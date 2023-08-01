Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9159C76B62B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Aug 2023 15:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjHANrR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 09:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjHANrQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 09:47:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA619F1
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 06:47:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb775625e2so37187945ad.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Aug 2023 06:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690897634; x=1691502434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jCIomZXZF5vnuHuuQsoxJX1rDSCNRXhqnhptfsOemJk=;
        b=i70W5mRH9VY6EQDXwr/OlKYRTj6CMlcLTpB6fXT/sg84tleKkFiOsmH2wR/EgUh4HG
         VfLIb1m/8S+l2D5/gBt/7z3kfeNQ2M3Gu5trZGmeSbJTsixKSoq8ZamSocmsqbYH3WQw
         O1sAcWC9gQ50TgZq76Uorj5CHFfhElPnzdFGZ+07hN5XjZjOifbh6q3+pdZS+GSIf9NP
         jNPGikBWijSvb+Z8b3x1/WCtgwXOBfa3SL4G8W/jy7cZpMQvRMZlSWEG8P9Ed+2GvhQu
         DuZieAAZBignpiElQh8Gkk9i9SD5Qkr67jJCphNBmAGjrhIuah0iFVjxKjqulnbfs3as
         SV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690897634; x=1691502434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCIomZXZF5vnuHuuQsoxJX1rDSCNRXhqnhptfsOemJk=;
        b=O5P7LDioVrqnxcrqTyZKn6E46cFiGMDjU6vPXPFDXXBLjQSZJuITRKs/VXyWofDNaA
         jDJqXouM0q3tM8EQ7mjjVITucyaGZV0kj7HgSSmAd5ccbkL8v/q5WoPm3e/SGfiQYmE4
         GN9DHzPtZBGrtGjiFGcHx+4+0duvGWx7bL2EDtUKynI9hD41egsOQsu03IsvU6foyZJ8
         vrbtIbeYAVe6Wfb/6k9jRJLlqY1HGwlKqjWF2TwdBqh2g/IQM++ng18uE9yurIXCSUmW
         o6ZNdfLInIkXztG6VZbaE7b1gnnoJAwXz75v2m6ZjUw3JqPNkVkjs9oBtyvSq7/IRrY5
         FTRA==
X-Gm-Message-State: ABy/qLak6ZgZd8T3/0mnJqkiyui78JdjndxBdyejGuLz6vXM4QEaNmjC
        xc7YafHgedaXm/u0aej/XEIrqg==
X-Google-Smtp-Source: APBJJlGqgHh89WnZgqWhSk0rLgzoWXDVsSGSbMOI/7Mv3fIQcnxATcDGCmqXs+w2asZjD8mntnOivA==
X-Received: by 2002:a17:902:ea0f:b0:1b5:674d:2aa5 with SMTP id s15-20020a170902ea0f00b001b5674d2aa5mr15344931plg.13.1690897634126;
        Tue, 01 Aug 2023 06:47:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902cf4600b001b8c6890623sm10553604plg.7.2023.08.01.06.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:47:13 -0700 (PDT)
Message-ID: <64c90ce1.170a0220.dcb52.375f@mx.google.com>
Date:   Tue, 01 Aug 2023 06:47:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc4-58-g7e5258db49000
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 51 runs,
 5 regressions (v6.5-rc4-58-g7e5258db49000)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 51 runs, 5 regressions (v6.5-rc4-58-g7e5258db49000)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
fsl-ls2088a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =

fsl-lx2160a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc4=
-58-g7e5258db49000/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc4-58-g7e5258db49000
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7e5258db49000c4ff5c1b3bc596c2d92e40d6edc =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
fsl-ls2088a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64c902cd793409d1138acea1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-58-g7e5258=
db49000/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-58-g7e5258=
db49000/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c902cd793409d1138acea4
        failing since 18 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-01T13:04:05.311296  [   15.986818] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1240007_1.5.2.4.1>
    2023-08-01T13:04:05.416851  =

    2023-08-01T13:04:05.518086  / # #export SHELL=3D/bin/sh
    2023-08-01T13:04:05.518518  =

    2023-08-01T13:04:05.619539  / # export SHELL=3D/bin/sh. /lava-1240007/e=
nvironment
    2023-08-01T13:04:05.619967  =

    2023-08-01T13:04:05.720957  / # . /lava-1240007/environment/lava-124000=
