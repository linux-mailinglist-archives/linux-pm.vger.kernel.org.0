Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC0696C6C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 19:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBNSIV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 13:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjBNSIH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 13:08:07 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0E5728D
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 10:07:52 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 16so10752906pfo.8
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6qQMra4r8cIghdcVqKziVGMh4HwkFhBaqwWWPWip7mM=;
        b=EObPi3o+xae77xLZ7fFeIYxmXlh6UDYCWIc1dWfvdJduMS/+TsMlUs5km1obk31b4O
         q1cju6JRtvc128YYXOmsrnYBe1Es6UAJxEksXImF3NLsPhmHo7I5W1SsfJF+M/48Hk5m
         axF+RfzqVrnj/cJPqqnuXRIcj/hDpVPyizBqY/IHjeuM0Ko/XEvXTEgILtImviHzTM+p
         DRoq3q9JupfledHMOnqKDFPHLHiKSvM2TV/alVPHYMQtF2d3TmRyMfWJ2OcLgQBIDnbu
         3ow38uKbfOOC8cLvqGZecjiGxE4+Kr9wZw98tUdfjNujSAqGIxP+LoWJ6UF4o2RtwZds
         23gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qQMra4r8cIghdcVqKziVGMh4HwkFhBaqwWWPWip7mM=;
        b=W+1cG1G5Cdd4/HVEre6psz5cMnkLYa2vOhsZJEnmDMyaL/lCmLsUZD+w6n7K0teN9W
         QGnCz54+ADDY0omJjcmv/vAxkUKw99W3JwMt3EQ1sSL3uDLOoNjK+COWRpscQwd+tlCw
         P4l2c3gE9daL+TiknFCx+gRhsc+AXeqrnis5ZnNBbX8LUReWwRaL/KIu+dnmqpqzrbM2
         h5MpL50NliyAPOY83atJlMsTUpqEVm2Mh2Q5EaB/1vPKqHh/QdRXgYuYMvLYZ+o4NjES
         jDHS19Oin7k5FEb0HerrKwVAvSjQTk5w3IASjor+IQtAy2UagvLlTbJw6t6bB0QmfIxw
         ES0A==
X-Gm-Message-State: AO0yUKVe85wWY4+zzbcj7XuYIVHB7P4vS8g1LuSZdrnGu/t3u6m/sWdB
        EbFqvoiy0YgqkxoQWX9uSCmeWA==
X-Google-Smtp-Source: AK7set+/JGdMrdqBjG96k5LW/BxOzfSZzWO9iIXY4lZNfe4kxIpc2bDJWcVvhF90cGItV60lIQ6a+A==
X-Received: by 2002:aa7:8bdb:0:b0:5a8:52d5:3bb9 with SMTP id s27-20020aa78bdb000000b005a852d53bb9mr3052868pfd.10.1676398072283;
        Tue, 14 Feb 2023 10:07:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c188-20020a6335c5000000b004fbd91d9716sm1286173pga.15.2023.02.14.10.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 10:07:51 -0800 (PST)
Message-ID: <63ebcdf7.630a0220.346dd.2416@mx.google.com>
Date:   Tue, 14 Feb 2023 10:07:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-6.2-rc9-244-gdfe08e56df2e
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 48 runs,
 5 regressions (pm-6.2-rc9-244-gdfe08e56df2e)
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

pm/testing baseline: 48 runs, 5 regressions (pm-6.2-rc9-244-gdfe08e56df2e)

Regressions Summary
-------------------

platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
imx53-qsrb             | arm    | lab-pengutronix | gcc-10   | multi_v7_def=
config | 1          =

qemu_i386-uefi         | i386   | lab-broonie     | gcc-10   | i386_defconf=
ig     | 1          =

qemu_i386-uefi         | i386   | lab-collabora   | gcc-10   | i386_defconf=
ig     | 1          =

qemu_x86_64-uefi       | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig   | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig   | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-6.2-r=
c9-244-gdfe08e56df2e/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-6.2-rc9-244-gdfe08e56df2e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      dfe08e56df2e9bb7d3b34e24284a28536063365b =



Test Regressions
---------------- =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
imx53-qsrb             | arm    | lab-pengutronix | gcc-10   | multi_v7_def=
config | 1          =


  Details:     https://kernelci.org/test/plan/id/63ebc37cb780049f7b8c864d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.2-rc9-244-gdfe=
08e56df2e/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.2-rc9-244-gdfe=
08e56df2e/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63ebc37cb780049f7b8c8656
        failing since 17 days (last pass: v6.1-rc8-156-g0a9e32afe717, first=
 fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-02-14T17:22:51.436610  [   12.928619] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-02-14T17:22:51.442257  + set +x
    2023-02-14T17:22:51.442626  [   12.939489] <LAVA_SIGNAL_ENDRUN 0_dmesg =
905827_1.5.2.3.1>
    2023-02-14T17:22:51.557433  / # #
    2023-02-14T17:22:51.658900  export SHELL=3D/bin/sh
    2023-02-14T17:22:51.659381  #
    2023-02-14T17:22:51.760703  / # export SHELL=3D/bin/sh. /lava-905827/en=
vironment
    2023-02-14T17:22:51.761138  =

    2023-02-14T17:22:51.862395  / # . /lava-905827/environment/lava-905827/=
bin/lava-test-runner /lava-905827/1
    2023-02-14T17:22:51.862878   =

    ... (13 line(s) more)  =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_i386-uefi         | i386   | lab-broonie     | gcc-10   | i386_defconf=
ig     | 1          =


  Details:     https://kernelci.org/test/plan/id/63ebc372b780049f7b8c8633

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.2-rc9-244-gdfe=
08e56df2e/i386/i386_defconfig/gcc-10/lab-broonie/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.2-rc9-244-gdfe=
08e56df2e/i386/i386_defconfig/gcc-10/lab-broonie/baseline-qemu_i386-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63ebc372b780049f7b8c8=
634
        failing since 0 day (last pass: v6.2-rc7-185-gbe3ba1769837, first f=
ail: v6.2-rc8-229-g00400047861d) =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_i386-uefi         | i386   | lab-collabora   | gcc-10   | i386_defconf=
ig     | 1          =


  Details:     https://kernelci.org/test/plan/id/63ebc2e353fffd64068c863f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.2-rc9-244-gdfe=
08e56df2e/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i386-uefi.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.2-rc9-244-gdfe=
08e56df2e/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i386-uefi.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63ebc2e353fffd64068c8=
640
        failing since 0 day (last pass: v6.2-rc7-185-gbe3ba1769837, first f=
ail: v6.2-rc8-229-g00400047861d) =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/63ebc3c216b4a65d058c86ba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.2-rc9-244-gdfe=
08e56df2e/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.2-rc9-244-gdfe=
08e56df2e/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63ebc3c216b4a65d058c8=
6bb
        failing since 0 day (last pass: pm-6.2-rc8-185-g61b7614c114c, first=
 fail: v6.2-rc8-229-g00400047861d) =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/63ebc3b016b4a65d058c8633

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.2-rc9-244-gdfe=
08e56df2e/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-u=
efi-mixed.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.2-rc9-244-gdfe=
08e56df2e/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-u=
efi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63ebc3b016b4a65d058c8=
634
        failing since 0 day (last pass: pm-6.2-rc8-185-g61b7614c114c, first=
 fail: v6.2-rc8-229-g00400047861d) =

 =20
