# frozen_string_literal: true

namespace :admin do
  desc '管理者ユーザーを作成'
  task create: :environment do
    email = ENV['ADMIN_EMAIL'] || 'tkyntm0927@gmail.com'
    password = ENV['ADMIN_PASSWORD']
    username = ENV['ADMIN_USERNAME'] || 'tkyntm0927'

    # パスワードが設定されていない場合はランダム生成
    if password.blank?
      password = SecureRandom.alphanumeric(16) + "!@#"
      puts "⚠️  ADMIN_PASSWORD環境変数が設定されていません"
      puts "📝 ランダムパスワードを生成しました: #{password}"
      puts "🔧 次回からは環境変数を設定してください:"
      puts "   fly secrets set ADMIN_PASSWORD='あなたの任意のパスワード'"
    end

    admin_user = User.find_or_create_by(email: email) do |user|
      user.username = username
      user.password = password
      user.password_confirmation = password
      user.admin = true
    end

    if admin_user.persisted?
      if admin_user.admin?
        puts "✅ 管理者ユーザーが正常に作成されました:"
        puts "   Email: #{admin_user.email}"
        puts "   Username: #{admin_user.username}"
        puts "   管理画面URL: https://ruby-tap.fly.dev/admin"
        if ENV['ADMIN_PASSWORD'].blank?
          puts "   🔑 パスワード: #{password}"
          puts "   ⚠️  このパスワードを安全な場所に保存してください！"
        end
      else
        admin_user.update!(admin: true)
        puts "✅ 既存ユーザーに管理者権限を付与しました: #{admin_user.email}"
      end
    else
      puts "❌ 管理者ユーザーの作成に失敗しました:"
      admin_user.errors.full_messages.each { |message| puts "   - #{message}" }
    end
  end

  desc '管理者ユーザーのパスワードをリセット'
  task reset_password: :environment do
    email = ENV['ADMIN_EMAIL'] || 'tkyntm0927@gmail.com'
    new_password = ENV['NEW_PASSWORD'] || SecureRandom.alphanumeric(16) + "!@#"

    admin_user = User.find_by(email: email, admin: true)

    if admin_user
      admin_user.update!(password: new_password, password_confirmation: new_password)
      puts "✅ 管理者パスワードをリセットしました:"
      puts "   Email: #{admin_user.email}"
      puts "   新しいパスワード: #{new_password}"
      puts "   ⚠️  このパスワードを安全な場所に保存してください！"
    else
      puts "❌ 管理者ユーザーが見つかりません: #{email}"
    end
  end

  desc '管理者ユーザー一覧を表示'
  task list: :environment do
    admins = User.where(admin: true)

    if admins.any?
      puts "📋 管理者ユーザー一覧:"
      admins.each do |admin|
        puts "   - #{admin.email} (#{admin.username})"
      end
    else
      puts "❌ 管理者ユーザーが存在しません"
    end
  end

  desc 'ダミーユーザーや不要なユーザーを削除'
  task cleanup_users: :environment do
    puts "🧹 ユーザークリーンアップを開始します..."

    # 削除対象のユーザーを特定
    dummy_users = User.where(admin: false).where(
      "email LIKE ? OR email LIKE ? OR username LIKE ?",
      "%example.com%", "%test%", "%dummy%"
    )

    test_users = User.where("created_at < ? AND games_count = 0", 1.day.ago)

    puts "\n📋 削除対象ユーザー:"

    if dummy_users.any?
      puts "  ダミーユーザー:"
      dummy_users.each do |user|
        puts "    - #{user.email} (#{user.username}) - 作成日: #{user.created_at}"
      end
    end

    if test_users.any?
      puts "  テストユーザー（ゲーム履歴なし）:"
      test_users.each do |user|
        puts "    - #{user.email} (#{user.username}) - 作成日: #{user.created_at}"
      end
    end

    total_to_delete = dummy_users.count + test_users.count

    if total_to_delete == 0
      puts "\n✅ 削除対象のユーザーはありません"
      return
    end

    puts "\n⚠️  #{total_to_delete}名のユーザーを削除しますか？ (y/N)"

    # 本番環境では自動実行のため、環境変数で制御
    if ENV['CONFIRM_USER_CLEANUP'] == 'yes'
      confirmation = 'y'
    else
      puts "   確認するには CONFIRM_USER_CLEANUP=yes を設定してください"
      return
    end

    if confirmation&.downcase == 'y'
      deleted_count = 0

      dummy_users.each do |user|
        user.destroy!
        deleted_count += 1
        puts "  ✅ 削除: #{user.email}"
      end

      test_users.each do |user|
        user.destroy!
        deleted_count += 1
        puts "  ✅ 削除: #{user.email}"
      end

      puts "\n🎉 #{deleted_count}名のユーザーを削除しました"
    else
      puts "\n❌ クリーンアップをキャンセルしました"
    end
  end

  desc '全ユーザー一覧を表示（管理者以外）'
  task list_all_users: :environment do
    puts "📋 全ユーザー一覧:"
    puts "=" * 50

    admins = User.where(admin: true)
    regular_users = User.where(admin: false)

    puts "\n👑 管理者ユーザー (#{admins.count}名):"
    admins.each do |user|
      puts "  - #{user.email} (#{user.username}) - 作成日: #{user.created_at.strftime('%Y-%m-%d')}"
    end

    puts "\n👤 一般ユーザー (#{regular_users.count}名):"
    regular_users.order(:created_at).each do |user|
      games_count = user.games.count
      puts "  - #{user.email} (#{user.username}) - ゲーム数: #{games_count} - 作成日: #{user.created_at.strftime('%Y-%m-%d')}"
    end

    puts "\n📊 統計:"
    puts "  - 総ユーザー数: #{User.count}名"
    puts "  - 管理者: #{admins.count}名"
    puts "  - 一般ユーザー: #{regular_users.count}名"
    puts "  - アクティブユーザー（ゲーム履歴あり）: #{User.joins(:games).distinct.count}名"
  end

  desc '特定のユーザーを削除'
  task delete_user: :environment do
    email = ENV['DELETE_USER_EMAIL']

    if email.blank?
      puts "❌ DELETE_USER_EMAIL環境変数を設定してください"
      puts "   例: DELETE_USER_EMAIL='user@example.com' rails admin:delete_user"
      return
    end

    user = User.find_by(email: email)

    if user.nil?
      puts "❌ ユーザーが見つかりません: #{email}"
      return
    end

    if user.admin?
      puts "⚠️  管理者ユーザーは削除できません: #{email}"
      return
    end

    puts "🗑️  以下のユーザーを削除します:"
    puts "  - Email: #{user.email}"
    puts "  - Username: #{user.username}"
    puts "  - ゲーム数: #{user.games.count}"
    puts "  - 作成日: #{user.created_at}"

    user.destroy!
    puts "\n✅ ユーザーを削除しました: #{email}"
  end
end
