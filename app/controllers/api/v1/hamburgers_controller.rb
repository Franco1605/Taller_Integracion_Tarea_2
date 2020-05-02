module Api
  module V1
    class HamburgersController < ApplicationController
      def is_numeric(o)
        true if Integer(o) rescue false
      end
      
      # GET /hamburguesa
      def index
        @hamburgers = Hamburger.all
        render json: @hamburgers, :except => [:created_at, :updated_at], status:200
      end

      # GET /hamburguesa/:id
      def show
        if is_numeric(params[:id])
          @hamburger = Hamburger.find(params[:id].to_i)
          if @hamburger
            render json: @hamburger, :except => [:created_at, :updated_at], status: 200
          else
            render json: { error: 'Hamburguesa inexistente'}, status: 404
          end
        else
          render json: { error: 'Id inválido'}, status: 400
        end
      end

      # POST /hamburguesas
      def create
        if hamburger_params.key?("nombre") && hamburger_params.key?("precio") && hamburger_params.key?("descripcion") && hamburger_params.key?("imagen")
          if hamburger_params["nombre"]!= "" && hamburger_params["descripcion"]!= "" && hamburger_params["precio"]> 0 && hamburger_params["imagen"]!= ""
            if hamburger_params.key?("ingredientes")
              render json: { error: 'Input inválido. Los ingredientes son agregados después'}, status: 400
            else
              @hamburger = Hamburger.new(hamburger_params)
              @hamburger.save
              render json: @hamburger, :except => [:created_at, :updated_at], status: 201
            end
          else
            render json: { error: 'Input inválido. Debe ingresar valores válidos para el nombre, la descripción, el precio y la url de una imagen'}, status: 400
          end
        else
          render json: { error: 'Input inválido. Debe llenar todos los campos'}, status: 400
        end
      end

      # PUT /hamburguesa/:id_hamburguesa/ingrediente/:id_ingrediente
      # Agrega el ingrediente
      def add_ingredient
        path = "https://tarea-2-taller-integracion.herokuapp.com/api/v1/"
        # Buscamos si la hamburguesa existe. Si es así, entonces pasamos a buscar el ingrediente.
        # Si no, rechazamos la operación
        @hamburger = Hamburger.find(params[:id_hamburguesa])
        if @hamburger
          # Buscamos que el ingrediente exista. Si es así, entonces podemos continuar
          # Si no, entonces rechazamos la operación
          @ingredient = Ingredient.find(params[:id_ingrediente])
          if @ingredient
            # Buscamos si la hamburguesa ya tiene el ingrediente
            # Si lo tiene, entonces no hacemos nada
            # Si no, lo agregamos
            @relation = HamburgersIngredient.find_by(hamburger_id: @hamburger["id"], ingredient_id: @ingredient["id"])
            if @relation
              render json: { message: 'La hamburguesa ya tiene el ingrediente'}, status: 200
            else
              @hamburger["ingredientes"].push({"path" => path + "ingrediente/" + params[:id_ingrediente].to_s})
              @hamburger.save
              HamburgersIngredient.create({hamburger_id: @hamburger["id"], ingredient_id: @ingredient["id"]})
              render json: { message: 'Ingrediente agregado'}, status: 201
            end
          else
            render json: { error: 'Ingrediente inexistente'}, status: 404
          end
        else
          render json: { error: '	Id de hamburguesa inválido'}, status: 400
        end
      end

      # PATCH /hamburguesa/:id
      def edit_hamburger
        @hamburger = Hamburger.find(params[:id])
        if @hamburger
          if hamburger_params_edit.key?("id") || hamburger_params_edit.key?("ingredientes")
            render json: { error: 'Parámetros inválidos'}, status: 400
          else
            @hamburger.update(hamburger_params_edit)
            render json: { message: 'Hamburguesa actualizada'}, status: 200
          end
        else
          render json: { error: 'Hamburguesa inexistente'}, status: 404
        end
      end

      # DELETE /hamburguesa/:id
      def destroy
        @hamburger=Hamburger.find(params[:id])
        if @hamburger
          @hamburger.destroy
          render json: { message: 'Hamburguesa eliminada con éxito'}, status: 200
        else
          render json: { error: 'Hamburguesa inexistente'}, status: 400
        end
      end

      # DELETE /hamburguesa/:id_hamburguesa/ingrediente/:id_ingrediente
      # Elimina el ingrediente
      def delete_ingredient
        # Buscamos si la hamburguesa existe. Si es así, entonces pasamos a buscar el ingrediente.
        # Si no, rechazamos la operación
        @hamburger = Hamburger.find(params[:id_hamburguesa])
        if @hamburger
          # Buscamos que el ingrediente esté en la hamburguesa. Si es así, entonces podemos continuar
          # Si no, entonces rechazamos la operación
          @ingredient = Ingredient.find(params[:id_ingrediente])
          if @ingredient
            # Buscamos si la hamburguesa ya tiene el ingrediente
            # Si lo tiene, entonces lo eliminamos
            # Si no lo tiene, entonces arrojamos el error 404
            @relation = HamburgersIngredient.find_by(hamburger_id: @hamburger["id"], ingredient_id: @ingredient["id"])
            if @relation
              HamburgersIngredient.where(hamburger_id: @hamburger["id"], ingredient_id: @ingredient["id"]).delete_all
              @hamburger["ingredientes"].delete(params[:id_ingrediente].to_i)
              @hamburger.save
              render json: { message: 'ingrediente retirado'}, status: 200
            else
              render json: { message: 'Ingrediente inexistente en la hamburguesa'}, status: 404
            end
          else
            render json: { error: 'Ingrediente inexistente'}, status: 404
          end
        else
          render json: { error: '	Id de hamburguesa inválido'}, status: 400
        end
      end

      private
      def hamburger_params
        params.require(:hamburger).permit(:nombre, :descripcion, :precio, :imagen,:ingredientes => [])
      end
      def hamburger_params_put
        params..require(:hamburger).permit(:hamburguesaId, :ingredienteId)
      end
    end
  end
end