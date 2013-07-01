# Dateikit

Dateikit makes file sharing in teams awesome. scp your files to the server and
automatically have the files delete once they were downloaded. Can be changed
on a per file basis. Pure awesomesauce.

## Use case
* We usually have private files we don't others except in our team to
  download.
* We send them a link in IRC instead of writing an email.
* The upload should be painless, i.e. via SCP to our server.
* The file should self destruct once downloaded by the other party.

## Getting started
* Upload all the files you want to be served into public/files
* Downloading a file will create a new database record for that file.

## TODO
* Make it work with S3 or other storage service.
