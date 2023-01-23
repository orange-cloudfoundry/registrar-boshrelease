# Registrar BOSH release

This is a [BOSH](http://bosh.io/) release for deploying registration tasks.

It (basically, executes stuff during the `pre-start` phase of the virtual machine) communicate to:
* the Cloud Foundry API to register or update a service broker
* UAA to create or update [users and clients](https://docs.cloudfoundry.org/uaa/uaa-concepts.html)
* the Cloud Foundry MySQL server (add databases, update data, …)

The goal is to be able to deploy specifics components on some virtual machines without impacting
all the deployments; by example:
* working with the [Prometheus](https://github.com/bosh-prometheus/prometheus-boshrelease),
  or the [log-service](https://github.com/orange-cloudfoundry/logservice-boshrelease) BOSH release,
  living in their own (BOSH) deployment,
* which is registering data in the Cloud Foundry database, present in the `cf` BOSH deployment,
* without affecting the others Cloud Foundry virtual machines (presents in the `cf` deployment)

## Dependencies

It uses [BOSH package vendoring](https://bosh.io/docs/package-vendoring/) for:
- [Cloud Foundry CLI](https://github.com/bosh-packages/cf-cli-release)
- [PXC](https://github.com/cloudfoundry/pxc-release)
- [Ruby](https://github.com/bosh-packages/ruby-release)

And git submodule for:
- [UAAC](https://github.com/cloudfoundry/cf-uaac)
- [Ruby](https://github.com/bosh-packages/ruby-release)
