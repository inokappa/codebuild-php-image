<?php

$filename = 'result.html';

if (! file_exists($filename)) {
    echo "$filename は存在していません." . "\n";
    exit(1);
}

require __DIR__ . '/aws.phar';

$s3 = new Aws\S3\S3Client([
    'version' => 'latest',
    'region'  => 'ap-northeast-1'
]);

$build_id = explode(":", getenv('CODEBUILD_BUILD_ID'));
$result = $s3->putObject(array(
    'Bucket' => getenv('ARTIFACTS_BUCKET'),
    'Key'    => 'html' . '/' . $build_id[0] . '/' . $build_id[1] .'/result.html',
    'Body'   => fopen('result.html', 'r')
));

echo $result['ObjectURL'] . "\n";
