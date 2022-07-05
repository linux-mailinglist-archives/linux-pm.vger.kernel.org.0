Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287DF567A63
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 00:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiGEWvY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 18:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiGEWvK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 18:51:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CB51E3C1
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 15:49:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l12so6824944plk.13
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 15:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rW7YJx+Jyr0hMBioBIAAA0tsQzE1vCtR28ls3o4tiwc=;
        b=UnCjRiMFwD9RyQQkdO/XlrjqS2TJVJEU4sPzAshRGFe3ddZksIfc8YqT+wXvIJsdh+
         Jsu++XNnBeEvBR2M5G6Gwv16ev9kfn3j52HBn2sNiFOJ5806SsGhjt3mtJrJaCa/Raz7
         YF7ZclFVwQHQBpbp66WW4yXPzMg2Fb3oMcpA8r3lAWUxuAPb8qEMe7AQFA8dgGcnwn9i
         9spYxk0yoPPJBz1lPLRs9Hoz0eRhBJb7LgZIixVPtk0J3/4g1zQbufha649HBfVxaX7f
         Rhz0WvPuhZxaBmq1TfrVcVVega8jFDMeksR22aTbFqo0mFkJTyqFmqQbet4MR3mOcoFx
         wqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rW7YJx+Jyr0hMBioBIAAA0tsQzE1vCtR28ls3o4tiwc=;
        b=kssEHwUoanY049EyEX+6ZLWFxTsMcf25thrN6gMdaHXWiYuG4tppLA+OXh3CokCs++
         RFT5HJ2WG54Ba5BPkI59xEfQ40AumAYnbXLr8kYx+dSBoygkP0COKtO/9MQzMtE2HvwW
         sGJgQlZO7KCWLjAkTWBM0LrWCyYFumg69PuoBPAnAjc0Ea8UM5s7faHOQSudeChDDbCX
         sLAWhJdkTs5HWLsTwQ4sUM2/KRnmHN1GeZmFo6BAHUxZxEMoNcGQiEE8cdSLPtKe4SFd
         7livdzY1LREhJopwYU6f/6mTCYfbKjwDpvLFdn36QObsfjA/v3a1vHdntabGH2YAdWAl
         mU/g==
X-Gm-Message-State: AJIora/Ar/4wwPlw37BP9+HH0r11vA8Dw6eJyrnUR6jYFNat3sdqlFPP
        I6TBoWVQuyjptBiNcnoS7iA3Pg==
X-Google-Smtp-Source: AGRyM1uJ1Onm4/TB1TQgUtRX3Rz7vpysmgOOyoaRia9I90JmGv0Ydy/lgZlQlzLtQKsGuSrxR2fU6A==
X-Received: by 2002:a17:90b:2384:b0:1ef:8506:374e with SMTP id mr4-20020a17090b238400b001ef8506374emr17504953pjb.99.1657061399207;
        Tue, 05 Jul 2022 15:49:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709028ec600b001638a171558sm23933150plo.202.2022.07.05.15.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 15:49:58 -0700 (PDT)
Message-ID: <62c4c016.1c69fb81.717e9.2bc8@mx.google.com>
Date:   Tue, 05 Jul 2022 15:49:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc5-50-g3bc028d913bd
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 91 runs,
 4 regressions (v5.19-rc5-50-g3bc028d913bd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 91 runs, 4 regressions (v5.19-rc5-50-g3bc028d913bd)

Regressions Summary
-------------------

platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =

jetson-tk1            | arm   | lab-baylibre    | gcc-10   | multi_v7_defco=
nfig | 1          =

kontron-bl-imx8mm     | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =

kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.19-rc=
5-50-g3bc028d913bd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc5-50-g3bc028d913bd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3bc028d913bd352d8ba9e4b371e7e1303457bfe3 =



Test Regressions
---------------- =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62c4b6773147a6bcb7a39c1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc5-50-g3bc02=
8d913bd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-=
hobbit.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc5-50-g3bc02=
8d913bd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-=
hobbit.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c4b6773147a6bcb7a39=
c20
        failing since 28 days (last pass: thermal-5.16-rc5-48-gf1f42573b6f3=
, first fail: v5.19-rc1-2-g6a8964e282382) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
jetson-tk1            | arm   | lab-baylibre    | gcc-10   | multi_v7_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62c4b6e325345c6beca39c09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc5-50-g3bc02=
8d913bd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc5-50-g3bc02=
8d913bd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c4b6e325345c6beca39=
c0a
        failing since 6 days (last pass: v5.19-rc4-36-g4035647418c1, first =
fail: v5.19-rc4-35-g06cab9aecb43) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
kontron-bl-imx8mm     | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/62c4b683d3fb415e00a39cdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc5-50-g3bc02=
8d913bd/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-bl-imx8mm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc5-50-g3bc02=
8d913bd/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-bl-imx8mm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c4b683d3fb415e00a39=
ce0
        new failure (last pass: v5.19-rc4-63-g5a03ffb415cc) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/62c4b56bf057aa3f8fa39bf9

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc5-50-g3bc02=
8d913bd/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc5-50-g3bc02=
8d913bd/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
c4b56bf057aa3f8fa39c06
        failing since 28 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-07-05T22:04:16.201847  /lava-136942/1/../bin/lava-test-case
    2022-07-05T22:04:16.202143  <8>[   18.887406] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =

 =20
