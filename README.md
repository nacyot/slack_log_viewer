# Slack Log Viewer

Simple web interface for exploring Slack log.

# Usage

```sh
# Installing slack_log_viewer
$ gem install slack_log_viewer

# Before run server, check your log data
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

# Screenshot

![some logs](http://i.imgur.com/qQQoPuW.png)
![attachments](http://i.imgur.com/QMh79D8.png)
