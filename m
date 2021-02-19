Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103BE31FF73
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 20:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBSTaC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 14:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSTaB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 14:30:01 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B37BC061574
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 11:29:21 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id z68so5457814pgz.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 11:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7TQeA7uTgcDQlj8AekUua+ukeumSCBBaz/TuLxktWDE=;
        b=V00RnSKANMZFbfqw/K/TPe/bAMsl8tH7ebTX66JptRtHxvZaqC7WM5GpN4nHiO5IBX
         XMFipV9oGPNZS/ecrq9xi1zzXaTTbqTirWLJPUipJkP59CsmRgBuxSesT9+HwGt+1CP2
         3UfA3gmqKRc/d2az4/hI3WOSE9xFfuZ9mtMcYFDjRTgD2QR3wyJTg9VidlEiktq/c4pC
         0kPr+ju0SgaVvm9EGtPl7LNM0+9yOSSa607/+S2vWuIXHBpex9+YL7LNXQhCIRJEKv9t
         ZwSFSjox3gKFQ6CpmssRMG7esbphX7g4jv6XDhc5nbMK17U/DqTKM84jv2Y9cVqFooxT
         MFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7TQeA7uTgcDQlj8AekUua+ukeumSCBBaz/TuLxktWDE=;
        b=N90KxbTASTNEUqQFDaaZALVTXEux8q5xj/z+JniVWlIiX6mg39IvW5Bi2gcuObsZAu
         OdVx1a4oYpHmw42gndyV7yhK4qiW7MTpEThhndo3WJiZkdQSCZWgUldM1BCq5zDThovs
         08yVqO9tBKVGGgA0zrj65V/saj9xQWbJ+fDqavuhut/1n/ls3ZGH0uixylCXV4J6j3SD
         nBs3CoHczmsGziUoLxnKEgC3llDn42DJEdRPguuXCXz4lWrdxt67XeIKACfTU2otKhGS
         dukDv4Zz/OEFepL+QMJfdqOU8tPjzthuS4FJwhn6cEe6aPBUL8zSmAiYAXya3hNW59hb
         L+iQ==
X-Gm-Message-State: AOAM531le6r30eL6uzftvzj/4L/Wz9T1a/oE4GWLdNgOlZpExnK4oZF2
        dgY9W30+6VofV2NHw2zBidpIUw==
X-Google-Smtp-Source: ABdhPJyZWfnGBP/X+6b2o0nWefy3Tn+fYlyT3tQu1hoSwQikrMo9N9gporuh/TRvMQFFU4wQX+G5Kg==
X-Received: by 2002:a63:686:: with SMTP id 128mr9751861pgg.421.1613762960931;
        Fri, 19 Feb 2021 11:29:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z15sm2760570pjq.53.2021.02.19.11.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 11:29:20 -0800 (PST)
Message-ID: <60301190.1c69fb81.119b1.566e@mx.google.com>
Date:   Fri, 19 Feb 2021 11:29:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-5.11-rc8-205-g4475f0291af9
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 68 runs,
 1 regressions (pm-5.11-rc8-205-g4475f0291af9)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 68 runs, 1 regressions (pm-5.11-rc8-205-g4475f0291af9)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.11-=
rc8-205-g4475f0291af9/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-5.11-rc8-205-g4475f0291af9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4475f0291af9a9a16535123a859e154e35ad2277 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6030091b992e987d70addcb1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-205-g44=
75f0291af9/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-205-g44=
75f0291af9/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6030091b992e987d70add=
cb2
        new failure (last pass: pm-5.11-rc8-201-g8b72d3aa065c) =

 =20
