Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C8718B28B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 12:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgCSLtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 07:49:50 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:40508 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgCSLtu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 07:49:50 -0400
Received: by mail-pf1-f175.google.com with SMTP id l184so1299718pfl.7
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 04:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=I4XA78Bd2Dq0bOkaphDszqE41TsYUYZxHYZOCy397go=;
        b=0+X7Q5N5OXkrylixT1vaQJvLySyM7Eil9yiRgcUoS3K1ruaTwymEAgQKxURlKqVY0d
         spde499i7kzGO0JrFBr0ExS9l/9wp+fZbx5a5GZvYIOPpEef+EAoy+7qnVFTBuut+SqQ
         dPkHDyD3qB55J0wRW4hTmr9vVQKt26Uqg1RHm57O992IN0Fbl9pgJ4PmuBImVVYmmF6o
         DxoBydTqQ8lfql+gmwhG6hYEKhwLi/N5FQtWe308YTvBbT4Buy9TPYlXRbauo9PxvSLz
         iuma90BzFKmt/VwcIJBsJt/qvDVUNMmhgEvrGPll+xhleGzhZm0mUMJRsVqzMV+JKLc8
         iIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=I4XA78Bd2Dq0bOkaphDszqE41TsYUYZxHYZOCy397go=;
        b=Bl1QDRm5NgndmDvqqgI5lYyNvL8//7ZL5HTgU78i6WCTYV7qnZMijQYsiQCb/t0R+s
         0lXSW/hALEaZnw17PpW4WoeV7lWVtwuVBR0NrrDz3RkucPB+zFVaWLrBC2Gzb2WKImEF
         XSpR75w+VmdIJF1lPfnLmmYFCCgMtycVeBGwbBvEWPA1UJ6FbBHTJ9bFV4IsqWcZAuWG
         FbAa7mgoy2wEXIhdSj60n4fuC64HtF/MxU65DLConzdiGXV6yodl8LM9hueEwcGriiYo
         ephu8zyn0oSCGCFhMyvv5kg5wmve8DEjNtClNdslw8igUHWyFJ0nR2aZH7jYiF1BSrCC
         7NAg==
X-Gm-Message-State: ANhLgQ1PONmbx2K1jrIDyWQnu/h0qlInna5n9r4kMWAQFcziaUomGsOV
        RfntLeWp9hUwQYB9EfYc+GYobhn4Fg0=
X-Google-Smtp-Source: ADFU+vu2g9kmIjVqZadL2iqNDkXmm5NjfYf3xxwI3uz1gQYkInSjQvk0AazWqAHef8ZUbWMGOu2DVA==
X-Received: by 2002:aa7:9e42:: with SMTP id z2mr3514328pfq.109.1584618588291;
        Thu, 19 Mar 2020 04:49:48 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m18sm2185234pgd.39.2020.03.19.04.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 04:49:47 -0700 (PDT)
