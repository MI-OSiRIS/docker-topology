# Periscope Topology Discovery Application

This container runs the Ryu-based topology discovery service.

OpenFlow connections are accepted on port 6633.

The configuration of the service is controlled by a configuration file
that should be exposed as a Docker volume.  The service looks for
configuration in the `/etc/ryu` directory.

> docker run -ti -v <src dir>:/etc/ryu <name>

On the host, maintain the following configuration file in `src dir`:

osiris-sdn-app.conf
```
[osiris]
unis_domain="My Domain"
unis_server="http://UNIS_HOST:UNIS_PORT"
unis_host="http://UNIS_HOST:UNIS_PORT"

unis_update_interval=5
```
