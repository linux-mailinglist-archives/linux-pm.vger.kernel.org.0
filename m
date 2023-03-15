Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514256BBFBB
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 23:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCOWZs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 18:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCOWZs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 18:25:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640B9CBE2
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 15:25:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a2so21672181plm.4
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 15:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678919146;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p2ZYU2v5GYkrmOWJ43g2nEMeMKumhv2q7JluSLEdTxc=;
        b=THHW0EoLnk35+KqgBV1U+aB0FcVgJdiBiO3U6KGLBtbmHt2i91EwOj+wu/ihZUlMkb
         +38Ka3dYY/vCVlYJKGy0yiM7Sv1ymfb4hXjgZuxJJTcIcOoTCV9GWiAXyhWZ7xm7C88g
         jFYyQVgpmFWGMlVGPP89yvTYMLuePBk1iWBUyZpqpoi7VwDaOdr6XmDWQv++zRv58fA7
         B6DNMpkzuTy+d2Xw4XM+tNwY2ulcuVvoRyB+KMM1oEXUB3PIeathIvGZV8EXnI+saVrd
         s7PVm+sEgClIxsnTfukvgYDgTI7YJ0PrrVeeIkV8F0S3X+XQZSSR8a/LXZ138mpXDSG8
         99Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678919146;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2ZYU2v5GYkrmOWJ43g2nEMeMKumhv2q7JluSLEdTxc=;
        b=1lgXBZoZSeH6FCgbDzFVUoJsvQWTCkaKS8ksUCkLuwopN5ieB7xD6aF7O4lYz36iMg
         /EdaMewzAd8eJfTHlr1D3HSoMK40QVoBl5AMWcp1WItAdtqfBE8C12+sYal8/kFZsYzn
         kSRyOOiJyTvAif9P+O/1AHBvOWxQDxALjWLnRJIsi1TWvYnX4uqrH96E69C4ynrj1gMq
         DTZbXiEbDj9ita9jkgij3Zy48e3UscZ2U3GlJQnK1BFThJSLCP/pplsAIg0jLFPp5Xl4
         j6gh6qrOkpDBiZDBPQp3K5pTCqWJ9McYSmpNnzp1ZdkbCG2wq6devMe+ikos6+bKLxOX
         NX8g==
X-Gm-Message-State: AO0yUKVAxsRPnomBv6Gmz69b+CHriZh4vsyHpctB/N5ZNer35oseziQG
        JoNVQpJL+dhT7qQa5YY3xC5qa2c4fO6VJNLOyjotkQ==
X-Google-Smtp-Source: AK7set+L9H052Fd87yPBBUArvEtfQOKfTOrk3cw2yjBnibBF5AtHunyhASqJWOJHbIwiuuVrxK5Fgg==
X-Received: by 2002:a05:6a20:7f9a:b0:d0:36d5:cf1f with SMTP id d26-20020a056a207f9a00b000d036d5cf1fmr1294689pzj.5.1678919145869;
        Wed, 15 Mar 2023 15:25:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 36-20020a631064000000b00502f1540c4asm3801777pgq.81.2023.03.15.15.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:25:45 -0700 (PDT)
Message-ID: <641245e9.630a0220.7eb7b.87e9@mx.google.com>
Date:   Wed, 15 Mar 2023 15:25:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc2-33-g1240ce78c05e
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 46 runs,
 6 regressions (v6.3-rc2-33-g1240ce78c05e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 46 runs, 6 regressions (v6.3-rc2-33-g1240ce78c05e)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
fsl-lx2160a-rdb       | arm64 | lab-nxp     | gcc-10   | defconfig | 1     =
     =

kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc2=
-33-g1240ce78c05e/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc2-33-g1240ce78c05e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1240ce78c05e340f533341148739ee126219afcb =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
fsl-lx2160a-rdb       | arm64 | lab-nxp     | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/64123ba9aac68fd22d8c864c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc2-33-g1240ce=
78c05e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc2-33-g1240ce=
78c05e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64123ba9aac68fd22d8c8653
        new failure (last pass: v6.1-rc5-55-g60453df62d30)

    2023-03-15T21:41:41.645879  [   12.706424] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1174330_1.5.2.4.1>
    2023-03-15T21:41:41.751718  / # #
    2023-03-15T21:41:41.853608  export SHELL=3D/bin/sh
    2023-03-15T21:41:41.854179  #
    2023-03-15T21:41:41.955479  / # export SHELL=3D/bin/sh. /lava-1174330/e=
nvironment
    2023-03-15T21:41:41.956072  =

    2023-03-15T21:41:42.057580  / # . /lava-1174330/environment/lava-117433=
0/bin/lava-test-runner /lava-1174330/1
    2023-03-15T21:41:42.058558  =

    2023-03-15T21:41:42.060186  / # /lava-1174330/bin/lava-test-runner /lav=
a-1174330/1
    2023-03-15T21:41:42.086633  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =


  Details:     https://kernelci.org/test/plan/id/64123b05b3287614768c8648

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc2-33-g1240ce=
78c05e/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc2-33-g1240ce=
78c05e/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64123b05b3287614768c864f
        failing since 8 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-15T21:38:46.593931  / # #
    2023-03-15T21:38:46.695847  export SHELL=3D/bin/sh
    2023-03-15T21:38:46.696279  #
    2023-03-15T21:38:46.797712  / # export SHELL=3D/bin/sh. /lava-296305/en=
vironment
    2023-03-15T21:38:46.798136  =

    2023-03-15T21:38:46.899656  / # . /lava-296305/environment/lava-296305/=
bin/lava-test-runner /lava-296305/1
    2023-03-15T21:38:46.900393  =

    2023-03-15T21:38:46.906324  / # /lava-296305/bin/lava-test-runner /lava=
-296305/1
    2023-03-15T21:38:46.972261  + export 'TESTRUN_ID=3D1_bootrr'
    2023-03-15T21:38:46.972552  + <8>[   22.503881] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 296305_1.5.2.4.5> =

    ... (17 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/64123b05b3287614768c8653
        failing since 8 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-15T21:38:49.066393  /lava-296305/1/../bin/lava-test-case
    2023-03-15T21:38:49.066765  <8>[   24.609489] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2023-03-15T21:38:49.067007  /lava-296305/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/64=
123b06b3287614768c8655
        failing since 8 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-15T21:38:50.124942  /lava-296305/1/../bin/lava-test-case
    2023-03-15T21:38:50.125320  <8>[   25.647177] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2023-03-15T21:38:50.125573  /lava-296305/1/../bin/lava-test-case
    2023-03-15T21:38:50.125801  <8>[   25.664029] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/64123b06b3287614768c865a
        failing since 8 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-15T21:38:51.199622  /lava-296305/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/64123b06b3287614768c865b
        failing since 8 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-15T21:38:51.202885  <8>[   26.759479] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2023-03-15T21:38:52.261235  /lava-296305/1/../bin/lava-test-case
    2023-03-15T21:38:52.261601  <8>[   27.780614] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2023-03-15T21:38:52.261839  /lava-296305/1/../bin/lava-test-case   =

 =20
