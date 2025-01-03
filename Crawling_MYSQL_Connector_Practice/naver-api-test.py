import urllib.request

client_id = '9xxjvLHB8bwLjF9c8yto'
client_secret = 'LOF2fVfNrF'

# 인코딩 된 문자가 encText에 담긴다.
encText = urllib.parse.quote("오늘 점심")



url = 'https://openapi.naver.com/v1/search/news.json?query=' + encText

# 요청객체를 만들어준다.
request = urllib.request.Request(url)
request.add_header("X-Naver-Client-Id", client_id)
request.add_header("X-Naver-Client-Secret", client_secret)

response = urllib.request.urlopen(request)

print(response.getcode())

response_body = response.read()
print(response_body.decode('utf-8'))