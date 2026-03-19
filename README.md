# 프로젝트 개요
이 프로젝트는 SpringMVC를 사용한 회의실 예약 웹 애플리케이션입니다. 

# 기술 스택
- Java 11
- Spring Boot
- Spring MVC
- Thymeleaf
- JPA
- Hibernate
- MySQL

# 의존성 정보
- Spring Web
- Spring Data JPA
- MySQL Connector/J
- Lombok

# 설치 및 빌드 방법
1. 레포지토리를 클론합니다.
   ```bash
   git clone https://github.com/Marshe3/Moaple.git
   ```
2. Maven을 사용하여 의존성을 설치합니다.
   ```bash
   mvn install
   ```
3. 애플리케이션을 실행합니다.
   ```bash
   mvn spring-boot:run
   ```

# 프로젝트 구조
```
Moaple/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/moaple/
│   │   │       ├── controller/
│   │   │       ├── model/
│   │   │       ├── repository/
│   │   │       └── service/
│   │   └── resources/
│   │       ├── application.properties
│   │       └── templates/
│   └── test/
└── pom.xml
```

# 주요 기능
- 사용자 인증 및 인가
- CRUD 작업
- 데이터베이스 관리

# 보안
- Spring Security를 사용하여 JWT 기반 인증 구현

# 데이터베이스 설정
- application.properties 파일에서 데이터베이스 접속 정보 설정

# 테스트
- JUnit 5를 사용하여 단위 테스트 실시

# 로깅
- SLF4J와 Logback을 사용한 로깅 설정
