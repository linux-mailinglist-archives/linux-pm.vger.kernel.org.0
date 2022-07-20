Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A3457AB47
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 03:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiGTBDk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jul 2022 21:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGTBDj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2022 21:03:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E225A15E
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2022 18:03:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q13-20020a17090a304d00b001f1af9a18a2so561870pjl.5
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2022 18:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=N4PjsQAq+RAMN7NoXboX6tDeLB5XKR6/TX4KbaUk5b4=;
        b=XvM7q/73p8iFqQzSIMLldOv8lUtiW7ll5vcLYDOVgsOWynO0cByLu/AtB+guHAhmBY
         LI4nGaKySclKoFXun/9ecc/aQ+EVLs5BIcXHFEy2t2AGvEtUobTkNw1Yexdb5kf13xyt
         BiyAG10qNbDbXsHpkSxMwx7tuznEzqGBfayZRgpHXIixLrwj1yhcRyCvBsHTodX2R6+o
         Dx8NB2jk2woB7+f9bDg0wp7auewlFFRgWUvr2KZZaUq7amFgJqCJoiEtiztKN91Eyzb/
         YpycUhBFqaFA0GslyD0TZ3AR7XFss1J6gEITWmWR5qyd09qm98oKcwfJoohoSMdS+GI/
         V9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=N4PjsQAq+RAMN7NoXboX6tDeLB5XKR6/TX4KbaUk5b4=;
        b=kyRRXiO7dLnNcl9FVcuHLDW5v8T7861Ws2UleXnUUU8IscgdQGDnRgZdr8DIZlxeGG
         mRPPjP19m573yX/rmz08cYkwYpINXD1CwATYqWAO1tu/UmvtdpsHQ/EPQDAGy+V+xjeA
         NzHYNV0PZF0wfZoZREkf9052UMcVehPNhNojLpzqFmpxeWOP3xqjlMM3/wu23LimDSQC
         RTcssMIDhE1A67/D3m9A8jkRYGanQnueAxXXHdVuYP/QLw0SCzCWChl60BYgdZjxpszs
         ATr5WzAl0Dbfy8JEWCZWhY0NrFF61DYoMigJgudEsYC2k6yB8e81NxvKC3bLPuVHco6p
         B42w==
X-Gm-Message-State: AJIora+o22SDA/StiwIP5pfvP+P7XE3N3GuElnf76M3df/MSPCZ5J6eU
        v67t4m7XsPvulRZyiUFKEilcfw==
X-Google-Smtp-Source: AGRyM1uljXcz+B1Yoeh6bZ/oBXsjeDOEBuqJ+k7gG++tPXfFSUC+v9K/aJmTfmdZm99GYBKyWEFtUA==
X-Received: by 2002:a17:90b:4b4d:b0:1ef:a2c2:6bcc with SMTP id mi13-20020a17090b4b4d00b001efa2c26bccmr2440400pjb.186.1658279018216;
        Tue, 19 Jul 2022 18:03:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w15-20020a63c10f000000b004114cc062f0sm10544669pgf.65.2022.07.19.18.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 18:03:37 -0700 (PDT)
Message-ID: <62d75469.1c69fb81.5f2a0.00c4@mx.google.com>
Date:   Tue, 19 Jul 2022 18:03:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc7-79-g66de314cd08fc
Subject: pm/testing baseline: 86 runs,
 6 regressions (v5.19-rc7-79-g66de314cd08fc)
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

pm/testing baseline: 86 runs, 6 regressions (v5.19-rc7-79-g66de314cd08fc)

Regressions Summary
-------------------

platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =

kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =

rk3328-rock64         | arm64 | lab-baylibre    | gcc-10   | defconfig     =
     | 2          =

rk3399-rock-pi-4b     | arm64 | lab-collabora   | gcc-10   | defconfig     =
     | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.19-rc=
7-79-g66de314cd08fc/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc7-79-g66de314cd08fc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      66de314cd08fc4a7830333025d6a9c61ed12cd30 =



