Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8FC67A360
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 20:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjAXTtc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 14:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjAXTtc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 14:49:32 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3304C66F
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 11:49:29 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b24-20020a17090a551800b0022beefa7a23so2980620pji.5
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 11:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SUvbV9PRMI3FTN1TGsA5mLwjbHJCsxKrq7dtEI3Cv1g=;
        b=k4IMsxvTjqgyghoKeqg+/xrKlpIcpuan89KMx8S8B9u39+5NFRmyfw8RAVg3vcIJwM
         YAB81ICR4lmFCwE+GEhsSe/ph6lIa/SH3Xp/6seEuzDq+mEkZm5ipzV1xnQHQ8/NtpKg
         Av5qcVDlwUSOQjKRLqq7fINc+pIxI+jvgtlbNsuyL8zZOAhrtMTMj8tbHO/iG2yzVBcG
         /0udhggFivOvH7u6WrLoWfGcArJhYiJBEaykxjkuMT3WQPPIcvP2O5vEjPjdRBPF+Dfn
         EBeMC82mSvpmFFilD3uCjCO7IuLQmmCJY2ueXkNZ4XMOR6Gg7uMslnMhaOXthN8sLM15
         n0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUvbV9PRMI3FTN1TGsA5mLwjbHJCsxKrq7dtEI3Cv1g=;
        b=GGOWobMv0DR+WfJUN7SJEuUJV4ovAVUCVOB0E4hzIBRgWpG4uI3SlIf7DhWyAL/xty
         xR7zsmiVrim5K+IpdYxNRgc9jSQXV3e1Y0XuhN54dZiPLO81Z9dgVyQK4eKCKVFcy8jn
         JzlwVYuC/qvrmtvaRJihAKDJA8VhJbVuILHG5Jg9xLK2ZdgxQYmRCGs5xBLl6qtoIFVa
         LYxC9SxS93Q2VoP5vJ+1PXSYfcG6pa1KFmLJyj/CYdCRVaSJYGqe6gYQM3c95WRY7w6Y
         KUaGBBmy/nDpdu0St8tpSqZuoYQgdieBNR87GAJ6TydN6kx/4LpQG+k5c34VlJ2G+LE4
         wD0w==
X-Gm-Message-State: AO0yUKUXMcGQrjGsKiixi8av1fnqDpRxyAZjC57d9rvxfOOzaD7r21TM
        manXKTlefpTHoFf3TVL7TSHQht8aFFcPw7VwvWM=
X-Google-Smtp-Source: AK7set/uPDfpEP3FCMvyfI1s4/ZMJVq0RDCUBFLS3KwKWhFEZLzvbxewWMszkxF+HtFkBLRzgQ4BuQ==
X-Received: by 2002:a05:6a20:8f20:b0:bb:9ad9:4967 with SMTP id b32-20020a056a208f2000b000bb9ad94967mr4196651pzk.44.1674589769109;
        Tue, 24 Jan 2023 11:49:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d4-20020a63a704000000b0047850cecbdesm1766121pgf.69.2023.01.24.11.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:49:28 -0800 (PST)
Message-ID: <63d03648.630a0220.2ae67.2e46@mx.google.com>
Date:   Tue, 24 Jan 2023 11:49:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-95-gc37ccd838159
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 68 runs,
 6 regressions (v6.2-rc5-95-gc37ccd838159)
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

pm/testing baseline: 68 runs, 6 regressions (v6.2-rc5-95-gc37ccd838159)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
cubietruck                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =

kontron-pitx-imx8m           | arm64 | lab-kontron  | gcc-10   | defconfig =
         | 2          =

