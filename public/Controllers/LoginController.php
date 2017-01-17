<?php
 
use Silex\Application;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;


$login = $app['controllers_factory'];

$login->get('/', function (Application $app){
		return 'oi';
});

$login->get('/novo', function (Application $app){
	return 'jose';
});


return $login;

