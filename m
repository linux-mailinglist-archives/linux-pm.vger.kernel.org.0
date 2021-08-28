Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359053FA2AD
	for <lists+linux-pm@lfdr.de>; Sat, 28 Aug 2021 03:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhH1BDs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 21:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhH1BDr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Aug 2021 21:03:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3856FC0617AE
        for <linux-pm@vger.kernel.org>; Fri, 27 Aug 2021 18:02:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so6026480pjx.5
        for <linux-pm@vger.kernel.org>; Fri, 27 Aug 2021 18:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=JLZIwfK6hCeD2SrXpeJ4JUVVDM2aTBeBWw6is+AKjzM=;
        b=SDqD4cCXSYvL7tagGM8BtD8JkvlTk5U3ScXLZxGs8Gxl//zm5SLQPKuYeLDO+GUzrp
         84C0LTatKKw5vp89W7EZRiYy59iozVqPQAOMQfuBdncqXRUhj0dxPVJGXiYuUzJlEOe4
         LmyLYf1mpLQjAggxZxCtd5P7W5VtenBpfIeRVBFNrBR7J+SWLQArhLvjEch57ZFQCckl
         myuXpZ94d0wzIOw7IrqwrwlfvvbG0YkD/Op215E5dWNQNeDg+hez2cu8mq/hJzA6/JHu
         KHZ643Ajz5sQFZYXxkjXtw9zX4exX4Zmdjx27z5UiEXIvm6dfgnFexZZ9CaRWk3+NIiN
         W7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=JLZIwfK6hCeD2SrXpeJ4JUVVDM2aTBeBWw6is+AKjzM=;
        b=d/cU+3zTxlyFPrXQZku+FMMqP0ax8UR08x0W0jnpigYXxcs8IlAg5opZMxTvd7BdUL
         XlPsZful0+XaSx2XlrR2FXtH5OYRrce2shLP7yYvZO7ur0Dtx7Pwe+DIxS0MR5b1Vhru
         cFTYT/KZ7QxCfnoIbt8cl11O5V44ui+HYhqwHMXkWCIAYz7cHbhMOUcPAUHXxFVVwcgr
         z50dPwfhOw2iqMFJbh49HxuyKKzSr60hbxGOZtD/mE7U2PdhrQTV01c9ZTFgVAPIZf1v
         HFE4e5GUgxBWqjJQMswbZ6Z8cz77IwzqxE+VkiuY5TcpMGpgHnpfEkEcsmy8uq5AGeDs
         PAAw==
X-Gm-Message-State: AOAM533IOyBDNfmcFIzTnGADbosepYwDJejgVczoYag+QRcRCP2pLkcZ
        u5F+UlPffvaoVpsnYHjt58oKZw==
X-Google-Smtp-Source: ABdhPJydshs+vNhaMGAFiAp+AvKh+o3fGj633gDW25QwCnVhUC0ZMNro/fV5Sm10twMIgbyhYBNrtA==
X-Received: by 2002:a17:903:228e:b0:137:529:980d with SMTP id b14-20020a170903228e00b001370529980dmr11096624plh.43.1630112577711;
        Fri, 27 Aug 2021 18:02:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u7sm7553948pju.13.2021.08.27.18.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 18:02:57 -0700 (PDT)
Message-ID: <61298b41.1c69fb81.da2c1.4cb3@mx.google.com>
Date:   Fri, 27 Aug 2021 18:02:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: acpi-5.14-rc8-64-ga93c0039d89d
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 77 runs,
 5 regressions (acpi-5.14-rc8-64-ga93c0039d89d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 77 runs, 5 regressions (acpi-5.14-rc8-64-ga93c0039d89d)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig         =
 | regressions
---------------------+-------+--------------+----------+-------------------=
-+------------
bcm2837-rpi-3-b      | arm64 | lab-baylibre | gcc-8    | defconfig         =
 | 1          =

beagle-xm            | arm   | lab-baylibre | gcc-8    | multi_v7_defconfig=
 | 1          =

hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig         =
 | 1          =

meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-8    | defconfig         =
 | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
4-rc8-64-ga93c0039d89d/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.14-rc8-64-ga93c0039d89d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a93c0039d89d6f11b98f49db841515e65a5dd0ba =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig         =
 | regressions
---------------------+-------+--------------+----------+-------------------=
-+------------
bcm2837-rpi-3-b      | arm64 | lab-baylibre | gcc-8    | defconfig         =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/612981ee647056e9188e2c9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.14-rc8-64-ga=
93c0039d89d/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.14-rc8-64-ga=
93c0039d89d/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/612981ee647056e9188e2=
c9f
        failing since 46 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1) =

 =



platform             | arch  | lab          | compiler | defconfig         =
 | regressions
---------------------+-------+--------------+----------+-------------------=
-+------------
beagle-xm            | arm   | lab-baylibre | gcc-8    | multi_v7_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/61298089e0cd29fae48e2c97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.14-rc8-64-ga=
93c0039d89d/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.14-rc8-64-ga=
93c0039d89d/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61298089e0cd29fae48e2=
c98
        failing since 22 days (last pass: v5.14-rc3-20-g604483c9d252, first=
 fail: v5.14-rc4-28-g9ac32de19606) =

 =



platform             | arch  | lab          | compiler | defconfig         =
 | regressions
---------------------+-------+--------------+----------+-------------------=
-+------------
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig         =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/61297e6a1f17e37d058e2c8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.14-rc8-64-ga=
93c0039d89d/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a0=
0.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.14-rc8-64-ga=
93c0039d89d/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a0=
0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61297e6a1f17e37d058e2=
c8e
        failing since 274 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fi=
rst fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =



platform             | arch  | lab          | compiler | defconfig         =
 | regressions
---------------------+-------+--------------+----------+-------------------=
-+------------
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-8    | defconfig         =
 | 2          =


  Details:     https://kernelci.org/test/plan/id/61298125b882ce0ad78e2c7a

  Results:     4 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.14-rc8-64-ga=
93c0039d89d/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-g12b-odroid-n=
2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.14-rc8-64-ga=
93c0039d89d/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-g12b-odroid-n=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/61298125b882ce0a=
d78e2c80
        new failure (last pass: v5.14-rc7-64-g2a7254aa7491)
        1 lines

    2021-08-28T00:19:41.584491  / # =

    2021-08-28T00:19:41.687832  #
    2021-08-28T00:19:41.789275  export SHELL=3D/bin/sh
    2021-08-28T00:19:41.789672  =

    2021-08-28T00:19:41.789872  / # #
    2021-08-28T00:19:41.891036  / # export SHELL=3D/bin/sh. /lava-752993/en=
vironment
    2021-08-28T00:19:41.992259  /lava-752993/bin/lava-test-runner /lava-752=
993/0
    2021-08-28T00:19:41.993271  =

    2021-08-28T00:19:41.993434  / # . /lava-752993/environment
    2021-08-28T00:19:41.994012  / # /lava-752993/bin/lava-test-runner /lava=
-752993/0 =

    ... (9 line(s) more)  =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/61298125b882ce0=
ad78e2c82
        new failure (last pass: v5.14-rc7-64-g2a7254aa7491)
        2 lines =

 =20
