Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987036C2FE5
	for <lists+linux-pm@lfdr.de>; Tue, 21 Mar 2023 12:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCULMi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Mar 2023 07:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCULMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2023 07:12:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DDB47826
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2023 04:12:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso15543551pjb.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2023 04:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679397145;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kBtYWLm7J+J+ybdg0GlwBBr0mADsM9lAgGJh1+MU7DA=;
        b=tyRq08GUtYynf+kO9rtyFKLfaISwZuYYGwuamZbS9GYWme/TOL3KA1ZqyotapMLp/v
         DIC+kWRM5VjPwjbMj3YvnIC4gc4tDIEyY1MnVh/bKXyBvi3XVGITPdFtS5sMoexDSBPw
         1pev6f+szqY+9L0mozlGga+7cenhG8i+002i+1CocXGhW48CGNAHz6ay/7PmHyBDJowy
         ZZJ7kI/bdAYH00xJQzdLfHcTvRuhIE/ybamavTVonEZVcKyT2+L6U/ZzZjeE+A0rmxG4
         G5nQfkw29koKKKBt4K3g0AbtUToIBo9IMZrodLPIo8oMqWYgKf0LoLWxdlC4HuACJkfD
         Ow0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679397145;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBtYWLm7J+J+ybdg0GlwBBr0mADsM9lAgGJh1+MU7DA=;
        b=H9Kd/QdudVNF7xl0xvVgjsKCVf07LKyOkoPYEhyppO3AEpsJVxPxwaOBxe+twYirPQ
         QGUB4pegFfx2qVI7fcjET9wm9QfJ29uhp+AdE1u+ZnHmjI1jL0qkeJeOlEZQjTAtH7XQ
         c3ICAADshsjIdyzW89fCO6RrRwd42Ted1zi3/IZj6r01Ae8HlUCPHMXJZ7jrtizfQc7F
         ooAZQY/GeEqj28/Czrk5i7WOOPN9b2QYC9wxyeFmr2G1YQbpHVGUvvGcrU8InDmjJ9gz
         MZ95HAcaJwheei3C/18R6lu5oAryiLNPcA1Vb62f1amCd7J7XYsAwpItvzDD7l2thSBT
         5H5g==
X-Gm-Message-State: AO0yUKUBvC/gqzjBwXZnLzpjMb8/Gibi2Qu5MR9y49CXOCab1TNWkN1P
        wNGoJUfiEr/hw8f9EPAADD4Ddw==
X-Google-Smtp-Source: AK7set+nQe0a6VfSEAe6USXFp8J6HSr7vWqCKJYC8bOD1AlpQy69UR6JhUoFzvcllwPUmYjxt8oWjQ==
X-Received: by 2002:a17:903:210b:b0:1a0:50bd:31bf with SMTP id o11-20020a170903210b00b001a050bd31bfmr1576985ple.32.1679397145211;
        Tue, 21 Mar 2023 04:12:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b0019a97a4324dsm8554833plb.5.2023.03.21.04.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 04:12:24 -0700 (PDT)
Message-ID: <64199118.170a0220.3ac76.f4e5@mx.google.com>
Date:   Tue, 21 Mar 2023 04:12:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3-rc3-30-g51555d0c77b35
Subject: pm/testing baseline: 55 runs,
 6 regressions (v6.3-rc3-30-g51555d0c77b35)
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

