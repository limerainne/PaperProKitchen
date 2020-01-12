## 폴더 구조
- apps: "_install_apps.cmd"에서 설치할 APK 파일을 가져오는 위치
- bin: 각종 도구 파일
- drivers: 기기 인식을 위한 장치 드라이버
- images: 리커버리 이미지 또는 ADB 활성화/루팅 작업 자동화용 이미지
- tools: 주요 작업에는 무관한 보조 도구 포함

## 포함된 보조 도구

**sign_zips**  
앱, 업데이트 ZIP을 위한 테스트 서명 도구 (signapk.jar 이용)

**aapt**  
APK 패키지에서 AndroidManifest.xml 추출, 여러 정보 (서비스 클래스 이름 등) 파악 
  * `aapt dump badging <APK file>`
  * `aapt dump xmltree <APK file> AndroidManifest.xml`

**apktool**
APK 패키지 디컴파일/컴파일, 앱 코드 수정 또는 프레임워크 수정 (배터리 퍼센트 표시) 등에 사용
  * `apktool d -o <workdir> <APK file>`
  * `apktool b -o <generated APK file> <workdir>`

**sed, patch**
텍스트 파일 찾아바꾸기, 준비한 패치 적용
