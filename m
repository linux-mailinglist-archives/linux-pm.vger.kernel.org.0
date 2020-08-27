Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896582547B4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgH0Ox3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgH0OxZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 10:53:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583F6C061264
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 07:53:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k18so3692478pfp.7
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7I0vg+HDkvC6tRwUcdh5SFwqOWSXsOmzdENn0ILneqs=;
        b=ILW1nyp0tBrR1qw2bcs5k0/AxJCD8J3Cev0GQAcV+hnqYrY2iw6RBqEttzM2DwbnJJ
         5Ho7GqtJiAQ87XE2sNSPez5vBFcrcCXYJuZuGOElS4pGJPXaz9YZUW1pO+9I/iuxGzch
         8tVsCtP2MuRRWAVTmPvat52qlplO9Y275FfaNqytNOCt5nx97hMPkrqb/He2g6nHW2cS
         TyeNi6PNURRFEtzpPVythxjmPkADaVnF3fEBAXMlgp6jmdr+LEIyCG1or23qOsBaUa1X
         Wm5vLb+lTe49tc87dE5pOlFryBLHPoY14tFHDLcj/2sr8onCPVQSAkfm3U41X52czZkK
         rBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7I0vg+HDkvC6tRwUcdh5SFwqOWSXsOmzdENn0ILneqs=;
        b=aqStZIrFybgecfncau8EwnveTSfRSlYkwFMrmUa91r4iNhiXE7JFLFSNhbWT+g654+
         h+HK/LhMiQHxU0uPHkwXnBXsjhPLcziYf5hbLyXf+gvfEA1u2EgnhPZu8X4NKS9p2cNP
         uBsx8pe2bcldljp6zHOXIjGNZA6VmRu8HrwX31u/24aSpAgqd0iKnn5SobBokRHvQAJP
         jSdZc0iQDZXuzoPWMUd8n75H+sWquBGrzLcYkgaTi6eatSFd8yRh5FYOrFCbCCsOc+Js
         jaUTILZLAzDwnrXXacT9o6An17K++AIVvNX0p8hdXFfaX4MDRqScvVVeVVC3xEWcqpjA
         zyHA==
X-Gm-Message-State: AOAM530DqGNzAppf+npziZ5e7yUtNag6v0T+kTcfy9Ytb/JoiNl0U9A4
        Ctfa2U5ONlVN7BUzkJ2rtWhcJw==
X-Google-Smtp-Source: ABdhPJypfzIjS5G5g1TZwOtxUbp30V6dId36psZ8uOiahC2VJF+zqiPIIOK43Ps8yCmYrmxsfUGOzg==
X-Received: by 2002:a17:902:bd8d:: with SMTP id q13mr16451706pls.142.1598540002911;
        Thu, 27 Aug 2020 07:53:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f3sm3040350pfj.206.2020.08.27.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:53:22 -0700 (PDT)
Message-ID: <5f47c8e2.1c69fb81.3b49e.87d4@mx.google.com>
Date:   Thu, 27 Aug 2020 07:53:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc2-17-gdc37b29f6d30
Subject: pm/testing sleep: 3 runs, 2 regressions (v5.9-rc2-17-gdc37b29f6d30)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 2 regressions (v5.9-rc2-17-gdc37b29f6d30)

Regressions Summary
-------------------

platform             | arch  | lab           | compiler | defconfig        =
  | results
---------------------+-------+---------------+----------+------------------=
--+--------
exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_defconfi=
g | 0/1    =

mt8173-elm-hana      | arm64 | lab-collabora | gcc-8    | defconfig        =
  | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc2=
-17-gdc37b29f6d30/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc2-17-gdc37b29f6d30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      dc37b29f6d3007e72ff3de80fcbeeed75843cfed =



Test Regressions
---------------- =



platform             | arch  | lab           | compiler | defconfig        =
  | results
---------------------+-------+---------------+----------+------------------=
--+--------
exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_defconfi=
g | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f47beaed26b330e789fb52c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu=
3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidxu=
3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0821.0/armhf/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f47beaed26b330e789fb52d
      failing since 6 days (last pass: v5.9-rc1-4-g1f08d51cd57f, first fail=
: v5.9-rc1-4-gcc15fd9892e2)  =



platform             | arch  | lab           | compiler | defconfig        =
  | results
---------------------+-------+---------------+----------+------------------=
--+--------
mt8173-elm-hana      | arm64 | lab-collabora | gcc-8    | defconfig        =
  | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f47bc2d7e62e1d73b9fb42f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-17-gdc37b2=
9f6d30/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0821.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f47bc2d7e62e1d73b9fb430
      failing since 7 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =20
