Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0093CF488
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 08:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbhGTFuQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 01:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbhGTFuP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 01:50:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD24C061766
        for <linux-pm@vger.kernel.org>; Mon, 19 Jul 2021 23:30:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p14-20020a17090ad30eb02901731c776526so1319562pju.4
        for <linux-pm@vger.kernel.org>; Mon, 19 Jul 2021 23:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fdyvMoA0pBeuLVlJmLV9c5yZwDaPQigFSQdyXafMuZc=;
        b=TC8CSRu1qkLbsXT5BggRKs6BlvI05Ega6D1itBB5wa6QalMg/6V1NRpbqLxu6nsA9g
         DGoumOdpqY1Neab9CHVmE1iNY/qW8PvkM6cVR4hMGZqQefR5g0h5OTgFG4Za9LpfoIeG
         KdFDXRhMYnDD8AL6w9bD/mqY7t/QZnr3JnScgC6DseSCh/NfRiV+uqZ4vM+WsB7Hom5L
         3jxxAd5JLkjh4fkceMh2wM9d6q5eQAY1iql6smXocy1xkYeQ/BbwBeCr1AgdZmywSI0k
         Ec40hCKjyUwq3Z4GHQf72NnCT10gIelDuQmtOuO9bvzbJzGYpAX4T/FS0wMe7AiUSyDT
         lU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fdyvMoA0pBeuLVlJmLV9c5yZwDaPQigFSQdyXafMuZc=;
        b=r3WUUGeEcFCi+Reqo46Y51LKh8GPFs6z1FPRkHV0+xD9zs9+ITwuMegkdH7VUz+KpO
         tU0qAXF5aZ3ai4j/R851pre9F8PskHcewwyiDCm1RHQ9/JZzmu6QpDy0kQR1jTVjgZrZ
         EkHc5KqdQYGgasW37/dVaYna3BuVaWEJwSvMF9cemEfeaHwqiZKm6g7KxYezt3N8wvY8
         Z62MUgVnqFYPzLdfH0xVtUTuOW0BereTpzDXsKrg/ymW2VVtapu1FEK0w7X4VN8OU5SB
         tQmhzCGPrm5/pNWTE4KvCzSr6gH3y0g8Yl/YSzASx9RgC6YY++yCEofQvpfQtbPK0Nt3
         F9Hw==
X-Gm-Message-State: AOAM530/aKDWTvb0jWpTMusdfbkRrtUK49iD/BqCjp/vvy1d0SoGmFkM
        oQhP/qQOyVHD12gAbUegK7P4q3uN5D9BkA==
X-Google-Smtp-Source: ABdhPJy+aJ9O3fbVuYwdM8fjilWH79v8wtXLTPjNy3Re+pwzaZgPQARmeKV+nO8ZS9v5K7q/cyFfxw==
X-Received: by 2002:a17:902:9a41:b029:12b:8e55:d2b1 with SMTP id x1-20020a1709029a41b029012b8e55d2b1mr5254625plv.78.1626762652908;
        Mon, 19 Jul 2021 23:30:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ie13sm1556527pjb.45.2021.07.19.23.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 23:30:52 -0700 (PDT)
Message-ID: <60f66d9c.1c69fb81.ec57f.5c95@mx.google.com>
Date:   Mon, 19 Jul 2021 23:30:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.14-rc2-17-gd713e0c833987
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 108 runs,
 6 regressions (v5.14-rc2-17-gd713e0c833987)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 108 runs, 6 regressions (v5.14-rc2-17-gd713e0c833987)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
bcm2837-rpi-3-b       | arm64 | lab-baylibre  | gcc-8    | defconfig       =
   | 1          =

beagle-xm             | arm   | lab-baylibre  | gcc-8    | multi_v7_defconf=
ig | 1          =

imx8mp-evk            | arm64 | lab-nxp       | gcc-8    | defconfig       =
   | 1          =

kontron-kbox-a-230-ls | arm64 | lab-kontron   | gcc-8    | defconfig       =
   | 1          =

rk3399-gru-kevin      | arm64 | lab-collabora | gcc-8    | defconfig       =
   | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
2-17-gd713e0c833987/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc2-17-gd713e0c833987
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d713e0c8339876fb5070b53cb1bec248c37fbf38 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
bcm2837-rpi-3-b       | arm64 | lab-baylibre  | gcc-8    | defconfig       =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/60f663d6b14fbe6b3c1160be

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60f663d6b14fbe6b3c116=
0bf
        failing since 7 days (last pass: devprop-5.13-rc8-173-ge132b9a1079c=
, first fail: v5.14-rc1) =

 =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
beagle-xm             | arm   | lab-baylibre  | gcc-8    | multi_v7_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/60f66451534b7256501160a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60f66451534b725650116=
0a8
        new failure (last pass: v5.14-rc1) =

 =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
imx8mp-evk            | arm64 | lab-nxp       | gcc-8    | defconfig       =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/60f664e429f0e1a9ac1160a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60f664e429f0e1a9ac116=
0a8
        new failure (last pass: devprop-5.13-rc8-173-ge132b9a1079c) =

 =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
kontron-kbox-a-230-ls | arm64 | lab-kontron   | gcc-8    | defconfig       =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/60f664a7ae02aa9fa811610d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm64/defconfig/gcc-8/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm64/defconfig/gcc-8/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60f664a7ae02aa9fa8116=
10e
        failing since 7 days (last pass: devprop-5.13-rc8-173-ge132b9a1079c=
, first fail: v5.14-rc1) =

 =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
rk3399-gru-kevin      | arm64 | lab-collabora | gcc-8    | defconfig       =
   | 2          =


  Details:     https://kernelci.org/test/plan/id/60f66415c0b0564ff91160c2

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/60f66415c0b0564ff91160cc
        failing since 7 days (last pass: devprop-5.13-rc8-173-ge132b9a1079c=
, first fail: v5.14-rc1)

    2021-07-20T05:49:50.498592  <8>[   23.851182] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
    2021-07-20T05:49:51.521486  /lava-4217678/1/../bin/lava-test-case
    2021-07-20T05:49:51.532156  <8>[   24.887057] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/60f66415c0b0564ff91160cd
        failing since 7 days (last pass: devprop-5.13-rc8-173-ge132b9a1079c=
, first fail: v5.14-rc1)

    2021-07-20T05:49:50.485126  /lava-4217678/1/../bin/lava-test-case   =

 =20
