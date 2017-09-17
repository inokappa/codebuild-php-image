#!/usr/bin/env bash

php phpunit.phar --bootstrap src/Email.php tests/EmailTest --log-junit post_build/result.xml
