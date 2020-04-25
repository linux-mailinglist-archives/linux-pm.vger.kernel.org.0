Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DBC1B83C6
	for <lists+linux-pm@lfdr.de>; Sat, 25 Apr 2020 06:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgDYEk5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Apr 2020 00:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbgDYEk5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Apr 2020 00:40:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42525C09B049
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 21:40:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a32so4744334pje.5
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 21:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=wtEtC7Zl7iKfSkQifw3hShat/KPv6T4GkZHjA5uVCqw=;
        b=fYXHxwikclAlBWCfj4VxR9uQIGVhDSE/G/F3xUrF4yVwfNW4SMFU48hfKsLQ0vgtGn
         Tbl2bad0n5azzxVHIJTSFjBzJA+K8zkhk5ngwcLniiWHaUtAxeJ2ki0TAg3t7G8HlQb0
         BSRZydIJ9LTcI1dSunoBujLl06i28XeU34Oa9V8qIn+WMIkyOxqicEuCtqJfkVJFaHdl
         Ouyvd1taTo9dpWpOEYqoh6fDlmzwiUHgCxR4nxQhLeN7FdM9W3c4Ca893A7naT757DEL
         iVQj2Bw4eAJ6U5Yql6IYs2fj1p4RC81esqTeFeeQ0JSks9SgNwpZmpN6GyFB4l9fcyUA
         A9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=wtEtC7Zl7iKfSkQifw3hShat/KPv6T4GkZHjA5uVCqw=;
        b=HFA1meAiZDgJf01RTU+bErVOTwfFzHVMF0ISXT9i5rV5P87r0FmLGmXGce/d8FtnSw
         cU4opdQKX+QgSRQqqcAkV0nOsRvDrIcic+p/g/aNhUVWDWa0Kki+40s/X3S02zj8SH90
         uh71FiNtFlPPfrRFFTTlFxg/kP1e+SxTnRSjz59kvUtT7lH601F46Fhbnb564ieGwelv
         zVhfoxcCs2IjNnd0/8nDYTrEJIxE0Unk6pX7WSDTdlGk3sA8Z1MXntEiWD3iboQYQZvn
         iZaxdsn5C+T7PzDgGpRMlzv1TpAZ/xV2f9hrWsSaA/0vv2Ho53KFva4yKZX3lqPAH671
         Vl+w==
X-Gm-Message-State: AGi0PuafVORYMQWo6JSb2TnV5RCsY+ivTBNhvuLiiqS1hUkjXOG0H1R6
        4QpxgU63EH5C0kES50vyf1fbRg==
X-Google-Smtp-Source: APiQypLSwsWxKFEtfFUFxAw7eeFHFSNVQJZXUuYxdfev/dCkg69SQ38BW9ViYEHtPPWzkh+NgA3fsQ==
X-Received: by 2002:a17:90a:315:: with SMTP id 21mr9572493pje.96.1587789655548;
        Fri, 24 Apr 2020 21:40:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y186sm7086484pfy.66.2020.04.24.21.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 21:40:54 -0700 (PDT)
Message-ID: <5ea3bf56.1c69fb81.22f35.8b90@mx.google.com>
Date:   Fri, 24 Apr 2020 21:40:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pnp-5.7-rc3-19-gcd227cc5ff82
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs, 1 regressions (pnp-5.7-rc3-19-gcd227cc5ff82)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 1 regressions (pnp-5.7-rc3-19-gcd227cc5ff82)

Test results summary
--------------------

run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =

2   | exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =

3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

5   | rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

6   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 6/6    =

7   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pnp-5.7-rc3-19-gcd227cc5ff82
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      cd227cc5ff829b628f48df3e6b18fc59349c4f9c =



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
  Plain log:   https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0417.1/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

      =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
2   | exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroi=
dxu3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroi=
dxu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0417.1/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: v5.7-rc2-16-g247f4817f956)   =

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
  Plain log:   https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0417.1/armhf/rootfs.cpio.gz  =


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
  Plain log:   https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squ=
are.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pnp-5.7-rc3-19-gcd2=
27cc5ff82/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squ=
are.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0417.1/armhf/rootfs.cpio.gz  =


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
