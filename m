Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935663F50FC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhHWTEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 15:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhHWTE3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 15:04:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A425DC061575
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 12:03:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q21so1741227plq.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iSeNrdXqniyH63OC9MhNx2Z6wZNZXF+mBNf7q1WHfXk=;
        b=CPwmeIRn1c7h7wCWMmMBGquUe6gNQp4euoq4U35pDOx+vjAwlb+eyLzFNnvbcWzPv4
         E43D0L/pHkTsaYB2a/3TrW3USGixuZPLEl6VtjCXK76iE9Mg08L72fdV0pvydBrHu8pn
         /MuO6OOKzZE/yTvTB744+sh9i4JKSp5No5ie/T9u/lB2J7xL+sl+L00wr4BwvoyhXUvb
         zavWymg8FQ8lX51nXaPpHghHMvxcXQJ8uorsCLA/ZzQt3o5nEcAKf+FY59qR24rlYiF0
         +RJ9pAaYZ4vpGPPsd0tYljZ8babgdjgAKygXriG6F+An4jq08+6dnLHz1eG0O3EtrIiB
         7SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iSeNrdXqniyH63OC9MhNx2Z6wZNZXF+mBNf7q1WHfXk=;
        b=rAOnJ6sb3sUvgnZlIe+s3AXFjDvw3qHRycJywtG9svdtGgg7U+wyMNctLYVR9D+4K2
         YcSrgE5tbjtVp8ov2H/qozDgTY5gGK73aj4qgoGlvHQeFR56NCb1G++jdBH7cTPvSzoW
         3ncCe9dmPmx9SzD3/urxJpnjwtszINFm+QWWdZTvUqen/mH0CZeQR7dZ5MF8Mp4nRMBL
         sEtmAtBmMHSic20hDuVgEkH/1s0GeDEUtf+SLQkGLB7Gi3tg2bL2Zec6yYhnVZeb0M4i
         fPnKra59QG/sgn5ermQkMUoDbppNXMBVxTXyISY3Wd1ZEuz/sEY07WemNSv0g3IIoAu/
         iuTQ==
X-Gm-Message-State: AOAM533dI8libCX68g8WydpsSzRtbUan5/OjTEyXTLKFKwxtOBF3bCsD
        HePDhzGaolPuRxlS+zHNUhfSgQ==
X-Google-Smtp-Source: ABdhPJxoR0LBBKTtTMIZ0iwdWqGrcJ1B4MtfpzWnf5gbRCLdoO+ttSQjd4ccnSep++JOyOX2PBjWLQ==
X-Received: by 2002:a17:903:2441:b0:12d:c574:e654 with SMTP id l1-20020a170903244100b0012dc574e654mr29591737pls.43.1629745426144;
        Mon, 23 Aug 2021 12:03:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 143sm16565857pfx.1.2021.08.23.12.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:03:45 -0700 (PDT)
Message-ID: <6123f111.1c69fb81.7bbc7.06a0@mx.google.com>
Date:   Mon, 23 Aug 2021 12:03:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.14-rc7-50-gbd1cb9850313
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 87 runs,
 6 regressions (v5.14-rc7-50-gbd1cb9850313)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 87 runs, 6 regressions (v5.14-rc7-50-gbd1cb9850313)

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

meson-gxbb-p200  | arm64 | lab-baylibre  | gcc-8    | defconfig          | =
1          =

r8a77960-ulcb    | arm64 | lab-baylibre  | gcc-8    | defconfig          | =
1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
7-50-gbd1cb9850313/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc7-50-gbd1cb9850313
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      bd1cb9850313a606390b4b21b9d07b2ca9ede9b1 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
bcm2837-rpi-3-b  | arm64 | lab-baylibre  | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/6123ea65307419a6d28e2cbf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6123ea65307419a6d28e2=
cc0
        failing since 41 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6123e9054bc6f8efe78e2c7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6123e9054bc6f8efe78e2=
c7f
        failing since 17 days (last pass: v5.14-rc3-20-g604483c9d252, first=
 fail: v5.14-rc4-28-g9ac32de19606) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
meson-gxbb-p200  | arm64 | lab-baylibre  | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/6123e9f9916b98dd608e2c8a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6123e9f9916b98dd608e2=
c8b
        new failure (last pass: v5.14-rc6-60-g10bc7fbefe3a) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
r8a77960-ulcb    | arm64 | lab-baylibre  | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/6123e7302d9ec4e9368e2c96

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6123e7302d9ec4e9368e2=
c97
        new failure (last pass: v5.14-rc3-20-g604483c9d252) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:     https://kernelci.org/test/plan/id/6123ebf54b31f0c04d8e2ce3

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6123ebf54b31f0c04d8e2ce9
        failing since 41 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-08-23T18:58:56.952424  /lava-4401474/1/../bin/lava-test-case   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6123ebf54b31f0c04d8e2cea
        failing since 41 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-08-23T18:58:55.917690  /lava-4401474/1/../bin/lava-test-case
    2021-08-23T18:58:55.928687  <8>[   51.354942] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>   =

 =20
