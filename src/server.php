<?php

declare(strict_types=1);

use Swoole\Http\Request;
use Swoole\Http\Response;
use Swoole\Http\Server;

$server = new Server('0.0.0.0', 80);

$count = 0;

$server->on('request', function (Request $request, Response $response) use (&$count) {
    ($request); // to suppress linter about unused variable
    $response->header('Content-Type', 'text/plain');
    $response->end("Hello, World! Count: $count");
    $count = $count + 1;
});

$server->start();
