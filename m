Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B44732A298
	for <lists+linux-pm@lfdr.de>; Tue,  2 Mar 2021 15:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349453AbhCBILU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 03:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380265AbhCBBtn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 20:49:43 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E035C061756
        for <linux-pm@vger.kernel.org>; Mon,  1 Mar 2021 17:49:02 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s7so3884227plg.5
        for <linux-pm@vger.kernel.org>; Mon, 01 Mar 2021 17:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5wVGbrM45QLg578XHG+6omwUbClW54zsa5tr083F52I=;
        b=L0WNO+vevHxqDeNxLzwdHENem/4PIJsW46j1Z5TDrjXkFfe1P1x3+vywUW8nTdq/pP
         /X1x3rshhd3VNKZ3KhEws8MEkTVtaK+vonYbhvOCy5WoittvRN1EFFOUyIvBTWZt18sk
         JLQnHxHYQE5YTdC9dwWLbO9jegqIj41qjCMtB3/CubooXCboEL8HRMlGfWsvoR/OWmH5
         okhZutFNitURGzBsl4H6yIgFnnGiv7SgkNIf0bCV9rvC56sV3URA4s0ae0qPvJsku0m1
         4CS+v1NRbi71kLernpgMcHwF36iztMoztXRv4i621lvd1L+jJMCCiG5twx70d28jvXzO
         5TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5wVGbrM45QLg578XHG+6omwUbClW54zsa5tr083F52I=;
        b=SH5N4wQK3bBEQQ9ZfW+DdTGikCf98xRE8rR1wsx1I9SPnsJiIZHxhIw1wNrEzDS04k
         2NETuP+9UJS088uLW3C2RW0kQVIBbpw6fHwWehiyAvx11eTd9N/Ao0t0Ijt/SCogh6wS
         0r4Vj4RRYgb7p5+L2ACRNsNOrJAfJ8M4KUdDmyNDzNRsGSVfMCRsQsI4SsN8pdRADfGu
         Cx+fybqGGPsSONqqiBUmIpGeZJgzlp3GWsqtFLoBr05l+hfkUCOHtX4tXGeuqQaP+rQm
         Q2fVxhRWcfEoZ8gPA4DUGncPDvhnDHeBt+kOCJ4EzLVW9mMb5BG/Dl349c2gBmSj+c7t
         aYWw==
X-Gm-Message-State: AOAM531iUpmXTKeYsNRoiRmtXcHPP8E2g3eongABgPAgVvzWPLA8kh54
        xERA/Bp051Q1v/mSvd3ePiwaRw==
X-Google-Smtp-Source: ABdhPJyJHhiS4G3U5KgshvcZESQbkli5AMYuCGQjHO0OxKXhfJtSoWq+YYM/uo4HqHCPV5vSLAcy5g==
X-Received: by 2002:a17:902:edcb:b029:df:cce5:1105 with SMTP id q11-20020a170902edcbb02900dfcce51105mr1372741plk.2.1614649742167;
        Mon, 01 Mar 2021 17:49:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p7sm17225115pgg.2.2021.03.01.17.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 17:49:01 -0800 (PST)
Message-ID: <603d998d.1c69fb81.7608c.8a7f@mx.google.com>
Date:   Mon, 01 Mar 2021 17:49:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc1
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 60 runs, 1 regressions (v5.12-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 60 runs, 1 regressions (v5.12-rc1)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
1/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/603d90c93e3164f2cdaddcbe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc1/arm64/def=
config/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc1/arm64/def=
config/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/603d90c93e3164f2cdadd=
cbf
        failing since 10 days (last pass: pm-5.11-rc8-201-g8b72d3aa065c, fi=
rst fail: pm-5.11-rc8-205-g4475f0291af9) =

 =20
