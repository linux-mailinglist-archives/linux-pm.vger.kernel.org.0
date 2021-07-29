Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A923D9C04
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 05:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhG2DM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 23:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhG2DM6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 23:12:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE178C061757
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 20:12:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso13367132pjq.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 20:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1bWIH8NLKhH9BDb32fnZ/Wyc8xrtpVRhYC3hNhUd0mg=;
        b=VL/BcgqmzJn8JrPC+l18IJTRXw7pEzzy/9rBlq4Nz4Z6zdXQ4RuT6lnDEEG0OFmXxp
         rnQjQYWrXR3zHpNc4HUkmgnSma8A8tG2BGLVKhRFU4a6z1S3MmNXLbjxhnMJTFBBbAIa
         SPtK84t3Fq0NC0WW1ppuN5Q4ENnMPrebm+QnOJPIZABgP6pHOUNoSyMkBqfsrfiXqOYe
         3cAH+Hqiv+CS+MxECtX831kU40ya0I9jl/w66EgiWv7gf0vcgVsYqWBNVhIn6rE8+R2b
         4DBEa1nvMRxlcLsMNvAtt8LpI0tH+mICymGR95cira4IT3rZ6SHJtDeK3gCOunAyxzul
         tDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1bWIH8NLKhH9BDb32fnZ/Wyc8xrtpVRhYC3hNhUd0mg=;
        b=ej9g+RTOhzYqHdZrmNnKgxajD+aSL0zi2JzQ1LbXEmV1oBh23+XbkubOPDamLbLni/
         GWNbbb74O2NruD52fMV/kdtUZ2nQ+5Tbu0djrhIbD4RUAkTqT8KZHIwP66zVDhq4BC2o
         2RXzRGilR2Z8xJvfz0f+vRbsILpD2Jv/9jRZWCCAkWKuSTu7hOc0YBFXD3cOBn5dhQsh
         rF/dpq7roY4hOP3vsnlRGvJCUH95sMlCfXvHgBjv+5XViu2zCn9eVUsv7HnSmGWIFASj
         Z18cZ5bGCcT5NLRKaHnOM7B7Xe8N1luj4po75Eq1WSZh8K8dQ5oOVIpToSUp2e/Gelk3
         FUKg==
X-Gm-Message-State: AOAM531y8t9tttbZJm+W0NpttrlexZYD1NMuqbm/SlaK2GkfLC4ait84
        WMe4jko4Tw7yu/ilcykGGBrWQw==
X-Google-Smtp-Source: ABdhPJxgiA4Tvayihbv1CYSPNAsfPsj39n1ZmJsiaVhxIihCd8Et7DyHa4vkxQtyfCDtoYZ1emwMLw==
X-Received: by 2002:a17:90a:a390:: with SMTP id x16mr2991070pjp.136.1627528374261;
        Wed, 28 Jul 2021 20:12:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l11sm1462292pfd.187.2021.07.28.20.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:12:53 -0700 (PDT)
Message-ID: <61021cb5.1c69fb81.bc4b1.609a@mx.google.com>
Date:   Wed, 28 Jul 2021 20:12:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.14-rc3-20-g604483c9d252
Subject: pm/testing baseline: 94 runs,
 4 regressions (v5.14-rc3-20-g604483c9d252)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 94 runs, 4 regressions (v5.14-rc3-20-g604483c9d252)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
bcm2837-rpi-3-b  | arm64 | lab-baylibre  | gcc-8    | defconfig | 1        =
  =

hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 2        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
3-20-g604483c9d252/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc3-20-g604483c9d252
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      604483c9d25283debe498a972c2b4565581e3aaa =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
bcm2837-rpi-3-b  | arm64 | lab-baylibre  | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/61020e315db991b9115018cc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc3-20-g60448=
3c9d252/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc3-20-g60448=
3c9d252/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61020e315db991b911501=
8cd
        failing since 16 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/61020e2a568713115c5018e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc3-20-g60448=
3c9d252/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc3-20-g60448=
3c9d252/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61020e2a568713115c501=
8e4
        failing since 28 days (last pass: pm-5.13-rc8-159-g3304616e985f, fi=
rst fail: devprop-5.13-rc8-173-ge132b9a1079c) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 2        =
  =


  Details:     https://kernelci.org/test/plan/id/61020e75779e3374425019bd

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc3-20-g60448=
3c9d252/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc3-20-g60448=
3c9d252/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/61020e75779e3374425019c3
        failing since 16 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-07-29T02:11:53.219771  /lava-4273417/1/../bin/lava-test-case
    2021-07-29T02:11:53.231155  <8>[   52.314934] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/61020e75779e3374425019c4
        failing since 16 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-07-29T02:11:52.184832  /lava-4273417/1/../bin/lava-test-case
    2021-07-29T02:11:52.196141  <8>[   51.279893] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>   =

 =20
