<template>
  <div>
    <div class="card">
      <div class="card-header">
        <tr>
          <td>
            <button v-on:click="add()" type="button" class="btn btn-block bg-gradient-info">&nbsp;&nbsp;Add&nbsp;&nbsp;</button>&emsp;
          </td>
          &nbsp;
          <td>
            <button v-on:click="list(1)" type="button" class="btn btn-block bg-gradient-success">Refresh</button>
          </td>
        </tr>
      </div>
      <!-- /.card-header -->
      <div class="card-body table-responsive p-0">
        <table class="table table-hover text-nowrap">
          <thead>
          <tr>
               <th>ID</th>
                <th>标题</th>
                <th>课程</th>
                <th>大章</th>
                <th>视频</th>
                <th>时长</th>
                <th>Tariff</th>
                <th>顺序</th>
            <th>Operation</th>
          </tr>
          </thead>

          <tbody>
          <tr v-for="section in sections">
            <td>{{section.id}}</td>
            <td>{{section.title}}</td>
            <td>{{section.courseId}}</td>
            <td>{{section.chapterId}}</td>
            <td>{{section.video}}</td>
            <td>{{section.time}}</td>
            <td>{{SECTION_CHARGE | optionKV(section.charge)}}</td>
            <td>{{section.sort}}</td>
          <td>
            <div>
              <button v-on:click="edit(section)" type="button" class="btn btn btn-warning">&nbsp;Edit&nbsp;</button>
              &nbsp;
              <button v-on:click="del(section.id)" type="button" class="btn btn btn-danger">Delete</button>
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
            <h4 class="modal-title">Add 小节</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
            <form class="form-horizontal">
              <div class="form-group">
                <label class="col-sm-2 control-label">标题</label>
                <div class="col-sm-10">
                  <input v-model="section.title" class="form-control" placeholder="标题">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">课程</label>
                <div class="col-sm-10">
                  <input v-model="section.courseId" class="form-control" placeholder="课程">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">大章</label>
                <div class="col-sm-10">
                  <input v-model="section.chapterId" class="form-control" placeholder="大章">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">视频</label>
                <div class="col-sm-10">
                  <input v-model="section.video" class="form-control" placeholder="视频">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">时长</label>
                <div class="col-sm-10">
                  <input v-model="section.time" class="form-control" placeholder="时长">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">Tariff</label>
                <div class="col-sm-10">
                  <select v-model="section.charge" class="form-control">
                    <option v-for="o in SECTION_CHARGE" v-bind:value="o.key">{{o.value}}</option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">顺序</label>
                <div class="col-sm-10">
                  <input v-model="section.sort" class="form-control" placeholder="顺序">
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
  name: "section",
  data: function (){
    return {
      section: {},
      sections: [],
      SECTION_CHARGE: SECTION_CHARGE,
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
      _this.section = {};
      $("#form-modal").modal("show");
    },
    /**
     * 点击【编辑】
     */
    edit(section) {
      let _this = this;
      _this.section = $.extend({}, section);
      $("#form-modal").modal("show");
    },
    /**
     * 列表查询
     */
    list(page) {
      let _this = this;
      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/section/list',{
        page:page,
        size:_this.$refs.pagination.size,
      }).then((response)=>{
        Loading.hide();
        let resp = response.data;
        _this.sections = resp.content.list;
        _this.$refs.pagination.render(page, resp.content.total);
      })
    },
    /**
     * 点击【保存】
     */
    save(page) {
      let _this = this;

      // 保存校验
      if (1 != 1
              || !Validator.require(_this.section.title, "标题")
              || !Validator.length(_this.section.title, "标题", 1, 50)
              || !Validator.length(_this.section.video, "视频", 1, 200)
      ) {
        return;
      }

      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/section/save', _this.section).then((response)=>{
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
        _this.$ajax.delete(process.env.VUE_APP_SERVER + '/business/admin/section/delete/' + id).then((response)=>{
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
