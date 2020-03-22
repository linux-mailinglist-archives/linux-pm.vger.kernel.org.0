Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA95F18E84C
	for <lists+linux-pm@lfdr.de>; Sun, 22 Mar 2020 12:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCVLNi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Mar 2020 07:13:38 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:37635 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCVLNi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Mar 2020 07:13:38 -0400
Received: by mail-pl1-f179.google.com with SMTP id x1so583335plm.4
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2020 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YFNVUPPQwITu+ch8e0xAP8rgkXd1NCmyLw57IZmOWV4=;
        b=e9Mvk4bGJFvhPukPPYspxyLNzWUEmofUlomubSGXvlkVvwmJVnu9psKHOJAKrCwjVF
         bEjldaD4jTxqSeOA0Dg9/57C6SNSwQF1b8S3DvjM3pQkH0y8ZyqT+kZCBttkN/FJtohW
         H01lBWMOwAnlmtdbrLpayWhuZm4wssEzJAgR0wrDgnXmKTmwWGI3Mxds05EziCl2q2KN
         LXjyYyYFHqYP5fomvNzGUhA0TM7qbA+Gsuh8mXA6DK4VCQPVEXyFpvZxgGGWTSoHC/vE
         mlXKgCq4ZPW6yuyDpxqSooB4NMUwRBn6BdyKgZrqTjOkScLujQ02k5GcvKTVRqwq7lb+
         EQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YFNVUPPQwITu+ch8e0xAP8rgkXd1NCmyLw57IZmOWV4=;
        b=HVSYnoq0busBv9IMN6w/URW+T4jArhAvE2CT38QAs+wNLOzFoCyZFP0Phxn60GYAO/
         HWO3QLdoUeLPBKI9u3g367NfMc+0IS11hSVfWGss4HMCe8V32F3/vHcwrE5pl8hNONoK
         iKFJOb/BUb3dQ2nt09+T8AO5Bc/OlHlCQgemxyAYLHTckAvL1FEj+Zl8/k5HDILd2a/A
         Q4LL948OUAJtJ7LzzwWCBu36lXG9/qa0G5RZuOAbzCQC54F+z6gXweWJUap8Lq0RQo/b
         5oGLdKFdP8glE15XmwmwOil/H2899qIVjiLrNH5tet7JTGkFaHpnzV90O3P7JaaXgEk6
         4fvw==
X-Gm-Message-State: ANhLgQ1ZD+lKL7O78mUMs6+8HUzz00e4Bt8p+sr4BWaH2k5gV9paiaME
        qJkVfS6D9bM/mwmESbrcM7DxDA==
X-Google-Smtp-Source: ADFU+vtdP1HAp0fZeSwCPO7b0aPN95aHnmzjBjPS5LvBH+YO1eC3R1o8jGPSzFNQS3lCDCrfQUiTJA==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3mr17316100plt.27.1584875616047;
        Sun, 22 Mar 2020 04:13:36 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k5sm9119881pju.29.2020.03.22.04.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 04:13:35 -0700 (PDT)
Message-ID: <5e77485f.1c69fb81.eac9.0b3c@mx.google.com>
Date:   Sun, 22 Mar 2020 04:13:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-104-g5e3ada361a7a
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 64 runs,
 1 regressions (v5.6-rc6-104-g5e3ada361a7a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 64 runs, 1 regressions (v5.6-rc6-104-g5e3ada361a7a)

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

8   | exynos5422-odroidxu3         | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

9   | hifive-unleashed-a00         | riscv  | lab-baylibre          | gcc-8=
    | defconfig          | 1/1    =

10  | hip07-d05                    | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 3/5    =

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
    | defconfig          | 0/1    =

29  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

30  | meson-sm1-sei610             | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

31  | meson8b-odroidc1             | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

32  | minnowboard-turbot-E3826     | x86_64 | lab-collabora         | gcc-8=
    | x86_64_defconfig   | 5/5    =

33  | omap3-beagle-xm              | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

34  | omap4-panda                  | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

35  | omap4-panda                  | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

36  | qemu_arm-virt-gicv2          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

37  | qemu_arm-virt-gicv2          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

38  | qemu_arm-virt-gicv3          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

39  | qemu_arm-virt-gicv3          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

40  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

41  | qemu_arm64-virt-gicv2        | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

42  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

43  | qemu_arm64-virt-gicv3        | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

44  | qemu_x86_64                  | x86_64 | lab-baylibre          | gcc-8=
    | x86_64_defconfig   | 5/5    =

45  | qemu_x86_64                  | x86_64 | lab-collabora         | gcc-8=
    | x86_64_defconfig   | 5/5    =

46  | rk3288-rock2-square          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

47  | rk3288-veyron-jaq            | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 68/68  =

48  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 85/88  =

49  | rk3399-puma-haikou           | arm64  | lab-theobroma-systems | gcc-8=
    | defconfig          | 5/5    =

50  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

51  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

52  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

53  | sun50i-h6-pine-h64           | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

54  | sun50i-h6-pine-h64-model-b   | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

55  | sun5i-a13-olinuxino-micro    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

56  | sun7i-a20-cubieboard2        | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

57  | sun7i-a20-olinuxino-lime2    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

58  | sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

59  | sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

60  | sun8i-h2-plus-orangepi-zero  | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

61  | sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

62  | tegra124-jetson-tk1          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

63  | tegra124-jetson-tk1          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

64  | tegra124-nyan-big            | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc6-104-g5e3ada361a7a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5e3ada361a7aef36e173fc7004a8e9f0066f9010 =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack=
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b=
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odro=
idx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odro=
idx2.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * alert:
        never passed
        1 lines    =

            =


run | platform                     | arch   | lab                   | compi=
ler | defconfig          | results
----+------------------------------+--------+-----------------------+------=
----+--------------------+--------
10  | hip07-d05                    | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 3/5    =


  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-9-g25091c539382/arm64/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 1  PASS, 2 FAIL, 0 SKIP
    * alert:
        never passed
        11 lines
    * emerg:
        never passed
        2 lines    =

                                                         =


run | platform                     | arch   | lab                   | compi=
ler | defconfig          | results
----+------------------------------+--------+-----------------------+------=
----+--------------------+--------
28  | meson-gxm-q200               | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-9-g25091c539382/arm64/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: v5.6-rc6-100-g37da629c357d)   =

                                                               =


run | platform                     | arch   | lab                   | compi=
ler | defconfig          | results
----+------------------------------+--------+-----------------------+------=
----+--------------------+--------
48  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-104-g5e3ad=
a361a7a/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
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
