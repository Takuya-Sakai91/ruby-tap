import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="typing"
export default class extends Controller {
  static targets = ["method", "input"];
  static values = {
    methods: Array,
    currentIndex: Number,
  };

  connect() {
    // 初期化時の現在のインデックス
    this.currentIndexValue = 0;

    // ゲームの設定
    this.setupGame();
  }

  setupGame() {
    // 最初のメソッドを表示
    if (this.methodsValue.length > 0) {
      this.updateCurrentMethod();
    }

    // 入力フィールドの設定
    this.inputTarget.addEventListener("input", this.handleInput.bind(this));
  }

  // 現在のメソッドを表示
  updateCurrentMethod() {
    if (this.currentIndexValue < this.methodsValue.length) {
      const currentMethod = this.methodsValue[this.currentIndexValue];
      this.methodTarget.textContent = currentMethod.name;
    } else {
      // 全てのメソッドが終了した場合は最初に戻る
      this.currentIndexValue = 0;
      this.updateCurrentMethod();
    }
  }

  // ユーザー入力の処理
  handleInput(event) {
    const input = event.target.value;
    const currentMethod = this.methodsValue[this.currentIndexValue];

    if (input === currentMethod.name) {
      // 正解の場合
      this.nextMethod();
      // 入力フィールドをクリア
      event.target.value = "";
    }
  }
  // 次のメソッドへ
  nextMethod() {
    this.currentIndexValue += 1;
    this.updateCurrentMethod();
  }
}
