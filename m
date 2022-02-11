Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EB74B1A88
	for <lists+linux-pm@lfdr.de>; Fri, 11 Feb 2022 01:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346416AbiBKAjT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Feb 2022 19:39:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346413AbiBKAjS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Feb 2022 19:39:18 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8DA5F6E
        for <linux-pm@vger.kernel.org>; Thu, 10 Feb 2022 16:39:18 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a39so12460804pfx.7
        for <linux-pm@vger.kernel.org>; Thu, 10 Feb 2022 16:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qiK/v7FeVRbaPSjaExX4Yoje5XZ9+hJWW/EBMA73w/c=;
        b=F8fW2MrUFKaZ4nBh+WwRc0fcISuEyCvHbKg5utP3XKilBPX/dpZaaA+4MjoyVR+g7r
         f4l6wgYYf32BsdNfVfIAyvkGKMTGTzCiZGYhbGG61wo7lb2P5N7QCmgxtAlzUI8E8HGZ
         ZZ7BrsTpvepkvkGkWPnwJkOZ71+Jran3XjeRiLCg1/ScIZ+K2Lqf8UgP7ByN8LF5T3qB
         hV0eHs/NziRcafaFlaQzFSpBm3A9072lglM7SUwp7K+pwdWDIb1yj8z5FCfMgidTXcAP
         l3H6lhJJvpKsg2wuCaLd5deL0DOA968kZNREBhD4B5Fb6PGBrKGVDpJMLa9RZgI9mxJU
         B2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qiK/v7FeVRbaPSjaExX4Yoje5XZ9+hJWW/EBMA73w/c=;
        b=T/wXU6rxLX4zc+0mZ8GYJ1aT+TZZg0AYUdqihik0AgsFv78Uj+9HZBrldj7jXertLf
         CoxIdCuIgk/Z9XTt62HnRAHaNzu0l8UqvpiEsTuC1+lAZmxzkwMc6SveSRujNzB4GvzJ
         Ap/aIYcLheeRnArHIgFxLHqLPK1ZNQsHbQfqCPBLeB92xCL3synO2kAaqeQEeoHTjym7
         /lZ494w4gFDk/Rqlv6uflvORn+MW6nGjnnRvlucy8sAKXwLB7V4JEa/7avKCH2Fz53wp
         sT9d0Syd8AfNZgfF07OVZGetFRWcZZBsOmBA+jw8tUQRBhtG0PJJLq6pQxU6izrxdHqE
         Y2Zw==
X-Gm-Message-State: AOAM5320TfXeihzleDj2QW0VnwUgXh/LOQEpllyQuMTA/fS1SuDciWci
        /zc1mbbvZMHRxwGQyqWYESAnVw==
X-Google-Smtp-Source: ABdhPJyAH/4c/3Cqo2EDEJZZBzW7OK9QByxOQ5QViXFwHLvY4ehjRwJ46oxZNARARWvLxNZtVp86Zw==
X-Received: by 2002:a63:ab48:: with SMTP id k8mr8338815pgp.232.1644539957560;
        Thu, 10 Feb 2022 16:39:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z27sm17520180pgk.78.2022.02.10.16.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:39:17 -0800 (PST)
Message-ID: <6205b035.1c69fb81.36269.cdb3@mx.google.com>
Date:   Thu, 10 Feb 2022 16:39:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc3-39-g9b044ca4ac33
Subject: pm/testing baseline: 60 runs,
 12 regressions (v5.17-rc3-39-g9b044ca4ac33)
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

pm/testing baseline: 60 runs, 12 regressions (v5.17-rc3-39-g9b044ca4ac33)

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
3-39-g9b044ca4ac33/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc3-39-g9b044ca4ac33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      9b044ca4ac33454a5fdf1254867bde83228eedcc =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
kontron-kbox-a-230-ls      | arm64 | lab-kontron  | gcc-10   | defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/6205a6fe7344138494c62985

  Results:     91 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6205a6fe7344138494c629ca
        failing since 16 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1)

    2022-02-10T23:59:47.602281  /lava-86996/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-probed: https://kernelci.org/test/case/id/620=
5a6fe7344138494c629cb
        failing since 16 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1)

    2022-02-10T23:59:47.605419  <8>[   18.416468] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>
    2022-02-10T23:59:48.656343  /lava-86996/1/../bin/lava-test-case
    2022-02-10T23:59:48.656734  <8>[   19.436361] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-probed RESULT=3Dfail>
    2022-02-10T23:59:48.656896  /lava-86996/1/../bin/lava-test-case
    2022-02-10T23:59:48.657043  <8>[   19.452470] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsimple-mfd-i2c-driver-present RESULT=3Dpass>
    2022-02-10T23:59:48.657192  /lava-86996/1/../bin/lava-test-case
    2022-02-10T23:59:48.657335  <8>[   19.468436] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsimple-mfd-i2c-probed RESULT=3Dpass>
    2022-02-10T23:59:48.657476  /lava-86996/1/../bin/lava-test-case   =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
kontron-sl28-var3-ads2     | arm64 | lab-kontron  | gcc-10   | defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/6205a6c0f69650838bc62979

  Results:     99 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6205a6c0f69650838bc629c5
        failing since 15 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1-9-g52d883c7bbae)

    2022-02-10T23:58:45.833835  /lava-86994/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-probed: https://kernelci.org/test/case/id/620=
5a6c0f69650838bc629c6
        failing since 15 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1-9-g52d883c7bbae)

    2022-02-10T23:58:45.837087  <8>[   13.540123] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>
    2022-02-10T23:58:46.884019  /lava-86994/1/../bin/lava-test-case
    2022-02-10T23:58:46.884466  <8>[   14.558875] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-probed RESULT=3Dfail>
    2022-02-10T23:58:46.884713  /lava-86994/1/../bin/lava-test-case
    2022-02-10T23:58:46.884944  <8>[   14.575682] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsimple-mfd-i2c-driver-present RESULT=3Dpass>   =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6205a6e6f8c6c8e0bbc6299b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6205a6e6f8c6c8e0bbc62=
99c
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6205a6838c23a816e8c62972

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6205a6838c23a816e8c62=
973
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6205a6e7f8c6c8e0bbc6299e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6205a6e7f8c6c8e0bbc62=
99f
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6205a6968c23a816e8c629b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6205a6968c23a816e8c62=
9b2
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6205a70f7c2a56b0a6c62974

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6205a70f7c2a56b0a6c62=
975
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6205a6868c23a816e8c62978

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6205a6868c23a816e8c62=
979
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6205a70eb369c2e70ac62968

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6205a70eb369c2e70ac62=
969
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6205a6858c23a816e8c62975

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-39-g9b044=
ca4ac33/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6205a6858c23a816e8c62=
976
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =20
