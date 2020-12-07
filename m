Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D88C2D147D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 16:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgLGPOT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 10:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGPOT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 10:14:19 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334C9C061793
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 07:13:39 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l23so7624173pjg.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 07:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2P4ubLZqiZby9eo7uK3XkAZ8iDln/RpgCSdwMxU4gTw=;
        b=daKy0osk2zM/BC2p+v7kvr89NIQmZdzX1gCibelN0ZsLtP92buWQzl1VEGW+PwliVh
         P9x7Px23iOZzvOLxhST3I8stgGwpoI31hIMHCf+kxdLUCbUChdjMtZRBRkPIn/MlKppC
         Z//IicRolfz7iK5nhYvSMdUWFtJA77g8dk4v3H86TjF7/mjSe17FKCCnYzPPjTq1aT9B
         DGUdt48eBO5aiQQk0IjsMT9pUlVkA4RUVuU6l7FAsw3KWubJSDcYj7M56TrD9+7b3/0s
         1nQSTOClNkb9mbd/zyxdW7f/Uuv0DlSFexuHGXjZxXdq7UYRbaSef4u6iuVv1AXGCjA9
         Fu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2P4ubLZqiZby9eo7uK3XkAZ8iDln/RpgCSdwMxU4gTw=;
        b=s7qwMudZ3olQOKSTdpNQDW1fq3o7qYHk/uqcXOWEnEdfSDepleq1HV1pFYud7lHbRI
         KrK9JgXp3QM8cqhr1yNYqpJO7ksjVcFUGWkbl7R26AviNB/Y23FVszTIHpwLxahXJe46
         3ChP5+DvRo4PeaLaNxiGShVGoQkW0b2bfQh4PCE6lcerHm/eer7Trf1AwPrBK/joFsn+
         lPHjoG/0gazbTlqPFy1Y52mEcRtMPCcjm61kS2dKWMfC2fbIxK13DljFps/595yRHQOV
         Yb1hPW7+m7qP4XvGRtqRbwDrJUxzBli9TrFjG7q9lpAlMO/jdJAXx2VOQMYAbNjpR8p5
         q11w==
X-Gm-Message-State: AOAM531VGFavhTfZ0yDLU9VKx7ezkOuhWwatquAVJAlsbwXiGCoRE0j2
        n+o6fb8P7MZvIoodrTyRnMUr8A==
X-Google-Smtp-Source: ABdhPJzuAeWAkVkkeFg7zYMcTAIs+cbLPO2pv4BukdCU/NAWg1bC20rWZ/ubSRL2f9XOtaHmu4gGZA==
X-Received: by 2002:a17:90a:fd08:: with SMTP id cv8mr16556523pjb.29.1607354018725;
        Mon, 07 Dec 2020 07:13:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b17sm14607933pfi.61.2020.12.07.07.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 07:13:38 -0800 (PST)
Message-ID: <5fce46a2.1c69fb81.40ba.1ef3@mx.google.com>
Date:   Mon, 07 Dec 2020 07:13:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-87-g960e625edeb5
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 131 runs,
 1 regressions (v5.10-rc7-87-g960e625edeb5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 131 runs, 1 regressions (v5.10-rc7-87-g960e625edeb5)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
7-87-g960e625edeb5/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc7-87-g960e625edeb5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      960e625edeb5932009c1e687adae37447fdf69d8 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fce3e448ccfc7d4cbc94cd7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-87-g960e6=
25edeb5/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-87-g960e6=
25edeb5/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fce3e448ccfc7d4cbc94=
cd8
        new failure (last pass: v5.10-rc6-90-gc35cc6e0cf05) =

 =20
