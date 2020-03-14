Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46259185969
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 03:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgCOCvu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Mar 2020 22:51:50 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38105 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgCOCvu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Mar 2020 22:51:50 -0400
Received: by mail-il1-f195.google.com with SMTP id f5so13104749ilq.5
        for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2020 19:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QFUIjJJek3nJGv7R/qGTOxaHZPIrcjhkAl11fYO5NUg=;
        b=mutLbyV9PU6xPbMmnAtXSc49kHppbiMP0XXjBrFKtSStqhWNjmsrnXUffgM0KLMzNq
         QxWMYg3HG7AMntFe1BET36ogPjChELmyPInYagpadZ5jCKFOBt5a/QjZLWbwIfSTu31n
         Bgz1AvTermAt35KMcFoWMdNU9J2HrBhkdPtBfJeiuxFV0Townw3q0yVsz6Pb9H5i87+R
         6sqq4tIcLGqQABcW+X0VDDBOzquYeVlf7UzswNTMoPNxqmQ+8uBhC4zb1bySk4uSNBTf
         gVvCXXa/7n33G0Q3WTIPaMIAgXjM6PxXXshDZvjGPCaQFR/MnzUPGHDhVb241EVD1GFo
         pp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QFUIjJJek3nJGv7R/qGTOxaHZPIrcjhkAl11fYO5NUg=;
        b=tYmyhBbNfflATHOCcxVohJnGxYZkMZvYETRqL+X7aQbz4/IGjxnFqC3xVZJHuB60WD
         bcr+wy9/vMA0EQcaFD5qA1YhtJ38V1nW4r6UtwC9qAcyoqetnV8ulDCo9RUtmNzIq9N4
         9whhsblyKy/J/E2G19I6tjYogmihpB4AwMZsROd2xiNVZpLkkMGokDBKd5udg1prljVO
         xxSmOQ0SjaRWYfKXmcNFqbjifusJ8Mdx9DkYh0yKYis5zAJIivKEMG1lOaVQKa7O3B+P
         DDTkUxiJ37hb+N3Un2yRmPndUFRlAWIB/yaX4ISgqAp9ljMtCb2U6AkmeNWzYhq9UXiK
         fuVw==
X-Gm-Message-State: ANhLgQ3OUflc8Sseh4z9D2nOFQQ4jZP2NYB5b3UvUHEkg+RjIfThFRMi
        iRJqclDL8obvHHf3wAEnuN73P5C3vCM=
X-Google-Smtp-Source: ADFU+vsWjSq8HU9Nq5//hJ+6yC3FF6TMzyTc9E/9uVNJvSQ+/pOxaO8TLXx1NdBb2vbRbdJJfiXUsw==
X-Received: by 2002:a63:af58:: with SMTP id s24mr19558284pgo.15.1584216342884;
        Sat, 14 Mar 2020 13:05:42 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i21sm15833551pgn.5.2020.03.14.13.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 13:05:42 -0700 (PDT)
Message-ID: <5e6d3916.1c69fb81.1d8f6.3e3e@mx.google.com>
Date:   Sat, 14 Mar 2020 13:05:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-5.6-rc6-81-g0b0cbef30e18
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs, 3 regressions (pm-5.6-rc6-81-g0b0cbef30e18)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 3 regressions (pm-5.6-rc6-81-g0b0cbef30e18)

Test results summary
--------------------

run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =

2   | exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

5   | rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

6   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 8/12   =

7   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.6-rc6-81-g0b0cbef30e18
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      0b0cbef30e1812bc567874888a4e71eb777fc51b =



Test Failures
-------------
  =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.6-rc6-81-g0b0c=
bef30e18/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.6-rc6-81-g0b0c=
bef30e18/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

         =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.6-rc6-81-g0b0c=
bef30e18/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.6-rc6-81-g0b0c=
bef30e18/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/armhf/rootfs.cpio.gz  =


  21 tests: 1 PASS, 20 FAIL, 0 SKIP
    * rtcwake-mem-1:
        never passed
    * rtcwake-mem-2:
        never passed
    * rtcwake-mem-3:
        never passed
    * rtcwake-mem-4:
        never passed
    * rtcwake-mem-5:
        never passed
    * rtcwake-mem-6:
        never passed
    * rtcwake-mem-7:
        never passed
    * rtcwake-mem-8:
        never passed
    * rtcwake-mem-9:
        never passed
    * rtcwake-mem-10:
        never passed
    * rtcwake-freeze-1:
        never passed
    * rtcwake-freeze-2:
        never passed
    * rtcwake-freeze-3:
        never passed
    * rtcwake-freeze-4:
        never passed
    * rtcwake-freeze-5:
        never passed
    * rtcwake-freeze-6:
        never passed
    * rtcwake-freeze-7:
        never passed
    * rtcwake-freeze-8:
        never passed
    * rtcwake-freeze-9:
        never passed
    * rtcwake-freeze-10:
        never passed   =

      =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.6-rc6-81-g0b0c=
bef30e18/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squa=
re.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.6-rc6-81-g0b0c=
bef30e18/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squa=
re.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/armhf/rootfs.cpio.gz  =


  21 tests: 1 PASS, 20 FAIL, 0 SKIP
    * rtcwake-mem-1:
        never passed
    * rtcwake-mem-2:
        never passed
    * rtcwake-mem-3:
        never passed
    * rtcwake-mem-4:
        never passed
    * rtcwake-mem-5:
        never passed
    * rtcwake-mem-6:
        never passed
    * rtcwake-mem-7:
        never passed
    * rtcwake-mem-8:
        never passed
    * rtcwake-mem-9:
        never passed
    * rtcwake-mem-10:
        never passed
    * rtcwake-freeze-1:
        never passed
    * rtcwake-freeze-2:
        never passed
    * rtcwake-freeze-3:
        never passed
    * rtcwake-freeze-4:
        never passed
    * rtcwake-freeze-5:
        never passed
    * rtcwake-freeze-6:
        never passed
    * rtcwake-freeze-7:
        never passed
    * rtcwake-freeze-8:
        never passed
    * rtcwake-freeze-9:
        never passed
    * rtcwake-freeze-10:
        never passed   =

         =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
6   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 8/12   =


  Results:     8 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.6-rc6-81-g0b0c=
bef30e18/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.6-rc6-81-g0b0c=
bef30e18/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/arm64/rootfs.cpio.gz  =


  12 tests: 8 PASS, 4 FAIL, 0 SKIP
    * rtcwake-mem-8:
        new failure (last pass: v5.6-rc4-78-ge63a6b3d7d38)
    * rtcwake-mem-9:
        new failure (last pass: v5.6-rc4-78-ge63a6b3d7d38)
    * rtcwake-mem-10:
        new failure (last pass: v5.6-rc4-78-ge63a6b3d7d38)
    * rtcwake-freeze-1:
        never passed   =

        =20
