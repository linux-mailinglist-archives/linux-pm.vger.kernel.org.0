Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8B8189AE6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 12:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCRLnf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 07:43:35 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:35987 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRLnf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 07:43:35 -0400
Received: by mail-pl1-f177.google.com with SMTP id g2so8568457plo.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2020 04:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=C7GgE541tC9UNOFWVFFAAUd0naeGlCDMQiCXGqpgwI4=;
        b=Id1oeAiq7sIhPpXuzrk2MnBiWTuyOSt9LQfUKDJWovXIvzbrjR2BhJXxwQeCR+GRri
         hGgZYwvglw/lL5ebJkItL1sg1I+Y9GTqxqGZPhxG5gPdt0KLPDgx8LSz8p7ujXqeODgN
         pdVDYiSih7B1mIWs+6lKj6KhiU+AF6CK2VRf11dO+7D9MWUjONKaUR4TEm2qddcEui5x
         bUeJ52GUlr0njHEtlrYRXiDeYN4hJKUXh0+M9RnmiO/tO/iQng+q+x+e/uvuMXZFlief
         Zhmdrt0M0GbkmteepgMf+4TU2iRJWANxHAbkT9nXlJIzHR72+PG/AdswsCJzP76JUdbD
         9bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=C7GgE541tC9UNOFWVFFAAUd0naeGlCDMQiCXGqpgwI4=;
        b=I+v+5l2Omw2GDpHy1rStekzDC6Kpp+XwuRwS9HsLnA6qrDHifPfZqkSy7G36MvBhJN
         aDX0BynO/xSSUo6czsBm6dlu+PIZVIWvcMGHtfM9hnAxP+DonfBlU8orcntiCy0De/Eb
         08eldxTArcR1zuPr3kJyrQZbZiIKAsYAQEzlzv2t1/PIoG2d17/LKXgYs/gOgfQY4+8m
         HQLMvlrOpxO2Y29nLO8UP6nt1ECzrr1AbPd5WDWRPZWyatrvnHBf4RI/ih0QnlkBZTf1
         glwg5TbFezjBPN9Hpesilt+CXhuMT00hwfyJz3j0/nBGJpfdSYa/lRl4G5JhOKruxU8K
         CiUg==
X-Gm-Message-State: ANhLgQ3SwPWjBwHZm1R3ZyRlyhaB32eZJHuMtNrX5BxlY7iEJn8YeT0X
        Fwb1DLWvVWUDr/VzSbu6rhb7N23Jp4A=
X-Google-Smtp-Source: ADFU+vsF5NtryloooVHHKFX9u4cYvlcLDmnq0uPO+yHh3j4p0uao6JH2Gr8v/EJuRqvmAGCisWo/4Q==
X-Received: by 2002:a17:90a:1b42:: with SMTP id q60mr4300396pjq.84.1584531812562;
        Wed, 18 Mar 2020 04:43:32 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y3sm2347968pfy.158.2020.03.18.04.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 04:43:31 -0700 (PDT)
Message-ID: <5e720963.1c69fb81.e0eee.8569@mx.google.com>
Date:   Wed, 18 Mar 2020 04:43:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-102-gc03d064a440c
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 59 runs,
 0 regressions (v5.6-rc6-102-gc03d064a440c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 59 runs, 0 regressions (v5.6-rc6-102-gc03d064a440c)

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
    | defconfig          | 4/4    =

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

32  | minnowboard-turbot-E3826     | x86_64 | lab-collabora         | gcc-8=
    | x86_64_defconfig   | 5/5    =

33  | omap3-beagle-xm              | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

34  | omap4-panda                  | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

35  | omap4-panda                  | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

36  | qemu_arm-virt-gicv2          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

37  | qemu_arm-virt-gicv3          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

38  | qemu_arm64-virt-gicv2        | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

39  | qemu_arm64-virt-gicv3        | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

40  | qemu_x86_64                  | x86_64 | lab-collabora         | gcc-8=
    | x86_64_defconfig   | 5/5    =

41  | rk3288-rock2-square          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

42  | rk3288-veyron-jaq            | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 68/68  =

43  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 85/88  =

44  | rk3399-puma-haikou           | arm64  | lab-theobroma-systems | gcc-8=
    | defconfig          | 5/5    =

45  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

46  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

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
  Describe: v5.6-rc6-102-gc03d064a440c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c03d064a440c2a5cbe3da782db05d3e18dc5ec3e =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack=
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b=
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odro=
idx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odro=
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
43  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
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
