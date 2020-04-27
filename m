Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842871BA1EC
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 13:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgD0LHJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 07:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbgD0LHI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 07:07:08 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819C2C0610D5
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 04:07:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z6so6865812plk.10
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Abz1TwoWWO5G49ybTIpc3i/cn1bMwv6lIWBxCKtL/wY=;
        b=aPpp5DhOmiprz0aIu5yggmR5bK2k0EYETplSskSkX/fdYQXi1Eip81gCsyvr/21sMf
         /1az18bdBl2NSXdrmtuWOOD+Lqg8zWS/xLCoqM7ihaYpDKXC+m4YHprfgsCL8HSh9tnM
         MJEsUXgACw+VvW7YMMxu0/vH9ZS1tjlZko41XBFT8Kj9YzavvAx26lWK9QofRcVQ+yug
         HhMf1fFyVYwSMkr5KOwx5QHm7Kcm2Uv9I5U4LXuRj/SuiEyCAmasvogAplNxmCjpW8lI
         eSmJTmwTRdo95FNjP1O/69BahN6a+To6oJm/K/TXj7spqjUEHoUO9sbpM44K3IqIGLOB
         GRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Abz1TwoWWO5G49ybTIpc3i/cn1bMwv6lIWBxCKtL/wY=;
        b=W5t/I5eWgsSuVvN6VGy15k/N7rnQ18d/Z+05nJiplHnUMib399NPR+XpfgCoNVK9Jx
         XgBNOTLd5NefW0XLa4R8LvHB4EJGEs3Dx6sEL22cOeW4hqJYEv84DBkdH9a8Hd/RzAh2
         71W9v+Sv1QByLDT3yQYM70pq9gSkUjNy5r3QBr6iUsEAwIPHhb26OluGA5Ll59XQBOdq
         xx/zjAWtP8LQRyFBaeK8rxQJR06Y7hXMsantuIR+uuCYwVlCxE0W+D+JqsSzFcWbGQ3U
         yHtEJ7sVbuxbMWM/FQP9d1/H9apWE5QqqbZ5jBAn61sOwvVlnYbOpGYU273zf9aOAqq3
         v2rg==
X-Gm-Message-State: AGi0PubeAP0gXUcQoWK6Hy2/xqHRFFTik0YDL+xVhjrKR9+GvZtc3uTC
        UZXs2AvfLzrVJ8a/7uk3pT4LS1YF3Lk=
X-Google-Smtp-Source: APiQypI3XthiAc3i2igZw5kKe9LnJH4ibMFYOeeA+oa6d9459IgifYCYpCPI8B4SupoJc+xHLLb5Pw==
X-Received: by 2002:a17:902:7286:: with SMTP id d6mr23435137pll.241.1587985627972;
        Mon, 27 Apr 2020 04:07:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a22sm12236017pfg.169.2020.04.27.04.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 04:07:07 -0700 (PDT)
Message-ID: <5ea6bcdb.1c69fb81.e193.1b02@mx.google.com>
Date:   Mon, 27 Apr 2020 04:07:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc3-21-gd38f9bc9261a
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 61 runs,
 1 regressions (v5.7-rc3-21-gd38f9bc9261a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 61 runs, 1 regressions (v5.7-rc3-21-gd38f9bc9261a)

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
multi_v7_defconfig | 4/4    =

8   | exynos5422-odroidxu3         | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

9   | hifive-unleashed-a00         | riscv  | lab-baylibre    | gcc-8    | =
defconfig          | 1/1    =

10  | hip07-d05                    | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 3/5    =

11  | imx6dl-riotboard             | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

12  | imx6q-sabrelite              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

13  | imx6q-sabrelite              | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

14  | imx6q-var-dt6customboard     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

15  | imx6ul-pico-hobbit           | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

16  | imx8mn-ddr4-evk              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

17  | meson-g12a-sei510            | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

18  | meson-g12a-u200              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

19  | meson-g12a-x96-max           | arm64  | lab-baylibre    | gcc-8    | =
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

36  | qemu_arm-virt-gicv3          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

37  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

38  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

39  | qemu_x86_64                  | x86_64 | lab-baylibre    | gcc-8    | =
x86_64_defconfig   | 5/5    =

40  | rk3288-rock2-square          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

41  | rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 68/68  =

42  | rk3328-rock64                | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

43  | rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 85/88  =

44  | stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

45  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

46  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 0/1    =

47  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

48  | sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

49  | sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 5/5    =

50  | sun5i-a13-olinuxino-micro    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

51  | sun7i-a20-cubieboard2        | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

52  | sun7i-a20-cubietruck         | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

53  | sun7i-a20-olinuxino-lime2    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

54  | sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

55  | sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

56  | sun8i-h2-plus-orangepi-zero  | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

57  | sun8i-h3-bananapi-m2-plus    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

58  | sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

59  | tegra124-jetson-tk1          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

60  | tegra124-jetson-tk1          | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =

61  | tegra124-nyan-big            | arm    | lab-collabora   | gcc-8    | =
multi_v7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc3-21-gd38f9bc9261a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d38f9bc9261a2b20e8509370b5df9bdb3badaf81 =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
html
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
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
10  | hip07-d05                    | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 3/5    =


  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
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
43  | rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-8    | =
defconfig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/arm64/baseline/rootfs.cpio.gz     =


  bootrr - 84 tests: 81  PASS, 3 FAIL, 0 SKIP
    * cros-ec-sensors-accel0-probed:
        never passed
    * cros-ec-sensors-accel1-probed:
        never passed
    * cros-ec-sensors-gyro0-probed:
        never passed    =

            =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
46  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-21-gd38f9b=
c9261a/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/arm64/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: acpi-5.7-rc3-250-g177af5b82ac5)   =

                                                  =20
