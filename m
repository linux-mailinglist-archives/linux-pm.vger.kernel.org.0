Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A078A621C91
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 19:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKHS6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Nov 2022 13:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKHS5k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2022 13:57:40 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747C6A68C
        for <linux-pm@vger.kernel.org>; Tue,  8 Nov 2022 10:57:39 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r18so14148281pgr.12
        for <linux-pm@vger.kernel.org>; Tue, 08 Nov 2022 10:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RlwmNCRYb3gMwTEj1BBBI+YWu12iStqTkBWtpSRcVq0=;
        b=rfcqlUGhKAfL2oi8EGnT4mJ+DKaC6gEK4bCPFvj74KHm0HruhAwIOvb+av347/ImKp
         zueAJOTwTt9I09k10OPZvSf6D1pzMf7wle/P0yzupwtKd2LwuTXX5WIRnE5/ZhqDX7HX
         wN8xZs3MBbcwtvYsSmKa7UCNd/4aEYY8r7DiIuLDkaIpFmHq1IFQIRiCNxbOV6jrJHbS
         Kw3Mw55un3wuYnGIfuzP9LVrjkO6zr73VSOHVK1/yKhjqT+diyrNDAuZTqaCCWQ2O+h9
         /Y7OLaGc16xAHTjR3Gl7Ulco2NNMOuEZAtAXGe81ZMJxdXCU24sonBpJkP5HviikYAI0
         fS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlwmNCRYb3gMwTEj1BBBI+YWu12iStqTkBWtpSRcVq0=;
        b=DFfKmUNB8ECXQKIrEvqFhc4csXn5CQJzqHc9z6kwdTiUU8dJKgk2y3UnpDRbhthKYR
         heLkfMu+pGpX0cKmzghMxeTRBEKfCmVDAekh/elYjjO5F0VZRs81XxCQtCOSsw0z2bd4
         cTnwMDGKZD8p++Y6U5DGXZAoHifeCgp5o8Oja2XBtDqLCFaafNb+ynyy4VHrWqC8GUnZ
         XFwM4WamPSGXMEvld/1SJ4idxPxP7mCDarQxr69y44XnN+3GmjLMeoalu3Q0vRl4k0ig
         nTJfWB9COGmKGAvYYxCY//AHmYBvTUMMc/WjW2+nzCQrb4/G3gLFCHzAHLry8MxbIiaJ
         MCCw==
X-Gm-Message-State: ACrzQf0O3iQxHmpH3tjyzE7xcDlQSL08dbqAel8vEa6GIjYYxtYFm6Uy
        hTaEcHefl3e6X1K6CDVzU8HYx7Iw2qMS1pQQ
X-Google-Smtp-Source: AMsMyM4HFnlPKJkGz4y+dBqMVa2pSMZa+Od2OwY9pY7BDZ8hmNOBV0dlN66Ho5U+datHEyq0HM3l9Q==
X-Received: by 2002:a63:90c2:0:b0:46f:5e42:4eeb with SMTP id a185-20020a6390c2000000b0046f5e424eebmr48111475pge.268.1667933859087;
        Tue, 08 Nov 2022 10:57:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b00186b945c0d1sm7355763plj.2.2022.11.08.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:57:38 -0800 (PST)
Message-ID: <636aa6a2.170a0220.dd04.c2de@mx.google.com>
Date:   Tue, 08 Nov 2022 10:57:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc4-48-gfd856f9c4ef3
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 72 runs,
 3 regressions (v6.1-rc4-48-gfd856f9c4ef3)
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

pm/testing baseline: 72 runs, 3 regressions (v6.1-rc4-48-gfd856f9c4ef3)

Regressions Summary
-------------------

platform              | arch | lab             | compiler | defconfig      =
    | regressions
----------------------+------+-----------------+----------+----------------=
----+------------
at91-sama5d4_xplained | arm  | lab-baylibre    | gcc-10   | multi_v7_defcon=
fig | 1          =

imx6ul-pico-hobbit    | arm  | lab-pengutronix | gcc-10   | multi_v7_defcon=
fig | 1          =

imx7ulp-evk           | arm  | lab-nxp         | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc4=
-48-gfd856f9c4ef3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc4-48-gfd856f9c4ef3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fd856f9c4ef381398466a06b3480549368d90e2d =



Test Regressions
---------------- =



platform              | arch | lab             | compiler | defconfig      =
    | regressions
----------------------+------+-----------------+----------+----------------=
----+------------
at91-sama5d4_xplained | arm  | lab-baylibre    | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/636a9f182cac9c30b7e7dba5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc4-48-gfd856f=
9c4ef3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xpl=
ained.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc4-48-gfd856f=
9c4ef3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xpl=
ained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636a9f182cac9c30b7e7d=
ba6
        new failure (last pass: pm-6.0-rc7-143-g00674ddf1b594) =

 =



platform              | arch | lab             | compiler | defconfig      =
    | regressions
----------------------+------+-----------------+----------+----------------=
----+------------
imx6ul-pico-hobbit    | arm  | lab-pengutronix | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/636a9e0fb61ac6be86e7db4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc4-48-gfd856f=
9c4ef3/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-h=
obbit.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc4-48-gfd856f=
9c4ef3/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-h=
obbit.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636a9e0fb61ac6be86e7d=
b4f
        failing since 102 days (last pass: v5.19-rc8-79-gb3f10ca8bf191, fir=
st fail: v5.19-rc8-92-ge240a33f1bc48) =

 =



platform              | arch | lab             | compiler | defconfig      =
    | regressions
----------------------+------+-----------------+----------+----------------=
----+------------
imx7ulp-evk           | arm  | lab-nxp         | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/636a9d9dd2a53097aee7db76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc4-48-gfd856f=
9c4ef3/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc4-48-gfd856f=
9c4ef3/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636a9d9dd2a53097aee7d=
b77
        failing since 39 days (last pass: pm-6.0-rc7-143-g00674ddf1b594, fi=
rst fail: v6.0-rc7-186-gfa11712315997) =

 =20
