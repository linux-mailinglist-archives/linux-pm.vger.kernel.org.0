Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07541D593E
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgEOSmL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 14:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgEOSmJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 14:42:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7D3C061A0C
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 11:42:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so1365247pjb.0
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=I/HUKOTJGsxjSkAlGhignG+2aIB05O+lOpQB97gBp5M=;
        b=Iwo0NR0gBn5Xphki/NkKam33dVih0ffEDQlfaGo+xm/5w9LYTnLVRV0TqfHYIzM3qN
         Ppjl3ys02v2MV+b9gSrLv0noqMIjUZgd+MP7jIQF3+px6L7e9Q8yRsNJMcM3dvPd3iO2
         8nxMlpTltFqNGc1j/MWprpqZppd9Plg5FhjHzcq4Rw6nP1sh3sOCRkcjXdd41tlVtFtW
         RMWqX64gZovWzVh4LZBuFkmxX4bP+r9zUTHwj++bqAHmUt9wsCpGectCTM9AOMMg12GU
         W4j3CsIN3ROPar3GHmm1NeP0lPGJ3P+uCEmN7c028AxvtAanKZPR1Pp89LQTES+58NgA
         pXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=I/HUKOTJGsxjSkAlGhignG+2aIB05O+lOpQB97gBp5M=;
        b=pbJbfgYYO1484tJ6J137+0HU9jhPdZOyawssB6QDCauPFC5zx1rTwU4QKsSrx234mW
         7heXpFlLlAG50LxpOo8LXPY0YXoDORRzZp6KrkalBzmJM2Ox/jidJC2YE8DqSR4DVlwb
         s/7aKtWRu3T+PEjAGdgbLzv8rxybnnEAUsRBZr+s08hVrMUpk/j9Me+DDEsshxoCul9x
         Mh7JfQbOfV2DRqcOmfblUg0TywtLBKT/wd2rXWIJoPNf5PKDpH6iCjiR9JuhauYzf2Y3
         mpXek63QFEPTwH46qlRwot6kwZKTmJ+NRJ3Z2IwmXTnL9sNop3Q3Dn951KqEGeY3vD6G
         bV6w==
X-Gm-Message-State: AOAM533d3NoWi4DUWhCFED4/QAdmQF8oguk9m5pHRaefk9jt22HIGxgQ
        wbKa+pvaOYtg4+uEoatqwqfWmIfiT1I=
X-Google-Smtp-Source: ABdhPJy0Ic+22REXSM8vojLE2KtEPu8QOml79aZx2Lbv81fWBgBxP9Lwca7ro2grasRfHpKDqSI6Ww==
X-Received: by 2002:a17:90a:4ce5:: with SMTP id k92mr5021161pjh.192.1589568128873;
        Fri, 15 May 2020 11:42:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q9sm2455612pff.62.2020.05.15.11.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:42:08 -0700 (PDT)
Message-ID: <5ebee280.1c69fb81.bb7b6.7a1c@mx.google.com>
Date:   Fri, 15 May 2020 11:42:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc5-57-g8ef6544598d6
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 62 runs,
 1 regressions (v5.7-rc5-57-g8ef6544598d6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 62 runs, 1 regressions (v5.7-rc5-57-g8ef6544598d6)

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
defconfig          | 4/5    =

7   | exynos4412-odroidx2          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 4/5    =

8   | exynos5422-odroidxu3         | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

9   | hifive-unleashed-a00         | riscv  | lab-baylibre    | gcc-8    | =
defconfig          | 1/1    =

10  | hip07-d05                    | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 3/5    =

11  | imx53-qsrb                   | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

12  | imx6dl-riotboard             | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

13  | imx6q-sabrelite              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

14  | imx6q-sabrelite              | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

15  | imx6q-var-dt6customboard     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

16  | imx6ul-pico-hobbit           | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

17  | imx8mn-ddr4-evk              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

18  | meson-g12a-u200              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

19  | meson-g12a-x96-max           | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

20  | meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

21  | meson-g12b-odroid-n2         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

22  | meson-gxl-s805x-p241         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

23  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

24  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

25  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

26  | meson-gxm-q200               | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

27  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

28  | meson-sm1-sei610             | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

29  | minnowboard-turbot-E3826     | x86_64 | lab-collabora   | gcc-8    | =
x86_64_defconfig   | 5/5    =

30  | omap3-beagle-xm              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

31  | omap4-panda                  | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

32  | omap4-panda                  | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

33  | qemu_arm-virt-gicv2          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

34  | qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-8    | =
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

40  | qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 5/5    =

41  | qemu_x86_64                  | x86_64 | lab-baylibre    | gcc-8    | =
x86_64_defconfig   | 5/5    =

42  | qemu_x86_64                  | x86_64 | lab-collabora   | gcc-8    | =
x86_64_defconfig   | 5/5    =

43  | rk3288-rock2-square          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

44  | rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 68/68  =

45  | rk3328-rock64                | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

46  | rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 85/88  =

47  | stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

48  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

49  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

50  | sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 5/5    =

51  | sun50i-h6-pine-h64-model-b   | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

52  | sun5i-a13-olinuxino-micro    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

53  | sun7i-a20-cubieboard2        | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

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
  Describe: v5.7-rc5-57-g8ef6544598d6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8ef6544598d61aab12b6b4613971bf53256b14eb =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
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
5   | bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/armel/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

      =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
6   | bcm2837-rpi-3-b              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * crit:
        new failure (last pass: v5.7-rc5-53-gfbe093dd16f4)
        1 lines  =

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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/armel/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * alert:
        never passed
        1 lines  =

            =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
10  | hip07-d05                    | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 3/5    =


  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
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
