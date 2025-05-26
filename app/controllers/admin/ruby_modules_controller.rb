# frozen_string_literal: true

module Admin
  class RubyModulesController < BaseController
    before_action :set_ruby_module, only: [:show, :edit, :update, :destroy]

    def index
      @ruby_modules = RubyModule.order(:name)
    end

    def show
      @ruby_methods = @ruby_module.ruby_methods.order(:name)
    end

    def new
      @ruby_module = RubyModule.new
    end

    def create
      @ruby_module = RubyModule.new(ruby_module_params)

      if @ruby_module.save
        redirect_to admin_ruby_module_path(@ruby_module), notice: 'モジュールを追加しました'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @ruby_module.update(ruby_module_params)
        redirect_to admin_ruby_module_path(@ruby_module), notice: 'モジュールを更新しました'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @ruby_module.destroy
      redirect_to admin_ruby_modules_path, notice: 'モジュールを削除しました'
    end

    private

    def set_ruby_module
      @ruby_module = RubyModule.find(params[:id])
    end

    def ruby_module_params
      params.require(:ruby_module).permit(:name, :description)
    end
  end
end
