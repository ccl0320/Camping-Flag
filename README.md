# 露營足跡 · Camping Log

用台灣 3D 地圖記錄露營足跡：每個露營區、第幾露、預訂中的行程與露營月曆。

## 功能
- Three.js 3D 台灣地圖（縮放／旋轉／平移），露過的縣市會長高變綠
- 自動或手動編號「第幾露」，支援「不計露數」紀錄
- 計畫中／已預訂行程、下一露倒數、露營月曆
- 時間軸、露營區、縣市統計、年份篩選
- 備份／匯入 JSON

## 使用
直接打開 `index.html`，或啟用 GitHub Pages（Settings → Pages → Branch: `main` / root）。

## Supabase 雲端同步
1. 在 [Supabase](https://supabase.com) 建立專案，到 **SQL Editor** 執行 [`supabase/schema.sql`](supabase/schema.sql)。
2. **Authentication → Users → Add user** 建立自己的帳號（Email + 密碼）。
3. **Project Settings → API** 複製 `Project URL` 與 `anon public` key。
4. 打開網站右上角 **☁️ 雲端** → 貼上 URL 與 key → 登入 → 「把目前資料上傳到雲端」。
5. 之後在任何裝置登入，新增/修改都會自動同步；未登入的訪客只能讀取。

> 想讓訪客不用設定就讀到雲端資料：把 `index.html` 裡 `SUPA_DEFAULT` 的 `url`、`key` 填上（anon key 本來就是公開金鑰，安全靠 RLS 保護）。

地圖資料：[taiwan-atlas](https://github.com/dkaoster/taiwan-atlas)（政府資料開放授權）


## 多使用者帳號（v2）

- 任何人都可以用 Email 註冊，登入後只會看到、也只能修改自己的紀錄（資料表 `camping_logs`，每位使用者一列，RLS 保護）。
- 沒登入也能先試用，紀錄暫存在瀏覽器；註冊後會自動帶進帳號。
- 在「我的帳號」打開「公開我的露營足跡」，就能把 `?u=<使用者 ID>` 的連結分享給朋友（唯讀）。
- Supabase 後台需要設定：Authentication → URL Configuration，把網站網址加進 Redirect URLs（例如 `https://camping-flag.pages.dev/**`），確認信與重設密碼信才會導回本站。
