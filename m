Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281261C2ACE
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgECJB6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 05:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgECJB6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 05:01:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCE6C061A0C
        for <linux-pm@vger.kernel.org>; Sun,  3 May 2020 02:01:58 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f7so4002243pfa.9
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2020 02:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4al/g7oFP8u4qilOU2JBzcl+jES+WbkKJJBarXYjAyQ=;
        b=g2ZOtq9WZpT3xu7M8pXdvWNUcK0zD7XmWdThiF0Nq5l3jiNXPB1KCiHkQKoN2aqkaO
         b5mTPeORuxmDGMAN/wnuDZ/aNkIFOFgIVSZv8ZaEWoz8GBefcbYKI0MjpmUtGRu6XgU/
         gP/wP2PR6ZY1D7R5XSPzpv+fkPbYqtFEJRioA+a7Tq3rIg+v5RTZ7iTorUdeaRmnPP79
         dlKv3svKkkxVvUx0KoI9jqK1mt99Q1TZ1hDG/LwL4Ey7nC6p9//QiFJIbYTafrUwT8ZQ
         1DYVx1iIqfX7KfC+2G2LBHX9IGls6eud6z3LXnZSahL1E7NFFYxNwdtyaszJlf+bqoRa
         0+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4al/g7oFP8u4qilOU2JBzcl+jES+WbkKJJBarXYjAyQ=;
        b=GcW4RvoUKe3N4BQj1ui98W07MlZCx/0V0VWip32HpoCdGpLGwQNYfQWMvEwZLG9FL4
         z0N/6ABqPM6pf7zunzVYhJwI1GaJuGvgUjg5JW9Wn/LqdvnB6uwqBjV8d49KF/2qlIyX
         6/03r9yTYLeEYLlX7xy4roB87NFCP1kI06BAmg5IwyTZmfJX9ZAEz/BgNmO2F87BeKng
         RF/NFTizq8jmCL+fsOE7r1FzKcED+royRPRho8U9vly8rbB7Kh5O4MoDeqvRejacGNSv
         CwczorNzheFUNHdu9bGCdscgusmT57zYXUqV8oMatlkHkE+AOpVNLIJY9MPBf27bbGr9
         VeGA==
X-Gm-Message-State: AGi0PuZa+nuMw9l1YcWyKscqnRFF44vaj0BsDf1DfU5a42+4eQ8gOCXO
        1SfSB36BWeJNSI0Sy1YoN4FDaQ==
X-Google-Smtp-Source: APiQypI7S0NtJOsKSydKiE7cpz6RyA3ISRfhVTDvsp2cWqtWp9EwzaBr9t+WuKoHEdQrB4nKCtlnog==
X-Received: by 2002:a63:5704:: with SMTP id l4mr12345747pgb.85.1588496517492;
        Sun, 03 May 2020 02:01:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t80sm6243305pfc.23.2020.05.03.02.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 02:01:56 -0700 (PDT)
Message-ID: <5eae8884.1c69fb81.804e1.98fe@mx.google.com>
Date:   Sun, 03 May 2020 02:01:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc3-24-g1985b45de014
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 51 runs,
 1 regressions (v5.7-rc3-24-g1985b45de014)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 51 runs, 1 regressions (v5.7-rc3-24-g1985b45de014)

Test results summary
--------------------

run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
1   | bcm2711-rpi-4-b              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

2   | bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 0/1    =

3   | bcm2837-rpi-3-b              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

4   | exynos4412-odroidx2          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 4/5    =

5   | exynos5422-odroidxu3         | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 0/1    =

6   | hifive-unleashed-a00         | riscv  | lab-baylibre    | gcc-8    | =
defconfig          | 1/1    =

7   | hip07-d05                    | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 3/5    =

8   | imx6dl-riotboard             | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

9   | imx6q-sabrelite              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

10  | imx6q-var-dt6customboard     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

11  | imx6ul-pico-hobbit           | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

12  | imx8mn-ddr4-evk              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

13  | meson-g12a-x96-max           | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

14  | meson-g12b-odroid-n2         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

15  | meson-gxbb-p200              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

16  | meson-gxl-s805x-p241         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

17  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

18  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

19  | meson-gxm-q200               | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

20  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

21  | meson-sm1-sei610             | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

22  | omap4-panda                  | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

23  | omap4-panda                  | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

24  | qemu_arm-virt-gicv2          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

25  | qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

26  | qemu_arm-virt-gicv3          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

27  | qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

28  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

29  | qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 5/5    =

30  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

31  | qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 5/5    =

32  | qemu_x86_64                  | x86_64 | lab-baylibre    | gcc-8    | =
x86_64_defconfig   | 5/5    =

33  | qemu_x86_64                  | x86_64 | lab-collabora   | gcc-8    | =
x86_64_defconfig   | 5/5    =

34  | rk3288-rock2-square          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

35  | rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 68/68  =

36  | rk3328-rock64                | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

37  | rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 85/88  =

38  | stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

39  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

40  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

41  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

42  | sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 5/5    =

43  | sun5i-a13-olinuxino-micro    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

44  | sun7i-a20-olinuxino-lime2    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

45  | sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

46  | sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

47  | sun8i-h2-plus-orangepi-zero  | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

48  | sun8i-h3-bananapi-m2-plus    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

49  | sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

50  | tegra124-jetson-tk1          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

51  | tegra124-nyan-big            | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc3-24-g1985b45de014
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1985b45de01473658db9194e948eb151f9e076ae =



Test Failures
-------------
     =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
2   | bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
html
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
4   | exynos4412-odroidx2          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * alert:
        never passed
        1 lines  =

      =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
5   | exynos5422-odroidxu3         | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odroi=
dxu3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odroi=
dxu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: v5.7-rc3-21-gd38f9bc9261a)   =

         =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
7   | hip07-d05                    | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 3/5    =


  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/arm64/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 1  PASS, 2 FAIL, 0 SKIP
    * alert:
        never passed
        11 lines
    * emerg:
        never passed
        2 lines  =

                                                                           =
                  =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
37  | rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
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
