# BookApp
![설명화면](https://github.com/user-attachments/assets/caf63e53-b10a-4fed-99a6-5dff4eab740a)

## 목차
1. [프로젝트 소개](#star-프로젝트-소개)
2. [개발 기간](#calendar-개발기간)
3. [기술스택](#hammer_and_wrench-기술스택)
5. [주요기능](#sparkles-주요기능)
6. [개발 환경](#computer-개발-환경)
7. [설치 및 실행 방법](#inbox_tray-설치-및-실행-방법)
8. [트러블 슈팅](#bug-트러블-슈팅)
<br><br>

## :star: 프로젝트 소개
`BookApp`은 iOS 앱 개발에서 네트워크 통신과 로컬 데이터 저장을 익히기 위해 진행된 학습용 프로젝트입니다. 사용자는 카카오 책 검색 REST API를 활용하여 원하는 책을 검색하고, 저장하거나 최근 본 책을 다시 확인할 수 있습니다.

![Simulator Screen Recording - iPhone 16 Pro - 2025-01-06 at 10 41 58](https://github.com/user-attachments/assets/5bd2c5ef-ae1f-4b7d-92c6-fcf5e0a3ca01)

<br><br>
## :calendar: 개발기간
- 2024.12.27.(일) ~ 2025.01.06.(월)
<br><br>
## :hammer_and_wrench: 기술스택

### :building_construction: 아키텍처
- MVC

### :art: UI Framworks
- UIKit
- SnapKit(Auto Layout)
<br><br>

## :sparkles: 주요기능
- **책 검색**: 카카오 책 검색 REST API를 활용하여 네트워크 통신
- **책 검색 결과**: 네트워크 통신 결과를 표시
- **최근 본 책**: 검색 결과를 눌러서 확인한 경우, 표시
- **책 저장**: 담기를 누르면 CoreData에 저장 
<br><br>

## :computer: 개발 환경
- **Xcode**: 16.2
- **iOS Deployment Target**: iOS 18.2
- **iOS Tested Version**: iOS 18.2 (시뮬레이터 및 실제 기기)
<br><br>
## :inbox_tray: 설치 및 실행 방법
1. 이 저장소를 클론합니다.
```bash
git clone https://github.com/name-mun/BookApp.git
```
2. 프로젝트 디렉토리로 이동합니다.
```bash
cd BookApp

```
3. Xcode에서 `BookApp.xcodeproj` 파일을 엽니다.

4. Xcode에서 빌드 후 실행합니다.
- 실행 대상에서 **iPhone Simulator** 선택
- **Cmd + R**로 실행
<br><br>

## :bug: 트러블 슈팅
👉 [컬렉션뷰 섹션 숨기기 트러블슈팅](https://name-mun.tistory.com/70)

컬렉션뷰에서 조건에 따라 섹션을 숨기는 과정에서 발생한 문제와 이를 해결하는 과정에 대한 기록입니다.


