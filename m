Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56201D7B40
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 16:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgEROaI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 10:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROaI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 10:30:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78195C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:30:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s10so2633556pgm.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=q4P+CeSKpVuZ7pCbQOkf/oxi9lOnGxGz0rq0GZtB/bE=;
        b=oZ+vWCSMEi5VsA7sD2BwBH2D8YzIQoFB070xLGM/dTL1kJg6JGHZ2EJXML7KXOsSL6
         Z/ybHzk8FGbt0ln+2xHXaFMoysfWeZKguNeBlDEH5IL6AkXwKSegR667Qx0iP8F5y0os
         gp91woQCoDp5YA0aEiWMPdw1vqItdWsQ5Q+bdQ6sRVb3TuAl32BL/auvXwStu7SF5RaC
         a2vS34Ob0PgafVZhyzw0UtOxX3ZyKjAWK8eHVsECp1rvEK7ryHxbT9kbhASkmJqfGTCQ
         ITIi39ie725lnPdOL31mDGxup0Kol2g9U8Dj2w+WC4UevFHzrlGvTZ0bkHCcmTI8PIJv
         VfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=q4P+CeSKpVuZ7pCbQOkf/oxi9lOnGxGz0rq0GZtB/bE=;
        b=fpV9ouLTjHCqJzggl36PbgkjgQmFS2Rm/ZPzIRHRvasz6lfhCMR7P9G4h/whB/IsOv
         PbqwTBY0cUW7U9iiDOJ8Q3iUdJYXXDNZ9urG2PG0MpUsn2deHVlxTnbrbWvYHf5AnGN3
         NfFAF/kkOjZCPpsuKxuHYh/5aWNdPKtc0HDFSyBl60A9w96WnXHULfsjdRh1jCo3rT+x
         HNNWMpD7jDzlzdq5AO5x7H21SjwTpg6GzbRwXv5k8cICi7r/kv1oN/5hSnM3zymb885x
         Mpk6krmeDiKDHmAnXR2LKREbTnpYVIRSu/YjgEPIMaB0Euyqqe9ArgW6JkN5vLAbfz8b
         qxLg==
X-Gm-Message-State: AOAM533zYZUv+g2h+P6RBUZPXv8UgMDvGCpevrcfRpd/IErTb9rHdoK7
        Dsswtnq9ainp5CviHBdVTUg+tg==
X-Google-Smtp-Source: ABdhPJxUcc/gEYLWq+uS3SXhGOeQfOA6/fHeU1FkUumJEOzh6OdZLHgCcG7Wc2N+XhcchIHmJ/UOBQ==
X-Received: by 2002:a63:7f09:: with SMTP id a9mr9818626pgd.400.1589812208013;
        Mon, 18 May 2020 07:30:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k1sm2837123pfg.205.2020.05.18.07.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:30:07 -0700 (PDT)
Message-ID: <5ec29bef.1c69fb81.f945f.2589@mx.google.com>
Date:   Mon, 18 May 2020 07:30:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc6-60-g478d8912f6a3
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 25 runs,
 0 regressions (v5.7-rc6-60-g478d8912f6a3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 25 runs, 0 regressions (v5.7-rc6-60-g478d8912f6a3)

Test results summary
--------------------

run | platform              | arch   | lab             | compiler | defconf=
ig          | results
----+-----------------------+--------+-----------------+----------+--------=
------------+--------
1   | bcm2836-rpi-2-b       | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 0/1    =

2   | exynos4412-odroidx2   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 4/5    =

3   | exynos5422-odroidxu3  | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

4   | hifive-unleashed-a00  | riscv  | lab-baylibre    | gcc-8    | defconf=
ig          | 1/1    =

5   | hip07-d05             | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 3/5    =

6   | imx53-qsrb            | arm    | lab-pengutronix | gcc-8    | multi_v=
7_defconfig | 5/5    =

7   | imx6dl-riotboard      | arm    | lab-pengutronix | gcc-8    | multi_v=
7_defconfig | 5/5    =

8   | imx6ul-pico-hobbit    | arm    | lab-pengutronix | gcc-8    | multi_v=
7_defconfig | 5/5    =

9   | meson-g12a-x96-max    | arm64  | lab-baylibre    | gcc-8    | defconf=
ig          | 5/5    =

10  | meson-g12b-odroid-n2  | arm64  | lab-baylibre    | gcc-8    | defconf=
ig          | 5/5    =

11  | meson-sm1-sei610      | arm64  | lab-baylibre    | gcc-8    | defconf=
ig          | 5/5    =

12  | omap4-panda           | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

13  | qemu_arm-virt-gicv2   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

14  | qemu_arm-virt-gicv3   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

15  | qemu_arm64-virt-gicv2 | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 5/5    =

16  | qemu_arm64-virt-gicv3 | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 5/5    =

17  | qemu_x86_64           | x86_64 | lab-collabora   | gcc-8    | x86_64_=
defconfig   | 5/5    =

18  | rk3288-rock2-square   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

19  | rk3288-veyron-jaq     | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 68/68  =

20  | rk3328-rock64         | arm64  | lab-baylibre    | gcc-8    | defconf=
ig          | 5/5    =

21  | rk3399-gru-kevin      | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 85/88  =

22  | stm32mp157c-dk2       | arm    | lab-baylibre    | gcc-8    | multi_v=
7_defconfig | 5/5    =

23  | sun50i-h6-pine-h64    | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 5/5    =

24  | tegra124-jetson-tk1   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

25  | tegra124-nyan-big     | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc6-60-g478d8912f6a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      478d8912f6a348713e0a6f7707e2a1874890a7ae =



Test Failures
-------------
  =


run | platform              | arch   | lab             | compiler | defconf=
ig          | results
----+-----------------------+--------+-----------------+----------+--------=
------------+--------
1   | bcm2836-rpi-2-b       | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/armel/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

      =


run | platform              | arch   | lab             | compiler | defconf=
ig          | results
----+-----------------------+--------+-----------------+----------+--------=
------------+--------
2   | exynos4412-odroidx2   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/armel/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * alert:
        never passed
        1 lines  =

            =


run | platform              | arch   | lab             | compiler | defconf=
ig          | results
----+-----------------------+--------+-----------------+----------+--------=
------------+--------
5   | hip07-d05             | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 3/5    =


  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 1  PASS, 2 FAIL, 0 SKIP
    * alert:
        never passed
        11 lines
    * emerg:
        never passed
        2 lines  =

                                                   =


run | platform              | arch   | lab             | compiler | defconf=
ig          | results
----+-----------------------+--------+-----------------+----------+--------=
------------+--------
21  | rk3399-gru-kevin      | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc6-60-g478d89=
12f6a3/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz     =


  bootrr - 84 tests: 81  PASS, 3 FAIL, 0 SKIP
    * cros-ec-sensors-accel0-probed:
        never passed
    * cros-ec-sensors-accel1-probed:
        never passed
    * cros-ec-sensors-gyro0-probed:
        never passed    =

                 =20
