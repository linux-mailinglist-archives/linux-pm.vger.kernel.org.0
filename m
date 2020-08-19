Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358ED24A6DF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 21:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHST21 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 15:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHST2Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 15:28:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD87DC061757
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 12:28:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u20so12190460pfn.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ERjIikN0vvxlZaV38oFj2g0kks7/zBj2hwpMslj8PRE=;
        b=vwdUeyuZaIBha31QTqp0Esr+A1yH/1A9LiIHX15iFPqLmcIUjyCSveHs5g5TRqBbG+
         Uqk/+l4lYg2hgc4YPnl9aQsOT9UqmZdIUF+iYu0Ts+HaZVuRz4Fi7kUJiAfyz/GVuo5h
         h05cZMsPJQgEoj5dd22uZ6+5Xh0xrfltoOWN/1ppbj9yoNYAm6KnpvTzuGnOE1LLtnHT
         M37uGaa24paF20eHgCD4Yz7sWv+oUB541T7dT3pimYvQ+APgigVmGdjSzR+4C/ZvQyht
         YQpMP6FmGSHJUn5LVa8LbXYxS7dp5b/BLAarfWAL3MDsI/VzTBPIpNbc3OuXDT0/HSWN
         vjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ERjIikN0vvxlZaV38oFj2g0kks7/zBj2hwpMslj8PRE=;
        b=eBfMXsI7MRjg4VEVgliFbeARB87yk+unFYx1+mWeCQFstvIts7+yfIzFXpjOcNr5BA
         6OiwvzFeA2k/I14qXVF4LxTH1KDS5ubc11zMT5nQBk72NEelDfnUaTxiINAtDQxbsZ7N
         9Ysx80ovFJHKk1hM2sJSMLemI7s43Vqpgcxgzt0dHU6lLLf2yjeV3p9G9s6M2X4kUbKN
         Iqm7H5RJmIhk9mfPseeCmMfboG4VMR1QJFNL6AVGV2EEReSvDua/+mGt+n9cPnDvMCwG
         YyF8IUOx9tNQUI64mxJbFm2w8ZM5YPYL5u1upmUqQBGNHQrqma3PlrXcic9gK+1nGzum
         gjgw==
X-Gm-Message-State: AOAM532e7J6RRmXBhDhvFkB29nEUQX4E0cGGHIUcy8VfjGYm3WJ7vu4v
        g70H74Lt35H+3pEeViM7PRHND6pV5SGyDQ==
X-Google-Smtp-Source: ABdhPJzm15qNS/fQ3WzYaYSKoElYVPufJn/fObYYKATHsbWJvBGGFRzElI+W3jfI003OMS6Mx3l9iw==
X-Received: by 2002:a05:6a00:1344:: with SMTP id k4mr19422436pfu.131.1597865305180;
        Wed, 19 Aug 2020 12:28:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g5sm3881133pjx.53.2020.08.19.12.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:28:24 -0700 (PDT)
