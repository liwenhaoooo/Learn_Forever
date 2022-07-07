<template>
  <div>
    <div class="card">
      <div class="card-header">
        <tr>
          <td>
            <button v-on:click="add()" type="button" class="btn btn-block bg-gradient-info"><i class="fa-solid fa-plus"></i></button>&emsp;
          </td>
          &nbsp;
          <td>
            <button v-on:click="list(1)" type="button" class="btn btn-block bg-gradient-success"><i class="fa-solid fa-arrow-rotate-left"></i></button>
          </td>
        </tr>
      </div>
      <!-- /.card-header -->
      <div class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column">
        <div v-for="teacher in teachers" class="card bg-light d-flex flex-fill">
          <div class="card-header text-muted border-bottom-0">
            {{teacher.position}}
          </div>
          <div class="card-body pt-0">
            <div class="row">
              <div class="col-7">
                <h2 class="lead"><b>
                  <a href="javascript:;" class="text-info bigger-110" v-bind:title="teacher.motto">
                  <i class="ace-icon fa fa-user"></i>
                  {{teacher.name}}【{{teacher.nickname}}】
                </a></b></h2>
                <p class="text-muted text-sm"><b>About: </b> {{teacher.intro}} </p>
                <ul class="ml-4 mb-0 fa-ul text-muted">
                  <li ><span class="fa-li"><i class="fas fa fa-info"></i></span> {{teacher.motto}}</li>
                </ul>
              </div>
              <div class="col-5 text-center">
                <img v-show="!teacher.image" class="editable img-responsive editable-click editable-empty" src="/static/image/user1-128x128.jpg" v-bind:title="teacher.intro"/>
<!--                <img v-show="teacher.image" class="media-object" v-bind:src="teacher.image" v-bind:title="teacher.intro"/>-->
              </div>
            </div>
          </div>
          <div class="card-footer">
            <div class="text-right">
              <div>
                <button v-on:click="edit(teacher)" type="button" class="btn btn btn-warning"><i class="fa-solid fa-pen-to-square"></i></button>
                &nbsp;
                <button v-on:click="del(teacher.id)" type="button" class="btn btn btn-danger"><i class="fa-regular fa-trash-can"></i></button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
    <pagination ref="pagination" v-bind:list="list" v-bind:itemCount="10"></pagination>

    <div id="form-modal" class="modal fade" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">Form</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
            <form class="form-horizontal">
                    <div class="form-group">
                      <label class="col-sm-2 control-label">姓名</label>
                      <div class="col-sm-10">
                        <input v-model="teacher.name" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">昵称</label>
                      <div class="col-sm-10">
                        <input v-model="teacher.nickname" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">头像</label>
                      <div class="col-sm-10">
                        <input v-model="teacher.image" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">职位</label>
                      <div class="col-sm-10">
                        <input v-model="teacher.position" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">座右铭</label>
                      <div class="col-sm-10">
                        <input v-model="teacher.motto" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">简介</label>
                      <div class="col-sm-10">
                        <input v-model="teacher.intro" class="form-control">
                      </div>
                    </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button v-on:click="save()" type="button" class="btn btn-primary">Save</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
  </div>
</template>
<script>
import Pagination from "../../components/pagination";
export default {
  components: {Pagination},
  name: "business-teacher",
  data: function (){
    return {
      teacher: {},
      teachers: [],
    }
  },
  mounted: function() {
    let _this = this;
    _this.$refs.pagination.size = 10;
    _this.list(1);

  },
  methods:{
    /**
     * 点击【新增】
     */
    add() {
      let _this = this;
      _this.teacher = {};
      $("#form-modal").modal("show");
    },
    /**
     * 点击【编辑】
     */
    edit(teacher) {
      let _this = this;
      _this.teacher = $.extend({}, teacher);
      $("#form-modal").modal("show");
    },
    /**
     * 列表查询
     */
    list(page) {
      let _this = this;
      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/teacher/list',{
        page:page,
        size:_this.$refs.pagination.size,
      }).then((response)=>{
        Loading.hide();
        let resp = response.data;
        _this.teachers = resp.content.list;
        _this.$refs.pagination.render(page, resp.content.total);
      })
    },
    /**
     * 点击【保存】
     */
    save() {
      let _this = this;

      // 保存校验
      if (1 != 1
              || !Validator.require(_this.teacher.name, "姓名")
              || !Validator.length(_this.teacher.name, "姓名", 1,50)
              || !Validator.length(_this.teacher.nickname, "昵称", 1,50)
              || !Validator.length(_this.teacher.image, "头像", 1,100)
              || !Validator.length(_this.teacher.position, "职位", 1,50)
              || !Validator.length(_this.teacher.motto, "座右铭", 1,50)
              || !Validator.length(_this.teacher.intro, "简介", 1,500)
      ) {
        return;
      }

      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/teacher/save', _this.teacher).then((response)=>{
        Loading.hide();
        let resp = response.data;
        if (resp.success) {
          $("#form-modal").modal("hide");
          _this.list(1);
          Toast.success("Saved successful !");
        } else {
          Toast.warning(resp.message)
        }
      })
    },
    /**
     * 点击【删除】
     */
    del(id) {
      let _this = this;
      Confirm.show("After deletion, it cannot be recovered. Confirm deletion?", function () {
        Loading.show();
        _this.$ajax.delete(process.env.VUE_APP_SERVER + '/business/admin/teacher/delete/' + id).then((response)=>{
          Loading.hide();
          let resp = response.data;
          if (resp.success) {
            _this.list(1);
            Toast.success("Delete successful !");
          }
        })
      });

    }
  }
}
</script>
