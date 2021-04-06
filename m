Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FA0355701
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345320AbhDFOup (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 10:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239488AbhDFOup (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 10:50:45 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68C8C06174A
        for <linux-pm@vger.kernel.org>; Tue,  6 Apr 2021 07:50:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w10so5040065pgh.5
        for <linux-pm@vger.kernel.org>; Tue, 06 Apr 2021 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eEAk9FssOHar0dmQC/K7N+qjR/f/e4XVz/RS04yDbPc=;
        b=cfMpl4WqDrDcsMmgfGC9hoqSu3DFPtU0hiKJ4Q9fcPHu6eEBhPGBwfqF7Qcf+OGzcY
         zs3GkrXirhyk4pJf/NE5DSTfRzGREx+rep+8hWcDU0c9cEfbdCfPP5+zHUvrt5c4bCU4
         U9EfB7fxEfKX/bMlH8by89E1qKGvOgk2U6qqtHqUj+ciNodNeM7uKWbY1pwAYIY50SSe
         IZf9qDmeUSw0NJPNCSq8b2+9cE0dDMcb38Er9K7eEIgZPsYaUmNuZ6vxoHNvdnPXpwUb
         TnzFBHmOz7dauRUfXqMBxtSDPXNGtjJHXiCvgbGgK4VndiE8eQlEyF7pPb6iVqhshJuG
         Xenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eEAk9FssOHar0dmQC/K7N+qjR/f/e4XVz/RS04yDbPc=;
        b=CEm+AwKoOctrQTi/yHXuXODGBLhUfWEyo79m8EBTcZeSk3Y92kNv7uBeB3WtDqV9Qc
         A9535QHVmRfacQoiduTDqqNTcQZkdTp9Luh6OfBRwS+omn2ML05zLSXkqprIQEVFIzqw
         WDdTQ/kyvR8omHCDxE3arW8plJ3N+539cyt5XWCQeK402D4a2T3E55roiP5ofjxyO4GE
         r4tTpwVagtJXnMHmSfQojox/05CBQUqGylJoMnm9nGyZxi7zYm3CEhMEzacNeN98QSMd
         7I8RdQgmbs1iGiBS64ZXlzRFfYwnRllQBK6LHutoo4yt2JK7OlPE3IkQgNSKmaiVW8xv
         PXIA==
X-Gm-Message-State: AOAM530Po7CUqP6D1FOVi6XwYEUqb9MOq+bGfJoygr64bPuAs6t52nQV
        23uGivfsZov9AORLSf6FJENl1Q==
X-Google-Smtp-Source: ABdhPJwwvFGnYw3uAHthD+qeT9etauYz/2pT3p2K7Ezuk3nMchb/JfxqdB7Qzzxqwt5g/U/v3PwRBw==
X-Received: by 2002:a63:5f54:: with SMTP id t81mr1734132pgb.283.1617720637262;
        Tue, 06 Apr 2021 07:50:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o1sm2855226pjp.4.2021.04.06.07.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:50:37 -0700 (PDT)
Message-ID: <606c753d.1c69fb81.1a08a.7873@mx.google.com>
Date:   Tue, 06 Apr 2021 07:50:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc6-37-gcf66fa75745a0
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 89 runs,
 1 regressions (v5.12-rc6-37-gcf66fa75745a0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 89 runs, 1 regressions (v5.12-rc6-37-gcf66fa75745a0)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
6-37-gcf66fa75745a0/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc6-37-gcf66fa75745a0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      cf66fa75745a0b1237bc54340c8148170dc63edc =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/606c6e63023da47c73dac6bf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc6-37-gcf66f=
a75745a0/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc6-37-gcf66f=
a75745a0/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/606c6e63023da47c73dac=
6c0
        failing since 5 days (last pass: v5.12-rc5-47-g506a524e05e2, first =
fail: v5.12-rc5-47-g85f34ae663986) =

 =20
