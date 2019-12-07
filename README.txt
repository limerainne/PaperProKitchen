# Ridi Paper Pro Kitchen r13_2

- 안내서
https://cafe.naver.com/bookbook68912/770
- 저장소
https://github.com/limerainne/PaperProKitchen

## 작업 절차
- "_step_by_step.cmd"를 실행해서 아래 절차를 차례로 진행!


- ADB 드라이버 설치
  - "drivers/GoogleUSBDriver/" 폴더의 "android_winusb.inf" 파일 오른쪽 클릭 > 설치 클릭 (관리자 권한 필요)
  - Windows 7에서는 기기가 Fastboot 모드일 때, 작업 완료 후 정상 상태일 때 각각 드라이버 수동 설치
     - "DPInst_x64.exe" 또는 "DPInst_x86.exe" (32비트 OS이면) 실행하여 설치하는 것은, 네트로닉스 기기용 드라이버가 아니라 의미 없음.
  
- (윈도7인 경우) adb_usb.ini 파일에 네트로닉스 USB Vendor ID 추가
  - "_add_vendor_to_adb_usb_ini.cmd" 실행
  
- 장치 관리자 열어두기
  - [시작 > 실행] > "devmgmt.msc" 입력 > [확인]
  - 또는, "_open_devmgmt.cmd" 파일 실행

- PC에 기기 연결하기, 안정적인 진행을 위해
  - 데스크톱 PC인 경우 뒷면 USB 포트 이용 추천
  - 짱짱한 USB 케이블 이용 추천: Fastboot에서 커스텀 리커버리 이미지로 부팅하지 못 하는 문제 회피
  
- (선택) 기기에 설치할 앱 APK 파일 및 설정, 명령 파일 담기
  - Windows 탐색기 > PAPER PRO > 내부 저장소 열기
  - "Apps" 폴더를 만든 뒤 (대소문자 주의! 리눅스에서는 대소문자를 구별함)
  - 그 안에 APK 파일, 그리고 앱 초기 설정 파일 등 담기

- (선택) [윈도 7, 루팅 이미지] ADB USB 장치 VID 변경
  - Windows 탐색기 > PAPER PRO > 내부 저장소 열기
  - 도구 폴더에 있는 ".win7" 파일을 내부 저장소로 복사
    - 추후 루팅 스크립트 동작 중 이 파일이 존재하면 장치 VID 변경 시행

- (선택) epdblk / RefreshPie (네이버 eBook카페 데메빌러님 도구) 사용 위한 부트 이미지 수정
  - Windows 탐색기 > PAPER PRO > 내부 저장소 열기
  - 도구 폴더에 있는 ".allow_epdblk" 파일을 내부 저장소로 복사
    - 루팅 스크립트 동작 중 이 파일이 있으면 epdblk 동작 위한 프레임버퍼 권한 개방 처리

- 기기를 완전히 종료하기
  - 기기 상단의 전원 버튼을 누르고, 화면에서 [확인]을 터치.
  - 또는, 기기가 켜져 있을 때 전원 버튼을 10초간 눌러 강제로 끄기.

- Fastboot 모드로 기기 시작하기
  - 전면 우상단 물리 버튼과 전원 버튼 함께 누르고 있기. 측면 퀵버튼 아님!
  - 전원 버튼 옆 LED에 잠시 초록 불이 들어왔다가 (노란 빛이 섞인) 흰색으로 바뀌면 버튼에서 손 떼기.
  - 장치 관리자에 "Android Device" > "Android ADB Interface" 장치가 잡혀 있으면 성공.
    - 대신 "기타 장치" > "i.mx6sl NTX Smart Device"가 잡혀 있으면... 위의 ADB 드라이버 수동 설치할 것.
  
  - 참고) 전원 LED가 흰색으로 바뀌기 전에 (또는, 초록 불이 들어오기 시작할 때 즈음) 전원 버튼에서 손을 떼고
    - 우상단 물리 버튼만 누르고 있으면 리커버리 모드로 부팅

- ADB 활성화 / SuperSU (루트 권한) 설치 이미지로 부팅
  - "_start_cmd.cmd" 파일을 실행해 명령줄 창을 띄우고, 다음 명령 두 줄을 입력하여 실행
    - 첫 명령어로 장치가 정상 인식되는 지 확인
    - 두번째 명령어로 리커버리 이미지로 부팅
      - 여기서 부팅 실패 시 ("FAILED"), USB 케이블 교체·데스크톱이면 후면 USB 포트 추천

