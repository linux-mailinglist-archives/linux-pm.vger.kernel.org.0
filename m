Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B05475A0A0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jul 2023 23:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGSVe2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jul 2023 17:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSVe1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2023 17:34:27 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E432B13E
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2023 14:34:25 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53482b44007so32300a12.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2023 14:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689802465; x=1692394465;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VoqRWCF/99Xh5x3xsosrwupY6V9YuWDUD1evgfinu8k=;
        b=qjAZtYrtoGh/JAgZzUT/+YAshSHkdDL0OvM4lbBhHAwndZhvcu+9x1F6SJ/wL5pt8l
         7tANCVbWhjDtfsslVWeVaZ87rNWAGEmZSxpF2mJkOijNRDHoGK7rqUqDv70COW6mj2lk
         K/evru6iubvLGWvakm/7S1FxLaRgcn7nGIRnv2cAdJ5AYWbuxgHOKG3Z3SmDWZMcOvFu
         MIkaroieZN3Gyb/47LjBwu67o+FfQ3zv7mmMEp0+GMKlzMd8zujCcoKwNZhzzn+C3N9r
         X/WjGNsBlgcz1ZolWRl0R04jipousSiq7UA380KkgqR3udcRX9vou+5B5ccbw2Qv19BD
         0gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802465; x=1692394465;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VoqRWCF/99Xh5x3xsosrwupY6V9YuWDUD1evgfinu8k=;
        b=BCpjx91QWFEPReYZegamRUeDO2KvkQz7Bce3q4qlYnMU2czrW0WJNOYsflE2c5alGw
         hmW2p/h9Sn/HbsXTD4yAD+vDWruDR8x5nzv2XYnQgUCM7N/ljz847qYaIi9mAkFSq23u
         X9cBIMK2RuOjjkd91GjNvGs4ctNPqkwNP83R4lJ7hZf1B7AVZybWwzbI+F/yHJp5Kg4T
         RRnBkR6GhzQ+rWqEe5StSm+9gZTI5JW5lXoGxhsC5AGdl+j/gnRKultPxxyr7DQO1VQA
         U2XS9CES5MrPQdIhyWFfY7eklsCjcF9z9rl4Ltx48F1tu1AZ5dMVNkw7bN7eiAhICGHr
         Y36g==
X-Gm-Message-State: ABy/qLa7f9PQWd+sbgMwySJew5tIpM6K7duSdxHeoToJmj4G47TjDxl/
        RnhTdtAZiiG1bUkRWgQBKilhb+S5ZnTZZq4TKOA/TA==
X-Google-Smtp-Source: APBJJlEvID/j9I5qHJ1+irmHfVa7rRpyHRlHBAAvN2VHrRcibEX3ZC8fGNKIEFUEikeNhHo8DYci9w==
X-Received: by 2002:a17:90b:1b0a:b0:260:9cad:c56d with SMTP id nu10-20020a17090b1b0a00b002609cadc56dmr815858pjb.7.1689802465291;
        Wed, 19 Jul 2023 14:34:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x11-20020a17090aa38b00b002609cadc56esm1556568pjp.11.2023.07.19.14.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:34:24 -0700 (PDT)
Message-ID: <64b856e0.170a0220.258ab.3395@mx.google.com>
Date:   Wed, 19 Jul 2023 14:34:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc2-44-g6384f300e9f3
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 49 runs,
 6 regressions (v6.5-rc2-44-g6384f300e9f3)
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

pm/testing baseline: 49 runs, 6 regressions (v6.5-rc2-44-g6384f300e9f3)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
fsl-ls2088a-rdb              | arm64 | lab-nxp       | gcc-10   | defconfig=
 | 1          =

fsl-lx2160a-rdb              | arm64 | lab-nxp       | gcc-10   | defconfig=
 | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =

r8a779m1-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
 | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc2=
-44-g6384f300e9f3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc2-44-g6384f300e9f3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      6384f300e9f3c5baed9ea999c386cf95c9dc6ba0 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
fsl-ls2088a-rdb              | arm64 | lab-nxp       | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b84d13635af3a71c8ace21

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b84d13635af3a71c8ace24
        failing since 5 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first f=
ail: v6.5-rc1-21-g3c61a03588dd8)

    2023-07-19T20:52:23.207730  [   16.998856] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237706_1.5.2.4.1>
    2023-07-19T20:52:23.312914  =

    2023-07-19T20:52:23.414044  / # #export SHELL=3D/bin/sh
    2023-07-19T20:52:23.414443  =

    2023-07-19T20:52:23.515364  / # export SHELL=3D/bin/sh. /lava-1237706/e=
