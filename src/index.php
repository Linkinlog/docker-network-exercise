<?php
declare(strict_types=1);

$tempDir = sys_get_temp_dir();
$filename = $tempDir.DIRECTORY_SEPARATOR.'counter';
$file = fopen($filename, 'c+');

if ($file) {
    if (flock($file, LOCK_EX)) {
        $counter = 0;
        if (filesize($filename) > 0) {
            rewind($file);
            $counter = (int) fread($file, filesize($filename));
        }

        $counter++;
        rewind($file);
        ftruncate($file, 0);
        fwrite($file, (string) $counter);
        fflush($file);

        echo "Hello, World! Counter: $counter";

        flock($file, LOCK_UN);
    } else {
        echo 'Failed to lock the file.';
    }

    fclose($file);
} else {
    echo 'Failed to create file.';
}
