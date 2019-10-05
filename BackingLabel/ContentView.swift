//
//  ContentView.swift
//  BackingLabel
//
//  Created by muukii on 2019/10/05.
//  Copyright © 2019 muukii. All rights reserved.
//

import SwiftUI

final class MyLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    print("init", self)
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("deinit", self)
  }
  
  override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    
    print(bounds)
    let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
    return rect
  }
    
  override func alignmentRect(forFrame frame: CGRect) -> CGRect {
    let rect = super.alignmentRect(forFrame: frame)
    return rect
  }
  
  override func frame(forAlignmentRect alignmentRect: CGRect) -> CGRect {
    let frame = super.frame(forAlignmentRect: alignmentRect)
    print("frame", frame, alignmentRect)
    return frame
  }

}

struct BackingLabelView: UIViewRepresentable {
  
  class Coordinator {
    var widthConstraint: NSLayoutConstraint?
  }
    
  let text: String
  let maxWidth: CGFloat
  
  func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<BackingLabelView>) {
    print("Update", uiView.intrinsicContentSize)
    uiView.numberOfLines = 0
    uiView.text = text
    context.coordinator.widthConstraint?.constant = maxWidth
  }
  
  func makeUIView(context: UIViewRepresentableContext<BackingLabelView>) -> UILabel {
    
    let label = MyLabel()
    label.font = .boldSystemFont(ofSize: 28)
    let c = label.widthAnchor.constraint(equalToConstant: 0)
    c.isActive = true
    context.coordinator.widthConstraint = c
    
    label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    label.setContentHuggingPriority(.defaultHigh, for: .vertical)
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    
    label.numberOfLines = 0
    label.text = text
    
    return label
    
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator()
  }
  
}

struct Wrapper: View {
  
  let text: String
  
  var body: some View {
    GeometryReader { geometry in
      BackingLabelView(text: self.text, maxWidth: geometry.size.width)
    }
  }
}


struct ContentView: View {
  
  @State var text: String = """
    私は昔いくらその誤解ようとかいうのの時の据えたらます。もし場合から楽ようもしっくりその意味たたかもを解るて来ですには所有聞いだですが、またにはするですますたた。圏外にあるですのはけっして昔をあたかもですないた。
"""
  @State var isOn = false
  
  var body: some View {
    
    VStack {
      TextField("", text: self.$text)
        .background(Color.blue)
      Toggle(isOn: self.$isOn) {
        EmptyView()
      }
      Wrapper(text: text)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    }
}
