# Senzing file layout

## Types of Senzing files

Senzing has directories of files that fit into the following categories:

1. Immutable files:
    1. `g2` directory. Frequent releases.
    1. `data` directory. Infrequent releases.
1. Configuration files:
    1. `etc` directory.
1. Mutable files:
    1. `var`directory.

The expectation is that `g2` and `data` directory contents are not modified by the user nor by processes.
If there are files that need to be customized or modified,
they are copied into either the `etc` directory or `var` directory and then modified.

## Configuration precedence

Processes look for configuration in the following priority order:

1. Command-line options
1. Environment variables
1. Configuration file
1. Defaults

With exception of "Defaults", all are optional.
Any combination can be used.
For instance, `FOO` can be specified as a command-line option and an environment variable.
In this case the value of `FOO` in the command-line option takes precedence over the value in the environment variable.

### Command-line options

The highest configuration priority is given to a command-line option.
The command-line option over-rides an Environment variable, configuration-file value, and default value.
If a value is not specified on the command-line, then the pecking order is:
Environment variable; Configuration file; and finally default value.

1. Example:

    ```console
    senzing-program \
      --data-dir /path/to/data \
      --g2-dir /path/to/g2 \
      --etc-dir /path/to/etc \
      --var-dir /path/to/var
    ```

### Environment variables

Optional environment values.

1. Example:

    ```console
    export SENZING_DATA_DIR=/path/to/data
    export SENZING_ETC_DIR=/path/to/etc
    export SENZING_G2_DIR=/path/to/g2
    export SENZING_VAR_DIR=/path/to/var
    ```

### Configuration file

An optional configuration file can specify one or more configurations.

1. Examples:

    ```console
    senzing-program \
      --config-file /path/to/config-file.toml
    ```

    ```console
    senzing-program \
      --config-file /path/to/config-file.json
    ```

1. `/path/to/config-file.toml` contents.
    Example:

    ```console
    [senzing]
    dataDir = /path/to/data
    etcDir  = /path/to/etc
    g2Dir   = /path/to/g2
    varDir  = /path/to/var
    ```

1. `/path/to/config-file.json` contents.
    Example:

    ```json
    {
      "senzing": {
        "dataDir": "/path/to/data",
        "etcDir": "/path/to/etc",
        "g2Dir": "/path/to/g2",
        "varDir": "/path/to/var"
      }
    }
    ```

### Default locations

1. Example:

    1. `data` directory
        1. `${CURRENT_WORKING_DIRECTORY}/data`
        1. `/opt/senzing/data`
    1. `etc` directory
        1. `${CURRENT_WORKING_DIRECTORY}/etc`
        1. `/etc/opt/senzing`
    1. `g2` directory
        1. `${CURRENT_WORKING_DIRECTORY}/g2`
        1. `/opt/senzing/g2`
    1. `var` directory
        1. `${CURRENT_WORKING_DIRECTORY}/var`
        1. `/var/opt/senzing`

1. **Notes**
    1. The "data" directory refers to the directory containing actual data (e.g. `cnv.ibm`, `gnv.ibm`).
       It does not refer to the the directory that holds version subdirectories.
    1. To disambiguate "floating" paths from versioned paths, the use of the `/latest` directory as a soft link to the version of Senzing software might be used as the system default.

## Projects

Given that a Project is a specific set of (data, etc, g2, var),
the "Default locations" could be augmented to:

1. `data` directory
    1. `${SENZING_PROJECT_DIR}/data`
    1. `${CURRENT_WORKING_DIRECTORY}/data`
    1. `/opt/senzing/data`
1. `etc` directory
    1. `${SENZING_PROJECT_DIR}/etc`
    1. `${CURRENT_WORKING_DIRECTORY}/etc`
    1. `/etc/opt/senzing`
1. `g2` directory
    1. `${SENZING_PROJECT_DIR}/g2`
    1. `${CURRENT_WORKING_DIRECTORY}/g2`
    1. `/opt/senzing/g2`
1. `var` directory
    1. `${SENZING_PROJECT_DIR}/var`
    1. `${CURRENT_WORKING_DIRECTORY}/var`
    1. `/var/opt/senzing`

Then, a Senzing project directory could be specified as a configuration option.

1. Command-line options.
   Example:

    ```console
    senzing-program \
      --project-dir /path/to/project
    ```

1. Environment variables.
   Example:

    ```console
    export SENZING_PROJECT_DIR=/path/to/project
    ```

1. Configuration file.
   Example:

    ```console
    senzing-program \
      --config-file /path/to/config-file.toml
    ```

   `/path/to/config-file.toml` contents.
   Example:

    ```console
    [senzing]
    projectDir = /path/to/project
    ```

1. Default.
   There is no default.
   Just like command-line options, environment variables and configuration files,
   if there is no `SENZING_PROJECT_DIR` specified, it is not factored into the configuration.

The configuration precedence now looks like this:

1. Command-line options
1. Environment variables
1. Configuration file
1. Project directory
1. Defaults

### Special cases

1. A command like:

    ```console
    senzing-program \
      --project-dir /path/to/project \
      --etc-dir /path/to/etc
    ```

   Means use the project directory for (data, g2, var) directories and `/path/to/etc` for the "etc" directory.
   This allows for flexible testing against multiple configurations.

