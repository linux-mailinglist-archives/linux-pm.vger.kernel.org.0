Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11B423AE73
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 22:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgHCUxC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 16:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgHCUxB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 16:53:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1029C06174A
        for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2020 13:53:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u10so12099334plr.7
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2020 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=d7DJeeuLqdzCrvS+aMg05SNU2tORebF8Prtp+sYJDRQ=;
        b=PK+rhV2uYy+U3p3Sp0ijKntIlX936C+VNjbZc2pmmSmnVS/pGYIShI0XQWDNF8jKca
         VRQXGmCNXw2TKB8JOB2tZ+hmsQ1ldpLg55jZwFedTRvDLPGlLky1x3QE1F5/OOgLs+x7
         GWQy3o+5Wb/gYCXgQ/P7w/h8YmhrMyZYBeTEKxq4O4l0ouNCn3YV3N4IsZvvm7Y/camr
         ZQMgpSR4921Ebi1YvkHzCFPz+WV/Fc15J88pPj6EAErtJNs9iofTI03g8+dupxnlGwGE
         l1jCjIL/oe9FYHdYAsw8JrvmPASBb70afje/9JRbYx5i0+87Ekncr7ONr+JkVtFu0VvR
         Qn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=d7DJeeuLqdzCrvS+aMg05SNU2tORebF8Prtp+sYJDRQ=;
        b=InmIsipNECGs65ZJY43r8THxG1gRnT0ltTqEXeZXx3hYlNzmwCrHZDy5ZEytxIigZy
         1monw3xFdt5kRCqe/c1e7yNFjzOvFKzNvlQuCuMyutBmaR92xwYPYDhhRwZN1dpDV0eo
         rP2zmeU79Lz3rbzvviiVQ2R/OQsBnGvzgwIVRFjOKoXCWmgFumyLXWptGsbjr4TzM2hy
         nsPripcUS4aZaE3Mo9rL0AERKpiQuVwYlg6dQwpSVy98wAC/FFgf3vsj4S8l5rinWK/l
         MVWR8ODujZAdppm3cr/NebxwYIIejhlVD8I6OnEkZGR3UgmuZwMZX3K8og5MBWeE7x8r
         54gg==
X-Gm-Message-State: AOAM530wTCqoUr1cYq/4JG3Nr7pIibsbNUvoBPlMOkuaMm2qi14u6OkU
        h+PNL+Ut4Woa+8aS6fd7aiMezg==
X-Google-Smtp-Source: ABdhPJyjZ0/hDfDBJrQHN38YGKsZbqh+9M+ukSSZW77204pN8Q3l50mVgU2ZpbxMeAgbOv6xbWWn+g==
X-Received: by 2002:a17:90a:c781:: with SMTP id gn1mr984503pjb.151.1596487981360;
        Mon, 03 Aug 2020 13:53:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t187sm19776842pgb.76.2020.08.03.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:53:00 -0700 (PDT)
Message-ID: <5f28792c.1c69fb81.a6e6b.f5e4@mx.google.com>
Date:   Mon, 03 Aug 2020 13:53:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.8-107-gb72b3ea38c81
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 119 runs, 1 regressions (v5.8-107-gb72b3ea38c81)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 119 runs, 1 regressions (v5.8-107-gb72b3ea38c81)

Regressions Summary
-------------------

platform             | arch | lab           | compiler | defconfig         =
 | results
---------------------+------+---------------+----------+-------------------=
-+--------
exynos5422-odroidxu3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
 | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-107=
-gb72b3ea38c81/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-107-gb72b3ea38c81
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      b72b3ea38c81d6f9585d8e47c6cfa70efa383698 =



Test Regressions
---------------- =



platform             | arch | lab           | compiler | defconfig         =
 | results
---------------------+------+---------------+----------+-------------------=
-+--------
exynos5422-odroidxu3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
 | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f2875c05eae56462e52c1e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-107-gb72b3ea38=
c81/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odroidxu=
3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-107-gb72b3ea38=
c81/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odroidxu=
3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f2875c05eae56462e52c=
1e9
      failing since 3 days (last pass: v5.8-rc7-94-g89beac5dc8d0, first fai=
l: v5.8-rc7-107-g97987ea7f86a) =20
