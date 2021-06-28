Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2483C3B6B9A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 02:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhF2AC0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 20:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhF2ACX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jun 2021 20:02:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB0C061574
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 16:59:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g4so11308323pjk.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=us8uXr4RhmtWa5K9eTExZma90iBZJIP7Ie4BrFd/wKQ=;
        b=B/sKz5f2zplJxq+05FeYPb7imXejun/+YpYAzYo+nxeRJk54Ji2jeRH1Va4Fyjy2EQ
         5irGRYne3MXCt/ymitMbFalfMSWYxRmdvNiqowDT+cIDIyW2znEIoXoE8PB7wxk6Kf3q
         uaMM4TiuqdS8aEkkvxyDiqC4APmoACtRMyDqms3Y7G+moVWo1tHFQu1WUAuGcgamiVm5
         SsYlDXop+/PAQ0qlX9vm9EkJ8LcmFcYj5D4zmtvx1Q1bs9nVMccyzJRGhaGX7V3V2jQd
         rqy6nZQWac1J0gTTcC67v1GAbxOI8JcV08MNAOt8BTfqDHgMjjKTdc7EAe4uUTE6yQv0
         yNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=us8uXr4RhmtWa5K9eTExZma90iBZJIP7Ie4BrFd/wKQ=;
        b=mwhIFwxB1tcBN6t5SPSWLv0WrO4OzEcMC7HFkbyCHUwum5mJlpKFTXWkz19s9E1e2c
         1UwdDn07HG8W5BUq4JljcRU6xo9fP0TrbgzQOfjzsKpnzXpOlaPscBo+TagEXnkRD1pQ
         9j7doGcRSHCo4i7BvjBbkhn05/M5QO8FL4ZnHUOc8Qs7/CCbvNT7GUYKjC0Ux4bOReqO
         owtVG4cjtY+be4JqAzPTuEt+WLmzYpoHGhWn21sUGmhlHjttI3MZ5vBNxS0/O8lrROVa
         x0mDCswhVXlaYPF5rU+7XPsg1k3J/DaRCEvb86mH/MxL0rp2Z1ZrbW0kZ9UCIhKSPrMg
         +aJw==
X-Gm-Message-State: AOAM531eFOLMl48YK7+cMWINfeO/KfC16HZ9227g2M5pJNBSfDOnQmfR
        QRZWVBqsWbygMwdApm2Vgvuejg==
X-Google-Smtp-Source: ABdhPJwndAmltX73hfdhPaKS42O6XBErVQlxbbc6ZYEoKwo5meUB80GClBqMr3WaFiXJjfXZlQRSbw==
X-Received: by 2002:a17:90a:5202:: with SMTP id v2mr24198851pjh.169.1624924795747;
        Mon, 28 Jun 2021 16:59:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v9sm15339035pfn.22.2021.06.28.16.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 16:59:55 -0700 (PDT)
Message-ID: <60da627b.1c69fb81.bfb9c.dc6f@mx.google.com>
Date:   Mon, 28 Jun 2021 16:59:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: devprop-5.13-rc8-169-g33842e66a789
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 57 runs,
 2 regressions (devprop-5.13-rc8-169-g33842e66a789)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 57 runs, 2 regressions (devprop-5.13-rc8-169-g33842e66=
a789)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/devprop-=
5.13-rc8-169-g33842e66a789/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: devprop-5.13-rc8-169-g33842e66a789
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      33842e66a789d1e4aa9d0379c1f5f43fd4cc4ae7 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/60da55f36129f1400c23bbe9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/devprop-5.13-rc8-16=
9-g33842e66a789/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashe=
d-a00.txt
  HTML log:    https://storage.kernelci.org//pm/testing/devprop-5.13-rc8-16=
9-g33842e66a789/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashe=
d-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60da55f36129f1400c23b=
bea
        failing since 214 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fi=
rst fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
imx8mp-evk           | arm64 | lab-nxp      | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/60da5b07e3faacaf5323bbc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/devprop-5.13-rc8-16=
9-g33842e66a789/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/devprop-5.13-rc8-16=
9-g33842e66a789/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60da5b07e3faacaf5323b=
bc4
        failing since 21 days (last pass: acpi-5.13-rc5-42-ga25ea0c642c2, f=
irst fail: v5.13-rc5-37-gfcbef3bdf3a8) =

 =20
