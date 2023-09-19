Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435A97A5764
	for <lists+linux-pm@lfdr.de>; Tue, 19 Sep 2023 04:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjISC0D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 22:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjISC0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 22:26:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E7F10D
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 19:25:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c3d6d88231so41427915ad.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 19:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695090356; x=1695695156; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vtJ/1GbiYgSKhLymlpWYrMBHchv6N8MwzO2XFDqGDvI=;
        b=Vgx7rMuzafCJZ42kPUP/esJA+gc1fMn2EKnNXhvfcsGC4BWOD4aM6MEfj6jXq87qyw
         d8ZR2wkbPSr1BHn4eudI/YlnxLo7TJJz2W071AKVxhJDGwPtHzCMB2o9Xk95hLmWjT0R
         KsHJF6AwJ2iIqhVdGNLhcCX/5SqT3uh5GHgh23KqHDUJ7TI+u9VVmLX3C2cPqpkCHTiy
         ejLPtd0Z4yP1iR/U4Krw8RFSENQ96RqkaEjsHQ3BkoVn8nbaaEjFUSQZl44uyx0KQkAK
         bORnJYoYeuda3WdaiEnK2VOFxxVjo4PlYrEpeUP9j4lBBS7kyt6U6xPn9CM952kr+DXQ
         AOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695090356; x=1695695156;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtJ/1GbiYgSKhLymlpWYrMBHchv6N8MwzO2XFDqGDvI=;
        b=jCxs5kl2BtHQ/n3KF/dUToHF74hTpXjj3SLyyBGv0DkRKNDVte7ruqE95uVJS6M6Gq
         teg1tYkLVAsSK5gAcpoW/BIztVsp6LcdCMhkeYoZSb3d2bw4EsEKhZF1s5OPj681viA4
         j15IzzOdJvfcoSu3AfOledwSyJ1XSWfn4YRxJltMHIrXJU1m5ORAEDiFzkEgRXUztT7F
         Q1Oi5eiB0c0crpGG8ZsSknWruRD/pz2pzsQmH60J8RJcucKyc/zetX2AiAuNA/mCJJsu
         MmsHb4HWd9ULtSID6n8laacyAaNVViap0P5Pezx/3rFqv0DnyLtLJvgXevUQ1qNtTQRM
         Uh3A==
X-Gm-Message-State: AOJu0YySXwdSxkTJihi1ivV9Xp7GZi4uHp26uvgHzzLxh6Er5USDtcU9
        LqNiJvaPW4WLMt/33wDEXz54+gPJJ4rrClls/feYfw==
X-Google-Smtp-Source: AGHT+IHY7pJLyv1nm7oUMEa5YyLbo3j6HUXKus+V8tBa4MWkvXk9nzo1m8rLwPPkzn+B5BGuITedfA==
X-Received: by 2002:a17:903:246:b0:1bf:6ad7:2286 with SMTP id j6-20020a170903024600b001bf6ad72286mr10261419plh.43.1695090356294;
        Mon, 18 Sep 2023 19:25:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001c3267ae31bsm3183040plz.301.2023.09.18.19.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 19:25:55 -0700 (PDT)
Message-ID: <650906b3.170a0220.c9447.b084@mx.google.com>
Date:   Mon, 18 Sep 2023 19:25:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc2-10-gb34108fa27bd
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 48 runs,
 3 regressions (v6.6-rc2-10-gb34108fa27bd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 48 runs, 3 regressions (v6.6-rc2-10-gb34108fa27bd)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =

r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc2=
-10-gb34108fa27bd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc2-10-gb34108fa27bd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      b34108fa27bd31c2e82b5f41c55066d83822c7b3 =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6508f9a45f4febea678a0a87

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc2-10-gb34108=
fa27bd/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc2-10-gb34108=
fa27bd/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6508f9a45f4febea678a0a90
        failing since 6 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, firs=
t fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-09-19T01:29:59.945848  + set<8>[   29.007720] <LAVA_SIGNAL_ENDRUN =
0_dmesg 116195_1.5.2.4.1>
    2023-09-19T01:29:59.946531   +x
    2023-09-19T01:30:00.057438  / # #
    2023-09-19T01:30:01.219880  export SHELL=3D/bin/sh
    2023-09-19T01:30:01.225951  #
    2023-09-19T01:30:02.721562  / # export SHELL=3D/bin/sh. /lava-116195/en=
vironment
    2023-09-19T01:30:02.727761  =

    2023-09-19T01:30:05.444430  / # . /lava-116195/environment/lava-116195/=
bin/lava-test-runner /lava-116195/1
    2023-09-19T01:30:05.451041  =

    2023-09-19T01:30:05.467992  / # /lava-116195/bin/lava-test-runner /lava=
-116195/1 =

    ... (12 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6508fc2c30a1a6432c8a0a74

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc2-10-gb34108=
fa27bd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc2-10-gb34108=
fa27bd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6508fc2c30a1a6432c8a0a7d
        failing since 61 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-19T01:45:02.918206  / # #

    2023-09-19T01:45:03.020395  export SHELL=3D/bin/sh

    2023-09-19T01:45:03.021106  #

    2023-09-19T01:45:03.122493  / # export SHELL=3D/bin/sh. /lava-11566571/=
environment

    2023-09-19T01:45:03.123269  =


    2023-09-19T01:45:03.224782  / # . /lava-11566571/environment/lava-11566=
571/bin/lava-test-runner /lava-11566571/1

    2023-09-19T01:45:03.225928  =


    2023-09-19T01:45:03.241945  / # /lava-11566571/bin/lava-test-runner /la=
va-11566571/1

    2023-09-19T01:45:03.292463  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T01:45:03.292982  + cd /lav<8>[   20.551736] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11566571_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6508f9a25f4febea678a0a7c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc2-10-gb34108=
fa27bd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc2-10-gb34108=
fa27bd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6508f9a25f4febea678a0a85
        failing since 61 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-19T01:31:53.834176  / # #

    2023-09-19T01:31:54.914175  export SHELL=3D/bin/sh

    2023-09-19T01:31:54.916036  #

    2023-09-19T01:31:56.406846  / # export SHELL=3D/bin/sh. /lava-11566566/=
environment

    2023-09-19T01:31:56.408597  =


    2023-09-19T01:31:59.133275  / # . /lava-11566566/environment/lava-11566=
566/bin/lava-test-runner /lava-11566566/1

    2023-09-19T01:31:59.135371  =


    2023-09-19T01:31:59.143562  / # /lava-11566566/bin/lava-test-runner /la=
va-11566566/1

    2023-09-19T01:31:59.204684  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T01:31:59.205213  + cd /lav<8>[   29.545860] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11566566_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =20
