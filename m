Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051EA3B34F4
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 19:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFXRq2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 13:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFXRq2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 13:46:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8B0C061574
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 10:44:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g24so3914215pji.4
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gLg2GEvVfSu665sj/pFmVMReDqNxxR9mUKji+NSIz7o=;
        b=MiTsBuOR0ESge4miXJWLydPE45JWnOX53xObePEkSBti440sckrrzclm+k6dVIDPAV
         RuREZvEr9lsj/aQ7pUyflzRuyxswppOkSLJQM2WC2XMJlLDDZRy/naUwUneQ3TNpbQVC
         6LP/BgbdtrFOoQ/2UgujySkm7bgK8ZZcw4pGrxKwip+V9bmBkGGNNVOYf4qYnh2v2ugO
         /KgFXcVV6m9dCh9dwO5I7XVDvnf+Iy9uIQSowtUHJJITEjRQp90IrlbYM+07kwXLUyLS
         +EVg/2On6b60mKn4nBdre4P8zUyMgdWw9Gy0tjCxfPE8m9EIzXbubMx8HHWdTnGPnSnU
         auFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gLg2GEvVfSu665sj/pFmVMReDqNxxR9mUKji+NSIz7o=;
        b=FkqdATO4kZI8MJuaEtnAZSZcYyDOE3uuvbjRRH0RRY7sw4LqpKplTXCqmJDGvjaxRT
         hDqf4HbyEEuMRGGYhf5oPCalK/7ijNqd++jj+g4D8BNNdtVddYxYpvY7BkcHYaRHrCX2
         EwF+rhE5FrdPbL/fKH1xnIMUqS/Xm5ZArVMuo72VOxRp7mHzDNSBl9GIkcatrYa1LfQ5
         Npd0LuHggGi43jZjtGYh07rRZMDpqP/5BZqV8aDlYtmrrtLg+VDo0XS35T/2lJTpSm1A
         dqBUEBbWe6uTIRA8s1w9OjBFFJKrH8D67dOIOLKHeC0M2bOfGWrW96XI0WnUj+iGgVcK
         UUbA==
X-Gm-Message-State: AOAM532WqvjW36OYDu7AHdnRkpoP5ME/u4jWD0M1F7zIQXRkBhRzvtCp
        dOHNJfY4wOiulRjiTOEuW0mtwblANzu7eqag
X-Google-Smtp-Source: ABdhPJzo+ViVGRMm3tStU1J7rN/wwcPGECu3UPk0SugZBRCHkbE9CViN3hgmp/ld8LHgrSGl7JA7Kw==
X-Received: by 2002:a17:90a:c917:: with SMTP id v23mr16149403pjt.167.1624556647353;
        Thu, 24 Jun 2021 10:44:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y80sm3518271pfb.204.2021.06.24.10.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 10:44:07 -0700 (PDT)
Message-ID: <60d4c467.1c69fb81.7f497.983f@mx.google.com>
Date:   Thu, 24 Jun 2021 10:44:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: pm-5.13-rc8-159-g3304616e985f
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 73 runs,
 1 regressions (pm-5.13-rc8-159-g3304616e985f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 73 runs, 1 regressions (pm-5.13-rc8-159-g3304616e985f)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.13-=
rc8-159-g3304616e985f/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-5.13-rc8-159-g3304616e985f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3304616e985fa1c05e1a111375480fc88d71a574 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/60d4b71e0732ab247041329d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.13-rc8-159-g33=
04616e985f/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a00=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.13-rc8-159-g33=
04616e985f/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a00=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60d4b71e0732ab2470413=
29e
        failing since 209 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fi=
rst fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =20
