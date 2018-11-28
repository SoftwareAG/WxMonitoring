# WxMonitoring
WxMonitoring is a ready-to-use webMethods monitoring solution based on Open Elastic Stack (Elastic Search, Logstash, Filebeat), that provides rules-based log-file analysis and activity monitoring to optimize webMethods operations.

## Overview
If running multiple webMethods productive environments it becomes critical to keep track of exceptions in near-time and leverage operational costs. WxMonitoring is a monitoring solution based on Open Elastic Stack, that provides a independent, centralized monitoring. It samples existing IS log-files and supports queries and aggregations views. Additionally automatized rule based actions allows you to react immediately after an exception occurs. They simply send mails, raise JIRA tickets or invoke a compensating service. Rules can be easily defined on existing los messages. For business users WxMonitoring provides views and reports on current and historical process executions.

![System Architecture](ressources/img/architecture.png)

## Jump Start
To getting started just [download latest](dist/WxMonitoring-dist-0.1.zip) (current: v0.1) distribution package and unzip. 

## Roapmap
WxMonitoring started as a custom development and was ported to a community version. In November 2018 the first (beta) version 0.1 of WxMonitoring is released to give a first introduction.

Several features will be added to this community edition, depending on customer requests.

## Authors
[Marko Goerg](mailto:Marko.Goerg@softwareag.com)

[Puneet Arora](mailto:Puneet.Arora@softwareag.com)