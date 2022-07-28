Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631D95848D4
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jul 2022 01:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiG1Xzf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 19:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiG1Xzb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 19:55:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504DB4D4C9
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 16:55:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b22so3124478plz.9
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 16:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=V4JJ8D1mNpH7TUOrQsYKVN1S9b+SoKDW1YIMVleEZuw=;
        b=CF1ZrvmuP7/bys6CLyiUtxiw+FFXlSLYDBsJ3v7ANXICCcbgHTLW0v586fkh4orx4i
         LSuo9OZMRaDDfTei19LysBBJHiI2qnNXE096u09j6UcTlq4nGi2yMaraK9amkeagvvXJ
         34sYMr7kCaFoejnbHbTf7OPHV+B8PO72d6/EjNiLGzKKlqXqGZdVgjqYiJuNYcuDNum3
         k3NCwVTsxchhZssOGJ0retYaiNn4BITNml3yu0r1kTcg10VJNAo2zMQeNuQhfkwx/81i
         odHBmzxjwRn4hCYgOGOAl5yMDSC/x2+CWOWnWXUMFwiXWrrVogs7MADXfhXXjh++r4V8
         NJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=V4JJ8D1mNpH7TUOrQsYKVN1S9b+SoKDW1YIMVleEZuw=;
        b=KG67VvFpKxO26iXglPRbJVhB3AtgTvjjfyX2rtu8qF5KyNv4WSVhqTxaUTs3bii9wo
         uEop3c1MjZofG7uqSyW86yZ9jn8oBtFfROevCuSZHvzMFNcGUqv3SxxTYyVwOW4hmL4j
         N+qDPLQdkPw12p/9AclJrfwGqjJqphPNq4m6ZKAymvb4qgYXv/TDAVar/dJbHoJ7VTok
         CCuAdTSUrDg6EdwDY65UHqwYXJwbia/a8L8FYf8erlqVhcNju3u/LmXJzduxfcV3Mdae
         USBMMKm5i/TIjtgHiGfgYfd/8kKhZTkZgW4u49qwG16x0o2UEmqjfvvN4zi1mIK2+X5A
         gI4Q==
X-Gm-Message-State: ACgBeo1DIDoF0vbQjxvtWLJnRyE1fRwe2DRhExhSsHWobumwo/e6970N
        EqUUFfeqvJNcy9rLFEoKaWNQjJkLe+lSE3z5
X-Google-Smtp-Source: AA6agR5/TgUshYevffgkhpMowPf0rTUbhxFuKOwsUjRIAtqD5YX8LEKDfoXvWq3NV2+T3o184/PjLg==
X-Received: by 2002:a17:90a:fc2:b0:1f3:20d0:2e47 with SMTP id 60-20020a17090a0fc200b001f320d02e47mr1111783pjz.117.1659052529645;
        Thu, 28 Jul 2022 16:55:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902a3cb00b0016d4f05eb95sm1878263plb.272.2022.07.28.16.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 16:55:29 -0700 (PDT)
Message-ID: <62e321f1.170a0220.c6a9b.2bbf@mx.google.com>
Date:   Thu, 28 Jul 2022 16:55:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc8-92-ge240a33f1bc48
Subject: pm/testing baseline: 61 runs,
 2 regressions (v5.19-rc8-92-ge240a33f1bc48)
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

pm/testing baseline: 61 runs, 2 regressions (v5.19-rc8-92-ge240a33f1bc48)

Regressions Summary
-------------------

platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =

kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.19-rc=
8-92-ge240a33f1bc48/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc8-92-ge240a33f1bc48
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e240a33f1bc480e5ff7a39d07ab3ba0c8ed34df8 =



Test Regressions
---------------- =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62e3194090c8ad73a2daf098

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc8-92-ge240a=
33f1bc48/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico=
-hobbit.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc8-92-ge240a=
33f1bc48/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico=
-hobbit.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62e3194090c8ad73a2daf=
099
        new failure (last pass: v5.19-rc8-79-gb3f10ca8bf191) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/62e3168ed1bc447ea8daf071

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc8-92-ge240a=
33f1bc48/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc8-92-ge240a=
33f1bc48/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
e3168ed1bc447ea8daf07a
        failing since 51 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-07-28T23:06:38.436667  /lava-146501/1/../bin/lava-test-case
    2022-07-28T23:06:38.437016  <8>[   14.677092] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-07-28T23:06:38.437261  /lava-146501/1/../bin/lava-test-case
    2022-07-28T23:06:38.437494  <8>[   14.693060] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-07-28T23:06:38.437728  /lava-146501/1/../bin/lava-test-case
    2022-07-28T23:06:38.437952  <8>[   14.708625] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-07-28T23:06:38.438172  /lava-146501/1/../bin/lava-test-case   =

 =20
