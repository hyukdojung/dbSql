페이징 처리 
. ROWNUM
. INLINE-VIEW
. pagig 공식 
. 바인드 변수

함수 : 로직을 모듈화 한 코드
==> 실제 사용(호출)하는 곳과 함수가 구현되어있는 부분을 분리 ==> 유지보수의 편이성을 도모

함수를 사용하지 않을경우
 호출하는 부분에 함수 코드를 직접 기술해야 하므로, 코드가 길어진다. => 가독성이 나빠진다.
 
 오라클 함수를 구분
 입력 구분 : 
  . single row function
  . muti row function
  
제작자 구분:
  . 내장 함수: 오라클에서 제공해 주는 함수
  . 사용자 정의 함수: 개발자가 직접정의한 함수 (pl/sql배울 때)

Function  
프로그래밍언어, 식별이름 부여 ... 중요한 원칙

concat 문자열 결합
SUBSTR 문자열 분리 
length 문자열 길이

TRIM 앞뒤 공백제거

DUAL TABLE
SYS 계정에 속해 있는 테이블
오라클의 모든 사용자가 공통으로 사용할 수 있는 테이블

한개의 행, 하나의 컬럼 (dummy)- 값은 'x'

사용 용도 
1. 함수를 테스트할 목적
2. *merge 구문
3. *데이터 복제


