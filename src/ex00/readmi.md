#запуск в беш команды
#  macOS Chrome
USER_AGENT="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

ответ

HTTP/2 403 
server: ddos-guard
set-cookie: __ddg8_=gI9aJUJoxQqIXX2d; Domain=.hh.ru; Path=/; Expires=Fri, 17-Apr-2026 16:36:39 GMT
set-cookie: __ddg10_=1776442599; Domain=.hh.ru; Path=/; Expires=Fri, 17-Apr-2026 16:36:39 GMT
set-cookie: __ddg9_=178.207.154.251; Domain=.hh.ru; Path=/; Expires=Fri, 17-Apr-2026 16:36:39 GMT
set-cookie: __ddg1_=1Q1ft2Js3WHT1qmNx99U; Domain=.hh.ru; HttpOnly; Path=/; Expires=Sat, 17-Apr-2027 16:16:39 GMT
date: Fri, 17 Apr 2026 16:16:39 GMT
content-type: application/json; charset=UTF-8
content-length: 0
x-request-id: 1776442599933c921808b7dee3285021
access-control-allow-origin: *
access-control-expose-headers: Location, ETag, Date, Expires, Cache-Control, Content-Type, X-Request-ID
server-timing: frontik;desc="frontik execution time";dur=0.009113073348999023
x-request-id: 1776442599933c921808b7dee3285021
report-to: {"group":"nel","endpoints":[{"url":"https:\/\/nel.hhdev.ru\/report\/api"}],"max_age":3600}
report-to: {"group":"csp-endpoint","max_age":3600,"endpoints":[{"url":"https:\/\/nel.hhdev.ru\/report\/api"}]}
nel: {"success_fraction":0,"report_to":"nel","max_age":3600}
strict-transport-security: max-age=31536000; includeSubDomains
x-frame-options: SAMEORIGIN
x-content-type-options: nosniff


Проблема ясна: hh.ru использует защиту DDoS-Guard, которая блокирует ваш запрос. Видно по заголовкам:
server: ddos-guard
set-cookie: __ddg8_=... (это куки защиты от DDoS-Guard)
Ваш IP (178.207.154.251) или сеть заблокированы на уровне DDoS-Guard. Обычный curl не может пройти эту защиту, так как требуется выполнение JavaScript.