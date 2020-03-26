Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C061194BB4
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 23:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgCZWnT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 18:43:19 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:55538 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZWnT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 18:43:19 -0400
Received: by mail-pj1-f46.google.com with SMTP id mj6so3061643pjb.5
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ZDnMtyf6BLmOswg/Tyyl8GzNXDwaXNhfEjpPrfXDPMM=;
        b=j6aJ43Cr2HQAovoF0bLgCVSg23JXSQwBtHJBegA/LnFM39YhjaeghetYa5zcosW4jJ
         soQwQ/LdL5+uoe0XdJQCmQIEthnjZ4ApcvrY6jiiIl84VN/AhHfnf2kPjN5XauJs0lSS
         AFN+pYRY9r/BWl08GBpWL5saJu/xYo6cfyId+0+0ZVN73OnUvzGs9oNlgzAPsZEeZtyZ
         HnoeUi48I38RPVr7Fe9GQ/IZgfiyiblA3K+oW45uhPMNKb1v1YZvXCS0SxdzZx5EolcA
         kydylPA5oLpA1r5QjKrGx3sszP5TSoQkUpnMwlc3RWZ5z5+2w+4NGUx4pYH1ZR3LrmV7
         H7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ZDnMtyf6BLmOswg/Tyyl8GzNXDwaXNhfEjpPrfXDPMM=;
        b=jEcGIQPmUaIpnwM9uhfw4X1M4DvolSSU3rlMRS42FZXDfXfugf9DpNohVRabyy+Oz4
         f4TIMFRJkI3SZ+NuCuKMJa/PB2LYvaaqwFMXGer4XVm1IIBhlbdf7ur8JRAafEafENVt
         sun5cdECbTJe0zHZmBAJk/+fJftRFHskKPXm/eAt8TpiuJ5qBEnLWxj5hCpP3igbSeqj
         EyOXEsIeK5ZAUU+zUShZdub5APgrjXz953BduAJzM7oI/SXhKuWVP7wU5bLbJOHoY1M9
         +aOA39XCBSkP9P3XrDFPWpLq8bcxZl+518dZhPBiqvRfDlP4PDlx70XwPkn+KDhRetlu
         uNbg==
X-Gm-Message-State: ANhLgQ33cesCraSBUi8OKgfzi4p9vpMa7LgspGDZVGJWoZHbSORVVypc
        7oegbu2488BHnnJW/8TuNHd76g==
X-Google-Smtp-Source: ADFU+vsseBQU3q/M56vj+cnpTUi48HVaXUAMtf8HJ5gdR2sE1mPBFzGr/YCqmu5GLTmWkf3N/X8ElA==
X-Received: by 2002:a17:90b:4c84:: with SMTP id my4mr2460046pjb.3.1585262597281;
        Thu, 26 Mar 2020 15:43:17 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p22sm2467532pgn.73.2020.03.26.15.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 15:43:16 -0700 (PDT)
Message-ID: <5e7d3004.1c69fb81.877e1.906a@mx.google.com>
Date:   Thu, 26 Mar 2020 15:43:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc7-129-g8b4ddf47b7b4
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 7 runs, 0 regressions (v5.6-rc7-129-g8b4ddf47b7b4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 0 regressions (v5.6-rc7-129-g8b4ddf47b7b4)

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
  Describe: v5.6-rc7-129-g8b4ddf47b7b4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8b4ddf47b7b4dd54539f1821c95a8dee3295fb0b =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0325.0/armhf/rootfs.cpio.gz  =


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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0325.0/armhf/rootfs.cpio.gz  =


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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0325.0/armhf/rootfs.cpio.gz  =


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