오라클 내장 함수 테스트 (대소문자 관련
LOWER, UPPER, INITCAP : 인자로 문자열 하나를 받는다. 

SELECT LOWER('Hello, world'), UPPER('Hello, world'), INITCAP('hello, world')
FROM DUAL;

SELECT empno, 5, LOWER('Hello, world'), UPPER('Hello, world'), INITCAP('hello, world')
FROM emp;

함수는 WHERE 절에서도 사용이 가능하다
emp 테이블의 SMITH 사원의 이름은 대문자로 저장되어 있음

SELECT *
FROM emp 
WHERE LOWER(ename) = 'smith'; 이런식으로 작성하면 안된다. 함수가 행 개수만큼 실행
WHERE ename = UPPER('smith'); 두가지 방식중에는 위에보다 아래방식

WHERE ename = 'smith'; 테이블에는 데이터 값이 대문자로 저장되어 있으므로 조회건수 0
WHERE ename = 'SMITH'; 정상실행

문자열 연산
CONCAT : 두개의 문자열을 입력으로 받아, 결합한 문자열을 변환
SELECT CONCAT('test','end')
FROM dual;

SELECT table_name, tablespace_name, CONCAT('start','end')
        CONCAT(table_name, tablespace_name),
        'SELECT * FROM ' || table_name || ';'
            CONCAT 함수로 작성
FROM user_tables;

SELECT CONCAT(table_name, tablespace_name)
FROM user_tables;

SELECT  'SELECT * FROM ' || table_name || ';'
FROM user_tables;

SELECT CONCAT('SELECT * FROM ',CONCAT(table_name, ';')) CONCAT응용
FROM user_tables;

SUBSTR(문자열, 시작 인덱스, 종료 인덱스) : 문자열의 시작 인덱스 부터 .. 종료인덱스까지 부분문자열
시작인덱스는 1부터 (*자바의 경우 0부터)

SELECT SUBSTR('Hello, World',1,5)
FROM dual;

LENGTH(문자열): 문자열의 길이를 반환
SELECT LENGTH('Hello, World') len
FROM dual; 

INSTR(문자열 , 찾을 문자열, 검색 시작 인덱스[생략가능]) : 
                    문자열에서 찾을 문자열이 존재하는지, 존재할 경우 찾을 문자열의 인덱스(위치)반환

SELECT INSTR('Hello, World', 'o', 5) ins
FROM dual; 

SELECT INSTR('Hello, World', 'o', INSTR('Hello, World','o')+1) ins
FROM dual; 

LPAD, RPAD(문자열, 맞추고 싶은 전체 문자열 길이, [패딩 문자열-기본값은 공백])

SELECT LPAD('hello',15, '*') LP
FROM dual; 

SELECT RPAD('hello',15, '*') RP
FROM dual; 

SELECT LPAD('hello',15) LP
FROM dual;

REPLACE(문자열, 검색할 문자열, 변경할 문자열)  : 문자열에서 검색할 문자열 찾아 변경할 문자열 변경

SELECT REPLACE('Hello, world','ll', 'LL') REP
FROM dual; 

TRIM(문자열) : 문자열의 앞뒤의 존재하는 공백을 제거 , 문자열 중간에 있는 공백은 제거 대상이 아님

SELECT TRIM('      Hello      ') tr
FROM dual; 

SELECT TRIM('H'FROM'Hello') tr
FROM dual; 

number 관련 함수
ROUND(숫자, 반올림 위치-default 0): 반올림
ROUND(105.54, 1) 소수점 첫번째자리까지 결과를 생성 >> 두번째 자리에서 반올림
 : 105.5
TRUNC(숫자, 내림 위치-default 0): 내림
MOD(피제수, 제수) 나머지 연산

 SELECT ROUND(105.54, 1) round,
        ROUND(105.55, 1) round,
        ROUND(105.55, 0) round,
        ROUND(105.55, -1) round
 FROM dual;


 SELECT TRUNC(105.54, 1) trunc,
        TRUNC(105.55, 1) trunc,
        TRUNC(105.55, 0) trunc,
        TRUNC(105.55, -1) trunc
 FROM dual;

SELECT MOD (10, 3), sal, MOD(sal, 1000)
FROM emp;


날짜 관련 함수
SYSDATE : 사용중인 오라클 데이터베이스 서버의 현재 시간 , 날짜를 반환한다.
            함수이지만 인자가 없는 함수
            (인자가 없을때 java : 메소드()
                            SQL: 함수명);

date type -+ 정수 : 일자 더하기 빼기
정수 1 = 하루
1/24 = 한시간
1/24/60 = 일분
SELECT SYSDATE , SYSDATE + 5
FROM dual;

리터럴 
숫자 :
문자 : ''
날짜 : TO_DATE ('날짜문자열', '포맷')'2020,10,02'


SELECT TO_DATE ('2019/12/31', 'YYYY/MM/DD') LASTDAY, TO_DATE ('2019/12/31', 'YYYY/MM/DD') -5 LASTDAY_BEFORE5, SYSDATE NOW, SYSDATE -3 NOW_BEFORE3
FROM dual;


TO_DATE(문자열, 포맷) : 문자열을 포맷에 맞게 해석하여 날짜 타입으로 형변환
TO_CHAR(날짜, 포맷) : 날짜타입을 포맷에 맞게 문자열로 변환

YYYY : 연도
MM : 월
DD : 일자
D : 주간일자(1~7, 1-일요일, 2-월요일... 7-토요일)
IW : 주차(52~53) 해당일자가 몇주차에 속하는지
HH : 시간(12시간)
HH24 : 24시간 표기
MI : 분
SS : 초

현재시간 (SYSDATE) 시분초 단위까지 표현 >> TO_CHAR를 이용하여 형변환

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now
FROM dual;


SELECT TO_CHAR(SYSDATE-3, 'YYYY/MM/DD HH24:MI:SS') now_before3
FROM dual;

SELECT TO_CHAR(SYSDATE-1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_1hour
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH, 
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') DT_DASH_WITH_TIME,
        TO_CHAR(SYSDATE, 'DD-MM-YYYY')DT_DD_MM_YYYY
FROM dual;

MONTHS_BETWEEN(DATE1, DATE2) :DATE1과 DATE2사이의 개월수를 변환
4가지 날짜 관련함수중에 사용빈도가 낮음
SELECT MONTHS_BETWEEN( TO_DATE ('2020/04/21', 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD')),
    MONTHS_BETWEEN( TO_DATE ('2020/04/22', 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD'))
FROM dual;

ADD_MONTHS(DATE1, 가감할 개월수) : DATE1로부터 두번쨰 입력된 개월수 만큼 가감한 DATE
오늘 날짜로부터 5개월뒤 날짜 
SELECT ADD_MONTHS(SYSDATE, 5) dt1,
    ADD_MONTHS(SYSDATE, -5) dt2
FROM dual;

NEXT_DAY(DATE1, 주간일자) : date 이후 등장하는 첫번쨰 주간일자의 날짜를 반환 

SELECT NEXT_DAY(SYSDATE, 7)
FROM dual;

LAST_DAY(DATE1): DATE1이 속한 월의 마지막 날짜를 반환
SYSDATE: 2020/04/21 >> 2020/04/30

SELECT LAST_DAY(SYSDATE)
FROM dual;

SELECT ADD_MONTHS(LAST_DAY(SYSDATE)+1,-1),
    TO_DATE(TO_CHAR(SYSDATE, 'YYYY/MM') ||'01','YYYY/MM/DD')
FROM dual;


























