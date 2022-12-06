import SwiftUI
// Idea: https://www.framer.com/showcase/project/lo2Qka8jtPXrjzZaPZdB/

// 實作CGPoint相乘運算子
extension CGPoint {
    static func *(lhs: Self, rhs: CGFloat) -> Self {
        .init(x: lhs.x * rhs, y: lhs.y * rhs)
    }
}

// MARK: 實作具有動畫屬性的自訂調整器

struct MoveToModifier: ViewModifier & Animatable {
    var offset: CGFloat = .zero // x軸移動距離，元件從此處插入(消失)
    var maxYOffset: CGFloat = 40 // 半徑，相當於y軸變化最大值
    var progress: CGFloat // 動畫進度
    
    init(offset: CGFloat, active: Bool) {
        self.offset = offset
        self.progress = active ? 1 : 0
    }
    
    // 實作此計算屬性，給予動畫進度的意義
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        // 運用sin函式，帶入半徑與弧度求y軸
        let amount = sin(.pi * progress) * maxYOffset
        // 更新元件位置
        content.offset(x: offset * progress, y: amount)
    }
}
                
struct StarButton: View {
    @State var selected = false
    
    var body: some View {
        // 建立一個自訂轉場，靜止與啟動狀態套用同一個調整器(位置不同)
        let moveTo = AnyTransition.modifier(active: MoveToModifier(offset: 70, active: true), identity: MoveToModifier(offset: 70, active: false))
        // 建立一個自訂轉場，插入時維持在靜止狀態+淡入，移除時套用moveTo+淡出
        let star = AnyTransition.asymmetric(insertion: .identity, removal: moveTo).combined(with: .opacity)
        
        // 建立一個展示元件
        HStack {
            if !selected {
                Image(systemName: "star")
                    .symbolRenderingMode(.multicolor)
                    .symbolVariant(.fill)
                    .transition(star) // 使用自訂的star轉場
            }
            Text(selected ? "Starred" : "Star") // 使用預設的淡進淡出轉場
            Divider()
                .frame(idealHeight: 10)
            Text(selected ? "39" : "38")
                .monospacedDigit()
                .id(selected) // 利用id()來取代if敘述；只要id值改變，就等於新物件出現，會觸發轉場
                .transition(.scale(scale: 0).combined(with: .opacity)) // 使用縮放+淡進淡出轉場
        }
        .frame(width: 100)
        .animation(.default.speed(0.5), value: selected) // 設定selected改變時觸發動畫
        .foregroundColor(.primary)
        .padding()
        .background(
            // 製作一個陰影背景
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(white: 0.87))
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 5, y: 5)
        )
        .contentShape(RoundedRectangle(cornerRadius: 5)) // 定義感應範圍
        .onTapGesture {
            // 點擊時切換狀態，進而觸發動畫轉場
            selected.toggle()
        }
    }
}
