Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70A319886C
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 01:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgC3XkK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 19:40:10 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:40801 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3XkJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 19:40:09 -0400
Received: by mail-pj1-f41.google.com with SMTP id kx8so287702pjb.5
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2020 16:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=01pn2Qff1NiMzlerMxTMEL/zSNnMVIfeVtck760cbKw=;
        b=JV4brJYcuonoBX9cGXlqIZ8+LGfVdRggZTkmdkQIg+TrsHUJMHru8R0CcNOM8QWQ0p
         fPjlx5D3PTcE2iWOTpwnD4bVoD9FVIEPZAWGlTLLdADO1zQrThCsgVeQLcvgQJVlRF4T
         DmqmNEaFOXjxhsH8j80VL2rG1OZTSYQhTabzGWX9I0j8qJRrj+xDPoK2gt8l/iu7b4sW
         2JGXSJhVi7oQ/2pDEGuV6d7rekqBbfkO2OxW4JsvhVMH5vm9dMO7oK20YCjvjp4pZNAh
         Rj0ZieoRG0xPByzpnwFtOwQTd6uZ3QBbshJD9xDPRuPUVukbBxX3ys3zNW8btN66lWzu
         gfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=01pn2Qff1NiMzlerMxTMEL/zSNnMVIfeVtck760cbKw=;
        b=iDrpvAqgZ1uVye6X7DaDMWgGYmE4aVn1ZoIp8wMu4yY35KUrTjn4M4yDjC9EKRnX9S
         7bSOTmaRwF7jr3MvAJjtq18quTFs6ouL1U/lLbbVCHOxJxoA67mnIk0ul1nvN6Avs5w0
         iJ46yia/dth4Ny4cq80I4+cI4bPSa2sYq85tVVBnWKCwl1ECtxAvt7IML8PgtFEqNGzA
         qDNJLwXGn2Yy0BLXpqLXoUY/V95WN/Dn8laqEmb5+BzMDQwycTxoww6c9YE/WsbWP/os
         H/LtI9c2ngcMJX/MkFI58D7nW23zm0sVfLI4VikgEoXfb9c8KzuZvfr5jl+zSGs+JLB8
         wRDg==
X-Gm-Message-State: ANhLgQ111w2ECNCMYKNW6U2IWf8tw5tUWMx0+g4t0+6xhqlGkIAJwPfS
        fKnLHONNjMj5DhrTji1RzTd6losoJAc=
X-Google-Smtp-Source: ADFU+vtUD+m3b4kgBMaByW70sY/iQ1L3rZcrqBEktViGyFUoe8+NludCW680LcpSUXysMn2KN1UXEw==
X-Received: by 2002:a17:902:9a86:: with SMTP id w6mr14752139plp.37.1585611608847;
        Mon, 30 Mar 2020 16:40:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d188sm10837162pfa.7.2020.03.30.16.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:40:08 -0700 (PDT)
Message-ID: <5e828358.1c69fb81.d68fb.2553@mx.google.com>
Date:   Mon, 30 Mar 2020 16:40:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-141-g61fafa3ac67b
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 8 runs, 0 regressions (v5.6-141-g61fafa3ac67b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 8 runs, 0 regressions (v5.6-141-g61fafa3ac67b)

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

3   | exynos5800-peach-pi  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/1    =

4   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

5   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

6   | rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 20/20  =

7   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 11/11  =

8   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.6-141-g61fafa3ac67b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      61fafa3ac67beab5d2e0bf439da2523bd035cb0e =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-141-g61fafa3ac=
67b/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-141-g61fafa3ac=
67b/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0325.0/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

            =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
4   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-141-g61fafa3ac=
67b/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-141-g61fafa3ac=
67b/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0325.0/armhf/rootfs.cpio.gz  =


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
5   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-141-g61fafa3ac=
67b/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-141-g61fafa3ac=
67b/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0325.0/armhf/rootfs.cpio.gz  =


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
