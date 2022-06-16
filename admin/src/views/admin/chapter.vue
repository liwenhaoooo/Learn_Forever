<template>
  <div>

    <div class="card">

      <div class="card-header">
        <td>
          <button v-on:click="list()" type="button" class="btn btn-block bg-gradient-success">Refresh</button>
        </td>
<!--        <div class="card-tools">-->
<!--          <div class="input-group input-group-sm" style="width: 150px;">-->
<!--            <input type="text" name="table_search" class="form-control float-right" placeholder="Search">-->

<!--            <div class="input-group-append">-->
<!--              <button type="submit" class="btn btn-default">-->
<!--                <i class="fas fa-search"></i>-->
<!--              </button>-->
<!--            </div>-->
<!--          </div>-->
<!--        </div>-->
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
            <td>... ... ... ... </td>
          </tr>
          </tbody>
        </table>
      </div>
      <!-- /.card-body -->
    </div>
    <!-- /.card -->
  </div>

</template>

<script>
export default {
  name: "chapter",
  data: function (){
    return {
      chapters :[]
    }
  },
  mounted: function() {
    let _this = this;
    _this.list();

  },
  methods:{
    list() {
      let _this = this;
      _this.$ajax.post('http://127.0.0.1:10000/business/admin/chapter/list',{
        page:1,
        size:1
      }).then((response)=>{
        console.log("查询大章列表结果：", response);
        _this.chapters = response.data.list;
      })
    }
  },
}
</script>