1. Immutable files from `g2` or `data`.

   If there are files that may be modified by a user and place in either the  `etc` or `var` directores,
   the `senzing-program` needs to know to look in the `/etc` or `var` directory
   before looking in the `g2` or `data` directory.

   **Note** A "cascading" or merging of base files in `g2` and `etc` may be considered to keep only the
   specific customizations in the `etc` directory.  Loosely known as "Cascading Configuration Pattern".

## Tool chain considerations

### Git

1. If a customer creates a git repository for their code,
   they should not have to include Senzing code in their repository.
1. By separating the specification of Senzing files from their actual locations,
   Git repositories do not need to imbed Senzing code.
1. Git does not support "soft linking".  No soft-linking needed in this proposal for git repositories.
1. An "etc" directory can be separately versioned by a customer.
   A "var" directory can be snap-shotted, if needed.
   The "data" and "g2" directories can always be reinstalled.

### Docker

1. The proposal allows immutable volumes to be mounted Read Only for security and performance.
1. Mounting volumes at `docker run` time allow for incremental development by allowing a developer
   to copy and modify one of the (data, etc, g2, var) directories, then test.
1. Allows the same docker image to be run at different versions of Senzing.

1. Using docker with system install.
   Example:

    ```console
    sudo docker run \
      --interactive \
      --rm \
      --volume ${SENZING_DATA_VERSION_DIR}:/opt/senzing/data \
      --volume ${SENZING_ETC_DIR}:/etc/opt/senzing \
      --volume ${SENZING_G2_DIR}:/opt/senzing/g2 \
      --volume ${SENZING_VAR_DIR}:/var/opt/senzing \
      senzing/init-container
    ```

1. Using docker with projects.
   Example:

    ```console
    sudo docker run \
      --env SENZING_PROJECT_DIR=/project \
      --interactive \
      --rm \
      --volume ${SENZING_PROJECT_DIR}:/project \
      senzing/init-container
    ```

1. Using docker with ad-hoc mounting.
   Example:

    ```console
    sudo docker run \
      --env SENZING_DATA_VERSION_DIR=/my/tom/data \
      --env SENZING_ETC_DIR=/my/betty/etc \
      --env SENZING_G2_DIR}:/my/oscar/g2 \
      --env SENZING_VAR_DIR}:/my/susan/var \
      --interactive \
      --rm \
      --volume /tmp/bob/senzing/data:/my/tom/data \
      --volume /tmp/mary/senzing/etc:/my/betty/etc \
      --volume /tmp/john/senzing/g2:/my/oscar/g2 \
      --volume /tmp/jane/senzing/var:/my/susan/var \
      senzing/init-container
    ```

### Kubernetes / OpenShift

1. Separate Persistent Volumes can be kept for different version of Senzing.
1. Separate Persistent Volumes for development, verification, and production.
1. Supports "rolling updates" and roll-backs.
1. If desired, the same docker images can be run with different Persistent Volumes to
   spread the load across different file systems.

### Jenkins

1. Jenkins jobs can reuse Senzing installations whether they be system, project, or ad-hoc installs.
1. Variation can be made in Jenkins runs by changing the "etc" directory, but keeping (data, g2, var) directories.
1. Only single versions of immutable files need to be kept on Jenkins server.
1. For regression testing we have a battery of docker images with different version of our "apps" baked in.
   We run them against different versions of senzing by adjusting the specification of the (data, etc, g2, var) directories.

## Questions

1. Is `PIPELINE.CONFIGPATH` always `${SENZING_ETC_DIR}`?
1. Is `PIPELINE.SUPPORTPATH` always `${SENZING_DATA_DIR}`?
1. Is `PIPELINE.RESOURCEPATH` always `${SENZING_G2_DIR}/resources`?

## Issues

1. The structure of `/opt/senzing/data`
   doesn't allow a symbolic link to `/opt/senzing/data` for "latest" version.
   May have to introduce `/opt/senzing/data/latest` to identify current version.
1. A G2Project would need to separate (data, etc, g2, var) directories.
   Currently, it has (data, etc, var) directories, but obfuscates the "g2" directory.

## References

1. Linux Filesystem Hierarchy Standard
    1. [tldp.org](http://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/)
    1. [Wikipedia](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)
1. Layered configuration
    1. [Python LayeredConfig](https://layeredconfig.readthedocs.io/en/latest/usage.html#precedence)
1. TOML
    1. [Wikipedia](https://en.wikipedia.org/wiki/TOML)
1. Configuration packages
    1. [Viper](https://github.com/spf13/viper)
1. Cascading Configuration pattern
    1. [Cascading Configuration Design Pattern](https://fredtrotter.com/2017/12/05/cascading-configuration-design-pattern/)
    1. [Cascading Configuration Pattern](http://www.octodecillion.com/cascadeconfigpattern/)
1. Configuration precedence
    1. [StackOverflow: ...in what order](https://stackoverflow.com/questions/32272911/precedence-of-configuration-options-environment-registry-configuration-file-a)
    1. [AWS Elastic Beanstalk precedence](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options.html#configuration-options-precedence)
    1. [Order of Precedence when Configuring ASP.NET Core](https://devblogs.microsoft.com/premier-developer/order-of-precedence-when-configuring-asp-net-core/) - see "Order of Precedence"
    1. [Hashicorp Consul Configuration](https://www.consul.io/docs/agent/options.html)