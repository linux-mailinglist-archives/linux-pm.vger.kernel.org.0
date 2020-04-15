Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF391A91C7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 06:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388805AbgDOEXN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 00:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgDOEXK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 00:23:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83782C061A0C
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 21:23:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a32so6239796pje.5
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 21:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ZV4j+U1opDBdU/te0uqIZ9nuZs6MGyClzeeyHBZfP2A=;
        b=ioUv5PNDH+uiV06DE7OPF95zx2h1fpmf6h/HPXt9cVMbQ/dk+pmoDVarIMRa7DUKh1
         trRmH7aN3YbZ8yPSZJI43jDVUMYVI2TIez2gE+J1cdPgosNetekp9AFnoUTlKfUdGjto
         H21lsSMDdm3JqBr6AAlPXBSUaf4A4Bdg/aS6VOg8FK1TZ2Uh8ogAi8OcABfPLGslW1cX
         GzFewhXlm5fw8SbWEkLK05Jxt+Exw6iXxj/R6YQlBwY8ZPgNSW2tPFKdeIgVipHhajja
         JHrrm8TE/ZEXBQj25kwLSb6yrQX+NdzTLO5/D0yqcSoyrFQtHEmBb3dDPas2BamOwhB1
         KT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ZV4j+U1opDBdU/te0uqIZ9nuZs6MGyClzeeyHBZfP2A=;
        b=XWMyLKl+mDX/iwtb49rhFMUIqZ4Gfx4NYBm51HWnwWevD/Ipn+p+po4xQuZHloa4aQ
         D441ClWg6Q8yFHgVbX6EqOPXEg7J9uNXGW1WDwVxISYReW96i9uHc3OuOz0ZgkDm/nc8
         9BKDk24FL0LhGBpwm61aZ+WjgPGvXe0alKyXBy4mZxAx9dsHE02SnM660au6NgB5MU+/
         3J21N6+ChdpT22mPw6wjtpfsYsBOsllKyFbbjlbj9BQY7rN+IGUK7v5674ANd4Qg/Ml0
         agRkA24dq21PNsuU6akMVrME755r1rJi8HMTFo+D+udq44sbfW9YsQHQcmO21hCrbcMX
         FyRQ==
X-Gm-Message-State: AGi0PuYfX7fCpnTBEVUjbnf5RYXmk70JlT4JoOzUPGeKXjyvll8q2koT
        Zb35fSNgCDEyyVQ0ahxRF7cNJwVnr8s=
X-Google-Smtp-Source: APiQypJ73MIBiNhOOwWK5hp8wHRLYCxylpR1F3oeo4kD0dk3DdIyyRlWVbAh3bB3dj/k1ZkbDZ1CFg==
X-Received: by 2002:a17:90a:af8e:: with SMTP id w14mr3900431pjq.164.1586924588867;
        Tue, 14 Apr 2020 21:23:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f3sm12895563pjo.24.2020.04.14.21.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 21:23:08 -0700 (PDT)
Message-ID: <5e968c2c.1c69fb81.59e0f.bd17@mx.google.com>
Date:   Tue, 14 Apr 2020 21:23:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.7-rc1-2-g38aeec472905
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 62 runs, 0 regressions (v5.7-rc1-2-g38aeec472905)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 62 runs, 0 regressions (v5.7-rc1-2-g38aeec472905)

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
    | multi_v7_defconfig | 2/2    =

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

14  | imx6ul-pico-hobbit           | arm    | lab-pengutronix       | gcc-8=
    | multi_v7_defconfig | 5/5    =

15  | imx8mn-ddr4-evk              | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

16  | meson-g12a-sei510            | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

17  | meson-g12a-u200              | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

18  | meson-g12a-x96-max           | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

19  | meson-g12b-odroid-n2         | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

20  | meson-gxbb-p200              | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

21  | meson-gxl-s805x-libretech-ac | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

22  | meson-gxl-s905d-p230         | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

23  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

24  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

25  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

26  | meson-gxm-q200               | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

27  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

28  | meson-sm1-sei610             | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

29  | meson8b-odroidc1             | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

30  | omap3-beagle-xm              | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

31  | omap4-panda                  | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

32  | omap4-panda                  | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

33  | qemu_arm-virt-gicv2          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

34  | qemu_arm-virt-gicv2          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

35  | qemu_arm-virt-gicv3          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

36  | qemu_arm-virt-gicv3          | arm    | lab-collabora         | gcc-8=
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

42  | qemu_x86_64                  | x86_64 | lab-collabora         | gcc-8=
    | x86_64_defconfig   | 5/5    =

43  | rk3288-rock2-square          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

44  | rk3288-veyron-jaq            | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 66/66  =

45  | rk3328-rock64                | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

46  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 85/88  =

47  | rk3399-puma-haikou           | arm64  | lab-theobroma-systems | gcc-8=
    | defconfig          | 5/5    =

48  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

49  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

50  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

51  | sun50i-h6-pine-h64           | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

52  | sun50i-h6-pine-h64-model-b   | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

53  | sun5i-a13-olinuxino-micro    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

54  | sun7i-a20-cubieboard2        | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

55  | sun7i-a20-olinuxino-lime2    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

56  | sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

57  | sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

58  | sun8i-h2-plus-orangepi-zero  | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

59  | sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

60  | tegra124-jetson-tk1          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

61  | tegra124-jetson-tk1          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =

62  | tegra124-nyan-big            | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc1-2-g38aeec472905
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      38aeec47290576cd1f4112fab3937c855a0331d9 =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * crit:
        never passed
        1 lines  =

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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz  =


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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroid=
x2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroid=
x2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * alert:
        never passed
        1 lines  =

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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
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


run | platform                     | arch   | lab                   | compi=
ler | defconfig          | results
----+------------------------------+--------+-----------------------+------=
----+--------------------+--------
46  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc1-2-g38aeec4=
72905/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
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
