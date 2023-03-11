Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C174D6B5791
	for <lists+linux-pm@lfdr.de>; Sat, 11 Mar 2023 02:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCKB2N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 20:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCKB2L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 20:28:11 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7650B134815
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 17:27:26 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so6778262pjp.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 17:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678498044;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=atPcqBPLCVuA0QLIOnE29NH5lK7Hr87/CFdM8mH7TS0=;
        b=Ll2PRcAJ8ZLxwCKvmZIozyHU6Dym72a/502CoHLoLjQEM9kCNiAFfd7KAYAAebCKQ0
         4qLqyfhkZMzd+cw3fksQEczPgSLcZML1jgekc4QQ4vZKJM2QJVweTd3zsl4S5JSOjrPw
         /5Sl6qXXQmaLbPLQV/Ur0iV5WIifENK3Upab5TMa8T46NAkzwXhxAk+6itpETj4mCCsL
         BXGIywHpfPZOjj+xyDoY5VurkhL07A7322gvinyaKceZas99HpjQcfHh6LjFgXx21FET
         oqB8BJwhPEEpWqdmUFUM4lwt/r0vQdqWTaN2gCiPNLlcHg6Pp5DELxuCGCvipwAMagkx
         IIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678498044;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atPcqBPLCVuA0QLIOnE29NH5lK7Hr87/CFdM8mH7TS0=;
        b=zG3QHKlQzHkJDtjGFfRPWoAvpQL/2wzSoDpX+6B37YfRZMAlB0WP1w5Mdp4Nzw/b79
         BAsfJncfv6BpU91ZYKmHxqpYkudOg0QSak8miQ3FbqCcvW0Dn5MZ1tHSnG7/Q4Wqo3ub
         Gt72BJ4YT22j85jEVohUAY5wKPnQh04lPjrFMD3eGnlpAz43KkT2JYa8IxbKe8BHbr07
         nbG0KtV3stAR1BTl7cply5TyO8Tors6h46TH2nBMik0RlZnFvsmp/8CVfr8kVFx4ZWpD
         Fu7wP/HOz4U5yEyaBR+U190xcIQBWTq4TLnIPbzxCtYyKnmD631sJiUqOlNzKBtO6c9s
         esRQ==
X-Gm-Message-State: AO0yUKX3nPDotscQO2sDDJeIZacEvXAHT7RMS3rb0vq9ABl0H4bHW+Bf
        WOr3v9FOQvg0M9Wqy9vjgtSnASS2Y6gmWq7kqBVWehuB
X-Google-Smtp-Source: AK7set/R/bnkqaUUQtnsC+dMWlaRwKPkMaQHlbOB0qeRzcdHkamW0aZ7FH9FfcJxij9QK152uqZrVg==
X-Received: by 2002:a17:903:190:b0:19d:2542:96a4 with SMTP id z16-20020a170903019000b0019d254296a4mr34689080plg.4.1678498044396;
        Fri, 10 Mar 2023 17:27:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lh4-20020a170903290400b0019258bcf3ffsm586416plb.56.2023.03.10.17.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:27:24 -0800 (PST)
Message-ID: <640bd8fc.170a0220.d97cf.1ffe@mx.google.com>
Date:   Fri, 10 Mar 2023 17:27:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc1-33-g687388eb09d3
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 31 runs,
 7 regressions (v6.3-rc1-33-g687388eb09d3)
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

pm/testing baseline: 31 runs, 7 regressions (v6.3-rc1-33-g687388eb09d3)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =

kontron-pitx-imx8m    | arm64 | lab-kontron | gcc-10   | defconfig | 2     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc1=
-33-g687388eb09d3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc1-33-g687388eb09d3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      687388eb09d318fb319b2771f1ee426afbf03bc3 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =


  Details:     https://kernelci.org/test/plan/id/640bcd08bd1ed2a6888c866c

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc1-33-g687388=
eb09d3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc1-33-g687388=
eb09d3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640bcd08bd1ed2a6888c8673
        failing since 3 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-11T00:35:58.960618  / # #
    2023-03-11T00:35:59.062696  export SHELL=3D/bin/sh
    2023-03-11T00:35:59.063340  #
    2023-03-11T00:35:59.164640  / # export SHELL=3D/bin/sh. /lava-292249/en=
