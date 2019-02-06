## Development Guide

Hallo Marko !!

Still under construction ...

TODO !!

This development guide gathers several topics around software development lifecycle. Therefore both content and topics may change over time and releases.

### Design Principles

1. Keep it simple

    Keep it simple in sense of installation, configuration, usage, documentation to reduce complexity and avoid misuse

1. User-centric 

    All features should be motivated on users benefits.

1. Resilient first

    Features should be resilient before functional complete.

1. Use Markdown

    As Markdown is simple to use, Markdown should be a common way to provide projects documentation most fast and versatile

1. Selfdocumented

    * Project structure (package folders, naming) should be self-explanatory, with no need to explain
    * assets (public IS Services) should be documented directly in flow

1. Use Github

    Use GitHub to make project public available and interactive. This differs to most customer-related projects due to restricted contribution.

1. Selfcontained

    ??

### Dashboard

### Import log files

### Purge data

### Data Structures

#### Indexes

| index | description | 
| ------------- | ------------- |
| wxmonitoring-events-original | |
| wxmonitoring-events-[yyyy.MM.dd] | |
| wxmonitoring-processes-original | |
| wxmonitoring-processes | |
| wxmonitoring-event-rules | |

#### Event 
```json
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

#### Process 
```json
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

### Design

### Coding Conventions

### Code Checks

* dependency checks
* usage of external services
* coding conventions
* ...

#### webMethods Services

* wx.monitoring.__services.gui__.processes:getProcesses
    * [docs] wx.monitoring.docs.view:ProcessView
    * wx.monitoring.__services.query__.process:getProcesses
        * _wx.monitoring.impl.__persistence.queries__.processes:create*[AggQuery|Query]_
        * wx.monitoring.__impl.persistence.handler:getESDocumentsByQuery__
            * wx.monitoring.__impl.adapters.es:invokeElasticSearch__
        * _wx.monitoring.__impl.maps__:processCanonicalToprocessView_

* wx.monitoring.services.gui.processes:getProcessesStats
    * wx.monitoring.services.query.aggregation:getProcessesAgg
        * [docs] wx.monitoring.docs.dbo:LevelOneAgg
        * [docs] wx.monitoring.docs.dbo:LevelTwoAgg
        * [docs] wx.monitoring.docs.dbo:AggBucket
        * wx.monitoring.impl.persistence.queries.processes:createGetProcessAggQuery
        * wx.monitoring.__impl.persistence.handler:getESDocumentsByQuery__
        * wx.monitoring.impl.maps:aggSourceToAggViewList


* wx.monitoring.services.gui.dashboard:getDashboard
    * wx.monitoring.services.gui.events:getEventsStats
        * wx.monitoring.services.admin:getEventsAgg
            * wx.monitoring.impl.maps:aggSourceToAggViewList
            * wx.monitoring.impl.persistence.handler:getESDocumentsByQuery
            * wx.monitoring.impl.persistence.queries.events:createGetEventAggQuery
    * wx.monitoring.services.gui.processes:getProcessesStats
        * wx.monitoring.services.admin:getProcessesAgg
            * wx.monitoring.impl.maps:aggSourceToAggViewList
            * wx.monitoring.impl.persistence.handler:**getESDocumentsByQuery**
                 * wx.monitoring.services.adapters.es:invokeElasticSearch
        * wx.monitoring.impl.persistence.queries.processes:createGetProcessAggQuery


### Elastic Search Query

#### Querying

#### Aggregation

Aggreation can be 
* performed on index
* filtered by timerange (from-to), field-value
* grouped by 1 or 2 dimensions

##### Sample Request (group by date - date histogram)

```json
{
	"size": 0, 
    "query": {
		"bool": {
			"must": [{
					"range": {
						"last_updated_utc": {
							"gte": "2017-01-21 23:00:00",
							"lte": "2019-02-01 14:47:59"
						    }
					    }   
				    },
                    {
                    "match": {
                        "business_domain": "RbProcessSAPArchivingApprovalModel"
                        }
                    }
            ]
		}
	},
  "aggs": {
    "level_one_bucket": {
      "date_histogram": {
        "field": "last_updated_utc",
        "interval": "day"
      }, "aggs": {
        "level_two_bucket": {
          "terms": {
            "field": "current_status",
            "size": 10
          }
        }
      }
    }
  }}
```

##### Sample Request (group by field - terms)

```json
...
  "aggs": {
    "level_one_bucket": {
      "terms": {
        "field": "process_env.keyword",
        "size": 1000,
         "order" : { "_key" : "asc" }
      },
      "aggs": {
        "level_two_bucket": {
          "terms": {
            "field": "current_status",
            "size": 1000
          }
        }
      }
    }
  }
```

##### Sample Request (simple one level only)

```json
  "aggs": {
    "level_one_bucket": {
      "terms": {
        "field": "business_domain",
        "size": 1000,
         "order" : { "_key" : "asc" }
      }
    }
  }}
```


##### Sample Response (date histogram)

```json
{
  "took" : 2,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : 102,
    "max_score" : 0.0,
    "hits" : [ ]
  },
  "aggregations" : {
    "level_one_bucket" : {
      "buckets" : [ {
        "key_as_string" : "2017-04-13 00:00:00",
        "key" : 1492041600000,
        "doc_count" : 19,
        "level_two_bucket" : {
          "doc_count_error_upper_bound" : 0,
          "sum_other_doc_count" : 0,
          "buckets" : [ {
            "key" : "failed",
            "doc_count" : 15
          }, {
            "key" : "completed",
            "doc_count" : 4
          } ]
        }
      }, {
        "key_as_string" : "2017-04-14 00:00:00",
        "key" : 1492128000000,
        "doc_count" : 0,
        "level_two_bucket" : {
          "doc_count_error_upper_bound" : 0,
          "sum_other_doc_count" : 0,
          "buckets" : [ ]
        }
      }, {
...
      }, {
        "key_as_string" : "2018-12-03 00:00:00",
        "key" : 1543795200000,
        "doc_count" : 2,
        "level_two_bucket" : {
          "doc_count_error_upper_bound" : 0,
          "sum_other_doc_count" : 0,
          "buckets" : [ {
            "key" : "completed",
            "doc_count" : 1
          }, {
            "key" : "failed",
            "doc_count" : 1
          } ]
        }
      } ]
    }
  }
}
```

##### Sample Response (date histogram)

```json
...
  "aggregations" : {
    "level_one_bucket" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 0,
      "buckets" : [ {
        "key" : "dev1",
        "doc_count" : 4,
        "level_two_bucket" : {
          "doc_count_error_upper_bound" : 0,
          "sum_other_doc_count" : 0,
          "buckets" : [ {
            "key" : "completed",
            "doc_count" : 2
          }, {
            "key" : "failed",
            "doc_count" : 2
          } ]
        }
      }, {
        "key" : "import_server2",
        "doc_count" : 152,
        "level_two_bucket" : {
          "doc_count_error_upper_bound" : 0,
          "sum_other_doc_count" : 0,
          "buckets" : [ {
            "key" : "completed",
            "doc_count" : 96
          }, {
            "key" : "failed",
            "doc_count" : 34
          }, {
            "key" : "started",
            "doc_count" : 22
          } ]
        }
      }, {
...
```