pm/testing baseline: 55 runs, 6 regressions (v6.3-rc3-30-g51555d0c77b35)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc3=
-30-g51555d0c77b35/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc3-30-g51555d0c77b35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      51555d0c77b35f23311fe0c81bad3a8083478a96 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
fsl-lx2160a-rdb       | arm64 | lab-nxp     | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/641988dbbc96c88f749c9508

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc3-30-g51555d=
0c77b35/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc3-30-g51555d=
0c77b35/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641988dbbc96c88f749c9511
        failing since 5 days (last pass: v6.1-rc5-55-g60453df62d30, first f=
ail: v6.3-rc2-33-g1240ce78c05e)

    2023-03-21T10:36:49.885853  [   12.898418] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1179945_1.5.2.4.1>
    2023-03-21T10:36:49.991901  / # #
    2023-03-21T10:36:50.093719  export SHELL=3D/bin/sh
    2023-03-21T10:36:50.094269  #
    2023-03-21T10:36:50.195696  / # export SHELL=3D/bin/sh. /lava-1179945/e=
nvironment
    2023-03-21T10:36:50.196157  =

    2023-03-21T10:36:50.297498  / # . /lava-1179945/environment/lava-117994=
5/bin/lava-test-runner /lava-1179945/1
    2023-03-21T10:36:50.298281  =

    2023-03-21T10:36:50.299954  / # /lava-1179945/bin/lava-test-runner /lav=
a-1179945/1
    2023-03-21T10:36:50.325346  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =


  Details:     https://kernelci.org/test/plan/id/64198755c92f2537dd9c95f0

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc3-30-g51555d=
0c77b35/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc3-30-g51555d=
0c77b35/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64198755c92f2537dd9c95f7
        failing since 13 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-21T10:30:25.744390  / # #
    2023-03-21T10:30:25.845615  export SHELL=3D/bin/sh
    2023-03-21T10:30:25.845870  #
    2023-03-21T10:30:25.946814  / # export SHELL=3D/bin/sh. /lava-299603/en=
vironment
    2023-03-21T10:30:25.947057  =

    2023-03-21T10:30:26.048004  / # . /lava-299603/environment/lava-299603/=
bin/lava-test-runner /lava-299603/1
    2023-03-21T10:30:26.048478  =

    2023-03-21T10:30:26.059817  / # /lava-299603/bin/lava-test-runner /lava=
-299603/1
    2023-03-21T10:30:26.119836  + export 'TESTRUN_ID=3D1_bootrr'
    2023-03-21T10:30:26.120030  + <8>[   22.425391] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 299603_1.5.2.4.5> =

    ... (17 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/64198755c92f2537dd9c95fb
        failing since 13 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-21T10:30:28.215692  /lava-299603/1/../bin/lava-test-case
    2023-03-21T10:30:28.215915  <8>[   24.531770] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2023-03-21T10:30:28.216053  /lava-299603/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/64=
198755c92f2537dd9c95fd
        failing since 13 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-21T10:30:29.274601  /lava-299603/1/../bin/lava-test-case
    2023-03-21T10:30:29.275007  <8>[   25.569540] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2023-03-21T10:30:29.275138  /lava-299603/1/../bin/lava-test-case
    2023-03-21T10:30:29.275244  <8>[   25.587634] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2023-03-21T10:30:29.275349  /lava-299603/1/../bin/lava-test-case
    2023-03-21T10:30:29.275451  <8>[   25.606715] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2023-03-21T10:30:29.275553  /lava-299603/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/64198755c92f2537dd9c9602
        failing since 13 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-21T10:30:30.351106  /lava-299603/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/64198755c92f2537dd9c9603
        failing since 13 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-21T10:30:30.354275  <8>[   26.683770] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2023-03-21T10:30:31.415446  /lava-299603/1/../bin/lava-test-case
    2023-03-21T10:30:31.415815  <8>[   27.704814] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2023-03-21T10:30:31.415948  /lava-299603/1/../bin/lava-test-case
    2023-03-21T10:30:31.416059  <8>[   27.724159] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-driver-present RESULT=3Dpass>
    2023-03-21T10:30:31.416162  /lava-299603/1/../bin/lava-test-case
    2023-03-21T10:30:31.416258  <8>[   27.744858] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-probed RESULT=3Dpass>
    2023-03-21T10:30:31.416353  /lava-299603/1/../bin/lava-test-case   =

 =20
