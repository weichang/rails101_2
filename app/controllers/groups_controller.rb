class GroupsController < ApplicationController
    before_action :authenticate_user! , only:[:new,:create,:edit,:update,:destroy]
    def index
        @groups = Group.all
    end
    def show
       @group = Group.find(params[:id])   
       @posts = @group.posts
    end
    
    def new
        @group = current_user.groups.new
    end
    def create
        
        @group = current_user.groups.create(groups_params)
        
        if @group.save
            current_user.join!(@group)
            flash[:notice] = "群組新增成功!!"
            redirect_to groups_path
            
        else
            render :new
        end
        
        
    end
    
    def edit
        @group = current_user.groups.find(params[:id])
    end
    
    def update
        @group = current_user.groups.find(params[:id])
        
        if @group.update(groups_params)
            
            flash[:notice] = '修改成功'
            redirect_to groups_path
        else
            
            render :edit
        end
        
    end
    
    def destroy
        @group = current_user.groups.find(params[:id])
        @group.destroy
        flash[:notice] = "刪除成功"
        redirect_to groups_path
    end
    
    
      def join
       @group = Group.find(params[:id])
    
       if !current_user.is_member_of?(@group)
         current_user.join!(@group)
         flash[:notice] = "加入本討論版成功！"
       else
         flash[:warning] = "你已經是本討論版成員了！"
       end
    
       redirect_to group_path(@group)
     end
    
     def quit
       @group = Group.find(params[:id])
    
       if current_user.is_member_of?(@group)
         current_user.quit!(@group)
         flash[:alert] = "已退出本討論版！"
       else
         flash[:warning] = "你不是本討論版成員，怎麼退出 XD"
       end
    
       redirect_to group_path(@group)
     end
    private 
    
    def groups_params
        params.require(:group).permit(:title,:description)
    end
end
