Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1347B49C059
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 01:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiAZAx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jan 2022 19:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiAZAx6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jan 2022 19:53:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F7EC06161C
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 16:53:58 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i8so19675981pgt.13
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 16:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YPSgXNG3SdzMs1KBvdyqNfOE4ezlpdGLDAJRiN73U1I=;
        b=WN7gvFICQZPvj1Lyw6VVHhLdweEvU5NaTGiISmg4sxZ5gQ1rFoD7E6K9BZUFYio1+F
         f6i3pnViTiiWIa/oN3WMycmpV/snaBq2bdIhPOug0VDjdT8a4awqpRwWYRJ2vH1G8tcm
         CTHiBV8m3eZjZaE+CjJe+bxnNzYD1mWc+I/3DTKPnaBybCP7iSr/sfbzmcFqJt1A+og6
         +vC9QUwTYjjuMKH3BoUDD5GycSnq6VfAtTKJflb3llUdKMIulXackd2AHYVCT4ljTJtO
         t9FVoU1UmuQ8cf+hsqvocAGnGIFapBo9o0rVsH5yr8xzTpl4KY0Kw5p5vINqA2jaCZAo
         A83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YPSgXNG3SdzMs1KBvdyqNfOE4ezlpdGLDAJRiN73U1I=;
        b=u2aQd/dmQOdvi28RWCELLvudJOaJGTVetlSrSXD+zi3l3zSIHWG60vDN53QVx1afB0
         7scWROqasxBcI0JvYnbr7W4ak8tgdMUjBLo9mZSkrTPB5RbDuD26X+GbKfH42+DPubsF
         dKMHAqH7eFxuuIJrR0Whn37+wiaZCLRXGfTOfRlckZde2p+nCRqpsVxlS3X1tF+PBaoT
         LjgM4Kc5SvGur/gMODwcdONsEOyYwj2tu/YseA7CvE4td4YOdMDmRpwKzaVmn4AN7wPa
         geE+4ygNsV7taODgWpRYIDs8zKVVW0OnFHJ2tFbF4Hko7XshXo0fLU8F5MBeQX4xEFoc
         Cqcg==
X-Gm-Message-State: AOAM531a5DUBqGq3eFS6xSbjajZLzBM7Ur+qfG6ZUxecXRxSXP3uJObH
        RXFJzKU+oG7TP7ra03JSn5IAQw==
X-Google-Smtp-Source: ABdhPJzM6FNnn/uPMXKkL6YwTqpPPhKRuAVFCBLx0EMg+jVN8rnXhFV7rlnrvQclAOFdnJfouBzq7Q==
X-Received: by 2002:aa7:9edc:0:b0:4c6:eb85:be8c with SMTP id r28-20020aa79edc000000b004c6eb85be8cmr20212800pfq.62.1643158437755;
        Tue, 25 Jan 2022 16:53:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q9sm193304pfk.137.2022.01.25.16.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 16:53:57 -0800 (PST)
Message-ID: <61f09ba5.1c69fb81.78e6b.0df2@mx.google.com>
Date:   Tue, 25 Jan 2022 16:53:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.17-rc1
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 52 runs, 4 regressions (v5.17-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 52 runs, 4 regressions (v5.17-rc1)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
imx8mn-ddr4-evk       | arm64 | lab-nxp     | gcc-10   | defconfig | 2     =
     =

kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 2     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.17-rc=
1/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e783362eb54cd99b2cac8b3a9aeac942e6f6ac07 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
imx8mn-ddr4-evk       | arm64 | lab-nxp     | gcc-10   | defconfig | 2     =
     =


  Details:     https://kernelci.org/test/plan/id/61f08d1d0b1fe6e977abbd81

  Results:     4 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc1/arm64/def=
config/gcc-10/lab-nxp/baseline-imx8mn-ddr4-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc1/arm64/def=
config/gcc-10/lab-nxp/baseline-imx8mn-ddr4-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/61f08d1d0b1fe6e=
977abbd88
        new failure (last pass: v5.16-rc7-119-g63b95bce9ea4)
        12 lines

    2022-01-25T23:51:25.936824  kern  :alert : Unable to handle kernel NULL=
 pointer dereference <8>[   14.438533] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=
=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D12>
    2022-01-25T23:51:25.937031  at virtual address 0000000000000000
    2022-01-25T23:51:25.937139  kern  :alert : Mem abort info:
    2022-01-25T23:51:25.937239  kern  :alert :   ESR =3D 0x96000006
    2022-01-25T23:51:25.937337  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), IL =3D 32 bits   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/61f08d1d0b1fe6e=
977abbd89
        new failure (last pass: v5.16-rc7-119-g63b95bce9ea4)
        2 lines

    2022-01-25T23:51:25.938037  kern  :alert :   SET =3D <8>[   14.462950] =
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEAS=
UREMENT=3D2>
    2022-01-25T23:51:25.938139  0, FnV =3D 0   =

 =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 2     =
     =


  Details:     https://kernelci.org/test/plan/id/61f08be47b3952893eabbd5f

  Results:     91 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc1/arm64/def=
config/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc1/arm64/def=
config/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/61f08be57b3952893eabbda0
        new failure (last pass: v5.16-rc8-171-gf099fd60c342)

    2022-01-25T23:46:20.381491  /lava-83642/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-probed: https://kernelci.org/test/case/id/61f=
08be57b3952893eabbda1
        new failure (last pass: v5.16-rc8-171-gf099fd60c342)

    2022-01-25T23:46:20.383768  <8>[   17.402413] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>
    2022-01-25T23:46:21.433332  /lava-83642/1/../bin/lava-test-case
    2022-01-25T23:46:21.433654  <8>[   18.421819] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-probed RESULT=3Dfail>   =

 =20
