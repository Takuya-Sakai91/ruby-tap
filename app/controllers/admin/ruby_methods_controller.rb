# frozen_string_literal: true

module Admin
  class RubyMethodsController < BaseController
    before_action :set_ruby_method, only: [:show, :edit, :update, :destroy]

    def index
      base_query = RubyMethod.includes(:ruby_module).order('ruby_modules.name', :name)

      @ruby_methods = if defined?(Kaminari) && base_query.respond_to?(:page)
                       base_query.page(params[:page]).per(20)
                     else
                       base_query
                     end
    end

    def show
    end

    def new
      @ruby_method = RubyMethod.new
      @ruby_modules = RubyModule.order(:name)
    end

    def create
      @ruby_method = RubyMethod.new(ruby_method_params)

      if @ruby_method.save
        redirect_to admin_ruby_method_path(@ruby_method), notice: 'メソッドを追加しました'
      else
        @ruby_modules = RubyModule.order(:name)
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @ruby_modules = RubyModule.order(:name)
    end

    def update
      if @ruby_method.update(ruby_method_params)
        redirect_to admin_ruby_method_path(@ruby_method), notice: 'メソッドを更新しました'
      else
        @ruby_modules = RubyModule.order(:name)
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @ruby_method.destroy
      redirect_to admin_ruby_methods_path, notice: 'メソッドを削除しました'
    end

    private

    def set_ruby_method
      @ruby_method = RubyMethod.find(params[:id])
    end

    def ruby_method_params
      params.require(:ruby_method).permit(:name, :description, :class_name, :ruby_module_id)
    end
  end
end
