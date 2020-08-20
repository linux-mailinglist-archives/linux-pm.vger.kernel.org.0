Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB8624C5F0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 20:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHTSzF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 14:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgHTSzD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 14:55:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA40C061385
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 11:55:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a79so1480818pfa.8
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=d/526QsQ/NFnFEvBHp0DITZQgZKAnda3R3d1pb+h4cY=;
        b=iaUT0ZXcWWsOUZ3ow1X91TTlQ2U+PThZalZN9jllIVavCB64JgI1wLnBT8A3dYJfjw
         c1w0/LNV+O9cC8T2crtKXOZYqNde1ase6ybQNdH1uVyay2Nav0DBQW+NFyCfAxrnVu/h
         RG12AekY17F4UIZ9v0gCFKocv8hAjRT5Hh3QDLE8VWELFWGxTTZrqgDdZ62U9bkbcsy2
         pQF4j7lo1oM3b4q54/xtxBXuxaHzu40RfkYT76fZsJjEgYqyYWPWWbZuHcFCe1GSdCeh
         IcTd3tGSITwbWIB/9Cf8F1EaZhI/kWLVfSL1V7CIpY59DFWpz3iaHCQmepKU6P6BGeFl
         uGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=d/526QsQ/NFnFEvBHp0DITZQgZKAnda3R3d1pb+h4cY=;
        b=JIOGVTCYBNm/iU5Td4XQ7/FFvmq/5m1MmKQi2gUJzX0zAOb/oKjqmegUdQfwQqSyAM
         JVAHCGbc26ZxGpce9iwNCzV+hT7S10ca3y8nCofOpHYOIi2/11P9YGEt+WBO+QEFDLIG
         /IO/CTKQMXFLz0LTsGa+e7zn3CPqUx3EzpkXkhqIh+5+VjPJR4tDJrjd5CvGTJw+rJlH
         piZk2OFmku/z/lurem8nsvOcCfLNSmV1G45dbkgVi+II/cmREztSnRl+Dwt0w+P/nssp
         I5gkO1iJe/9bRmh9vjZ72GfLzqtldwT46EuaCz1mi1w9LaBbU+vxe/kBGqa0tTxsoZ7G
         LeZQ==
X-Gm-Message-State: AOAM533eVTRhUPrLcXA4WGPi5FpxDCk/vS+CyIwxLYy6i2M60uUc5Lf6
        NDIAirAGoQIkrPQirh3Vg3a0fmxzZqcJMg==
X-Google-Smtp-Source: ABdhPJyH/kpkyfx97+K0QPfG+kBwSg4OSC9y7hpbzPzWhKU32O9X3e0z5fcDBW4oUkL16jxviFLCOQ==
X-Received: by 2002:a62:2704:: with SMTP id n4mr107951pfn.246.1597949701047;
        Thu, 20 Aug 2020 11:55:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f3sm3469819pfj.206.2020.08.20.11.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 11:55:00 -0700 (PDT)
Message-ID: <5f3ec704.1c69fb81.23c28.8930@mx.google.com>
Date:   Thu, 20 Aug 2020 11:55:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.9-rc1-4-gcc15fd9892e2
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 8 runs, 2 regressions (v5.9-rc1-4-gcc15fd9892e2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 8 runs, 2 regressions (v5.9-rc1-4-gcc15fd9892e2)

Regressions Summary
-------------------

platform             | arch  | lab           | compiler | defconfig        =
  | results
---------------------+-------+---------------+----------+------------------=
--+--------
exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_defconfi=
g | 0/1    =

mt8173-elm-hana      | arm64 | lab-collabora | gcc-8    | defconfig        =
  | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc1=
-4-gcc15fd9892e2/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc1-4-gcc15fd9892e2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      cc15fd9892e28689b6e17dbd6e28d00c55d62928 =



Test Regressions
---------------- =



platform             | arch  | lab           | compiler | defconfig        =
  | results
---------------------+-------+---------------+----------+------------------=
--+--------
exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_defconfi=
g | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3ebbcd9b82c99c50d99a50

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu3=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu3=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0814.0/armhf/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f3ebbcd9b82c99c50d99a51
      new failure (last pass: v5.9-rc1-4-g1f08d51cd57f)  =



platform             | arch  | lab           | compiler | defconfig        =
  | results
---------------------+-------+---------------+----------+------------------=
--+--------
mt8173-elm-hana      | arm64 | lab-collabora | gcc-8    | defconfig        =
  | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3eba601adf47c8fad99a3f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-gcc15fd9=
892e2/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0814.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f3eba601adf47c8fad99a40
      failing since 0 day (last pass: v5.8-107-gb72b3ea38c81, first fail: v=
5.9-rc1-4-g1f08d51cd57f)  =20
