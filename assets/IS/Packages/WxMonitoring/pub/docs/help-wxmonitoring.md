# WxMonitoring
WxMonitoring is a ready-to-use webMethods monitoring solution based on Open Elastic Stack (Elastic Search, Logstash, Filebeat), that provides rules-based log-file analysis and activity monitoring to optimize webMethods operations.

## Overview
If running multiple webMethods productive environments it becomes critical to keep track of exceptions in near-time and leverage operational costs. WxMonitoring is a monitoring solution based on Open Elastic Stack, that provides a independent, centralized monitoring. It samples existing IS log-files and supports queries and aggregations views. Additionally automatized rule based actions allows you to react immediately after an exception occurs. They simply send mails, raise JIRA tickets or invoke a compensating service. Rules can be easily defined on existing los messages. For business users WxMonitoring provides views and reports on current and historical process executions.

## ToDo...

## Features

### Dashboard

### Fulltext Search

### Import log files

### Purge data


## Interfaces

### Filebeat

### Logstash

```
input {
  beats {
    port => "${LOGSTASH_PORT:5044}"
  }
  http {
    port => "${LOGSTASH_HTTP_IMPORT_PORT:5045}"
  }
}
```

#### Beats

Logstash is listing on port :5044 to receive Beats log events.

#### Http

For debugging and importing events directly Logstash is listing on port :5045 to receive log events via REST.

Use this JSON-format to emit an message event:
```
{
"message":"2018-12-11 11:33:59 MEZ [ISS.0134.0058E] JMS Trigger test.wx.smoketest.services.edademo...",
"log_identifier":"server_log",
"source":"\\IS1\\server.log",
"fields":{
    "env":"esbtest"
}
}
```


## Data Structures

### Indexes

| index | description | 
| ------------- | ------------- |
| wxmonitoring-events-original | |
| wxmonitoring-events-[yyyy.MM.dd] | |
| wxmonitoring-processes-original | |
| wxmonitoring-processes | |
| wxmonitoring-event-rules | |

### Event 
```
{
"_index": "wxmonitoring-events-original",
"_type": "doc",
"_id": "Zw0qmmcBRr67D9-7nTXm",
"_score": 2.2693477,
"_source": {
    "event_tags": "ISS",
    "complete_event_log": "2018-05-01 00:02:40 MESZ [ISS.0015.0005D] Invoking service wm.server.ns:getNode.",
    "event_severity": "DEBUG",
    "log_identifier": "server_log",
    "event_identifier": "unknown_IS_event",
    "event_timestamp_utc": "2018-04-30 22:02:40",
    "host": "127.0.0.1",
    "log_time_zone": "MESZ",
    "event_information": "Invoking service wm.server.ns:getNode.",
    "@timestamp": "2018-12-10T22:09:02.703Z",
    "event_code": "ISS.0015.0005",
    "source": """\IS\server.log""",
    "event_env": "serverdid2"
    }
}
```

### Process 
```
{
"_index": "wxmonitoring-processes",
"_type": "doc",
"_id": "202bb4e0-00e2-1a47-8335-fffffffe442c",
"_score": 1,
"_source": {
    "process_id": "202bb4e0-00e2-1a47-8335-fffffffe442c",
    "log_history": [
        "2018-11-08 14:39:34 MEZ [BPM.0102.0196I] 202bb4e0-00e2-1a47-8335-fffffffe442c:1, MID=WxSmoketestProcesses/SmokeTest3, MVer=1: process started",
        "2018-11-08 14:39:37 MEZ [BPM.0102.0199I] 202bb4e0-00e2-1a47-8335-fffffffe442c:1, MID=WxSmoketestProcesses/SmokeTest3, MVer=1: process failed"
    ],
    "MVer": "1",
    "offset": null,
    "started_timestamp_utc": "2018-11-08 13:39:34",
    "process_name": "SmokeTest3",
    "business_domain": "WxSmoketestProcesses",
    "current_status": "failed",
    "process_env": "serverid1",
    "source": """\IS\server.log""",
    "process_instance": "1",
    "last_updated_utc": "2018-11-08 13:39:37",
    "failed_timestamp_utc": "2018-11-08 13:39:37",
    "event_tags": [
        "BPM"
    ]
}
}
```