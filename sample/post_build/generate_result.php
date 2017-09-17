<?php  

$filename = 'result.xml';

if (! file_exists($filename)) {
    echo "$filename は存在していません." . "\n";
    exit(1);
}

$xsl = new DOMDocument();
$xsl->load("phpunit.xslt");
$xml = new DOMDocument();
$xml->load("result.xml");

$proc = new XsltProcessor();  
$proc->importStylesheet($xsl);  
$result_html = $proc->transformToXML($xml);  
file_put_contents("result.html", $result_html);
