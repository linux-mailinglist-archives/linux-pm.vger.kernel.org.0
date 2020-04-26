Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB061B930C
	for <lists+linux-pm@lfdr.de>; Sun, 26 Apr 2020 20:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgDZSkr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Apr 2020 14:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726156AbgDZSkr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2020 14:40:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D834FC061A0F
        for <linux-pm@vger.kernel.org>; Sun, 26 Apr 2020 11:40:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g6so7508827pgs.9
        for <linux-pm@vger.kernel.org>; Sun, 26 Apr 2020 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WMjgZrgg4vlHtFvAvejIvWXgivKjNavVGwz0Yi/umns=;
        b=UIx3oG7jHNf/7XZjQ33CkX7FZ6Zf9Wf7l8w8byjPk+PoDow/mHdBlb2Gi+iY4ArVLA
         TVZvlqiWJmAiY+NmhLPaXK/LdjkpZzB/drrSYQrbBV/NNyRbMVW4bZkys4EzbmqnkPK0
         KiYP0xQO5IREwN4urY7a6hZM4L6/Hu3A8Q13o2zpRiAl4t3PhJvLQoo1A8nCbZcLcrDI
         HStK9B4KTdX45VunEzz+HTVCcbT0SGysZqoIAN2mOZEtroOjDLmxze8w1vrpR7vto9FP
         ALMKTWOjsdpckaUtYeecZZhFHgi2XjlNoPsQ3EEZ8bUuBevhM1cHh8nu6piEEkq/TO+K
         9skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WMjgZrgg4vlHtFvAvejIvWXgivKjNavVGwz0Yi/umns=;
        b=HHmRCwxOy7CPkE6VSwe0sZ6vbbQF/KeaMhXU/Ja94xhAl68bFqgoj5ykKgFgmAgCLK
         3k7qwyT0FyOGoeg04cyozZ+tDQ9ij1dlh18ABhCNH5Dzg25AKr4YQbJZJ+dTaEbDHzvc
         WQqu5FgHdXhmVnKcq5Qa+6Vt62j5Z7/ugTzuRh+apyEeIS/JlSRy1v+SQSKjAcHTl6Gg
         bAYaV7ut/Lao6eAlHaL+zKNm9Ebj1XS6COw99wmDZHb5iTp7UnJgXud+SiplgahtsvPa
         OvuEmW9s8hevMDkVsDDlVeCuS5xEodq2AAKqp5XUy831U2NysgsHt8nyTHTjcxgVMqhP
         x2SQ==
X-Gm-Message-State: AGi0PuY7nroZwtbqQ/6BPu0lLn50N8Krgw1FDORbeYepSP2QQcfNFRgd
        1mJbdaLD0ZbfateobXgU5/G1iDNlGC0=
X-Google-Smtp-Source: APiQypIAaV4LSE1oOVfqHwQp4oup93uagzNLr4lFQ6Ao45D9I8UPn5o81BG95IH/0U6pBzAXu49m5g==
X-Received: by 2002:a63:da10:: with SMTP id c16mr19608661pgh.208.1587926445286;
        Sun, 26 Apr 2020 11:40:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y21sm8906594pfn.148.2020.04.26.11.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 11:40:44 -0700 (PDT)
Message-ID: <5ea5d5ac.1c69fb81.f93b0.0294@mx.google.com>
Date:   Sun, 26 Apr 2020 11:40:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: acpi-5.7-rc3-250-g177af5b82ac5
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 47 runs,
 1 regressions (acpi-5.7-rc3-250-g177af5b82ac5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 47 runs, 1 regressions (acpi-5.7-rc3-250-g177af5b82ac5)

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

6   | hifive-unleashed-a00         | riscv  | lab-baylibre    | gcc-8    | =
defconfig          | 1/1    =

7   | imx6dl-riotboard             | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

8   | imx6q-sabrelite              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

9   | imx6q-var-dt6customboard     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

10  | imx6ul-pico-hobbit           | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

11  | imx8mn-ddr4-evk              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

12  | meson-g12a-u200              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

13  | meson-g12a-x96-max           | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

14  | meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

15  | meson-g12b-odroid-n2         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

16  | meson-gxbb-p200              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

17  | meson-gxl-s805x-libretech-ac | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

18  | meson-gxl-s905d-p230         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

19  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

20  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

21  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

22  | meson-gxm-q200               | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 0/1    =

23  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

24  | meson-sm1-sei610             | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

25  | meson8b-odroidc1             | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

26  | omap3-beagle-xm              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

27  | omap4-panda                  | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

28  | qemu_arm-virt-gicv2          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

29  | qemu_arm-virt-gicv3          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

30  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

31  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

32  | qemu_x86_64                  | x86_64 | lab-baylibre    | gcc-8    | =
x86_64_defconfig   | 5/5    =

33  | rk3328-rock64                | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

34  | stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

35  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

36  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

37  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

38  | sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

39  | sun5i-a13-olinuxino-micro    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

40  | sun7i-a20-cubieboard2        | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

41  | sun7i-a20-cubietruck         | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 4/4    =

42  | sun7i-a20-olinuxino-lime2    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

43  | sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

44  | sun8i-h2-plus-orangepi-zero  | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

45  | sun8i-h3-bananapi-m2-plus    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

46  | sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

47  | tegra124-jetson-tk1          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.7-rc3-250-g177af5b82ac5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      177af5b82ac567bebb27ee08d4fe5556d6fd4e8c =



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
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.7-rc3-250-g1=
77af5b82ac5/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneb=
lack.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.7-rc3-250-g1=
77af5b82ac5/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneb=
lack.html
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
22  | meson-gxm-q200               | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.7-rc3-250-g1=
77af5b82ac5/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.7-rc3-250-g1=
77af5b82ac5/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/arm64/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: pnp-5.7-rc3-19-gcd227cc5ff82)   =

                                                                           =
     =20
