import streamlit as st
import pandas as pd
import pydeck as pdk
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from geopy.geocoders import Nominatim


st.title("Crime By Location Map")
st.subheader("State : Australia")

year_options = ['2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022']
year = st.selectbox("Year", year_options)

region_options = ["1 North West Metro", "2 Eastern", "3 Southern Metro", "4 Western"]
region = st.multiselect("Police Region", region_options)

df = pd.read_csv("crime_data.csv")
government_options = df["Local Government Area"].unique()
government = st.multiselect("Local Government Area", government_options)

filtered_df = df[
    (df["Year"] == int(year)) &
    (df["Police Region"].isin(region) if region else True) &
    (df["Local Government Area"].isin(government) if government else True)
]

filtered_df = filtered_df[["Local Government Area", "Year", "Police Region", "Criminial Incident Rate", "Incidents Recorded", "Rate per 100,000 population"]]
filtered_df = filtered_df[~filtered_df["Police Region"].isin(["Justice Institutions and Immigration Facilities", "Unincorporated Vic"])]
st.dataframe(filtered_df, use_container_width=True)



filtered_df["Incidents Recorded"] = filtered_df["Incidents Recorded"].str.replace(",", "")

filtered_df["Criminial Incident Rate"] = filtered_df["Criminial Incident Rate"].str.replace(",", "")
filtered_df["Criminial Incident Rate"] = filtered_df["Criminial Incident Rate"].str.split(".").str[0]

filtered_df["Rate per 100,000 population"] = filtered_df["Rate per 100,000 population"].str.replace(",", "")
filtered_df["Rate per 100,000 population"] = filtered_df["Rate per 100,000 population"].str.split(".").str[0]

filtered_df["Criminial Incident Rate"] = pd.to_numeric(filtered_df["Criminial Incident Rate"], errors="coerce")
filtered_df["Incidents Recorded"] = pd.to_numeric(filtered_df["Incidents Recorded"], errors="coerce")
filtered_df["Rate per 100,000 population"] = pd.to_numeric(filtered_df["Rate per 100,000 population"], errors="coerce")
average_num = ["Criminial Incident Rate", "Incidents Recorded", "Rate per 100,000 population"]
average_df = filtered_df.groupby("Police Region")[average_num].mean().reset_index()

colors = sns.color_palette("Purples", len(average_df))

col1, col2, col3 = st.columns(3)
# st.bar_chart(average_df.set_index("Police Region")["Incidents Recorded"])
# st.line_chart(average_df.set_index("Police Region")['Criminial Incident Rate'])
with col1:
    fig = average_df.plot.pie(
        y="Rate per 100,000 population",
        labels=average_df['Police Region'],
        autopct="%1.1f%%",
        figsize=(6, 6),
        legend=False,
        title="Rate per 100,000 population",
        colors=colors,
        fontsize=12,
        wedgeprops={'edgecolor': 'white', 'linewidth': 1.5},
        ylabel=''

    ).get_figure()

    for label in fig.get_axes()[0].texts:
        label.set_fontsize(12)
        label.set_fontweight('bold')

    st.pyplot(fig)

with col2:
    fig2 = average_df.plot.pie(
        y="Incidents Recorded",
        labels=average_df['Police Region'],
        autopct="%1.1f%%",
        figsize=(6, 6),
        legend=False,
        title="Incidents Recorded",
        colors=colors,
        fontsize=12,
        wedgeprops={'edgecolor': 'white', 'linewidth': 1.5},
        ylabel=''
    ).get_figure()

    for label in fig2.get_axes()[0].texts:
        label.set_fontsize(12)
        label.set_fontweight('bold')

    st.pyplot(fig2)

with col3:
    fig3 = average_df.plot.pie(
        y="Criminial Incident Rate",
        labels=average_df['Police Region'],
        autopct="%1.1f%%",
        figsize=(6, 6),
        legend=False,
        title="Criminial Incident Rate",
        colors=colors,
        fontsize=12,
        wedgeprops={'edgecolor': 'white', 'linewidth': 1.5},
        ylabel=''
    ).get_figure()

    for label in fig3.get_axes()[0].texts:
        label.set_fontsize(12)
        label.set_fontweight('bold')

    st.pyplot(fig3)




chart_data = pd.read_csv("crime_geocode.csv")

st.pydeck_chart(
    pdk.Deck(
        map_style="mapbox://styles/mapbox/light-v9",
        initial_view_state=pdk.ViewState(
            latitude=chart_data['lat'].mean(),
            longitude=chart_data['lng'].mean(),
            zoom=6,
            pitch=50,
        ),
        layers=[
            pdk.Layer(
                "HexagonLayer",
                data=chart_data,
                get_position='[lng, lat]',
                radius=2000,  # 헥사곤 반지름 (미터 단위)
                elevation_scale=0.2,  # 높이 스케일
                elevation_range=[0, 4000],  # 높이 범위
                extruded=True,  # 3D 효과
                pickable=True,
                coverage=0.8,  # 헥사곤 내 데이터 커버리지
                get_elevation_value="Criminial Incident Rate",  # 높이 기준 컬럼
                get_fill_color="[Criminial Incident Rate * 255 / 17366.1, 50, 100]",
            ),
        ],
    )
)