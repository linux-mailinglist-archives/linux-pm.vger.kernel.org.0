Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2BA24C5B9
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHTSkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgHTSkF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 14:40:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00893C061385
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 11:40:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kr4so1355365pjb.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=kvILieHCnqNhwB04DxwS84+cfz6Y7DPJWyB2j+GcfhY=;
        b=soMFkkqUVIagRHr1ExNkB8H7hyNfsVyMHJ49d8Wf8MsQ79gjnz9rRCUmY/X7nUluXg
         E/hJGuKaM2Q8AbBSGmvGsXY+gqrxndQuV69Eeq0rkcWLQh6uGFsvNAxx67W9y99uBtxe
         GXyAnj1ZlGPftVU+7s8KRzVOlf08wIxXip03ZAueJ7fKUOWtKuxVU1GmXSoGK5Dzc6fI
         oIDd6ESXiFGdqFvFdK1VSM9mDiWRJDbkKQM7JVH2NlQ/8iLD87ONwkrifc8W+7w7WGuR
         E97hBT4JoJp5NEOBQl88VBy2jA2dYK9GCz4B2uFNoh0c0pHmu1KWITfZOf6jZjY3y6ty
         hhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=kvILieHCnqNhwB04DxwS84+cfz6Y7DPJWyB2j+GcfhY=;
        b=FQCPBW7rnR24Yk6Ukpv3yFq/8MreNqU8uylCrBc0yLKJhmdo0xGaSjAyAhvNyM1ch7
         80rPF/Vts+mJOvL8uWe6t2idEuKbNu89HNVqVH2emx4o2yCcdqv8TA3PeioY5v/zt8vU
         k83bLTJ2lDy5nvAs6KeMeHXbFsNY3ECAz4C9CDX7ZkxxNLagq8crUG234v5r2q3eXaJe
         PyjrLQdjbK6dDT2y2Qq+ealkOc+f6qsBqq3sJGADUFGCM/U+s37jFm1MHhulIRn6aEDi
         +8vxph6/0w3Q+i2GHM19GAXG8ibQPo/nbaQx3Nh5Xp5WNlj99IyWzkrdFRU0Bk+5HYVB
         x6VA==
X-Gm-Message-State: AOAM531YKXO0NTvJybtu4vgFVONB5zbBq82uk3X0twRR9SJ55gGYKiq6
        Hr6L/c/e0CSAOMBFA4E/tw1m6A==
X-Google-Smtp-Source: ABdhPJxBX0zymPuX9jtIPgV3LqxXdNPL5O9JNqprCa+PRQIzP9AGyUkYDbu7GrWxF8OKDNxzXwXsnQ==
X-Received: by 2002:a17:902:b203:: with SMTP id t3mr3444245plr.50.1597948801622;
        Thu, 20 Aug 2020 11:40:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s125sm3861316pfc.63.2020.08.20.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 11:40:00 -0700 (PDT)
