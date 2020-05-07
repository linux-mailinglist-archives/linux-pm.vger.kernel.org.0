Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0231C9E23
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 00:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgEGWDd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 18:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGWDd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 18:03:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826B2C05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 15:03:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so3696216pfa.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qJ4ci/udXRmzR33OJcZGVl6HeGVK9Z6y5mlxt8NMRCs=;
        b=Df74CD5e7gsxHIqOhHYtFVyE5WRvzELNajLOCjwcbUc+8xBxSUFmzK/Fjos8FjGQ57
         djh5RMbWwOledlsimPlTPkU/VYoZu/AZMxjqrUyzITnRpIzJOFB9raqyGUwopthpfC9j
         4II6RFISBafyLRWgQXk8o3M6oJT95AZpfoGgQBfj6a+5z2FvwB9aiZVZyxlQrll6//S+
         5fXJABdEh/L6CMldIijv+no5MkfrpM5X4cTbmNcbKlybucKxJw43wffO082RyfDiufxk
         WEycnOSbc9lSyVXOZgArJs7PTf3tV29K30CVcBOFqhSTpGHHXA6NRCV9cOCDQd0XmG94
         XOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qJ4ci/udXRmzR33OJcZGVl6HeGVK9Z6y5mlxt8NMRCs=;
        b=KJ64T1y1ysaloK3IZ01FtahUq0cMILfkvuy2bVfLQQzdT1bZSI02yNlnkZ+8Ph34uZ
         4GG2qs4kDkOvmfNgonDSbmN/xjUhHdHD5mf0AwylPQ2zJY8F4KLtxYbN0dDuoBA1BHLo
         7tG71IUpFO726yB1CDUYvb64TOExbt/fwYRHMTrK/y991Xv4iGNRlYmgxJ1iM+Y3qK8A
         Vae6FbqAkVv703ZqjSYV4xgdyYyZpJ89tLg0GS8YKUmDxPl7tbIKO8kIIMWN/piwtOcO
         HoShhkS5W3gVkoDcd+BJeJQjHzpbaDyOe4sfegsN8d+mAcf/GJzOO/q0LPj0Vhv0ue1o
         vXeg==
X-Gm-Message-State: AGi0PubxmWTQRWtGmhXc6VSOCgAn/8uFhm8jpx3UQoqV+dQ61hR9/MmM
        pTcDdCCH36tUxDi+0OeRXY+6eA==
X-Google-Smtp-Source: APiQypLGS0vbWbED/jA8JsEZ+8chOng4BwKquLByaA10le5o7mzR3nntZEgMZJM9zb/dJK/Lfx1N5w==
X-Received: by 2002:aa7:982b:: with SMTP id q11mr15600481pfl.260.1588889012805;
        Thu, 07 May 2020 15:03:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 23sm4586803pgm.18.2020.05.07.15.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 15:03:31 -0700 (PDT)
Message-ID: <5eb485b3.1c69fb81.cd0cf.f9ca@mx.google.com>
Date:   Thu, 07 May 2020 15:03:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc4-21-g5b45c277ddc3
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs, 1 regressions (v5.7-rc4-21-g5b45c277ddc3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 1 regressions (v5.7-rc4-21-g5b45c277ddc3)

Test results summary
--------------------

run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =

2   | exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =

3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

5   | rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 9/9    =

6   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 4/4    =

7   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc4-21-g5b45c277ddc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5b45c277ddc338e5236f44f9be4a64ff904ec9b5 =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc4-21-g5b45c2=
77ddc3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc4-21-g5b45c2=
77ddc3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
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
2   | exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc4-21-g5b45c2=
77ddc3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu=
3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc4-21-g5b45c2=
77ddc3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu=
3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0424.0/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: v5.7-rc3-24-g1985b45de014)   =

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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc4-21-g5b45c2=
77ddc3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc4-21-g5b45c2=
77ddc3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.html
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc4-21-g5b45c2=
77ddc3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc4-21-g5b45c2=
77ddc3/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
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