> fastboot devices
> fastboot boot images\openlib_r13_full.img

실행 예시)-*-*-*-*-*-*-*-*-*-*-*-*-
C:\Users\LVLZ\Desktop\PaperPro>fastboot devices
PP1A1********   fastboot

C:\Users\LVLZ\Desktop\PaperPro>fastboot boot images\openlib_r13_full.img
downloading 'boot.img'...
OKAY [  0.230s]
booting...
OKAY [  0.003s]
finished. total time: 0.236s
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

  - 리커버리 이미지에 따라 다른 작업 수행
    - open_adb_only_r1.img
        : ADB 활성화 (+ 킷캣 OS SD카드 쓰기 권한 제한 해제; 부트 영역 수정 않으면 무의미)

    - openlib_r13_base.img
        : 위 이미지 + 루트 권한 + 유용한 시스템 수정
         + init.d 활성화 + 첫 부팅 시 앱 자동 설치 기능
         + SuperSU 설치 + 부트 파티션 수정 (SD카드 인식) + 브라우저 파일 다운로드 기능 수리
         + ADB 장치 구글 넥서스 4로 속임 + 데메빌러님 epdblk 작동 준비
         + Xposed, PlayStore 설치/유지
    - openlib_r13_light.img
        : 위 이미지 + 소프트키&앱서랍만 자동 설치
    - openlib_r13_full.img
        : 위 이미지 + 각종 기본 앱 자동 설치

    - recovery_adb_r13.img
        : 그냥 TWRP 리커버리, 직접 명령 내려야 할 때

- 리커버리 모드로 진입하고, 이미지에 따라 작업을 진행한 후 자동 재부팅됨.

- 기기가 정상 재시작되면, ADB 장치가 정상 인식되는지 확인.
  - 장치관리자 중, "범용 직렬 버스 장치" > "Ridi_device" 또는 "Android Device" > "Android ADB Interface" 있는지 확인
    - 대신 "기타 장치"에 있으면 드라이버 한 번 더 설치
      - 리커버리 때와 장치 ID가 달라서 드라이버 설치를 한 번 더 진행해야 함
        Fastboot, 리커버리 때는 구글 ID, 정상 부팅 때는 네트로닉스 ID
        (부트 파티션 램디스크의 /init.usb.rc 참조)
  - 앞의 명령줄 창에서, 'adb devices'했을 때 아래와 같이 뜨는지 확인
    - ADB에서만 인식이 안 되면 "_add_vendor_to_adb_usb_ini.cmd" 실행
      - (원인을 모르겠지만) %userprofile%/.android/adb_usb.ini에 네트로닉스 USB vendor id가 있어야 동작하는 경우 있음

실행 예시)-*-*-*-*-*-*-*-*-*-*-*-*-
C:\Users\LVLZ\Desktop\PaperPro>adb devices
List of devices attached
PP1A1********   device
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

- 필요한 앱 설치: 'adb install' 명령
  - 앱 자동 설치 스크립트를 통해 설치하지 않은 앱들은,
  - 네이버 eBook 카페의 네무네무 님의 툴을 사용하거나, 'adb install' 명령으로 설치
  - 또는, 같이 포함된 apps/ 폴더 내의 앱들을 '_install_apps.cmd'를 통해 설치
  - 또는, 기기 내부 저장소에 APK 파일을 담은 후 기기에서 탐색기 앱을 통해 찾아서 설치
    - 기기 내 환경설정 앱 > 보안 > 알 수 없는 소스 허용 선택해야 할 수 있음 (어차피 체크 안 되어 있으면 알아서 안내해 줌)

- 기기에서 앱 서랍을 실행할 수 있도록 ADB를 통해 가상 버튼 앱 실행: '_launch_app.cmd'
  - 가상 버튼 역할을 할 앱을 기기에 내장된 "monkey" 테스트 툴을 통해 처음 한 번은 실행해 주어야 함.
adb shell monkey -p <패키지 이름> -c android.intent.category.LAUNCHER 1

