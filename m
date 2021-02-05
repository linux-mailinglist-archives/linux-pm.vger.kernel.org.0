Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BA531018B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 01:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhBEAWU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 19:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhBEAWT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 19:22:19 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C097C0613D6
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 16:21:39 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id j2so3328856pgl.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 16:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0cipnU1+bW72Ga3/Etb3ZkiSnTx2ZaxsfCrDprF2M+4=;
        b=reXJ9wnfWOIPmi+EhaznRvQ3ZrN31ka4o2qYcULaBfuJKXavoNObXCinOe8hvgpkty
         QvlggwW18JvGcSK+tUaMwmy28kKgLS7MOwsPOuWhXAAf+9p2WDbMeF6XAZgQ6SiLHuDP
         mjAjcSpWlGIB73SbO26CcTqbTl5wbwRcHnnV7vwKJ2A9hQBJSV1YG6Q4k9p0QiLOXlWI
         GPV7gPWCB9ekcE7qUMCtP2COZRSI45hvHj6+vf6gXYOL6F0NnER/fz/dTrF8o218uh27
         frp+2V/B7VPBQYpiSOCGCFQ2r835q2Sy4UDL9wTngvcVK3AJhrhJq4vxnNaDQSse/i0l
         1DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0cipnU1+bW72Ga3/Etb3ZkiSnTx2ZaxsfCrDprF2M+4=;
        b=XDirLy0IZztl2pv8cVCDgPo2IHlxejaTesrKmQuUqwrHoaJGawmubraa8y74NGAKyL
         ToDirtZ50vDsqlwAvkV/4b314wxmthHCwaaopq1KR4vA3Erl+8EbP0sEI5kn9KAaxBif
         SE5sl8V9OIgBaMKnZCzNvgOHrsGLOmuHZD1iCivwv+e+LKe2upi+dPBHOuJ+p0ox/VA9
         bH2Gxy+VSgaB1CnhM/NvifoRZZQjD2t2w8RvUCHNXCnIf2vaftG5EgNH3h71K6O4MgOP
         ElAjjOx4WvbOUXsiqfsYp6vpO+3m1h7g9iRrTM8NW5hkT3mZy31X/ktQCdPUiskMx+J3
         gM3g==
X-Gm-Message-State: AOAM531xi3eTNE0SwB1nASdE4RmSj1OGAuabhyuKJfgJkUVZcyDNzUvU
        9sYp6Xbx2a6zoYfngMEWNX/oUg==
X-Google-Smtp-Source: ABdhPJyML3A8/0OUqKfnDF5Nd7ceons5y1fczO3QVhb6xm3ANLrOVDFMv83bjg8t6XJd51eumgSCRw==
X-Received: by 2002:a63:6e0f:: with SMTP id j15mr1541102pgc.21.1612484499027;
        Thu, 04 Feb 2021 16:21:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r7sm6616361pfc.26.2021.02.04.16.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 16:21:38 -0800 (PST)
Message-ID: <601c8f92.1c69fb81.68aca.eeb3@mx.google.com>
Date:   Thu, 04 Feb 2021 16:21:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: acpi-5.11-rc7-89-g5f8da9ef1c5d8
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 98 runs,
 2 regressions (acpi-5.11-rc7-89-g5f8da9ef1c5d8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 98 runs, 2 regressions (acpi-5.11-rc7-89-g5f8da9ef1c5d=
8)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =

imx8mp-evk           | arm64 | lab-nxp      | gcc-8    | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
1-rc7-89-g5f8da9ef1c5d8/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.11-rc7-89-g5f8da9ef1c5d8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5f8da9ef1c5d88b9a6de64ad33d98e2edd58ce89 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/601c82841c125eb69f3abe76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.11-rc7-89-g5=
f8da9ef1c5d8/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a=
00.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.11-rc7-89-g5=
f8da9ef1c5d8/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a=
00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/601c82841c125eb69f3ab=
e77
        failing since 70 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fir=
st fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
imx8mp-evk           | arm64 | lab-nxp      | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/601c86de0b254387ac3abe94

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.11-rc7-89-g5=
f8da9ef1c5d8/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.11-rc7-89-g5=
f8da9ef1c5d8/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/601c86de0b254387ac3ab=
e95
        new failure (last pass: v5.11-rc6-72-gc42187278fc1) =

 =20
