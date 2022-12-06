# StarButton
---
> 建立自訂轉場，與嘗試組合多種轉場

## 實作細節
  1. 實作具有動畫屬性的調整器
   - 實作animatableData，綁定動畫進度
   - 實作body(content:)，根據動畫進度改變位置
   - x軸位移:offset * 進度
   - y軸位移:利用sin函式，帶入弧度與半徑求y
  2. 建立一個展示元件
   - 星星為 .modifier(active:identity) + .asymmetric(insertion:removal:) + .combined(with:)
     * insertion: identity + 淡進
     * removal: active + 淡出 
   - 文字為預設淡進淡出
   - 數字轉場為縮放 + 淡進淡出

![展示畫面](./starButton_gif.gif "展示畫面")