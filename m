Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACA176A18D
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jul 2023 21:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGaT4C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jul 2023 15:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGaT4C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2023 15:56:02 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D904419A1
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 12:56:00 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a741f46fadso575956b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690833360; x=1691438160;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YIT1va+G+nH2I/nRjCuezmXJMRruGNYJotXA/FuK89c=;
        b=pzjKJpEvbERiY35FUoRjgKft1mTWrkzRNKCGSThUB9Dd0abrQMzeQBipAjGXbYmV4N
         89b91PLqJvVIDWnpMZFQsy+i4uHA5Xw3j1CCCQNaIiJKTiJNxaKQW6qE4Ifzf8D7WxZ/
         B2fYRKObhjv5rCiVD/DLl0SNOI4Ei+H5idBX1TlFULCq9Zs9oXe4EBP8ui6Jqa8anppm
         Ri1q03lW0RbkbiU5LlZOEGh0bOp1cyEGddgGtMBmaBEExi8U7VLfuyvrOFbh+CARFH5u
         vvW8lp3WbKnbsu+EEeFSHzRHBt/fdw3/7Bx+9wzUMLeRI37DJruxpuLa0qbmcCCwe0cZ
         4YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690833360; x=1691438160;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIT1va+G+nH2I/nRjCuezmXJMRruGNYJotXA/FuK89c=;
        b=Dj781ilyVjX4z1QyVstwsIzBDF3PhYkzXW7P0ovoyk0QMR7F+oMohXr6DbnrMMNq5d
         wdx4WbLg+yZ8KxqQyckDsErFyCzLEdciEA4wT1fT79en3Q6u2hElEPiJkneu+Yocc/fF
         /pOjc8UKBdU9l0XhPt3rDjPSV8vk6fPcWC9ylQJC7LMiqvfIR1nfQfFHGcl2Rj1CFQzZ
         0fZQlJqzufV70WaSqtpH95WpPp7UuVqmL+lvs9HVw3AZ5fT+Idim16uebq8x7KtJlBzh
         kRamcxbylLEEzcZu3eItAeCfn4jmQuW78ZAxuIGT6nahaeMJ7XQw5BWk48D0DJWmmY5a
         Qa+Q==
X-Gm-Message-State: ABy/qLaESn2XxNoeKfm7cnkHDQXfD5jobE7D1A3BT+VKx9nx+L3WLbR5
        8r0Ie2gM5lpjckHeki/8WJg1m3Un/fcMinpJ9gh3qQ==
X-Google-Smtp-Source: APBJJlG22rLL0a8/CAI1xNg8gdNVExhaJvUXN0Rcg3gQlFGlbaewF19Hot561E57tJ1A6XELfNGXpg==
X-Received: by 2002:a05:6808:2cb:b0:3a4:67b6:454e with SMTP id a11-20020a05680802cb00b003a467b6454emr10608630oid.6.1690833360147;
        Mon, 31 Jul 2023 12:56:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005638a70110bsm8353275pgc.65.2023.07.31.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 12:55:59 -0700 (PDT)
Message-ID: <64c811cf.630a0220.37ad8.ffe2@mx.google.com>
Date:   Mon, 31 Jul 2023 12:55:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc4-47-g015a64bab2b55
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 49 runs,
 5 regressions (v6.5-rc4-47-g015a64bab2b55)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 49 runs, 5 regressions (v6.5-rc4-47-g015a64bab2b55)

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
-47-g015a64bab2b55/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc4-47-g015a64bab2b55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      015a64bab2b55aca17cb15373d780fde0c869169 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
fsl-ls2088a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64c807c632defac50d8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-47-g015a64=
bab2b55/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-47-g015a64=
bab2b55/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c807c632defac50d8ace1f
        failing since 17 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-07-31T19:12:57.396640  [   12.601756] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1239732_1.5.2.4.1>
    2023-07-31T19:12:57.502023  =

    2023-07-31T19:12:57.603204  / # #export SHELL=3D/bin/sh
    2023-07-31T19:12:57.603642  =

    2023-07-31T19:12:57.704592  / # export SHELL=3D/bin/sh. /lava-1239732/e=
nvironment
    2023-07-31T19:12:57.705061  =

    2023-07-31T19:12:57.806075  / # . /lava-1239732/environment/lava-123973=
