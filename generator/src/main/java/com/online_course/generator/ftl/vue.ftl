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
      <div class="card-body table-responsive p-0">
        <table class="table table-hover text-nowrap">
          <thead>
          <tr>
            <#list fieldList as field>
              <#if field.nameHump!="createdAt" && field.nameHump!="updatedAt">
                <th>${field.nameCn}</th>
              </#if>
            </#list>
            <th>Operation</th>
          </tr>
          </thead>

          <tbody>
          <tr v-for="${domain} in ${domain}s">
            <#list fieldList as field>
              <#if field.nameHump!="createdAt" && field.nameHump!="updatedAt">
                <#if field.enums>
                  <td>{{${field.enumsConst} | optionKV(${domain}.${field.nameHump})}}</td>
                <#else>
                  <td>{{${domain}.${field.nameHump}}}</td>
                </#if>
              </#if>
            </#list>
          <td>
            <div>
              <button v-on:click="edit(${domain})" type="button" class="btn btn btn-warning"><i class="fa-solid fa-pen-to-square"></i></button>
              &nbsp;
              <button v-on:click="del(${domain}.id)" type="button" class="btn btn btn-danger"><i class="fa-regular fa-trash-can"></i></button>
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
            <h4 class="modal-title">Form</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
            <form class="form-horizontal">
              <#list fieldList as field>
                <#if field.name!="id" && field.nameHump!="createdAt" && field.nameHump!="updatedAt">
                  <#if field.enums>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">${field.nameCn}</label>
                      <div class="col-sm-10">
                        <select v-model="${domain}.${field.nameHump}" class="form-control">
                          <option v-for="o in ${field.enumsConst}" v-bind:value="o.key">{{o.value}}</option>
                        </select>
                      </div>
                    </div>
                  <#else>
                    <div class="form-group">
                      <label class="col-sm-2 control-label">${field.nameCn}</label>
                      <div class="col-sm-10">
                        <input v-model="${domain}.${field.nameHump}" class="form-control">
                      </div>
                    </div>
                  </#if>
                </#if>
              </#list>
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
  name: "${module}-${domain}",
  data: function (){
    return {
      ${domain}: {},
      ${domain}s: [],
      <#list fieldList as field>
      <#if field.enums>
      ${field.enumsConst}: ${field.enumsConst},
      </#if>
      </#list>
    }
  },
  mounted: function() {
    let _this = this;
    _this.$refs.pagination.size = 10;
    _this.list(1);

  },
  methods:{
    /**
     * ??????????????????
     */
    add() {
      let _this = this;
      _this.${domain} = {};
      $("#form-modal").modal("show");
    },
    /**
     * ??????????????????
     */
    edit(${domain}) {
      let _this = this;
      _this.${domain} = $.extend({}, ${domain});
      $("#form-modal").modal("show");
    },
    /**
     * ????????????
     */
    list(page) {
      let _this = this;
      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/${module}/admin/${domain}/list',{
        page:page,
        size:_this.$refs.pagination.size,
      }).then((response)=>{
        Loading.hide();
        let resp = response.data;
        _this.${domain}s = resp.content.list;
        _this.$refs.pagination.render(page, resp.content.total);
      })
    },
    /**
     * ??????????????????
     */
    save() {
      let _this = this;

      // ????????????
      if (1 != 1
              <#list fieldList as field>
              <#if field.name!="id" && field.nameHump!="createdAt" && field.nameHump!="updatedAt" && field.nameHump!="sort">
              <#if !field.nullAble>
              || !Validator.require(_this.${domain}.${field.nameHump}, "${field.nameCn}")
              </#if>
              <#if (field.length > 0)>
              || !Validator.length(_this.${domain}.${field.nameHump}, "${field.nameCn}", 1,${field.length?c})
              </#if>
              </#if>
              </#list>
      ) {
        return;
      }

      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/${module}/admin/${domain}/save', _this.${domain}).then((response)=>{
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
     * ??????????????????
     */
    del(id) {
      let _this = this;
      Confirm.show("After deletion, it cannot be recovered. Confirm deletion?", function () {
        Loading.show();
        _this.$ajax.delete(process.env.VUE_APP_SERVER + '/${module}/admin/${domain}/delete/' + id).then((response)=>{
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
