Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0AF7CA6EF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 13:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjJPLtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 07:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPLtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 07:49:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB3C8E
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 04:49:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9e95aa02dso26070615ad.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 04:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697456950; x=1698061750; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ADMFca954ZrjMoIrt3+bkB3yfaybDSDHyMnnQsiHKGo=;
        b=MQ2BKZ4D8lUGkY1bBCjHNJg/LO7OAX7m32/fgDKdjQAnItWeU8H/Jni1tcwPt79gyo
         N4LmP9RjPWGWu183qBGYwRZLoH7ZSim7R62MWe8aD6wkUofKDn6GmrXPnqhF2whFAEZQ
         Si/c00BIRPmnMdss/sAfdXrPtNEi2wzBsmTqfqOI8M0gEPGEP77s3jtCFVMbefI3fGrn
         +pz2S6ACavePE+XRGLaD+ejO7XIHRar86labepQN/lLhe6yqDwQB6OqbzxQ/bL2JbEea
         TYfiKIEstvDL7iRq3Uv9nL/r9zkk3y6TmiveZIHANzR6thA1Qci90YNXODHTcXJcPeef
         lb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697456950; x=1698061750;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADMFca954ZrjMoIrt3+bkB3yfaybDSDHyMnnQsiHKGo=;
        b=SFz4MR+nX6aRb2Q0eP15HyWZgSM9K1VbthPzlVYiTej8f/KFKtHtUw7i9VflRwrmVr
         bXyDD0LgiVGHUcWDo0bm2D1wh6m72nmu1gsYD/lIWi9FSxjr+I4SNqDMc8i7MWwJwASF
         clRFunfSwn3k9u8EJTUDW9z9yXyPYRzPzoiI6lZzD0Q7QsE7tnCwwE/AYQoC6kKgO8As
         kqwANAUzBOBsEJFL4ZzHVIH7IBqWZVndF9c7UGPWINYhs2U309tSS6uIsmMOHTuxwRQ1
         6XwWbdpdf6LTBbIR5DIfk11ODocmbPkdZORHCN2zmSmjIFiWwfmy/grXMquJTmMoXd5U
         nPIw==
X-Gm-Message-State: AOJu0YwVy+Fieo7bIYZksLm9Bd2A3ltiKt2csaI11moI5OCWVwPCXsim
        YojFP+RYgw9lvIbzTVDKWrIVsw==
X-Google-Smtp-Source: AGHT+IEWIV1VOR/1nSaXiJevl+VnCbWmvsutNjvJsuiQflEiUh2CjXEJCIDq9uJeTql6mNRUan3ffw==
X-Received: by 2002:a17:902:d2c4:b0:1c9:ddd8:9950 with SMTP id n4-20020a170902d2c400b001c9ddd89950mr12011998plc.21.1697456950138;
        Mon, 16 Oct 2023 04:49:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jc3-20020a17090325c300b001c9bca1d705sm8370062plb.242.2023.10.16.04.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:49:09 -0700 (PDT)
Message-ID: <652d2335.170a0220.34a55.8aa3@mx.google.com>
Date:   Mon, 16 Oct 2023 04:49:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc6-156-g701ff0817fdda
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 47 runs,
 5 regressions (v6.6-rc6-156-g701ff0817fdda)
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

pm/testing baseline: 47 runs, 5 regressions (v6.6-rc6-156-g701ff0817fdda)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
imx8mp-evk         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 2      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc6=
-156-g701ff0817fdda/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc6-156-g701ff0817fdda
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      701ff0817fdda8d4fc8de43d1a314958273b3b33 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
imx8mp-evk         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/652d19513a6edca8cbefcf90

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc6-156-g701ff=
0817fdda/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc6-156-g701ff=
0817fdda/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d19513a6edca8cbefcf99
        failing since 33 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, fir=
st fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-10-16T11:06:31.040020  + set<8>[   28.665643] <LAVA_SIGNAL_ENDRUN =
0_dmesg 174102_1.5.2.4.1>
    2023-10-16T11:06:31.040514   +x
    2023-10-16T11:06:31.147407  / # #
    2023-10-16T11:06:32.311040  export SHELL=3D/bin/sh
    2023-10-16T11:06:32.316931  #
    2023-10-16T11:06:33.812436  / # export SHELL=3D/bin/sh. /lava-174102/en=
