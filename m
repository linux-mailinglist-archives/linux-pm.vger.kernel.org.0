Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65202D14B8
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 16:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgLGP3S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 10:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgLGP3S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 10:29:18 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F161C061794
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 07:28:38 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i3so6735912pfd.6
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 07:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qccMIqYlcHhY1Sbe+AWZcXAJHG+DqEolLVJWlfOBzTM=;
        b=RoL+4bz4WHUHcUgxx9K6oP0XGAZ9aR3RfMGQjRkogjS9nrSfZgcxFPUlbdKkWG1TzZ
         swKppy885Xp9MwY/Jd4QCKp9n+bJHhQPRTYrIZKq2J8b9GG/xfzz1dc4sRCbenl8VYRC
         Xt9euFHSlm48OawgMZlgkQAwuFod7v1FHIhKBU7RY1iWv3UIplrqqNbIlSFzO/lBfoKA
         dGYZFLGHWoL9ht6phg/hfNjF6X/8j/zKq1rRiaMbgXMIpJKcO1yAk52u5nRzUzWLuLM9
         khZynbUz+unVkT5aoxohplIAzo3NjjEtWrGx3sMfR6I5mmmJakS8dhwA6GfNoZ0/8Bj6
         7vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qccMIqYlcHhY1Sbe+AWZcXAJHG+DqEolLVJWlfOBzTM=;
        b=iXAdO8KdrsnjWOpF5qDlXrAI3MgtE6O3GHJZcS+IUVs4+iUpT2SEgVgCY3XvIwAiJc
         qke3hLAGCyIgzVzlj8a5BcApTq+pid4z/4w+FvB/twovG55WWpYy75Wa2OIAprXbAB0i
         5t3fqL19CiXfMlnO+Dxe2gVwYW4lF+By13d2RxQ2YQQoebeyJNClOyAi1gkjHao/W1hh
         i7+iK96/Zr56E55AGkrFsmz/A8o8vmt8XC33dsHMlowt0yz/s/bZFIrmo1X/gzsZmdwP
         bjQLeqW1JkIOo87i1A/lkrY5O870VmBfjdq+UcEuao5Iityx0uluZbmmf6DybsGq9i6D
         PY1w==
X-Gm-Message-State: AOAM532PZQcVx+uBNMpFKCwcij71xr+GaM/uZVv86UcDCljMKf8S7/Qf
        rLN8tN5h1S6fL6Kf37kWPNEACQ==
X-Google-Smtp-Source: ABdhPJzq2fHfenhY8u19joiSMEaX8d1RjgcsTwOQpguzdcxRKYyYUwh8CFu/14B3LQ62S+hVOd+O+w==
X-Received: by 2002:a63:7f03:: with SMTP id a3mr18664451pgd.313.1607354918068;
        Mon, 07 Dec 2020 07:28:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g9sm12713993pgk.73.2020.12.07.07.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 07:28:37 -0800 (PST)
Message-ID: <5fce4a25.1c69fb81.b7f41.c4b2@mx.google.com>
Date:   Mon, 07 Dec 2020 07:28:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-87-g960e625edeb5
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 8 runs, 2 regressions (v5.10-rc7-87-g960e625edeb5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 8 runs, 2 regressions (v5.10-rc7-87-g960e625edeb5)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
7-87-g960e625edeb5/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc7-87-g960e625edeb5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      960e625edeb5932009c1e687adae37447fdf69d8 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/5fce3dcf8a3547805dc94cb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-87-g960e6=
25edeb5/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-87-g960e6=
25edeb5/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1130.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fce3dcf8a3547805dc94cba
        failing since 109 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/5fce3e298ccfc7d4cbc94cb9

  Results:     11 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-87-g960e6=
25edeb5/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-87-g960e6=
25edeb5/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1130.0/arm64/rootfs.cpio.gz =



  * sleep.rtcwake-mem-4: https://kernelci.org/test/case/id/5fce3e298ccfc7d4=
cbc94cbf
        new failure (last pass: v5.10-rc6-90-gc35cc6e0cf05)

    2020-12-07 14:32:40.133000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Mon Dec  7 13:49:57 2020
    2020-12-07 14:32:40.147000+00:00  <6>[   26.406630] PM: suspend entry (=
deep)
    2020-12-07 14:32:40.159000+00:00  <6>[   26.417518] Filesystems sync: 0=
.000 seconds
    2020-12-07 14:32:40.178000+00:00  <6>[   26.431672] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2020-12-07 14:32:40.184000+00:00  <6>[   26.443962] OOM killer disabled.
    2020-12-07 14:32:40.198000+00:00  <6>[   26.451508] Freezing remaining =
freezable tasks ... (elapsed 0.001 seconds) done.
    2020-12-07 14:32:40.210000+00:00  <6>[   26.465490] printk: Suspending =
console(s) (use no_console_suspend to debug)
    2020-12-07 14:32:46.875000+00:00  =15=00=00<3>[   27.080526] mwifiex_pc=
ie 0000:01:00.0: adapter is not valid
    2020-12-07 14:32:46.887000+00:00  <6>[   27.293391] Disabling non-boot =
CPUs ...
    2020-12-07 14:32:46.898000+00:00  <5>[   27.293905] CPU1: shutdown =

    ... (46 line(s) more)  =

 =20
