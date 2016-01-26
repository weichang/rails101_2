class PostsController < ApplicationController
    before_action :authenticate_user! , only:[:new,:create,:edit,:update,:destroy]
    before_action :find_group
    before_action :member_required, only: [:new, :create ]
    
    def index
    end
    
    def show
        
    end
    
    def new
        #@group = Group.find(params[:group_id])
        @post = @group.posts.new
    end
    
    def create
        #@group = Group.find(params[:group_id])
        @post = @group.posts.build(post_params)
        
        if @post.save
            
            redirect_to group_path(@group) , notice: "文章新增成功"
            
        else
            render :new
        end
    end
    def edit
       # @group = Group.find(params[:group_id])
        @post = @group.posts.find(params[:id]) 
    end
    
    def update
        #@group = Group.find(params[:group_id])
        @post = @group.posts.find(params[:id]) 
        
        if @post.update(post_params)
            
            redirect_to group_path(@group) , notice: "修改成功"
        else
            render :edit
            
        end
    end
    def destroy
        
       # @group = Group.find(params[:group_id])
        @post = @group.posts.find(params[:id]) 
        @post.destroy
        redirect_to group_path(@group),notice: "文章 #{@post.id} 刪除成功"
    end
    private
    
    def find_group
         @group = Group.find(params[:group_id])
    end
    def post_params
        
        params.require(:post).permit(:content)
        
    end
  
    def member_required
        
        if !current_user.is_member_of?(@group)
             flash[:warning] = "你不是這個討論版的成員，不能發文喔！"
             redirect_to group_path(@group)
        end
        
    end
end
