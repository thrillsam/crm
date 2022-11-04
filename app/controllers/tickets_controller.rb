class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update, :destroy]
  skip_before_action :authenticate_user, only: :chart

  # GET /tickets
  def index
    @tickets = Ticket.all

    render json: @tickets
  end

  # GET /tickets/1
  def show
    render json: @ticket
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      render json: @ticket, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tickets/1
  def update
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
  end

  def chart
    # render json: {
    #   xAxis: {
    #     type: 'category',
    #     data: [Date.yesterday, Date.today]
    #   },
      
    #   yAxis: {
    #     type: 'value'
    #   },
      
    #   series: [
    #     {
    #       data: [Ticket.created_yesterday, Ticket.created_today],
    #       type: 'bar'
    #     }
    #   ]
    # }

    first = Team.first
    second = Team.second
    third = Team.third
    
    data = [
      {
        name: 'Ticket',
        children: [
          {
            name: first.name,
            value: 10,
            children: [
              {
                name: 'Cousin Jack',
                value: 5
              },
              {
                name: 'Cousin Mary',
                value: 5,
              },
              {
                name: 'Cousin Ben',
                value: 5
              }
            ]
          },

          {
            name: second.name,
            value: 10,
            children: [
              {
                name: 'Me',
                value: 5
              },
              {
                name: 'Brother Peter',
                value: 5
              }
            ]
          },

          {
            name: third.name,
            value: 10,
            children: [
              {
                name: 'Me',
                value: 5
              },
              {
                name: 'Brother Peter',
                value: 5
              }
            ]
          }          
        ]
      }
    ]
    
    render json: {
      series: {
        type: 'sunburst',
        data: data,
        radius: [10, '120%'],
        label: {
        rotate: 'radial'
        }
      }
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_params
      params.require(:ticket).permit(:title, :description, :status)
    end
end
