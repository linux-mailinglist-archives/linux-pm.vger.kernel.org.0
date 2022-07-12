Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAED571D41
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jul 2022 16:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiGLOtY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jul 2022 10:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiGLOtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2022 10:49:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A1D54CAA
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 07:49:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q82so7773211pgq.6
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=FO/mif2PB1na5ia79WNezqjCmfQFDt/29S89cTVyav0=;
        b=AOh+2imMb8EWZX5YbqB59kbLfiHSIYzX1yH9n9HTkv5PULPvwunITMNcuwLhJgHbly
         M/aJt5+P9tgJrsP/NmjzSDhltPS4yag/O/IRWh98MEpANHvEa2nJfiupr85C11F7hYYN
         vguBl9BV/o51CoQeYUbtPjfBIEuu5HL2158lt5ckfLfn2szfHSH4zqEIausnKuG9QE+Z
         +XPJf+7Jua5quIQFU9CQk2mMlGuqP/ngCxfTvlgIBKedq9LpuAf0U+qJgGTB4pC6m6qA
         9THbVYgS4LGxc9B0WcQ5ZmqwsYwD3USRQGmjhxBldQgEAAJwArKcJivFaxrG4Z0334eK
         aUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=FO/mif2PB1na5ia79WNezqjCmfQFDt/29S89cTVyav0=;
        b=Ed/Vd35iblJXeCiZw9c7fj0t9UKTnUXFj39VQRZuXdAFcLjy3vhVgUgbaYja+x9Mmn
         81J/+i3y/dud0Vyt8JdySs2WbnaHy5zQ3qC4EsreIFPH48KkjCg8MoK1y001xZ/dqhQ0
         PQLHe+as/jkBSmreuaFDBcuQvMxcQu4SKw7wpELgnfpTw+ss7JQN6VfNlNKx3h1wI5Lq
         XBAuvmge+gLaMbkkuwtGEyLQ3CNA36Sac9kzrbDpHMbspgyHZE9/MQFhdBK7M+jEnsKA
         KoEIlVJgXs620GGjZik+jHUSZH/2lAhTmBok6d64trV5o3tDuhsGysUblklv8JqDlAFP
         MYeQ==
X-Gm-Message-State: AJIora/cwH/Lw+xDa1DO2yfwJ1TLQMwKXbf9Mv3b28z/cFcnG5HEDaDa
        jVTiLWPTkHcJdFKJATZt8wYhlw==
X-Google-Smtp-Source: AGRyM1vySQrfQwA9c8hpGiU62MzipzBZeFXJ3nN/WwD3/c2x2fTeKAuJFFYbTP2xssEzSuM7Sqf2ew==
X-Received: by 2002:a63:235f:0:b0:412:77a8:4fe5 with SMTP id u31-20020a63235f000000b0041277a84fe5mr21506357pgm.258.1657637352967;
        Tue, 12 Jul 2022 07:49:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902b59400b00161ac982b9esm6908633pls.185.2022.07.12.07.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:49:12 -0700 (PDT)
Message-ID: <62cd89e8.1c69fb81.25b55.9ea8@mx.google.com>
Date:   Tue, 12 Jul 2022 07:49:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc6-53-ge71c5921cc50
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 83 runs,
 5 regressions (v5.19-rc6-53-ge71c5921cc50)
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

pm/testing baseline: 83 runs, 5 regressions (v5.19-rc6-53-ge71c5921cc50)

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
6-53-ge71c5921cc50/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc6-53-ge71c5921cc50
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e71c5921cc5005d866e7acd0b501faff1f548897 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
kontron-kbox-a-230-ls | arm64 | lab-kontron   | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/62cd7ec3c6a7a6e526a39bcd

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc6-53-ge71c5=
921cc50/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc6-53-ge71c5=
921cc50/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
cd7ec4c6a7a6e526a39bda
        failing since 35 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-07-12T14:01:18.007369  /lava-139315/1/../bin/lava-test-case
    2022-07-12T14:01:18.007900  <8>[   14.615481] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-07-12T14:01:18.008068  /lava-139315/1/../bin/lava-test-case
    2022-07-12T14:01:18.008247  <8>[   14.631579] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-07-12T14:01:18.008454  /lava-139315/1/../bin/lava-test-case
    2022-07-12T14:01:18.008679  <8>[   14.647215] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-07-12T14:01:18.008844  /lava-139315/1/../bin/lava-test-case   =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
