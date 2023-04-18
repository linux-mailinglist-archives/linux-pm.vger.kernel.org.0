Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF46E5F57
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 13:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDRLHu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDRLHs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 07:07:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9C79023
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 04:07:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-246f856d751so1283698a91.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 04:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681816059; x=1684408059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zDmdnYkrRsVLcM/fIF2OxJcDEalGG6RopeRGnFvRntc=;
        b=VRpxTimAgMA56gLQ08ehSoedum/znkkhlByUD5h84MBsVKyG/yElvGEWdqiDnLcRtl
         6pk42sjIAs9nLDyFnFtFpJWd+YXAnyFhQrkUXprpWdiXphYeunthiJtJEgWfmqiAdPh2
         QrZn6L69g4XfpYGbbfIx0dqqQSyHhiLFDm1wmDJOCCKQ02KfvInvnwEYTzHAuBcVXUMZ
         CqMOuLDpKNm1CTSIg6ZbJAZ5w9l94VBxG2XdK/6NNUmE5N/YLo84KIaWHNat5NF8pbp9
         y2YgbwhG78kRzBms7cutK3lt7yELzK6xIgCuc4ivUq4UDumAPcSXOZ6ZnyTTw8hyMeli
         8TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681816059; x=1684408059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDmdnYkrRsVLcM/fIF2OxJcDEalGG6RopeRGnFvRntc=;
        b=YLqZMLBr6/Blyd4ZQzWStSr9dglkJ8BG/PwT8hdYTwYJdrf1qK8XIyjy1UIMAm6VJQ
         n5BpcROx9EXGHQPN2581XSOv2oMd9ek91u40hGkTYNwC7/fei5S6VMuBAYqtPSmffIB0
         YAmIHVCLLeXhF+YFatc4y6+0DqdYoU56zT9tLipTk1x07z8kt7uOJkEP/6nb/nK8ANeu
         t0+Jze5AojODKJRvMzRFPMxoho+AN1eQZIF62cjV2G/3jqzzkGkETm5EmfbbRWDBoXAI
         9WVgs/CPnQFNOeT+cYgdmSHRavEqQ2JeCXZPL/UCbkDKPcu2GHWd1CSR5WQwlnPShgz5
         Q1Yw==
X-Gm-Message-State: AAQBX9e23d89FV4yS1fRU7RGp4qYA3Iv7pkPFYN5/XvssBGK767PQ+V8
        kzws9yYp/JB2nJJ0y9MXGURIu+/WU8Kh5Jlwc5NE3uXQ
X-Google-Smtp-Source: AKy350bk2kE9DZ7peqM5TjNellA3JddUKi8e00P5pWDv+0U0J6Vakmn0h5LRpump9eDUd9YRWJ9gJw==
X-Received: by 2002:a17:90b:2251:b0:247:3c8e:dc1f with SMTP id hk17-20020a17090b225100b002473c8edc1fmr1636870pjb.19.1681816058820;
        Tue, 18 Apr 2023 04:07:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gw7-20020a17090b0a4700b002349608e80csm8519246pjb.47.2023.04.18.04.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 04:07:38 -0700 (PDT)
Message-ID: <643e79fa.170a0220.8b7bc.2c46@mx.google.com>
Date:   Tue, 18 Apr 2023 04:07:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc7-153-gbc538c8be4bd
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 43 runs,
 2 regressions (v6.3-rc7-153-gbc538c8be4bd)
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

pm/testing baseline: 43 runs, 2 regressions (v6.3-rc7-153-gbc538c8be4bd)

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
-153-gbc538c8be4bd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc7-153-gbc538c8be4bd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      bc538c8be4bd17479f88f2e1a78d5b76b5523319 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/643e6f034aa96f8ff92e8677

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc7-153-gbc538=
c8be4bd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc7-153-gbc538=
c8be4bd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643e6f034aa96f8ff92e867c
        failing since 80 days (last pass: v6.1-rc8-156-g0a9e32afe717, first=
 fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-04-18T10:20:30.175260  + set +x
    2023-04-18T10:20:30.175445  [   13.000201] <LAVA_SIGNAL_ENDRUN 0_dmesg =
928949_1.5.2.3.1>
    2023-04-18T10:20:30.283243  / # #
    2023-04-18T10:20:30.384753  export SHELL=3D/bin/sh
    2023-04-18T10:20:30.385168  #
    2023-04-18T10:20:30.486482  / # export SHELL=3D/bin/sh. /lava-928949/en=
vironment
    2023-04-18T10:20:30.486986  =

    2023-04-18T10:20:30.588379  / # . /lava-928949/environment/lava-928949/=
bin/lava-test-runner /lava-928949/1
    2023-04-18T10:20:30.589090  =

    2023-04-18T10:20:30.592868  / # /lava-928949/bin/lava-test-runner /lava=
-928949/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/643e70f338233e5ceb2e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc7-153-gbc538=
c8be4bd/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc7-153-gbc538=
c8be4bd/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/643e70f338233e5ceb2e8=
5f0
        new failure (last pass: v6.3-rc6-135-g5235219c59f8) =

 =20
