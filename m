Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06C4188F07
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 21:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCQUec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 16:34:32 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:39885 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQUeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 16:34:31 -0400
Received: by mail-pf1-f169.google.com with SMTP id d25so4571771pfn.6
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2020 13:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rcCSWHKfxYWUzdrWn3dZDAh8ycFUW3xAl48AcgOePGM=;
        b=NKQVLEAA9LY+4nXlv7PbAJp01ZoUxnjD9qCy5K6mjTMakKf4cAHFpP51wagCn8XgQ/
         QPrba9sChrKC/hArcQKjOZ8j4W+7rKXTTZ7DhIfj0oQC0bLAgeeGsIzOz4WjYKjcjKWW
         2zfY6Z5P+vSQOaWdRDfKABGli+lcmegEHYSJH6MJ6RmKw5JW72S55Km7j9zFAntl296m
         LGq7RQhiMp5PfdwFVjj5oXbl01UPTZZkwR4tUuXjP5ORhasLSwuDawy7YDJiSW5YqnSa
         TAZN5oAOhe9T4xpINTUM5xXC2cli7yxb66D5X9sddwevRCbanH8PQqPS7BiLIvqIdBAR
         vZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rcCSWHKfxYWUzdrWn3dZDAh8ycFUW3xAl48AcgOePGM=;
        b=UDNkR2XW9bKqPaPAjwriSJ2aoU3eQ1baSakjwRH3nJdxO8zCCd9rNjwZlvIUGQ+2f6
         JUU2KDD5x1SRk95g+6XsBuqwD1lDuIJBF36Wtz+o0QaDbifL7aXarw3IbpHuakMbsdCY
         mYr6GtA7Ds/n7qqKUdHeK+zI7nzn4QNj483KwL96G6JsJp/Do1o1muxsyrV6ia3xAk6i
         GTYt9MuMq+GfrntXR5LDHy7MCdcJxcFR989yHRAolk9Sk9eG6+iXmSFfYYL4GsfloxBl
         TsW0isqxvkM2LICc3CCXljfMFvbvJDxRZZfuefm1CbqP7jN6LIw8t78eAnqB6uAjqSpr
         0YvQ==
X-Gm-Message-State: ANhLgQ2PXugWmz7X4gsSSvt+ZKSKoHgGi2eSificAld7M4BbjpaAhfhr
        3li+pfmS6RBjdkdl4RLnP2KsjA==
X-Google-Smtp-Source: ADFU+vv+yrG+INmng4YzKX4D9+b03ibv+9xaMXg7kP1Az8+wbMbg1OIBqbmKuyQqhIDGZiDYNl8jbA==
X-Received: by 2002:a62:1cf:: with SMTP id 198mr614645pfb.246.1584477267194;
        Tue, 17 Mar 2020 13:34:27 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v29sm3691633pgc.72.2020.03.17.13.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:34:26 -0700 (PDT)
Message-ID: <5e713452.1c69fb81.bc494.bd6f@mx.google.com>
Date:   Tue, 17 Mar 2020 13:34:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-99-g4a13723c325c
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 6 runs, 1 regressions (v5.6-rc6-99-g4a13723c325c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 1 regressions (v5.6-rc6-99-g4a13723c325c)

Test results summary
--------------------

run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
1   | bcm2836-rpi-2-b      | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 0/1    =

2   | exynos5422-odroidxu3 | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 0/1    =

3   | imx6q-sabrelite      | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 1/21   =

4   | rk3288-rock2-square  | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 1/21   =

5   | rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 21/21  =

6   | tegra124-nyan-big    | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc6-99-g4a13723c325c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4a13723c325ce2b444bec3aa5836854cc1f48390 =



Test Failures
-------------
  =


run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
1   | bcm2836-rpi-2-b      | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

      =


run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
2   | exynos5422-odroidxu3 | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu=
3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu=
3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: v5.6-rc6-99-g90f425b95754)   =

      =


run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
3   | imx6q-sabrelite      | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.html
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


run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
4   | rk3288-rock2-square  | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g4a1372=
3c325c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.html
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
