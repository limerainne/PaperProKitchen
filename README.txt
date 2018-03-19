## 작업 절차
- ADB 드라이버 설치
  - "drivers/GoogleUSBDriver/" 폴더의 "android_winusb.inf" 파일 오른쪽 클릭 > 설치 클릭 (관리자 권한 필요)
  - Windows 7에서는 기기가 Fastboot 모드일 때, 작업 완료 후 정상 상태일 때 각각 드라이버 수동 설치
     - "DPInst_x64.exe" 또는 "DPInst_x86.exe" (32비트 OS이면) 실행하여 설치하는 것은, 네트로닉스 기기용 드라이버가 아니라 의미 없음.
  
- adb_usb.ini 파일에 네트로닉스 USB Vendor ID 추가
  - "_add_vendor_to_adb_usb_ini.cmd" 실행
  
- 장치 관리자 열어두기
  - [시작 > 실행] > "devmgmt.msc" 입력 > [확인]
  - 또는, "_open_devmgmt.cmd" 파일 실행

- PC에 기기 연결하기, 안정적인 진행을 위해
  - 데스크톱 PC인 경우 뒷면 USB 포트 이용 추천
  - 짱짱한 USB 케이블 이용 추천: Fastboot에서 커스텀 리커버리 이미지로 부팅하지 못 하는 문제 회피
  
- (선택) 기기에 설치할 앱 APK 파일 및 설정, 명령 파일 담기
  - Windows 탐색기 > PAPER PRO > 내부 저장소 열기
  - "Apks" 폴더를 만든 뒤 (대소문자 주의! 리눅스에서는 대소문자를 구별함)
  - 그 안에 APK 파일, 그리고 앱 초기 설정 파일 등 담기
  
- 기기를 완전히 종료하기
  - 기기 상단의 전원 버튼을 누르고, 화면에서 [확인]을 터치.
  - 또는, 기기가 켜져 있을 때 전원 버튼을 10초간 눌러 강제로 끄기.

- Fastboot 모드로 기기 시작하기
  - 전면 우상단 물리 버튼과 전원 버튼 함께 누르고 있기.
  - 전원 버튼 좌측 LED에 잠시 초록 불이 들어왔다가 (노란 빛이 섞인) 흰색으로 바뀌면 버튼에서 손 떼기.
  - 장치 관리자에 "Android Device" > "Android ADB Interface" 장치가 잡혀 있으면 성공.
    - 대신 "기타 장치" > "i.mx6sl NTX Smart Device"가 잡혀 있으면... 위의 ADB 드라이버 설치할 것.
  
  - 참고) 전원 LED가 흰색으로 바뀌기 전에 (또는, 초록 불이 들어오기 시작할 때 즈음) 전원 버튼에서 손을 떼고
    - 우상단 물리 버튼만 누르고 있으면 리커버리 모드로 부팅

- ADB 활성화 / SuperSU (루트 권한) 설치 이미지로 부팅
  - "_start_cmd.cmd" 파일을 실행해 명령줄 창을 띄우고, 다음 명령 두 줄을 입력하여 실행
    - 첫 명령어로 장치가 정상 인식되는 지 확인
    - 두번째 명령어로 리커버리 이미지로 부팅
      - 여기서 부팅 실패 시 ("FAILED"), USB 케이블 교체 추천

fastboot devices
fastboot boot images\mod_adb_su_boot_v1.0.0_r4.img

실행 예시)-*-*-*-*-*-*-*-*-*-*-*-*-
C:\Users\CottonCandy\Desktop\PaperPro>fastboot devices
PP1A1********   fastboot

C:\Users\CottonCandy\Desktop\PaperPro>fastboot boot images\mod_adb_su_boot_v1.0.0_r2.img
downloading 'boot.img'...
OKAY [  0.230s]
booting...
OKAY [  0.003s]
finished. total time: 0.236s
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

  - 리커버리 이미지에 따라 다른 작업 수행
    - open_adb_rbpp1_v1.0.0_r4.img
        : ADB 활성화 + init.d 활성화
    - mod_adb_su_boot_v1.0.0_r4.img
        : ADB 활성화 + SuperSU 설치 + 부트 파티션 수정 (SD카드 인식) + 브라우저 파일 다운로드 기능 + init.d 활성화

- 리커버리 모드로 진입하고, 다음 작업을 진행한 후 5초 후 자동 재부팅됨.
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
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
  
  - SuperSU 설치
  - 브라우저 다운로드 기능 고치기: /system/priv-app/DownloadProvider.apk 교체 (v1.0.1P 파일 이용)
com.android.providers.downloads.DownloadProvider.checkFileUriDestination() 함수 중,
  getCanonicalPath() -> getAbsolutePath()로 변경
  - 부트 파티션 수정
init.E70Q10.rc SECONDARY_STORAGE 환경변수 설정
default.prop에 위의 ADB 활성화 수정
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