7/bin/lava-test-runner /lava-1240007/1
    2023-08-01T13:04:05.721664  =

    2023-08-01T13:04:05.725656  / # /lava-1240007/bin/lava-test-runner /lav=
a-1240007/1
    2023-08-01T13:04:05.748059  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
fsl-lx2160a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64c9031e0fb7418d018acf17

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-58-g7e5258=
db49000/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-58-g7e5258=
db49000/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c9031e0fb7418d018acf1a
        failing since 138 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-01T13:05:21.382425  [   13.566676] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1240005_1.5.2.4.1>
    2023-08-01T13:05:21.487649  =

    2023-08-01T13:05:21.588778  / # #export SHELL=3D/bin/sh
    2023-08-01T13:05:21.589176  =

    2023-08-01T13:05:21.690108  / # export SHELL=3D/bin/sh. /lava-1240005/e=
nvironment
    2023-08-01T13:05:21.690509  =

    2023-08-01T13:05:21.791473  / # . /lava-1240005/environment/lava-124000=
5/bin/lava-test-runner /lava-1240005/1
    2023-08-01T13:05:21.792141  =

    2023-08-01T13:05:21.794876  / # /lava-1240005/bin/lava-test-runner /lav=
a-1240005/1
    2023-08-01T13:05:21.817766  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64c905dcab790577aa8ace1c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-58-g7e5258=
db49000/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-58-g7e5258=
db49000/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c905dcab790577aa8ace21
        failing since 12 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-01T13:18:38.903879  / # #

    2023-08-01T13:18:39.006216  export SHELL=3D/bin/sh

    2023-08-01T13:18:39.006909  #

    2023-08-01T13:18:39.108404  / # export SHELL=3D/bin/sh. /lava-11184058/=
environment

    2023-08-01T13:18:39.109174  =


    2023-08-01T13:18:39.210711  / # . /lava-11184058/environment/lava-11184=
058/bin/lava-test-runner /lava-11184058/1

    2023-08-01T13:18:39.211913  =


    2023-08-01T13:18:39.228356  / # /lava-11184058/bin/lava-test-runner /la=
va-11184058/1

    2023-08-01T13:18:39.278156  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T13:18:39.278665  + cd /lava-111840<8>[   19.138260] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11184058_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64c902c52fbde21dac8ace3e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-58-g7e5258=
db49000/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-58-g7e5258=
db49000/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c902c52fbde21dac8ace43
        failing since 12 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-01T13:04:04.854060  / # #

    2023-08-01T13:04:05.934877  export SHELL=3D/bin/sh

    2023-08-01T13:04:05.936752  #

    2023-08-01T13:04:07.427445  / # export SHELL=3D/bin/sh. /lava-11184067/=
environment

    2023-08-01T13:04:07.429379  =


    2023-08-01T13:04:10.154936  / # . /lava-11184067/environment/lava-11184=
067/bin/lava-test-runner /lava-11184067/1

    2023-08-01T13:04:10.157335  =


    2023-08-01T13:04:10.160209  / # /lava-11184067/bin/lava-test-runner /la=
va-11184067/1

    2023-08-01T13:04:10.226957  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T13:04:10.227485  + cd /lava-111840<8>[   28.535616] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11184067_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64c902bc0fb7418d018ace58

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-58-g7e5258=
db49000/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-58-g7e5258=
db49000/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c902bc0fb7418d018ace5d
        failing since 12 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-01T13:05:27.401259  / # #

    2023-08-01T13:05:27.503287  export SHELL=3D/bin/sh

    2023-08-01T13:05:27.503974  #

    2023-08-01T13:05:27.605135  / # export SHELL=3D/bin/sh. /lava-11184064/=
environment

    2023-08-01T13:05:27.605804  =


    2023-08-01T13:05:27.707143  / # . /lava-11184064/environment/lava-11184=
064/bin/lava-test-runner /lava-11184064/1

    2023-08-01T13:05:27.708211  =


    2023-08-01T13:05:27.753498  / # /lava-11184064/bin/lava-test-runner /la=
va-11184064/1

    2023-08-01T13:05:27.794618  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T13:05:27.795121  + cd /lava-11184064/1/tests/1_boot<8>[   17=
.216443] <LAVA_SIGNAL_STARTRUN 1_bootrr 11184064_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