Message-ID: <5f3d7d58.1c69fb81.71ec8.8a6c@mx.google.com>
Date:   Wed, 19 Aug 2020 12:28:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.9-rc1-4-g1f08d51cd57f
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 92 runs, 7 regressions (v5.9-rc1-4-g1f08d51cd57f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 92 runs, 7 regressions (v5.9-rc1-4-g1f08d51cd57f)

Regressions Summary
-------------------

platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
exynos5422-odroidxu3   | arm   | lab-collabora | gcc-8    | multi_v7_defcon=
fig | 0/1    =

mt8173-elm-hana        | arm64 | lab-collabora | gcc-8    | defconfig      =
    | 0/1    =

omap4-panda            | arm   | lab-baylibre  | gcc-8    | multi_v7_defcon=
fig | 3/4    =

omap4-panda            | arm   | lab-collabora | gcc-8    | multi_v7_defcon=
fig | 4/5    =

rk3399-gru-kevin       | arm64 | lab-collabora | gcc-8    | defconfig      =
    | 84/88  =

sun50i-a64-pine64-plus | arm64 | lab-baylibre  | gcc-8    | defconfig      =
    | 0/1    =

sun7i-a20-cubieboard2  | arm   | lab-baylibre  | gcc-8    | multi_v7_defcon=
fig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc1=
-4-g1f08d51cd57f/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc1-4-g1f08d51cd57f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1f08d51cd57fddbecc396183e544b1d6df98cbfa =



Test Regressions
---------------- =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
exynos5422-odroidxu3   | arm   | lab-collabora | gcc-8    | multi_v7_defcon=
fig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3d754a3631905ebad99a39

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odroid=
xu3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odroid=
xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f3d754a3631905ebad99=
a3a
      failing since 19 days (last pass: v5.8-rc7-94-g89beac5dc8d0, first fa=
il: v5.8-rc7-107-g97987ea7f86a)  =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
mt8173-elm-hana        | arm64 | lab-collabora | gcc-8    | defconfig      =
    | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3d6be372102f2b86d99a59

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f3d6be372102f2b86d99=
a5a
      new failure (last pass: v5.8-107-gb72b3ea38c81)  =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
omap4-panda            | arm   | lab-baylibre  | gcc-8    | multi_v7_defcon=
fig | 3/4    =


  Details:     https://kernelci.org/test/plan/id/5f3d73c7c47d209e34d99a3d

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-omap4-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-omap4-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f3d73c7c47d209=
e34d99a40
      new failure (last pass: v5.8-107-gb72b3ea38c81)
      60 lines

    2020-08-19 18:47:24.097000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c801
    2020-08-19 18:47:24.102000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-08-19 18:47:24.106000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-08-19 18:47:24.112000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-08-19 18:47:24.117000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-08-19 18:47:24.123000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-08-19 18:47:24.132000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-08-19 18:47:24.138000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-08-19 18:47:24.143000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-08-19 18:47:24.147000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    ... (50 line(s) more)
      =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
omap4-panda            | arm   | lab-collabora | gcc-8    | multi_v7_defcon=
fig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f3d7341d632b501f8d99a53

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f3d7341d632b50=
1f8d99a57
      new failure (last pass: v5.8-107-gb72b3ea38c81)
      60 lines

    2020-08-19 18:45:14.636000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c801
    2020-08-19 18:45:14.642000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-08-19 18:45:14.648000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-08-19 18:45:14.654000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-08-19 18:45:14.660000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-08-19 18:45:14.666000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-08-19 18:45:14.672000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-08-19 18:45:14.678000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-08-19 18:45:14.684000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-08-19 18:45:14.690000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    ... (50 line(s) more)
      =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
rk3399-gru-kevin       | arm64 | lab-collabora | gcc-8    | defconfig      =
    | 84/88  =


  Details:     https://kernelci.org/test/plan/id/5f3d6bfd1acb1e7978d99a44

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.bootrr.rockchip-pcie-probed: https://kernelci.org/test/case/id=
/5f3d6bfd1acb1e7978d99a84
      new failure (last pass: v5.8-107-gb72b3ea38c81)

    2020-08-19 18:14:14.178000  <8>[   52.550832] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-pcie-driver-present RESULT=3Dpass>
    2020-08-19 18:14:15.199000  /lava-2556232/1/../bin/lava-test-case
    2020-08-19 18:14:15.209000  <8>[   53.584107] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-pcie-probed RESULT=3Dfail>
      =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
sun50i-a64-pine64-plus | arm64 | lab-baylibre  | gcc-8    | defconfig      =
    | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3d744938f24dabe8d99a39

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f3d744938f24dabe8d99=
a3a
      new failure (last pass: v5.8-107-gb72b3ea38c81)  =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
sun7i-a20-cubieboard2  | arm   | lab-baylibre  | gcc-8    | multi_v7_defcon=
fig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3d74088ac8bff82dd99a3d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubieboa=
rd2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubieboa=
rd2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f3d74088ac8bff82dd99=
a3e
      new failure (last pass: v5.8-107-gb72b3ea38c81)  =20
