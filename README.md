# **심플한 투두**

<img src="https://velog.velcdn.com/images/rytak108/post/3d4944f8-ee3b-4ca9-ad7a-a34a1fd8a704/image.png">

## **📲 앱 소개**
### 오늘의 날씨, 디데이, 할 일 목록을 각각의 색상과 함께 깔끔하게 보여주는 앱
- 할 일 목록 (리스트, 그리드 형식)
- 디데이, 기념일
- 날씨와 현재, 최고, 최저 기온
- 위젯


<a href="https://apps.apple.com/kr/app/%EC%8B%AC%ED%94%8C%ED%95%9C-%ED%88%AC%EB%91%90/id1663704834" target="_blank"><img src="https://developer.apple.com/news/images/download-on-the-app-store-badge.png" width="150px" /></a>  

## **🗓️ 개발기간**
### 2022.12.31 ~ 2023.01.10 (10일)  

---
## **🛠️ Framwork & Tech Stack**
- ### ```MVC```, ```MVVM```
- ### ```SwiftUI```, ```Core Location```, ```Core Data```, ```WedgetKit```
- ### ```Combine```, ```Alamofire```, ```Moya```, ```PopupView```

---
## **🔴 Trouble Shooting**

### 1. 디데이 계산

- 날짜를 가져와서 디데이를 인드형 인터벌로 변환하여 계산하고 값에 따라 문자열로 리턴
```swift
func calculateDate(date: Date) -> String {
    let interval = Date().timeIntervalSince(date)
    let days = Int(floor(interval / 86400))
    
    if days > 0 {
        return "D+\(days)"
    } else if days < 0 {
        return "D\(days)"
    } else {
        return "D-DAY"
    }
}
```
###  2. 완료하지 않은 할 일만 필터링, 날짜 정렬
- NSpredicate를 이용하여 필터링 후 패치, sortDescriptors를 이용하여 Todo.date 정렬
```swift
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.date, ascending: true)],
        predicate: NSPredicate(format: "done == NO"),
        animation: .default) private var todoList: FetchedResults<Todo>
```
###  3. 위젯에 CoreData 연동
- AppGroups 사용, NSCustomPersistentController 사용
```swift
public enum AppGroup: String {
  case facts = "group.com.ryuyeon.SimpleTodo"

  public var containerURL: URL {
    switch self {
    case .facts:
      return FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: self.rawValue)!
    }
  }
}
```
```swift 
class NSCustomPersistentController: NSPersistentCloudKitContainer {
    
    override class func defaultDirectoryURL() -> URL {
        let storeURL = AppGroup.facts.containerURL.appendingPathComponent("Item.sqlite")
        return storeURL
    }
}
// PersistenceController container를 NSCustomPersistentController로 변경
```

###  4. 위젯 데이터 갱신
- 데이터가 변환되는 곳에서 위젯 갱신 호출
```swift
WidgetCenter.shared.reloadAllTimelines()
```
---

## **🤔 회고**
- SwiftUI를 처음 공부해보면서 앱을 만들어봤는데 레이아웃을 구성하는 방법이 아직 완벽하지 않아 아쉬웠고 SwiftUI의 장점이라고 생각한는 애니메이션 기능들을 많이 사용하지 않아 추후 업데이트에서 구현할 예정이다.
- 체크박스에 해당되는 이미지나 디데이에서도 이미지를 넣어 사용자가 커스텀할 수 있도록 기능을 만들어보면 어떨까 하는 생각이 있다. 어떤 방식으로 사용자 경험을 더 개선시킬 수 있을지에 대해 고민이 필요하다.
- 상단에 날씨와 디데이를 포함한 ```CoverView```가 사용자가 위치권한을 허용하지 않거나 네트워크 연결되어 있지않은 상태에서 날씨 정보를 받아 오지 못해 ```EmptyView```로 표현되는데 인디케이터나 얼럿을 통해 표시하는 방향으로 업데이트를생각하고 있다.
- 홈 화면 위젯, 다국어 지원, 푸시 알림도 업데이트 해보면 좋을것같다.