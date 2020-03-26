Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217BC194B85
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 23:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCZW2Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 18:28:25 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:46332 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgCZW2Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 18:28:25 -0400
Received: by mail-pg1-f169.google.com with SMTP id k191so3592661pgc.13
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aMJn0FbSvRWjK9mp1f1WMmwey+IK3Yg4cNNKDdl61VA=;
        b=hdk8NiPTBiGBV/bmFWqbapBqxUC4z624pSmEmLJ0lPsuP2wWLOq9xgBI1GzJ2ICREF
         iajakU+lMYnU5B2nUKL+dM1Ysge7QJZ/66mzYVLwOe9mbDs2dCgimERa8iqdBem98l2/
         kOXc1AbjnL5npxIt1u5YtgvcnuLu3VvUQa6KouG6rsPpbJIfC5Ama1yw4REzsAy8wulV
         tBuI8W6WmVtVtjNK8yFjcj8HWdZ6QlVwXD5UX8oUwRdFsWg7vitreFp1JkE4L2a0TG6z
         IBIkiZ3vTYlijjLDlCsDxBqEY9L/n080Yg8s1l+aQcgq2GLvh4RJP0F1POSivdYsthLc
         nnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aMJn0FbSvRWjK9mp1f1WMmwey+IK3Yg4cNNKDdl61VA=;
        b=NUMw/mgV8Aa6QNOuX4CxZDcnt1rcFovF4UXGJaI26KoEWWnhMQndD6jobAY9IA62Po
         PQdBPZ9dGTijC+orVmspy70ihmBsMLkNsyBXkcyWkuYBpAg1mtQpiPzDqLwh4SSofNDy
         lAHGKgramejTK6K+/SRhqllBogQxXMa/hJ97YYZJtuDpk0L95c95GYe8MkkzuPlacGMw
         KI8FkijJQFwLvgOpXD8AJJml8jOcBAOftBKrGM7r4S5IHVoFjO5KRYBEm7Gvdg1LWZDG
         9QFn3dBfFRgYSM2NZkdvh30KSEjusoxs1cjTIpSbFlq/OZIU6HLmjjQ0CXAL+2fs/27c
         m1PQ==
X-Gm-Message-State: ANhLgQ32jbeU5lwOyJ34AmHydkMc1Ad6tKg9izBoBM0qCAu7A2ahg6g6
        dXgq5HBUaaQLd+yZLeY+bO0DP1mYLmw=
X-Google-Smtp-Source: ADFU+vsRqux+hi0HfuyHa1oh4xOlSr2FPA3VF3sNxUMfpiAeYJcKS2oM7BoAeKTHA3qs+NASQxrx2Q==
X-Received: by 2002:a65:62c7:: with SMTP id m7mr10917524pgv.380.1585261703162;
        Thu, 26 Mar 2020 15:28:23 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q71sm2384184pjb.5.2020.03.26.15.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 15:28:22 -0700 (PDT)
Message-ID: <5e7d2c86.1c69fb81.16be6.84a8@mx.google.com>
Date:   Thu, 26 Mar 2020 15:28:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc7-129-g8b4ddf47b7b4
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 59 runs,
 0 regressions (v5.6-rc7-129-g8b4ddf47b7b4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 59 runs, 0 regressions (v5.6-rc7-129-g8b4ddf47b7b4)

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

22  | meson-gxl-s805x-p241         | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

23  | meson-gxl-s905d-p230         | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

24  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

25  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

26  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

27  | meson-gxm-q200               | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

28  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

29  | meson-sm1-sei610             | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

30  | minnowboard-turbot-E3826     | x86_64 | lab-collabora         | gcc-8=
    | x86_64_defconfig   | 5/5    =

31  | omap3-beagle-xm              | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

32  | omap4-panda                  | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

33  | omap4-panda                  | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

34  | qemu_arm-virt-gicv2          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

35  | qemu_arm-virt-gicv2          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

36  | qemu_arm-virt-gicv3          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

37  | qemu_arm-virt-gicv3          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

38  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

39  | qemu_arm64-virt-gicv2        | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

40  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

41  | qemu_arm64-virt-gicv3        | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

42  | qemu_x86_64                  | x86_64 | lab-baylibre          | gcc-8=
    | x86_64_defconfig   | 5/5    =

43  | qemu_x86_64                  | x86_64 | lab-collabora         | gcc-8=
    | x86_64_defconfig   | 5/5    =

44  | rk3288-rock2-square          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

45  | rk3288-veyron-jaq            | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 68/68  =

46  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 85/88  =

47  | rk3399-puma-haikou           | arm64  | lab-theobroma-systems | gcc-8=
    | defconfig          | 5/5    =

48  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

49  | sun50i-h6-pine-h64           | arm64  | lab-collabora         | gcc-8=
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
  Describe: v5.6-rc7-129-g8b4ddf47b7b4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8b4ddf47b7b4dd54539f1821c95a8dee3295fb0b =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack=
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b=
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odro=
idx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odro=
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
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
                                    =


run | platform                     | arch   | lab                   | compi=
ler | defconfig          | results
----+------------------------------+--------+-----------------------+------=
----+--------------------+--------
46  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc7-129-g8b4dd=
f47b7b4/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
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
