<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Pimple\Container;

require_once __DIR__.'/../vendor/autoload.php';



#$container = new Container(); // instalado pimple. ver usabilidade
$app = new Silex\Application();
$app['debug'] = true;


//Primeira conexão  configurada é a default
$app->register(new Silex\Provider\DoctrineServiceProvider(), array(
    'dbs.options' => array (
        'mysql_read' => array(
            'driver'    => 'pdo_mysql',
            'host'      => '127.0.0.1',
            'dbname'    => 'clyck',
            'user'      => 'root',
            'password'  => '',
            'charset'   => 'utf8',
        ),
        'mysql_write' => array(
            'driver'    => 'pdo_mysql',
            'host'      => '127.0.0.1',
            'dbname'    => 'clyck',
            'user'      => 'root',
            'password'  => '',
            'charset'   => 'utf8',
        ),
    ),
));


$app->register(new Silex\Provider\HttpCacheServiceProvider(), array(
    'http_cache.cache_dir' => __DIR__.'/cache/',
));




$app->get('/hello/{name}', function ($name) use ($app) {
    return 'Hello '.$app->escape($name);
});


$app->get('/teste/{id}', function ($id) use ($app) {
    $sql = "SELECT * FROM teste WHERE id = ?";
    $post = $app['dbs']['mysql_read']->fetchAssoc($sql, array((int) $id));

    $retorno = new Response(json_encode($post));
	$retorno->headers->set('Content-Type','application/json; charset=utf-8');
	return $retorno;
});

$app->run();