실행 예시: 여기서는 App Drawer 앱)-*-*-*-*-*-*-*-*-*-*-*-*-
C:\Users\LVLZ\Desktop\PaperPro>adb shell monkey -p be.wazabe.appdrawer -c android.intent.category.LAUNCHER 1
Events injected: 1
## Network stats: elapsed time=65ms (0ms mobile, 0ms wifi, 65ms not connected)
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
  - "Multi-action Home Button" 앱 실행 명령
adb shell monkey -p com.home.button.bottom -c android.intent.category.LAUNCHER 1

- 접근성 서비스 활성화
  - 가상 버튼 앱은 "접근성 서비스"를 통해 뒤로 버튼 등을 동작시키지만
  - 리디의 환경설정 앱 개조가 덜 되어 있어 기기 상에서는 접근성 서비스 활성화가 불가능
    - 설정 앱의 레이아웃에서 상단 툴바가 제거되어 있으나 코드에 반영되어 있지 않아, 존재하지 않는 툴바에 명령 내리려다 강제종료...
  - ADB 셸에서 "settings" 명령 통해 활성화가 가능 (루트 권한 불필요)
  
  - APK 파일에 대해 aapt 명령을 내리거나 하여 접근성 서비스 이름을 찾고
    e.g. Multi-action Home Button은 com.home.button.bottom/com.home.button.service.AccessibilityActionService
  - 기기의 ADB 셸에서 다음 명령을 다음 순서대로 내리기
settings put secure enabled_accessibility_services 'com.home.button.bottom/com.home.button.service.AccessibilityActionService'
settings put secure accessibility_enabled 1

  - 원하는 서비스가 두 개 이상이라면 ':'으로 구분하여 이어 적기

-----------------------------------------------

## 폴더 안내
- apps: "_install_apps.cmd"에서 설치할 APK 파일을 가져오는 위치
- bin: 각종 도구 파일
- drivers: 기기 인식을 위한 장치 드라이버
- images: 리커버리 이미지 또는 ADB활성화/루팅 작업 자동화용 이미지
- tools: 주요 작업에는 무관한 보조 도구 포함

## 준비된 도구
adb, fastboot
sign_zips: 순정 리커버리에서의 업데이트 파일 플래싱 위한 테스트 서명 도구 (signapk.jar 이용)
aapt: APK 패키지에서 AndroidManifest.xml 추출, 여러 정보 (서비스 클래스 이름 등) 파악
> aapt dump badging <APK file>
> aapt dump xmltree <APK file> AndroidManifest.xml
apktool: APK 패키지 디컴파일/컴파일, 앱 코드 수정 또는 프레임워크 수정 (배터리 퍼센트 표시) 등에 사용
> apktool d -o <workdir> <APK file>
> apktool b -o <generated APK file> <workdir>
sed: 텍스트 파일 찾아바꾸기

### 도구 버전
- Android SDK Platform-Tools r40 (v28.0.0) (<sdk>/platform-tools)
: ADB, Fastboot
- Android SDK Build-Tools v28.0.0 (<sdk>/build-tools/28.0.0)
: aapt (AndroidManifest.xml 추출용)
- Google USB Driver rev 11 (<sdk>/extras/google/usb_driver)
: ADB 연결

- APKTool v2.3.4 https://ibotpeaches.github.io/Apktool/install/
: APK unpack/repack용

#### 리커버리 도구
- 기반 v1.0.0P, /sbin/recovery 바이너리 v1.0.2P
- /sbin/ 디렉토리, "adbd" YotaPhone2 커스텀 리커버리 XDA@SteadyQuad 
https://forum.xda-developers.com/yotaphone-one/development/recovery-modified-stock-recovery-to-t3131871

- TWRP+OmniRom v3
https://github.com/limerainne/ridi_paper_pro_ntx_6sl_twrp
<- https://github.com/Ryogo-Z/nook_ntx_6sl_twrp/ 포크 및 수정

