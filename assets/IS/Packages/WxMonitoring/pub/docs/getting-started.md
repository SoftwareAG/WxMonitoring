## Getting started

It is quite easy to install and run WxMonitoring. Following steps guide you through installation.

### Install Monitoring Environment

First, you need to install (at least) an instance of 
> **webMethods Integration Server**
> * Version: 9.10 (or later)
> * Packages required: 
>   * _only_ Default, WmRoot, WmPublic
> * no messaging
> * no local database (use embedded database pool)

You may (re)use your current local webMethods environment.

Install the following 3rd party products on your local machine. (Skip this if already installed.)

> **Elasticsearch** (version: 6.2.x)
> use [Installing ElasticSearch][install-elasticsearch]

> **Logstash** (version: 6.2.x)
> use [Installing Logstash][install-logstash]

Start Servers

> **Elasticsearch**
> (e.g.) run `%ES_HOME%/bin/elasticsearch.bat`

> **Integration Server**
> (e.g.) run `%SAG_HOME%/profiles/IS_default/bin/startup.bat`

### Install WxMonitoring

1. Download the latest release of WxMonitoring from [GitHub][github-release].
1. Install IS package WxMonitoring
    * copy WxMonitoring.zip to `%SAG_HOME%/IntegrationServer/instances/default/replicate/inbound`
    * open IS Administration http://localhost:5555/
    * start Packages > Management > Install Inbound Releases, choose WxMonitoring, install
1. Open http://localhost:5555/WxMonitoring/
    * You should see an empty search result page
1. Open http://localhost:9200/_cat/indices?v
    * You should see indexes - `wxmonitoring-processes`, `wxmonitoring-events-original`, `wxmonitoring-events-xxxx.xx.xx`, `wxmonitoring-event-rules` - have been created
1. Start Logstash
    * Navigate to `...\packages\WxMonitoring\pub\elk\logstash` directory
    * Edit file `startLogstash.cmd` and update correct paths for following variables
          `SAG_HOME`: path for software ag home folder (e.g. `c:\SoftwareAG`)
          `LOGSTASH_HOME`: path to logstash home folder (for e.g. `C:\SoftwareAG\logstash-6.2.2`)
    * Run `startLogstash.cmd`
1. View Logstash logs
    * open file `%LOGSTASH_HOME%/logs/logstash-plain`
    * verify following log has been recorded: 
      `[INFO ][org.logstash.beats.Server] Starting server on port: 5044`

Now all components on monitoring enviroment are up and running. You can now 
1. start importing log files (see Users Guide), or 
1. install filebeat on target environment 

### Install Log Environment

You need to install filebeat on each environment you want to listen to. Please repeat the following steps for ech environment.

> **Hint**: 
> Monitoring environment _should not_ be a log environment. You won't need to run WxMonitoring to receive log events anyway.

Install the following 3rd party products on your local machine. (Skip this if already installed.)

> **Filebeat** (version: 6.2.x)
> use [Installing Filebeat][install-filebeat]

1. Copy files from `...\packages\WxMonitoring\pub\elk\filebeat` to anywhere in log environment server.
   * `startFilebeat.cmd`
   * `wxmonitoring_filebeat.yml`
1. Start Filebeat
   * Edit file `startFilebeat.cmd` and update correct paths for following variables
          `SAG_HOME`: path for software ag home folder (e.g. `c:\SoftwareAG`)
          `FILEBEAT_HOME`: path to filebeat home folder (for e.g. `C:\SoftwareAG\filebeat-6.2.2`)
          `SERVER_ID`: name of this log environment (e.g. prod1)
          `LOGSTASH_HOST`: address URL of Logstash on monitoring environment (e.g. 127.0.0.1 or localhost)
1. Run `startFilebeat.cmd`
1. Wait a second and open WxMonitoring http://localhost:5555/WxMonitoring/
   * You should see incoming events on dashboard
