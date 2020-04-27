Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94F71BA23A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 13:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgD0LWK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 07:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726260AbgD0LWJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 07:22:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EBAC0610D5
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 04:22:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w3so6892314plz.5
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8C3/T+6KCH835T0WErWUKH3J8UTARWq7GLyZ1EjmmXY=;
        b=eZtpc6ZLs+ow1vZOWButyX8Y2+PhV/MeuqhSTsyjO5+jlrX3LkfScxbyEtPueUalhn
         8Pps0KWPUgpQ6kWskc5Hg46qh24v4507aQi439t+p76F45iUutM1kwyOQQSVU5ty5OLf
         5PP6bARg0+/FTfw2r4ZCW1i7RCcuPkcC+fuaAt3PtmB7Vnbj5xZhUFrRR5/2ZPMFxCJo
         PQ/Lbj4wMvJRYQJ2uistTLvjHqsSg0HXdDiqhx14zbWKdY8b0gQ46pF8IYPeguWdMy8u
         rBdWxPIGxu5Hln0JXdTmND2Co6eEAIZxF/1WCwPgX5ZqemR40TEWMns2ZpzUY3LWEG10
         7VeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8C3/T+6KCH835T0WErWUKH3J8UTARWq7GLyZ1EjmmXY=;
        b=scGF6KaTHyNzDIaBKy3/tyO07z56TLwqzRTtf+gxJ3vC7kEeogadU78ZLYXL1Ggr3w
         PRMH4E6TUU41W9gBoKZ+WsvIVUHdNcnM9KK2efb7fcBWZd1d629Od4jGCCn6uvig5Von
         EtK72Lh2pQVkPh2xLaaHOo6EIE7XbbH/GQ+ifntb07jeW32zjgyiO+FMtN2kjquumQyq
         f6tfnwqXkKs3PJPWo0bXDeFmr8SLcp+0xJdrUiKTFB/EtulDGnLVeF/p8bZIXJ+24dgb
         hycO0qJfIvKzxZeWkbn80fYQRpGXqmuEp9vbJ5UC5vK6hrDKZWnFRt4ueG9L/Ef0hA1k
         nnoQ==
X-Gm-Message-State: AGi0PuYs/kGkChmw07WFFk7G53eKu2ewjErBJ6vNqxqbHbXdVvkJwiL4
        ihavUCgC5WHH5Y/QhpMa6TZRSQ==
X-Google-Smtp-Source: APiQypIj3osBdLqWzNw3Isuj7I60jQAFMKbiyjmlnNh6Luj3qFwVHDJcArpBycmQdZPXdyClg3MOMg==
X-Received: by 2002:a17:90a:883:: with SMTP id v3mr23134449pjc.5.1587986527972;
        Mon, 27 Apr 2020 04:22:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g6sm10934017pjx.48.2020.04.27.04.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 04:22:07 -0700 (PDT)
Message-ID: <5ea6c05f.1c69fb81.4a0e6.c91f@mx.google.com>
Date:   Mon, 27 Apr 2020 04:22:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc3-21-gd38f9bc9261a
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs, 0 regressions (v5.7-rc3-21-gd38f9bc9261a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 0 regressions (v5.7-rc3-21-gd38f9bc9261a)

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
        | 6/6    =

7   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc3-21-gd38f9bc9261a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d38f9bc9261a2b20e8509370b5df9bdb3badaf81 =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
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
3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.html
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
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
