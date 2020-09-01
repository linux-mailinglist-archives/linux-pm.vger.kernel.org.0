Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB09D25A03D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 22:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgIAUzj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 16:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAUzh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 16:55:37 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D4C061244
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 13:55:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 67so1334992pgd.12
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=LzrbK5F4Uzd/z+6djXKJDBoXNddk+KsBwqvWkFnKv9U=;
        b=otMN7XMJbed1JsEeSgSRPVoZG7+alHcdNBo0MfjwaLs3IiuTa+hmrYruxpMID19Eci
         pY1mAnKEa7Wav1JY8fhqMMj26uiJRo4/18tiHQTIuPi6+dtsvE/dEGwm/YwNomh2MuVb
         0x29WMb71crPMukqHey6e8YaszzPyNYwucez941RDpzMqL4SWmuxgsnARr5gbaJ6U365
         9iRlHQXl/9if8FkDSJe6sbQ4I9HKxodJS95ZmVRPwrrXf61g1lHdWP9QtbGwHewCLVjt
         tz2QqfRt3xn+3dGSLRh3GbzBwqWyoJiaYC065Xr66nxdPO3yLmyXnuaPF6tUtrsGoOHj
         qY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=LzrbK5F4Uzd/z+6djXKJDBoXNddk+KsBwqvWkFnKv9U=;
        b=RWNvTw2nsOKieU0bBroQAPQC6frVDNNJAigq20KHZJt4wjhlna3vwSmxk7CzVfIT15
         nnzOuEqbtCjJ0q2WEHIxcVQiA+OkOZhBbGg0vWV4S81lPLpDtK24+fQ52h2jrsaXIvmj
         ljvdr9FVarVaq7GSNvHheSLWpjVORviaJSMpCthFEZ+xjqDzLI2zWUVhw0dPouOP+4c6
         HjT13OTExzKFNvu5I0DvsIXvPtz2J6NpR2TtprGY6NPkcKBtypSR2SWqqXeZ3vpP+gSA
         vv0+uA88HGLEejGsRtCQ/u7uhNEOdiFT+rEAw4RKhFb0sWFQSBDgKZPshH8lGIVNyEXS
         xXCQ==
X-Gm-Message-State: AOAM531nlWXifQParwCqfbgT0VjwcdYFVzgp9PPGzxAzY4RGLT872jfF
        DWG1ilBvTy4/bUO5WSEa8meMLg==
X-Google-Smtp-Source: ABdhPJxKGkbxbpMQYWRvV3xI+9g9ynqOMOqw8/dC1u2Gd3xXELirpnQ7zyQNafQ4sZWC3O0w6JD14A==
X-Received: by 2002:a63:60e:: with SMTP id 14mr3010158pgg.343.1598993735686;
        Tue, 01 Sep 2020 13:55:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j20sm3166951pfi.122.2020.09.01.13.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 13:55:34 -0700 (PDT)
