import { Controller } from "@hotwired/stimulus";

// フラッシュメッセージを自動的に消すためのコントローラー
export default class extends Controller {
  connect() {
    // 3秒後にフラッシュメッセージを消す
    setTimeout(() => {
      this.element.classList.add("opacity-0");
      setTimeout(() => {
        this.element.remove();
      }, 500);
    }, 3000);
  }

  close() {
    this.element.classList.add("opacity-0");
    setTimeout(() => {
      this.element.remove();
    }, 500);
  }
}
