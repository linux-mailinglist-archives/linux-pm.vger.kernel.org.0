Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927AE3063AA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 20:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbhA0TCh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 14:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbhA0TCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 14:02:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313A9C061574
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 11:01:55 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g3so1573071plp.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 11:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gfHD4I/nN9VEOZkD09CU6Flq67afLsC2Dj3AdQOa2kI=;
        b=NhGrymRO+gdpMA2sG426gSMsKI7G7MU5Gbt69hj0CWwV79VowrPQzMjgBUX3RBy4Hx
         gU6DyVw14FJvEgGMIjiPlCrswUkmM3qPUC59W2yuoQTYvj3wnb2AI3Duj65IRNQTgpys
         K0HWlAOqaaretLzu4vRKksYmfK54an8Rgv30+AT+CglAuLb9n4nNSIxV/QUMMBDO841M
         HHnYWhA+1bqJMDEJWw1uNiSck8dMXcZWCm3ySr37gw/PWvm1NAXstznEKWzmqzAuP+P+
         y6LyncRxMsvQqP9URrtsuMbneY9ipWGyTQ5ce3l3RUnQptdNhzK2qjtAyFhVGUeATb1i
         i26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gfHD4I/nN9VEOZkD09CU6Flq67afLsC2Dj3AdQOa2kI=;
        b=Lm32sNfn4QVHVAX2XhbjRxAz0nqnbdRerSLcoyCC9GJ0D1OjJA1l/rr6LId/PV+P8N
         E6dZnmhhM+9NetYKuUAC8L/yHBb9CTOMqcBR/qJOZkSNBgEwlOhHZAjzMds8fjTUABSO
         tNBeKLelDEaOC3epHH/gkkSZeSGm0PGOY2lpQjcD4ZuCbc7gAAV82e7xTd15AEKpSHnc
         /hcVRONNm7pe0wUM8htuD7MEl0aV1tGu8TwCkuARAJjUHmTsphc11tlZ4nXpSM0vAI4f
         M60Qm6/ahy/3DOgSjMUSFIaz2ySy7nEqYh3/JvvxtxrNwEuA1BeWyDfWMi9GzWzPtgex
         shoA==
X-Gm-Message-State: AOAM532KV45GEzlk5tS7ArLAAydmZcgQ3zcW4xMqaNmGdnIC3/TyX0jg
        7x1eNv6aDbwS36l0T8xya7JNRQ==
X-Google-Smtp-Source: ABdhPJw+Ks6UB9VAAtJ5IxG4TTZNY4ZTk2H/8sPOgd2Y6ChgVSldWCXztiQDu8fU6kNOyZw6dq8nxQ==
X-Received: by 2002:a17:903:1d0:b029:df:d098:f1cb with SMTP id e16-20020a17090301d0b02900dfd098f1cbmr12445370plh.49.1611774114777;
        Wed, 27 Jan 2021 11:01:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w14sm2761692pjl.38.2021.01.27.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 11:01:54 -0800 (PST)
Message-ID: <6011b8a2.1c69fb81.c1ae.6336@mx.google.com>
Date:   Wed, 27 Jan 2021 11:01:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.11-rc5-62-g93c3d4245f20
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 107 runs,
 3 regressions (v5.11-rc5-62-g93c3d4245f20)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 107 runs, 3 regressions (v5.11-rc5-62-g93c3d4245f20)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig   =
   | regressions
---------------------------+-------+--------------+----------+-------------=
---+------------
meson-gxm-q200             | arm64 | lab-baylibre | gcc-8    | defconfig   =
   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-8    | defconfig   =
   | 1          =

qemu_i386                  | i386  | lab-broonie  | gcc-8    | i386_defconf=
ig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
5-62-g93c3d4245f20/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc5-62-g93c3d4245f20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      93c3d4245f208b925982f9e9bef346f47dff0157 =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig   =
   | regressions
---------------------------+-------+--------------+----------+-------------=
---+------------
meson-gxm-q200             | arm64 | lab-baylibre | gcc-8    | defconfig   =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/6011af5bff80057d3bd3dfdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc5-62-g93c3d=
4245f20/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc5-62-g93c3d=
4245f20/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6011af5bff80057d3bd3d=
fe0
        new failure (last pass: acpi-5.11-rc5-27-gad758c58a703) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
   | regressions
---------------------------+-------+--------------+----------+-------------=
---+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-8    | defconfig   =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/6011afab1617f109ddd3dfd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc5-62-g93c3d=
4245f20/arm64/defconfig/gcc-8/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc5-62-g93c3d=
4245f20/arm64/defconfig/gcc-8/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6011afab1617f109ddd3d=
fd5
        new failure (last pass: acpi-5.11-rc5-27-gad758c58a703) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
   | regressions
---------------------------+-------+--------------+----------+-------------=
---+------------
qemu_i386                  | i386  | lab-broonie  | gcc-8    | i386_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/6011a704ffb2e61697d3e020

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc5-62-g93c3d=
4245f20/i386/i386_defconfig/gcc-8/lab-broonie/baseline-qemu_i386.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc5-62-g93c3d=
4245f20/i386/i386_defconfig/gcc-8/lab-broonie/baseline-qemu_i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6011a704ffb2e61697d3e=
021
        new failure (last pass: v5.11-rc5-48-gfeb0d85db3fd2) =

 =20
