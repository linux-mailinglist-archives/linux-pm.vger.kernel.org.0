Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A972C3AD414
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 23:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhFRVE1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 17:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhFRVE1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 17:04:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DBAC061574
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 14:02:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e1so5316580plh.8
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Vvf/SH3Isla3aU5SK9PfZXd4HgoD9E2QsvYm73JWwpY=;
        b=z5SjtYCVJTr0pJYjNmkKFfRevtrvblDuDdKKmX/davTnsorLRc3Q0iQYF1PbE7k2W7
         7jtpssSkl2xHng83mDMoqEXPuddSon+4ialL3PYxGCWeUD8Gr88LiGmrpEKMm5ee7tnO
         JaXXsIVAQDEqM1crgP2zoDmhjYet8Zt1l0QE8BfxEQccnuDlRjvdS50/I2eib3LepjRx
         p8Z/WsZBCiKFhL0nRZhCQbDKTG+KYwqeMHkLsfLUJvcciKSndtSqp5xMzuf47Ew+uYWN
         p7lj/HYmL9DCFZHy0Pix2HYgnzUGC8OqpZyx8ApzMpMIFb4Wk/LcqgxGe04mRMJPgkBH
         Edxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Vvf/SH3Isla3aU5SK9PfZXd4HgoD9E2QsvYm73JWwpY=;
        b=KNej8QDdfe6TJf2DWzLZl8JbPWIjQeOuHA8jb9A36qhSPaw5Kj8JUj/gs+BTCs72rE
         4M5UZMKs1LSM0pM8LJw4FuCFpGza+FELd1uqTVq5goVIflUqcnoLc/fOYYt6ysyjiUeE
         lFct7EGX/nFlu6DjxEKDGyhyoGeLG6ag2uchvaCB/2CEd8QTJhdqkItjoD8ESHxLQZeM
         Lv0aQ+/PoKGFz/KeaMEZ8pia4dcxC+ng2T+noAb+TpUErs1WmrVJXW8sGSNcclEB+rI/
         V4sagb78OiUkzoetZKVl1CuXh8BzsFjYhV0cX31yPK4OdIU1c8PmOIA2t7bQFK1NYfhw
         lpsw==
X-Gm-Message-State: AOAM531ClpxKVdSJ+qNa6+U/7OvJfTNEc9yClquzQPaAWcSB6HvWq/7f
        FNtHI4vx6HGLkklx75WNI9qgUQ==
X-Google-Smtp-Source: ABdhPJzmlPeRn208Hcj2tW4PEm5dWAuiEMfGbRkFiAk+2rnc3hDKd5ModK9H8VBe5S2WnViHKIR1ug==
X-Received: by 2002:a17:90b:1d06:: with SMTP id on6mr13286194pjb.50.1624050135963;
        Fri, 18 Jun 2021 14:02:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j4sm11821807pjv.7.2021.06.18.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:02:15 -0700 (PDT)
Message-ID: <60cd09d7.1c69fb81.78498.2675@mx.google.com>
Date:   Fri, 18 Jun 2021 14:02:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: pm-5.13-rc7-139-g5469c0cf8416
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 89 runs,
 2 regressions (pm-5.13-rc7-139-g5469c0cf8416)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 89 runs, 2 regressions (pm-5.13-rc7-139-g5469c0cf8416)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =

meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.13-=
rc7-139-g5469c0cf8416/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-5.13-rc7-139-g5469c0cf8416
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5469c0cf84167fc90f5a6899df50cffa9ad1ccf9 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/60ccfc04204761a61441326e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.13-rc7-139-g54=
69c0cf8416/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a00=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.13-rc7-139-g54=
69c0cf8416/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a00=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60ccfc04204761a614413=
26f
        failing since 204 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fi=
rst fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/60cd01aa2d6466b2fe4132cc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.13-rc7-139-g54=
69c0cf8416/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905d-p230=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.13-rc7-139-g54=
69c0cf8416/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905d-p230=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60cd01aa2d6466b2fe413=
2cd
        new failure (last pass: v5.13-rc5-112-gfce7d470d0dd) =

 =20
