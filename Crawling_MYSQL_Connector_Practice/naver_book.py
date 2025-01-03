import urllib.request
import urllib.parse
import json

# API 호출을 위한 client_id, client_secret 변수 설정
client_id = '9xxjvLHB8bwLjF9c8yto'
client_secret = 'LOF2fVfNrF'


# 인코딩 된 문자가 encText에 담긴다.
encText = urllib.parse.quote("투자")

url = 'https://openapi.naver.com/v1/search/book.json?query=' + encText

request = urllib.request.Request(url)
request.add_header("X-Naver-Client-Id", client_id)
request.add_header("X-Naver-Client-Secret", client_secret)

# 요청 후 읍답객체 생성
response = urllib.request.urlopen(request)

print(response.getcode()) #getcode() : 응답 코드 반환

response_body = response.read() # read: 응답 내용 반환
response_body = json.loads(response_body)
book_list = response_body['items']


