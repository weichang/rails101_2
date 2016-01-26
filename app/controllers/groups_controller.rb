class GroupsController < ApplicationController
    
    def index
        @groups = Group.all
    end
    def show
       @group = Group.find(params[:id])   
       @posts = @group.posts
    end
    
    def new
        @group = Group.new
    end
    def create
        
        @group = Group.create(groups_params)
        
        if @group.save
            
            flash[:notice] = "群組新增成功!!"
            redirect_to groups_path
            
        else
            render :new
        end
        
        
    end
    
    def edit
        @group = Group.find(params[:id])
    end
    
    def update
        @group = Group.find(params[:id])
        
        if @group.update(groups_params)
            
            flash[:notice] = '修改成功'
            redirect_to groups_path
        else
            
            render :edit
        end
        
    end
    
    def destroy
        @group = Group.find(params[:id])
        @group.destroy
        flash[:notice] = "刪除成功"
        redirect_to groups_path
    end
    
    private 
    
    def groups_params
        params.require(:group).permit(:title,:description)
    end
end
