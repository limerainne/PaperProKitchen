## r13_2
   * /default.prop: 'user' 빌드로 되돌림 <- 기존: 'eng' 빌드; 불필요한 디버그 모드 활성화 문제
   * iToast: 저장소 부족 경고 더 잘 뜨도록 수정
   * RidiPosed v0.2.5 (v1.5.1P 전용)
     - 시스템 수준 기능 추가, 비호환시 강제종료 문제 수정
   * 웹브라우저 다시 추가
 
## r13_1
  * RidiPosed: 일부 앱 검정 배경 흰색 바꾸기 문제 수정 및 밝은 회색으로 후퇴
  * XposedAdditions: 스캔코드 규칙 지정시 일반 키코드 규칙을 무시하지 않도록 수정
  * 오른쪽 두 키뿐 아니라 왼쪽 두 키로도 수동 화면 리프레시 가능
  * epdblk/RefreshPie 위한 부트 이미지 수정을 선택 기능으로 바꿈 (.allow_epdblk 플래그)
 
## r13
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

## r12
  * 순정 리커버리 대신 TWRP 커스텀 리커버리로 교체
    (https://github.com/limerainne/ridi_paper_pro_ntx_6sl_twrp)
  * 필수 기본앱만 담긴 (소프트키, 앱서랍) 루트 이미지 추가
  * 첫 부팅시 앱 설치: 대화상자 바깥을 눌러 닫은 경우 투명창이 남아있어 터치 안 되는 문제 개선
  * 전체 절차 안내 위한 스크립트 추가: _step_by_step.cmd
  * 버튼매퍼 기본 설정 적용: 교보도서관, 북큐브, 카카오페이지, 조아라 등

  ## r12_1
    * 절차 안내 스크립트의 치명적인 오타 ('\') 수정 및 설명 개정
  ## r12_2
    * 버튼매퍼 기본 설정 중 이전 페이지 터치 좌표 고침
    * 설정/애플리케이션 화면 투명 배경 하얗게 변경
    * 첫 부팅시 앱 설치
      - 'Apps' 폴더 이름 모두 소문자, SD카드에 넣은 경우도 지원
      - 안내 문구 수정
    * PC 스크립트: install_apps 개정
      - 시작하기 전 ADB 장치 인식 점검, 기기 내 APK 파일 설치 기능

## r11
  * 루트 이미지: 업데이트 패키지 설치 방식으로 변경
    - 진행률 표시 가능, 깔끔한 설치 후 재시작
  * OTA 직후 자동 루트 기능 추가
    - OTA 정상 설치된 이후 준비된 루트 도구 설치 진행
    - 커스텀 리커버리 이미지 기기에 플래싱 및 /data/local/recovery_mod.img 배치됨

## r10
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
    
## r9
  * PC 쪽 도구
    - 버전 업데이트 (ADB, Fastboot, APKTool 등)
    - 앱 설치 스크립트와 앱 실행 스크립트 분리
    - 앱 설치 스크립트 수행 후 앱 서랍 강제 종료하도록 하여 앱 목록 새로고침 시행
  * 리커버리 이미지
    - busybox 새 버전으로 교체, 각종 파티션 편집 툴, tar/zip 압축 툴 추가 ... 언젠가는 쓸 일이 있겠지...
    ## recovery 프로그램 v1.0.2P 것으로 교체: 하드웨어 키 직관대로 동작, 메뉴 선택시 최종 경고 화면 간소화
  * 루팅 스크립트
    - 앱 자동 설치 스크립트 개선: "getprop sys.boot_completed" 값을 검사하여 올바른 시작 타이밍 파악, 올바른 init.d 스크립트 권한 부여, 기본 앱 리커버리에 포함하여 설치 진행
    - 부트 이미지 패치 스크립트: 기존 Polymorph&AIK-Mobile에서 bbootimg&AIK-Mobile의 mkbootfs로 직접 구현
        : busybox의 버그인지 잘못 만들어서 그런지 편집한 ramdisk를 손수 cpio 압축하면 부팅이 안 됨..
      - Win7을 위해 ADB 장치 VID를 Google Nexus 4의 것으로 교체
      - 데메빌러님 epdblk 사용 위한 graphics 유저 관련 권한 수정 (보안 구멍 된다 하지만...)
  * 신규 루팅 이미지 추가: 필수 앱 설치

## r8
  * v1.1.0P의 미디어 서비스 중지하지 않도록 수정 (교보문고 전자도서관, 볼륨 리모컨 등 문제 해결)

## r7
  * init.d 스크립트 동작 시점 늦춤, 환경 따라 동작 않는 원인 여전히 파악 못 함
  * v1.0.2P의 /boot/init.E7***.rc 변경 반영 -- 더 나은 방법 필요.

  * 윈도7 드라이버 사전 설치 전략 실패, devcon.exe를 통한 전략도 1차 실패.

## r6
  * 윈도 7에서 UTF-8로 인한 명령 창 오류 발생하지 않도록 "_start_cmd.cmd" 수정, "_install_apps_MS949.cmd" 추가
  * 윈도 7 위한 DPInst.exe를 ADBInstaller_v1.4.3 (https://forum.xda-developers.com/showthread.php?t=2588979) 에서 무단전제함...
    * MS Windows Driver Kit > Driver Install Frameworks (DIFx) > Driver Package Installer

## r5
  * 루팅 이미지 BusyBox 업데이트로 인해 부트 파티션 수정 스크립트가 동작하지 않는 문제 수정
    : chown root:root <boot image> 명령이 "root:root"를 인식하지 못해 동작하지 않았음.
  * init.d 설치 스크립트가 SELinux context를 제대로 설정하지 못하는 문제 수정
    : toolbox chcon 명령이 "-h" 옵션을 인식하지 못하는 문제.
 
## r4
  * init.d 활성화 및 첫 부팅시 앱 설치 스크립트 추가
  * 루팅 이미지 다시 두 가지로 줄임
    : 부트 파티션 수정 이미지가 충분히 검증된 점 고려
  
## r3
  * PC 측 스크립트 수정
    : "_install_apps.cmd"도 관리자 권한 여부 무관하게 실행
    : "_add_vendor_to_adb_usb_ini.cmd" 추가
  * 부트 파티션 수정하는 새 루팅 이미지도 포함
  * 순정 리커버리 개조 이미지
    : SD 카드를 "/extsd"에 마운트할 수 있도록 fstab 편집
    : BusyBox 업데이트: v1.26.2 <- v1.22.1, init.rc에 ls 명령을 위한 LS_COLORS=none 환경변수 설정

## r2
  * PC 측 스크립트 문제 수정
    : "_start_cmd.cmd" - 관리자 권한 여부 무관하게 명령 창 실행
    : "tools/sign_zips.cmd" - 이름에 공백이 있어도 동작
  * 추천 앱 APK 파일 별도 압축파일로 분리
  * 새 루팅 이미지 시험 삼아 게시
    : 브라우저 다운로드 문제 (시스템 앱 수정), SD카드 인식 문제 (부트 이미지 수정) 해결

## r1: 첫 게시
