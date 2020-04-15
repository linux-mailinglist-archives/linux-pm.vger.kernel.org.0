Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73831A91F8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 06:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbgDOEiK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 00:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388223AbgDOEiH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 00:38:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A94AC061A0C
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 21:38:07 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id i3so955591pgk.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 21:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=JstZHvX1uysvcXCr49BYyMPfu72nEWemRm+UuWT9g0o=;
        b=KkoZurNH9vmNSsdomlm+xE4OvRp7PA689JvovFbv0Akkb7BS1Rw86IdNMQ9PwhHIZ8
         OEFLonciRiXk+oakxKOiesLqkb+LuctmUg4ncx3Mi2JaV1tpJfvhaClet9n1022N9QU/
         s18ZiwwsctWM3MZQ5NSqrbfgUpIHUget1H5mu+rLnr6So5/x2+RtmO+tg1XvKHARIO7n
         n9ya2je8KpcoDrKa88sP8Qy7HM7RPzL9nLHHhby1zk5J20CZmU5aypKHVwRqp77fxl0N
         5nu8jRVAFzyjWOim43EZCrlG1yT++Ifwlpq7LZiYY15mV/ylySZR7hkerNlbBPUQq5Es
         7/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=JstZHvX1uysvcXCr49BYyMPfu72nEWemRm+UuWT9g0o=;
        b=tcItKnSW9FcFY11Yw0Z9lMoVdU6RaPxFxl/YLJovzl/y+8rpkXiKv2rPxzSdTeeCMk
         E3QiuPd65YFTR30/mkPPoycZd5T+ny1NuTNkWT/3Z5/Nt/ck7pta8E6+DOXANAiZxKje
         GyDS8SVaq9qSMFyylt5rpJFWWv7EAB5uLgAihniVf1lEs5W7yejpwo3XwXZbXiFXryjY
         8AN8KUB6I3wMta5TLCGUKxQqvaqaYgU5FdrA4L6HYRP0iW3r93bm14P0idGtpmrd8e1T
         Qk3piUhJX/6Zf7ajCUAPuShOHkpbL/kJcIcrql++3pWK41ouZJhhghf/a/uOYeYv/Z85
         5BKA==
X-Gm-Message-State: AGi0PuadBBAtD7rQAq+tAwzz7ztlKz1inUV5RdRJ9JjMIO2WKyLhL+hZ
        JINEjfQu1HuVkaxjPLO/rwb9prt0nZM=
X-Google-Smtp-Source: APiQypIwjNOgeC+QbzfX1ZgTEvWzX/CHaxbBZrhIeGZewwfbLVnD2oqe4MCGvtkZXa/VNMICVLfKxg==
X-Received: by 2002:a63:954b:: with SMTP id t11mr25117923pgn.309.1586925486322;
        Tue, 14 Apr 2020 21:38:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o99sm4686011pjo.8.2020.04.14.21.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 21:38:05 -0700 (PDT)
Message-ID: <5e968fad.1c69fb81.2a7c8.1323@mx.google.com>
Date:   Tue, 14 Apr 2020 21:38:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.7-rc1-2-g38aeec472905
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 6 runs, 1 regressions (v5.7-rc1-2-g38aeec472905)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 1 regressions (v5.7-rc1-2-g38aeec472905)

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
  Describe: v5.7-rc1-2-g38aeec472905
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      38aeec47290576cd1f4112fab3937c855a0331d9 =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
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
2   | exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu3=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu3=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0325.0/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: v5.6-141-g61fafa3ac67b)   =

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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square.=
html
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
