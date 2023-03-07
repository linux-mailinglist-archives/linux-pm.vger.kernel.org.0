Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EE06AEF6A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 19:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjCGSXc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 13:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCGSXN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 13:23:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FC7A54EC
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 10:17:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so12671561pja.5
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 10:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678213070;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qw4unK5M05FB0p4NeJ/jRZWKxZ2mDe+NBepts0GoWEw=;
        b=0+XQmI/VMiEJzvrJg/m9niuemObPCEXfToafAjYD4+L1ZmXkvdRSY6BrGmTIVLb71z
         4lbi2Em/ui+IGObRFquv6KpRppPom9CsPqlPeZYT1abIk0UvUBBfWOfRr0kZqfidoZga
         q/sk2XVJCMYE9OmP7qyJ7i4RQEAzeLlEujFhKbhiUzyvx/yvwsQ2SPBdLK1Sgl6GJhL3
         r8cmmEWS9GPq0rVjm4Y1f7CA1aNQiUcF4LkWz9Ry2PUEMscHR4ng3drSCnm4+Uvrp01s
         kNGw33A3yY68P4egdSCP11nSKezqGYV9kczefjHoZNTNGxrRaO7MpxigoBAl9tE672VF
         SVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213070;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qw4unK5M05FB0p4NeJ/jRZWKxZ2mDe+NBepts0GoWEw=;
        b=WYGahzJSyXl0KVO5hcUCAMp+0QIxpM6u89q2I+oCIrfjZo2YxnYn/Td7fexAv9p9wj
         vocRiJTgX/G7fiq1mGZxQIQCdEsfSMMABuq2WeCqHd1VGVNoShOPO3wiYNs2caolggiv
         G8zsXG3AFXSyrVWNLMVqh2ef7hc5p1oyTNPLACjvWljR5pllpohzTg4Zk9SO0GJhv29e
         e040CxZyOasCnuWWr4MZ65IORXEUqnmKxxbi/qFzjgqIeHbpvcXpfxx+OmSs/GUJzfgM
         lB4i7sNHWxA39tsmLEQXU74O2WmMRdIuARq80nf6rCrV8o/vIWkI4VJdWEMaSIedBT8T
         dA1A==
X-Gm-Message-State: AO0yUKXfMEcgSOkw9/ZoZeUfeHUWv5ws8PlHd9/+rAFkWOlG82Jl1dDa
        Zry5hi2QkjkcQ5fOyaJDvA1GIg==
X-Google-Smtp-Source: AK7set/cWbP18jO2SFRDlKAABLUp0obNXOdLQq/ooiRU7fY8ecBfDD6cAFNWFk7txB3F4IFyxp+tDQ==
X-Received: by 2002:a17:903:1103:b0:19e:6c02:801c with SMTP id n3-20020a170903110300b0019e6c02801cmr18551113plh.14.1678213070440;
        Tue, 07 Mar 2023 10:17:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q37-20020a631f65000000b004f1e73b073bsm8093362pgm.26.2023.03.07.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:17:50 -0800 (PST)
