# Slack Log Viewer

Simple web interface for exploring Slack log.

# Usage

```sh
# Installing slack_log_viewer
$ gem install slack_log_viewer

# You can download all data from 'Slack Admin > Message Archives > Export Data' menu.
# https://<SLACK_TEAM_NAME>.slack.com/archives
# Before running server, unzip your log data, and check log data
$ ls <SLACK_LOG_DIR>
channel1/ channel2/ channels.json users.json ...

# help command show help message for slack-log-viewer command
$ slack-log-viewer --help
Usage: slack-log-viewer [options]
    -d LOG_DIR                       Set directory which has log data
    -p PORT_NUMBER                   Specify Port number
    -h HOST                          Specify host address

# Below command runs slack-log-viewer server
$ slack-log-viewer -d <SLACK_LOG_DIR>
[2016-01-30 22:33:01] INFO  WEBrick 1.3.1
[2016-01-30 22:33:01] INFO  ruby 2.2.3 (2015-08-18) [x86_64-darwin14]
== Sinatra (v1.4.7) has taken the stage on 4567 for development with backup from WEBrick
[2016-01-30 22:33:01] INFO  WEBrick::HTTPServer#start: pid=35157 port=4567
```

Browse `localhost:4567`. Port number can be set by `-p` option.

## Docker

Slack Log Viewer can run as a Docker container. 

```
$ docker build -t nacyot/slack_log_viewer .
$ docker run -it -v <LOG_DIR>:/tmp/slack -p 5000:5000 nacyot/slack_log_viewer
```

# Screenshot

![some logs](http://i.imgur.com/qQQoPuW.png)
![attachments](http://i.imgur.com/QMh79D8.png)
