Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62151D7B8E
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEROnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgEROnu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 10:43:50 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDB6C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:43:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n11so4912965pgl.9
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VKEpTeJCH/bu7F1R/az2XhDfuSm1FyfQpLhOr5/C888=;
        b=f8rmgMw6uwcf7oLKCOddmtRwO6OnKqQgfQTqmePsSkHPdWFpZtdzz12/7CaU7wKdyC
         6HNyOvROU9XsoqwgyONw2HptXCQgvu9Kt47V96IOQBG0DziC4Y17YG9zte6G47SRmcsQ
         4BW8bPWYWfRVRNW0w/wTuw8RZYuFB6gzDssoxIqlLjPdp7efX1lfMFFt5A6SI247vapH
         AOvn7A+MIrKqcoJRDZ3o2TBQdbZ/sSrM5eT7WpY63A277wX/tyH5XMFTpI+4P9cihf/f
         zWRf4XQqr8OH/hXHalFtXDJp9hyuOohhUioppprcpFF9U4xCgJ+bzjKegyrOVUF4ulEE
         Bbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VKEpTeJCH/bu7F1R/az2XhDfuSm1FyfQpLhOr5/C888=;
        b=Ii/Mhh16s14oihykzo5TKFbLcyjwDr1TZqXgyg+VZOcwdrUDbd94fI0lsyZVG/NePN
         OWBw0bGpOKF+HJi1nZ+FTvvKTMbaFJ+psqw9bobGVPTctbZzaPwnh5jKrsJcJQiI43Td
         1sdpXeBJ3OSz0cLGw4r7d/mpzMoNQjc+msjyWMWBRkNYyMlIIRt65XRfi3nJaAYWBxLy
         yCcq+zQN4AUHAGd1ZvzieZnbgQFV1DpFAiB81nXwgn/cszCmPy0jBCeAUg7SZAfJB+xX
         W/8NoR/Ops4yUpZwV7ftNvC7nUaf7UX8+zN7Go8lSoS83mC7oqhkWZGClwGPI6RbuJU1
         nkAg==
X-Gm-Message-State: AOAM531LSInWSfROskhfq3uTB+zL7YtwTFAnoqQFHMpBd3AE72DRbnfq
        tMCsVrh0WjxEVoGSehGyP8xAlw==
X-Google-Smtp-Source: ABdhPJyKNDl2jIEM2QwkU89et50eFQ2RM4+lTjtv7XANW64yV/HVsNiQ1X+W7rs4LdRb/SZBM0WAag==
X-Received: by 2002:aa7:96e7:: with SMTP id i7mr6038597pfq.114.1589813029412;
        Mon, 18 May 2020 07:43:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j16sm8839010pfa.179.2020.05.18.07.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:43:48 -0700 (PDT)
Message-ID: <5ec29f24.1c69fb81.26dbf.ade8@mx.google.com>
Date:   Mon, 18 May 2020 07:43:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc6-60-g478d8912f6a3
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 6 runs, 0 regressions (v5.7-rc6-60-g478d8912f6a3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 0 regressions (v5.7-rc6-60-g478d8912f6a3)

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

3   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

4   | rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

5   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 11/11  =

6   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc6-60-g478d8912f6a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      478d8912f6a348713e0a6f7707e2a1874890a7ae =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
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
3   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
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
