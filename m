Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E718835A91F
	for <lists+linux-pm@lfdr.de>; Sat, 10 Apr 2021 01:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhDIXL6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 19:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhDIXL4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 19:11:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F534C061762
        for <linux-pm@vger.kernel.org>; Fri,  9 Apr 2021 16:11:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t22so3144913ply.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Apr 2021 16:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8VvVo+ivNgiqVjmY8DXeMtFpOrnhht2yzQMguV7uG1Y=;
        b=REWm0EUyrDLTLs0QpSsfjL+mUq1SLZlWyo2KhNGTwDoFdhMrRvLmIqFLMeOPye2IRP
         2srLeHb6Y6SsSYSyrOMhJeouPS+BQjLU75L5PzXyfmaJb37ItbjuOjQVFnwXPV5lm3b7
         e+dNjT1eRXPGS/lALsM84BIlXvjNc9oQRpWPT7h3eW3ZldtBUOBAIrwX66b5VQWx6J8P
         VZ9s3pM6Iv47JsRalbO4LVuDTmYx5a3D3vzdoqC4lpgnCeRsN44PcBTJs50ng5ytnx90
         JIkMHfE2NLkL51FcgptMBBTjIaGKSMqa/tq+GiStSxqumbytnssz268vQb3qxoXH/Jtl
         vXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8VvVo+ivNgiqVjmY8DXeMtFpOrnhht2yzQMguV7uG1Y=;
        b=KSHhoVjBMIfaxctKBerY7r7/LuF3CMaoKi4CEIDf6bacPLX1jpG6NoQ2iZKHKHTova
         z+5TZqplg5keMtMDeicbN8wIfpgGbEL3CisrxovkMyvTDVxH40STdGAhRNlqdbAZLPuy
         xPj/rQCVSlKgNKjopGcmRt/4vYklLXlFT3gs7FKdwux1YVAp0htfqxRkaZHb1vMkIIe/
         dBK2RsrvMJ6jIsuiN2+fjRg+io8ivD2qrSXt0JfqvZ4Tayoa9/+tjjaV0nrgONf7n/RY
         o86p7Uc+CgGjcavg9f1b9euVrlza89jkjW+RUEnZ0lEJFvTlYykHMAUn28BbdHB3CKDZ
         xesw==
X-Gm-Message-State: AOAM532uP1wU6lw5XJXulbgYt6ETXmVS0iGApc+bDAcdKq69PCB73fAH
        uLCfR87Oigva3XmNajywYq0w6g==
X-Google-Smtp-Source: ABdhPJzPbhaoAbRmLfH8ChumNJgwQokMxXUthMfQsiVf1ysRpW95X31ZqaWNnavYFKpm7TbHu4kpEw==
X-Received: by 2002:a17:90b:f93:: with SMTP id ft19mr15583404pjb.135.1618009902841;
        Fri, 09 Apr 2021 16:11:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a81sm3006645pfa.165.2021.04.09.16.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 16:11:42 -0700 (PDT)
Message-ID: <6070df2e.1c69fb81.ce213.86a2@mx.google.com>
Date:   Fri, 09 Apr 2021 16:11:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: acpi-5.12-rc7-125-g45f505d811b4
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 106 runs,
 2 regressions (acpi-5.12-rc7-125-g45f505d811b4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 106 runs, 2 regressions (acpi-5.12-rc7-125-g45f505d811=
b4)

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
2-rc7-125-g45f505d811b4/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.12-rc7-125-g45f505d811b4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      45f505d811b4a64b2909019c0e0cba141114a007 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6070d0e42c0faaf9f0dac6b2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.12-rc7-125-g=
45f505d811b4/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a=
00.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.12-rc7-125-g=
45f505d811b4/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a=
00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6070d0e42c0faaf9f0dac=
6b3
        failing since 134 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fi=
rst fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
imx8mp-evk           | arm64 | lab-nxp      | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6070d687f9fbe32979dac70f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.12-rc7-125-g=
45f505d811b4/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.12-rc7-125-g=
45f505d811b4/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6070d687f9fbe32979dac=
710
        failing since 8 days (last pass: v5.12-rc5-47-g506a524e05e2, first =
fail: v5.12-rc5-47-g85f34ae663986) =

 =20
