Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04A573E6B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 23:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiGMVAp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jul 2022 17:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiGMVAp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2022 17:00:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00C3326E1
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2022 14:00:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so5769828pjm.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2022 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=AxeLo7IdUAr5cjwPAKdLXThz6oRwui3yx4ky+3W71qM=;
        b=hR5NNxU0qQMDbNYyuutEE9X0f1WYyJP6gRlKAIM3Ds9LqT1clPXIKj9UlpbAle2pE/
         BIxqouHS3XRZnNnB/XSyuSALY/A4qfD5ksgfABTUrkmja+9Ea4J9ZXVRSERBwCG6Ipd+
         n/POBEqjPEPXIUPynrFgVm91ByBMToCGtJgGafc8sP+PO+led03p6/6qUxiKe2RJ3Y1X
         t5WyaBBhxtOpir8deH7eARfwvg40Fu3k9KTR0n2qIDxQXqgwbKIBpCthExPY/qwrPK7j
         mIFJeg7CoZItoy3wee+dLJmnqWJHKGJWi6pz2tNHgNCm4EW4C4V12a/llIVcTGZhMylf
         bdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=AxeLo7IdUAr5cjwPAKdLXThz6oRwui3yx4ky+3W71qM=;
        b=o2TlXJ6bO69u7rcZz5FklK8h4exQ98WF64CxYd5JaoIjOgIM6ttFAz7Of1pzy4OS21
         Mmx4CUbPOGmjMGSKxzB9yDffg7IRpRbMVDv8FDoK099Pjx5aldkue5KdGKxrOUKirYom
         zFpgnhk4gZ2WeBxc/OTNWa89OBBo2co9Ju4xyCSbBH3Wpa+Fg7muX6aZsJ9MoEJx0OVa
         ZGnaC9GeSFsFDdXlIXJuaHMnpyuo7ZxygXAl2frTpUA1mvygXGFZmkehwFTuFOD0fZZB
         xRGaor/SjBvbPM0BC+nXVTsrICK1DvRTTcwtK7l2dCvo5WuhXZkTyFSpJAZK/qkbsrpr
         EcRA==
X-Gm-Message-State: AJIora/MPsQnBr8OK7Zhbuu49+bKZLPYIFztCtm7PTZFk26OVMsAKGze
        gszI6G3y/W+ksLnLHOHE4JpVvQ==
X-Google-Smtp-Source: AGRyM1vLc8JmGZB9tnQQ2BRtBO2zkZNTSAiBTE6glm/BM24zQfpbXVln1YSMQGUOWWX9C5OpQVSrBQ==
X-Received: by 2002:a17:90b:33c4:b0:1f0:3d9d:39ac with SMTP id lk4-20020a17090b33c400b001f03d9d39acmr5705639pjb.56.1657746042221;
        Wed, 13 Jul 2022 14:00:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a17090a3d0200b001ef7c7564fdsm2050602pjc.21.2022.07.13.14.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:00:40 -0700 (PDT)
Message-ID: <62cf3278.1c69fb81.6ece5.38fe@mx.google.com>
Date:   Wed, 13 Jul 2022 14:00:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc6-57-g524b6b1a1288
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 67 runs,
 5 regressions (v5.19-rc6-57-g524b6b1a1288)
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

pm/testing baseline: 67 runs, 5 regressions (v5.19-rc6-57-g524b6b1a1288)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
kontron-kbox-a-230-ls | arm64 | lab-kontron   | gcc-10   | defconfig | 1   =
       =

rk3328-rock64         | arm64 | lab-baylibre  | gcc-10   | defconfig | 2   =
       =

rk3399-rock-pi-4b     | arm64 | lab-collabora | gcc-10   | defconfig | 2   =
       =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.19-rc=
6-57-g524b6b1a1288/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc6-57-g524b6b1a1288
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      524b6b1a1288721f687931cf457a3216ad14742a =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
kontron-kbox-a-230-ls | arm64 | lab-kontron   | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/62cf264821088c3b51a39bd6

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc6-57-g524b6=
b1a1288/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc6-57-g524b6=
b1a1288/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
cf264821088c3b51a39bdf
        failing since 36 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-07-13T20:08:25.862232  /lava-140317/1/../bin/lava-test-case
    2022-07-13T20:08:25.862545  <8>[   14.647684] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
