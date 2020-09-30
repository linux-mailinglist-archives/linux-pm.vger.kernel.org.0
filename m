Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA327F25D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgI3TNB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 15:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3TNB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 15:13:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5048C061755
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 12:13:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t18so1598833plo.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 12:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Pr5+K2OmnHgHQ0BOfHck1nEaWy6m0y2UD2KTqORUOuE=;
        b=Ei5Ls/UpxUsp73heN21iXt9T30S3s/wPI6xuEQM74LGks6tLkM+HOJWRjykuqMJnqR
         6ALQqcJKU+iH6ljI93hzX4t1AdIuwyPD411D1Ol05wJEBazU0t6TX9bRQ+FxuDQUenQC
         Yrz8U9GBdEHRtc8wyznPa+poUZm2OHypIEAf6+QQ68DNPOwny9s+EOn2wI9aKsTl9kNS
         23QxnQwX1Pf2HzKOdP7RLkB7hFLEoFLnYg2dvid8AzULrxCqNRcpvkXADyvp2GGiK6aY
         bQpNim4Z7EAnVvBEcRFnf7vfw3Bj67JAT7+4mCc6OIp3puNc1W24ZsnKFS0YdQEven1b
         jShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Pr5+K2OmnHgHQ0BOfHck1nEaWy6m0y2UD2KTqORUOuE=;
        b=oinoUgdAQUoaZIxe+5HIYQfW6S5K80W8wzap0jjcUsnMmveniOX2lkKsQSO4gZZR39
         fdA7WCPuBLAxNSSCSkINc4IgLeri23MBPyznwSG5PuzL+BfuJya3KDIEfj89XEiF2khv
         DxlRscEmFPwqnPQV9Pz1DI20WTGPyn1pcKl1OFXiB8avrH/idt3DgxGdcgrbsajrWZkG
         2XOreRT9WHbhVXnbfWNrr0WKG7y0synvqWHnaB1n9QaKwZd1UdCsIRbcm6yNZ1595SkD
         +uHIoevyKMhUlqyGSoN5lRW7+oJp6+NxNDbz1kWc/YTwKKumoxnGAvHczFCbs6yNfT8Q
         vI7Q==
X-Gm-Message-State: AOAM5303jzjgrAwYObte5XSpb1NtOyJJsABvf8j4TzT8kHoUwnIMoL9t
        w7UNgHdUJjqLdxbU1J0keeGoRA==
X-Google-Smtp-Source: ABdhPJxXS2FVZf0LNKl7AqakJ09sMsG2jatodSIJMEWHp5BDyY2m7YK5yf/VG7OTs6NhLh0Gb4NErA==
X-Received: by 2002:a17:902:b107:b029:d2:ab87:c418 with SMTP id q7-20020a170902b107b02900d2ab87c418mr4057618plr.40.1601493181127;
        Wed, 30 Sep 2020 12:13:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u4sm3185381pfk.166.2020.09.30.12.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 12:13:00 -0700 (PDT)
Message-ID: <5f74d8bc.1c69fb81.17537.6313@mx.google.com>
Date:   Wed, 30 Sep 2020 12:13:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc7-75-g027a0d093137
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 6 runs, 2 regressions (v5.9-rc7-75-g027a0d093137)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 2 regressions (v5.9-rc7-75-g027a0d093137)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc7=
-75-g027a0d093137/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc7-75-g027a0d093137
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      027a0d093137cac9655d241a1ace1b36ed1f455d =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f74cb8c3cc29680988771f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc7-75-g027a0d=
093137/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc7-75-g027a0d=
093137/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0925.2/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f74cb8c3cc29680988771f1
      failing since 42 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =



platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f74cdb5a3a0202d53877169

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc7-75-g027a0d=
093137/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc7-75-g027a0d=
093137/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0925.2/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f74cdb5a3a0202d5387716a
      failing since 1 day (last pass: v5.9-rc6-48-g537658447367, first fail=
: v5.9-rc7-68-geb6335b68ce3)  =20
