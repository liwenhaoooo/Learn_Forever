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

      <div class="row">
        <div v-for="course in courses" class="col-md-4">
          <!-- Profile Image -->
          <div class="card card-primary card-outline">
            <div class="card-body box-profile">
              <div class="text-center">
                <img v-show="!course.image" class="media-object" src="/static/image/demo-course.jpg">
                <img v-show="course.image" class="media-object" v-bind:src="course.image">
              </div>
              &nbsp;
              <ul class="text-right">
                  <span class="bg-purple color-palette">{{COURSE_LEVEL | optionKV(course.level)}}</span>
           &nbsp; <span class="bg-purple color-palette">{{COURSE_CHARGE | optionKV(course.charge)}}</span>
           &nbsp;<span class="bg-purple color-palette">{{COURSE_STATUS | optionKV(course.status)}}</span>
              </ul>
              <div>
                <h3 class="search-title">
                  <a href="#" class="blue">{{course.name}}</a>
                </h3>
                <h3>
                  <span class="blue bolder bigger-150">{{course.price}}&nbsp;￡</span>
                </h3>
                <p>{{course.summary}}</p>
                <p>
                  <span class="badge badge-info">{{course.id}}</span>
                  <span class="badge badge-info">排序：{{course.sort}}</span>
                  <span class="badge badge-info">时长：{{course.time}}</span>
                </p>
                <a>
                  <div>
                    <button v-on:click="edit(course)" type="button" class="btn btn btn-warning">&nbsp;Edit&nbsp;</button>
                    &nbsp;
                    <button v-on:click="del(course.id)" type="button" class="btn btn btn-danger">Delete</button>
                  </div>
                </a>
              </div>

            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
      </div>


      <!-- /.card-header -->
<!--      <div class="card-body table-responsive p-0">-->
<!--        <table class="table table-hover text-nowrap">-->
<!--          <thead>-->
<!--          <tr>-->
<!--                <th>id</th>-->
<!--                <th>名称</th>-->
<!--                <th>概述</th>-->
<!--                <th>时长</th>-->
<!--                <th>价格（元）</th>-->
<!--                <th>封面</th>-->
<!--                <th>级别</th>-->
<!--                <th>收费</th>-->
<!--                <th>状态</th>-->
<!--                <th>报名数</th>-->
<!--                <th>顺序</th>-->
<!--            <th>Operation</th>-->
<!--          </tr>-->
<!--          </thead>-->

<!--          <tbody>-->
<!--          <tr v-for="course in courses">-->
<!--                  <td>{{course.id}}</td>-->
<!--                  <td>{{course.name}}</td>-->
<!--                  <td>{{course.summary}}</td>-->
<!--                  <td>{{course.time}}</td>-->
<!--                  <td>{{course.price}}</td>-->
<!--                  <td>{{course.image}}</td>-->
<!--                  <td>{{COURSE_LEVEL | optionKV(course.level)}}</td>-->
<!--                  <td>{{COURSE_CHARGE | optionKV(course.charge)}}</td>-->
<!--                  <td>{{COURSE_STATUS | optionKV(course.status)}}</td>-->
<!--                  <td>{{course.enroll}}</td>-->
<!--                  <td>{{course.sort}}</td>-->
<!--          <td>-->
<!--            <div>-->
<!--              <button v-on:click="edit(course)" type="button" class="btn btn btn-warning">&nbsp;Edit&nbsp;</button>-->
<!--              &nbsp;-->
<!--              <button v-on:click="del(course.id)" type="button" class="btn btn btn-danger">Delete</button>-->
<!--            </div>-->
<!--          </td>-->
<!--          </tr>-->
<!--          </tbody>-->
<!--        </table>-->

<!--      </div>-->
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
    <pagination ref="pagination" v-bind:list="list" v-bind:itemCount="10"></pagination>

    <div id="form-modal" class="modal fade" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">Add 课程</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
            <form class="form-horizontal">
                    <div class="form-group">
                      <label class="col-sm-2 control-label">名称</label>
                      <div class="col-sm-10">
                        <input v-model="course.name" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">概述</label>
                      <div class="col-sm-10">
                        <input v-model="course.summary" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">时长</label>
                      <div class="col-sm-10">
                        <input v-model="course.time" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">价格（元）</label>
                      <div class="col-sm-10">
                        <input v-model="course.price" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">封面</label>
                      <div class="col-sm-10">
                        <input v-model="course.image" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">级别</label>
                      <div class="col-sm-10">
                        <select v-model="course.level" class="form-control">
                          <option v-for="o in COURSE_LEVEL" v-bind:value="o.key">{{o.value}}</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">收费</label>
                      <div class="col-sm-10">
                        <select v-model="course.charge" class="form-control">
                          <option v-for="o in COURSE_CHARGE" v-bind:value="o.key">{{o.value}}</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">状态</label>
                      <div class="col-sm-10">
                        <select v-model="course.status" class="form-control">
                          <option v-for="o in COURSE_STATUS" v-bind:value="o.key">{{o.value}}</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">报名数</label>
                      <div class="col-sm-10">
                        <input v-model="course.enroll" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">顺序</label>
                      <div class="col-sm-10">
                        <input v-model="course.sort" class="form-control">
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
  name: "business-course",
  data: function (){
    return {
      course: {},
      courses: [],
      COURSE_LEVEL: COURSE_LEVEL,
      COURSE_CHARGE: COURSE_CHARGE,
      COURSE_STATUS: COURSE_STATUS,
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
      _this.course = {};
      $("#form-modal").modal("show");
    },
    /**
     * 点击【编辑】
     */
    edit(course) {
      let _this = this;
      _this.course = $.extend({}, course);
      $("#form-modal").modal("show");
    },
    /**
     * 列表查询
     */
    list(page) {
      let _this = this;
      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/course/list',{
        page:page,
        size:_this.$refs.pagination.size,
      }).then((response)=>{
        Loading.hide();
        let resp = response.data;
        _this.courses = resp.content.list;
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
              || !Validator.require(_this.course.name, "名称")
              || !Validator.length(_this.course.name, "名称", 1,50)
              || !Validator.length(_this.course.summary, "概述", 1,2000)
              || !Validator.length(_this.course.image, "封面", 1,100)
      ) {
        return;
      }

      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/course/save', _this.course).then((response)=>{
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
        _this.$ajax.delete(process.env.VUE_APP_SERVER + '/business/admin/course/delete/' + id).then((response)=>{
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
