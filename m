Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE623D67DB
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 22:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhGZTY7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 15:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhGZTY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 15:24:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A73C061757
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 13:05:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso622122pjb.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rKiIqxEUcST6ZB3h/g1Ujr4Rr1a7Xkm6yyMRsNVl09s=;
        b=OaxuTfud20vC9OoC1niKEOOG8tIL6QBXa2wTVgLvLKqtZVNJp+XcrXIPNHQM24bb6T
         iEinTG8iF9uP5HB2NGbZXtKInJboiXiFUeNV9wgecT0tLuXQPwMqcyEMFQBbakJGsKZl
         azQBc92lMubUBasU6bTnLNxQym7IKe5Tgs3+jXIrQXL+kzsmEmjefcdLwZau4QNx4fno
         jpER5+Q/7OUaECA91anNjCcMuw43PG2Sb1yuT5559b0MFhSALZFMYnr6eu0IMRcWjaat
         KiU/dhXaONs83xqX/0sxETkFGeIVXaYO7eiAtPxzcDs8YJgy8tZZvp29dHsV6Dg63lZ3
         CwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rKiIqxEUcST6ZB3h/g1Ujr4Rr1a7Xkm6yyMRsNVl09s=;
        b=o3kcMJepOweHFrIlvDNRICQa7v84tIEc7gb83Ht7H6RGyBd0jU+otzcvJIIvgZOlYn
         b9cINHLMyVnawoOqQFzD0Lym37T0c/Ty9KVB2B3gzNrJOGYQKTBLZRHpv0S3f/o4g5Xl
         PT6bTRU9CDKRORm9gi8YvHrYuJHdmO/R7hgLMmto29LPpakTuA3aoMu2YLctbYvjGn6r
         rqdf1JSnPZMGHfK/C4vkv3ppKqx6kR/1hiwgjNZu4HyEn4uTX2BFjkJJ/xoz8qaJGc8b
         nxfhsfbyiNUsavpjXv75LceDf77v1E/ZHgC9e8CuDCzZlpCCh2NPgvv/9jrOQ0U2PYIv
         CPdg==
X-Gm-Message-State: AOAM531XezIomP9w97lIQMPCGgovrThAS6HOxac87w1R7XLMM5zlX89P
        DLQAWjkS7yBrVnogJ/agTM+DOg==
X-Google-Smtp-Source: ABdhPJy2nlsUY0k9FGhF8eoFELnxChtGBLaYpLPUntxM2vW3pBQ/01ur0fydQXVVbkEGzSARFiX7rg==
X-Received: by 2002:a63:5446:: with SMTP id e6mr19603172pgm.73.1627329927132;
        Mon, 26 Jul 2021 13:05:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e4sm602708pgi.94.2021.07.26.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 13:05:26 -0700 (PDT)
Message-ID: <60ff1586.1c69fb81.a1854.2aab@mx.google.com>
Date:   Mon, 26 Jul 2021 13:05:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.14-rc3-16-g1dae4a65c011
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 94 runs,
 3 regressions (v5.14-rc3-16-g1dae4a65c011)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 94 runs, 3 regressions (v5.14-rc3-16-g1dae4a65c011)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
bcm2837-rpi-3-b       | arm64 | lab-baylibre | gcc-8    | defconfig        =
  | 1          =

beagle-xm             | arm   | lab-baylibre | gcc-8    | multi_v7_defconfi=
g | 1          =

kontron-kbox-a-230-ls | arm64 | lab-kontron  | gcc-8    | defconfig        =
  | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
3-16-g1dae4a65c011/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc3-16-g1dae4a65c011
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1dae4a65c01109508ee17281b6d92b734d7bc1f3 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
bcm2837-rpi-3-b       | arm64 | lab-baylibre | gcc-8    | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/60ff0ec881427cd2a63a2f45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc3-16-g1dae4=
a65c011/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc3-16-g1dae4=
a65c011/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60ff0ec881427cd2a63a2=
f46
        failing since 13 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1) =

 =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
beagle-xm             | arm   | lab-baylibre | gcc-8    | multi_v7_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/60ff0c23655b7acd1c3a2f22

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc3-16-g1dae4=
a65c011/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc3-16-g1dae4=
a65c011/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60ff0c23655b7acd1c3a2=
f23
        failing since 6 days (last pass: v5.14-rc1, first fail: v5.14-rc2-1=
7-gd713e0c833987) =

 =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
kontron-kbox-a-230-ls | arm64 | lab-kontron  | gcc-8    | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/60ff10123830d2da183a2f85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc3-16-g1dae4=
a65c011/arm64/defconfig/gcc-8/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc3-16-g1dae4=
a65c011/arm64/defconfig/gcc-8/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60ff10123830d2da183a2=
f86
        failing since 13 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1) =

 =20