rk3328-rock64         | arm64 | lab-baylibre  | gcc-10   | defconfig | 2   =
       =


  Details:     https://kernelci.org/test/plan/id/62cf2911539f8cfca2a39bcd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc6-57-g524b6=
b1a1288/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc6-57-g524b6=
b1a1288/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62cf2911539f8cf=
ca2a39bd4
        failing since 1 day (last pass: v5.19-rc5-50-g3bc028d913bd, first f=
ail: v5.19-rc6-53-ge71c5921cc50)
        2 lines

    2022-07-13T20:20:09.591729  kern  :emerg : Internal error: Oops: 960000=
06 [#1] PREEMPT SMP
    2022-07-13T20:20:09.595166  kern  :emerg : Code: aa0003f4 a9025bf5 aa00=
03f6 aa0103f5 (f8418e93) =

    2022-07-13T20:20:09.599999  [   69.221243] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2022-07-13T20:20:09.600289  + set +x   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/62cf2911539f8cf=
ca2a39bd5
        failing since 1 day (last pass: v5.19-rc5-50-g3bc028d913bd, first f=
ail: v5.19-rc6-53-ge71c5921cc50)
        12 lines

    2022-07-13T20:20:09.570910  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 0000000000000005
    2022-07-13T20:20:09.571474  kern  :alert : Mem abort info:
    2022-07-13T20:20:09.571751  kern  :alert :   ESR =3D 0x0000000096000006
    2022-07-13T20:20:09.572052  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), IL =3D 32 bits
    2022-07-13T20:20:09.572452  kern  :alert :   SET =3D 0, FnV =3D 0
    2022-07-13T20:20:09.572623  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2022-07-13T20:20:09.572846  kern  :alert :   FSC =3D 0x06: level 2 tran=
slation fault
    2022-07-13T20:20:09.573290  kern  :alert : Data abort info:
    2022-07-13T20:20:09.573543  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006
    2022-07-13T20:20:09.573971  kern  :alert :   CM =3D 0, WnR =3D 0 =

    ... (3 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
rk3399-rock-pi-4b     | arm64 | lab-collabora | gcc-10   | defconfig | 2   =
       =


  Details:     https://kernelci.org/test/plan/id/62cf25a43b61b59220a39be1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc6-57-g524b6=
b1a1288/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc6-57-g524b6=
b1a1288/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62cf25a43b61b59=
220a39be8
        failing since 1 day (last pass: v5.19-rc5-50-g3bc028d913bd, first f=
ail: v5.19-rc6-53-ge71c5921cc50)
        2 lines =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/62cf25a43b61b59=
220a39be9
        failing since 1 day (last pass: v5.19-rc5-50-g3bc028d913bd, first f=
ail: v5.19-rc6-53-ge71c5921cc50)
        12 lines

    2022-07-13T20:05:42.296809  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006
    2022-07-13T20:05:42.297315  kern  :alert :   CM =3D 0, WnR =3D 0
    2022-07-13T20:05:42.297662  kern  :alert : user pgtable: 4k pages, 48-b=
it VAs, pgdp=3D0000000079043000
    2022-07-13T20:05:42.297988  kern  :alert : [0000000000000005] pgd=3D080=
0000079044003, p4d=3D0800000079044003, pud=3D0800000079045003, pmd=3D000000=
0000000000
    2022-07-13T20:05:42.298306  <8>[   61.338764] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D12>
    2022-07-13T20:05:42.298615  kern  :emerg : Internal error: Oops: 960000=
06 [#1] PREEMPT SMP
    2022-07-13T20:05:42.298918  kern  :emerg : Code: aa0003f4 a9025bf5 aa00=
03f6 aa0103f5 (f8418e93) =

    2022-07-13T20:05:42.299213  <8>[   61.358455] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2022-07-13T20:05:42.299506  + set +x
    2022-07-13T20:05:42.299796  <8>[   61.360581] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 6812673_1.5.2.4.1>   =

 =20
