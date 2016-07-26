# Cuberite-SlackChatPlugin
A plugin to integrate chats in Cuberite to Slack.

## Notes
* This is a quick hack to get in-game chats to appear in a Slack channel. 
* This plugin has only been tested on Linux. It requires curl so it likely won't work on Windows unless curl is installed.

## Installation
1. Create channel and a Slack bot: https://my.slack.com/services/new/bot (add the bot to the channel)
2. Download the plugin to Plugins/SlackChat
3. Add configuration in Cuberite root directory: SlackChat.ini

```
[SlackChat]
apiToken=(insert your api token from step #1)
channel=#minecraft
```

Feel free to make improvements/suggestions!
