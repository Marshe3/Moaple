package com.aischool.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	// Spring Security에게 상세설정을 할 수 있는 클래스
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// Security에게 요청하고 싶은 부분을 작성하는 메서
		// Security의 모든 보안 권한은 http 객체에게 있다
		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter("UTF-8",true);
		http.addFilterBefore(encodingFilter, CsrfFilter.class)
			.authorizeRequests()
				.antMatchers("/**").permitAll() // 모든 요청 허용
			.and()
			.csrf().disable(); // CSRF 비활성화
	}
	
	
	// 비밀번호 암호화 매서드 --> Bcrypt sha방식
	@Bean
	public PasswordEncoder passwordEncoder() {
		// 비밀번호 암호화 메소드
		return new BCryptPasswordEncoder();
	}

	
	
	
}
