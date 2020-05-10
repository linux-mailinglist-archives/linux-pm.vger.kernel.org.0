Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319221CCB32
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 14:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgEJMvN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 08:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726863AbgEJMvM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 08:51:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929CC061A0C
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 05:51:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f23so2515168pgj.4
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2t9SSUvX/CiDflml3fe6pu58xwJ8WWPxrTk7DQZqeaA=;
        b=LOUOWq4uo/iSVzFtcB2ZwPGtvTvrCGHeypSAMhwQ61wrtLkeBKukC2PglzaTcmXDw/
         Tw/z60TUv15ITmVcbhuJvziflt35BpifH6QeOxOCry+/LkJqEsbnXk5Rsjyr5wOfvqas
         RQfcXDVVnlXpjHpJUiEp49xXTTxoBjj1+MSj3VcmDLCBgkl9B2wV+YRwbAs/qXG0XAGy
         Bb5KBNAv0WeCw8ApnYjSG0/ILWvm9I7tuHDZX8hlocrmRxEX1aPe4nK/gQ2pe88dyiC5
         9CeEY68PJOfcwid8NCo3zlJ9GD245MgNJiMa51kyMCynMX8kfSROXJAStosaPxTNHn4n
         LRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2t9SSUvX/CiDflml3fe6pu58xwJ8WWPxrTk7DQZqeaA=;
        b=axkLLSzeo9jpVApqviriITV/HZeMIs6PDkBKPFnHJHyYsIlUU5d+EFsdW39YsH7Otv
         76aB4WugFILqUirbT0HURocjCuhqAYnpn3fRpmqlU5CQx2yNrC+EIjzSEvr6O5lEuUhq
         UPlNLWOxF3Qm6JSKDH01xE1uRZDyCeXflI29tENypD0YaXVwI97kFBUw24itT/WJ9vXH
         2rlskq1opK2Jtt7Z4nKw1y/ThDlgvz+GoVxX3sjNdqtszorfEzmuRbOZT15eHnWykS/A
         UohhUTEf3aIg/Dpf9HQxeniKTa4+fqrG2fhGhKxEpfrFglUfhZkkA1M1+OUzEtw44Ubc
         xq6A==
X-Gm-Message-State: AGi0PubpcVHNL1xCLPxLCGlgcK0jz5dprPefdxT2a3DCH86tC5/GIpOW
        1BQErheNX9DP3OvsOfyByY5vhcWgPMk=
X-Google-Smtp-Source: APiQypK+VL61tdcGgjDFE80pysHdoR6kVkeG8fLESdIrArgVvbHrpP7hexjdYhsIRKuB3y6T9H/iJg==
X-Received: by 2002:a62:8008:: with SMTP id j8mr5463816pfd.205.1589115070307;
        Sun, 10 May 2020 05:51:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z23sm6673854pfr.136.2020.05.10.05.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 05:51:09 -0700 (PDT)
Message-ID: <5eb7f8bd.1c69fb81.92021.7b58@mx.google.com>
Date:   Sun, 10 May 2020 05:51:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc4-41-g277a1722e66d
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 59 runs,
 0 regressions (v5.7-rc4-41-g277a1722e66d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 59 runs, 0 regressions (v5.7-rc4-41-g277a1722e66d)

Test results summary
--------------------

run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
1   | alpine-db                    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

2   | am335x-boneblack             | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 4/5    =

3   | at91-sama5d4_xplained        | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

4   | bcm2711-rpi-4-b              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

5   | bcm2837-rpi-3-b              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

6   | exynos4412-odroidx2          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 4/5    =

7   | exynos5422-odroidxu3         | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

8   | hifive-unleashed-a00         | riscv  | lab-baylibre    | gcc-8    | =
defconfig          | 1/1    =

9   | imx53-qsrb                   | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

10  | imx6dl-riotboard             | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

11  | imx6q-sabrelite              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

12  | imx6q-sabrelite              | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

13  | imx6q-var-dt6customboard     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

14  | imx6ul-pico-hobbit           | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

15  | imx8mn-ddr4-evk              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

16  | meson-g12a-sei510            | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

17  | meson-g12a-u200              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

18  | meson-g12a-x96-max           | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

19  | meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

20  | meson-g12b-odroid-n2         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

21  | meson-gxbb-p200              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

22  | meson-gxl-s805x-libretech-ac | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

23  | meson-gxl-s805x-p241         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

24  | meson-gxl-s905d-p230         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

25  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

26  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

27  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

28  | meson-gxm-q200               | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

29  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

30  | meson-sm1-sei610             | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

31  | meson8b-odroidc1             | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

32  | omap3-beagle-xm              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

33  | omap4-panda                  | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

34  | omap4-panda                  | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

35  | qemu_arm-virt-gicv2          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

36  | qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

37  | qemu_arm-virt-gicv3          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

38  | qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

39  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

40  | qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 5/5    =

41  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

42  | qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 5/5    =

43  | qemu_x86_64                  | x86_64 | lab-baylibre    | gcc-8    | =
x86_64_defconfig   | 5/5    =

44  | qemu_x86_64                  | x86_64 | lab-collabora   | gcc-8    | =
x86_64_defconfig   | 5/5    =

45  | rk3328-rock64                | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

46  | rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 85/88  =

47  | stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

48  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

49  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

50  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

51  | sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

52  | sun5i-a13-olinuxino-micro    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

53  | sun7i-a20-cubieboard2        | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

54  | sun7i-a20-olinuxino-lime2    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

55  | sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

56  | sun8i-h2-plus-orangepi-zero  | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

57  | sun8i-h3-bananapi-m2-plus    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

58  | sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

59  | tegra124-jetson-tk1          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc4-41-g277a1722e66d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      277a1722e66d47e6fc8b63834273f83631e33562 =



Test Failures
-------------
     =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
2   | am335x-boneblack             | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc4-41-g277a17=
22e66d/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc4-41-g277a17=
22e66d/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/armel/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * crit:
        never passed
        1 lines  =

               =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
6   | exynos4412-odroidx2          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc4-41-g277a17=
22e66d/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc4-41-g277a17=
22e66d/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/armel/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * alert:
        never passed
        1 lines  =

                                                                           =
                                                =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
46  | rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc4-41-g277a17=
22e66d/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc4-41-g277a17=
22e66d/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
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
