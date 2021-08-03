Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFBC3DF396
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbhHCRJH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 13:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbhHCRJG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 13:09:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF2FC061757
        for <linux-pm@vger.kernel.org>; Tue,  3 Aug 2021 10:08:55 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so5645114pjh.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Aug 2021 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yI0CdQJDbRr49seZCXnaZpp1sZNLsO3e41Z/Vx+kG58=;
        b=Fkl/sm6ZgzDhspkzRFbpcMg3JdDadLiE/mUSXXFVb+y08/G63T+I/KC4y/3O3c3VLS
         wlKShueOwfTesyuxJJdpB8yzokgcTN4kgY+orut1WqbYkixoOrho08kzrbXODHr97zSQ
         OcKtY9bSOoJsIhztK8jnE/QbEBaMYJeN81h1gRdBZW6bV3Gm02R7LBVqCeKQcu2tTLSI
         SJSEfdaptq1ITUsMjEUPe7pxizFWZI1vynlMqCSqTLB27sv93IQtTbGB+1EH0QLnz09L
         AHu35Q8PO//VBtDABQ4VIlBAW7yUE1DQasjjBsfbMrohUF/LjspE6+yrO16lrBgRpFzc
         U+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yI0CdQJDbRr49seZCXnaZpp1sZNLsO3e41Z/Vx+kG58=;
        b=B3ZDzZdwkOiOSY73853lQS+NGX9Z3Et6DryjHmRInhblhKm0LNfMvqy3h1P6fVfWw/
         gSRxad0qct5nN1Xz6+FWufsV5z3vORty3R+eQyczuq7SMiWJ+GKZphY6cRx5nHnN+XMw
         GsRfS40JCM+R5M2TQXy8s5yrz4Na6Fxfct7MhAXiS/tZm1Rhz+/Nxrk2M4piMaurcExG
         DZaoiI6WaPZf1EAsgCdxosXBBncllSf+M7b5v4LKkDr3XjLslQcXwYHcALcC0v7I49k8
         VvdiT0Dsw5m29KtIiPSb/G4TqBYjfld6hH1m6WAvZF1ujdTDL8+PT+YRNzCbLkTukTAV
         AGnQ==
X-Gm-Message-State: AOAM53122PMMwIHFhocktDcpFBhZ1iaM7gQrhtb4OmxGmHYr0u8E6Q9Q
        zCopQf+JR03jB+euoPjKXqPlNQ==
X-Google-Smtp-Source: ABdhPJwdbj/PcqvA2gVmeeCZDgMRpiuPX8jd5HYG2syZ2Qifdk7REhm4apAAyyrnYmBRNRbAjiAJpQ==
X-Received: by 2002:a17:90b:80c:: with SMTP id bk12mr24256370pjb.69.1628010535360;
        Tue, 03 Aug 2021 10:08:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p8sm7035473pfw.35.2021.08.03.10.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 10:08:55 -0700 (PDT)
Message-ID: <61097827.1c69fb81.b7c8f.2b0c@mx.google.com>
Date:   Tue, 03 Aug 2021 10:08:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.14-rc4-14-g392ac3ea48ca
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 5 runs, 3 regressions (v5.14-rc4-14-g392ac3ea48ca)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 3 regressions (v5.14-rc4-14-g392ac3ea48ca)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =

rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
4-14-g392ac3ea48ca/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc4-14-g392ac3ea48ca
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      392ac3ea48ca393968b11b98ea9e026203b1bcee =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =


  Details:     https://kernelci.org/test/plan/id/61096aad4447db3648b13661

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc4-14-g392ac=
3ea48ca/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc4-14-g392ac=
3ea48ca/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/61096aad4447db3648b13662
        failing since 348 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/6109774d3e19d6fd8fb13670

  Results:     21 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc4-14-g392ac=
3ea48ca/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc4-14-g392ac=
3ea48ca/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/6109774d3e19d6fd=
8fb13683
        failing since 84 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fir=
st fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-08-03T17:03:01.368309  rtcwake: assuming RTC uses UTC ...
    2021-08-03T17:03:01.368582  rtcwake: wakeup from \"mem\" using rtc0 at =
Tue Aug  3 17:03:07 2021
    2021-08-03T17:03:01.383525  <6>[  102.311064] PM: suspend entry (deep)
    2021-08-03T17:03:01.383865  <6>[  102.315420] Filesystems sync: 0.000 s=
econds
    2021-08-03T17:03:01.397873  <6>[  102.321211] Freezing user space proce=
sses ... (elapsed 0.001 seconds) done.
    2021-08-03T17:03:01.398192  <6>[  102.330529] OOM killer disabled.
    2021-08-03T17:03:02.412931  <6>[  102.334428] Freezing remaining freeza=
ble tasks ... =

    2021-08-03T17:03:02.413266  <3>[  103.336816] usb 2-1: device descripto=
r read/64, error -110
    2021-08-03T17:03:02.757380  <6>[  103.686425] usb 2-1: new high-speed U=
SB device number 5 using dwc2
    2021-08-03T17:03:08.005356  <3>[  108.936446] usb 2-1: device descripto=
r read/64, error -110 =

    ... (16 line(s) more)  =


  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/6109774d3e19d6fd=
8fb13684
        failing since 84 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fir=
st fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-08-03T17:02:40.997794  <6>[   81.911533] smsc95xx 2-1.1:1.0 eth0: =
Link is Down
    2021-08-03T17:02:40.998030  rtcwake: assuming RTC uses UTC ...<4>[   81=
.922973] ------------[ cut here ]------------
    2021-08-03T17:02:40.998234  =

    2021-08-03T17:02:41.010038  <4>[   81.931734] WARNING: CPU: 2 PID: 64 a=
t fs/kernfs/dir.c:1509 kernfs_remove_by_name_ns+0xa8/0xb0
    2021-08-03T17:02:41.022854  rtcwake: wakeup from \"mem\" using rtc0 at =
Tue Aug  3 17:02:47 202<4>[   81.941850] kernfs: can not remove 'attached_d=
ev', no directory
    2021-08-03T17:02:41.023091  1
    2021-08-03T17:02:41.097227  <4>[   81.954972] Modules linked in: mwifie=
x_sdio mwifiex btmrvl_sdio btmrvl bluetooth cfg80211 ecdh_generic ecc libae=
s cros_ec_chardev cros_ec_debugfs cros_ec_sysfs cros_ec_keyb i2c_cros_ec_tu=
nnel cros_ec_dev cros_ec_spi cros_ec snd_soc_rockchip_max98090 nvmem_rockch=
ip_efuse gpio_charger panel_simple snd_soc_rockchip_i2s snd_soc_rockchip_pc=
m panfrost gpu_sched rk_crypto md5 sha256_generic libsha256 phy_rockchip_dp=
 sha1_generic libdes clk_rk808 rtc_rk808 snd_soc_max98090 uvcvideo videobuf=
2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev mc pwm_=
rockchip snd_soc_ts3a227e snd_soc_core ac97_bus snd_pcm_dmaengine snd_pcm t=
pm_i2c_infineon snd_timer snd soundcore tpm pwm_bl backlight spi_rockchip r=
ockchipdrm dw_mipi_dsi analogix_dp dw_hdmi
    2021-08-03T17:02:41.109729  <4>[   82.029303] CPU: 2 PID: 64 Comm: kwor=
ker/2:2 Tainted: G        W         5.14.0-rc4 #1
    2021-08-03T17:02:41.109964  <6>[   82.029316] PM: suspend entry (deep)
    2021-08-03T17:02:41.122520  <4>[   82.038446] Hardware name: Rockchip (=
Device Tree) =

    ... (62 line(s) more)  =

 =20
