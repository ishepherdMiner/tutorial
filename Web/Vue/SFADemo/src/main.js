import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
// 每个 Vue 应用都是通过 createApp 函数创建一个新的 应用实例
const app = createApp(App)

app.use(router)

app.mount('#app')
