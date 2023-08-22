Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3E178392C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 07:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHVFRh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Aug 2023 01:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjHVFRh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 01:17:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C09FB
        for <linux-pm@vger.kernel.org>; Mon, 21 Aug 2023 22:17:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc63ef9959so31746205ad.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Aug 2023 22:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692681452; x=1693286252;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FQZ/m8I9oxo4meYaUYaNYiPmTXoy5qeBEjwh4qCEsFQ=;
        b=2Lf18s18/fCOt/lP/xzKyLNTBRYczfBcD0F1YcpRiFf1CeJzCCKhogJqRua9D2eat3
         3LrB4kLFDIBodS/xbDO0YEh+5HT6Rr8nKxCaZYt49vNNO3Il0o6rjaNAPLqA4mcg8GOs
         EYgymRf8QDB+1DyiKouqVqFLdsQgLoXUYmjPHWfcJ5f44ncgCi1Ezd9+LZ6mtbZNRMhJ
         pWzoZMgPC2/74oL6cR5OREMJYjQh+YgEGUSeqFJ0cL+jWh42zXVeEOO6oHAt47XCbnWK
         +VIpJwdB4Clz8m0ZmUd8xFWbg5cqg2/bv77HTADkByMSJFnooOKAR0UkC+gtc+BgI9Ex
         mCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692681452; x=1693286252;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQZ/m8I9oxo4meYaUYaNYiPmTXoy5qeBEjwh4qCEsFQ=;
        b=b3ZlmBWYPwUvaUlALhCMguNppo2ywUSZhGAKbqmytSemzUH9TNWDt0I0y96YHPDjMy
         hWjLMRXSfOddFd+1angm3gIVjWRA/RIwaHeTHUnkI7wA7Svqr0/BYY1Zz+9Ar/fBiuq1
         pJ2LYbKVAVlAEqh/elJKxTekatRxc12XDHBOF+EFe8hUMYXiDWx4khlo83ZLPsGt07On
         eKi6jgeTveyMnf5gIO2WZQSm7PR95W2yeX1c4zgKlrQ3a4BJdb89gyFxe2LiSGWD7eO9
         x823fdGficKV2YwG0zAL8nICBseTEkgl0kioIj0aXp7Yqhs4Cs/pWEKO6n0FumIPzFBp
         fiGA==
X-Gm-Message-State: AOJu0YxyKgBA/hr0Z9iibJiylnGA6p9jMaaGR4Acf7b/Fag2VYorRcJK
        cK1qT3Qu4lpK40bRNi7coo7MDQ==
X-Google-Smtp-Source: AGHT+IE8jyVG+fb0ymoFOLD4aD93wy5vIAXcDxHdsYsQSL5JnNC/OtMqDeppJmlnbb489/SvpH1a8A==
X-Received: by 2002:a17:902:e846:b0:1b9:e241:ad26 with SMTP id t6-20020a170902e84600b001b9e241ad26mr11334141plg.9.1692681452278;
        Mon, 21 Aug 2023 22:17:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902bd4b00b001bba373919bsm7978689plx.261.2023.08.21.22.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 22:17:31 -0700 (PDT)
Message-ID: <64e444eb.170a0220.9838.f04f@mx.google.com>
Date:   Mon, 21 Aug 2023 22:17:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.5-rc7-96-gabb51b0e3f333
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 49 runs,
 4 regressions (v6.5-rc7-96-gabb51b0e3f333)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 49 runs, 4 regressions (v6.5-rc7-96-gabb51b0e3f333)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
fsl-ls2088a-rdb   | arm64 | lab-nxp       | gcc-10   | defconfig | 1       =
   =

fsl-lx2160a-rdb   | arm64 | lab-nxp       | gcc-10   | defconfig | 1       =
   =

r8a779m1-ulcb     | arm64 | lab-collabora | gcc-10   | defconfig | 1       =
   =

rk3399-rock-pi-4b | arm64 | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc7=
-96-gabb51b0e3f333/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc7-96-gabb51b0e3f333
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      abb51b0e3f3336875a4b59f74a118134ce8c45fa =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
fsl-ls2088a-rdb   | arm64 | lab-nxp       | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64e43b3737eff20aaadc95f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc7-96-gabb51b=
0e3f333/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc7-96-gabb51b=
0e3f333/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e43b3737eff20aaadc95f3
        failing since 38 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-22T04:35:37.408242  + [   16.486639] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1244679_1.5.2.4.1>
    2023-08-22T04:35:37.408536  set +x
    2023-08-22T04:35:37.513858  =

    2023-08-22T04:35:37.615105  / # #export SHELL=3D/bin/sh
    2023-08-22T04:35:37.615572  =

    2023-08-22T04:35:37.716540  / # export SHELL=3D/bin/sh. /lava-1244679/e=
nvironment
    2023-08-22T04:35:37.716972  =

    2023-08-22T04:35:37.817946  / # . /lava-1244679/environment/lava-124467=
9/bin/lava-test-runner /lava-1244679/1
    2023-08-22T04:35:37.818636  =

    2023-08-22T04:35:37.821777  / # /lava-1244679/bin/lava-test-runner /lav=
a-1244679/1 =

    ... (12 line(s) more)  =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
fsl-lx2160a-rdb   | arm64 | lab-nxp       | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64e43b3494903e13e9dc95de

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc7-96-gabb51b=
0e3f333/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc7-96-gabb51b=
0e3f333/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e43b3494903e13e9dc95e1
        failing since 159 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-22T04:35:36.328207  [   12.820576] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244678_1.5.2.4.1>
    2023-08-22T04:35:36.433406  =

    2023-08-22T04:35:36.534603  / # #export SHELL=3D/bin/sh
    2023-08-22T04:35:36.535065  =

    2023-08-22T04:35:36.636100  / # export SHELL=3D/bin/sh. /lava-1244678/e=
nvironment
    2023-08-22T04:35:36.636519  =

    2023-08-22T04:35:36.737555  / # . /lava-1244678/environment/lava-124467=
8/bin/lava-test-runner /lava-1244678/1
    2023-08-22T04:35:36.738282  =

    2023-08-22T04:35:36.742113  / # /lava-1244678/bin/lava-test-runner /lav=
a-1244678/1
    2023-08-22T04:35:36.763925  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
r8a779m1-ulcb     | arm64 | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64e43ac218ec7c2e79dc95e5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc7-96-gabb51b=
0e3f333/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc7-96-gabb51b=
0e3f333/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e43ac218ec7c2e79dc95ea
        failing since 33 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-22T04:34:07.913654  / # #

    2023-08-22T04:34:08.993452  export SHELL=3D/bin/sh

    2023-08-22T04:34:08.995236  #

    2023-08-22T04:34:10.485787  / # export SHELL=3D/bin/sh. /lava-11329648/=
environment

    2023-08-22T04:34:10.487609  =


    2023-08-22T04:34:13.208227  / # . /lava-11329648/environment/lava-11329=
648/bin/lava-test-runner /lava-11329648/1

    2023-08-22T04:34:13.210491  =


    2023-08-22T04:34:13.222911  / # /lava-11329648/bin/lava-test-runner /la=
va-11329648/1

    2023-08-22T04:34:13.281939  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T04:34:13.282411  + cd /lava-113296<8>[   28.556801] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11329648_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
rk3399-rock-pi-4b | arm64 | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64e43bb0af5a236a02dc95cc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc7-96-gabb51b=
0e3f333/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc7-96-gabb51b=
0e3f333/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e43bb0af5a236a02dc9=
5cd
        new failure (last pass: v6.5-rc6-81-ge8cde28ba5123) =

 =20
