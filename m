Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF7331D29
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 03:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhCICvL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 21:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhCICuy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 21:50:54 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16D4C06174A
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 18:50:54 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so4334180pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 18:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ipGCJtxy/EjLQ7QUQBjjvZuehu4dkwujoiOy0J8evn4=;
        b=Ai3EvZmBsKnZZ0PQmtj/SQGMZxvrcV3Zt/G13ZKC5bOROmmZk6ose92FzFFAW8PJvJ
         0jqqfdQarfyhny3kQo93+TXnWCqqNrqr6MObjOkGjc6NqAIpzkjNX/1PnMJzm3D0D21N
         LDyidOXbo0CRvlC6H/jca4K8BteRiM/V7SH4HAHd26qZ23vaH45vWnnFN3kBoWwB1owx
         5PgL7sbCMuLKJuK0RIBUBi50cOrjIIL9Grr2B4e1UGPuL6hUxQ+mNH7gs74yU7AcgRKX
         myQtHpeu6HXT9fUK7m31be7dnlp9MoHYNGMv28Rd5IX15f/+3aHtfgHTAkZ5g6SCyLzy
         OH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ipGCJtxy/EjLQ7QUQBjjvZuehu4dkwujoiOy0J8evn4=;
        b=GRJcdHQmNtM0+s1OFJG6si4ITdjkytiDaT0IF9Xtp5rQNGjcjAnolSRM58bhoxQaMR
         TJMmFVXKF9qHJ254sLHcdGm2EQiEsdnuNAME2Ol2AOGjgMQ/eHnD6uN1rN3CBnFLetx5
         4DSXwOqiMOJUlfo08jy3EzE736hOK2RWo5gfQ1NEAdUct+Gue13kAEwVArkM7Cunw9ad
         nq0swNtJrzeFwcD/sQzxj1pZYOhkzdCJSVJXSCbBpMqiKTNlyfmO6t3DmA65RoRLPspO
         JZeH0xA9ORd16xOAvxjsbkQtSuFoWFH+Xo3Ur0krlPvBXob8f23mNFdQEPcVJMkgJHRq
         JZVA==
X-Gm-Message-State: AOAM5316FVQsjf0otu7YLPjpLkRQLPKxzQIUPiYX8+lpBHITwNL6jkzc
        8hn/RbdUxZdI3OR4rA7gxD690A==
X-Google-Smtp-Source: ABdhPJywXWUH45wdnrbJd2IO7W+kQ/b/bNmmQHOyvBPGDfdAKB2uQMLO1KG3as0UGP11dCHQJXBKug==
X-Received: by 2002:a17:902:7444:b029:e4:30bf:8184 with SMTP id e4-20020a1709027444b02900e430bf8184mr1746196plt.45.1615258254057;
        Mon, 08 Mar 2021 18:50:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p17sm666377pjv.49.2021.03.08.18.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 18:50:53 -0800 (PST)
Message-ID: <6046e28d.1c69fb81.4e599.3386@mx.google.com>
Date:   Mon, 08 Mar 2021 18:50:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc2-18-gf15befeb2bc3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 56 runs,
 1 regressions (v5.12-rc2-18-gf15befeb2bc3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 56 runs, 1 regressions (v5.12-rc2-18-gf15befeb2bc3)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
2-18-gf15befeb2bc3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc2-18-gf15befeb2bc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f15befeb2bc3590b212cdec60241a25b78450bc4 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6046da58be3aa272c0addcb1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc2-18-gf15be=
feb2bc3/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc2-18-gf15be=
feb2bc3/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6046da58be3aa272c0add=
cb2
        failing since 17 days (last pass: pm-5.11-rc8-201-g8b72d3aa065c, fi=
rst fail: pm-5.11-rc8-205-g4475f0291af9) =

 =20