Message-ID: <5e735c5b.1c69fb81.fd7e.8ca3@mx.google.com>
Date:   Thu, 19 Mar 2020 04:49:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-100-g37da629c357d
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 59 runs,
 0 regressions (v5.6-rc6-100-g37da629c357d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 59 runs, 0 regressions (v5.6-rc6-100-g37da629c357d)

Test results summary
--------------------

run | platform                     | arch   | lab                   | compi=
ler | defconfig          | results
----+------------------------------+--------+-----------------------+------=
----+--------------------+--------
1   | alpine-db                    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

2   | am335x-boneblack             | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 4/5    =

3   | at91-sama5d4_xplained        | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

4   | bcm2711-rpi-4-b              | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

5   | bcm2836-rpi-2-b              | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 0/1    =

6   | bcm2837-rpi-3-b              | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

7   | exynos4412-odroidx2          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 4/5    =

8   | exynos5250-snow              | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

9   | exynos5422-odroidxu3         | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

10  | hifive-unleashed-a00         | riscv  | lab-baylibre          | gcc-8=
    | defconfig          | 1/1    =

11  | imx53-qsrb                   | arm    | lab-pengutronix       | gcc-8=
    | multi_v7_defconfig | 5/5    =

12  | imx6dl-riotboard             | arm    | lab-pengutronix       | gcc-8=
    | multi_v7_defconfig | 5/5    =

13  | imx6q-sabrelite              | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

14  | imx6q-sabrelite              | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

15  | imx6ul-pico-hobbit           | arm    | lab-pengutronix       | gcc-8=
    | multi_v7_defconfig | 5/5    =

16  | imx8mn-ddr4-evk              | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

17  | meson-g12a-sei510            | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

18  | meson-g12a-u200              | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

19  | meson-g12a-x96-max           | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

20  | meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

21  | meson-g12b-odroid-n2         | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

22  | meson-gxl-s805x-libretech-ac | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

23  | meson-gxl-s805x-p241         | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

24  | meson-gxl-s905d-p230         | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

25  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

26  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

27  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

28  | meson-gxm-q200               | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

29  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

30  | meson-sm1-sei610             | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

31  | meson8b-odroidc1             | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

32  | omap3-beagle-xm              | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

33  | omap4-panda                  | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

34  | omap4-panda                  | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

35  | qemu_arm-virt-gicv2          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

36  | qemu_arm-virt-gicv3          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

37  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

38  | qemu_arm64-virt-gicv2        | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

39  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

40  | qemu_arm64-virt-gicv3        | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

41  | qemu_x86_64                  | x86_64 | lab-baylibre          | gcc-8=
    | x86_64_defconfig   | 5/5    =

42  | rk3288-rock2-square          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

43  | rk3288-veyron-jaq            | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 68/68  =

44  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 85/88  =

45  | rk3399-puma-haikou           | arm64  | lab-theobroma-systems | gcc-8=
    | defconfig          | 5/5    =

46  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

47  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

48  | sun50i-h6-pine-h64           | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

49  | sun50i-h6-pine-h64-model-b   | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

50  | sun5i-a13-olinuxino-micro    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

51  | sun7i-a20-cubieboard2        | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

52  | sun7i-a20-olinuxino-lime2    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

53  | sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

54  | sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

55  | sun8i-h2-plus-orangepi-zero  | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

56  | sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

57  | tegra124-jetson-tk1          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

58  | tegra124-jetson-tk1          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

59  | tegra124-nyan-big            | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc6-100-g37da629c357d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      37da629c357d0ce08072f1532fae2091e467ae42 =



Test Failures
-------------
     =


run | platform                     | arch   | lab                   | compi=
ler | defconfig          | results
----+------------------------------+--------+-----------------------+------=
----+--------------------+--------
2   | am335x-boneblack             | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack=
.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * crit:
        never passed
        1 lines    =

            =


run | platform                     | arch   | lab                   | compi=
ler | defconfig          | results
----+------------------------------+--------+-----------------------+------=
----+--------------------+--------
5   | bcm2836-rpi-2-b              | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b=
.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

         =


run | platform                     | arch   | lab                   | compi=
ler | defconfig          | results
----+------------------------------+--------+-----------------------+------=
----+--------------------+--------
7   | exynos4412-odroidx2          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odro=
idx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odro=
idx2.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * alert:
        never passed
        1 lines    =

                                                                           =
                                       =


run | platform                     | arch   | lab                   | compi=
ler | defconfig          | results
----+------------------------------+--------+-----------------------+------=
----+--------------------+--------
44  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-9-g25091c539382/arm64/baseline/rootfs.cpio.gz       =


  bootrr - 84 tests: 81  PASS, 3 FAIL, 0 SKIP
    * cros-ec-sensors-accel0-probed:
        never passed
    * cros-ec-sensors-accel1-probed:
        never passed
    * cros-ec-sensors-gyro0-probed:
        never passed  =

                                                  =20
