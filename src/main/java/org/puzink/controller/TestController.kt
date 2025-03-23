package org.puzink.controller

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController("/test")
class TestController {

    @GetMapping("/ping")
    fun ping() = "pong"
}