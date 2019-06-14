## Getting started

It is quite easy to install and run WxMonitoring. Following steps guide you through installation.

### Install Monitoring Environment

First, you need to install (at least) an instance of 
 **Integration Server / Microservices Runtime**
 * Version: 9.10 (or later)
 * Packages required: 
   * _only_ Default, WmRoot, WmPublic
 * no messaging
 * no local database (use embedded database pool)
 Download Trial Version IS MSR incl. Designer under http://techcommunity.softwareag.com/ecosystem/communities/public/webmethods/contents/downloads/webmethods-service-designer/index.html

You can also (re)use your current local webMethods environment.

#### Install Elastic Stack

Install the Elastic Stack products on your local machine. (Skip this if already installed.)

**Elasticsearch** (current version: 7.1.x)

* download from https://www.elastic.co/de/downloads/elasticsearch
* unzip to `%ES_HOME%`
* run `%ES_HOME%/bin/elasticsearch.bat`
* check access to http://localhost:9200/
    * open url in browser
    * run `Invoke-RestMethod http://localhost:9200/` in powershell

**Kibana** (current version: 7.1.x)

* download under https://www.elastic.co/de/downloads/kibana
* unzip to `%KIBANA_HOME%`
* run `%KIBANA_HOME%/bin/kibana.bat`
* check access to http://localhost:5601/

**Logstash** (version: 7.1.x)

* download from https://www.elastic.co/de/downloads/logstash
* unzip to `%LOGSTASH_HOME%`

**Integration Server**

* start Integration Server
    * MSR: `%SAG_HOME%/IntegrationServer/bin/startup.bat`
    * or ESB: `%SAG_HOME%/profiles/IS_default/bin/startup.bat`
* check access to http://localhost:5555/

### Install WxMonitoring

1. Download the latest release of WxMonitoring from https://github.com/SoftwareAG/WxMonitoring/tree/master/dist.
1. Configuration of package WxMonitoring is based on IS _Global Variables_. On package load all global varibales will be created if unset. Changes will     immediatly take place, so you don't need to reload the package.

    | Key | Value (default) | Description |
    | --- | --------------- | ----------- |
    | ES_BASE_URL | http://localhost:9200 | connection / URL to elastic search server |
    | LOGSTASH_BASE_URL | http://localhost:5045 | connnection /URL to logstash http port. Only needed to import data from monitoring UI |
    | ES_AUTH_USERNAME  | elastic | (optional: if ES authentication enabled) username to access elasticsearch |
    | ES_AUTH_PASSWORD  | elastic | (optional: if ES authentication enabled) password for elasticsearch username |
1. Install IS package WxMonitoring
    * copy WxMonitoring.zip to `%SAG_HOME%/IntegrationServer/instances/default/replicate/inbound`
    * open IS Administration http://localhost:5555/
    * start Packages  Management  Install Inbound Releases, choose WxMonitoring, install
1. (optional: for development only) link package for development
    * edit `.\bin\setEnv.bat`
    * run `.\bin\linkPackages.bat`
    * packages are now linked to ESB packages folder
    * restart ESB
1. Open http://localhost:5555/WxMonitoring/
    * You should see an empty search result page
1. Open http://localhost:9200/_cat/indices?v
    * You should see indexes - `wxmonitoring-processes`, `wxmonitoring-events-original`, `wxmonitoring-events-xxxx.xx.xx`, `wxmonitoring-event-rules` - have been created
1. Start Logstash
    * edit `.\bin\logstash\startLogstash.cmd` and update correct paths for following variables
          `SAG_HOME`: path for software ag home folder (e.g. `c:\SoftwareAG`)
          `LOGSTASH_HOME`: path to logstash home folder (for e.g. `C:\local\logstash-7.1.1`)
          `ELASTIC_SEARCH_ADDRESS`: base url for elastic search (for e.g. `localhost:9200`)
          (optional: if ES authentication enabled) `ELASTIC_SEARCH_LOGSTASH_USER`: logstash will access elastic search as this user (for e.g. `WxMonitoring_logstash_user`)
          (optional: if ES authentication enabled) `ELASTIC_SEARCH_LOGSTASH_PASSWORD`: password for logstash user (for e.g. `C:\local\logstash-7.1.1`)
    * Run `.\bin\logstash\startLogstash.cmd` or Install logstash as a service
    * View Logstash logs
        * open file `%LOGSTASH_HOME%/logs/logstash-plain`
        * verify following log has been recorded: 
            `[INFO ][org.logstash.beats.Server] Starting server on port: 5044`

Now all components on monitoring enviroment are up and running. You can now

1. start importing log files (see Users Guide), or
1. install filebeat on target environment

### Install Log Environment

You need to install filebeat on each environment you want to listen to. Please repeat the following steps for ech environment.

**Hint**:
Monitoring environment _should not_ be a log environment. You won't need to run WxMonitoring to receive log events anyway.

Install the following 3rd party products on your local machine. (Skip this if already installed.)

**Filebeat** (version: 7.1.x)

* download under https://www.elastic.co/de/downloads/beats/filebeat
* unzip to `%FILEBEAT_HOME%`
* copy files from `...\packages\WxMonitoring\pub\elk\filebeat` to anywhere in log environment server.
    * `startFilebeat.cmd`
    * `WxMonitoring.yml`
* Start Filebeat
    * Edit file `startFilebeat.cmd` and update correct paths for following variables
          `SAG_HOME`: path for software ag home folder (e.g. `c:\SoftwareAG`)
          `FILEBEAT_HOME`: path to filebeat home folder (for e.g. `C:\SoftwareAG\filebeat-7.1.1`)
          `SERVER_ID`: name of this log environment (e.g. prod1)
          `LOGSTASH_HOST`: address URL of Logstash on monitoring environment (e.g. 127.0.0.1 or localhost)
* Run `startFilebeat.cmd`
* Wait a second and open WxMonitoring http://localhost:5555/WxMonitoring/
   * You should see incoming events on dashboard
