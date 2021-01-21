Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D1F2FF66D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 21:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbhAUUwK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 15:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbhAUUwE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 15:52:04 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6621EC06174A
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 12:51:23 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x18so1979052pln.6
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 12:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=y1kdWwW6tBm+eBFHi9McSUw7HB2Z9NLD4esehe0HXVo=;
        b=V33k+DYfR0bCSw3m93JiYJnFA/hmCF7uYFPN2JWOear2k9GO2tCFFsnfqVDwxCK1ck
         f2MFPGMCKTy2C4FdqSre1nhujQ7n2+lH7R6WlqsR5yUVsaT4wdxCsg6E0pvSUpEk3RMC
         EfzKInqeRKpzHg5sYzd2uwUMPvK3BLI9N//v/HRDGVt1kGF2kXCn8HCuUvtsPg6JwF3t
         BkyO8TI+TG/JTF2KgeIO3/JHhc5a6605PpZgvVo91xiZUpwfXxKO8FVesWodNxdvkUiu
         laH94MyQEgEbjtQUYT2UDQyEUECTI4hcA1rZUejZ6S8K5QcYAsmYOjyiK1tA2AMVj7xO
         qsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=y1kdWwW6tBm+eBFHi9McSUw7HB2Z9NLD4esehe0HXVo=;
        b=kZ8po+z5KtgucKEyeupWu+nx9p5NxPYoze6WeNjnd4zMfsUqIswGhbCbWF5ktqKVUB
         wkqhJnM6dXGagB4SevgHRQ117Znzs+jpMq7dHcWczwcaF92qkv602y3WJMSGGfxigPBz
         LlvkVR1qGoHJLdfHB+fgu5DTToE9h15Mq2KGt9DLOOJjpzpInirRKo0VgH++KYsE7yEV
         arZUXVGZfAey8npeb8bkhDru+dL9oTMIU1bzcS+GV2K/mR+wRCsoH47YfO6RyM+b5bgT
         7UsWIydK8YoHi2jnv+8/YmgEZv5rmT20ydrYj4tOYhwf8K/xnRA5E1leTMTzYVSXzvUn
         NJVA==
X-Gm-Message-State: AOAM531sDJLSpbJsA+6hvcQj5j9uBjr9p5IN8syYvTvCPVgBUMpG/da2
        leooghRdsMbeyCnIikwuJfHGBA==
X-Google-Smtp-Source: ABdhPJzkFtqFOFpc873Ql/VuJ5plkgcvc4Qa2/xgiFL9tEJYpwL6+WmVenyqAxHp+SteKhcYGF/OkA==
X-Received: by 2002:a17:90a:d3c7:: with SMTP id d7mr1310568pjw.169.1611262283040;
        Thu, 21 Jan 2021 12:51:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n2sm6085882pfu.42.2021.01.21.12.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:51:22 -0800 (PST)
Message-ID: <6009e94a.1c69fb81.5ba7.e7b2@mx.google.com>
Date:   Thu, 21 Jan 2021 12:51:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: acpi-5.11-rc5-27-gd9ac95f54ba88
Subject: pm/testing baseline: 63 runs,
 1 regressions (acpi-5.11-rc5-27-gd9ac95f54ba88)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 63 runs, 1 regressions (acpi-5.11-rc5-27-gd9ac95f54ba8=
8)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
1-rc5-27-gd9ac95f54ba88/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.11-rc5-27-gd9ac95f54ba88
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d9ac95f54ba88454a0ff889028149b802118a89b =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6009db0b9afc6fd14dbb5d15

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.11-rc5-27-gd=
9ac95f54ba88/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a=
00.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.11-rc5-27-gd=
9ac95f54ba88/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a=
00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6009db0b9afc6fd14dbb5=
d16
        failing since 56 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fir=
st fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =20
