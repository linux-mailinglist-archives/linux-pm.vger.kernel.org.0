Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAD7B98A7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Oct 2023 01:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjJDXVV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Oct 2023 19:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjJDXVU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2023 19:21:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E89BC9
        for <linux-pm@vger.kernel.org>; Wed,  4 Oct 2023 16:21:16 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3af5fda8f6fso247116b6e.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Oct 2023 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696461675; x=1697066475; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgm7TGA8FumuxJVjfJvdxL0jzs2syhl4iTqhUKUVlH4=;
        b=20svLlBco071OeYq6P7bFzB5i219ew56gNuyT7zvBs9Qkp4FiavcQbRSbSd1hFtk3G
         N0Bua6eQjXF5fbbeSEAnFUk85LAWIEtMqegGnfAA60JaA2t2LB9E7HBPJIcOBSUePqoO
         qyarBs0uzxnNJGNUWMn6k1nx38mPvJcKoPkKdGmVm7I0EiQL+V7OWRwgrChJ8wdX5dW9
         m8JGQa/khpAPTTEFonA/DXmaxCkx2au0ONYQ2L3BGJu46TPwPwOvwAI8obY3/Ztww2yX
         ckmhgYwIoOAYLQdH54Z/kuEzuu8+wa5bIGOaugeH1Hgv3kUdZnwwYXzBxHXBjZQe6WlW
         W7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696461675; x=1697066475;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zgm7TGA8FumuxJVjfJvdxL0jzs2syhl4iTqhUKUVlH4=;
        b=UmZ1WuFqdPMxbywkh9iws1iKSUaEnPyTI/WyznypiKfHuO8+v5j2QaRKmOherWZU5V
         xQgisctHQQM9kayxOzeQ9qB/hcaTc/yll+8nFAwrXCulbUSEv4UbCzY0LpvRQlTkefUu
         XVaHv4MdIgXBL2cAJO+kHRW7vqoLHPHpE7rrdU0tx7DGjCjGbBh9d3mEhhHG0X7uLvkR
         c6WRUozOEuk5Jjk4VQjdB7nI/4T6qfZ1TUrSXL0Kq3qreXzMHC8DYzLcnl7fp/Q+rdEV
         uTcGLuY8pGaKDC3cdf1oQOoxt9nOK9brYUIg67uypRSwmhDtRBpUpiwKD2pRorv02Gxz
         YAHQ==
X-Gm-Message-State: AOJu0YwC7uxMOrmXvuLIZDKTjLf2+efPJ6fAfC2RA47/F4w8y47mGcgT
        YvnAtpUMCFvKVm/NoQYA6yxR1w==
X-Google-Smtp-Source: AGHT+IG2UiAu2LMMgwVhJlHvbOe5xvvHPTKaN92zeH7T/fnoXhufX5MQutk2ZrzwowUmdTcS55NBHA==
X-Received: by 2002:a05:6808:bca:b0:3a7:6b1c:8142 with SMTP id o10-20020a0568080bca00b003a76b1c8142mr4655307oik.25.1696461675458;
        Wed, 04 Oct 2023 16:21:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o7-20020a637307000000b0056b27af8715sm78751pgc.43.2023.10.04.16.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 16:21:14 -0700 (PDT)
Message-ID: <651df36a.630a0220.b74fa.0439@mx.google.com>
Date:   Wed, 04 Oct 2023 16:21:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc4-110-g087dbcb21272
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 48 runs,
 6 regressions (v6.6-rc4-110-g087dbcb21272)
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

pm/testing baseline: 48 runs, 6 regressions (v6.6-rc4-110-g087dbcb21272)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
bcm2711-rpi-4-b    | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

imx8mp-evk         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 2      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc4=
-110-g087dbcb21272/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc4-110-g087dbcb21272
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      087dbcb2127272bfc2419ec2dc1e19e6a030f3af =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
bcm2711-rpi-4-b    | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/651de9043f8544beec8a0a8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc4-110-g087db=
cb21272/arm64/defconfig/gcc-10/lab-collabora/baseline-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc4-110-g087db=
cb21272/arm64/defconfig/gcc-10/lab-collabora/baseline-bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651de9043f8544beec8a0=
a8e
        new failure (last pass: v6.6-rc3-95-g705ffbf392dc) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
imx8mp-evk         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/651de8d2e3f64ddf2a8a0a5c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc4-110-g087db=
cb21272/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc4-110-g087db=
cb21272/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651de8d2e3f64ddf2a8a0a65
        failing since 22 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, fir=
st fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-10-04T22:35:43.840688  + set<8>[   27.341092] <LAVA_SIGNAL_ENDRUN =
0_dmesg 154025_1.5.2.4.1>
    2023-10-04T22:35:43.841086   +x
    2023-10-04T22:35:43.946190  / # #
    2023-10-04T22:35:45.106010  export SHELL=3D/bin/sh
    2023-10-04T22:35:45.111622  #
    2023-10-04T22:35:46.603727  / # export SHELL=3D/bin/sh. /lava-154025/en=
vironment
    2023-10-04T22:35:46.609770  =

    2023-10-04T22:35:49.333358  / # . /lava-154025/environment/lava-154025/=
bin/lava-test-runner /lava-154025/1
    2023-10-04T22:35:49.340113  =

    2023-10-04T22:35:49.344873  / # /lava-154025/bin/lava-test-runner /lava=
-154025/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 2      =
    =


  Details:     https://kernelci.org/test/plan/id/651de89287e22f2b9f8a0adb

  Results:     51 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc4-110-g087db=
cb21272/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc4-110-g087db=
cb21272/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651de89287e22f2b9f8a0ae2
        new failure (last pass: v6.6-rc3-95-g705ffbf392dc)

    2023-10-04T22:34:33.724605  / # #
    2023-10-04T22:34:33.826667  export SHELL=3D/bin/sh
    2023-10-04T22:34:33.827374  #
    2023-10-04T22:34:33.928735  / # export SHELL=3D/bin/sh. /lava-384329/en=
vironment
    2023-10-04T22:34:33.929451  =

    2023-10-04T22:34:34.030765  / # . /lava-384329/environment/lava-384329/=
bin/lava-test-runner /lava-384329/1
    2023-10-04T22:34:34.031779  =

    2023-10-04T22:34:34.036315  / # /lava-384329/bin/lava-test-runner /lava=
-384329/1
    2023-10-04T22:34:34.102343  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-04T22:34:34.102772  + cd /l<8>[   15.876644] <LAVA_SIGNAL_START=
RUN 1_bootrr 384329_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/651=
de89287e22f2b9f8a0af2
        new failure (last pass: v6.6-rc3-95-g705ffbf392dc)

    2023-10-04T22:34:36.487363  /lava-384329/1/../bin/lava-test-case
    2023-10-04T22:34:36.487785  <8>[   18.357472] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-10-04T22:34:36.488079  /lava-384329/1/../bin/lava-test-case   =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/651de897ac66c335b88a0a60

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc4-110-g087db=
cb21272/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc4-110-g087db=
cb21272/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651de897ac66c335b88a0a69
        failing since 77 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-04T22:39:09.671218  / # #

    2023-10-04T22:39:09.773222  export SHELL=3D/bin/sh

    2023-10-04T22:39:09.773912  #

    2023-10-04T22:39:09.875253  / # export SHELL=3D/bin/sh. /lava-11681341/=
environment

    2023-10-04T22:39:09.876015  =


    2023-10-04T22:39:09.977473  / # . /lava-11681341/environment/lava-11681=
341/bin/lava-test-runner /lava-11681341/1

    2023-10-04T22:39:09.978576  =


    2023-10-04T22:39:09.980867  / # /lava-11681341/bin/lava-test-runner /la=
va-11681341/1

    2023-10-04T22:39:10.044331  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T22:39:10.044846  + cd /lava-116813<8>[   19.458332] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11681341_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/651de8aeac66c335b88a0ba0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc4-110-g087db=
cb21272/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc4-110-g087db=
cb21272/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651de8aeac66c335b88a0ba9
        failing since 77 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-04T22:37:31.411495  / # #

    2023-10-04T22:37:32.489728  export SHELL=3D/bin/sh

    2023-10-04T22:37:32.491439  #

    2023-10-04T22:37:33.980403  / # export SHELL=3D/bin/sh. /lava-11681346/=
environment

    2023-10-04T22:37:33.982033  =


    2023-10-04T22:37:36.702378  / # . /lava-11681346/environment/lava-11681=
346/bin/lava-test-runner /lava-11681346/1

    2023-10-04T22:37:36.704553  =


    2023-10-04T22:37:36.710933  / # /lava-11681346/bin/lava-test-runner /la=
va-11681346/1

    2023-10-04T22:37:36.773645  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T22:37:36.774125  + cd /lava-116813<8>[   28.515690] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11681346_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20
