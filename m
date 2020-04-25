Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED431B83B8
	for <lists+linux-pm@lfdr.de>; Sat, 25 Apr 2020 06:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgDYE0A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Apr 2020 00:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbgDYEZ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Apr 2020 00:25:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99010C09B049
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 21:25:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y25so5817358pfn.5
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 21:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ZrwvAt/y+PloGN4H6HdhcLBR2SrYwRf5CUCFUhqY4vU=;
        b=gvLeEE9JUD3Hwp81oFS9QKfjO9eSo6pnC+eHGvT+TeV3QP+v6G/q2cFNN2Zmhnqc19
         GkSaLmo/Ka7PcrzcjIxFv1EeHDDf4LLA8eObhh916GNCooPZQLJbfzCH0iXU7oEPG9PG
         RvF401RurA8TQZXRNyAcothfK4UaD6aRiyMAwVlEbBpuG0UB5Tzp8+jaz6wh4tk/Hysv
         4zS1lENqJtl+SxHRw4ruPk2+VbVLjVOelN3D1Hk5OnfiEEI2ONO7YzVdGTFrfN8nCz7F
         K3kxohDq3jbBr2EN2zLejkJD1cd/KFzewZqJMD0uUF7Sarr/uUYu0NRo4TuTT51KP/YQ
         klsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ZrwvAt/y+PloGN4H6HdhcLBR2SrYwRf5CUCFUhqY4vU=;
        b=r+XwM2NolGFnjT56KYa1bXU8LfAyMi91IJ7YzfczkA+26ENPL19GRGekEgN02kgf8F
         A9a5G0LmJaDmf7shWFjfnH67bIUpRwkUP6+a7qLv6SXfl/BXdPzUT8HtvkZFvWKLoy0o
         sA78ClxblVos4tbNNVAlSEemHqLm9/uuuMFbJQXAeesls2h6UBE3SVWeqByjVeWS+5ag
         q/vKle6P4acZ2y4qP6+bFzzSFrpOyvkZvM1p9T/ln79TrttLqaV+LfNahPWogOHfS+Ai
         omZQBpOYdjoX7enGHJmOTpHAwKO/La5y18RgieOcHx0GzhqOwnFhFPyZwdQ9j5UqvRCI
         zI6A==
X-Gm-Message-State: AGi0PuYTpDAlbYRiJqr8SHc2kt7+dKCGoUHJH0PkavJ4tDZ/lNmJ0lsb
        SmDdxWBTnymGnCCcoMdJBixWk99xifk=
X-Google-Smtp-Source: APiQypIKO5nIb1NWEFt6hODF9l/xq1NJlPIz3xBHbZld6TX+1g8+USzLmyv0Ym6cPiTC5zal7MqmRw==
X-Received: by 2002:a63:f503:: with SMTP id w3mr11933296pgh.397.1587788758905;
        Fri, 24 Apr 2020 21:25:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o11sm6107205pgd.58.2020.04.24.21.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 21:25:58 -0700 (PDT)
Message-ID: <5ea3bbd6.1c69fb81.c075e.2e1d@mx.google.com>
Date:   Fri, 24 Apr 2020 21:25:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pnp-5.7-rc3-19-gcd227cc5ff82
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 62 runs,
 0 regressions (pnp-5.7-rc3-19-gcd227cc5ff82)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 62 runs, 0 regressions (pnp-5.7-rc3-19-gcd227cc5ff82)

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

5   | bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 0/1    =

6   | bcm2837-rpi-3-b              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

7   | exynos4412-odroidx2          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 4/5    =

8   | exynos5422-odroidxu3         | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

9   | hifive-unleashed-a00         | riscv  | lab-baylibre    | gcc-8    | =
defconfig          | 1/1    =

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

23  | meson-gxl-s905d-p230         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

24  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

25  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

26  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

27  | meson-gxm-q200               | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

28  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

29  | meson-sm1-sei610             | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

30  | meson8b-odroidc1             | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

31  | omap3-beagle-xm              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

32  | omap4-panda                  | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

33  | omap4-panda                  | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

34  | qemu_arm-virt-gicv2          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

35  | qemu_arm-virt-gicv3          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

36  | qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

37  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

38  | qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 5/5    =

39  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

40  | qemu_x86_64                  | x86_64 | lab-baylibre    | gcc-8    | =
x86_64_defconfig   | 5/5    =

41  | qemu_x86_64                  | x86_64 | lab-collabora   | gcc-8    | =
x86_64_defconfig   | 5/5    =

42  | rk3288-rock2-square          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

43  | rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 68/68  =

44  | rk3328-rock64                | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

45  | rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 85/88  =

46  | stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

47  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

48  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

49  | sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

50  | sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 5/5    =

51  | sun5i-a13-olinuxino-micro    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

52  | sun7i-a20-cubieboard2        | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

53  | sun7i-a20-cubietruck         | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 1/1    =

54  | sun7i-a20-olinuxino-lime2    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

55  | sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

56  | sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

57  | sun8i-h2-plus-orangepi-zero  | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

58  | sun8i-h3-bananapi-m2-plus    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

59  | sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

60  | tegra124-jetson-tk1          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

61  | tegra124-jetson-tk1          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

62  | tegra124-nyan-big            | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pnp-5.7-rc3-19-gcd227cc5ff82
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      cd227cc5ff829b628f48df3e6b18fc59349c4f9c =



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
  Plain log:   https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-bonebla=
ck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-bonebla=
ck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * crit:
        never passed
        1 lines  =

            =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
5   | bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2=
-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2=
-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

         =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
7   | exynos4412-odroidx2          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-od=
roidx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-od=
roidx2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz       =


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
45  | rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/arm64/baseline/rootfs.cpio.gz     =


  bootrr - 84 tests: 81  PASS, 3 FAIL, 0 SKIP
    * cros-ec-sensors-accel0-probed:
        never passed
    * cros-ec-sensors-accel1-probed:
        never passed
    * cros-ec-sensors-gyro0-probed:
        never passed    =

                                                        =20