meson-gxbb-p200              | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc5=
-95-gc37ccd838159/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc5-95-gc37ccd838159
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c37ccd8381598ce7a31a9606ba2dd1c1da289990 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
cubietruck                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d02e6b12978393b4915ec8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-95-gc37ccd=
838159/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-95-gc37ccd=
838159/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d02e6b12978393b4915ecd
        failing since 5 days (last pass: v6.1-rc8-176-gcb06e36a6532, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-24T19:15:28.617697  <8>[   13.929881] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3202951_1.5.2.4.1>
    2023-01-24T19:15:28.727454  / # #
    2023-01-24T19:15:28.831530  export SHELL=3D/bin/sh
    2023-01-24T19:15:28.832797  #
    2023-01-24T19:15:28.935385  / # export SHELL=3D/bin/sh. /lava-3202951/e=
nvironment
    2023-01-24T19:15:28.936553  =

    2023-01-24T19:15:29.039240  / # . /lava-3202951/environment/lava-320295=
1/bin/lava-test-runner /lava-3202951/1
    2023-01-24T19:15:29.041012  =

    2023-01-24T19:15:29.045705  / # /lava-3202951/bin/lava-test-runner /lav=
a-3202951/1
    2023-01-24T19:15:29.137322  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
kontron-pitx-imx8m           | arm64 | lab-kontron  | gcc-10   | defconfig =
         | 2          =


  Details:     https://kernelci.org/test/plan/id/63d02989c3a9a7fc9f915ecf

  Results:     51 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-95-gc37ccd=
838159/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-95-gc37ccd=
838159/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d02989c3a9a7fc9f915ed2
        failing since 0 day (last pass: v6.2-rc4-80-gafd822f01cda, first fa=
il: v6.2-rc5-85-gfaa268e6daed)

    2023-01-24T18:54:46.471391  / # #
    2023-01-24T18:54:46.573268  export SHELL=3D/bin/sh
    2023-01-24T18:54:46.573695  #
    2023-01-24T18:54:46.675088  / # export SHELL=3D/bin/sh. /lava-254611/en=
vironment
    2023-01-24T18:54:46.675527  =

    2023-01-24T18:54:46.776956  / # . /lava-254611/environment/lava-254611/=
bin/lava-test-runner /lava-254611/1
    2023-01-24T18:54:46.777695  =

    2023-01-24T18:54:46.783703  / # /lava-254611/bin/lava-test-runner /lava=
-254611/1
    2023-01-24T18:54:46.847556  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-24T18:54:46.847867  + cd /l<8>[   15.889668] <LAVA_SIGNAL_START=
RUN 1_bootrr 254611_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/63d=
02989c3a9a7fc9f915ee2
        failing since 0 day (last pass: v6.2-rc4-80-gafd822f01cda, first fa=
il: v6.2-rc5-85-gfaa268e6daed)

    2023-01-24T18:54:50.907979  /lava-254611/1/../bin/lava-test-case
    2023-01-24T18:54:50.908350  <8>[   20.114655] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-01-24T18:54:50.908593  /lava-254611/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
meson-gxbb-p200              | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/63d029dae06c4ca0de915ecc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-95-gc37ccd=
838159/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-95-gc37ccd=
838159/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d029dae06c4ca0de915=
ecd
        new failure (last pass: v6.2-rc5-85-gfaa268e6daed) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d02c221fb89389e2915ed3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-95-gc37ccd=
838159/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-95-gc37ccd=
838159/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d02c221fb89389e2915ed8
        failing since 5 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-24T19:05:39.764433  <8>[   11.067557] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3202953_1.5.2.4.1>
    2023-01-24T19:05:39.869740  / # #
    2023-01-24T19:05:39.971445  export SHELL=3D/bin/sh
    2023-01-24T19:05:39.971790  #
    2023-01-24T19:05:40.073144  / # export SHELL=3D/bin/sh. /lava-3202953/e=
nvironment
    2023-01-24T19:05:40.073502  =

    2023-01-24T19:05:40.174860  / # . /lava-3202953/environment/lava-320295=
3/bin/lava-test-runner /lava-3202953/1
    2023-01-24T19:05:40.175526  =

    2023-01-24T19:05:40.195180  / # /lava-3202953/bin/lava-test-runner /lav=
a-3202953/1
    2023-01-24T19:05:40.284116  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
sun8i-h3-libretech-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d02c092aa3f4d649915ebd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-95-gc37ccd=
838159/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-95-gc37ccd=
838159/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d02c092aa3f4d649915ec2
        failing since 5 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-24T19:05:29.896840  / # #
    2023-01-24T19:05:29.998671  export SHELL=3D/bin/sh
    2023-01-24T19:05:29.999027  #
    2023-01-24T19:05:30.100375  / # export SHELL=3D/bin/sh. /lava-3202952/e=
nvironment
    2023-01-24T19:05:30.100732  =

    2023-01-24T19:05:30.202084  / # . /lava-3202952/environment/lava-320295=
2/bin/lava-test-runner /lava-3202952/1
    2023-01-24T19:05:30.202751  =

    2023-01-24T19:05:30.207776  / # /lava-3202952/bin/lava-test-runner /lav=
a-3202952/1
    2023-01-24T19:05:30.314588  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-24T19:05:30.315162  + cd /lava-3202952/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
