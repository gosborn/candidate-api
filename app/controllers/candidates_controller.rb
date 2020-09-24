class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :update, :destroy]
  before_action :set_candidates, only: :index

  def index
    render json: @candidates
  end

  def show
    render json: @candidate
  end

  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      render json: @candidate, status: :created, location: @candidate
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  def update
    if @candidate.update(candidate_params)
      render json: @candidate
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @candidate.destroy
  end

  private
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    def candidate_params
      params.require(:candidate).permit(:name, :years_exp, :status, :date_applied, :description)
    end

    def set_candidates
      candidates = Candidate.all
      candidates = filter_candidates(candidates)
      @candidates = order_candidates(candidates)
    end

    def filter_candidates(candidates)
      return candidates if params['reviewed'].blank?
      candidates.reviewed(ActiveRecord::Type::Boolean.new.deserialize(params[:reviewed]))
    end

    def order_candidates(candidates)
      return candidates if params['order'].blank?
      candidates.order(ordering)
    end

    def ordering
      params['order'].split(',').collect do |param|
        if param.starts_with?('-')
          "#{param[1..-1]} DESC" if Candidate.column_names.include?(param[1..-1])
        else
          param if Candidate.column_names.include?(param)
        end
      end.join(', ')
    end
end
