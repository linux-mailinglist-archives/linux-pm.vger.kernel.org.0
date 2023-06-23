Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D56E73BF35
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 22:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjFWUHr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjFWUHr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 16:07:47 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE89271F
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 13:07:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6687096c6ddso667875b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687550861; x=1690142861;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GSQ5hSw9dkxf7JF25cVAazmGZwKAIhgLcACWRxNXPdQ=;
        b=I1S0+Gj9AHOJk+YQcQd4bVQHbnDmoKW4nrk7oEBtHiDG2LNxclUPuQiTDoCukNH4Hs
         5nmuy5MRi8zrfQ67aOmgBfyqJRaJtXVQmI2xD5ypgt/ApnVn5W+zzV6sutlIWYJ1cKz4
         1CzX4vGJMuH/O1OqlSycFPC+HQb7rbNQp5mwpB3IurHxFWjI3TXhJ4zMxiWCwPQP/Zaq
         M0/aClEY1/9sXx/KvVUN2bEG4Zzj5QBnjdb3Z5mgiEbA2jNxoFxJQTegvTqTt1p7vp7s
         iHIT84oUsl41gxWymKpB1T7llddaKS3BLLna56d8sZ2faxFRCIrJVcZMPQp/Hl3KE0ef
         jyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687550861; x=1690142861;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSQ5hSw9dkxf7JF25cVAazmGZwKAIhgLcACWRxNXPdQ=;
        b=mGfjX1RxlT/uSi0ha33HP2oOOWCm8cuz8N72WOtvMUK32XqiN9CTs6thUNgwc+YcRj
         TxnWHqzycrZ1HF5uVm0v/GXdMWa87ibjnx9Ec81ivPcrDq20zfUJMtVV0gPR8bHPJSs7
         J8PN4zmC+gozpdveRtkwcu6vxHNzNjwetu3QksxeKmjc0Utrf05hh/AuxFaYQhKc8lf0
         tGfSdvuY33wW61zAw824Hf0DAj48TbRczM3dlJPXwZZLJDwsreLWNdBAo4MfrYw8t70D
         ej+qxr3cf+jZz08I9uxpahp9ptsMk8I1WdMrBwImQAbZMTO5DIO8z8looh5vHT3zOW8M
         5Gng==
X-Gm-Message-State: AC+VfDzMYGc5U4DWP0Iqeds/kQG0ueTMmPRFSi2ISReLSXJvkKUCoEWz
        pA1ikZtXLQpc8649mBVYhqbKKkDl6h8eeQkygPngwA==
X-Google-Smtp-Source: ACHHUZ7Ig4EZLsK5NDJQkczjF7XMka2nTXmS0E99LO79dCdIeEwxDjDxSzTxnGDXPvBWybhNKdWG2A==
X-Received: by 2002:a05:6a20:7fa9:b0:126:1f70:30e6 with SMTP id d41-20020a056a207fa900b001261f7030e6mr991664pzj.20.1687550860715;
        Fri, 23 Jun 2023 13:07:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b0064d34ace753sm6430998pfn.114.2023.06.23.13.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:07:40 -0700 (PDT)
Message-ID: <6495fb8c.a70a0220.c40b.df29@mx.google.com>
Date:   Fri, 23 Jun 2023 13:07:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.4-rc7-126-gf28ec6369334
Subject: pm/testing baseline: 54 runs,
 5 regressions (v6.4-rc7-126-gf28ec6369334)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 54 runs, 5 regressions (v6.4-rc7-126-gf28ec6369334)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =

imx8mm-innocomm-wb15-evk     | arm64 | lab-pengutronix | gcc-10   | defconf=
ig          | 1          =

qemu_i386-uefi               | i386  | lab-collabora   | gcc-10   | i386_de=
fconfig     | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora   | gcc-10   | defconf=
ig          | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.4-rc7=
-126-gf28ec6369334/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.4-rc7-126-gf28ec6369334
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f28ec636933467d6a13cbe9f37d97a74d13484b2 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6495f138d72a84a6f8306156

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc7-126-gf28ec=
6369334/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc7-126-gf28ec=
6369334/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6495f138d72a84a6f830615f
        failing since 147 days (last pass: v6.1-rc8-156-g0a9e32afe717, firs=
t fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-06-23T19:23:12.369324  + set +x
    2023-06-23T19:23:12.369683  [   13.135949] <LAVA_SIGNAL_ENDRUN 0_dmesg =
987154_1.5.2.3.1>
    2023-06-23T19:23:12.476833  / # #
    2023-06-23T19:23:12.578633  export SHELL=3D/bin/sh
    2023-06-23T19:23:12.579109  #
    2023-06-23T19:23:12.680332  / # export SHELL=3D/bin/sh. /lava-987154/en=
vironment
    2023-06-23T19:23:12.680770  =

    2023-06-23T19:23:12.782254  / # . /lava-987154/environment/lava-987154/=
bin/lava-test-runner /lava-987154/1
    2023-06-23T19:23:12.782996  =

    2023-06-23T19:23:12.786730  / # /lava-987154/bin/lava-test-runner /lava=
-987154/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx8mm-innocomm-wb15-evk     | arm64 | lab-pengutronix | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6495f0bfc1fc56b4233061fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc7-126-gf28ec=
6369334/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc7-126-gf28ec=
6369334/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6495f0bfc1fc56b423306=
1fc
        new failure (last pass: v6.4-rc7-121-g3eb3368746ef) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
qemu_i386-uefi               | i386  | lab-collabora   | gcc-10   | i386_de=
fconfig     | 1          =


  Details:     https://kernelci.org/test/plan/id/6495ec5eb1db081604306171

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc7-126-gf28ec=
6369334/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc7-126-gf28ec=
6369334/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i386-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6495ec5eb1db081604306=
172
        new failure (last pass: v6.4-rc7-121-g3eb3368746ef) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6495f26309bbd4ff63306196

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc7-126-gf28ec=
6369334/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc7-126-gf28ec=
6369334/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6495f26309bbd4ff63306=
197
        failing since 66 days (last pass: v6.3-rc6-135-g5235219c59f8, first=
 fail: v6.3-rc7-153-gbc538c8be4bd) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora   | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6495f1a886044a38fa30613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc7-126-gf28ec=
6369334/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc7-126-gf28ec=
6369334/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6495f1a886044a38fa306=
13c
        new failure (last pass: v6.4-rc7-121-g3eb3368746ef) =

 =20
