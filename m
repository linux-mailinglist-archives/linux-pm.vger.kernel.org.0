Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3893F5123
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhHWTT3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 15:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhHWTT3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 15:19:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D5CC061575
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 12:18:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u15so10723361plg.13
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 12:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VIUIGZ47yz6InDaqJphGsifxv5Zt2MTfKQAu2NpZkcQ=;
        b=qHOVgPNcoA2ngrjp21u5vF6v9M0husPsSf8TrDFLRRLAaJcdWUHAoeK2iwJgwVREyt
         afPqnJcy+tsfBgEDbmCljE4q1O3yEhs00Lbw3EG79HkmKrMjB+w2fEX3bEtUpGSSgBgr
         pAsmRsV+2zuUAQH75UldOSJG/K8z4OT+GXv5ljKfF5en0MYNAGe5J8V4LJXj/nmWK9Mt
         /tslM5+0P4Su0CFpmNpnqbvXD3y3tYqzkRdiBXuM3rJsdooo8fD+Agx9zciHCKw4SoY8
         TjZ1DA9IFsTJbZqcNQFcrZbMAwcOBhDC+vx7+KGtMmttDUCWfY9/uKWSVZW0ooQUJAXj
         EFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VIUIGZ47yz6InDaqJphGsifxv5Zt2MTfKQAu2NpZkcQ=;
        b=DXhdLHM7nziFShzNZTWYIX7Cy+zxgNA7WXM6eAs4SDZ7oNZrHcAQJQCcKuRNXxpIYO
         N5T3XyENaxMs3q+bfo2oYlWsm9Hptz+O8wg5Yr6S2M6ZHIHneZF+iUOty1EDRQgLs5eq
         IycL2On5zB7alkV+dPRwSpgdTQf5tpK3vbK0cncRsQd7kh/HxiQGLHaD7YoDVPon5v4r
         fDMZjXW7MPiNX6Nq+Fy1VV2pbVhd91rleQ6VsKIn4h0SpqQa1UhYe+2sGIdZE3K1fAiO
         xjRnabE6bkC79ojZ2UI5DhEZ1HzQcsQk7WPWq2D+dcF9UqS75iX5b4ZX6+2OuZZw1Xk3
         vwzg==
X-Gm-Message-State: AOAM530dqejd+G0vT7Yglek8ykI67Qw0PgV6bt64Fr9V44OMYnMHQ+Eh
        c/b2091PNCjnZD6WBFDPOavoMwj3S6MT+fkH
X-Google-Smtp-Source: ABdhPJzYpqQAhupVlmuggZVZ4lgUcutyXgvjwLW/1a7XDwzCV5bBjqoqJHZCou9DXmCqCUGBA8pGUg==
X-Received: by 2002:a17:90b:4c8b:: with SMTP id my11mr105220pjb.220.1629746325468;
        Mon, 23 Aug 2021 12:18:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g3sm19825562pgj.66.2021.08.23.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:18:45 -0700 (PDT)
Message-ID: <6123f495.1c69fb81.38cf5.a76d@mx.google.com>
Date:   Mon, 23 Aug 2021 12:18:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.14-rc7-50-gbd1cb9850313
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.14-rc7-50-gbd1cb9850313)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.14-rc7-50-gbd1cb9850313)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
7-50-gbd1cb9850313/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc7-50-gbd1cb9850313
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      bd1cb9850313a606390b4b21b9d07b2ca9ede9b1 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6123ea73fabe01537c8e2d00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc7-50-gbd1cb=
9850313/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6123ea73fabe01537c8e2d01
        failing since 369 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
