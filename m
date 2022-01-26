Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0E649D48A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 22:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiAZVcs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 16:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiAZVcr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 16:32:47 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17219C06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 13:32:47 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so712809plh.13
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 13:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VzD9V2RVr99sFMsvfBA6tReybSYrcbyX0IM/e7N2blY=;
        b=35fPReULFkdneisr5/soxM8Wwx9TprrkBglq6T/DDnxg2C2aXjtLWZpIvklK5ePVn4
         ZA5AQSVD8brf5OIpx1Zot8tfgq8Pa3DqCCK3StiXz0/EizzQWoJHh+JmoObIJwpjtIzP
         NdV7qVfrH+4RNaEpRZ35X6oY5anIJKCuY36saBkpaw8rc7+6fBAwUFhmn+qojCaCdwxe
         tABZNzwiEEF3XJ/NwB5N3ELvXS20g62bRXLNTnfnuKHtukiMm+kWacc93VFFAxgICXHg
         xMzdZ0Ck+2wpMg9d1A/1tDLCcbPOyuHCZ3Ws9dx9fbbuSELrxefBbG0ukk4xYZpG+j8F
         Nl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VzD9V2RVr99sFMsvfBA6tReybSYrcbyX0IM/e7N2blY=;
        b=CTUkQM9F2fVd+KAGKrRBkZmGSrJ3vEnSvbNpG5s52W/RhQowIG/jNieNCQJ5OLRHZP
         q/n4KLdDSKvidxcN9Neyazv2aN9n1wvOcPOyzyZ8JicyWEMaEkk2oQLjh29YUTgD8dZB
         dLugsg8ZehTQusch+n4b7ll0gfrjuXTyPOM9q01Spf7aMY61uugni7yFJHO09B16H7IH
         eqH57ShR8dp/1nC0sLKtNQ9ksTCDUZiz3hXOtUqKU1VhLyHXbmYV77E0CkLOlTgZ9hKD
         IGfXXyeqgq7cNvUa7sIxWEPSFGSlZXDwEk0bHWW7r6Ht8UXbvrr53ddkXDB67gX3IDbK
         Bx6w==
X-Gm-Message-State: AOAM532BMyCa4TEC5MW59W+WyBndWi0u19pbhIoK2NdpxHtUcHDvnUGF
        cwgnQg/c3x9jU7j9wHynSygEjhBwuXTZLCKqK1s=
X-Google-Smtp-Source: ABdhPJzgqlQRM41y2HOIa5J/p3k8vYn4A9SxZhm0MQZnj+2M4ntPvSv01VYUxk+RizMwVZPl26hTGw==
X-Received: by 2002:a17:902:8e84:: with SMTP id bg4mr503920plb.141.1643232766472;
        Wed, 26 Jan 2022 13:32:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s14sm3071872pfk.174.2022.01.26.13.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:32:46 -0800 (PST)
Message-ID: <61f1bdfe.1c69fb81.3816b.9348@mx.google.com>
Date:   Wed, 26 Jan 2022 13:32:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.17-rc1-9-g52d883c7bbae
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 89 runs,
 7 regressions (v5.17-rc1-9-g52d883c7bbae)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 89 runs, 7 regressions (v5.17-rc1-9-g52d883c7bbae)

Regressions Summary
-------------------

platform               | arch  | lab           | compiler | defconfig      =
    | regressions
-----------------------+-------+---------------+----------+----------------=
----+------------
imx8mn-ddr4-evk        | arm64 | lab-nxp       | gcc-10   | defconfig      =
    | 2          =

kontron-kbox-a-230-ls  | arm64 | lab-kontron   | gcc-10   | defconfig      =
    | 2          =

kontron-sl28-var3-ads2 | arm64 | lab-kontron   | gcc-10   | defconfig      =
    | 2          =

tegra124-nyan-big      | arm   | lab-collabora | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.17-rc=
1-9-g52d883c7bbae/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc1-9-g52d883c7bbae
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      52d883c7bbae11e5f06311eae7778db69bc4806e =



Test Regressions
---------------- =



platform               | arch  | lab           | compiler | defconfig      =
    | regressions
-----------------------+-------+---------------+----------+----------------=
----+------------
imx8mn-ddr4-evk        | arm64 | lab-nxp       | gcc-10   | defconfig      =
    | 2          =


  Details:     https://kernelci.org/test/plan/id/61f1b1d1b836d16c05abbd15

  Results:     4 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc1-9-g52d883=
