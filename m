Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE836576C22
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jul 2022 08:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiGPGO5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jul 2022 02:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGPGO4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2022 02:14:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD1E4D4F2
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 23:14:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y15so122597plp.10
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 23:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iNTQgxClrxSI9wwqfr00svunKAuOkyrQyLXIp0h1BCc=;
        b=Zz3qIpeWObEAxxUiNcuQeesG5LB5kN/obPDxuM2a5G8xpnIvk6qDuv+Ewi27zCF6Cp
         +5ChMaKJifGc6tEobOVGUivcxUZ5Ge9F8p4RJS1xplMUbvxvt7UQrlMhmOkN+RDPmrIp
         mj2E6A6R7ftVpWsp4wQmsA4Wo0xDVYFv/nDAt+73gX857BRiQ/od5owc9bFeLWLLEgRT
         ahKEDIFp3y9J2bkHjP9U9x87hxR2GQ2SZYYfdAI4VijxBKvMh2Km1P69e5Rc2mSdhasY
         HRxMWw5u8bLC4xbBr+Uh0UfuuqM8sjYCl3hirWtBliqIU54thGUfQvqJd/AqAYuBNYWM
         BcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iNTQgxClrxSI9wwqfr00svunKAuOkyrQyLXIp0h1BCc=;
        b=ZXD6DwPf+9YiuXg0XaOT7tfs5YLtheGASyuG/jzxxxrpXQ5QROGE24gOhZU1G2SQqf
         5Mbq+si+doXbyWPlt7RNTWqtNNgytrXthO6SPK6iXeNYLdb29o/sA8QA71Iywcp9Jt25
         g5oFH3hL1kg5WGJ1ruYKMVhFEEeP2tNe1OqO7/zoXizW1VWGiv9qHdE2W8258u6nPlCG
         ZezEvZAFEyb+0XTIHPZm6U5fUC+aApGVcSlYWoUrXDxlUaDfzICoLwiu9yT9ZNplBgz+
         WIfUyTIbnIlJcnq3EvuVYnsnqjS4ULIg7LrXPRNa9s7btuJGQC8YEHfNcVLZI4mcB60W
         lyyw==
X-Gm-Message-State: AJIora8M5KZuKuOiCK/SaWINXAbjsj6Daou446eQkYWTWnIKNT7KTnLA
        4xtKJA6Bw+oFEnplnZX75mDHOA==
X-Google-Smtp-Source: AGRyM1v9ofef3lWo/+sBAQa4EkKLbC3sBWacNJsvjrEnzHlOHtkmjZYkT2CuOOm3igkRUNSKGL9GlA==
X-Received: by 2002:a17:90b:384f:b0:1ef:e95d:de66 with SMTP id nl15-20020a17090b384f00b001efe95dde66mr19448204pjb.174.1657952094090;
        Fri, 15 Jul 2022 23:14:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p13-20020a63e64d000000b0040c9df2b060sm4263387pgj.30.2022.07.15.23.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 23:14:53 -0700 (PDT)
Message-ID: <62d2575d.1c69fb81.e1048.6bad@mx.google.com>
Date:   Fri, 15 Jul 2022 23:14:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: pm-5.19-rc7-63-g1b41824f2ecfc
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 79 runs,
 5 regressions (pm-5.19-rc7-63-g1b41824f2ecfc)
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

pm/testing baseline: 79 runs, 5 regressions (pm-5.19-rc7-63-g1b41824f2ecfc)

Regressions Summary
-------------------

platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =

jetson-tk1            | arm   | lab-baylibre    | gcc-10   | multi_v7_defco=
nfig | 1          =

kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =

rk3328-rock64         | arm64 | lab-baylibre    | gcc-10   | defconfig     =
     | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.19-=
rc7-63-g1b41824f2ecfc/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-5.19-rc7-63-g1b41824f2ecfc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1b41824f2ecfca03c667d33921100965fe537722 =



Test Regressions
---------------- =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62d24d4fd81ed1d63ea39bf8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.19-rc7-63-g1b4=
1824f2ecfc/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pi=
co-hobbit.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.19-rc7-63-g1b4=
1824f2ecfc/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pi=
co-hobbit.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d24d4fd81ed1d63ea39=
bf9
        failing since 38 days (last pass: thermal-5.16-rc5-48-gf1f42573b6f3=
, first fail: v5.19-rc1-2-g6a8964e282382) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
jetson-tk1            | arm   | lab-baylibre    | gcc-10   | multi_v7_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62d24e103c8b0d78dba39c07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.19-rc7-63-g1b4=
1824f2ecfc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.19-rc7-63-g1b4=
1824f2ecfc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d24e103c8b0d78dba39=
c08
        failing since 16 days (last pass: v5.19-rc4-36-g4035647418c1, first=
 fail: v5.19-rc4-35-g06cab9aecb43) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/62d24c1d9bd899c4b3a39bea

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.19-rc7-63-g1b4=
1824f2ecfc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-l=
s.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.19-rc7-63-g1b4=
1824f2ecfc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-l=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
d24c1d9bd899c4b3a39bf3
        failing since 39 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-07-16T05:26:39.332978  /lava-141753/1/../bin/lava-test-case
    2022-07-16T05:26:39.333345  <8>[   19.110955] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
rk3328-rock64         | arm64 | lab-baylibre    | gcc-10   | defconfig     =
     | 2          =


  Details:     https://kernelci.org/test/plan/id/62d24d783893e687a3a39bfd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.19-rc7-63-g1b4=
1824f2ecfc/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.19-rc7-63-g1b4=
1824f2ecfc/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62d24d783893e68=
7a3a39c04
        failing since 3 days (last pass: v5.19-rc5-50-g3bc028d913bd, first =
fail: v5.19-rc6-53-ge71c5921cc50)
        2 lines

    2022-07-16T05:32:17.964408  kern  :emerg : Internal error: Oops: 960000=
06 [#1] PREEMPT SMP
    2022-07-16T05:32:17.967132  kern  :emerg : Code: aa0003f4 a9025bf5 aa00=
03f6 aa0103f5 (f8418e93) =

    2022-07-16T05:32:17.972593  [   69.327813] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2022-07-16T05:32:17.972900  + set +x   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/62d24d783893e68=
7a3a39c05
        failing since 3 days (last pass: v5.19-rc5-50-g3bc028d913bd, first =
fail: v5.19-rc6-53-ge71c5921cc50)
        12 lines

    2022-07-16T05:32:17.943445  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 0000000000000005
    2022-07-16T05:32:17.944074  kern  :alert : Mem abort info:
    2022-07-16T05:32:17.944390  kern  :alert :   ESR =3D 0x0000000096000006
    2022-07-16T05:32:17.944752  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), IL =3D 32 bits
    2022-07-16T05:32:17.945103  kern  :alert :   SET =3D 0, FnV =3D 0
    2022-07-16T05:32:17.945270  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2022-07-16T05:32:17.945490  kern  :alert :   FSC =3D 0x06: level 2 tran=
slation fault
    2022-07-16T05:32:17.945726  kern  :alert : Data abort info:
    2022-07-16T05:32:17.945927  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006
    2022-07-16T05:32:17.946335  kern  :alert :   CM =3D 0, WnR =3D 0 =

    ... (3 line(s) more)  =

 =20
