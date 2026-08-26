# Sub-Store

Sub-Store 是一个支持 Quantumult X、Loon、Surge、Stash、Egern、Shadowrocket、Clash.Meta 和 sing-box 等格式的订阅管理后端。

## 使用说明

- 应用默认监听容器端口 `3000`，安装时可以修改外部端口。
- 数据保存在应用目录下的 `data` 目录，卸载或升级前请按需备份。
- 如果通过官方前端 `https://sub-store.vercel.app/` 使用，请将“后端路径”配置为 `/sub-store`，并在 CORS 白名单中加入前端来源；不确定时可暂用 `*`。
- 后端路径启用后，API 地址示例为 `http://服务器地址:端口/sub-store/api/`。
- 后端路径必须以 `/` 开头，总长度为 2-64；除开头的 `/` 外支持英文、数字、`.`、`-` 和 `_`，例如 `/sub-store`。

## 安全建议

订阅内容可能包含节点地址、凭据和访问令牌。建议使用 HTTPS 反向代理，并将 CORS 白名单改为实际前端来源，不要长期使用 `*`。

项目文档：[Sub-Store Wiki](https://github.com/sub-store-org/Sub-Store/wiki)
