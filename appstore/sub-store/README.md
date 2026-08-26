# Sub-Store

Sub-Store 是一个支持 Quantumult X、Loon、Surge、Stash、Egern、Shadowrocket、Clash.Meta 和 sing-box 等格式的订阅管理工具。本应用在同一个容器中提供前端和后端。

## 使用说明

- 应用默认监听容器端口 `3000`，安装时可以修改外部端口。
- 数据保存在应用目录下的 `data` 目录，卸载或升级前请按需备份。
- 访问 `http://服务器地址:端口/` 使用内置前端，API 地址示例为 `http://服务器地址:端口/sub-store/api/`。
- 后端路径必须以 `/` 开头，总长度为 2-64；除开头的 `/` 外支持英文、数字、`.`、`-` 和 `_`，例如 `/sub-store`。
- CORS 默认允许所有来源；如果只使用内置前端，可保持默认值，使用外部前端时再加入对应来源。

## 安全建议

订阅内容可能包含节点地址、凭据和访问令牌。建议使用 HTTPS 反向代理，并将 CORS 白名单改为实际前端来源，不要长期使用 `*`。

项目文档：[Sub-Store Wiki](https://github.com/sub-store-org/Sub-Store/wiki)
