import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="timer"
export default class extends Controller {
  static targets = ["display", "input", "progressBar"];

  connect() {
    // タイマーの初期値
    this.remainingTime = parseInt(this.displayTarget.textContent);
    this.totalTime = this.remainingTime; // 開始時の時間を保存

    // ゲーム開始時に入力フィールドに自動でフォーカス
    this.inputTarget.focus();

    // プログレスバーの初期状態を設定
    this.updateProgressBar();

    // タイマースタート
    this.startTimer();
  }

  disconnect() {
    // ページ離脱時にタイマーをクリア
    this.stopTimer();
  }

  startTimer() {
    // 1秒ごとにカウントダウン
    this.timer = setInterval(() => {
      this.remainingTime -= 1;
      this.displayTarget.textContent = this.remainingTime;

      // プログレスバーを更新
      this.updateProgressBar();

      // 0秒になったらタイマー停止
      if (this.remainingTime <= 0) {
        this.stopTimer();
        this.endGame();
      }
    }, 1000);
  }

  // プログレスバーを更新するメソッド
  updateProgressBar() {
    if (this.hasProgressBarTarget) {
      const percentage = (this.remainingTime / this.totalTime) * 100;
      this.progressBarTarget.style.width = `${Math.max(0, percentage)}%`;

      // 残り時間が少なくなったら色を変更
      if (percentage <= 20) {
        this.progressBarTarget.classList.remove(
          "bg-gradient-to-r",
          "from-red-500",
          "to-red-300"
        );
        this.progressBarTarget.classList.add(
          "bg-gradient-to-r",
          "from-red-600",
          "to-red-800"
        );
      } else if (percentage <= 50) {
        this.progressBarTarget.classList.remove(
          "bg-gradient-to-r",
          "from-red-500",
          "to-red-300"
        );
        this.progressBarTarget.classList.add(
          "bg-gradient-to-r",
          "from-yellow-500",
          "to-red-500"
        );
      }
    }
  }

  stopTimer() {
    if (this.timer) {
      clearInterval(this.timer);
      this.timer = null;
    }
  }

  // タイマーが0になった時に、typingコントローラーに終了を通知する
  endGame() {
    // タイピング入力を無効にする
    if (this.hasInputTarget) {
      this.inputTarget.disabled = true;
    }

    // プログレスバーを0%にセット
    this.updateProgressBar();

    // タイピングコントローラーのfinishGameメソッドを呼び出す
    const typingController =
      this.application.getControllerForElementAndIdentifier(
        this.element,
        "typing"
      );
    if (typingController) {
      typingController.finishGame();
    }
  }
}