c7bbae/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn-ddr4-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc1-9-g52d883=
c7bbae/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn-ddr4-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/61f1b1d1b836d16=
c05abbd1c
        failing since 0 day (last pass: v5.16-rc7-119-g63b95bce9ea4, first =
fail: v5.17-rc1)
        12 lines

    2022-01-26T20:40:32.427945  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 000000000000<8>[   14.926914] <LAVA=
_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREME=
NT=3D12>
    2022-01-26T20:40:32.428326  0000   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/61f1b1d1b836d16=
c05abbd1d
        failing since 0 day (last pass: v5.16-rc7-119-g63b95bce9ea4, first =
fail: v5.17-rc1)
        2 lines

    2022-01-26T20:40:32.429683  kern  :alert : Mem abort info:
    2022-01-26T20:40:32.429929  kern  :alert :   ESR =3D 0x96000006
    2022-01-26T20:40:32.430230  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), IL =3D 32 bits
    2022-01-26T20:40:32.430468  kern  :alert :   SET =3D 0, FnV =3D 0
    2022-01-26T20:40:32.430699  kern  :alert :   EA<8>[   14.953797] <LAVA_=
SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMEN=
T=3D2>
    2022-01-26T20:40:32.430931   =3D 0, S1PTW =3D 0
    2022-01-26T20:40:32.431158  kern  :alert :  <8>[   14.964545] <LAVA_SIG=
NAL_ENDRUN 0_dmesg 813382_1.5.2.4.1>
    2022-01-26T20:40:32.431386   FSC =3D 0x06: level 2 translation fault
    2022-01-26T20:40:32.431611  kern  :alert : Data abort info:   =

 =



platform               | arch  | lab           | compiler | defconfig      =
    | regressions
-----------------------+-------+---------------+----------+----------------=
----+------------
kontron-kbox-a-230-ls  | arm64 | lab-kontron   | gcc-10   | defconfig      =
    | 2          =


  Details:     https://kernelci.org/test/plan/id/61f1b1f006e5cb90f9abbd2e

  Results:     91 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc1-9-g52d883=
c7bbae/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc1-9-g52d883=
c7bbae/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/61f1b1f006e5cb90f9abbd6f
        failing since 0 day (last pass: v5.16-rc8-171-gf099fd60c342, first =
fail: v5.17-rc1)

    2022-01-26T20:40:46.994347  /lava-84014/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-probed: https://kernelci.org/test/case/id/61f=
1b1f006e5cb90f9abbd70
        failing since 0 day (last pass: v5.16-rc8-171-gf099fd60c342, first =
fail: v5.17-rc1)

    2022-01-26T20:40:46.997618  <8>[   16.868291] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>
    2022-01-26T20:40:48.044048  /lava-84014/1/../bin/lava-test-case
    2022-01-26T20:40:48.044413  <8>[   17.887014] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab           | compiler | defconfig      =
    | regressions
-----------------------+-------+---------------+----------+----------------=
----+------------
kontron-sl28-var3-ads2 | arm64 | lab-kontron   | gcc-10   | defconfig      =
    | 2          =


  Details:     https://kernelci.org/test/plan/id/61f1b1270acce51239abbd39

  Results:     99 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc1-9-g52d883=
c7bbae/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc1-9-g52d883=
c7bbae/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/61f1b1270acce51239abbd81
        new failure (last pass: v5.16-rc8-171-gf099fd60c342)

    2022-01-26T20:37:51.103124  /lava-84012/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-probed: https://kernelci.org/test/case/id/61f=
1b1270acce51239abbd82
        new failure (last pass: v5.16-rc8-171-gf099fd60c342)

    2022-01-26T20:37:51.106275  <8>[   13.413255] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>
    2022-01-26T20:37:52.153351  /lava-84012/1/../bin/lava-test-case
    2022-01-26T20:37:52.153750  <8>[   14.432299] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-probed RESULT=3Dfail>
    2022-01-26T20:37:52.153995  /lava-84012/1/../bin/lava-test-case
    2022-01-26T20:37:52.154223  <8>[   14.448601] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsimple-mfd-i2c-driver-present RESULT=3Dpass>   =

 =



platform               | arch  | lab           | compiler | defconfig      =
    | regressions
-----------------------+-------+---------------+----------+----------------=
----+------------
tegra124-nyan-big      | arm   | lab-collabora | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/61f1bd1e6599627f83abbd17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc1-9-g52d883=
c7bbae/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc1-9-g52d883=
c7bbae/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61f1bd1e6599627f83abb=
d18
        new failure (last pass: v5.16-rc8-173-g00759929cccb) =

 =20
