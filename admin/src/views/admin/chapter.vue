<template>
  <div>
    <div class="card">
      <div class="card-header">
        <h3>
          {{course.name}}
        </h3>
     <tr>
       <td>
         <router-link to="/business/course" type="button" class="btn btn-block bg-gradient-info"><i class="fa-solid fa-arrow-left-long"></i></router-link>&emsp;
       </td>
       &nbsp;
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
      <div class="card-body table-responsive p-0">
        <table class="table table-hover text-nowrap">
          <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>ClassID</th>
            <th>Operation</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="chapter in chapters">
            <td>{{ chapter.id }}</td>
            <td>{{ chapter.name }}</td>
            <td>{{ chapter.courseId }}</td>
            <td>
              <div>
                <button v-on:click="edit(chapter)" type="button" class="btn btn btn-warning"><i class="fa-solid fa-pen-to-square"></i></button>
                &nbsp;
                <button v-on:click="del(chapter.id)" type="button" class="btn btn btn-danger"><i class="fa-regular fa-trash-can"></i></button>
              </div>
           </td>
          </tr>
          </tbody>
        </table>

      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
    <pagination ref="pagination" v-bind:list="list" v-bind:itemCount="10"></pagination>




    <div id="form-modal" class="modal fade" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">Add Chapter</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>

          </div>
          <div class="modal-body">
            <form class="form-horizontal">
              <div class="form-group">
                <label class="col-sm-2 control-label">Name</label>
                <div class="col-sm-10">
                  <input v-model="chapter.name" class="form-control" placeholder="Name">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">Course</label>
                <div class="col-sm-10">
                  <p class="form-control-static">{{course.name}}</p>
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
  name: "business-chapter",
  data: function (){
    return {
      chapter: {},
      chapters :[],
      course: {},
    }
  },
  mounted: function() {
    let _this = this;
    _this.$refs.pagination.size = 10;
    let course = SessionStorage.get("course") || {};
    if (Tool.isEmpty(course)) {
      _this.$router.push("/welcome");
    }
    _this.course = course;
    _this.list(1);

  },
  methods:{
    /**
     * 点击【新增】
     */
    add() {
      let _this = this;
      _this.chapter = {};
      $("#form-modal").modal("show");
    },
    /**
     * 点击【编辑】
     */
    edit(chapter) {
      let _this = this;
      _this.chapter = $.extend({}, chapter);
      $("#form-modal").modal("show");
    },
    /**
     * 列表查询
     */
    list(page) {
      let _this = this;
      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/chapter/list',{
        page:page,
        size:_this.$refs.pagination.size,
        courseId: _this.course.id
      }).then((response)=>{
        Loading.hide();
        let resp = response.data;
        _this.chapters = resp.content.list;
        _this.$refs.pagination.render(page, resp.content.total);
      })
    },
    /**
     * 点击【保存】
     */
    save(page) {
      let _this = this;

      // 保存校验
      if (!Validator.require(_this.chapter.name, "Name")
          || !Validator.length(_this.chapter.courseId, "CourseID", 1, 8)) {
        return;
      }
      _this.chapter.courseId = _this.course.id;

      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/chapter/save', _this.chapter).then((response)=>{
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
        _this.$ajax.delete(process.env.VUE_APP_SERVER + '/business/admin/chapter/delete/' + id).then((response)=>{
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
