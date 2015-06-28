# Confluence Vagrant Build
This vagrant config will build a local Confluence VM on your workstation. You can use this to mirror a Confluence site and take it on the go (see the [RoadRunner](https://marketplace.atlassian.com/plugins/rr) plugin).

## Requirements

- You will need a YUM based distro (RHEL, CentOS, Fedora, etc). This has only been tested on CentOS and RHEL 7.X.
- Copy your Linux based Confluence installer into the root directory of the project. This file will be ignored by git if you keep the original naming format.
- A license for Confluence. You can demo it with a trial license or pick up a 10 person license for only $10 (what I use).

## Build
**NOTE**: When you run this for the first time, you will be required to go through the setup wizard for Confluence.

After `vagrant up` completes, open your browser and go to `http://localhost:8090/`. You should be greated by a screen asking if you want to setup a trial configuration or a production configuration. If you choose the trial configuration it will configure an internal database. If you choose the production configuration, you will need to specify some MySQL information in the next step.

### MySQL DB
If you chose the trial configuration, you can skip this section. Also since I have not completed this portion yet, you should skip this section. MariaDB is not installed nor is the basic DB built in this vagrant config.

### Licensing
Follow the prompts here to sign up for a trial license or install an existing license that you have.

### Users
Since this is just a small portable Confluence install, I recommend choosing `Manage Users and Groups within Confluence` for the user management option. If you're also building a Jira install for on the go usage, you could link it to that but that is beyond the scope of this project.

On the next screen, configure your admin account. Then follow the tutorial screens to finish the build.

## Notes
Once this is completed, you can run `vagrant destroy` and then `vagrant up` and all of your data will still be there. You will no longer have to complete the wizard after building the vagrant box. The data for this install is kept in either `confluence-localdb` or `confluence-mysqldb` depending on which option you chose. (Right now there is only the localdb option, I have not added in the mysql pieces yet).
