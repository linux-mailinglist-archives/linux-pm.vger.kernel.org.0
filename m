Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046E5791B6
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jul 2022 06:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiGSEOl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jul 2022 00:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiGSEOk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2022 00:14:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F683ED5B
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 21:14:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso495190pjb.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 21:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KyL3J1YQQGTfSY+cpRQjM9QIBNOWt7mwDaimPY9Xxf8=;
        b=n5tdZOqGxhHElWl8bSR9bAXY8mB93mM7xhjySlmZze6KEjeYXWrW6RlpO9gGmivCbz
         Wa0UrCxnM6J9a2Fni56BxLtCVPOrPj7+x7SCe6hY+AGHJjzqP8v+sLfDll+Gof6KOU6z
         sGdonfS/8nDk73leDAEzRtTf6mpawhRQOEyud/2POCScXeQ0zJ/0ttQ/Q28rby07Nbbd
         d+mRnnksGiH7t6xzOYhiNVb+tfxWmZgshZKc3YbvZi3gyyvLZHG2fvfJ//QBJ7pyB3/c
         f1ztJO4dE/BhG9yKV9So2rCjEOKZ1t1cBOoZH6V7SsZfMAnpwr86A7t/51rLFRWrM3vp
         lbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KyL3J1YQQGTfSY+cpRQjM9QIBNOWt7mwDaimPY9Xxf8=;
        b=mz0ajhYS+oHoI56SlauxoCcvX/TJ21niQFZcWbgoTW2+1yt0anHqEJ9HZWPNHDLqa6
         N3mnmmPhH5Do/u8AbmsXWAVD/u9LMRBYmz+cuIZdOZcBfSWOTRqRJUk65w0sdN8PdHsi
         fc7FT0vAUBIE6KLT0azMfm78fiTBRrFR3NEQlpGza5ZRiBOaLhV3ZhnxWCDyp15RffGc
         qHwVkZL89BZ1GUq3Fn+k8kP9JQkVsH2hcT+J/PNGpPBplLaZg+6esDDKTRFQChfgra6a
         yavg4/Il0wqKKAJEcM/zVInbolQ2r0Jz++R98g8E+HUUUX3ljHWb8Gpfd3xfd5FKHJKA
         JvVg==
X-Gm-Message-State: AJIora9i0+4vHSNVglHe7FZEb04bscHpBhhXZWGWErddtwrd4gLzz8GJ
        BgfPcJvC6aRNVK2e37ee37ZUZw==
X-Google-Smtp-Source: AGRyM1u/gIdEKxBGidvK8fzlRM/jU6ZF7ZFeYiOvM3Rb3+PsMkJGf/XBU9bIVniEzgcBu+eC+Oy/7A==
X-Received: by 2002:a17:902:f7cc:b0:16c:10a6:9e25 with SMTP id h12-20020a170902f7cc00b0016c10a69e25mr32204846plw.162.1658204079106;
        Mon, 18 Jul 2022 21:14:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090ac59300b001e31f4cc977sm10018553pjt.56.2022.07.18.21.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 21:14:38 -0700 (PDT)
Message-ID: <62d62fae.1c69fb81.33ccb.e6ac@mx.google.com>
Date:   Mon, 18 Jul 2022 21:14:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc7-69-gcd720ad594e64
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 64 runs,
 5 regressions (v5.19-rc7-69-gcd720ad594e64)
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

pm/testing baseline: 64 runs, 5 regressions (v5.19-rc7-69-gcd720ad594e64)

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
7-69-gcd720ad594e64/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc7-69-gcd720ad594e64
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      cd720ad594e64894f94f2b011e281c9b85ac1cdd =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
kontron-kbox-a-230-ls | arm64 | lab-kontron   | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/62d6266a65415eee85a39bd9

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc7-69-gcd720=
ad594e64/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc7-69-gcd720=
ad594e64/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220716.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
d6266a65415eee85a39be2
        failing since 42 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-07-19T03:35:00.202977  /lava-142321/1/../bin/lava-test-case
    2022-07-19T03:35:00.203594  <8>[   17.283767] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-07-19T03:35:00.203823  /lava-142321/1/../bin/lava-test-case
    2022-07-19T03:35:00.204029  <8>[   17.300868] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-07-19T03:35:00.204257  /lava-142321/1/../bin/lava-test-case
    2022-07-19T03:35:00.204464  <8>[   17.317301] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-07-19T03:35:00.204662  /lava-142321/1/../bin/lava-test-case   =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
