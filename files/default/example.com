server {
       listen   80; ## listen for ipv4; this line is default and implied
       #listen   [::]:80 default ipv6only=on; ## listen for ipv6

       root /var/www/example.com/public_html;
       index index.html index.htm;

       # Make site accessible from http://localhost/
       server_name example.com;
}