vironment
    2023-10-16T11:06:33.818607  =

    2023-10-16T11:06:36.537783  / # . /lava-174102/environment/lava-174102/=
bin/lava-test-runner /lava-174102/1
    2023-10-16T11:06:36.543995  =

    2023-10-16T11:06:36.558170  / # /lava-174102/bin/lava-test-runner /lava=
-174102/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 2      =
    =


  Details:     https://kernelci.org/test/plan/id/652d18fdd581f8e3f9efcf00

  Results:     51 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc6-156-g701ff=
0817fdda/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc6-156-g701ff=
0817fdda/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d18fdd581f8e3f9efcf07
        new failure (last pass: v6.6-rc5-157-g8134843f53ba)

    2023-10-16T11:05:08.574809  / # #
    2023-10-16T11:05:08.676759  export SHELL=3D/bin/sh
    2023-10-16T11:05:08.677522  #
    2023-10-16T11:05:08.778719  / # export SHELL=3D/bin/sh. /lava-386792/en=
vironment
    2023-10-16T11:05:08.779219  =

    2023-10-16T11:05:08.879983  / # . /lava-386792/environment/lava-386792/=
bin/lava-test-runner /lava-386792/1
    2023-10-16T11:05:08.880420  =

    2023-10-16T11:05:08.922395  / # /lava-386792/bin/lava-test-runner /lava=
-386792/1
    2023-10-16T11:05:08.950110  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-16T11:05:08.950268  + cd /lava-386792/1/tests/1_bootrr =

    ... (9 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/652=
d18fdd581f8e3f9efcf17
        new failure (last pass: v6.6-rc5-157-g8134843f53ba)

    2023-10-16T11:05:11.341175  /lava-386792/1/../bin/lava-test-case
    2023-10-16T11:05:11.341445  <8>[   18.103077] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-10-16T11:05:11.341685  /lava-386792/1/../bin/lava-test-case   =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/652d19061af3c0522aefcf12

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc6-156-g701ff=
0817fdda/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc6-156-g701ff=
0817fdda/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d19061af3c0522aefcf1b
        failing since 88 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-16T11:09:45.437594  / # #

    2023-10-16T11:09:45.538243  export SHELL=3D/bin/sh

    2023-10-16T11:09:45.538486  #

    2023-10-16T11:09:45.639025  / # export SHELL=3D/bin/sh. /lava-11790064/=
environment

    2023-10-16T11:09:45.639248  =


    2023-10-16T11:09:45.739763  / # . /lava-11790064/environment/lava-11790=
064/bin/lava-test-runner /lava-11790064/1

    2023-10-16T11:09:45.740074  =


    2023-10-16T11:09:45.751127  / # /lava-11790064/bin/lava-test-runner /la=
va-11790064/1

    2023-10-16T11:09:45.791816  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-16T11:09:45.810302  + cd /lav<8>[   19.203081] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11790064_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/652d19122fb91d8a26efcff9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc6-156-g701ff=
0817fdda/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc6-156-g701ff=
0817fdda/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d19122fb91d8a26efd002
        failing since 88 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-16T11:08:16.757895  / # #

    2023-10-16T11:08:17.838444  export SHELL=3D/bin/sh

    2023-10-16T11:08:17.840336  #

    2023-10-16T11:08:19.330968  / # export SHELL=3D/bin/sh. /lava-11790060/=
environment

    2023-10-16T11:08:19.332780  =


    2023-10-16T11:08:22.057045  / # . /lava-11790060/environment/lava-11790=
060/bin/lava-test-runner /lava-11790060/1

    2023-10-16T11:08:22.059222  =


    2023-10-16T11:08:22.067494  / # /lava-11790060/bin/lava-test-runner /la=
va-11790060/1

    2023-10-16T11:08:22.128249  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-16T11:08:22.128746  + cd /lava-117900<8>[   28.522731] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11790060_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20
