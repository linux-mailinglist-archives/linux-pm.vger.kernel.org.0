Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3578940A231
	for <lists+linux-pm@lfdr.de>; Tue, 14 Sep 2021 02:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhINAxe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 20:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhINAxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 20:53:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A93C061574
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 17:52:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v19so4974339pjh.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 17:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6SvdJezFGnS1Pg90DmwCu1jZCTg+spV3prwU5u5ZBNQ=;
        b=Wwgr90fQg1f22C/3huHGrSDrD+hCapp4BtC1SuOP2MhsYdZAZY5wzHnGukCwmMgg9b
         lYchxmYeEbeBiCtu+B17OwMp2JYnvULthOpu95GA947HJDxlaAz9YPipUBqXxtzm8nmb
         UnrWxb29ZdempLrDKo5Zb6Vfc070lSsSV2F0I1QMI+kt+lPddtdhaVh/NVWfFILMFpb7
         6CFaJ+HI3+AIU9CrsrToeQ96qAI9Y28MYf3UrZotflvlHirGAYpypVJ6BjmBCRjtElMe
         /rZhAnFwBO0ogZN/+H2/rrHKTtZdAuDVMWinVKpDZh+sLPtOMTUf0dbg1i3uOKe4xUfG
         KI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6SvdJezFGnS1Pg90DmwCu1jZCTg+spV3prwU5u5ZBNQ=;
        b=eWIjV9Fuiph9GK7+HGt6RtvPwEPsSPvnC/7BU/0ITEjg6MESkdDfWieqtqD8KyNN3a
         fDuoUjywISXmwZk9PUMtwyvnrp0P3rxfF1YVEc0bwVbOoftLDGNdl1NDIUsf+oHJrXxM
         wq6W5mbZeNZCz5pvPgJjlfcSHVasDJsJIjbX9DS1GiGv8TCraNvYFcVuaDMZ7wpIASyE
         2Z+mFa1YWwqTRgjy1kGTkN/omkm8HslOIyLlnMUJ9Fu3ex5KJaz0zcgUGgixM54kF0cX
         IM5CU8SKiCZ/DTzmJ4SOPKdylqPMCPifcuqMxqeTK+LPJlgdbiwmvSeLwhTHr2lEm5LT
         CVuQ==
X-Gm-Message-State: AOAM530+3C1BnPS3VhbYGIJKSjWxe3rw7MT67Tu1iZyr2hH4TOOUWt+v
        axaru93DuceVd4rVlhoKYqFbEw==
X-Google-Smtp-Source: ABdhPJx6BJRF4+IoK896MZFa/qC+r1O+lVMpdw+JleB9Fxmyvp5JG0bXwjfvgxOkdkiSLqZt+UlA1Q==
X-Received: by 2002:a17:90a:7848:: with SMTP id y8mr2407150pjl.229.1631580736663;
        Mon, 13 Sep 2021 17:52:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p16sm8024648pfw.66.2021.09.13.17.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 17:52:16 -0700 (PDT)
Message-ID: <613ff240.1c69fb81.2eb82.7cb1@mx.google.com>
Date:   Mon, 13 Sep 2021 17:52:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc1
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 98 runs, 7 regressions (v5.15-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 98 runs, 7 regressions (v5.15-rc1)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
bcm2837-rpi-3-b  | arm64 | lab-baylibre  | gcc-8    | defconfig          | =
1          =

beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =

imx8mn-ddr4-evk  | arm64 | lab-nxp       | gcc-8    | defconfig          | =
2          =

imx8mp-evk       | arm64 | lab-nxp       | gcc-8    | defconfig          | =
1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
1/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
bcm2837-rpi-3-b  | arm64 | lab-baylibre  | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/613fe87364f603930999a2fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc1/arm64/def=
config/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc1/arm64/def=
config/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613fe87364f603930999a=
2fe
        failing since 63 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/613fe90b5b64304e1c99a2fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc1/arm/multi=
_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc1/arm/multi=
_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613fe90b5b64304e1c99a=
2fb
        failing since 39 days (last pass: v5.14-rc3-20-g604483c9d252, first=
 fail: v5.14-rc4-28-g9ac32de19606) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
imx8mn-ddr4-evk  | arm64 | lab-nxp       | gcc-8    | defconfig          | =
2          =


  Details:     https://kernelci.org/test/plan/id/613fe8e0d5ef0fa73f99a2e4

  Results:     4 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc1/arm64/def=
config/gcc-8/lab-nxp/baseline-imx8mn-ddr4-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc1/arm64/def=
config/gcc-8/lab-nxp/baseline-imx8mn-ddr4-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/613fe8e0d5ef0fa=
73f99a2eb
        new failure (last pass: v5.14-rc7-64-g2a7254aa7491)
        12 lines =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/613fe8e0d5ef0fa=
73f99a2ec
        new failure (last pass: v5.14-rc7-64-g2a7254aa7491)
        2 lines

    2021-09-14T00:11:55.256743  kern  :alert : Unable to handle kernel NULL=
 pointer dereference <8>[   14.280483] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=
=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D12>
    2021-09-14T00:11:55.256853  at virtual address 0000000000000098
    2021-09-14T00:11:55.256957  kern  :alert : Mem abort info:
    2021-09-14T00:11:55.257092  kern  :alert :   ESR =3D 0x96000046
    2021-09-14T00:11:55.257221  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), IL =3D 32 bits
    2021-09-14T00:11:55.257325  kern  :alert :   SET =3D <8>[   14.305715] =
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEAS=
UREMENT=3D2>
    2021-09-14T00:11:55.257423  0, FnV =3D 0   =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
imx8mp-evk       | arm64 | lab-nxp       | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/613feb8c44e35555e299a352

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc1/arm64/def=
config/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc1/arm64/def=
config/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613feb8c44e35555e299a=
353
        new failure (last pass: v5.14-rc7-64-g2a7254aa7491) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:     https://kernelci.org/test/plan/id/613febda37e0c7de3999a2ff

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc1/arm64/def=
config/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc1/arm64/def=
config/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/613febda37e0c7de3999a305
        failing since 63 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-14T00:24:36.562010  /lava-4515636/1/../bin/lava-test-case
    2021-09-14T00:24:36.573854  <8>[   52.505185] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/613febda37e0c7de3999a306
        failing since 63 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-14T00:24:34.505354  <8>[   50.435484] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>
    2021-09-14T00:24:35.528590  /lava-4515636/1/../bin/lava-test-case
    2021-09-14T00:24:35.539763  <8>[   51.471359] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>   =

 =20
