Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385062C5C21
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 19:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404699AbgKZSrU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 13:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403877AbgKZSrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:47:20 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08F0C0613D4
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 10:47:18 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s63so2330011pgc.8
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 10:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=q6ggobS69pywsEBBezcfDxpX7vxdlKSt+ZDcAFlZM8Y=;
        b=jDVhj2QAcPaprg1kxnGC27TZNXeWHHjmE3hrIQWbJJRjMoYM5MAJFzFwZd9/Kdm5gO
         zDwp7qLUpmcRJ7MhEpppBM43jIr9Yyz1fgvC+rOWA/lIst6KRLJxi1wxjC94/v794FW1
         CAILkc3Rj2v68Gx3OiPsLfOt5+58SWIdBZJgmbyl7eYycRHmebSdpMQ7zFaGDlfbYac+
         lk1USRetkyoftP+P13+HmOUeUL2SMbkwQZ7K0Z8Bnk8g8oFmoS9LdESe+liH18cJJAup
         yPemcQzzgAF+Z4jXEtiO10mav54RPHfJ1lSTvOMtla8aXomziWxCAhgycnhpgk4ru10V
         FFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=q6ggobS69pywsEBBezcfDxpX7vxdlKSt+ZDcAFlZM8Y=;
        b=n1/je1EVFyBCBVFXhyYHxnltg2JHcRrvnT+DUTx7t2GZV2C188ZISMLPDwOgVQneF9
         aBv3LiAPUvWg/IjJmopw3NQ75Z8Fw323tBM2/U8NrbOJJx11I1Zc5Y1C9i0HiTfEXWjL
         /TywJNkiitG/RVv+JH1Q1RRqKd+Mb2IhOwJU6tMRNhBvMDv+331PrFlp87LFtASg8LmE
         ONOoa3FZoOEOs9ElCltBbm6dtB/4+fB8ZPzyvv97WMv+PB0E2kFvdX2Uw260mO0iyJxh
         HctN9fAOhnIfHmFAo32MKTv/Jukx+pHnnFQaxGfIBKAlbG7iuIL30wR8Ynedd0XRuSzC
         bSAQ==
X-Gm-Message-State: AOAM533AdiZ76qtLHmNSKUhVne1dC0L4juxyo+YBfBeN3qb/O+smzLOC
        7wGBbwdafg6W8kM7CGKdD4M8CA==
X-Google-Smtp-Source: ABdhPJzgqJ3cGjRP6oFc7FqMV7uDPGhipIu9/xlq5UuTJ7iT02/UCNzWzX6kFXT0gQeoCGQRdV0nzQ==
X-Received: by 2002:a17:90a:cc01:: with SMTP id b1mr5090833pju.121.1606416438198;
        Thu, 26 Nov 2020 10:47:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w11sm7594617pjr.2.2020.11.26.10.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 10:47:17 -0800 (PST)
Message-ID: <5fbff835.1c69fb81.22a14.027f@mx.google.com>
Date:   Thu, 26 Nov 2020 10:47:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-5.10-rc6-75-g735f7fba25ec
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 128 runs,
 5 regressions (pm-5.10-rc6-75-g735f7fba25ec)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 128 runs, 5 regressions (pm-5.10-rc6-75-g735f7fba25ec)

Regressions Summary
-------------------

platform               | arch  | lab          | compiler | defconfig       =
   | regressions
-----------------------+-------+--------------+----------+-----------------=
---+------------
bcm2837-rpi-3-b        | arm64 | lab-baylibre | gcc-8    | defconfig       =
   | 1          =

beagle-xm              | arm   | lab-baylibre | gcc-8    | multi_v7_defconf=
ig | 1          =

hifive-unleashed-a00   | riscv | lab-baylibre | gcc-8    | defconfig       =
   | 1          =

meson-sm1-khadas-vim3l | arm64 | lab-baylibre | gcc-8    | defconfig       =
   | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.10-=
rc6-75-g735f7fba25ec/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-5.10-rc6-75-g735f7fba25ec
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      735f7fba25ec002ec984d45612afaa3a553fe05d =



Test Regressions
---------------- =



platform               | arch  | lab          | compiler | defconfig       =
   | regressions
-----------------------+-------+--------------+----------+-----------------=
---+------------
bcm2837-rpi-3-b        | arm64 | lab-baylibre | gcc-8    | defconfig       =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/5fbfed7f30f0e39781c94d06

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.10-rc6-75-g735=
f7fba25ec/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.10-rc6-75-g735=
f7fba25ec/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5fbfed7f30f0e397=
81c94d09
        new failure (last pass: v5.10-rc5-65-g0a1829d7eb6a)
        1 lines

    2020-11-26 17:59:27.947000+00:00  Connected to bcm2837-rpi-3-b console =
