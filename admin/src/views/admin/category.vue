<template>
  <div>
    <div class="row">
      <div class="col-md-6">
        <div class="card">
          <div class="card-header">
            <tr>
              <td>
                <button v-on:click="add1()" type="button" class="btn btn-block bg-gradient-info"><i class="fa-solid fa-plus">新增一级</i></button>&emsp;
              </td>
              &nbsp;
              <td>
                <button v-on:click="all()" type="button" class="btn btn-block bg-gradient-success"><i class="fa-solid fa-arrow-rotate-left"></i></button>
              </td>
            </tr>
          </div>
          <!-- /.card-header -->
          <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
              <thead>
              <tr>
                <th>id</th>
                <th>名称</th>
                <th>顺序</th>
                <th>Operation</th>
              </tr>
              </thead>

              <tbody>
              <tr v-for="category in level1" v-on:click="onClickLevel1(category)" v-bind:class="{'active' : category.id === active.id}">
                <td>{{category.id}}</td>
                <td>{{category.name}}</td>
                <td>{{category.sort}}</td>
                <td>
                  <div>
                    <button v-on:click="edit(category)" type="button" class="btn btn btn-warning"><i class="fa-solid fa-pen-to-square"></i></button>
                    &nbsp;
                    <button v-on:click="del(category.id)" type="button" class="btn btn btn-danger"><i class="fa-regular fa-trash-can"></i></button>
                  </div>
                </td>
              </tr>
              </tbody>
            </table>

          </div>
          <!-- /.card-body -->
        </div>
      </div>
      <div class="col-md-6">
        <div class="card">
          <div class="card-header">
            <tr>
              <td>
                <button v-on:click="add2()" type="button" class="btn btn-block bg-gradient-info"><i class="fa-solid fa-plus">新增二级</i></button>&emsp;
              </td>
              &nbsp;
              <td>
                <button v-on:click="all()" type="button" class="btn btn-block bg-gradient-success"><i class="fa-solid fa-arrow-rotate-left"></i></button>
              </td>
            </tr>
          </div>
          <!-- /.card-header -->
          <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
              <thead>
              <tr>
                <th>id</th>
                <th>名称</th>
                <th>顺序</th>
                <th>Operation</th>
              </tr>
              </thead>

              <tbody>
              <tr v-for="category in level2">
                <td>{{category.id}}</td>
                <td>{{category.name}}</td>
                <td>{{category.sort}}</td>
                <td>
                  <div>
                    <button v-on:click="edit(category)" type="button" class="btn btn btn-warning"><i class="fa-solid fa-pen-to-square"></i></button>
                    &nbsp;
                    <button v-on:click="del(category.id)" type="button" class="btn btn btn-danger"><i class="fa-regular fa-trash-can"></i></button>
                  </div>
                </td>
              </tr>
              </tbody>
            </table>

          </div>
          <!-- /.card-body -->
        </div>
      </div>
    </div>
    <!-- /.card -->

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
                      <label class="col-sm-2 control-label">父分类</label>
                      <div class="col-sm-10">
                        <p class="form-control-static">{{active.name || "无"}}</p>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">名称</label>
                      <div class="col-sm-10">
                        <input v-model="category.name" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">顺序</label>
                      <div class="col-sm-10">
                        <input v-model="category.sort" class="form-control">
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
export default {
  name: "business-category",
  data: function (){
    return {
      category: {},
      categorys: [],
      level1: [],
      level2: [],
      active: {},
    }
  },
  mounted: function() {
    let _this = this;
    _this.all();

  },
  methods: {
    /**
     * 点击【新增一级】
     */
    add1() {
      let _this = this;
      _this.active = {};
      _this.level2 = [];
      _this.category = {
        parent: "00000000"
      };
      $("#form-modal").modal("show");
    },

    /**
     * 点击【新增二级】
     */
    add2() {
      let _this = this;
      if (Tool.isEmpty(_this.active)) {
        Toast.warning("请先点击一级分类");
        return;
      }
      _this.category = {
        parent: _this.active.id
      };
      $(".modal").modal("show");
    },
    /**
     * 点击【编辑】
     */
    edit(category) {
      let _this = this;
      _this.category = $.extend({}, category);
      $("#form-modal").modal("show");
    },
    /**
     * 列表查询
     */
    all() {
      let _this = this;
      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/category/all').then((response)=>{
        Loading.hide();
        let resp = response.data;
        _this.categorys = resp.content;
        //将所有记录格式化成树形结构
        // 将所有记录格式化成树形结构
        _this.level1 = [];
        for (let i = 0; i < _this.categorys.length; i++) {
          let c = _this.categorys[i];
          if (c.parent === '00000000') {
            _this.level1.push(c);
            for (let j = 0; j < _this.categorys.length; j++) {
              let child = _this.categorys[j];
              if (child.parent === c.id) {
                if (Tool.isEmpty(c.children)) {
                  c.children = [];
                }
                c.children.push(child);
              }
            }
          }
        }
      })
    },
    /**
     * 点击【保存】
     */
    save() {
      let _this = this;

      // 保存校验
      if (1 != 1
              || !Validator.require(_this.category.parent, "父id")
              || !Validator.require(_this.category.name, "名称")
              || !Validator.length(_this.category.name, "名称", 1,50)
      ) {
        return;
      }

      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/category/save', _this.category).then((response)=>{
        Loading.hide();
        let resp = response.data;
        if (resp.success) {
          $("#form-modal").modal("hide");
          _this.all();
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
        _this.$ajax.delete(process.env.VUE_APP_SERVER + '/business/admin/category/delete/' + id).then((response)=>{
          Loading.hide();
          let resp = response.data;
          if (resp.success) {
            _this.all();
            Toast.success("Delete successful !");
          }
        })
      });
    },
    onClickLevel1(category) {
      let _this = this;
      _this.active = category;
      _this.level2 = category.children;
    }

  }
}
</script>
<style scoped>
.active td {
  background-color: #d6e9c6 !important;
}
</style>
