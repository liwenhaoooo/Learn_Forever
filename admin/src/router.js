import Vue from "vue"
import Router from "vue-router"
import Login from "./views/login.vue"
import Admin from "./views/admin.vue"
import Welcome from "./views/admin/welcome.vue"
import Category from "./views/admin/category.vue"
import Course from "./views/admin/course.vue"
import Chapter from "./views/admin/chapter.vue"
import Section from "./views/admin/section.vue"


Vue.use(Router);

export default new Router({
  mode:"history",
  base:process.env.BASE_URL,
  routes: [{
    path:"*",
    redirect:"/login"
  },{
    path:"/login",
    component:Login
  },{
    path: "/",
    name: "admin",
    component:Admin,
    children:[{
      name: "welcome",
      path: "welcome",
      component:Welcome,
    },{
      name: "business/category",
      path: "business/category",
      component:Category,
    },{
      name: "business/course",
      path: "business/course",
      component:Course,
    },{
      name: "business/chapter",
      path: "business/chapter",
      component:Chapter,
    },{
      name: "business/section",
      path: "business/section",
      component:Section,
    },]
  },
  ]

})