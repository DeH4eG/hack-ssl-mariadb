<<__EntryPoint>>
async function main(): Awaitable<void>{
    $a = new PDO('mysql:host=db;dbname=app', 'root','', 
    [
        PDO::MYSQL_ATTR_SSL_CA => '/app/ssl/ca-cert.pem',
        PDO::MYSQL_ATTR_SSL_CERT => '/app/ssl/client/client-cert.pem',
        PDO::MYSQL_ATTR_SSL_KEY => '/app/ssl/client/client-key.pem'
        ]
        );

    var_dump($a->query('select 1;'));
}