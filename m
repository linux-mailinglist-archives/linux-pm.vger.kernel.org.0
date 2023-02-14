Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928376955CE
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 02:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBNBS5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Feb 2023 20:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBNBS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 20:18:56 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76854ECA
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 17:18:55 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r8so15485610pls.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 17:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z6zgTozPaYeS3xGYPH1wZYWkUP/VfXxUFzeSEIzBwlY=;
        b=AgB0UjlCHOAb9MQ9reN5pRw2grDmepx4ceAhxRbi2vPQS3h/lswYQo49tIYbov5U9N
         EGqVzJM021RZzTItPvq7a/Hfj/yXTxrmvFGDcCcG7JdCj+7JlkOOwnBfZsBfj8CElf50
         Q7I4JQtjy53zLJ9mqXeAoGOjCa+FXQA4p6xNTw8LBnf2knrLxIi7ogEhUAL6lHt+FDLZ
         7vemwvhHIrfcNgtIxgfXfrkvZYWT51cv21cj7GnobGEv4/j7RQPMgtpiH3AAzHYRmB3T
         NWOGHFOx+lq1CkT35YyOGJKGMrCxV0yJ7jqM1tiPCKbdDitHgPGSY/f0LH/Ca7bud3wY
         5PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6zgTozPaYeS3xGYPH1wZYWkUP/VfXxUFzeSEIzBwlY=;
        b=HXbsF7aqV+yVK8YmbBKWQiCtqFU1xORljttSw7YspfpR4oZmw7asm/lRFjsG2sINjS
         fSYdEnyUf6/GcW/cB1IP0uSdDpB3paKvtqR+kJJPLhrR+bpVvVW4uipBW3tV09W3d7Dd
         XVefyV9jB/JQkIV2sSIudRadmWhpJPdVcZ8u0nt6a8AQc1ewEzCIPBrfMrgLOBqhzvJQ
         znNXh52RpE191bgefJkC9VS206WFgLyMLpsm6Bwqiz0VlXXYFYQ19Iy9gcx8YJ6lka+Z
         HB7tLCHrPQ4Hal82NLSlTkfj6vKUHDhoxtJU+vfTMYpZqcDlIfNjt6daaqVeK3p2I3hj
         VLYQ==
X-Gm-Message-State: AO0yUKU+rWPmhrAw9RNe2Wf8RDp8MgMvR6BkYxbjgECEb5O087npRrY/
        2MO1ik5TFVR7TuaxJ7zdbhXV+IssCVORxH3n6ec=
X-Google-Smtp-Source: AK7set9JV9Dhc3xe8W7e8wQnuxMTusE5hpXZ1UYaPX19P1mNT2zzLRkE01zQygaaLLUogCtHkdLifA==
X-Received: by 2002:a17:902:d14b:b0:19a:b683:e11f with SMTP id t11-20020a170902d14b00b0019ab683e11fmr560556plt.27.1676337535200;
        Mon, 13 Feb 2023 17:18:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902b70200b0019a7c890c5asm5777625pls.263.2023.02.13.17.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 17:18:54 -0800 (PST)
Message-ID: <63eae17e.170a0220.8fa6c.ae05@mx.google.com>
Date:   Mon, 13 Feb 2023 17:18:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.2-rc8-229-g00400047861d
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 47 runs,
 5 regressions (v6.2-rc8-229-g00400047861d)
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

pm/testing baseline: 47 runs, 5 regressions (v6.2-rc8-229-g00400047861d)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc8=
-229-g00400047861d/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc8-229-g00400047861d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      00400047861d75925de73c4e8929c447b1306afc =



Test Regressions
---------------- =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
imx53-qsrb             | arm    | lab-pengutronix | gcc-10   | multi_v7_def=
config | 1          =


  Details:     https://kernelci.org/test/plan/id/63ead287a04f9e4eba8c8679

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc8-229-g00400=
047861d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc8-229-g00400=
047861d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63ead287a04f9e4eba8c8682
        failing since 17 days (last pass: v6.1-rc8-156-g0a9e32afe717, first=
 fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-02-14T00:14:43.101020  + set +x
    2023-02-14T00:14:43.101424  [   12.866795] <LAVA_SIGNAL_ENDRUN 0_dmesg =
905125_1.5.2.3.1>
    2023-02-14T00:14:43.205925  / # #
    2023-02-14T00:14:43.307703  export SHELL=3D/bin/sh
    2023-02-14T00:14:43.308250  #
    2023-02-14T00:14:43.409501  / # export SHELL=3D/bin/sh. /lava-905125/en=
vironment
    2023-02-14T00:14:43.409923  =

    2023-02-14T00:14:43.511204  / # . /lava-905125/environment/lava-905125/=
bin/lava-test-runner /lava-905125/1
    2023-02-14T00:14:43.511878  =

    2023-02-14T00:14:43.515497  / # /lava-905125/bin/lava-test-runner /lava=
-905125/1 =

    ... (12 line(s) more)  =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_i386-uefi         | i386   | lab-broonie     | gcc-10   | i386_defconf=
ig     | 1          =


  Details:     https://kernelci.org/test/plan/id/63ead9162b53655d638c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc8-229-g00400=
047861d/i386/i386_defconfig/gcc-10/lab-broonie/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc8-229-g00400=
047861d/i386/i386_defconfig/gcc-10/lab-broonie/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63ead9162b53655d638c8=
631
        new failure (last pass: v6.2-rc7-185-gbe3ba1769837) =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_i386-uefi         | i386   | lab-collabora   | gcc-10   | i386_defconf=
ig     | 1          =


  Details:     https://kernelci.org/test/plan/id/63ead30acac871e4188c8651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc8-229-g00400=
047861d/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc8-229-g00400=
047861d/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i386-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63ead30acac871e4188c8=
652
        new failure (last pass: v6.2-rc7-185-gbe3ba1769837) =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/63ead92a1a8a6e934f8c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc8-229-g00400=
047861d/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uef=
i.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc8-229-g00400=
047861d/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uef=
i.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63ead92a1a8a6e934f8c8=
630
        new failure (last pass: pm-6.2-rc8-185-g61b7614c114c) =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/63ead9651daec965988c8677

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc8-229-g00400=
047861d/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uef=
i-mixed.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc8-229-g00400=
047861d/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uef=
i-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63ead9651daec965988c8=
678
        new failure (last pass: pm-6.2-rc8-185-g61b7614c114c) =

 =20
