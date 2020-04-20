Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2CF1B06F4
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 12:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgDTK7V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 06:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTK7U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 06:59:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D02C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 03:59:20 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n16so4867711pgb.7
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nDi9048jma/XgtxOkcVd/KoKKrW4WlwGjZJgt8bepfM=;
        b=fB2+UsfiTEa+GKHu/fz5k27wmjMEErUIRedxZwQrDvmM/jXYuw4EdOwEjqI/Qqsh2s
         Qup89YGm8Cj+zMJyT0vsGyKM324R7QkZTBYNnkg4VIfajmi3y3YGS/PZIu5IqkgzSukc
         jrC/NUPftgcc5BVzOe6Ok3+vR5cS3PRKRSa8wYlYYZqEBCzvgNmdBYzUSiyvYkt24Ias
         fE7dQugqjrwej1qCNbQcO0LA3ALmGfNpK3MC6nDHIM6JVxj2ls++1z0N326PqDIS3JpJ
         oCvxGSnTgrjHU6+4bqRD/tyTik20o6h/Ah9+2rdzL9UdFgwQgYiYhqSQunpwQpwtKHpz
         RnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nDi9048jma/XgtxOkcVd/KoKKrW4WlwGjZJgt8bepfM=;
        b=AoOwQ60xBr1prS5GrHBIlG+B4+zYUdGEPtryyv/mEdOCidcXv5Sf/2dYqZirsKP49R
         MCRtxfZ8tECC41848LvjayOaY+MrQ25Krh7GkUeJdfOCsT4BAioSGatLu8bDfFfv0S6R
         poS6vYd5UoYMPXze4Me/NQ1Vgi9BYHZ1iaBQlFFsBrlGBI1YbdvVqmR4ccwV8j1yb7A8
         nMYJtH7jCW7BYlimaoXDz7EUSM7CCshnFS6yQO94BiXwmmm1oIfhcZ0qgV+XqZtpDe1J
         BVFnxOZpJDkCikfNo5Or8h+zrMsY6YZe8TKv0RixacOD4wLUr1zVSkwyZiVUe6zUP76o
         C+/Q==
X-Gm-Message-State: AGi0PuY1vIkK/DCY//u1ziTvnR4prRHCb4HIWnYGyvkDUdcGRpdC8NUH
        zSbhE04+jDcY48F9zZQ7DHGTVmRD1v8=
X-Google-Smtp-Source: APiQypJAk2E4M0bfP7c58Sob1xLnV+gqnmdjLRTbIA+KJutrv3iSz9rg0Ol4cofwoShYPTl7dNegwg==
X-Received: by 2002:a65:5642:: with SMTP id m2mr16433447pgs.191.1587380359742;
        Mon, 20 Apr 2020 03:59:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 10sm761733pfn.204.2020.04.20.03.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 03:59:19 -0700 (PDT)
Message-ID: <5e9d8087.1c69fb81.4a8c1.1e05@mx.google.com>
Date:   Mon, 20 Apr 2020 03:59:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc2-16-g247f4817f956
Subject: pm/testing sleep: 6 runs, 0 regressions (v5.7-rc2-16-g247f4817f956)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 0 regressions (v5.7-rc2-16-g247f4817f956)

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
  Describe: v5.7-rc2-16-g247f4817f956
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      247f4817f95659c2102343dedb580362ae60eb86 =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0417.1/armhf/rootfs.cpio.gz  =


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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0417.1/armhf/rootfs.cpio.gz  =


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