vironment
    2023-03-11T00:35:59.165304  =

    2023-03-11T00:35:59.266478  / # . /lava-292249/environment/lava-292249/=
bin/lava-test-runner /lava-292249/1
    2023-03-11T00:35:59.267335  =

    2023-03-11T00:35:59.273170  / # /lava-292249/bin/lava-test-runner /lava=
-292249/1
    2023-03-11T00:35:59.339226  + export 'TESTRUN_ID=3D1_bootrr'
    2023-03-11T00:35:59.339526  + <8>[   22.545205] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 292249_1.5.2.4.5> =

    ... (17 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/640bcd08bd1ed2a6888c8677
        failing since 3 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-11T00:36:01.436388  /lava-292249/1/../bin/lava-test-case
    2023-03-11T00:36:01.436685  <8>[   24.651439] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2023-03-11T00:36:01.436838  /lava-292249/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/64=
0bcd08bd1ed2a6888c8679
        failing since 3 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-11T00:36:02.494969  /lava-292249/1/../bin/lava-test-case
    2023-03-11T00:36:02.495268  <8>[   25.690793] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2023-03-11T00:36:02.495421  /lava-292249/1/../bin/lava-test-case
    2023-03-11T00:36:02.495562  <8>[   25.707705] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2023-03-11T00:36:02.495715  /lava-292249/1/../bin/lava-test-case
    2023-03-11T00:36:02.495862  <8>[   25.727870] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2023-03-11T00:36:02.496788  /lava-292249/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/640bcd08bd1ed2a6888c867e
        failing since 3 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-11T00:36:03.569501  /lava-292249/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/640bcd08bd1ed2a6888c867f
        failing since 3 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-11T00:36:03.572602  <8>[   26.803584] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2023-03-11T00:36:04.632072  /lava-292249/1/../bin/lava-test-case
    2023-03-11T00:36:04.632386  <8>[   27.823852] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2023-03-11T00:36:04.633220  /lava-292249/1/../bin/lava-test-case
    2023-03-11T00:36:04.633646  <8>[   27.842263] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-driver-present RESULT=3Dpass>
    2023-03-11T00:36:04.634276  /lava-292249/1/../bin/lava-test-case
    2023-03-11T00:36:04.634433  <8>[   27.862256] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-probed RESULT=3Dpass>
    2023-03-11T00:36:04.635253  /lava-292249/1/../bin/lava-test-case   =

 =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-pitx-imx8m    | arm64 | lab-kontron | gcc-10   | defconfig | 2     =
     =


  Details:     https://kernelci.org/test/plan/id/640bcd05bd1ed2a6888c8630

  Results:     51 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc1-33-g687388=
eb09d3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc1-33-g687388=
eb09d3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640bcd05bd1ed2a6888c8637
        new failure (last pass: v6.3-rc1-23-g06401c1b98b0)

    2023-03-11T00:35:53.682314  / # #
    2023-03-11T00:35:53.784941  export SHELL=3D/bin/sh
    2023-03-11T00:35:53.785586  #
    2023-03-11T00:35:53.887074  / # export SHELL=3D/bin/sh. /lava-292246/en=
vironment
    2023-03-11T00:35:53.888311  =

    2023-03-11T00:35:53.989871  / # . /lava-292246/environment/lava-292246/=
bin/lava-test-runner /lava-292246/1
    2023-03-11T00:35:53.990715  =

    2023-03-11T00:35:54.004373  / # /lava-292246/bin/lava-test-runner /lava=
-292246/1
    2023-03-11T00:35:54.060383  + export 'TESTRUN_ID=3D1_bootrr'
    2023-03-11T00:35:54.060685  + cd /l<8>[   16.290354] <LAVA_SIGNAL_START=
RUN 1_bootrr 292246_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/640=
bcd05bd1ed2a6888c8647
        new failure (last pass: v6.3-rc1-23-g06401c1b98b0)

    2023-03-11T00:35:58.115635  /lava-292246/1/../bin/lava-test-case
    2023-03-11T00:35:58.115988  <8>[   20.510743] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-03-11T00:35:58.116170  /lava-292246/1/../bin/lava-test-case   =

 =20
