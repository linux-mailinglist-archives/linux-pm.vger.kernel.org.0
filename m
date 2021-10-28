Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C143E6B6
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 18:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhJ1RBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 13:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1RBo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 13:01:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B5AC061570
        for <linux-pm@vger.kernel.org>; Thu, 28 Oct 2021 09:59:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v20so4859328plo.7
        for <linux-pm@vger.kernel.org>; Thu, 28 Oct 2021 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9VqXA6w7TThWcqG1p9YDumg4wUPeeGGcExc4jrIQ10s=;
        b=NQthHV/t06sVx9/JiWKMeDrfYrPaDszKb+TP8QlAwURfKTLsOWlP9gRyW3CMXy3ytl
         JV8OZ47O6hmY3pFbVbAaXYwz9vVqSE0KchY0/WkyNgLE2fvhjaqAsDtHnvi2A2ZsDCcW
         Ya8HeL8ku1ogtltrFLOajmr8aif8Cl38CuXoZl1JyNGBpRLy92EJjFhnpz98+11Gz20E
         Kl5xC/bofwB7L96VTYqpaDw/r9MFo1LILA2EA/JLq8xZP0Xa1dRtzGf8Lm5yDuXedlDp
         zDcai08cBhahmroUwNjErnRdWNW60Nscrgd4i74EQU4xfV3Aws8Iee+tuBoelBJRPG9t
         b3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9VqXA6w7TThWcqG1p9YDumg4wUPeeGGcExc4jrIQ10s=;
        b=qiMSd2UicSvsKJx1kS4TJMtE6ZMdmMDpoESlLfkF35a1QGhH9BrIn2JwJmjR5bxesl
         zXO3roew4TZOrYPJ2xUHeBzXRSXnFbaJReeRZ+olpsVSAakXUFxWOJZKDfo5ZNsroTyt
         bRxEsyKTZx8BQEm55rwn+VbvcQwI2ZP4eJ+R0lNmLNL4tEIH6ltv6JAO65dsbHaeciax
         DLxSgJsIA6ECFqFwsPK62tIUgtUVxuMo0I2TZUCYN046tCtOfteq5zijoDw1NxnW1jAd
         2OX8vNk+HllLPlvW8wKh8rOgdq6wxRlVq4fSMK1VkdcB81Y7a59368E2gYRwlSoQ0BKZ
         qTXQ==
X-Gm-Message-State: AOAM532tPMXFM6DM9fGoQ3s1Cw5D4xL2e6WQvwQrOpa21CFOwj/6tJWD
        bPkxabqd3q+5X73CVWfFEwHsEQbBuQGf4g8/W+M=
X-Google-Smtp-Source: ABdhPJywU7Qi3s7r0N2eTxRjQoWJKPQ1my50ipBX8WAASsvsu2xkbTUyWMuZ7BVzau8CdnOCyv7HPA==
X-Received: by 2002:a17:90b:4c0f:: with SMTP id na15mr5653704pjb.96.1635440357100;
        Thu, 28 Oct 2021 09:59:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z15sm3234806pga.16.2021.10.28.09.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:59:16 -0700 (PDT)
Message-ID: <617ad6e4.1c69fb81.1bbc0.9b1a@mx.google.com>
Date:   Thu, 28 Oct 2021 09:59:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc7-120-g1eb4f10091ca
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 82 runs,
 1 regressions (v5.15-rc7-120-g1eb4f10091ca)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 82 runs, 1 regressions (v5.15-rc7-120-g1eb4f10091ca)

Regressions Summary
-------------------

platform      | arch  | lab          | compiler | defconfig | regressions
--------------+-------+--------------+----------+-----------+------------
rk3328-rock64 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
7-120-g1eb4f10091ca/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc7-120-g1eb4f10091ca
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1eb4f10091caba528d8f81e0e14e9f6be1b22427 =



Test Regressions
---------------- =



platform      | arch  | lab          | compiler | defconfig | regressions
--------------+-------+--------------+----------+-----------+------------
rk3328-rock64 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/617acbae6dde82a4d53358e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc7-120-g1eb4=
f10091ca/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc7-120-g1eb4=
f10091ca/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/617acbae6dde82a4d5335=
8ea
        failing since 2 days (last pass: v5.15-rc6-80-g30c7771b41dc, first =
fail: v5.15-rc7-95-g5ae5ac40021d) =

 =20