Message-ID: <5f3ec380.1c69fb81.79a6c.9289@mx.google.com>
Date:   Thu, 20 Aug 2020 11:40:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.9-rc1-4-gcc15fd9892e2
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 104 runs,
 8 regressions (v5.9-rc1-4-gcc15fd9892e2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 104 runs, 8 regressions (v5.9-rc1-4-gcc15fd9892e2)

Regressions Summary
-------------------

platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
bcm2837-rpi-3-b           | arm64 | lab-baylibre  | gcc-8    | defconfig   =
       | 3/4    =

exynos5422-odroidxu3      | arm   | lab-collabora | gcc-8    | multi_v7_def=
config | 0/1    =

mt8173-elm-hana           | arm64 | lab-collabora | gcc-8    | defconfig   =
       | 0/1    =

omap4-panda               | arm   | lab-collabora | gcc-8    | multi_v7_def=
config | 4/5    =

rk3399-gru-kevin          | arm64 | lab-collabora | gcc-8    | defconfig   =
       | 84/88  =

sun50i-a64-pine64-plus    | arm64 | lab-baylibre  | gcc-8    | defconfig   =
       | 0/1    =

sun7i-a20-cubieboard2     | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =

sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc1=
-4-gcc15fd9892e2/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc1-4-gcc15fd9892e2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      cc15fd9892e28689b6e17dbd6e28d00c55d62928 =



Test Regressions
---------------- =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
bcm2837-rpi-3-b           | arm64 | lab-baylibre  | gcc-8    | defconfig   =
       | 3/4    =


  Details:     https://kernelci.org/test/plan/id/5f3eb9899938b1e44ed99a3b

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5f3eb9899938b1e4=
4ed99a3d
      new failure (last pass: v5.9-rc1-4-g1f08d51cd57f)
      2 lines

    2020-08-20 17:57:13.372000  / # =

    2020-08-20 17:57:13.382000  =

    2020-08-20 17:57:13.487000  / # #
    2020-08-20 17:57:13.496000  #
    2020-08-20 17:57:14.760000  / # export SHELL=3D/bin/sh
    2020-08-20 17:57:14.772000  export SHELL=3D/bin/sh
    2020-08-20 17:57:16.333000  / # . /lava-11416/environment
    2020-08-20 17:57:16.344000  .[   27.963095] hwmon hwmon1: Undervoltage =
detected!
    2020-08-20 17:57:16.344000   /lava-11416/environment
    2020-08-20 17:57:19.172000  / # /lava-11416/bin/lava-test-runner /lava-=
11416/0
    ... (10 line(s) more)
      =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
exynos5422-odroidxu3      | arm   | lab-collabora | gcc-8    | multi_v7_def=
config | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3eb93d4575b7a583d99a53

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odroid=
xu3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odroid=
xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f3eb93d4575b7a583d99=
a54
      failing since 20 days (last pass: v5.8-rc7-94-g89beac5dc8d0, first fa=
il: v5.8-rc7-107-g97987ea7f86a)  =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
mt8173-elm-hana           | arm64 | lab-collabora | gcc-8    | defconfig   =
       | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3eba58ce784ce4b3d99a3c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f3eba58ce784ce4b3d99=
a3d
      failing since 0 day (last pass: v5.8-107-gb72b3ea38c81, first fail: v=
5.9-rc1-4-g1f08d51cd57f)  =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
omap4-panda               | arm   | lab-collabora | gcc-8    | multi_v7_def=
config | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f3eb87800042a4fb5d99a39

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f3eb87800042a4=
fb5d99a3d
      failing since 0 day (last pass: v5.8-107-gb72b3ea38c81, first fail: v=
5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-08-20 17:52:50.336000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c801
    2020-08-20 17:52:50.342000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-08-20 17:52:50.347000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-08-20 17:52:50.354000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-08-20 17:52:50.360000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-08-20 17:52:50.366000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-08-20 17:52:50.372000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-08-20 17:52:50.377000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-08-20 17:52:50.383000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-08-20 17:52:50.389000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    ... (50 line(s) more)
      =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
rk3399-gru-kevin          | arm64 | lab-collabora | gcc-8    | defconfig   =
       | 84/88  =


  Details:     https://kernelci.org/test/plan/id/5f3eb97589d3b54ca0d99a3c

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.bootrr.rockchip-pcie-probed: https://kernelci.org/test/case/id=
/5f3eb97689d3b54ca0d99a7c
      failing since 0 day (last pass: v5.8-107-gb72b3ea38c81, first fail: v=
5.9-rc1-4-g1f08d51cd57f)

    2020-08-20 17:57:04.856000  <8>[   52.505274] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-pcie-driver-present RESULT=3Dpass>
    2020-08-20 17:57:05.877000  /lava-2558972/1/../bin/lava-test-case
      =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
sun50i-a64-pine64-plus    | arm64 | lab-baylibre  | gcc-8    | defconfig   =
       | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3ebb3f9b82c99c50d99a3e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f3ebb3f9b82c99c50d99=
a3f
      failing since 0 day (last pass: v5.8-107-gb72b3ea38c81, first fail: v=
5.9-rc1-4-g1f08d51cd57f)  =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
sun7i-a20-cubieboard2     | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3eb929365a4ec0e8d99a41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubieboa=
rd2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubieboa=
rd2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f3eb929365a4ec0e8d99=
a42
      failing since 0 day (last pass: v5.8-107-gb72b3ea38c81, first fail: v=
5.9-rc1-4-g1f08d51cd57f)  =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3ebb409b82c99c50d99a41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-olinuxin=
o-lime2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-olinuxin=
o-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f3ebb409b82c99c50d99=
a42
      failing since 0 day (last pass: v5.8-107-gb72b3ea38c81, first fail: v=
5.9-rc1-4-g1f08d51cd57f)  =20
