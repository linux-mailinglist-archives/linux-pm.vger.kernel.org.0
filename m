Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6C254717
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 16:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgH0Oik (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 10:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgH0Oi0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 10:38:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9DBC061264
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 07:38:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z18so2740045pjr.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zrRrQGfoO0ddOxi7PYi7aTNT8ciuizZWgpmjxW52rmw=;
        b=s3T7BkDNxcCNHOukmju4miCaTHTf1jmq4h+U/qxNF2hH9yRC6Wh/gkvizEtgnJfASZ
         bWO52UMszaeTEwYYn/pMt79n4ja5Dzn4mcsOH3oonWU5iPqez1QipSyozO18+sdgRyUZ
         XVtynplx65AZ5zQBGrs79JpDRfV7qkAESghHbClV6Py7BxZ9Lt+pFPsGENDxGw2K6/kY
         0M9JPzfmB4LCY3zSmuIM6h5r4SAto2CF5x0lFeAPdRA2WZyQaiIHWMYWU4K8UzjOU5zw
         0DtE+ErW6SqdQ+IOFLzE5R3LjZC1EkmezLhHSU7WZSi9mMmLhS92laef/S/GT8UsGP9v
         l/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zrRrQGfoO0ddOxi7PYi7aTNT8ciuizZWgpmjxW52rmw=;
        b=PgQTjvZP9ej5fkYsSev9xGJAqlxXjG4BY/3dqj2I70Yf+W4mQDIdVOOdU7m1uq9hwV
         11aMtUmVBi+GNo/4tTUdnPeC+VRXEKqfLhjJtCtz3GtlfFmFPlARPITaUyh5bsI8l62Q
         rhg4b0vPSls+tGzQ8zQZGCUC18qnXglPW7cFRFX6p47dr6Pv10tkfuAOugjEL8jzz17W
         CQSLioP8iPW5Ye6ySM7vtKolnnGRVVbP6cQv2MwcJPcBefRXCfc/X7fY6Fzw1f8amQCT
         ZPYv/Mj1jTtySQvUgVCq242ORqlL2u03d+pDxpvMor7i1BOEAhX/e+ZzqpXzB47M0lqN
         bD8Q==
X-Gm-Message-State: AOAM533lHkZPdMRIL8GjLTl1ZYGdM2Jg7PP7X2nCOmVJaUorZdSd7b5e
        AOr+9ySc0EyTsZZBtFCnu+BWqg==
X-Google-Smtp-Source: ABdhPJybPQfcolKYsTB22tbNnuyAWraG5yXLzmp7MBofDMEUs8rwfsM7bk1RlEb6hljiWXDTl+ulSQ==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr11436048pjg.197.1598539104294;
        Thu, 27 Aug 2020 07:38:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e17sm3119394pfm.60.2020.08.27.07.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:38:23 -0700 (PDT)
Message-ID: <5f47c55f.1c69fb81.56ed1.98c7@mx.google.com>
Date:   Thu, 27 Aug 2020 07:38:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc2-17-gdc37b29f6d30
Subject: pm/testing baseline: 107 runs,
 7 regressions (v5.9-rc2-17-gdc37b29f6d30)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 107 runs, 7 regressions (v5.9-rc2-17-gdc37b29f6d30)

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

sun50i-a64-pine64-plus    | arm64 | lab-baylibre  | gcc-8    | defconfig   =
       | 0/1    =

sun7i-a20-cubieboard2     | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =

sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc2=
-17-gdc37b29f6d30/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc2-17-gdc37b29f6d30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      dc37b29f6d3007e72ff3de80fcbeeed75843cfed =



Test Regressions
---------------- =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
bcm2837-rpi-3-b           | arm64 | lab-baylibre  | gcc-8    | defconfig   =
       | 3/4    =


  Details:     https://kernelci.org/test/plan/id/5f47bb822cc58cb1479fb454

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5f47bb822cc58cb1=
479fb458
      failing since 0 day (last pass: v5.9-rc2-12-g4958dfca3d0f, first fail=
: v5.9-rc2-14-gfe784821d630)
      1 lines

    2020-08-27 13:54:09.767000  Connected to bcm2837-rpi-3-b console [chann=
el connected] (~$quit to exit)
    2020-08-27 13:54:09.767000  (user:khilman) is already connected
    2020-08-27 13:54:24.783000  =00
    2020-08-27 13:54:24.783000  =

    2020-08-27 13:54:24.783000  U-Boot 2018.11 (Dec 04 2018 - 10:54:32 -080=
0)
    2020-08-27 13:54:24.784000  =

    2020-08-27 13:54:24.784000  DRAM:  948 MiB
    2020-08-27 13:54:24.798000  RPI 3 Model B (0xa02082)
    2020-08-27 13:54:24.885000  MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
    2020-08-27 13:54:24.918000  Loading Environment from FAT... *** Warning=
 - bad CRC, using default environment
    ... (380 line(s) more)
      =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
exynos5422-odroidxu3      | arm   | lab-collabora | gcc-8    | multi_v7_def=
config | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f47bff4ffbfec3ce39fb42f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odroi=
dxu3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odroi=
dxu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f47bff4ffbfec3ce39fb=
430
      failing since 27 days (last pass: v5.8-rc7-94-g89beac5dc8d0, first fa=
il: v5.8-rc7-107-g97987ea7f86a)  =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
mt8173-elm-hana           | arm64 | lab-collabora | gcc-8    | defconfig   =
       | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f47bc27456f49c30c9fb42d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f47bc27456f49c30c9fb=
42e
      failing since 7 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
omap4-panda               | arm   | lab-collabora | gcc-8    | multi_v7_def=
config | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f47bb4eda61ee93a79fb437

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f47bb4eda61ee9=
3a79fb43d
      failing since 7 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-08-27 13:55:19.953000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-08-27 13:55:19.959000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-08-27 13:55:19.965000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-08-27 13:55:19.971000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-08-27 13:55:19.977000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-08-27 13:55:19.983000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-08-27 13:55:19.988000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-08-27 13:55:19.994000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-08-27 13:55:20  kern  :alert : BUG: Bad page state in process swap=
per/0  pfn:9c80a
    2020-08-27 13:55:20.006000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
sun50i-a64-pine64-plus    | arm64 | lab-baylibre  | gcc-8    | defconfig   =
       | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f47bcdc283cc049099fb452

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f47bcdc283cc049099fb=
453
      failing since 7 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
sun7i-a20-cubieboard2     | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f47bb4d8831c8d0c29fb42e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubiebo=
ard2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubiebo=
ard2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f47bb4d8831c8d0c29fb=
42f
      failing since 7 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f47bf8848f49f877d9fb42f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-olinuxi=
no-lime2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-olinuxi=
no-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f47bf8848f49f877d9fb=
430
      failing since 7 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =20
