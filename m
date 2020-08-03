Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715E823AF77
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 23:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgHCVIB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 17:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgHCVIB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 17:08:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD8C06174A
        for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2020 14:08:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o1so21643917plk.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2020 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=losNbT+2TsuE/SwCe/xJyWOmYSsUNE+BCtbKafaS2Vc=;
        b=kbQc1FC4Ki++9S+45oBgVaSW1lDpOJTi6fNUcKT0nYS1wG1JyVF2BXU6kixqE1VYkn
         qaAR/kh/qWc/rB0zfQD1KI0oAE/YuOmx0ehi7+CVduZvtD+7q9p6PrmbSaAgEt/FOL3M
         3jXfqyGJkYvyjXnBJvSqHMS5cuDM2gpHF4hSEvgo6yUlAU5shxURd1yyFYvLdjrmJrW0
         1Ime/5OJiRXJ+m/Utr7ra++8qr7QDYJYCCDoPWfouKXaIikcKyt6YOC3XiYokupBPN6h
         Dxo+CuKKeFcf4PpjlhfwaauWtoSZo8NrVDAkSVM60P3GMPG5wvR7/xdFpkeeIunfu6Nv
         N/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=losNbT+2TsuE/SwCe/xJyWOmYSsUNE+BCtbKafaS2Vc=;
        b=HdQS46nMRZvq4DrulGrK2k/WQKZOjVQLoUboHDPtE7mS+2QqwEPV54NG8tJlgcJPAB
         z40Ren8NBhdyT8EIRf7M4qtaloNmHOWSdgf5E8eLhV8gO/8VxlmKBvwdISTXCt+FPm0K
         sbuEzqPvbCiAl0HZKJvlcL4AaStengKF4R7NawGYiKmO2EZGYRc108Gu7aHRpg9TxuNC
         fqvLcwY1ysYzVvG9Mebc1oPScBkNTinJtHaIng1L7OZd9k7W0tFWRpvYXaAW8uhMcUO9
         J8zGiXpvmopUfYFPDYbLN7vf0ikE6+5Xjo8XzTZhIxGD2g2Q+x4TA43XeywX7MF8FqiL
         9BCQ==
X-Gm-Message-State: AOAM531QQLJygVRrKF/NeSKxl4GbcPVXDN5BKLhWOoy+7SZj0ENEZd/D
        Nlm1qLj6XMo2aFMfFw+10+TDZg==
X-Google-Smtp-Source: ABdhPJxpotACMJMMWC9iTdWpZ+zsXJp1fxm1x3R7nViPK/V6r9qancdhDZhuZNmdhAFgsXf4kwpWhw==
X-Received: by 2002:a17:90a:e57:: with SMTP id p23mr1097801pja.164.1596488880969;
        Mon, 03 Aug 2020 14:08:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a10sm20561911pfk.26.2020.08.03.14.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:08:00 -0700 (PDT)
Message-ID: <5f287cb0.1c69fb81.cc6d8.44ab@mx.google.com>
Date:   Mon, 03 Aug 2020 14:08:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.8-107-gb72b3ea38c81
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 8 runs, 1 regressions (v5.8-107-gb72b3ea38c81)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 8 runs, 1 regressions (v5.8-107-gb72b3ea38c81)

Regressions Summary
-------------------

platform             | arch | lab           | compiler | defconfig         =
 | results
---------------------+------+---------------+----------+-------------------=
-+--------
exynos5422-odroidxu3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
 | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-107=
-gb72b3ea38c81/plan/sleep/

  Test:     sleep
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


  Details:     https://kernelci.org/test/plan/id/5f28732bbb3bdc998a52c1c2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-107-gb72b3ea38=
c81/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu3.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-107-gb72b3ea38=
c81/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu3.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0729.0/armhf/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f28732bbb3bdc998a52c1c3
      failing since 3 days (last pass: v5.8-rc7-94-g89beac5dc8d0, first fai=
l: v5.8-rc7-107-g97987ea7f86a) =20
