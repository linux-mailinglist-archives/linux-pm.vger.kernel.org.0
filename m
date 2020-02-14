Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701D515D2BD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 08:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgBNHWe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 02:22:34 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:55705 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgBNHWd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 02:22:33 -0500
Received: by mail-wm1-f43.google.com with SMTP id q9so8842943wmj.5
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2020 23:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4EPBu8kolqEvADUma0cYsF48TH+3+kf5PwbYKr4fw8A=;
        b=AX37qK76jmg72efukl0r1QQloedhThnFlFbzov1PnSVZQrEIOC1KhltUFKIBEPgkTp
         yffqAtvW43U5nB/NR/2zAO9QmJDvxeuVicE6dsBOZPQO9OthKFIa7btbZk05YZhi1SZO
         vWauxkDy7yVU+zWwpTPvjGaVLTv7QY4CnsK+/hA1daxDEBd398qO7ayA1/ns/BX8lkNM
         W/NN5IHPTnVfj/QqNfN7WNhFB/EPgO+Bz23UU3N08HhuWj2sAgHlp+s/y2nGb0egvjIZ
         3lM2BwCfY+AC3qGsH8JYPZyyVDB7aeE7dIcMNcYewdHMhSk8xUMqJVhVd4OBQQ6Qg6O4
         ZO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4EPBu8kolqEvADUma0cYsF48TH+3+kf5PwbYKr4fw8A=;
        b=skcdOwp4+cAfBS8O+xA73NbRXWXdEo6z6VK1V/NHjBCV2Ca0kjVm/vCDRL9BBSFZBf
         /vzU1I3YuzaGF4RNsGmg4XtBHSJp/3A341o5djmkJgtAPO8cbokP0hf8F2FJa/gGWKi1
         Ci1BttjFh17RnUPaOjDCzs7s3Gacjl1W7uh65p+PKUavUQGP6g8VX5Q1+mt4nig+B3yv
         wAQP3tcPcKQeSLnl5AU9xuFPSIa54ehkZ7RwQltRy+nEHmZeE9Ywr9vVWhc5EfIWOf2t
         B8w5xNhIpmOFZFzh1vfBTF7t5DtH/Qpx29cbaQ0HW/9AZoMEGL11vLnbJ+Tfk6fgJcUg
         9igA==
X-Gm-Message-State: APjAAAU/A+13yHU1pR8yMGMrJeiTQHNf/tkuxTMvlqq3esS9FnlyYJcm
        82S7CP1crqdb1l7GCaHg5b524Q==
X-Google-Smtp-Source: APXvYqw9nRykSIN8grORX1Tu0U+HXNP3YHhiJ3Rws+M/pxotSDEIM3ZY/m9qXKlzfbeCdjNg6YD+JQ==
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr2960089wma.111.1581664950294;
        Thu, 13 Feb 2020 23:22:30 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id g25sm16716399wmh.3.2020.02.13.23.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 23:22:29 -0800 (PST)
Message-ID: <5e464ab5.1c69fb81.3e7ec.e310@mx.google.com>
Date:   Thu, 13 Feb 2020 23:22:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc1-10-g55fe2ef33c65
Subject: pm/testing baseline: 28 runs,
 0 regressions (v5.6-rc1-10-g55fe2ef33c65)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 28 runs, 0 regressions (v5.6-rc1-10-g55fe2ef33c65)

Test results summary
--------------------

run | platform                     | arch | lab           | compiler | defc=
onfig          | results
----+------------------------------+------+---------------+----------+-----=
---------------+--------
1   | alpine-db                    | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

2   | am335x-boneblack             | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 4/5    =

3   | at91-sama5d4_xplained        | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

4   | bcm2836-rpi-2-b              | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 0/1    =

5   | exynos4412-odroidx2          | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 4/5    =

6   | exynos5422-odroidxu3         | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 5/5    =

7   | imx6q-sabrelite              | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

8   | meson8b-odroidc1             | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

9   | omap3-beagle-xm              | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

10  | omap4-panda                  | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

11  | omap4-panda                  | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 5/5    =

12  | qemu_arm-virt-gicv2          | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 1/1    =

13  | qemu_arm-virt-gicv2          | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 1/1    =

14  | qemu_arm-virt-gicv3          | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 1/1    =

15  | qemu_arm-virt-gicv3          | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 1/1    =

16  | rk3288-rock2-square          | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 5/5    =

17  | rk3288-veyron-jaq            | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 64/65  =

18  | sun4i-a10-olinuxino-lime     | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

19  | sun5i-a13-olinuxino-micro    | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

20  | sun7i-a20-cubieboard2        | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

21  | sun7i-a20-olinuxino-lime2    | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

22  | sun8i-h2-plus...ch-all-h3-cc | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

23  | sun8i-h2-plus-orangepi-r1    | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

24  | sun8i-h2-plus-orangepi-zero  | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

25  | sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

26  | tegra124-jetson-tk1          | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 5/5    =

27  | tegra124-jetson-tk1          | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 5/5    =

28  | tegra124-nyan-big            | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc1-10-g55fe2ef33c65
  URL:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
  SHA:      55fe2ef33c658a1c0922ca161b136bb7171ac084 =



Test Failures
-------------
     =


run | platform                     | arch | lab           | compiler | defc=
onfig          | results
----+------------------------------+------+---------------+----------+-----=
---------------+--------
2   | am335x-boneblack             | arm  | lab-baylibre  | gcc-8    | mult=
i_v7_defconfig | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/armel/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * crit:
        never passed
        1 lines    =

         =


run | platform                     | arch | lab           | compiler | defc=
onfig          | results
----+------------------------------+------+---------------+----------+-----=
---------------+--------
4   | bcm2836-rpi-2-b              | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/armel/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

      =


run | platform                     | arch | lab           | compiler | defc=
onfig          | results
----+------------------------------+------+---------------+----------+-----=
---------------+--------
5   | exynos4412-odroidx2          | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/armel/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * alert:
        never passed
        1 lines    =

                                       =


run | platform                     | arch | lab           | compiler | defc=
onfig          | results
----+------------------------------+------+---------------+----------+-----=
---------------+--------
17  | rk3288-veyron-jaq            | arm  | lab-collabora | gcc-8    | mult=
i_v7_defconfig | 64/65  =


  Results:     64 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-rk3288-veyron-ja=
q.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-rk3288-veyron-ja=
q.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/armel/baseline/rootfs.cpio.gz       =


  bootrr - 61 tests: 60  PASS, 1 FAIL, 0 SKIP
    * rk3x-i2c5-probed:
        never passed  =

                                      =20
