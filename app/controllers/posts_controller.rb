class PostsController < ApplicationController
    
    def index
    end
    
    def show
        
    end
    
    def new
        @group = Group.find(params[:group_id])
        @post = @group.posts.new
    end
    
    def create
        @group = Group.find(params[:group_id])
        @post = @group.posts.build(post_params)
        
        if @post.save
            
            redirect_to group_path(@group) , notice: "文章新增成功"
            
        else
            render :new
        end
    end
    def edit
        @group = Group.find(params[:group_id])
        @post = @group.posts.find(params[:id]) 
    end
    
    def update
        @group = Group.find(params[:group_id])
        @post = @group.posts.find(params[:id]) 
        
        if @post.update(post_params)
            
            redirect_to group_path(@group) , notice: "修改成功"
        else
            render :edit
            
        end
    end
    def destroy
        
        @group = Group.find(params[:group_id])
        @post = @group.posts.find(params[:id]) 
        @post.destroy
        redirect_to group_path(@group),notice: "文章 #{@post.id} 刪除成功"
    end
    private
    
    def post_params
        
        params.require(:post).permit(:content)
        
    end
end