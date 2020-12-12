Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCDB2D83AC
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 01:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391865AbgLLA6J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 19:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391213AbgLLA6G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 19:58:06 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0D0C0613CF
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 16:57:26 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id p4so8089477pfg.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 16:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yHKnAsbP8RdUa6JdUWBeFEeeqQE63fNIMADE2EgwWPI=;
        b=mPgWSXeGtmtdJUmV1/gNdC2AQTMY9l2pXkJdAC4KIjVOlyuc4qavj7VDJSVw0HWptj
         7V7MbUFTD7ECpdIIbsSCLXHktujFbccrJLHE6f56qWaefs0s/Mu8WdyQ3cCV+EBMzblX
         1sSRfroB53TCL5CBLBxv147mrUF4uteDxMjqDx5xaVhDZbnz0HfEy7MnOTCa6K8J3tKR
         v93z5Hs3Zi5grW2lgo+K+4GIBHVPzs7YIzcHqpc63H5AJITXd/oOpQiu5lUhUCBuh1Zw
         a/IyfjGhs/slMzELNbbaT5l5LY1+O9tORaL0kWHmVHX733JuvEUz3lniAygZ3SIiLid7
         GC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yHKnAsbP8RdUa6JdUWBeFEeeqQE63fNIMADE2EgwWPI=;
        b=Yf+yOq0myoiQJepp1bdQpjGICqcqioNfjHr3ZJ5+GIWnG+xSP/dy/QI0ar2ceZupej
         0TL4ebmoUlO9MSSnfXJel0QRX8gGUhZpZ1TSkS82q+AjlGd8T3FMNuKowcqpTs8NRwBC
         dwnHWKxAekL1WAiNi2Njt2EUr49t6ZAvx6CJuOHiaEij+p03D4FIUhlixysahR+J0tEb
         27eKMFJwg5eVcOFND/ReqfHP5sr3cF5X3ZxrO9/4oDoETiCfA4uLShj6D0Iu2QndM1BU
         Q2rQKx/lnIdrfcN0y+EphI1xb5NK15ehTU32FMBez/QyHQ/pVUz/j7gYErDvUBfyTcoh
         UDdQ==
X-Gm-Message-State: AOAM5323B6ER0Rln7qq+Er4ZpAF4BVoguK5irrt3VtkOEyt1TtLoq0gc
        JridxQxUzlEhyEWl4qVDpqDsVZD/kasOEw==
X-Google-Smtp-Source: ABdhPJxFGyfMa+axytNyVtDqe80df9LBtMwMwHIA9Ru6+IrB1JVUOE2TfXDGpWWw66k+r/jHZKf9ug==
X-Received: by 2002:a63:3111:: with SMTP id x17mr14317503pgx.329.1607734645727;
        Fri, 11 Dec 2020 16:57:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l23sm11460479pff.194.2020.12.11.16.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 16:57:25 -0800 (PST)
Message-ID: <5fd41575.1c69fb81.df8fd.626b@mx.google.com>
Date:   Fri, 11 Dec 2020 16:57:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-106-g97756044ce06
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 6 runs, 1 regressions (v5.10-rc7-106-g97756044ce06)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 1 regressions (v5.10-rc7-106-g97756044ce06)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
7-106-g97756044ce06/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc7-106-g97756044ce06
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      97756044ce0645570f22b356174ed0c811458ca7 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd4069ce29173c8c1c94cc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-106-g9775=
6044ce06/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-106-g9775=
6044ce06/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1130.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fd4069de29173c8c1c94cc4
        failing since 114 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
