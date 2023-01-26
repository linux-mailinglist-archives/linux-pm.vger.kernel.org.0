Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699F667D85D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jan 2023 23:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjAZW2Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 17:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjAZW2Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 17:28:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2A45F5E
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 14:28:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso3127221pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 14:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hYOrwvdc7Hotzja5IDCRBea1xbXdEvsi5f2eaoG3JHA=;
        b=5f6HtlRklZeBTuVt61lE4yPVIIlX+8iy8N7pce4xB1iMLwrCPKmtgWDxSpV1+urYA4
         uKUR2Prk3rZSU7l6sgTGZTBa74QnIEMuNY5vPGBBFZjJYeGvYZ6XervT78CansnNcVi2
         TwzVToQBNABlJVoMlcrQ2WTu+0S3AbpQHgOSbbzNSfXWsK01Pl2O2Gbh48TyeI4vdK+f
         hoxcgeoYCIwfWoEhAIHFb725WR3zVOYl76CwQcXFHu6MYQAm6AytyJ4BOc4e9rvFXCa0
         KTBrOW0d4P0rkauas2XBgiYJQZ7S4R+6HJeW6BQ77MhP2uJJNTQjZpudu6qcTbrYU2AZ
         QiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYOrwvdc7Hotzja5IDCRBea1xbXdEvsi5f2eaoG3JHA=;
        b=K0Ddrt7UFKF93+PqpLYfwcYUbvOIQ8IW5Py6Va4K0V4+YQmall9sp7ZC1bXgeGsbhA
         JpQxbzsG62KOSq8RYaaewuHApeUE1r4W8U6avKkyXjjLZeIqjzades+O0edYWVoJwczN
         LjcQtSIo4GeiPKQjpgGIzI/A0Hr4C9RjJsfLEc8MEc6t6505JpjzOy2TCmvJtVFcf7u3
         ftORfKIe6Gg+2Vsy6JkUqSI6drMZyX3ugY6ron9UUPAB2w34WZXINn4rgJFPFZ7Y5CDZ
         iFXlcdcwNsUMg83JFX7lXx1RsZsrjCLUOBWiS9yVP1gLrM4XrD3qeRi69n6WoH3zgeua
         si6A==
X-Gm-Message-State: AO0yUKVvjfYATwFd7wa+P/whFEbIoUHwxEMd7mkEI4mbAKAT0p+5Y7J0
        cUUF09igaJ8IUofEKBTN90qgzklXc6KL5f3cCIvieA==
X-Google-Smtp-Source: AK7set8NxrqsiVDAPtalL/4i3HY5EG4FH4anRmxqDbBG+zTzOe3UnG92aiQf3j0wqUK/0gwWo7vFlw==
X-Received: by 2002:a17:902:ecc8:b0:196:3e2c:4753 with SMTP id a8-20020a170902ecc800b001963e2c4753mr4952853plh.55.1674772102810;
        Thu, 26 Jan 2023 14:28:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db8500b00186b3c3e2dasm1457070pld.155.2023.01.26.14.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:28:22 -0800 (PST)
Message-ID: <63d2fe86.170a0220.f788e.298f@mx.google.com>
Date:   Thu, 26 Jan 2023 14:28:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-141-g0bb04b623f4c
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 86 runs,
 2 regressions (v6.2-rc5-141-g0bb04b623f4c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 86 runs, 2 regressions (v6.2-rc5-141-g0bb04b623f4c)

Regressions Summary
-------------------

platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
cubietruck                   | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc5=
-141-g0bb04b623f4c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc5-141-g0bb04b623f4c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      0bb04b623f4c836a9df3199616369010dbf5ce17 =



Test Regressions
---------------- =



platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
cubietruck                   | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d2f3d384c7481934915ed5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-141-g0bb04=
b623f4c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-141-g0bb04=
b623f4c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d2f3d384c7481934915eda
        failing since 7 days (last pass: v6.1-rc8-176-gcb06e36a6532, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-26T21:42:32.219732  <8>[   15.271100] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3220867_1.5.2.4.1>
    2023-01-26T21:42:32.331098  / # #
    2023-01-26T21:42:32.434394  export SHELL=3D/bin/sh
    2023-01-26T21:42:32.435277  #
    2023-01-26T21:42:32.537333  / # export SHELL=3D/bin/sh. /lava-3220867/e=
nvironment
    2023-01-26T21:42:32.538448  =

    2023-01-26T21:42:32.640802  / # . /lava-3220867/environment/lava-322086=
7/bin/lava-test-runner /lava-3220867/1
    2023-01-26T21:42:32.642428  =

    2023-01-26T21:42:32.647820  / # /lava-3220867/bin/lava-test-runner /lav=
a-3220867/1
    2023-01-26T21:42:32.745174  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d2f376181063802a915ee3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-141-g0bb04=
b623f4c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-141-g0bb04=
b623f4c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d2f376181063802a915ee8
        failing since 8 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-26T21:40:47.992808  / # #
    2023-01-26T21:40:48.094460  export SHELL=3D/bin/sh
    2023-01-26T21:40:48.094901  #
    2023-01-26T21:40:48.196265  / # export SHELL=3D/bin/sh. /lava-3220850/e=
nvironment
    2023-01-26T21:40:48.196658  =

    2023-01-26T21:40:48.298041  / # . /lava-3220850/environment/lava-322085=
0/bin/lava-test-runner /lava-3220850/1
    2023-01-26T21:40:48.298723  =

    2023-01-26T21:40:48.304204  / # /lava-3220850/bin/lava-test-runner /lav=
a-3220850/1
    2023-01-26T21:40:48.411954  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-26T21:40:48.412502  + cd /lava-3220850/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
