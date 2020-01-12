
# 도구 및 앱 출처

### 리커버리 이미지

 * 순정 리커버리
   * v1.0.0P 기반, `/sbin/recovery` 바이너리: v1.0.2P 버전
   * `/sbin/adbd` 바이너리 출처: [YotaPhone2 커스텀 리커버리 / XDA@SteadyQuad님](https://forum.xda-developers.com/yotaphone-one/development/recovery-modified-stock-recovery-to-t3131871)
 * TWRP 커스텀 리커버리
   * GitHub@Ryogo-Z님 [저장소 링크](https://github.com/Ryogo-Z/nook_ntx_6sl_twrp), OmniRom 팀
     * [수정본 코드 저장소](https://github.com/limerainne/ridi_paper_pro_ntx_6sl_twrp)
 * 리커버리 내 도구 바이너리 출처
   - [Busybox 1.28.3-YDS](https://github.com/yashdsaraf/bb-bot/releases)
   - [bbootimg](https://github.com/Tasssadar/sailfish_multirom_packer/blob/master/zip_root/post_install/bbootimg)
   - [parted, mke2fs, e2fsck, tune2fs](https://github.com/Talustus/android-recovery/tree/master/utilities)
   - [zipalign](https://github.com/skyleecm/android-build-tools-for-arm/tree/master/out/host/linux-arm/bin)
   - [tar, zip](https://github.com/opengapps/opengapps/tree/master/scripts)

### 기능 수정 도구

 * 부트 이미지 수정 도구
   * `bbootimg` (GitHub@Tassadar님, [ARM 바이너리](https://github.com/Tasssadar/sailfish_multirom_packer/blob/master/zip_root/post_install/bbootimg))
   * `mkbootfs` 
 * 부팅 중 앱 설치
   * 아이디어 출처 [XDA@SenseiSimple님](https://forum.xda-developers.com/showthread.php?t=1441378)
 * 부팅 중 토스트 메시지 표시, 플래그 파일 통한 동작 선택
   * 아이디어 출처: 곰돌라이트 커스텀 롬 (곰돌리우스 님)

---

### 구글 안드로이드 도구
- Android SDK Platform-Tools r40 (v28.0.0) (<sdk>/platform-tools)
  * ADB, Fastboot
- Android SDK Build-Tools v28.0.0 (<sdk>/build-tools/28.0.0)
  * aapt (AndroidManifest.xml 추출)
- Google USB driver rev 11 (<sdk>/extras/google/usb_driver)
  * ADB 연결
- [APKTool v2.3.4](https://ibotpeaches.github.io/Apktool/install/)
  * APK unpack/repack

---

### 기본 앱

- 소프트키: [Ultimate Dynamic Navbar](https://forum.xda-developers.com/showthread.php?p=41195815) by XDA@MrBIMC
- 앱 서랍: [E-Ink Launcher](https://github.com/Modificator/E-Ink-Launcher) by GitHub@Modificator
- 파일 탐색기: [MK Explorer](https://play.google.com/store/apps/details?id=pl.mkexplorer.kormateusz)
- 화면 회전: Adaptive Rotation Lock
- 앱 메모리 정리: [Greenify](https://play.google.com/store/apps/details?id=com.oasisfeng.greenify)
- 성능 개선: Seeder, Trimmer
- 오프라인 사전: [ColorDict](https://play.google.com/store/apps/details?id=com.socialnmobile.colordict)
- 웹브라우저: [Lightning Browser](https://github.com/anthonycr/Lightning-Browser)

#### Google Play 서비스
  - microG, FakeGapps, FakeStore, PlayStore

#### Xposed Framework
- [Xposed Framework](https://repo.xposed.info/module/de.robv.android.xposed.installer)
  - [Xposed Additions](https://github.com/SpazeDog/xposed-additions) by XDA@SpazeDog
    - [GitHub@sven-cnrd님](https://github.com/sven-cnrd/xposed-additions/) 수정사항 이용
  - RidiPosed
  - [RootCloak](https://repo.xposed.info/module/com.devadvance.rootcloak2)
  - [FakeGapps](https://github.com/thermatk/FakeGApps) by GitHub@thermatk, [No log](https://github.com/thermatk/FakeGApps/issues/34#issuecomment-507066336) by timeakesmarky