nvironment
    2023-07-19T20:52:23.515810  =

    2023-07-19T20:52:23.616800  / # . /lava-1237706/environment/lava-123770=
6/bin/lava-test-runner /lava-1237706/1
    2023-07-19T20:52:23.617940  =

    2023-07-19T20:52:23.620815  / # /lava-1237706/bin/lava-test-runner /lav=
a-1237706/1
    2023-07-19T20:52:23.643070  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
fsl-lx2160a-rdb              | arm64 | lab-nxp       | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b84d27635af3a71c8ace2f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b84d27635af3a71c8ace32
        failing since 125 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-07-19T20:52:37.439898  [   16.462862] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237709_1.5.2.4.1>
    2023-07-19T20:52:37.545888  =

    2023-07-19T20:52:37.647160  / # #export SHELL=3D/bin/sh
    2023-07-19T20:52:37.647604  =

    2023-07-19T20:52:37.748577  / # export SHELL=3D/bin/sh. /lava-1237709/e=
nvironment
    2023-07-19T20:52:37.748984  =

    2023-07-19T20:52:37.849991  / # . /lava-1237709/environment/lava-123770=
9/bin/lava-test-runner /lava-1237709/1
    2023-07-19T20:52:37.850683  =

    2023-07-19T20:52:37.854522  / # /lava-1237709/bin/lava-test-runner /lav=
a-1237709/1
    2023-07-19T20:52:37.877083  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b84ca60cd8a5ce078acea5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b84ca60cd8a5ce078aceaa
        new failure (last pass: pm-6.5-rc2-210-ga648a2d354da)

    2023-07-19T20:52:09.282183  / # #

    2023-07-19T20:52:09.382836  export SHELL=3D/bin/sh

    2023-07-19T20:52:09.383105  #

    2023-07-19T20:52:09.483690  / # export SHELL=3D/bin/sh. /lava-11115038/=
environment

    2023-07-19T20:52:09.483919  =


    2023-07-19T20:52:09.584474  / # . /lava-11115038/environment/lava-11115=
038/bin/lava-test-runner /lava-11115038/1

    2023-07-19T20:52:09.584775  =


    2023-07-19T20:52:09.595772  / # /lava-11115038/bin/lava-test-runner /la=
va-11115038/1

    2023-07-19T20:52:09.637084  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T20:52:09.654827  + cd /lava-111150<8>[   20.204436] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11115038_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
r8a779m1-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b84ccd74704515b78ace1d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b84cce74704515b78ace22
        new failure (last pass: pm-6.5-rc2-210-ga648a2d354da)

    2023-07-19T20:51:13.609834  / # #

    2023-07-19T20:51:14.688557  export SHELL=3D/bin/sh

    2023-07-19T20:51:14.689873  #

    2023-07-19T20:51:16.177825  / # export SHELL=3D/bin/sh. /lava-11115048/=
environment

    2023-07-19T20:51:16.179133  =


    2023-07-19T20:51:18.895688  / # . /lava-11115048/environment/lava-11115=
048/bin/lava-test-runner /lava-11115048/1

    2023-07-19T20:51:18.897179  =


    2023-07-19T20:51:18.904613  / # /lava-11115048/bin/lava-test-runner /la=
va-11115048/1

    2023-07-19T20:51:18.967115  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T20:51:18.967198  + cd /lava-111150<8>[   28.490101] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11115048_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b84cfca25d251b1a8ace29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b84cfca25d251b1a8ac=
e2a
        failing since 0 day (last pass: pm-6.5-rc2-210-ga648a2d354da, first=
 fail: v6.5-rc2-42-g6e9908abf1d1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b84cb9abd081a3678aceac

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc2-44-g6384f3=
00e9f3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b84cb9abd081a3678aceb1
        new failure (last pass: pm-6.5-rc2-210-ga648a2d354da)

    2023-07-19T20:52:21.262464  / # #

    2023-07-19T20:52:21.364392  export SHELL=3D/bin/sh

    2023-07-19T20:52:21.365052  #

    2023-07-19T20:52:21.466187  / # export SHELL=3D/bin/sh. /lava-11115042/=
environment

    2023-07-19T20:52:21.466449  =


    2023-07-19T20:52:21.567181  / # . /lava-11115042/environment/lava-11115=
042/bin/lava-test-runner /lava-11115042/1

    2023-07-19T20:52:21.568090  =


    2023-07-19T20:52:21.571278  / # /lava-11115042/bin/lava-test-runner /la=
va-11115042/1

    2023-07-19T20:52:21.654068  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T20:52:21.654554  + cd /lava-11115042/1/tests/1_boot<8>[   17=
.860207] <LAVA_SIGNAL_STARTRUN 1_bootrr 11115042_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
