import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "modalContent"];
  static values = { id: String };

  openModal(event) {
    event.preventDefault();
    const modalId = this.idValue;
    const modal = document.getElementById(`method-modal-${modalId}`);
    if (modal) {
      modal.classList.remove("hidden");
      // Escキーでモーダルを閉じる
      document.addEventListener("keydown", this.handleEscKey);
    }
  }

  closeModal(event) {
    if (event) event.preventDefault();
    if (this.hasModalTarget) {
      this.modalTarget.classList.add("hidden");
      // イベントリスナーを削除
      document.removeEventListener("keydown", this.handleEscKey);
    }
  }

  closeModalOutside(event) {
    // モーダルコンテンツ外をクリックした場合のみモーダルを閉じる
    if (
      this.hasModalContentTarget &&
      !this.modalContentTarget.contains(event.target)
    ) {
      this.closeModal();
    }
  }

  // Escキーが押された時の処理
  handleEscKey = (e) => {
    if (e.key === "Escape") {
      this.closeModal();
    }
  };

  // コントローラーが切断されたときの処理
  disconnect() {
    document.removeEventListener("keydown", this.handleEscKey);
    document.body.style.overflow = "auto";
  }
}