Message-ID: <64077fce.630a0220.12d6d.edcf@mx.google.com>
Date:   Tue, 07 Mar 2023 10:17:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc1-23-g06401c1b98b0
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 36 runs,
 9 regressions (v6.3-rc1-23-g06401c1b98b0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 36 runs, 9 regressions (v6.3-rc1-23-g06401c1b98b0)

Regressions Summary
-------------------

platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
imx53-qsrb             | arm    | lab-pengutronix | gcc-10   | multi_v7_def=
config | 1          =

kontron-kbox-a-230-ls  | arm64  | lab-kontron     | gcc-10   | defconfig   =
       | 5          =

qemu_i386-uefi         | i386   | lab-collabora   | gcc-10   | i386_defconf=
ig     | 1          =

qemu_x86_64-uefi       | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig   | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig   | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc1=
-23-g06401c1b98b0/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc1-23-g06401c1b98b0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      06401c1b98b0d0ba33789b770c3c0083deaa652f =



Test Regressions
---------------- =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
imx53-qsrb             | arm    | lab-pengutronix | gcc-10   | multi_v7_def=
config | 1          =


  Details:     https://kernelci.org/test/plan/id/6407775f78fc58b60d8c8664

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc1-23-g06401c=
1b98b0/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc1-23-g06401c=
1b98b0/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6407775f78fc58b60d8c866d
        failing since 38 days (last pass: v6.1-rc8-156-g0a9e32afe717, first=
 fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-03-07T17:41:28.716826  + set +x
    2023-03-07T17:41:28.716993  [   13.066887] <LAVA_SIGNAL_ENDRUN 0_dmesg =
917733_1.5.2.3.1>
    2023-03-07T17:41:28.824872  / # #
    2023-03-07T17:41:28.926331  export SHELL=3D/bin/sh
    2023-03-07T17:41:28.926657  #
    2023-03-07T17:41:29.027662  / # export SHELL=3D/bin/sh. /lava-917733/en=
vironment
    2023-03-07T17:41:29.028113  =

    2023-03-07T17:41:29.129350  / # . /lava-917733/environment/lava-917733/=
bin/lava-test-runner /lava-917733/1
    2023-03-07T17:41:29.129963  =

    2023-03-07T17:41:29.133181  / # /lava-917733/bin/lava-test-runner /lava=
-917733/1 =

    ... (12 line(s) more)  =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
kontron-kbox-a-230-ls  | arm64  | lab-kontron     | gcc-10   | defconfig   =
       | 5          =


  Details:     https://kernelci.org/test/plan/id/640778bfbbfab6c6c38c8636

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc1-23-g06401c=
1b98b0/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc1-23-g06401c=
1b98b0/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640778bfbbfab6c6c38c863d
        new failure (last pass: pm-6.2-rc9-232-gea150b53b1fd)

    2023-03-07T17:47:24.688442  / # #
    2023-03-07T17:47:24.790048  export SHELL=3D/bin/sh
    2023-03-07T17:47:24.790678  #
    2023-03-07T17:47:24.892543  / # export SHELL=3D/bin/sh. /lava-288200/en=
vironment
    2023-03-07T17:47:24.893189  =

    2023-03-07T17:47:24.994461  / # . /lava-288200/environment/lava-288200/=
bin/lava-test-runner /lava-288200/1
    2023-03-07T17:47:24.995333  =

    2023-03-07T17:47:25.000147  / # /lava-288200/bin/lava-test-runner /lava=
-288200/1
    2023-03-07T17:47:25.067235  + export 'TESTRUN_ID=3D1_bootrr'
    2023-03-07T17:47:25.067535  + <8>[   22.436152] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 288200_1.5.2.4.5> =

    ... (17 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/640778bfbbfab6c6c38c8641
        new failure (last pass: pm-6.2-rc9-232-gea150b53b1fd)

    2023-03-07T17:47:27.163339  /lava-288200/1/../bin/lava-test-case
    2023-03-07T17:47:27.163752  <8>[   24.543134] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2023-03-07T17:47:27.164114  /lava-288200/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/64=
0778bfbbfab6c6c38c8643
        new failure (last pass: pm-6.2-rc9-232-gea150b53b1fd)

    2023-03-07T17:47:28.223007  /lava-288200/1/../bin/lava-test-case
    2023-03-07T17:47:28.223379  <8>[   25.580890] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2023-03-07T17:47:28.223729  /lava-288200/1/../bin/lava-test-case
    2023-03-07T17:47:28.224050  <8>[   25.598691] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2023-03-07T17:47:28.224448  /lava-288200/1/../bin/lava-test-case
    2023-03-07T17:47:28.224664  <8>[   25.618355] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2023-03-07T17:47:28.224934  /lava-288200/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/640778bfbbfab6c6c38c8648
        new failure (last pass: pm-6.2-rc9-232-gea150b53b1fd)

    2023-03-07T17:47:29.298505  /lava-288200/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/640778bfbbfab6c6c38c8649
        new failure (last pass: pm-6.2-rc9-232-gea150b53b1fd)

    2023-03-07T17:47:29.301912  <8>[   26.695585] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2023-03-07T17:47:30.360034  /lava-288200/1/../bin/lava-test-case
    2023-03-07T17:47:30.360318  <8>[   27.716791] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2023-03-07T17:47:30.360469  /lava-288200/1/../bin/lava-test-case
    2023-03-07T17:47:30.360611  <8>[   27.734832] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-driver-present RESULT=3Dpass>
    2023-03-07T17:47:30.360753  /lava-288200/1/../bin/lava-test-case
    2023-03-07T17:47:30.360928  <8>[   27.754527] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-probed RESULT=3Dpass>
    2023-03-07T17:47:30.361082  /lava-288200/1/../bin/lava-test-case   =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_i386-uefi         | i386   | lab-collabora   | gcc-10   | i386_defconf=
ig     | 1          =


  Details:     https://kernelci.org/test/plan/id/640773c36a048817408c869f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc1-23-g06401c=
1b98b0/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc1-23-g06401c=
1b98b0/i386/i386_defconfig/gcc-10/lab-collabora/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640773c36a048817408c8=
6a0
        failing since 21 days (last pass: v6.2-rc7-185-gbe3ba1769837, first=
 fail: v6.2-rc8-229-g00400047861d) =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_x86_64-uefi       | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/64077680846b1e00d58c8653

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc1-23-g06401c=
1b98b0/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc1-23-g06401c=
1b98b0/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64077680846b1e00d58c8=
654
        failing since 18 days (last pass: v6.2-rc7-185-gbe3ba1769837, first=
 fail: pm-6.2-rc9-232-gea150b53b1fd) =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/64077682846b1e00d58c8661

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc1-23-g06401c=
1b98b0/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64-ue=
fi-mixed.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc1-23-g06401c=
1b98b0/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64-ue=
fi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64077682846b1e00d58c8=
662
        failing since 18 days (last pass: v6.2-rc7-179-g929367dbdffe, first=
 fail: pm-6.2-rc9-232-gea150b53b1fd) =

 =20