rk3328-rock64         | arm64 | lab-baylibre  | gcc-10   | defconfig | 2   =
       =


  Details:     https://kernelci.org/test/plan/id/62d6266165415eee85a39bce

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc7-69-gcd720=
ad594e64/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc7-69-gcd720=
ad594e64/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220716.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62d6266165415ee=
e85a39bd5
        failing since 6 days (last pass: v5.19-rc5-50-g3bc028d913bd, first =
fail: v5.19-rc6-53-ge71c5921cc50)
        2 lines

    2022-07-19T03:34:46.015480  kern  :emerg : Internal error: Oops: 960000=
06 [#1] PREEMPT SMP
    2022-07-19T03:34:46.018971  kern  :emerg : Code: aa0003f4 a9025bf5 aa00=
03f6 aa0103f5 (f8418e93) =

    2022-07-19T03:34:46.025127  [   60.468563] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2022-07-19T03:34:46.025438  + set +x   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/62d6266165415ee=
e85a39bd6
        failing since 6 days (last pass: v5.19-rc5-50-g3bc028d913bd, first =
fail: v5.19-rc6-53-ge71c5921cc50)
        12 lines

    2022-07-19T03:34:45.993663  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 0000000000000005
    2022-07-19T03:34:45.994259  kern  :alert : Mem abort info:
    2022-07-19T03:34:45.994573  kern  :alert :   ESR =3D 0x0000000096000006
    2022-07-19T03:34:45.994885  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), IL =3D 32 bits
    2022-07-19T03:34:45.995196  kern  :alert :   SET =3D 0, FnV =3D 0
    2022-07-19T03:34:45.995358  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2022-07-19T03:34:45.995533  kern  :alert :   FSC =3D 0x06: level 2 tran=
slation fault
    2022-07-19T03:34:45.995989  kern  :alert : Data abort info:
    2022-07-19T03:34:45.996133  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006
    2022-07-19T03:34:45.996478  kern  :alert :   CM =3D 0, WnR =3D 0 =

    ... (3 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
rk3399-rock-pi-4b     | arm64 | lab-collabora | gcc-10   | defconfig | 2   =
       =


  Details:     https://kernelci.org/test/plan/id/62d625a6d9bf850558a39bdb

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc7-69-gcd720=
ad594e64/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc7-69-gcd720=
ad594e64/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220716.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62d625a6d9bf850=
558a39be2
        failing since 6 days (last pass: v5.19-rc5-50-g3bc028d913bd, first =
fail: v5.19-rc6-53-ge71c5921cc50)
        2 lines =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/62d625a6d9bf850=
558a39be3
        failing since 6 days (last pass: v5.19-rc5-50-g3bc028d913bd, first =
fail: v5.19-rc6-53-ge71c5921cc50)
        12 lines

    2022-07-19T03:31:39.495132  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006
    2022-07-19T03:31:39.495229  kern  :alert :   CM =3D 0, WnR =3D 0
    2022-07-19T03:31:39.495324  kern  :alert : user pgtable: 4k pages, 48-b=
it VAs, pgdp=3D0000000079a5d000
    2022-07-19T03:31:39.495400  kern  :alert : [0000000000000005] pgd=3D080=
0000079a5e003, p4d=3D0800000079a5e003, pud=3D0800000079a5f003, pmd=3D000000=
0000000000
    2022-07-19T03:31:39.495488  <8>[   43.876651] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D12>
    2022-07-19T03:31:39.495563  kern  :emerg : Internal error: Oops: 960000=
06 [#1] PREEMPT SMP
    2022-07-19T03:31:39.495649  kern  :emerg : Code: aa0003f4 a9025bf5 aa00=
03f6 aa0103f5 (f8418e93) =

    2022-07-19T03:31:39.495733  <8>[   43.897730] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2022-07-19T03:31:39.495803  + set +x
    2022-07-19T03:31:39.495875  <8>[   43.899881] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 6843178_1.5.2.4.1>   =

 =20
