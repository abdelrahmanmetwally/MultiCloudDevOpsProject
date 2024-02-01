package com.example.demo.controller;

import org.junit.jupiter.api.Test;
import org.springframework.ui.Model;
import java.net.UnknownHostException;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class HomeControllerTest {

    @Test
    void testHome() throws UnknownHostException {
        HomeController homeController = new HomeController();

        // Mock Model
        Model model = mock(Model.class);

        // Mock InetAddress
        java.net.InetAddress mockInetAddress = mock(java.net.InetAddress.class);
        when(mockInetAddress.getHostAddress()).thenReturn("127.0.0.1");

        // Mock InetAddress.getLocalHost()
        when(java.net.InetAddress.getLocalHost()).thenReturn(mockInetAddress);

        // Execute the method under test
        String result = homeController.home(model);

        // Verify the result and model attributes
        assertEquals("index", result);
        assertEquals("127.0.0.1", model.getAttribute("ipAddress"));
    }
}

