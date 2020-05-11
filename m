Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20D91CE2C4
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 20:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgEKS3c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 14:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729673AbgEKS3c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 14:29:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C24C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 11:29:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r14so5125041pfg.2
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=77623GnrT0bPuYY9v83MvEUhBDw+UUbq+4IxDw+6cLI=;
        b=WyXnDBF4OEdG92yHCnoWmq8GB0Ffw/a3Ek8ZERSFhqHTxTFOw7xK8dDaMVOQFlnuTF
         fWAQ1vmRqb3feh85OO8qgOi7O1zM37abuFhDFRb61hOjTEklUwvyIumDmHICsEScZ8j6
         3cetqecbIKwLNo8s88LiOOxBTuPpggnOQXESS9EIs7ZT55MJpbnvcz8k1won7kYhwbs+
         7xqpln4VMxg3Kkou08rLsL40orrVkW6MfDLhvcNx2HfnxbQxoV0XtdbY3b4fX9OcXj53
         VnL7wsrY4aRFBZAgyfWb2tLYgxHNtIb+7B7F0wSfSEKHZcbCQkEJ1PP1ywifhT7foARw
         +UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=77623GnrT0bPuYY9v83MvEUhBDw+UUbq+4IxDw+6cLI=;
        b=NC3VUZBb03Wx6Lcx31pXspLDt9n2mTmn9EY9tamWclBkLDpi5cZ4pB/O1WHV8tNHKj
         5MnZi2+7CA1JqM7Bp6Ey9GM/kha8SQ64ZdZpmkhIq6Gax8Mx5i2MmdvFCnvU8GbyZweK
         KqDGQQLHNCiZLvaCe8iMNi5Wtnkl55CsQz1rTRcZQ1/M7zyqHcz0QBDQBUqNZfQgKByH
         l9RBh4vVxGOq7+oQdWHBC4vU+0f38fp08rNRSOjeb8qiptLnCtBXWALlQrTToNiNvYYY
         0PTMI0kkXvbPifU9mTVzv4rXUXPk3ANRJHtr6RZsh8zRJ57QG2HVoFKt8qbd0q/8+f8M
         MgKA==
X-Gm-Message-State: AGi0PuYFzBR7Hae35qy1HUE5HAI1RgyLgnhTCat1sJKumKEJoDNpBeo/
        xBzAWeCNZ6eKudlkd8UA6i+/3A==
X-Google-Smtp-Source: APiQypKQxgcHm18o5gBf+gR2rNVJntTQPOLmZdiHs8EEWiykmT233rQFYz/zommSSYS05PX7Z/6yRg==
X-Received: by 2002:a63:6f4c:: with SMTP id k73mr15557646pgc.241.1589221771380;
        Mon, 11 May 2020 11:29:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e10sm9738638pfl.195.2020.05.11.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:29:30 -0700 (PDT)
Message-ID: <5eb9998a.1c69fb81.827a6.38d0@mx.google.com>
Date:   Mon, 11 May 2020 11:29:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc5-43-gb68266410b45
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 49 runs,
 3 regressions (v5.7-rc5-43-gb68266410b45)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 49 runs, 3 regressions (v5.7-rc5-43-gb68266410b45)

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

7   | imx53-qsrb                   | arm    | lab-pengutronix | gcc-8    | =
multi_v7_defconfig | 5/5    =

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

13  | meson-g12a-sei510            | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 0/1    =

14  | meson-g12a-u200              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

15  | meson-g12a-x96-max           | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

16  | meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

17  | meson-g12b-odroid-n2         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

18  | meson-gxbb-p200              | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

19  | meson-gxl-s805x-libretech-ac | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

20  | meson-gxl-s905d-p230         | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

21  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

22  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

23  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

24  | meson-gxm-q200               | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

25  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

26  | meson-sm1-sei610             | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

27  | meson8b-odroidc1             | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

28  | omap3-beagle-xm              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

29  | omap4-panda                  | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

30  | qemu_arm-virt-gicv2          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

31  | qemu_arm-virt-gicv3          | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

32  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

33  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

34  | qemu_x86_64                  | x86_64 | lab-baylibre    | gcc-8    | =
x86_64_defconfig   | 0/1    =

35  | rk3328-rock64                | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

36  | stm32mp157c-dk2              | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

37  | sun4i-a10-olinuxino-lime     | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

38  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 0/1    =

39  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

40  | sun50i-h6-pine-h64-model-b   | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 5/5    =

41  | sun5i-a13-olinuxino-micro    | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

42  | sun7i-a20-cubieboard2        | arm    | lab-baylibre    | gcc-8    | =
multi_v7_defconfig | 5/5    =

43  | sun7i-a20-cubietruck         | arm    | lab-baylibre    | gcc-8    | =
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



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc5-43-gb68266410b45
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      b68266410b45608f9ac68f17acd76bf64c209d21 =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-43-gb68266=
410b45/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-43-gb68266=
410b45/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-am335x-boneblack.=
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
13  | meson-g12a-sei510            | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-43-gb68266=
410b45/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-g12a-sei510.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-43-gb68266=
410b45/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-g12a-sei510.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: v5.7-rc4-41-g277a1722e66d)   =

                                                                  =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
34  | qemu_x86_64                  | x86_64 | lab-baylibre    | gcc-8    | =
x86_64_defconfig   | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-43-gb68266=
410b45/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-43-gb68266=
410b45/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/x86/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: v5.7-rc4-41-g277a1722e66d)   =

               =


run | platform                     | arch   | lab             | compiler | =
defconfig          | results
----+------------------------------+--------+-----------------+----------+-=
-------------------+--------
38  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-8    | =
defconfig          | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-43-gb68266=
410b45/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-43-gb68266=
410b45/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: v5.7-rc4-41-g277a1722e66d)   =

                                      =20
