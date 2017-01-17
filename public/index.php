<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Pimple\Container;
 




require_once __DIR__.'/../vendor/autoload.php';


$dbConfig = parse_ini_file(__DIR__.'/../banco/config.ini', false);
 

Request::enableHttpMethodParameterOverride(); # enable this method override



#$container = new Container(); // instalado pimple. ver usabilidade
$app = new Silex\Application();
$app['debug'] = true;

//Primeira conexão  configurada é a default
$app->register(new Silex\Provider\DoctrineServiceProvider(), array(
    'dbs.options' => array (
        'mysql_write' => array(
            'driver'    => 'pdo_mysql',
            'host'      => $dbConfig['hostname'],
            'dbname'    => $dbConfig['database'],
            'user'      => $dbConfig['username'],
            'password'  => $dbConfig['password'],
            'charset'   => 'utf8',
        )/*,
        'mysql_read' => array(
            'driver'    => 'pdo_mysql',
            'host'      => '127.0.0.1',
            'dbname'    => 'clyck',
            'user'      => 'root',
            'password'  => '',
            'charset'   => 'utf8',
        )*/,
    ),
));


$app->register(new Silex\Provider\HttpCacheServiceProvider(), array(
    'http_cache.cache_dir' => __DIR__.'/cache/',
));

$app->mount('/login', require __DIR__. '/Controllers/LoginController.php');
$app->mount('/blog', new Controllers\LoginControllerProvider());

$app->get('/teste/{id}', function ($id) use ($app) {
    $sql = "SELECT * FROM user";
    $post = $app['dbs']['mysql_write']->fetchAssoc($sql, array());

    return $app->json($post);

      #ou
    #$retorno = new Response(json_encode($post));
	#$retorno->headers->set('Content-Type','application/json; charset=utf-8');
	#return $retorno;
});

$app->run();