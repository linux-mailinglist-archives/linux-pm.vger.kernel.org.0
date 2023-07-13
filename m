Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE875256B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjGMOqU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjGMOqS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 10:46:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D6173F
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:46:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso539560b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689259576; x=1691851576;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VYy+dAoVfvjEWvK403PDlxADYZxn1xpzC5NSWCmkKxQ=;
        b=kOtNFbgQ47MVvOr2KjEFuAyDzgQHe03IZ1mkMaf9WN39HYepvJ8t/1wtHSdO+zKAtd
         zvQKPpEFmA+U0qkzFhtq2iP/PDlgrTqRFHhqClxDZcGZw4B+FuZCk1LyU0uxCPqk9Ilr
         HK8O7OPCATI2/0x0QNagU3NM58wS6lMFxRBCfz6EJMboQXwT5O0oNLRfVgt8U2RYrD03
         E5gxxCwU6f4aYF3dQ0/H2bp5X4WWmoFwkQb0h9SgTVccoxTcRHtyS6xytgRzcXt2QCVH
         wO1t8aCUY9p4A9cKJDWVA10iumKot2+O4nfnAzNLxkKyvJeLDNMF1xKw0CjZQl3us98m
         ednw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259576; x=1691851576;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYy+dAoVfvjEWvK403PDlxADYZxn1xpzC5NSWCmkKxQ=;
        b=Knuqjp2oyff7RJqjoDEMdLreEBOm0amsyaL3de+jAarmyTmn9NogJOmUCGDh1p+zRi
         9/RoTqN45Ns6sQ14LOeWu39LEfHVIrzxnWt2jB4xgtdPWY12E2fA3YB50mzZwpXN9/tk
         OL2IWNmlCQIhHowhTUHBm4NTbNs1BMVXXxNvbGe71TgRs4K9CKlbN7pIp+v+Xp83VXR7
         IMlYMTgkicVNFevL70uKCfifsP1Mg/tEAZyhBKbfFdibNVO62DsYoM732LJeyqdLdyCz
         8nyw9HZ0EzFP9irom29aUBd53b3gussac9DSKehjsjTxRDpg6h0DzKmf5fk24HezkaP7
         8cqg==
X-Gm-Message-State: ABy/qLYMTQAfZcs5EmUgfmYwQW8s0Ll5vGHO1iNXLhgQ6Ar+BTqQXtk4
        +rw1pfAaxvrHjcHWH6Tam19o6A==
X-Google-Smtp-Source: APBJJlFwl/HXl+/wFlQje38V0hl/c3u/BMdUO7VQQV6HgoPeHL+mniiGo/+2Z10iqdIYDjPr0B1tLw==
X-Received: by 2002:a05:6a00:1509:b0:682:4801:93d3 with SMTP id q9-20020a056a00150900b00682480193d3mr1569777pfu.31.1689259576463;
        Thu, 13 Jul 2023 07:46:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m13-20020aa78a0d000000b006828ee9fa69sm5526029pfa.206.2023.07.13.07.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:46:15 -0700 (PDT)
Message-ID: <64b00e37.a70a0220.661b8.c419@mx.google.com>
Date:   Thu, 13 Jul 2023 07:46:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc1-26-g998829ca60f7
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 48 runs,
 4 regressions (v6.5-rc1-26-g998829ca60f7)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 48 runs, 4 regressions (v6.5-rc1-26-g998829ca60f7)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
fsl-lx2160a-rdb              | arm64 | lab-nxp       | gcc-10   | defconfig=
 | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
 | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
 | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc1=
-26-g998829ca60f7/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc1-26-g998829ca60f7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      998829ca60f7d9d396281f6c1276bf991ab8068d =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
fsl-lx2160a-rdb              | arm64 | lab-nxp       | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b00413f6917fd26c8ace22

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc1-26-g998829=
ca60f7/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc1-26-g998829=
ca60f7/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b00413f6917fd26c8ace27
        failing since 119 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-07-13T14:02:31.377747  [   13.180571] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1236289_1.5.2.4.1>
    2023-07-13T14:02:31.483345  =

    2023-07-13T14:02:31.584571  / # #export SHELL=3D/bin/sh
    2023-07-13T14:02:31.584996  =

    2023-07-13T14:02:31.685953  / # export SHELL=3D/bin/sh. /lava-1236289/e=
nvironment
    2023-07-13T14:02:31.686408  =

    2023-07-13T14:02:31.787509  / # . /lava-1236289/environment/lava-123628=
9/bin/lava-test-runner /lava-1236289/1
    2023-07-13T14:02:31.788210  =

    2023-07-13T14:02:31.792175  / # /lava-1236289/bin/lava-test-runner /lav=
a-1236289/1
    2023-07-13T14:02:31.814140  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b0048b122c0487418ace53

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc1-26-g998829=
ca60f7/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc1-26-g998829=
ca60f7/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b0048b122c0487418ac=
e54
        failing since 1 day (last pass: v6.4-rc7-126-gf28ec6369334, first f=
ail: v6.5-rc1-15-g61ca8e67fe61) =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b003b06f9c2992348ace2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc1-26-g998829=
ca60f7/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc1-26-g998829=
ca60f7/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b003b06f9c2992348ac=
e2d
        new failure (last pass: v6.5-rc1-21-g3c61a03588dd8) =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b00495aab80afd558ace1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc1-26-g998829=
ca60f7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc1-26-g998829=
ca60f7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b00495aab80afd558ac=
e1e
        new failure (last pass: v6.5-rc1-21-g3c61a03588dd8) =

 =20
