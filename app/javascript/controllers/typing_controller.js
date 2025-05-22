import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="typing"
export default class extends Controller {
  static targets = [
    "method",
    "input",
    "correctCount",
    "wrongCount",
    "finishForm",
  ];
  static values = {
    methods: Array,
    currentIndex: Number,
    gameId: Number,
  };

  connect() {
    // 初期化時の現在のインデックス
    this.currentIndexValue = 0;

    // 正解数とミス数の初期化
    this.correctCount = 0;
    this.wrongCount = 0;

    // ゲームの設定
    this.setupGame();

    // ESCキーイベントリスナーを追加
    document.addEventListener("keydown", this.handleKeyDown.bind(this));
  }

  disconnect() {
    // コントローラーが切断されるときにイベントリスナーを削除
    document.removeEventListener("keydown", this.handleKeyDown.bind(this));
  }

  // キーダウンイベントハンドラー
  handleKeyDown(event) {
    if (event.key === "Escape") {
      // ESCキーが押されたときの処理
      this.retryGame();
    }
  }

  // ゲームをリトライする（/games/newに遷移）
  retryGame() {
    // ページ遷移時にcontroller.disconnect()が自動的に呼ばれ、そこでタイマーは停止
    window.location.href = "/games/new";
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
      this.methodTarget.innerHTML = `
        <div class="font-bold text-2xl text-red-700">${currentMethod.name}</div>
        ${currentMethod.description ? `<div class="text-sm text-gray-600 mt-1">${currentMethod.description}</div>` : ''}
      `;
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
      this.incrementCorrectCount();
      this.nextMethod();
      // 入力フィールドをクリア
      event.target.value = "";
    } else if (!currentMethod.name.startsWith(input)) {
      // 入力が間違っている場合（メソッド名の先頭部分と一致しなくなった時点でミス）
      this.incrementWrongCount();
    }
  }

  // 正解数をインクリメント
  incrementCorrectCount() {
    this.correctCount += 1;
    if (this.hasCorrectCountTarget) {
      this.correctCountTarget.textContent = this.correctCount;
    }
  }

  // ミス数をインクリメント
  incrementWrongCount() {
    this.wrongCount += 1;
    if (this.hasWrongCountTarget) {
      this.wrongCountTarget.textContent = this.wrongCount;
    }
  }

  // 次のメソッドへ
  nextMethod() {
    this.currentIndexValue += 1;
    this.updateCurrentMethod();
  }

  // 結果を送信して結果画面に遷移
  finishGame() {
    // フォームの値を更新
    this.updateFormValues();

    // フォームを送信
    this.finishFormTarget.requestSubmit();
  }

  // フォームの値を更新
  updateFormValues() {
    document.getElementById("game_correct_count").value = this.correctCount;
    document.getElementById("game_wrong_count").value = this.wrongCount;
  }
}