2/bin/lava-test-runner /lava-1239732/1
    2023-07-31T19:12:57.806750  =

    2023-07-31T19:12:57.810755  / # /lava-1239732/bin/lava-test-runner /lav=
a-1239732/1
    2023-07-31T19:12:57.834917  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
fsl-lx2160a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64c808501b4aa6db978ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-47-g015a64=
bab2b55/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-47-g015a64=
bab2b55/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c808501b4aa6db978ace1f
        failing since 137 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-07-31T19:15:17.812251  [   12.493030] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1239733_1.5.2.4.1>
    2023-07-31T19:15:17.917447  =

    2023-07-31T19:15:18.018616  / # #export SHELL=3D/bin/sh
    2023-07-31T19:15:18.019058  =

    2023-07-31T19:15:18.120035  / # export SHELL=3D/bin/sh. /lava-1239733/e=
nvironment
    2023-07-31T19:15:18.120443  =

    2023-07-31T19:15:18.221413  / # . /lava-1239733/environment/lava-123973=
3/bin/lava-test-runner /lava-1239733/1
    2023-07-31T19:15:18.222084  =

    2023-07-31T19:15:18.226044  / # /lava-1239733/bin/lava-test-runner /lav=
a-1239733/1
    2023-07-31T19:15:18.248647  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64c807a4190fb2a7fc8acf68

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-47-g015a64=
bab2b55/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-47-g015a64=
bab2b55/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c807a4190fb2a7fc8acf6d
        failing since 11 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-07-31T19:13:56.597941  / # #

    2023-07-31T19:13:56.700035  export SHELL=3D/bin/sh

    2023-07-31T19:13:56.700835  #

    2023-07-31T19:13:56.801970  / # export SHELL=3D/bin/sh. /lava-11178181/=
environment

    2023-07-31T19:13:56.802499  =


    2023-07-31T19:13:56.903670  / # . /lava-11178181/environment/lava-11178=
181/bin/lava-test-runner /lava-11178181/1

    2023-07-31T19:13:56.904714  =


    2023-07-31T19:13:56.920938  / # /lava-11178181/bin/lava-test-runner /la=
va-11178181/1

    2023-07-31T19:13:56.971406  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-31T19:13:56.971882  + cd /lav<8>[   19.339039] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11178181_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64c807cf32defac50d8ace48

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-47-g015a64=
bab2b55/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-47-g015a64=
bab2b55/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c807cf32defac50d8ace4d
        failing since 11 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-07-31T19:13:20.204562  / # #

    2023-07-31T19:13:21.285243  export SHELL=3D/bin/sh

    2023-07-31T19:13:21.287037  #

    2023-07-31T19:13:22.778429  / # export SHELL=3D/bin/sh. /lava-11178176/=
environment

    2023-07-31T19:13:22.780391  =


    2023-07-31T19:13:25.503407  / # . /lava-11178176/environment/lava-11178=
176/bin/lava-test-runner /lava-11178176/1

    2023-07-31T19:13:25.505829  =


    2023-07-31T19:13:25.513931  / # /lava-11178176/bin/lava-test-runner /la=
va-11178176/1

    2023-07-31T19:13:25.575416  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-31T19:13:25.575935  + cd /lava-111781<8>[   28.557350] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11178176_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64c8086a1b4aa6db978ace2a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-47-g015a64=
bab2b55/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-47-g015a64=
bab2b55/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8086a1b4aa6db978ace2f
        failing since 11 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-07-31T19:17:28.892487  / # #

    2023-07-31T19:17:28.994667  export SHELL=3D/bin/sh

    2023-07-31T19:17:28.994920  #

    2023-07-31T19:17:29.095670  / # export SHELL=3D/bin/sh. /lava-11178170/=
environment

    2023-07-31T19:17:29.096402  =


    2023-07-31T19:17:29.197709  / # . /lava-11178170/environment/lava-11178=
170/bin/lava-test-runner /lava-11178170/1

    2023-07-31T19:17:29.198839  =


    2023-07-31T19:17:29.201548  / # /lava-11178170/bin/lava-test-runner /la=
va-11178170/1

    2023-07-31T19:17:29.284109  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-31T19:17:29.284271  + cd /lava-11178170/1/tests/1_boot<8>[   17=
.004852] <LAVA_SIGNAL_STARTRUN 1_bootrr 11178170_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
