Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3037C3F8E7C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 21:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhHZTMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 15:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhHZTMf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 15:12:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4336C061757
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 12:11:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id u6so2950433pfi.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=JE1u9rRrrVjr3bw5g5zQU7CEskevIGpMEIZAwmannVw=;
        b=IQGISDMIzgB9KtDCu0gfDdHO7IOuJixb4PDPk/okGjfrUq/viOZ96WWmw/ubvolHWr
         V2hJEKsfDZF7toayA8Y6+yrbDzm8edunjGt/FfHKQzGftxS/X1TPb3G0K/pzr+4i1i7Z
         G+nhrFA5YCoDL+U8e2LGSnLKkD9vZ2AL2kTqJ46Gh/zp1M3LrXyTN0myExE2SyGhV4ZN
         lpOHL3LB5lMqroxB9gcBy2E8haEX94m1tcbYfft6twiJFVTOJ37ckf5Xcor9/9o/MS0r
         Jf3kZNdvRd/GV925HKFO4+8I1mH8XlhOjQ3rYPOP1G8KFS2nvLOK1AowHkaU5XCsUBbH
         y0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=JE1u9rRrrVjr3bw5g5zQU7CEskevIGpMEIZAwmannVw=;
        b=KWSAYP5VQXbG3YI7CED+xynF9fuSPNcrpfB4tNUsI+8MMWgRoKB8NhzfQY9Squkh2C
         uaO+W0ElUM4Nmig1iO/uL26zHm5fdXLy0RjGce35QqdJsuU52qol8wzasuF1HaDgTtiW
         MuHTSMpQNlgZM3gy/ao/IGgT5KTxf4VlrskvSjEhMyUCjhHfPIKI6qA0Fd3z8JLF6CKp
         ZHQuR6WO0dYL0PbIKvO4P8bnP6wy23BZINGtsPISJ1VyVpi3JCoEe7+JfggnhTfuzHec
         WKgYvRTLhDGUedLstLY8B4kmCEfHtVKcQAO+U4u8zC4FxYGL+ulsyZWwFLBVBi3r74o9
         Ahtw==
X-Gm-Message-State: AOAM533R2/vuGXDVdjNbV53xeRrm5Ou0FCBVY0zOFMhtVJpelre/XOig
        DfiCWdR65BFWa1HZEST+b+hdBw==
X-Google-Smtp-Source: ABdhPJyfLgwY4RNLTtsQgqjWLuocbWTue7JyIjwMckwn0EJvuVcgoo+i43rnpyAOBlW931A0T8Q9xQ==
X-Received: by 2002:a63:5848:: with SMTP id i8mr4585446pgm.135.1630005107086;
        Thu, 26 Aug 2021 12:11:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u25sm3591079pfn.209.2021.08.26.12.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:11:46 -0700 (PDT)
Message-ID: <6127e772.1c69fb81.c212b.9ddb@mx.google.com>
Date:   Thu, 26 Aug 2021 12:11:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.14-rc7-64-g2a7254aa7491
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 4 runs, 3 regressions (v5.14-rc7-64-g2a7254aa7491)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 3 regressions (v5.14-rc7-64-g2a7254aa7491)

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
7-64-g2a7254aa7491/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc7-64-g2a7254aa7491
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      2a7254aa7491b3da13bb3fa15a3972f5660cd32e =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6127daba378922c0218e2cad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc7-64-g2a725=
4aa7491/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc7-64-g2a725=
4aa7491/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6127daba378922c0218e2cae
        failing since 372 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/6127e0c18e119b9c938e2cc1

  Results:     21 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc7-64-g2a725=
4aa7491/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc7-64-g2a725=
4aa7491/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/6127e0c18e119b9c=
938e2cd4
        failing since 107 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fi=
rst fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-08-26T18:41:00.172090  rtcwake: assuming RTC uses UTC ...
    2021-08-26T18:41:00.177575  rtcwake: wakeup from \"mem\" using rtc0 at =
Thu Aug 26 18:41:06 2021
    2021-08-26T18:41:00.193839  <6>[  101.954625] PM: suspend entry (deep)
    2021-08-26T18:41:00.194077  <6>[  101.959055] Filesystems sync: 0.000 s=
econds
    2021-08-26T18:41:00.207911  <6>[  101.964891] Freezing user space proce=
sses ... (elapsed 0.001 seconds) done.
    2021-08-26T18:41:00.208162  <6>[  101.974440] OOM killer disabled.
    2021-08-26T18:41:01.259204  <6>[  101.978383] Freezing remaining freeza=
ble tasks ... =

    2021-08-26T18:41:01.259599  <3>[  103.016818] usb 2-1: device descripto=
r read/64, error -110
    2021-08-26T18:41:01.603781  <6>[  103.366874] usb 2-1: new high-speed U=
SB device number 5 using dwc2
    2021-08-26T18:41:06.853335  <3>[  108.616884] usb 2-1: device descripto=
r read/64, error -110 =

    ... (22 line(s) more)  =


  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/6127e0c18e119b9c=
938e2cd5
        failing since 107 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fi=
rst fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-08-26T18:40:39.797709  <6>[   81.552010] smsc95xx 2-1.1:1.0 eth0: =
Link is Down
    2021-08-26T18:40:39.809549  rtcwake: assuming RTC uses UTC ...<4>[   81=
.563449] ------------[ cut here ]------------
    2021-08-26T18:40:39.809787  =

    2021-08-26T18:40:39.822387  <4>[   81.572203] WARNING: CPU: 1 PID: 81 a=
t fs/kernfs/dir.c:1509 kernfs_remove_by_name_ns+0xa8/0xb0
    2021-08-26T18:40:39.835248  rtcwake: wakeup from \"mem\" using rtc0 at =
Thu Aug 26 18:40:46 202<4>[   81.582321] kernfs: can not remove 'attached_d=
ev', no directory
    2021-08-26T18:40:39.835488  1
    2021-08-26T18:40:39.909564  <4>[   81.595443] Modules linked in: btmrvl=
_sdio btmrvl mwifiex_sdio mwifiex bluetooth cfg80211 ecdh_generic ecc libae=
s cros_ec_debugfs cros_ec_sysfs cros_ec_chardev cros_ec_keyb cros_ec_dev i2=
c_cros_ec_tunnel cros_ec_spi cros_ec snd_soc_rockchip_max98090 nvmem_rockch=
ip_efuse panel_simple gpio_charger rk_crypto panfrost gpu_sched md5 sha256_=
generic libsha256 phy_rockchip_dp snd_soc_rockchip_i2s sha1_generic libdes =
snd_soc_rockchip_pcm uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_=
v4l2 videobuf2_common snd_soc_max98090 pwm_rockchip videodev snd_soc_ts3a22=
7e clk_rk808 rtc_rk808 snd_soc_core ac97_bus snd_pcm_dmaengine mc tpm_i2c_i=
nfineon tpm spi_rockchip snd_pcm snd_timer snd soundcore rockchipdrm dw_mip=
i_dsi analogix_dp dw_hdmi pwm_bl backlight
    2021-08-26T18:40:39.909869  <4>[   81.669767] CPU: 1 PID: 81 Comm: kwor=
ker/1:4 Tainted: G        W         5.14.0-rc7 #1
    2021-08-26T18:40:39.921575  <4>[   81.678910] Hardware name: Rockchip (=
Device Tree)
    2021-08-26T18:40:39.921819  <6>[   81.678918] PM: suspend entry (deep) =

    ... (64 line(s) more)  =

 =20