rk3328-rock64         | arm64 | lab-baylibre  | gcc-10   | defconfig | 2   =
       =


  Details:     https://kernelci.org/test/plan/id/62cd7feddb719b7d3aa39be2

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc6-53-ge71c5=
921cc50/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc6-53-ge71c5=
921cc50/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62cd7feddb719b7=
d3aa39be5
        new failure (last pass: v5.19-rc5-50-g3bc028d913bd)
        2 lines

    2022-07-12T14:06:17.418420  kern  :emerg : Internal error: Oops: 960000=
06 [#1] PREEMPT SMP
    2022-07-12T14:06:17.422044  kern  :emerg : Code: aa0003f4 a9025bf5 aa00=
03f6 aa0103f5 (f8418e93) =

    2022-07-12T14:06:17.428228  [   71.313063] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2022-07-12T14:06:17.428545  + set +x   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/62cd7feddb719b7=
d3aa39be6
        new failure (last pass: v5.19-rc5-50-g3bc028d913bd)
        12 lines

    2022-07-12T14:06:17.397654  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 0000000000000005
    2022-07-12T14:06:17.398178  kern  :alert : Mem abort info:
    2022-07-12T14:06:17.398501  kern  :alert :   ESR =3D 0x0000000096000006
    2022-07-12T14:06:17.398804  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), IL =3D 32 bits
    2022-07-12T14:06:17.399250  kern  :alert :   SET =3D 0, FnV =3D 0
    2022-07-12T14:06:17.399502  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2022-07-12T14:06:17.399775  kern  :alert :   FSC =3D 0x06: level 2 tran=
slation fault
    2022-07-12T14:06:17.400202  kern  :alert : Data abort info:
    2022-07-12T14:06:17.400373  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006
    2022-07-12T14:06:17.400766  kern  :alert :   CM =3D 0, WnR =3D 0 =

    ... (3 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
rk3399-rock-pi-4b     | arm64 | lab-collabora | gcc-10   | defconfig | 2   =
       =


  Details:     https://kernelci.org/test/plan/id/62cd7e884a9940910ea39bed

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc6-53-ge71c5=
921cc50/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc6-53-ge71c5=
921cc50/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62cd7e884a99409=
10ea39bf0
        new failure (last pass: v5.19-rc5-50-g3bc028d913bd)
        2 lines

    2022-07-12T14:00:23.512762  kern  :emerg : Code: aa0003f4 a9025bf5 aa00=
03f6 aa0103f5 (f8418e93) =

    2022-07-12T14:00:23.512979  <8>[   60.001281] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2022-07-12T14:00:23.513097  + set +x
    2022-07-12T14:00:23.513202  <8>[   60.003132] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 6800090_1.5.2.4.1>   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/62cd7e884a99409=
10ea39bf1
        new failure (last pass: v5.19-rc5-50-g3bc028d913bd)
        12 lines

    2022-07-12T14:00:23.468978  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006
    2022-07-12T14:00:23.469066  kern  :alert :   CM =3D 0, WnR =3D 0
    2022-07-12T14:00:23.469135  kern  :alert : user pgtable: 4k pages, 48-b=
it VAs, pgdp=3D0000000009326000
    2022-07-12T14:00:23.469201  kern  :alert : [0000000000000005] pgd=3D080=
0000009327003, p4d=3D0800000009327003, pud=3D0800000009328003, pmd=3D000000=
0000000000
    2022-07-12T14:00:23.469266  <8>[   59.975488] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D12>
    2022-07-12T14:00:23.469328  kern  :emerg : Internal error: Oops: 960000=
06 [#1] PREEMPT SMP   =

 =20