Test Regressions
---------------- =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62d74b73a4a376ba4ddaf065

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc7-79-g66de3=
14cd08fc/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico=
-hobbit.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc7-79-g66de3=
14cd08fc/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico=
-hobbit.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220716.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d74b73a4a376ba4ddaf=
066
        failing since 42 days (last pass: thermal-5.16-rc5-48-gf1f42573b6f3=
, first fail: v5.19-rc1-2-g6a8964e282382) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/62d74a28065b164207daf0b0

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc7-79-g66de3=
14cd08fc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc7-79-g66de3=
14cd08fc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220716.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
d74a28065b164207daf0b9
        failing since 42 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-07-20T00:19:34.940415  /lava-142842/1/../bin/lava-test-case
    2022-07-20T00:19:34.940683  <8>[   14.667785] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
rk3328-rock64         | arm64 | lab-baylibre    | gcc-10   | defconfig     =
     | 2          =


  Details:     https://kernelci.org/test/plan/id/62d74a4033557639a0daf057

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc7-79-g66de3=
14cd08fc/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc7-79-g66de3=
14cd08fc/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220716.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62d74a403355763=
9a0daf05e
        failing since 7 days (last pass: v5.19-rc5-50-g3bc028d913bd, first =
fail: v5.19-rc6-53-ge71c5921cc50)
        2 lines

    2022-07-20T00:20:10.196053  kern  :emerg : Internal error: Oops: 960000=
06 [#1] PREEMPT SMP
    2022-07-20T00:20:10.199578  kern  :emerg : Code: aa0003f4 a9025bf5 aa00=
03f6 aa0103f5 (f8418e93) =

    2022-07-20T00:20:10.208833  [   60.478006] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2022-07-20T00:20:10.209093  + set +x   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/62d74a403355763=
9a0daf05f
        failing since 7 days (last pass: v5.19-rc5-50-g3bc028d913bd, first =
fail: v5.19-rc6-53-ge71c5921cc50)
        12 lines

    2022-07-20T00:20:10.175158  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 0000000000000005
    2022-07-20T00:20:10.175711  kern  :alert : Mem abort info:
    2022-07-20T00:20:10.175933  kern  :alert :   ESR =3D 0x0000000096000006
    2022-07-20T00:20:10.176242  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), IL =3D 32 bits
    2022-07-20T00:20:10.176677  kern  :alert :   SET =3D 0, FnV =3D 0
    2022-07-20T00:20:10.176919  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2022-07-20T00:20:10.177170  kern  :alert :   FSC =3D 0x06: level 2 tran=
slation fault
    2022-07-20T00:20:10.177581  kern  :alert : Data abort info:
    2022-07-20T00:20:10.177784  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006
    2022-07-20T00:20:10.178176  kern  :alert :   CM =3D 0, WnR =3D 0 =

    ... (3 line(s) more)  =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
rk3399-rock-pi-4b     | arm64 | lab-collabora   | gcc-10   | defconfig     =
     | 2          =


  Details:     https://kernelci.org/test/plan/id/62d74a5cab7e297df1daf08d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc7-79-g66de3=
14cd08fc/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc7-79-g66de3=
14cd08fc/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220716.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62d74a5cab7e297=
df1daf094
        failing since 7 days (last pass: v5.19-rc5-50-g3bc028d913bd, first =
fail: v5.19-rc6-53-ge71c5921cc50)
        2 lines =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/62d74a5cab7e297=
df1daf095
        failing since 7 days (last pass: v5.19-rc5-50-g3bc028d913bd, first =
fail: v5.19-rc6-53-ge71c5921cc50)
        12 lines

    2022-07-20T00:20:37.154131  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 0000000000000005
    2022-07-20T00:20:37.154668  kern  :alert : Mem abort info:
    2022-07-20T00:20:37.155014  kern  :alert :   ESR =3D 0x0000000096000006
    2022-07-20T00:20:37.155337  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), IL =3D 32 bits
    2022-07-20T00:20:37.155647  kern  :alert :   SET =3D 0, FnV =3D 0
    2022-07-20T00:20:37.155948  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2022-07-20T00:20:37.156242  kern  :alert :   FSC =3D 0x06: level 2 tran=
slation fault
    2022-07-20T00:20:37.156565  kern  :alert : Data abort info:
    2022-07-20T00:20:37.156857  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006
    2022-07-20T00:20:37.157147  kern  :alert :   CM =3D 0, WnR =3D 0 =

    ... (7 line(s) more)  =

 =20
