class Api::V1::JournalsController < ApplicationController
  def index
    @token = params[:token]
    unless User.find_by(token: @token)
      render json: { staus: 401, data: "Invalid token." }
    else
      @journals = Journal
                    .joins(:incomes)
                    .joins(:expenes)
                    .joins(:user)
                    .select("incomes.*", "expenes.*", "users.token")
                    .where(users: {token: @token})
      render json: { staus: 200, data: @journals }
    end
  end
  def create
    @token = params[:token]
    @name = params[:name]
    @amount = params[:amount]
    @target_datetime = params[:target_datetime]
    @type = params[:type]
    @user = User.find_by(token: @token)
    if !@user
      render json: { staus: 401, data: "Invalid token." }
    elsif @type == "income" || @type == "expene"
      @journal = Journal.create(name: @name, amount: @amount,
                                user_id: @user.id,
                                target_datetime: @target_datetime)
      if @type == "income"
        Income.create!(journal_id: @journal.id)
      elsif @type == "expene"
        Expene.create!(journal_id: @journal.id)
      end
      render json: { staus: 200, data: {journal: @journal, type: @type} }
    else
      render json: { staus: 401, data: "Invalid type." }
    end
  end
  def destroy
    @token = params[:token]

    unless User.find_by(token: @token)
      render json: { staus: 401, data: "Invalid token." }
    else
      @id = params["id"]
      @j = Journal.find(@id)
      if User.find(@j.user_id).token == User.find_by(token: @token).token
        Income.find_by(journal_id: @id).destroy! unless Income.find_by(journal_id: @id).nil?
        Expene.find_by(journal_id: @id).destroy! unless Expene.find_by(journal_id: @id).nil?
        @j.destroy!
        render json: { staus: 401, data: "Deleted" }
      else
        render json: { staus: 401, data: "You're evil." }
      end
    end
  end
end
