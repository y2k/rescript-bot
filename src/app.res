module Telegram = {
  type t

  type params = {polling: bool}

  @bs.new @bs.module external createTelegramBot: (string, params) => t = "node-telegram-bot-api"

  type chat = {id: int}
  type msg = {chat: chat, text: string}

  @bs.send external onMessage: (t, string, msg => unit) => unit = "on"
}

let main = () => {
  Node.Process.process["env"]
  ->Js_dict.unsafeGet("TELEGRAM_TOKEN")
  ->Telegram.createTelegramBot({polling: true})
  ->Telegram.onMessage("inline_query", msg => {
    Js.log(msg)
  })
}
