Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D71D1E6B
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 21:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390311AbgEMTAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 15:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMTAX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 15:00:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE066C061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 12:00:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n18so160932pfa.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8deakj/iH3PvU/eQL5iYzeICK++X/6wYDfc5CZJz61g=;
        b=cJp3MtuOAJLz7OgmZazx7h3qOWbq+9PvPnzLr7w+I9E8+A0P3wbBu6T4bGkq9XOPbO
         K0nV7NkGcJWfLwFXGN14MesYW0sZzynHsI8cE5EnEgNCprDkrt20jcW2Lmb4dCwAmYXS
         qts/2j8Ft/ktqU+2akUFGgkuHYz2sFztp871WRs+T9DJdDaElu33szBgDKiDZBLtQ81t
         Qc5OkwNoXh969VL4ziD0EUrZeu4t0Mlc+8H9PJYASDZMggjEP4/ySCHLnXBFMxdGHcd5
         o+6KBlhypfyO1WmLJVv+VgDPB8iiZmi4yrKsr9h7y00mV1cEBBFrmkXYGeKM3Qsjkia1
         fe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8deakj/iH3PvU/eQL5iYzeICK++X/6wYDfc5CZJz61g=;
        b=eBaNv0ygIwy0z43V3cC1lrIf3hG3sGCJhVIIwn+r8vp8EoeAv4J3jUjXn7rW41u7dO
         4mXBIgv3na5iPUyI85WW6q2qICiXAIfa533jAfvj2wCedyQPM3cK4mTmJGy8gJ1oifNN
         rW6CVMG+/W08sAy/uYJ2p2r6nJQhiGaQxWBk/mvdtDOqoyR+UnKQDyQ5JB32Xb7zYfoj
         YkYFsZDxH+4ea+mfaqwdMHhAKW3Sgl7tlo+rameFwDuggP7nN6gr1K5/JY9aXJGngUv5
         dPNDEezRcvyZXgJfoDQGMmgR6bDlfRZSk8nVii2jJbAu8W5uVRKgKHsX2AkUupyROhAp
         aADg==
X-Gm-Message-State: AOAM533AAidN9+MzMwbm0jKUvE5cNnkvCj/FxkVOoR33kHxuus0Q93RX
        NSzLPCjkk30mHEEQkopFY4LPyA==
X-Google-Smtp-Source: ABdhPJwdOoCkn/ltVfNCd+DLmwLwINbRhfxni1y+sac1QsEXJx+Cj7VDgDHW4q8KRNdxixz7nUSLeQ==
X-Received: by 2002:a63:2cd5:: with SMTP id s204mr692147pgs.140.1589396422463;
        Wed, 13 May 2020 12:00:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a2sm253137pfg.106.2020.05.13.12.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 12:00:21 -0700 (PDT)
Message-ID: <5ebc43c5.1c69fb81.c79dd.1265@mx.google.com>
Date:   Wed, 13 May 2020 12:00:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc5-53-gfbe093dd16f4
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs, 0 regressions (v5.7-rc5-53-gfbe093dd16f4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 0 regressions (v5.7-rc5-53-gfbe093dd16f4)

Test results summary
--------------------

run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =

2   | exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

5   | rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

6   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 11/11  =

7   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc5-53-gfbe093dd16f4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fbe093dd16f4eb35746ca73c063d6290a494a93a =



Test Failures
-------------
  =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-53-gfbe093=
dd16f4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-53-gfbe093=
dd16f4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0424.0/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

         =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-53-gfbe093=
dd16f4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-53-gfbe093=
dd16f4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0424.0/armhf/rootfs.cpio.gz  =


  21 tests: 1 PASS, 20 FAIL, 0 SKIP
    * rtcwake-mem-1:
        never passed
    * rtcwake-mem-2:
        never passed
    * rtcwake-mem-3:
        never passed
    * rtcwake-mem-4:
        never passed
    * rtcwake-mem-5:
        never passed
    * rtcwake-mem-6:
        never passed
    * rtcwake-mem-7:
        never passed
    * rtcwake-mem-8:
        never passed
    * rtcwake-mem-9:
        never passed
    * rtcwake-mem-10:
        never passed
    * rtcwake-freeze-1:
        never passed
    * rtcwake-freeze-2:
        never passed
    * rtcwake-freeze-3:
        never passed
    * rtcwake-freeze-4:
        never passed
    * rtcwake-freeze-5:
        never passed
    * rtcwake-freeze-6:
        never passed
    * rtcwake-freeze-7:
        never passed
    * rtcwake-freeze-8:
        never passed
    * rtcwake-freeze-9:
        never passed
    * rtcwake-freeze-10:
        never passed   =

      =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-53-gfbe093=
dd16f4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-53-gfbe093=
dd16f4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0424.0/armhf/rootfs.cpio.gz  =


  21 tests: 1 PASS, 20 FAIL, 0 SKIP
    * rtcwake-mem-1:
        never passed
    * rtcwake-mem-2:
        never passed
    * rtcwake-mem-3:
        never passed
    * rtcwake-mem-4:
        never passed
    * rtcwake-mem-5:
        never passed
    * rtcwake-mem-6:
        never passed
    * rtcwake-mem-7:
        never passed
    * rtcwake-mem-8:
        never passed
    * rtcwake-mem-9:
        never passed
    * rtcwake-mem-10:
        never passed
    * rtcwake-freeze-1:
        never passed
    * rtcwake-freeze-2:
        never passed
    * rtcwake-freeze-3:
        never passed
    * rtcwake-freeze-4:
        never passed
    * rtcwake-freeze-5:
        never passed
    * rtcwake-freeze-6:
        never passed
    * rtcwake-freeze-7:
        never passed
    * rtcwake-freeze-8:
        never passed
    * rtcwake-freeze-9:
        never passed
    * rtcwake-freeze-10:
        never passed   =

              =20
