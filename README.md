# Caddy cloudflare setup

This is a setup meant mostly for potainer. It's a setup I'm using personally that combines Caddy + Cloudflare DNS + Cloudflared tunnels for my websites.

The custom container is hosted as package on GitHub and it's supposed to build every 1st of a month, so you don't need to build caddy with xcaddy for this.

## How is it meant to work?

Essentially you add this as a git stack in portainer and set some environment variables and hopefully it should work with a wildcard domain. You will need to do some changes on your cloudflare dashboard though.

> [!IMPORTANT]
> If you're using a free Cloudflare account (as I am) you can only setup subdomain wildcards, not sub-subdomain wildcards.
> That means that `*.site.com` will work but `*.bar.site.com` won't. In case you really want something like sub-subdomains, you can use the `*.site.com` wildcard and then use the subdomain of `foo-bar.site.com`.

## Setting up cloudflare tunnels

On Cloudflare you can only setup remote-managed tunnels so you can't create a config file which sets everything up, meaning that you ***have*** to use the dashboard.

At the time of writing (<date>03/12/2025</date>) to access the remote tunnel page you have to go to `Zero Trust` > `Networks` > `Connectors`.

Let's start the tunnel creation process. Firstly, name your tunnel:

![tunnel-creation-start](./screenshots/tunnel-creation-start.png)

After that we need to get the tunnel token. Extract the token from the highlighted section:

![copy-token](screenshots/copy-segment.png)

Now set your `CLOUDFLARE_TUNNEL_TOKEN` env variable. I'm using portainer so I have a nice GUI for it:

![portainer-env-variables](screenshots/portainer-env.png)

Now we have to configure the Public Hostnames for our tunnel. Put in `*` for `Subdomains`, `Domain` should be your, well, domain. Don't worry about the warning, we'll take care of that later.

`Service.Type` should be `HTTPS` and `Service.URL` should be `caddy:443`. After that press `Additional application settings`:

![traffic-route-start](screenshots/traffic-route.png)

After opening the new menu, head into `Additional application settings` > `TLS` > `Origin Server Name` and set it to the combination of your subdomain and domain, in my case: `*.armor.quest`:

![tls-settings](screenshots/tls-settings.png)

Hit save and then you should see that your tunnel is active. If it's not, make sure it's started:

![healthy-tunnel](screenshots/show-healthy-tunnel.png)

Now copy the ID of the tunnel, in my case: `bfd810cf-b92e-45b7-a7c6-6c022956eea6` and let's go to the DNS settings page for the domain. You need to create a `CNAME` record for `<id>.cfargotunnel.com`:

![dns-rule](screenshots/dns-rule.png)

> [!IMPORTANT]
> Make sure proxy is enabled.

And with this Cloudflare should be communicating with the caddy server!

Now you should be able to access your websites without the ports actually being open.

![nextcloud and the router ports](sreenshots/../screenshots/nextcloud+router.png)