- 기기가 정상 재시작되면, ADB 장치가 정상 인식되는지 확인.
  - 장치관리자 중, "범용 직렬 버스 장치" > "Ridi_device"
    - "기타 장치"에 있으면 드라이버 한 번 더 설치
      - 리커버리 때와 장치 ID가 달라서 드라이버 설치를 한 번 더 진행해야 함
        (부트 파티션 램디스크의 /init.usb.rc 참조)
  - 앞의 명령줄 창에서, 'adb devices'했을 때 아래와 같이 뜨는지 확인
    - ADB에서만 인식이 안 되면 "_add_vendor_to_adb_usb_ini.cmd" 실행
      - (원인을 모르겠지만) %userprofile%/.android/adb_usb.ini에 네트로닉스 USB vendor id가 있어야 동작하는 경우 있음

실행 예시)-*-*-*-*-*-*-*-*-*-*-*-*-
C:\Users\CottonCandy\Desktop\PaperPro>adb devices
List of devices attached
PP1A1********   device
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

- 필요한 앱 설치: 'adb install'
  - 앱 자동 설치 스크립트를 통해 설치하지 않은 앱들은,
  - 네이버 eBook 카페의 네무네무 님의 툴을 사용하거나, 'adb install' 명령으로 설치
  - 또는, 같이 포함된 apps/ 폴더 내의 앱들을 '_install_apps.cmd'를 통해 설치
  - 또는, 기기 내부 저장소에 APK 파일을 담은 후 기기에서 탐색기 앱을 통해 찾아서 설치
    - 기기 내 환경설정 앱 > 보안 > 알 수 없는 소스 허용 선택해야 할 수 있음 (어차피 체크 안 되어 있으면 알아서 안내해 줌)

- ADB를 통해 가상 버튼 앱 실행
  - 가상 버튼 역할을 할 앱을 기기에 내장된 "monkey" 테스트 툴을 통해 처음 한 번은 실행해 주어야 함.
adb shell monkey -p <패키지 이름> -c android.intent.category.LAUNCHER 1

실행 예시: 여기서는 App Drawer 앱)-*-*-*-*-*-*-*-*-*-*-*-*-
C:\Users\CottonCandy\Desktop\PaperPro>adb shell monkey -p be.wazabe.appdrawer -c android.intent.category.LAUNCHER 1
Events injected: 1
## Network stats: elapsed time=65ms (0ms mobile, 0ms wifi, 65ms not connected)
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

- 접근성 서비스 활성화
  - 가상 버튼 등의 앱은 접근성 서비스를 통해 뒤로 버튼 등을 동작시키지만
  - 환경설정 앱 개조가 덜 되어 있어 기기 상에서 접근성 서비스 활성화가 불가능
    - 설정 앱의 레이아웃에서 상단 툴바가 제거되어 있으나 코드에 반영되어 있지 않아, 존재하지 않는 툴바에 명령 내리려다 강제종료...
  - ADB 셸에서 "settings" 명령 통해 활성화가 가능 (루트 권한 불필요)
  
  - APK 파일에 대해 aapt 명령을 내리거나 하여 접근성 서비스 이름을 찾고
    e.g. Multi-action Home Button은 com.home.button.bottom/com.home.button.service.AccessibilityActionService
  - 기기의 ADB 셸에서 다음 명령을 다음 순서대로 내리기
> settings put secure enabled_accessibility_services 'com.home.button.bottom/com.home.button.service.AccessibilityActionService'
> settings put secure accessibility_enabled 1
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

### 도구 버전
- Android SDK Platform-Tools v27.0.0 (<sdk>/platform-tools)
: ADB, Fastboot
- Android SDK Build-Tools v27.0.2 (<sdk>/build-tools/27.0.2)
: aapt (AndroidManifest.xml 추출용)
- Google USB Driver rev 11 (<sdk>/extras/google/usb_driver)
: ADB 연결

- APKTool v2.3 https://ibotpeaches.github.io/Apktool/install/
: APK unpack/repack용

-----------------------------------------------

## 달라진 점
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
(/init.d --> /system/etc/install-recovery.sh --> /system/etc/init.d/99_install_apps --> /data/install_apps.sh)

- 기기 내부 저장소의 "Apks" 폴더에서 APK 파일 설치 및 설정 파일 복사, 관련 명령 파일 실행

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

- 부팅 중 앱 설치가 완료되면, "Apks" 폴더 안에 ".installed" 파일과 "install.apps.log" 텍스트 파일 생성됨.
  - ADB Logcat 로그 (FirstTimeInstall 태그) 및 "install.apps.log" 파일에 로그 기록.
  - ".installed" 파일이 있으면 이미 앱을 설치해본 것이므로 다음에 스크립트를 실행해도 (install_apps.sh) 아무 일도 하지 않음.

- 루트 권한으로 명령 파일을 실행하는 것이 보안 문제가 될 수 있어서,
  - 첫 부팅 이후 앱 설치 스크립트는 삭제됨 (/data/install_apps.sh)
  - 삭제하지 않고 추후에 또 이용하시려면, "Apks" 폴더 안에 ".do_not_delete_script" 이름의 빈 파일 생성할 것.
  - init.d 안의 스크립트는 남아있으나, 어차피 껍데기이므로 의미 없음.

* 원전 https://forum.xda-developers.com/showthread.php?t=1441378 [DEV][SCRIPT] First-Boot App Install
-----------------------------------------------