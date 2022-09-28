Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652875EE668
	for <lists+linux-pm@lfdr.de>; Wed, 28 Sep 2022 22:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiI1UFt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Sep 2022 16:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1UFs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2022 16:05:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AC25FDC2
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 13:05:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso3789990pjk.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=aeQL+pY2we55QXVCXh5tYT5UC+vN5YFjCOltVFeoLHw=;
        b=0pMgRoyElIVKRhPDKAUvWHsb7U/DWVrt3/Rua+WUH3fjJju8wCq69ZaDoEbFENPEMo
         AlP6VnagqUmD0QjHa8AEw3hnebItnD0eM/9/UftSXkyOm1uHSXrCve2/aLkyj486AfK6
         tdzhj3ioAEzV8Ew4GMlmcK7Pe5UHLkXbeEPLk1drlK572GiKH4r8vJC0OC11BzSmLgno
         nnd+UcIQG6JenJq3kyh81sZP7fiGYkMVsB2Ushfv2MokCy0Orx4hP58Ch2pLw+3lJXfy
         ym7ooMTuG2FKI1Jnw1W1vpXuDU4yMKZY5BZz3Ox3+JBftTavEqF1A8hgxf/ADjGRbwS4
         NGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=aeQL+pY2we55QXVCXh5tYT5UC+vN5YFjCOltVFeoLHw=;
        b=TDe3ERKoxuinWaiUaPhC2dal6+QT1BvqMXgvDOyCofbPndv6yfSNSwFXipD8ejGerQ
         KgLx9q/XqrRGMw7aAQsPLgRWrkIr/WKVAr6WOj4oOLkWA4I1rAV5FeaavExZri/LynW0
         JRewDea5LgERyd/hu6wPN7ePy/x1n28W7ABBkO/Ce8Ngorr6ts6X8U6FPNdgp6/dqLum
         4GlKibc0NlmdYXjpmzFtqlDq/Vlk/JhMA3bbJdro240QDN2PV1aL+4fmQ6dlHIwzunIo
         1yUSIzmEKeuqu6NT6KHw2r+95DCzVcZ3w5eIP9lI7/wFZyscPt6vUAU5BoOGK5wTcYMV
         5P3Q==
X-Gm-Message-State: ACrzQf1w4RgePwYzOhTMf1FUwnW97AyK1kRoCKE1RI2kzn6Suh1g1ct9
        IRPJ+pSqt66NNG2iSKtfYQJekw==
X-Google-Smtp-Source: AMsMyM7iMyrvfmOZeWPu9U1agB8ZmpkhXY+0PplWQXt13apmiPFsjuEc3Mp07RSB3tcqg1yriCp77w==
X-Received: by 2002:a17:902:e788:b0:179:d220:1f6a with SMTP id cp8-20020a170902e78800b00179d2201f6amr1360972plb.133.1664395547047;
        Wed, 28 Sep 2022 13:05:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x67-20020a636346000000b0043a1c0a0ab1sm4019012pgb.83.2022.09.28.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:05:46 -0700 (PDT)
Message-ID: <6334a91a.630a0220.dd4ff.7185@mx.google.com>
Date:   Wed, 28 Sep 2022 13:05:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.0-rc7-179-g530bc2b3f53f3
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 57 runs,
 1 regressions (v6.0-rc7-179-g530bc2b3f53f3)
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

pm/testing baseline: 57 runs, 1 regressions (v6.0-rc7-179-g530bc2b3f53f3)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.0-rc7=
-179-g530bc2b3f53f3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.0-rc7-179-g530bc2b3f53f3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      530bc2b3f53f310b78938352fa32d7c1b364d2dd =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/63349d18ed7a306d68ec4f70

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc7-179-g530bc=
2b3f53f3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc7-179-g530bc=
2b3f53f3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
349d18ed7a306d68ec4f7d
        failing since 113 days (last pass: v5.18-rc7-183-g45785e0ed597, fir=
st fail: v5.19-rc1-2-g6a8964e282382)

    2022-09-28T19:14:25.644594  /lava-175266/1/../bin/lava-test-case
    2022-09-28T19:14:25.644999  <8>[   17.956348] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-09-28T19:14:25.645259  /lava-175266/1/../bin/lava-test-case
    2022-09-28T19:14:25.645488  <8>[   17.973011] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>   =

 =20
