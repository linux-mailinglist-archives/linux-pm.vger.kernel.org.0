Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4800B21143D
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 22:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgGAUUj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 16:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGAUUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 16:20:39 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ADEC08C5C1
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 13:20:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so11286274pfu.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=LJu64tEXzAvZji0U5dRVKIQ9PgpPn9G6+Ng81qs2mgQ=;
        b=ayOdtNJluc5l90fyqahwbXVt0yyNo0xfK9jHYqfVRTZI7t7k0J7oYzISjLJT5vcdYl
         oHMGePYUlMQlBTmkgQ+aKuJxtCg5hxTY60XdP1RZk1DkSzDuxekAP4Jq7w2XPE+R2veH
         QKi5dRUzemxY/gaxr5HtZaY5F9G/cRYhfEDlERKx6AcbcKVPVw3Pn0avV6RxqbeaJVbz
         CMCdQd14Pxa1rQc7Pbgb68bCTwSjvarnwnwcoibruIHRx+BueNa7XJ+PxMhPSCT2Rhas
         V0Dph99K5pz2YcwHFdsKC9+81kr1uSCadiBD8aRkD+5KEua2IAwgzffQ9Onh59MboDnc
         jDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=LJu64tEXzAvZji0U5dRVKIQ9PgpPn9G6+Ng81qs2mgQ=;
        b=OR2VVuJ1RgArfxnlGTJm+ZWvU8Zdz2ZGqmF7kF2cN/ftXtWzjAupDOwxD/jzbloHa4
         lHrGCZQ1B0+3daicO4lY7NX0w1JkGkLyrTjBzkXuZ4JFdUgTiz5PQNET7E6Zaxougcin
         hbRjkJFbJR2Zl1Ro3lxsznStVZe4QOYYucB6jG8XoCS32KEPSTlB0O06ZEAuojEu/wqw
         6TeqqKM8RkaNPHDJPvI67wJ0WEVmZkf86el2LqwyK8a4hz1C3Nb1q2UXKpN8f3ijc/ig
         M0mwvlZBeMNr7nnf340S33q3AVP73veuPFgN5WN0X3j67b2JOFfmHr/9SIJzz7nLwqa2
         X7oA==
X-Gm-Message-State: AOAM533PowV2xPBtrpR1l/ERsaz3e8tcbJBOXhA2JxZSLx7zijNC+zXq
        y2FJXjd8wc+PS5JpuLWH2D7BDnHWxPI=
X-Google-Smtp-Source: ABdhPJyjlEYTdGflvi6WCcBUIJInyJIFhEr6jdDM4T834rM+xG37vxGV99aGWWzRhIzWAF03a7ZrlA==
X-Received: by 2002:a65:63ca:: with SMTP id n10mr21843428pgv.252.1593634838467;
        Wed, 01 Jul 2020 13:20:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gg12sm1648658pjb.48.2020.07.01.13.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 13:20:37 -0700 (PDT)
Message-ID: <5efcf015.1c69fb81.a03a9.381c@mx.google.com>
Date:   Wed, 01 Jul 2020 13:20:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc3-33-gdb1041095755
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 58 runs,
 1 regressions (v5.8-rc3-33-gdb1041095755)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 58 runs, 1 regressions (v5.8-rc3-33-gdb1041095755)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc3=
-33-gdb1041095755/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc3-33-gdb1041095755
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      db104109575551b9d477167284d674fd31047baf =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5efce61ffdf107612285bb3f

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc3-33-gdb1041=
095755/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc3-33-gdb1041=
095755/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5efce620fdf10761=
2285bb42
      failing since 2 days (last pass: v5.8-rc2-27-g3168a010c528, first fai=
l: v5.8-rc3-20-g4ebdb176f4ab)
      2 lines =20
