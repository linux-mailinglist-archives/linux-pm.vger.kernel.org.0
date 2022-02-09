Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4584AE6E0
	for <lists+linux-pm@lfdr.de>; Wed,  9 Feb 2022 03:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242877AbiBICkg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Feb 2022 21:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244757AbiBICQ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Feb 2022 21:16:29 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70684C06157B
        for <linux-pm@vger.kernel.org>; Tue,  8 Feb 2022 18:16:28 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i21so207313pfd.13
        for <linux-pm@vger.kernel.org>; Tue, 08 Feb 2022 18:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=f0sC0GB9PzRlxVhfslyR1erdy5XJymnBQceAY6zSvrc=;
        b=TxplA817mJer2ftdzeQd/2LzWI9kmLYicuuZd+qhPEDJk1irBM7vfiUUcX5GGOumPd
         Cn3ulQ00e0/rtHBlXYfwohB6dvhW4UfZePODG3XejO6J5UQdCmV6DnevV0QVOcC9oUez
         1vIjoQZRLKz5OTKnqveUYG0HYvi82cj4TpfQU4Ms70YnXugCxMryWKB0b2fkeVXXLy01
         PyC/K/iknOqWO/JH2Z1FWB9p8H2XnGJ5MPQyub2//7q42YJEFdue45m4td5jlULIqhhP
         fJ98RPnqnRTeqjLLJhnYlp2mi8le+2qJYLPiW5+oHJPYJEdtXbXE40/jaMb6mXXCH1DU
         TBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=f0sC0GB9PzRlxVhfslyR1erdy5XJymnBQceAY6zSvrc=;
        b=bxoi7e9xJPDP6eQ4QFIZZPDNGr4lcQgZrc4ox2uhEjPQSMr+6SPrAFKwR/nS9+RYI3
         cKoBy5u8UknqhcpzBviCoYXNfDxOtXVY2Oa2fdexVAYp2o4XtyDnnMb8eY9TD/QVZmLB
         RS3DWdfFsvt0LpOWQTF1/Df8NXfkFjwcsH3R3X4wGQCTBLbulVxV3nRMdTo953qfIfTw
         vpjm8UFVK8ueH6bvHoRQra7OgUacyhwNLGgLmfUD19zsQlkFwY5LoPLU9zsVuOIKRq4C
         N7UROYPyDwm8tJvEjLdD7KS/apXMy6QlkepDiKtY0Rf/Tp0yChYmICf9rqKSX508M+22
         LWLg==
X-Gm-Message-State: AOAM532c2PHu8bN38hUgO0Zvxbfq2LjN47+CtPtW3GHZLERJ60+mB+Gn
        UPKLCaknQITlLO4D5oEqFPMnRciv5RHbU8hF
X-Google-Smtp-Source: ABdhPJzZt+cSa8W1HA241FX9k2C7wQaZxw51IYIqy52fZa5vm5uI6r/xWyB+yvVIXgC3KgcqQDVS0g==
X-Received: by 2002:a63:8649:: with SMTP id x70mr167211pgd.564.1644372987903;
        Tue, 08 Feb 2022 18:16:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ms8sm3993142pjb.33.2022.02.08.18.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:16:27 -0800 (PST)
Message-ID: <620323fb.1c69fb81.67d91.afa1@mx.google.com>
Date:   Tue, 08 Feb 2022 18:16:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc3-35-g1e2d75f89fc7
Subject: pm/testing baseline: 66 runs,
 12 regressions (v5.17-rc3-35-g1e2d75f89fc7)
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

pm/testing baseline: 66 runs, 12 regressions (v5.17-rc3-35-g1e2d75f89fc7)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
kontron-kbox-a-230-ls      | arm64 | lab-kontron  | gcc-10   | defconfig | =
2          =

kontron-sl28-var3-ads2     | arm64 | lab-kontron  | gcc-10   | defconfig | =
2          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.17-rc=
3-35-g1e2d75f89fc7/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc3-35-g1e2d75f89fc7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1e2d75f89fc7f3cf192049c10594d9535a64b6ea =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
kontron-kbox-a-230-ls      | arm64 | lab-kontron  | gcc-10   | defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/620319c9ddf91037dcc629f8

  Results:     91 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/620319c9ddf91037dcc62a3d
        failing since 14 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1)

    2022-02-09T01:32:47.773474  /lava-85613/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-probed: https://kernelci.org/test/case/id/620=
319c9ddf91037dcc62a3e
        failing since 14 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1)

    2022-02-09T01:32:47.776604  <8>[   16.773782] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>
    2022-02-09T01:32:48.823023  /lava-85613/1/../bin/lava-test-case
    2022-02-09T01:32:48.823433  <8>[   17.792499] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-probed RESULT=3Dfail>
    2022-02-09T01:32:48.823676  /lava-85613/1/../bin/lava-test-case
    2022-02-09T01:32:48.823903  <8>[   17.808489] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsimple-mfd-i2c-driver-present RESULT=3Dpass>   =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
kontron-sl28-var3-ads2     | arm64 | lab-kontron  | gcc-10   | defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/620319c7ddf91037dcc62993

  Results:     99 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/620319c8ddf91037dcc629df
        failing since 13 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1-9-g52d883c7bbae)

    2022-02-09T01:32:44.297440  /lava-85612/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-probed: https://kernelci.org/test/case/id/620=
319c8ddf91037dcc629e0
        failing since 13 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1-9-g52d883c7bbae)

    2022-02-09T01:32:44.300954  <8>[   13.468599] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>
    2022-02-09T01:32:45.347938  /lava-85612/1/../bin/lava-test-case
    2022-02-09T01:32:45.348353  <8>[   14.487517] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-probed RESULT=3Dfail>
    2022-02-09T01:32:45.348597  /lava-85612/1/../bin/lava-test-case
    2022-02-09T01:32:45.348826  <8>[   14.504036] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsimple-mfd-i2c-driver-present RESULT=3Dpass>   =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620319218bdfff620ac6297b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620319218bdfff620ac62=
97c
        new failure (last pass: v5.17-rc3-33-g4e3e936b36f6) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6203195c4b39ddcd49c62969

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6203195c4b39ddcd49c62=
96a
        new failure (last pass: v5.17-rc3-33-g4e3e936b36f6) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620319785ee09c75dbc6298b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620319785ee09c75dbc62=
98c
        new failure (last pass: v5.17-rc3-33-g4e3e936b36f6) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6203197045bb752167c62992

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6203197045bb752167c62=
993
        new failure (last pass: v5.17-rc3-33-g4e3e936b36f6) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/62031933a2d974f86bc62990

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62031933a2d974f86bc62=
991
        new failure (last pass: v5.17-rc3-33-g4e3e936b36f6) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6203196e5ee09c75dbc6296c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6203196e5ee09c75dbc62=
96d
        new failure (last pass: v5.17-rc3-33-g4e3e936b36f6) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/62031920a2d974f86bc6297c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62031920a2d974f86bc62=
97d
        new failure (last pass: v5.17-rc3-33-g4e3e936b36f6) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/62031947cffef0fe07c62981

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-35-g1e2d7=
5f89fc7/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62031947cffef0fe07c62=
982
        new failure (last pass: v5.17-rc3-33-g4e3e936b36f6) =

 =20
