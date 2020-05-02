module Api
  module V1
    class IngredientsController < ApplicationController
      
      # GET /ingrediente
      def index
        @ingredients = Ingredient.all
        render json: @ingredients, :except => [:created_at, :updated_at], status: 200
      end

      # GET /ingrediente/:id
      def show
        if params[:id].is_a? Integer
          @ingredient = Ingredient.find(params[:id].to_i)
          if @ingredient
            render json: @ingredient, :except => [:created_at, :updated_at], status: 200
          else
            render json: { error: 'Ingrediente inexistente'}, status: 404
          end
        else
          render json: { error: 'Id inválido'}, status: 400
        end
      end

      # POST /ingrediente
      def create
        if ingredient_params.key?("nombre") && ingredient_params.key?("descripcion")
          if ingredient_params["nombre"]!= "" && ingredient_params["descripcion"]!= ""
            @ingredient = Ingredient.new(ingredient_params)
            if @ingredient.save
              render json: @ingredient, message: 'ingrediente creado', :except => [:created_at, :updated_at], :status => "201"
            else
              render json: { error: 'No se pudo crear el ingrediente'}, status: 400
            end
          else 
            render json: { error: 'Input inválido. Se deben rellenar con valores válidos'}, status: 400    
          end
        else
          render json: { error: 'Input inválido'}, status: 400
        end
      end

      # DELETE /ingrediente/:id
      def destroy
        @ingredient=Ingredient.find(params[:id])
        if @ingredient
          @relation = HamburgersIngredient.find_by(ingredient_id: params[:id])
            if @relation
              render json: { error: '	Ingrediente no se puede borrar, se encuentra presente en una hamburguesa'}, status:409
            else
              @ingredient.destroy
              render json: { message: 'ingrediente eliminado'}, status: 200
            end
        else
          render json: { error: 'ingrediente inexistente'}, status: 404
        end
      end

      private
      def ingredient_params
        params.require(:ingredient).permit(:nombre, :descripcion)
      end
    end
  end
end