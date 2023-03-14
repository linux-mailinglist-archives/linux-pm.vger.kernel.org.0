Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC76B8BE9
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 08:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCNH0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Mar 2023 03:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCNH0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 03:26:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74D74DDB
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 00:26:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h8so15613848plf.10
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 00:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678778790;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cbMsM2i01QtjxnKMrQQpxYIyuO8Q6638rQDFlFLw2jQ=;
        b=dJFBxGXWOW7yXal2YtidlCABq/+YgeyiFSQaBY1Nua+M0pGxnAcTgbtnlAZP4ZVcOr
         DlfRCnSqqqWgJJP2HmQiYnT6fLUIN3Q4E+Hy0RzzCZcgSzMiVaZPWiGFyMWOLy2/8KNi
         dM+RUeiflua0kw9+ooWtcaMElr9A5BoJvDPt+2UY6KZprxn+OHdcc7BWrKW39tOsNDuA
         /T4Ouhtmm4FMsQF0FOp7x9wuRp77Ml9VzWmR56XzK4BKZ44K7bJzaFjeFV+XeH3+nhIV
         iRqaEuzWFKzUR+m0UzfZHtsPvhAAJfGNCnU3olX/Jc06XHu0P6kDi62ArPtsyP9z0Bnc
         ycrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678778790;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbMsM2i01QtjxnKMrQQpxYIyuO8Q6638rQDFlFLw2jQ=;
        b=zBoMkro3sAiTYILF1IppnzbTfbzL6vgMS0CG0fnulMDWfHwmqA+Tsg2L63O8rMKc7r
         1fYlyII9gSoMtNvoPS57isjihMU0LBl0lixtCQIgIH0nokREvOCpnPZ4Cgp27kZYDpNo
         St06QaJePl2SstujDaTYWenFMyvPVGlM/hBFMv8Tokgoi9i0vv/IIKjPBGazl5XNzYo4
         CV56YpMbSzJma7UyrMcZyi12O2Kn0mVNQIBKzcUbxxM08YhT3y1AFfaDJZ7Dnhlfvnro
         FjFAVkE16f7OpTH/MT9TUIxphxo/AOsAJzktst/Yz20faqC/PDqLEHLH+t4EPdCXHNk7
         swtw==
X-Gm-Message-State: AO0yUKWXadUgCGuhEKJMRl3lpoiDgBAb02oAn4+vWArh6klDPrjHvLvX
        d7ob27lFYlNljU4RLJ5lVn+Gsw==
X-Google-Smtp-Source: AK7set+0tuICkumqzBSRLwRZmSXUqQeagKmIETEDfIg3pbtsKhaKImQGmIHWX/8QfdH8cz4aoiorYg==
X-Received: by 2002:a05:6a20:3d82:b0:cd:36a3:3beb with SMTP id s2-20020a056a203d8200b000cd36a33bebmr39415688pzi.30.1678778790428;
        Tue, 14 Mar 2023 00:26:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f3-20020a63f103000000b004eecc3080f8sm910637pgi.29.2023.03.14.00.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 00:26:30 -0700 (PDT)
Message-ID: <641021a6.630a0220.a4d72.2b41@mx.google.com>
Date:   Tue, 14 Mar 2023 00:26:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc2-28-gd64b2bdbf627
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 51 runs,
 5 regressions (v6.3-rc2-28-gd64b2bdbf627)
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

pm/testing baseline: 51 runs, 5 regressions (v6.3-rc2-28-gd64b2bdbf627)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc2=
-28-gd64b2bdbf627/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc2-28-gd64b2bdbf627
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d64b2bdbf6274ec9d924b31de316b819d6916ab0 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =


  Details:     https://kernelci.org/test/plan/id/6410171abc9365cdf58c8672

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc2-28-gd64b2b=
dbf627/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc2-28-gd64b2b=
dbf627/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6410171abc9365cdf58c8679
        failing since 6 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-14T06:41:19.082307  <8>[   22.073147] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 294654_1.5.2.4.1>
    2023-03-14T06:41:19.187538  / # #
    2023-03-14T06:41:19.289644  export SHELL=3D/bin/sh
    2023-03-14T06:41:19.290119  #
    2023-03-14T06:41:19.391614  / # export SHELL=3D/bin/sh. /lava-294654/en=
vironment
    2023-03-14T06:41:19.392152  =

    2023-03-14T06:41:19.493593  / # . /lava-294654/environment/lava-294654/=
bin/lava-test-runner /lava-294654/1
    2023-03-14T06:41:19.494360  =

    2023-03-14T06:41:19.514113  / # /lava-294654/bin/lava-test-runner /lava=
-294654/1
    2023-03-14T06:41:19.566035  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (18 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/6410171abc9365cdf58c867d
        failing since 6 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-14T06:41:20.627733  <8>[   23.621467] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-driver-present RESULT=3Dpass>
    2023-03-14T06:41:21.664228  /lava-294654/1/../bin/lava-test-case
    2023-03-14T06:41:21.664622  <8>[   24.643492] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2023-03-14T06:41:21.664870  /lava-294654/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/64=
10171abc9365cdf58c867f
        failing since 6 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-14T06:41:22.720160  /lava-294654/1/../bin/lava-test-case
    2023-03-14T06:41:22.720541  <8>[   25.681170] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/6410171abc9365cdf58c8684
        failing since 6 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-14T06:41:23.795296  /lava-294654/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/6410171abc9365cdf58c8685
        failing since 6 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, firs=
t fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-14T06:41:23.798448  <8>[   26.791559] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2023-03-14T06:41:24.852070  /lava-294654/1/../bin/lava-test-case
    2023-03-14T06:41:24.852462  <8>[   27.812592] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2023-03-14T06:41:24.852706  /lava-294654/1/../bin/lava-test-case
    2023-03-14T06:41:24.852935  <8>[   27.830521] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-driver-present RESULT=3Dpass>
    2023-03-14T06:41:24.853161  /lava-294654/1/../bin/lava-test-case   =

 =20
