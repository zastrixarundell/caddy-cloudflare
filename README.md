# Caddy cloudflare setup

This is a setup meant mostly for potainer. It's an example (which I do use though) for using Caddy + Cloudflare DNS + Cloudflared tunnels for my local websites.

## How is it meant to work?

Essentially you add this as a git stack under portainer and set some environment variables and hopefully it should work, you will need to change your cloudflared config file though if you want to utilize tunnels.

## A little bit more details?!

Sure, this image file for Caddy uses caddy-builder to create a new, fresh, image of a caddy container with the cloudflare functionality, allowing you to use cloudflare-specific DNS stuff.

After that the cloudflared tunnel, if you wish so, can take of everything else if you don't plan to expose your port on the internet. 

My router isn't smart for IPs from cloudflare so I've opted out to use cloudflare tunnels for this. I don't really need to expose the 443 and 80 port then~.