import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="typing"
export default class extends Controller {
  static targets = ["method", "input", "finishForm", "classModuleInfo"];
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

    // 現在の入力位置を追跡
    this.currentCharIndex = 0;

    // メソッド配列をシャッフル
    this.shuffleMethodsArray();

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

    // 非表示の入力フィールドにフォーカスを設定
    this.inputTarget.focus();

    // クリックで入力フィールドにフォーカスを戻す
    document.addEventListener("click", () => {
      this.inputTarget.focus();
    });
  }

  // メソッド配列をシャッフルする
  shuffleMethodsArray() {
    for (let i = this.methodsValue.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [this.methodsValue[i], this.methodsValue[j]] = [
        this.methodsValue[j],
        this.methodsValue[i],
      ];
    }
  }

  // 現在のメソッドを表示（文字フォーカス機能付き）
  updateCurrentMethod() {
    if (this.currentIndexValue < this.methodsValue.length) {
      const currentMethod = this.methodsValue[this.currentIndexValue];
      this.currentCharIndex = 0; // 新しいメソッドでは文字インデックスをリセット
      this.renderMethodWithFocus(currentMethod);
      this.updateClassModuleInfo(currentMethod);
    } else {
      // 全てのメソッドが終了した場合は配列をシャッフルして最初から
      this.shuffleMethodsArray();
      this.currentIndexValue = 0;
      this.updateCurrentMethod();
    }
  }

  // クラス・モジュール情報を更新
  updateClassModuleInfo(method) {
    if (this.hasClassModuleInfoTarget) {
      this.classModuleInfoTarget.innerHTML = `クラス: ${method.class_name} • モジュール: ${method.module_name}`;
    }
  }

  // メソッドを文字フォーカス付きで描画
  renderMethodWithFocus(method) {
    const methodName = method.name;
    let html = "";

    // 各文字を個別のスパンで囲む
    for (let i = 0; i < methodName.length; i++) {
      const char = methodName[i];
      let className = "method-char";

      if (i === this.currentCharIndex) {
        className += " current-char"; // 現在の入力位置
      } else if (i < this.currentCharIndex) {
        className += " typed-char"; // 既に入力済み
      }

      html += `<span class="${className}">${char}</span>`;
    }

    this.methodTarget.innerHTML = `
      <div class="font-bold text-4xl text-red-700 tracking-wide method-display">
        ${html}
      </div>
    `;
  }

  // ユーザー入力の処理
  handleInput(event) {
    const input = event.target.value;
    const currentMethod = this.methodsValue[this.currentIndexValue];
    const methodName = currentMethod.name;

    if (input === methodName) {
      // 正解の場合
      this.incrementCorrectCount();
      this.showCorrectEffect();
      this.nextMethod();
      // 入力フィールドをクリア
      event.target.value = "";
      // 正解の場合は nextMethod() 内で新しいメソッドが表示されるので、ここでは何もしない
    } else if (!methodName.startsWith(input)) {
      // 入力が間違っている場合（メソッド名の先頭部分と一致しなくなった時点でミス）
      this.incrementWrongCount();
      this.showWrongEffect();
      // 入力フィールドをクリア
      event.target.value = "";
      // 文字インデックスをリセット
      this.currentCharIndex = 0;
      // 不正解の場合は現在のメソッドを再描画
      this.renderMethodWithFocus(currentMethod);
    } else {
      // 入力中の場合（部分的に正しい入力）
      // 入力文字数に応じて現在の文字インデックスを更新
      this.currentCharIndex = input.length;
      // 文字フォーカス表示を更新
      this.renderMethodWithFocus(currentMethod);
    }
  }

  // 正解エフェクトを表示
  showCorrectEffect() {
    // 入力フィールドに正解エフェクトを適用
    this.inputTarget.classList.add("correct-answer");
    this.methodTarget.classList.add("method-correct");

    // 一定時間後にエフェクトを削除
    setTimeout(() => {
      this.inputTarget.classList.remove("correct-answer");
      this.methodTarget.classList.remove("method-correct");
    }, 500);
  }

  // 不正解エフェクトを表示
  showWrongEffect() {
    // 画面を振動させるエフェクトを適用
    document.body.classList.add("shake");
    this.inputTarget.classList.add("wrong-answer");

    // 一定時間後にエフェクトを削除
    setTimeout(() => {
      document.body.classList.remove("shake");
      this.inputTarget.classList.remove("wrong-answer");
    }, 500);
  }

  // 正解数をインクリメント
  incrementCorrectCount() {
    this.correctCount += 1;
  }

  // ミス数をインクリメント
  incrementWrongCount() {
    this.wrongCount += 1;
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
