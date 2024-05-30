# Spring Vault Workshop
Example workshop showing how to use HashiCorp Vault with Spring Vault https://spring.io/projects/spring-vault

## Requirements

To run this workshop you need to have Jumppad installed, you can get Jummpad from the
following location:

[https://jumppad.dev/docs/introduction/installation](https://jumppad.dev/docs/introduction/installation)

You also need Docker or Podman, both Desktop and Server versions are supported.

[https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)

## Running the workshop

First clone this repository, then from the source code location run the following command.

```shell
jumppad up ./jumppad
```

Jumppad will create the workshop in Docker, it should take a few minutes for things
to start first time as several containers need to be downloaded.

```shell
Running configuration from  ./jumppad  -- press ctrl c to cancel

INFO Creating resources from configuration path=/Users/nic/code/github.com/nicholasjackson/workshop-spring-vault/jumppad
INFO Creating ImageCache ref=resource.image_cache.default
...
INFO Please wait, still creating resources [Elapsed Time: 75.000322]
INFO Please wait, still creating resources [Elapsed Time: 90.001084]
INFO Creating output ref=output.VAULT_TOKEN
INFO Creating Container ref=resource.container.vscode
INFO Creating module ref=module.docs
INFO Creating task ref=module.docs.resource.task.enable_database
INFO Creating Documentation ref=module.docs.resource.docs.docs
INFO Refresh Docs ref=module.docs.resource.docs.docs
```

Once everything is up and running you can access the workshop in your browser at the
following location:

[http://localhost:8000](http://locahost:8000)


## Stopping the workshop

To stop the workshop and to clean up the environment, run the following command 
in your terminal.

```shell
jummppad down --force
```