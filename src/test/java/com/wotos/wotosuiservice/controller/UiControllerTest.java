package com.wotos.wotosuiservice.controller;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class UiControllerTest {

	@Test
	void rootResolvesToIndexView() {
		assertEquals("index", new UiController().index());
	}
}
