Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DEF32F388
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 20:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCETKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 14:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhCETJp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 14:09:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CFFC061574
        for <linux-pm@vger.kernel.org>; Fri,  5 Mar 2021 11:09:45 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 192so2868326pfv.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Mar 2021 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=f0ZGqbpqYV1AMXI0j+I9nHs4swDRAdFUxszjGtGHyjU=;
        b=L5RUo10wwkDl6v9o4CiVnxvppyOgrdV70uc5SneRwxnSswaDHx8uH7/O1aNDkthn/T
         3UHFz2zCoExcm5Imt2F3AlncWB7FgJ0qKNbDUw9qWEGlVJ2oLf8vHmpqSpkYzloVBDfr
         5q6CzwcpLaH4EiA2OpGsQ00W4KBOr1X5lwAsp4IHgjAN2p0rjo//Say8jqGrZIGJlzwA
         mOuWrbLX1dg6yQ19pPEfraGbGROBuhWupXIK9m34H9Ssvhe5cXiXafy0FRm9r7O0BulZ
         Xa851hl1TUMbLwoJyoh18voEIVsVQS/kGsusGGrVOKFHb8CkVMoOjX4OGg2jLcicIU97
         /FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=f0ZGqbpqYV1AMXI0j+I9nHs4swDRAdFUxszjGtGHyjU=;
        b=sIZlgkha3VYoBqMXDYimrXbeDwi4ukg4fcHw3NUuN0ctieJ354Sr9i5vytQjbdtJal
         VhbYAJND06m+GyTWTaW3WikCv1bShaKqANldlssbNfH7mI+b45fTvvCP2gKT4ghp4nPZ
         Y3g7yPhYGXF8HuwC1bCUysKPL51JbtSE8VU5bueLp7Eirh6jcSYUWJ57mMJ5K4ejEACo
         bvn5IvanPQ8xcZ6HCBfVxC1A006GOp4lU20JpArX8AHP7HU30sTHF97jBT8PsbRcKeDd
         TB0ESMd3S37kwbfSSanp0M0a2FqvogapYB9h/WGC3wg5pMEoIAriRZk7XlzqFTW4c1FE
         c+yQ==
X-Gm-Message-State: AOAM532mCeAaMmIwiQVmcxL8uYhvODa3PDzNtK4iMe5mFm1dCfB2H9OR
        xzsH6QokCGW/OHnpI+11IXnktpbwEMy3lFIi
X-Google-Smtp-Source: ABdhPJw4DBWix3KuScK84Vh9jWdrx3aaPSqXjfgu+tsRb5eqY5oze7dD4s3Ehwzx7wlP0l2fMCBU7g==
X-Received: by 2002:a05:6a00:1393:b029:1b4:7938:ff1d with SMTP id t19-20020a056a001393b02901b47938ff1dmr10609347pfg.31.1614971384869;
        Fri, 05 Mar 2021 11:09:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y63sm2896109pfy.68.2021.03.05.11.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 11:09:44 -0800 (PST)
Message-ID: <604281f8.1c69fb81.bc8cd.7df0@mx.google.com>
Date:   Fri, 05 Mar 2021 11:09:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: acpi-5.12-rc2-19-g5c476073a9df
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 99 runs,
 4 regressions (acpi-5.12-rc2-19-g5c476073a9df)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 99 runs, 4 regressions (acpi-5.12-rc2-19-g5c476073a9df)

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

meson-gxm-q200       | arm64 | lab-baylibre | gcc-8    | defconfig | 2     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
2-rc2-19-g5c476073a9df/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.12-rc2-19-g5c476073a9df
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5c476073a9df062a501edf9ea7b11ccc53c27bf7 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/604274f67b4d680456addce5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.12-rc2-19-g5=
c476073a9df/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a0=
0.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.12-rc2-19-g5=
c476073a9df/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a0=
0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/604274f67b4d680456add=
ce6
        failing since 99 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fir=
st fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
imx8mp-evk           | arm64 | lab-nxp      | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/604279785d921b2cc4addcc6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.12-rc2-19-g5=
c476073a9df/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.12-rc2-19-g5=
c476073a9df/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/604279785d921b2cc4add=
cc7
        failing since 13 days (last pass: pm-5.11-rc8-201-g8b72d3aa065c, fi=
rst fail: pm-5.11-rc8-205-g4475f0291af9) =

 =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxm-q200       | arm64 | lab-baylibre | gcc-8    | defconfig | 2     =
     =


  Details:     https://kernelci.org/test/plan/id/60427809a921c46140addcbb

  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.12-rc2-19-g5=
c476073a9df/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.12-rc2-19-g5=
c476073a9df/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/60427809a921c46=
140addcbf
        new failure (last pass: v5.11-168-gd10b8fa0d6dfd)
        11 lines =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/60427809a921c46=
140addcc0
        new failure (last pass: v5.11-168-gd10b8fa0d6dfd)
        2 lines

    2021-03-05 18:26:58.829000+00:00  kern  :alert :   CM =3D 0, WnR =3D 0
    2021-03-05 18:26:58.829000+00:00  kern  :alert : swapper pgta<8>[   45.=
864217] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dli=
nes MEASUREMENT=3D2>
    2021-03-05 18:26:58.830000+00:00  ble: 4k pages, 48-bit VAs, pg<8>[   4=
5.874751] <LAVA_SIGNAL_ENDRUN 0_dmesg 785923_1.5.2.4.1>
    2021-03-05 18:26:58.830000+00:00  dp=3D0000000002633000
    2021-03-05 18:26:58.830000+00:00  kern  :alert : [ffff800408ea96b0] pgd=
=3D000000007ffff003, p4d=3D000000007ffff003, pud=3D0000000000000000
    2021-03-05 18:26:58.830000+00:00  kern  :emerg : Internal error: Oops: =
96000005 [#1] PREEMPT SMP   =

 =20
