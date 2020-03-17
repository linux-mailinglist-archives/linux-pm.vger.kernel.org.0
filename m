Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E88188ED9
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 21:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCQUT0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 16:19:26 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:44007 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQUT0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 16:19:26 -0400
Received: by mail-pf1-f179.google.com with SMTP id f206so1556990pfa.10
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2020 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SyDU7AULaz56WJMk4OH+pUfp24bkweY5FEyDHAYFN7s=;
        b=WSANIQQn2K/t8PNxhLDU5fI4l31/ujYYPM5fsIz5cSE9AwKQW/q3nHI5h6rdFipWhF
         tzOwZZSa2BZXvIZ+orXlt0DrzF1tEOi//j5Sr6Q3vqMrXoGREriYoHJn4AG+YuDDKVL6
         kjAIGyeU08ZLQJMI+PNb8SSxvCOjCSgUDO0EMsxPq6MclrAFAXZiY/4NKJvkVfkvdvuu
         YKhP4J05fCsKkliizcltUI0ItiPvLUv8KwQOZjXrdJ2NBpyeDheRz1tjUlNkRwS0hbqb
         KvGobbJJ2JSa/C8obX/DTkeBh2jHf7iPaf/G+e6dKdLDw72poU5TO6yKjONOt/FGC9Cy
         b+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SyDU7AULaz56WJMk4OH+pUfp24bkweY5FEyDHAYFN7s=;
        b=gbuAzRgI2S/HD1quYJHoLfZBQrXChYMNWjliwnF34QwCVLBS2X0taQ+tx/Fi83CmCr
         Eiijy/Goq4SCNaSrjwxVqM3GLQ5WLDCZETgdtqkt/56c4dQi8csq/afpLqEDBAbTpeaa
         pPt3ozKZ29t68WXFSBP+hKDlXcRvj43pn7D415aCTWhsLYCCXsxIaIvExDcIXJgN/GuJ
         m3UHs3S+afZH5gRGZvHnxIuKGrSL2KGxINV7l+50azQcle+bTFdEoxhrW+ro98UWbPJs
         C5buwed2r1vx7lrtBuX7229XWMCRKbq12EM+9pRsQ77tppbYnMzu21ymwioBtqtkR0gr
         cmIA==
X-Gm-Message-State: ANhLgQ0VNVlZVwWehdRYRmE4Ow33oMGgGWcetINdjVhflK/SMTASBAwQ
        zx6O1dHmc1+B7j3o/nthfZOCKQ==
X-Google-Smtp-Source: ADFU+vvd/eW3aTdeEeKxJ41UggrDLe0JEKpyxMRRA6t3sd7Tg+UrUkZjjkPf/qY1D6Ew2SYTwj3lUQ==
X-Received: by 2002:a63:ba05:: with SMTP id k5mr974707pgf.174.1584476364210;
        Tue, 17 Mar 2020 13:19:24 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x4sm3398950pgi.76.2020.03.17.13.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:19:23 -0700 (PDT)
Message-ID: <5e7130cb.1c69fb81.64692.b31d@mx.google.com>
Date:   Tue, 17 Mar 2020 13:19:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-99-g4a13723c325c
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 62 runs,
 0 regressions (v5.6-rc6-99-g4a13723c325c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 62 runs, 0 regressions (v5.6-rc6-99-g4a13723c325c)

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

48  | rk3399-puma-haikou           | arm64  | lab-theobroma-systems | gcc-8=
    | defconfig          | 5/5    =

49  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

50  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

51  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

52  | sun50i-h6-pine-h64           | arm64  | lab-collabora         | gcc-8=
    | defconfig          | 5/5    =

53  | sun50i-h6-pine-h64-model-b   | arm64  | lab-baylibre          | gcc-8=
    | defconfig          | 5/5    =

54  | sun5i-a13-olinuxino-micro    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

55  | sun7i-a20-cubieboard2        | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

56  | sun7i-a20-olinuxino-lime2    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

57  | sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

58  | sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

59  | sun8i-h2-plus-orangepi-zero  | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

60  | sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

61  | tegra124-jetson-tk1          | arm    | lab-baylibre          | gcc-8=
    | multi_v7_defconfig | 5/5    =

62  | tegra124-jetson-tk1          | arm    | lab-collabora         | gcc-8=
    | multi_v7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc6-99-g4a13723c325c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4a13723c325ce2b444bec3aa5836854cc1f48390 =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
html
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
html
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * alert:
        never passed
        1 lines    =

                                                                           =
                                                                           =
                    =20
