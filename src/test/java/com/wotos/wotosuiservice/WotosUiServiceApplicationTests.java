package com.wotos.wotosuiservice;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * Verifies the Spring application context boots on the upgraded stack
 * (Spring Boot 3.3 / Spring Cloud 2023.x, Java 17). Eureka registration is
 * disabled so the test does not depend on a running discovery server.
 */
@SpringBootTest(properties = "eureka.client.enabled=false")
class WotosUiServiceApplicationTests {

	@Test
	void contextLoads() {
	}

}
