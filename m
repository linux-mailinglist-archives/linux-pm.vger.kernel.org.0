Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A45418B2EA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 13:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCSMEt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 08:04:49 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:44995 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgCSMEt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 08:04:49 -0400
Received: by mail-pg1-f171.google.com with SMTP id 37so1146254pgm.11
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 05:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xxU8jm0rF7L7Z+qofytk4ZaK3hPQeg7ybUFlAnHiWXo=;
        b=1FiSSnb4vF/5u23tW+mHU0N9bQNOaGHDY8wA2gLYhb9MDYH0SoznYZ8bAHQ74pmbbf
         gSE9UfUUIuGjF/uezF5aOhooi0Dpx+wJmnSESIWRcP5PFTa0WRDF1Ss2o9CKY3wWN0jo
         0oGZAzemdWicknJM4Ta6zWHZwGsQ/1yfnjp/KAjJ3ESnYzqR8YO9We3zNPcwlSzjbzDX
         v4TpDTkcI2iMElgJmIo+QCsJE4f3KQcuytzdHAV4x57ltIZgnV422GUDQX22TwxlrmjL
         IOMMVOlLtqPFjaDxTjwBtlgbYWjnZt7hA9RRlh2sJIyXqP9WtjoqnmgOQ7ZV165aL6RR
         JHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xxU8jm0rF7L7Z+qofytk4ZaK3hPQeg7ybUFlAnHiWXo=;
        b=eh7MEUJRRu6BSsqkOIhDqal4vd7s1aLmKTQOnpKwWV1fb8qb84OSQizI1pW5WDpgaH
         jsf+AhblL7ITG03DNmkxdXpgeq+45bJ+mb41elXFUTISt2EYml+LtNInAhyM9Jg9Tlda
         ozrDAnnlZpIwZ72zQAEZtmU+RX5/hOgba27V2f+sFGd+OUk92FK+osr4EFP5Boyuyuya
         94otTHOp8fHKBl6uf7QYck4N+KCCkiZD5l65bB3g3LSWPsSC2zZDZJzMuFEkcGiO39n1
         LtAlrxQJjFrnkn0YRdRKpblQxQm0sG00dFukX2h8+UbGT7BjjOyYTwVNvzPhwX4uknvC
         VBVw==
X-Gm-Message-State: ANhLgQ1W/Q5aHvHNUumfax35wP2sdkQ0BFW4SLSRsijH/U89m45ASta0
        rqA0B3TTdM0dWJYKlPipSav6hA==
X-Google-Smtp-Source: ADFU+vveuNnyX1+ZgfALTIWxgIb7iO8I8mrneZVFxbQo7e7xjAC8eXk9dssEBU0gRgMTQAfkkoN+Rg==
X-Received: by 2002:a62:868a:: with SMTP id x132mr3447063pfd.208.1584619488405;
        Thu, 19 Mar 2020 05:04:48 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k2sm2249635pgj.16.2020.03.19.05.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 05:04:47 -0700 (PDT)
Message-ID: <5e735fdf.1c69fb81.34c6.910b@mx.google.com>
Date:   Thu, 19 Mar 2020 05:04:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-100-g37da629c357d
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs, 0 regressions (v5.6-rc6-100-g37da629c357d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 0 regressions (v5.6-rc6-100-g37da629c357d)

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
        | 11/11  =

7   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc6-100-g37da629c357d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      37da629c357d0ce08072f1532fae2091e467ae42 =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.ht=
ml
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.ht=
ml
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-100-g37da6=
29c357d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.html
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

              =20
