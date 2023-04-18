Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4856E6E20
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 23:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjDRV0b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 17:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRV0a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 17:26:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B9A253
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 14:26:21 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w1so5310132plg.6
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 14:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681853180; x=1684445180;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+s3EMqZAeyfOHYoph3seGkEJzZXej12XSlXLHkkYBNw=;
        b=MM/90q9iXuzAGW3/dYvSO/bJkysM3aWDt7nP6GOyHsMN/S3wSENGfUPx9cTDREvyEt
         voXoH+wWQVX3cvhy67QeEfiFem/zBQ/aZCB2BNM7P/JSRv2iWfGce3p8dOvYhru2EaNG
         oEBtk85cMBooy2Kosr3XHdI2kk9Hvdv5vvkq7GHc8yQWNuxporWIvx32aqW34VB7jok4
         U1rHrcIiZDBIPORFQ/Xs/AI6A/Jhh8eWUhNrnHpongbKrn7/x0+2IkCYD8V6pDEWdx5S
         /FxCxCdpz2Yzy5EBrgS1D7qa1ysQh2UPoxMgb5CVxQuJ7Dqio3SIWWxlJxMlnSHiQeP/
         cC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853180; x=1684445180;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+s3EMqZAeyfOHYoph3seGkEJzZXej12XSlXLHkkYBNw=;
        b=QP+unJRROqQIey98yZojWZEWo8sNa9BtwSN5LpGd1FRzQ6gKLno1FTNWI0snODETjM
         19EDpvfZFH/T9snAQeEziCi8Fv8K+Errg/LZW0JnY+XbITSPsSaHlrohdzTg3ZfkWOR4
         50HbNRaWFmhPJc2F2TPXZ61u1SFhMBgvOaAecOuT5UDMAMfDPqqUikkYG/7WLwuyGsso
         sO/Uf72m8251/3IpbZkTNfVN/zM/WDaQjgacM6xle1dSOHtQYWx40KYhf6IqH6QWKYQQ
         hmXvv9IQADZaMP+RNzvEGACqr4JI1VZwwBBvSgbqXXe+pYb0No9xqIE8uBY7cn7A7lcX
         uUrg==
X-Gm-Message-State: AAQBX9e79dsA++skzMnlujkEaSbYYtzrTQ8W2yltVCdAlDuZ8s7xzyfH
        r9jO98lR5qgJlX7KEjohWaMl+aBmTqwNcoFNrjWUCtTm
X-Google-Smtp-Source: AKy350Z4LXhQHYuLOq2sow/Zp7GTEltU/bkT4+JBlnIeBLgHXTK0wA67HMeNy6TBmqdwWzHXw8uiNA==
X-Received: by 2002:a05:6a20:3946:b0:ef:b472:ccb6 with SMTP id r6-20020a056a20394600b000efb472ccb6mr1220960pzg.39.1681853180500;
        Tue, 18 Apr 2023 14:26:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a15-20020a63d20f000000b0051b7e3546acsm6834015pgg.22.2023.04.18.14.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:26:20 -0700 (PDT)
Message-ID: <643f0afc.630a0220.9fec2.edd3@mx.google.com>
Date:   Tue, 18 Apr 2023 14:26:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc7-158-ga55dbec19157
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 43 runs,
 2 regressions (v6.3-rc7-158-ga55dbec19157)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 43 runs, 2 regressions (v6.3-rc7-158-ga55dbec19157)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc7=
-158-ga55dbec19157/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc7-158-ga55dbec19157
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a55dbec19157d83e21eb1b8f0cf5a8195d405005 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/643eff2a2284d354342e85f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc7-158-ga55db=
ec19157/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc7-158-ga55db=
ec19157/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643eff2a2284d354342e85f7
        failing since 81 days (last pass: v6.1-rc8-156-g0a9e32afe717, first=
 fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-04-18T20:35:30.388592  + set +x
    2023-04-18T20:35:30.388841  [   13.056920] <LAVA_SIGNAL_ENDRUN 0_dmesg =
930137_1.5.2.3.1>
    2023-04-18T20:35:30.495994  / # #
    2023-04-18T20:35:30.597809  export SHELL=3D/bin/sh
    2023-04-18T20:35:30.598285  #
    2023-04-18T20:35:30.699683  / # export SHELL=3D/bin/sh. /lava-930137/en=
vironment
    2023-04-18T20:35:30.700152  =

    2023-04-18T20:35:30.801462  / # . /lava-930137/environment/lava-930137/=
bin/lava-test-runner /lava-930137/1
    2023-04-18T20:35:30.802104  =

    2023-04-18T20:35:30.805186  / # /lava-930137/bin/lava-test-runner /lava=
-930137/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/643f0212b255d1cd042e8622

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc7-158-ga55db=
ec19157/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc7-158-ga55db=
ec19157/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/643f0212b255d1cd042e8=
623
        failing since 0 day (last pass: v6.3-rc6-135-g5235219c59f8, first f=
ail: v6.3-rc7-153-gbc538c8be4bd) =

 =20
