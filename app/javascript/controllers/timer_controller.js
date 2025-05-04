import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {
  static targets = ["display", "input"]
  connect() {
    // タイマーの初期値
    this.remainingTime = parseInt(this.displayTarget.textContent)

    // ゲーム開始時に入力フィールドに自動でフォーカス
    this.inputTarget.focus()

    // タイマースタート
    this.startTimer()
  }

  disconnect() {
    // ページ離脱時にタイマーをクリア
    this.stopTimer()
  }

  startTimer() {
    // 1秒ごとにカウントダウン
    this.timer = setInterval(() => {
      this.remainingTime -= 1
      this.displayTarget.textContent = this.remainingTime

      // 0秒になったらタイマー停止
      if (this.remainingTime <= 0) {
        this.stopTimer()
        // 後でゲーム終了処理を追加する
      }
    }, 1000)
  }

  stopTimer() {
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
  }
}