Message-ID: <5f4eb546.1c69fb81.b3e95.7d80@mx.google.com>
Date:   Tue, 01 Sep 2020 13:55:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.9-rc3-9-g7eada1ae101b
Subject: pm/testing sleep: 6 runs, 8 regressions (v5.9-rc3-9-g7eada1ae101b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 8 regressions (v5.9-rc3-9-g7eada1ae101b)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig          |=
 results
------------------+-------+---------------+----------+--------------------+=
--------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 0/1    =

rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 7/14   =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc3=
-9-g7eada1ae101b/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc3-9-g7eada1ae101b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7eada1ae101b2de8a32fb7125db0162b00965d48 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig          |=
 results
------------------+-------+---------------+----------+--------------------+=
--------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f4ea7cdde3abb8f1808112a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc3-9-g7eada1a=
e101b/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc3-9-g7eada1a=
e101b/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0821.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f4ea7cdde3abb8f1808112b
      failing since 13 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =



platform          | arch  | lab           | compiler | defconfig          |=
 results
------------------+-------+---------------+----------+--------------------+=
--------
rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 7/14   =


  Details:     https://kernelci.org/test/plan/id/5f4ea993786d7bd330081118

  Results:     7 PASS, 7 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc3-9-g7eada1a=
e101b/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc3-9-g7eada1a=
e101b/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0821.0/armhf/rootfs.cpio.gz =


  * sleep.rtcwake-mem-1: https://kernelci.org/test/case/id/5f4ea993786d7bd3=
3008111a
      new failure (last pass: v5.9-rc3-8-gd21006a798ed)

    2020-09-01 19:59:12.245000  [Enter `^Ec?' for help]
    2020-09-01 19:59:24.596000  =EF=BF=BD
    2020-09-01 19:59:24.597000  =

    2020-09-01 19:59:24.597000  coreboot-7d042db9 Mon Oct 22 20:40:09 UTC 2=
018 bootblock starting...
    2020-09-01 19:59:24.597000  Exception handlers installed.
    2020-09-01 19:59:24.609000  Configuring PLL at ff760030 with NF =3D 99,=
 NR =3D 2 and NO =3D 2 (VCO =3D 1188000KHz, output =3D 594000KHz)
    2020-09-01 19:59:24.621000  Configuring PLL at ff760020 with NF =3D 32,=
 NR =3D 1 and NO =3D 2 (VCO =3D 768000KHz, output =3D 384000KHz)
    2020-09-01 19:59:24.621000  Translation table is @ ff700000
    2020-09-01 19:59:24.633000  Mapping address range [0x00000000:0x0000000=
0) as uncached
    2020-09-01 19:59:24.634000  Creating new subtable @ff720800 for [0xff70=
0000:0xff800000)
    ... (1146 line(s) more)
     * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/5f4ea993786d7=
bd33008111c
      new failure (last pass: v5.9-rc3-8-gd21006a798ed)

    2020-09-01 20:00:51.112000  <8>[   30.380758] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drtcwake-mem-2 RESULT=3Dpass>
    2020-09-01 20:00:51.127000  + lava-test-case rtcwake-mem-3 --shell rtcw=
ake -d rtc0 -m mem -s 5<8>[   30.398891] <LAVA_SIGNAL_STARTTC rtcwake-mem-3>
    2020-09-01 20:00:51.139000  =

    2020-09-01 20:00:51.140000  rtcwake: assuming RTC uses UTC ...
    2020-09-01 20:00:51.140000  rtcwake: wakeup from \"mem\" using rtc0 at =
Tue Sep  1 20:00:57 2020
    2020-09-01 20:00:51.155000  <6>[   30.434212] PM: suspend entry (deep)
    2020-09-01 20:00:51.162000  <6>[   30.440497] Filesystems sync: 0.000 s=
econds
    2020-09-01 20:00:51.173000  <4>[   30.450120] sbs-battery 20-000b: Unkn=
own chemistry: POLY
    2020-09-01 20:00:51.371000  <4>[   30.647814] sbs-battery 20-000b: Unkn=
own chemistry: POLY
    2020-09-01 20:00:51.433000  <4>[   30.709420] sbs-battery 20-000b: Unkn=
own chemistry: POLY
    ... (130 line(s) more)
     * sleep.rtcwake-mem-4: https://kernelci.org/test/case/id/5f4ea993786d7=
bd33008111d
      new failure (last pass: v5.9-rc3-8-gd21006a798ed)

    2020-09-01 20:01:00.400000  <8>[   39.668290] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drtcwake-mem-3 RESULT=3Dfail>
    2020-09-01 20:01:00.417000  + lava-test-case rtcwake-mem-4 --shell rtcw=
ake -d rtc0 -m mem -s 5<8>[   39.689049] <LAVA_SIGNAL_STARTTC rtcwake-mem-4>
    2020-09-01 20:01:00.417000  =

    2020-09-01 20:01:00.431000  rtcwake: assuming RTC uses UTC ...
    2020-09-01 20:01:00.431000  rtcwake: wakeup from \"mem\" using rtc0 at =
Tue Sep  1 20:01:07 2020
    2020-09-01 20:01:00.447000  <6>[   39.725744] PM: suspend entry (deep)
    2020-09-01 20:01:00.459000  <6>[   39.736766] Filesystems sync: 0.000 s=
econds
    2020-09-01 20:01:00.631000  <6>[   39.744948] Freezing user space proce=
sses ... =

    2020-09-01 20:01:00.643000  <4>[   39.908457] sbs-battery 20-000b: Unkn=
own chemistry: POLY
    2020-09-01 20:01:00.665000  <4>[   39.942978] (elapsed 0.198 seconds) d=
one.
    ... (122 line(s) more)
     * sleep.rtcwake-mem-6: https://kernelci.org/test/case/id/5f4ea993786d7=
bd33008111f
      new failure (last pass: v5.9-rc3-8-gd21006a798ed)

    2020-09-01 20:01:19.842000  <8>[   57.789700] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drtcwake-mem-5 RESULT=3Dpass>
    2020-09-01 20:01:19.857000  + lava-test-case rtcwake-mem-6 --shell rtcw=
ake -d rtc0 -m mem -s 5<8>[   57.801079] <LAVA_SIGNAL_STARTTC rtcwake-mem-6>
    2020-09-01 20:01:19.857000  =

    2020-09-01 20:01:19.865000  <4>[   57.814917] sbs-battery 20-000b: Unkn=
own chemistry: POLY
    2020-09-01 20:01:19.878000  rtcwake: assuming RTC uses UTC ...
    2020-09-01 20:01:19.878000  rtcwake: wakeup from \"mem\" using rtc0 at =
Tue Sep  1 20:01:26 2020
    2020-09-01 20:01:19.894000  <6>[   57.845145] PM: suspend entry (deep)
    2020-09-01 20:01:19.900000  <6>[   57.851502] Filesystems sync: 0.000 s=
econds
    2020-09-01 20:01:20.081000  <6>[   57.858866] Freezing user space proce=
sses ... (elapsed 0.169 seconds) done.
    2020-09-01 20:01:20.089000  <6>[   58.040833] OOM killer disabled.
    ... (155 line(s) more)
     * sleep.rtcwake-mem-7: https://kernelci.org/test/case/id/5f4ea993786d7=
bd330081120
      new failure (last pass: v5.9-rc3-8-gd21006a798ed)

    2020-09-01 20:01:32.088000  <8>[   69.833823] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drtcwake-mem-6 RESULT=3Dfail>
    2020-09-01 20:01:32.088000  <6>[   69.839798] hub 2-1:1.0: USB hub found
    2020-09-01 20:01:32.089000  <8>[   69.863363] <LAVA_SIGNAL_STARTTC rtcw=
ake-mem-7>
    2020-09-01 20:01:32.098000  <6>[   69.863960] hub 2-1:1.0: 5 ports dete=
cted
    2020-09-01 20:01:32.098000  <6>[   69.912288] PM: suspend entry (deep)
    2020-09-01 20:01:32.112000  <3>[   69.914710] rockchip-snd-max98090 sou=
nd: Soc register card failed -517
    2020-09-01 20:01:32.120000  <6>[   69.920872] Filesystems sync: 0.000 s=
econds
    2020-09-01 20:01:32.120000  <4>[   70.043610] sbs-battery 20-000b: Unkn=
own chemistry: POLY
    2020-09-01 20:01:32.151000  <6>[   70.044527] Freezing user space proce=
sses ... (elapsed 0.053 seconds) done.
    2020-09-01 20:01:32.156000  <6>[   70.109116] OOM killer disabled.
    ... (124 line(s) more)
     * sleep.rtcwake-mem-10: https://kernelci.org/test/case/id/5f4ea993786d=
7bd330081123
      new failure (last pass: v5.9-rc3-8-gd21006a798ed)

    2020-09-01 20:02:00.068000  + lava-test-case rtcwake-mem-10 --shell rtc=
wake -d rtc0 -m mem -s <8>[   91.635088] <LAVA_SIGNAL_STARTTC rtcwake-mem-1=
0>
    2020-09-01 20:02:00.068000  5
    2020-09-01 20:02:00.082000  <4>[   91.637172] sbs-battery 20-000b: Unkn=
own chemistry: POLY
    2020-09-01 20:02:00.082000  rtcwake: assuming RTC uses UTC ...
    2020-09-01 20:02:00.087000  rtcwake: wakeup from \"mem\" using rtc0 at =
Tue Sep  1 20:02:06 2020
    2020-09-01 20:02:00.107000  <6>[   91.680061] PM: suspend entry (deep)
    2020-09-01 20:02:00.113000  <6>[   91.686667] Filesystems sync: 0.000 s=
econds
    2020-09-01 20:02:00.424000  <6>[   91.694110] Freezing user space proce=
sses ... =

    2020-09-01 20:02:00.448000  <4>[   91.996421] sbs-battery 20-000b: Unkn=
own chemistry: POLY
    2020-09-01 20:02:00.468000  <4>[   92.010186] (elapsed 0.316 seconds) d=
one.
    ... (149 line(s) more)
     * sleep.rtcwake-freeze-2: https://kernelci.org/test/case/id/5f4ea99378=
6d7bd330081125
      new failure (last pass: v5.9-rc3-8-gd21006a798ed)

    2020-09-01 20:02:24.965000  <6>[  116.506077] smsc95xx 2-1.1:1.0 enx94e=
b2c000524: unregister 'smsc95xx' usb-ff580000.usb-1.1, smsc95xx USB 2.0 Eth=
ernet
    2020-09-01 20:02:24.976000  <8>[  116.517692] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drtcwake-freeze-1 RESULT=3Dpass>
    2020-09-01 20:02:24.992000  + lava-test-case rtcwake-freeze-2 --shell r=
tcwake -d rtc0 -m freez<8>[  116.561129] <LAVA_SIGNAL_STARTTC rtcwake-freez=
e-2>
    2020-09-01 20:02:25.006000  e -s 5
    2020-09-01 20:02:25.006000  rtcwake: assuming RTC uses UTC ...
    2020-09-01 20:02:25.006000  rtcwake: wakeup from \"freeze\" using rtc0 =
at Tue Sep  1 20:02:31 2020
    2020-09-01 20:02:25.022000  <6>[  116.596476] PM: suspend entry (s2idle)
    2020-09-01 20:02:25.030000  <6>[  116.603202] Filesystems sync: 0.000 s=
econds
    2020-09-01 20:02:25.038000  <6>[  116.610687] Freezing user space proce=
sses ... =

    2020-09-01 20:02:25.054000  <4>[  116.610798] sbs-battery 20-000b: Unkn=
own chemistry: POLY
    ... (130 line(s) more)
      =20
