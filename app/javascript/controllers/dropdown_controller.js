import { Controller } from "@hotwired/stimulus";

// ドロップダウンメニューの制御
export default class extends Controller {
  static targets = ["menu"];

  connect() {
    // クリック外部での閉じる処理を設定
    document.addEventListener("click", this.outsideClick);
  }

  disconnect() {
    // イベントリスナーを削除
    document.removeEventListener("click", this.outsideClick);
  }

  // アロー関数を使用してthisのコンテキストを保持
  outsideClick = (event) => {
    if (
      !this.element.contains(event.target) &&
      !this.menuTarget.classList.contains("hidden")
    ) {
      this.menuTarget.classList.add("hidden");
    }
  };

  toggle() {
    this.menuTarget.classList.toggle("hidden");
  }
}