[channel connected] (~$quit to exit)
    2020-11-26 17:59:27.947000+00:00  (user:khilman) is already connected
    2020-11-26 17:59:43.330000+00:00  =00
    2020-11-26 17:59:43.331000+00:00  =

    2020-11-26 17:59:43.346000+00:00  U-Boot 2018.11 (Dec 04 2018 - 10:54:3=
2 -0800)
    2020-11-26 17:59:43.346000+00:00  =

    2020-11-26 17:59:43.346000+00:00  DRAM:  948 MiB
    2020-11-26 17:59:43.379000+00:00  RPI 3 Model B (0xa02082)
    2020-11-26 17:59:43.454000+00:00  MMC:   mmc@7e202000: 0, sdhci@7e30000=
0: 1
    2020-11-26 17:59:43.486000+00:00  Loading Environment from FAT... *** W=
arning - bad CRC, using default environment =

    ... (378 line(s) more)  =

 =



platform               | arch  | lab          | compiler | defconfig       =
   | regressions
-----------------------+-------+--------------+----------+-----------------=
---+------------
beagle-xm              | arm   | lab-baylibre | gcc-8    | multi_v7_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fbfefa7ad470c4563c94df9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.10-rc6-75-g735=
f7fba25ec/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.10-rc6-75-g735=
f7fba25ec/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fbfefa7ad470c4563c94=
dfa
        new failure (last pass: v5.10-rc5-65-g0a1829d7eb6a) =

 =



platform               | arch  | lab          | compiler | defconfig       =
   | regressions
-----------------------+-------+--------------+----------+-----------------=
---+------------
hifive-unleashed-a00   | riscv | lab-baylibre | gcc-8    | defconfig       =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/5fbfe9fc08d3be7eabc94cc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.10-rc6-75-g735=
f7fba25ec/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a00.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.10-rc6-75-g735=
f7fba25ec/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a00.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fbfe9fc08d3be7eabc94=
cc4
        new failure (last pass: pm-5.10-rc4-33-g52d108cd060d) =

 =



platform               | arch  | lab          | compiler | defconfig       =
   | regressions
-----------------------+-------+--------------+----------+-----------------=
---+------------
meson-sm1-khadas-vim3l | arm64 | lab-baylibre | gcc-8    | defconfig       =
   | 2          =


  Details:     https://kernelci.org/test/plan/id/5fbfed9b32b71de4bac94cdb

  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.10-rc6-75-g735=
f7fba25ec/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-sm1-khadas-vim3=
l.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.10-rc6-75-g735=
f7fba25ec/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-sm1-khadas-vim3=
l.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5fbfed9b32b71de=
4bac94cdf
        new failure (last pass: v5.10-rc5-65-g0a1829d7eb6a)
        11 lines

    2020-11-26 18:01:57.808000+00:00  kern  :alert : Mem abort info:
    2020-11-26 18:01:57.808000+00:00  kern  :alert :   ESR =3D 0x96000006
    2020-11-26 18:01:57.849000+00:00  kern  :alert :   EC =3D 0x25: DABT (c=
urrent EL), IL =3D 32 bits
    2020-11-26 18:01:57.849000+00:00  kern  :alert :   SET =3D 0, FnV =3D 0
    2020-11-26 18:01:57.850000+00:00  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2020-11-26 18:01:57.850000+00:00  kern  :alert : Data abort info:
    2020-11-26 18:01:57.850000+00:00  kern  :alert :   ISV =3D 0, ISS =3D 0=
x00000006
    2020-11-26 18:01:57.850000+00:00  kern  :alert :   CM =3D 0, WnR =3D 0
    2020-11-26 18:01:57.850000+00:00  kern  :alert : user pgtable: 4k pages=
, 48-bit VAs, pgdp=3D0000000044be4000
    2020-11-26 18:01:57.850000+00:00  kern  :alert : [0000000000000002] pgd=
=3D0000000044be6003, p4d=3D0000000044be6003, pud=3D0000000044be7003, pmd=3D=
0000000000000000   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5fbfed9b32b71de=
4bac94ce0
        new failure (last pass: v5.10-rc5-65-g0a1829d7eb6a)
        2 lines

    2020-11-26 18:01:57.887000+00:00  kern  :emerg : Code: d503233f a9bf7bf=
d 910003fd 97ffffe0 (79400401)    =

 =20
