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

> 在 GitHub Pages 上新增的紀錄會存在瀏覽器（localStorage）。要永久更新網站資料，請用「備份 / 匯入」複製 JSON，替換 `index.html` 內 `<script id="state">` 的內容後提交。

地圖資料：[taiwan-atlas](https://github.com/dkaoster/taiwan-atlas)（政府資料開放授權）