- Busybox 1.28.3-YDS https://github.com/yashdsaraf/bb-bot/releases
- bbootimg (binary https://github.com/Tasssadar/sailfish_multirom_packer/blob/master/zip_root/post_install/bbootimg)
- parted, mke2fs, e2fsck, tune2fs https://github.com/Talustus/android-recovery/tree/master/utilities
- zipalign https://github.com/skyleecm/android-build-tools-for-arm/tree/master/out/host/linux-arm/bin
- tar, zip https://github.com/opengapps/opengapps/tree/master/scripts

#### 기본 앱
- 소프트키: UDN
- 앱 서랍: E-Ink Launcher
-------
- 파일 탐색기: MK Explorer
- 오프라인 사전: ColorDict
- Xposed Framework
  - Xposed Additions, RidiPosed, RootCloak
- GooglePlay 서비스
  - microG, FakeGapps, FakeStore, (선택: PlayStore)
- 화면 회전: Adaptive Rotation Lock
- 앱 메모리 정리: Greenify
- 성능 개선: Seeder, Trimmer
- 웹브라우저: Lightning

-----------------------------------------------

## 달라진 점
 - r13_2
  * /default.prop: 'user' 빌드로 되돌림 <- 기존: 'eng' 빌드; 불필요한 디버그 모드 활성화 문제
  * iToast: 저장소 부족 경고 더 잘 뜨도록 수정
  * RidiPosed v0.2.5 (v1.5.1P 전용)
    - 시스템 수준 기능 추가, 비호환시 강제종료 문제 수정
  * 웹브라우저 다시 추가
 
 - r13_1
  * RidiPosed: 일부 앱 검정 배경 흰색 바꾸기 문제 수정 및 밝은 회색으로 후퇴
  * XposedAdditions: 스캔코드 규칙 지정시 일반 키코드 규칙을 무시하지 않도록 수정
  * 오른쪽 두 키뿐 아니라 왼쪽 두 키로도 수동 화면 리프레시 가능
  * epdblk/RefreshPie 위한 부트 이미지 수정을 선택 기능으로 바꿈 (.allow_epdblk 플래그)
 
 - r13
  * WiFi 탐색 주기 10분으로 (build.prop), 신호 세기 새로고침 주기 1분으로 (RidiPosed)
  * Xposed Framework 자동 설치 / 유지
    * 버튼 매핑 도구 교체: Xposed Additions
      - 모든 버튼 개별 매핑 가능
      - (수동) 화면 리프레시, 밝기 조절 화면 호출
    * RidiPosed
      - 사전 버튼 (오프라인 앱)
      - 도서별 폰트 지정, 형광펜 커서 동작, 본문 검정 배경 (v1.3.0P에서만 확실히 동작)
      - 어느 앱에서나 퀵버튼 리프레시 동작
      - 일부 앱의 검정 배경 흰색으로, WiFi 신호 세기 새로고침 간격 1분으로 늦춤
    * RootCloak
      - 루트 감지하여 동작 않는 일부 앱 문제 우회
  * GooglePlay (microG) 및 PlayStore 설치 / 유지 기능
    - (비공식) microG 통한 가벼운 GooglePlay 서비스 작동
      - 자동 동기화, 위치 서비스 없음
    - PlayStore 설치 (별도) 및 OTA 업데이트 후 유지 기능
  * 앱 추가: Seeder, Trimmer, Lightning 브라우저
    * Seeder: 반응성 개선: 얼음땡 문제 완화
    * Trimmer: 자체 메모리 TRIM 기능이 못 미더울 때
    * Lightning: 순정 인터넷 앱보다 깔끔한 인터페이스, 광고 차단
  * 앱 업데이트
    * E-Ink Launcher: 아이콘 이름순 정렬
    * Greenify: 목록에 주요 서점 앱 더 추가
  * 앱 삭제: Multi-action Home Button, RidiDictBridge, Yalp Store, 나그네님 버튼매퍼
  
  * iToast: 앱 저장소 부족할 때 알림 대화상자 표시 (안드로이드 기본값: <10%)
  * 순정 리커버리로 되돌림 -- 순정 파티션 재조정 기능 사용 가능
  * 부팅 중 앱 설치: APK 파일에 띄어쓰기 있으면 파일 찾지 못하는 문제 회피
  * 도구 설치 시 번들 앱 설정 파일을 무조건 덮어쓰도록 되돌림

 - r12
  * 순정 리커버리 대신 TWRP 커스텀 리커버리로 교체
    (https://github.com/limerainne/ridi_paper_pro_ntx_6sl_twrp)
  * 필수 기본앱만 담긴 (소프트키, 앱서랍) 루트 이미지 추가
  * 첫 부팅시 앱 설치: 대화상자 바깥을 눌러 닫은 경우 투명창이 남아있어 터치 안 되는 문제 개선
  * 전체 절차 안내 위한 스크립트 추가: _step_by_step.cmd
  * 버튼매퍼 기본 설정 적용: 교보도서관, 북큐브, 카카오페이지, 조아라 등
  - r12_1
    * 절차 안내 스크립트의 치명적인 오타 ('\') 수정 및 설명 개정
  - r12_2
    * 버튼매퍼 기본 설정 중 이전 페이지 터치 좌표 고침
    * 설정/애플리케이션 화면 투명 배경 하얗게 변경
    * 첫 부팅시 앱 설치
      - 'Apps' 폴더 이름 모두 소문자, SD카드에 넣은 경우도 지원
      - 안내 문구 수정
    * PC 스크립트: install_apps 개정
      - 시작하기 전 ADB 장치 인식 점검, 기기 내 APK 파일 설치 기능

 - r11
  * 루트 이미지: 업데이트 패키지 설치 방식으로 변경
    - 진행률 표시 가능, 깔끔한 설치 후 재시작
  * OTA 직후 자동 루트 기능 추가
    - OTA 정상 설치된 이후 준비된 루트 도구 설치 진행
    - 커스텀 리커버리 이미지 기기에 플래싱 및 /data/local/recovery_mod.img 배치됨

 - r10
  * r9에서 Win7을 위한 ADB 장치 VID 교체 선택 사항으로 변경
    - /sdcard/.win7 (빈 파일) 만들면 동작
    - /sdcard/.rev_win7 (빈 파일) 만들면 원래대로 되돌림: 일부 Win10 PC에서 인식 안 되는 문제 해결 위해
      - 둘 다 있으면 ".win7" 동작
  * 기본 앱 자동 설치:
    - Greenify 앱 추가
    - SuperSU 동작 시점 가장 처음으로 변경, UDN, 버튼매퍼 권한 획득하도록 수정
    - 기본 브라우저 비활성화 명령 삭제
    - 부팅 후 나타나는 불필요한 토스트 메시지 삭제 ("스크립트 실행")
    - 폰트 권한 교정 스크립트 개정
    - UDN 활성화 방식 하단 어디서든 위로 스와이프 -> 하단 우측 구석 터치로 변경
  * 기본 앱 제외 설치 이미지 개정
    - SuperSU 기본 설정 파일 복사: 루트 권한 필요한 UDN, ButtonMap, OTA시 SuperSU 앱 삭제로 설정 파일로 함께 삭제됨
  * 리파티션 위해 부팅 이미지 편집용 bbootimg 도구 추가
  * PC 쪽 도구: diff, patch 추가
    
 - r9
  * PC 쪽 도구
    - 버전 업데이트 (ADB, Fastboot, APKTool 등)
    - 앱 설치 스크립트와 앱 실행 스크립트 분리
    - 앱 설치 스크립트 수행 후 앱 서랍 강제 종료하도록 하여 앱 목록 새로고침 시행
  * 리커버리 이미지
    - busybox 새 버전으로 교체, 각종 파티션 편집 툴, tar/zip 압축 툴 추가 ... 언젠가는 쓸 일이 있겠지...
    - recovery 프로그램 v1.0.2P 것으로 교체: 하드웨어 키 직관대로 동작, 메뉴 선택시 최종 경고 화면 간소화
  * 루팅 스크립트
    - 앱 자동 설치 스크립트 개선: "getprop sys.boot_completed" 값을 검사하여 올바른 시작 타이밍 파악, 올바른 init.d 스크립트 권한 부여, 기본 앱 리커버리에 포함하여 설치 진행
    - 부트 이미지 패치 스크립트: 기존 Polymorph&AIK-Mobile에서 bbootimg&AIK-Mobile의 mkbootfs로 직접 구현
        : busybox의 버그인지 잘못 만들어서 그런지 편집한 ramdisk를 손수 cpio 압축하면 부팅이 안 됨..
      - Win7을 위해 ADB 장치 VID를 Google Nexus 4의 것으로 교체
      - 데메빌러님 epdblk 사용 위한 graphics 유저 관련 권한 수정 (보안 구멍 된다 하지만...)
  * 신규 루팅 이미지 추가: 필수 앱 설치

 - r8
  * v1.1.0P의 미디어 서비스 중지하지 않도록 수정 (교보문고 전자도서관, 볼륨 리모컨 등 문제 해결)

 - r7
  * init.d 스크립트 동작 시점 늦춤, 환경 따라 동작 않는 원인 여전히 파악 못 함
  * v1.0.2P의 /boot/init.E7***.rc 변경 반영 -- 더 나은 방법 필요.

  * 윈도7 드라이버 사전 설치 전략 실패, devcon.exe를 통한 전략도 1차 실패.

 - r6
  * 윈도 7에서 UTF-8로 인한 명령 창 오류 발생하지 않도록 "_start_cmd.cmd" 수정, "_install_apps_MS949.cmd" 추가
  * 윈도 7 위한 DPInst.exe를 ADBInstaller_v1.4.3 (https://forum.xda-developers.com/showthread.php?t=2588979) 에서 무단전제함...
    * MS Windows Driver Kit > Driver Install Frameworks (DIFx) > Driver Package Installer

 - r5
  * 루팅 이미지 BusyBox 업데이트로 인해 부트 파티션 수정 스크립트가 동작하지 않는 문제 수정
    : chown root:root <boot image> 명령이 "root:root"를 인식하지 못해 동작하지 않았음.
  * init.d 설치 스크립트가 SELinux context를 제대로 설정하지 못하는 문제 수정
    : toolbox chcon 명령이 "-h" 옵션을 인식하지 못하는 문제.
 
 - r4
  * init.d 활성화 및 첫 부팅시 앱 설치 스크립트 추가
  * 루팅 이미지 다시 두 가지로 줄임
    : 부트 파티션 수정 이미지가 충분히 검증된 점 고려
  
 - r3
  * PC 측 스크립트 수정
    : "_install_apps.cmd"도 관리자 권한 여부 무관하게 실행
    : "_add_vendor_to_adb_usb_ini.cmd" 추가
  * 부트 파티션 수정하는 새 루팅 이미지도 포함
  * 순정 리커버리 개조 이미지
    : SD 카드를 "/extsd"에 마운트할 수 있도록 fstab 편집
    : BusyBox 업데이트: v1.26.2 <- v1.22.1, init.rc에 ls 명령을 위한 LS_COLORS=none 환경변수 설정

 - r2
  * PC 측 스크립트 문제 수정
    : "_start_cmd.cmd" - 관리자 권한 여부 무관하게 명령 창 실행
    : "tools/sign_zips.cmd" - 이름에 공백이 있어도 동작
  * 추천 앱 APK 파일 별도 압축파일로 분리
  * 새 루팅 이미지 시험 삼아 게시
    : 브라우저 다운로드 문제 (시스템 앱 수정), SD카드 인식 문제 (부트 이미지 수정) 해결

 - r1: 첫 게시

-----------------------------------------------
## 부팅 중 앱 자동 설치 스크립트

- init.d 활성화를 통해, 부팅 중 앱 설치 진행
(/init.d --> /system/etc/install-recovery.sh --> /system/etc/init.d/91_install_apps --> /data/install_apps.sh)

- 기기 내부 저장소의 "Apps" 폴더에서 APK 파일 설치 및 설정 파일 복사, 관련 명령 파일 실행

* 내부 저장소의 특정 폴더에 미리 담아놓은 앱을 설치하고
    * 앱 설정 파일을 함께 두었다면, 앱 데이터 폴더로 해당 파일을 복사하고 (/data/data/<앱 패키지 이름>)
    * 실행해야 할 명령이 있어서 명령 파일을 함께 두었다면, 해당 파일을 실행하고
       (예. 가상 버튼 앱의 백 버튼 기능 활성화) (루팅 안 했더라도 루트 권한으로 실행)
* 처음 한 번은 실행해야 하는 앱이 있다면 (예. 가상 버튼 앱) 그 앱을 실행

- APK 파일 이름은 공백을 포함해도 되고 한글이 들어가도 됨
- 그러나 설정 파일을 담은 폴더 이름은 반드시 앱 패키지 이름과 같아야 함
  - 앱 데이터 폴더와 폴더 구조도 동일해야 함 e.g. shared_prefs

- APK 파일 이름 앞에 @을 붙이거나, 폴더 이름 앞에 @을 붙이면 설치 완료 후 monkey 명령으로 실행됨

- 앱 데이터 파일 복사시, 기존 파일이 있든말든 덮어 쓰니 유의..

- 부팅 중 앱 설치가 완료되면, "Apps" 폴더 안에 ".installed" 파일과 "install.apps.log" 텍스트 파일 생성됨.
  - ADB Logcat 로그 (FirstTimeInstall 태그) 및 "install.apps.log" 파일에 로그 기록.
  - ".installed" 파일이 있으면 이미 앱을 설치해본 것이므로 다음에 스크립트를 실행해도 (install_apps.sh) 아무 일도 하지 않음.

- 루트 권한으로 명령 파일을 실행하는 것이 보안 문제가 될 수 있어서,
  - 첫 부팅 이후 앱 설치 스크립트는 삭제됨 (/data/install_apps.sh)
  - 삭제하지 않고 추후에 또 이용하시려면, "Apps" 폴더 안에 ".do_not_delete_script" 이름의 빈 파일 생성할 것.
  - init.d 안의 스크립트는 남아있으나, 어차피 껍데기이므로 의미 없음.

* 원전 https://forum.xda-developers.com/showthread.php?t=1441378 [DEV][SCRIPT] First-Boot App Install
-----------------------------------------------
## OTA 직후 자동 루트 기능

- OTA 설치 완료 감지하여 루트 도구 설치 진행하도록 커스텀 리커버리 제작

- 기기에 커스텀 리커버리를 설치해 두면 소프트웨어 업데이트에 무관하게 루트 권한 유지 가능
- 위험성 낮을 것으로 기대
   * OTA 설치 절차 자체는 원본 그대로
   * 사용하는 시스템 파일 수정 방법(설정 파일 속성 한 줄 찾아 바꾸기, patch 이용) 특성
     - 신규 파일 내용이 크게 달라진다면 수정 작업이 이루어지지 않음

- OTA 패키지 설치시 리커버리 파티션이 순정 상태로 돌아가므로
   * 루트 작업 마지막에 커스텀 리커버리 기기에 플래싱
   * (<=r11) 앱 설치 공간에 10 MiB 상당의 커스텀 리커버리 파일을 비치 (/data/local/recovery_mod.img)
     - 리커버리 이미지 안에 자기 자신 이미지를 넣을 수는 없으니...
     - 이미지 안에 자기 자신을 포함시킬 다른 방법도 있겠으나, 위험 부담 + 귀찮
   * (>=r12) 리커버리 시작 시 리커버리 파티션 백업 -> OTA 설치 후 루트 도구 설치 중 이용
     - 이제 소중한 데이터 파티션 공간 10 MiB 가량 아낌

-----------------------------------------------
## 기능 수정별 상세 내역

  - ADB 활성화: /system/build.prop에 다음 줄 덧붙임
persist.sys.usb.config=mtp,adb

  - 사용자 앱의 SD카드 쓰기 권한 허용: /system/etc/permissions/platform.xml 수정
     <permission name="android.permission.WRITE_EXTERNAL_STORAGE" >
         <group gid="sdcard_r" />
         <group gid="sdcard_rw" />
+        <group gid="media_rw" />
     </permission>

  - init.d 활성화 (/system/etc/install-recovery.sh 및 busybox run-parts 활용)

  - 첫 부팅 시 앱 설치 스크립트 추가
: 리커버리 내장한 필수 앱 /data/local/tmp/apps로 복사
: /system/app/에 토스트+대화상자용 앱 추가

  - SuperSU 설치

  - 브라우저 다운로드 기능 고치기: /system/priv-app/DownloadProvider.apk 교체 (v1.0.1P 파일 이용)
com.android.providers.downloads.DownloadProvider.checkFileUriDestination() 함수 중,
  getCanonicalPath() -> getAbsolutePath()로 변경

  - 부트 파티션 수정
init.E70Q10.rc SECONDARY_STORAGE 환경변수 설정
default.prop에 위의 ADB 활성화 수정
데메빌러님 epdblk 구동을 위한 graphics 유저 전용 파일 권한 수정
USB 벤더 ID "구글 넥서스 4"로 속이기: 간편한 Win7 드라이버 인식 위해
