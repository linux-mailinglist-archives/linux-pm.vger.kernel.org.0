Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DB85A6F36
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 23:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH3Vgr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Aug 2022 17:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiH3Vgp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 17:36:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B539895E6
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2022 14:36:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o4so12353429pjp.4
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2022 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=szFPQ9HnDCjvxn4TC5fFI29SNM55IyXYTkIoSOzPehU=;
        b=lr+ZDR01EzpYVPXDJSd/PZs9pfpp4i7rZ1MMM4WwgsUhaqsqvYn1wOexkukzPu6Cw3
         exC/opeaWS/ER/3/rYdWnMDZPLQB/gtqg6iOf9HuyBUA14Qa/ZAcfHs56r09YCY0NNcB
         3WreFJWTznSrZbfQJ/9aXQkAIUayXme48QPD00XFtohevEJWEvizSxVoTRqK4qy5H6gb
         oPazo4mQcyKSmzRAOGHerrmN0t9gVW32tyDu4jPvqo2lU6dGFyNDvfTECopc8nWCmtmd
         qvCcTyehNVHHP18Zdjt3a3M4RtYRFxUdA0Sxk4CrTFXAxRxJig3SxAdx5c7xDptPsdgV
         YV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=szFPQ9HnDCjvxn4TC5fFI29SNM55IyXYTkIoSOzPehU=;
        b=LO0laU7k9+0i/VmU54DLyHzNh6v5iFN5U3bZqxJbBJcbMarrWZB7ZJeT0XQ0w4rWh0
         QJ0xxa24Y4P7bSEJilhu1Bi2D+eGThjzl8IGtTUPDagrw5jS1UudPb67HICXb/0MzB2T
         evV/44B8jH7BRybNQlJ0ji3MQjvkCcuBxgaPXFXk7uqqosiGxqbF9iwtkD4zbsR8S2X5
         Yjz4aICyB+IBwbgUscpP9FmDNTpPf11Epnbq/YUz3oiHKgujrK2dCEB6yW9YrNGlon8x
         ffwIJT7oFsH0MnSNmmhhztKyEDQPWWKqHCtv9dOQdRp2eHagJy3zdnFalSV68XXm/0pO
         I3hA==
X-Gm-Message-State: ACgBeo0n/HN7TSgyPdW5W6C5EKz88+IGu0vxn9p8UnaFE/E5wTKj8maQ
        DnI5ffYp1O9pmbE1VySKyvTDMbtDMidioyhwdRE=
X-Google-Smtp-Source: AA6agR6DFucP62YP3eOKf55+EDJsDkFxdcFCyJXcZ3un8GOsaxPZBVM7XYmyg1IGaZiWa0Spii+B7g==
X-Received: by 2002:a17:90b:4b89:b0:1f5:68b:b14e with SMTP id lr9-20020a17090b4b8900b001f5068bb14emr45148pjb.30.1661895404120;
        Tue, 30 Aug 2022 14:36:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 199-20020a6300d0000000b00419ab8f8d2csm2065130pga.20.2022.08.30.14.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:36:43 -0700 (PDT)
Message-ID: <630e82eb.630a0220.9f0e.3d3b@mx.google.com>
Date:   Tue, 30 Aug 2022 14:36:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.0-rc3-72-g41607487f81c
Subject: pm/testing baseline: 84 runs,
 3 regressions (v6.0-rc3-72-g41607487f81c)
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

pm/testing baseline: 84 runs, 3 regressions (v6.0-rc3-72-g41607487f81c)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =

kontron-pitx-imx8m    | arm64 | lab-kontron | gcc-10   | defconfig | 2     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.0-rc3=
-72-g41607487f81c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.0-rc3-72-g41607487f81c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      41607487f81ccdf20e796adacc277483ecc9c234 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/630e79b9f67630068435564d

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc3-72-g416074=
87f81c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc3-72-g416074=
87f81c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
0e79b9f676300684355656
        failing since 84 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-08-30T20:57:14.928149  /lava-161202/1/../bin/lava-test-case
    2022-08-30T20:57:14.928511  <8>[   15.113332] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-08-30T20:57:14.928691  /lava-161202/1/../bin/lava-test-case
    2022-08-30T20:57:14.928862  <8>[   15.130081] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-08-30T20:57:14.929005  /lava-161202/1/../bin/lava-test-case
    2022-08-30T20:57:14.929143  <8>[   15.146625] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-08-30T20:57:14.929280  /lava-161202/1/../bin/lava-test-case   =

 =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-pitx-imx8m    | arm64 | lab-kontron | gcc-10   | defconfig | 2     =
     =


  Details:     https://kernelci.org/test/plan/id/630e7bac9cd7e3862c355648

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc3-72-g416074=
87f81c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc3-72-g416074=
87f81c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.imx6q-pcie-pcie0-probed: https://kernelci.org/test/case=
/id/630e7bac9cd7e3862c355656
        failing since 7 days (last pass: v5.19-rc8-92-ge240a33f1bc48, first=
 fail: v6.0-rc1-6-g977346c02019)

    2022-08-30T21:05:23.877132  /lava-161203/1/../bin/lava-test-case
    2022-08-30T21:05:23.877536  <8>[   19.362591] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dimx6q-pcie-pcie0-probed RESULT=3Dfail>
    2022-08-30T21:05:23.877804  /lava-161203/1/../bin/lava-test-case   =


  * baseline.bootrr.intel-igb-probed: https://kernelci.org/test/case/id/630=
e7bac9cd7e3862c355658
        failing since 7 days (last pass: v5.19-rc8-92-ge240a33f1bc48, first=
 fail: v6.0-rc1-6-g977346c02019)

    2022-08-30T21:05:24.916384  /lava-161203/1/../bin/lava-test-case
    2022-08-30T21:05:24.916705  <8>[   20.406867] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dintel-igb-probed RESULT=3Dfail>
    2022-08-30T21:05:24.916861  /lava-161203/1/../bin/lava-test-case
    2022-08-30T21:05:24.917006  <8>[   20.426800] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-driver-present RESULT=3Dpass>
    2022-08-30T21:05:24.917153  /lava-161203/1/../bin/lava-test-case
    2022-08-30T21:05:24.917294  <8>[   20.447277] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb0-probed RESULT=3Dpass>
    2022-08-30T21:05:24.917437  /lava-161203/1/../bin/lava-test-case   =

 =20
