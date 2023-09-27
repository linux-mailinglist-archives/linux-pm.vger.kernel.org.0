Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB0D7B0947
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 17:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjI0Ptp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 11:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjI0Pt1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 11:49:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5676272BD
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 08:49:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso84086745ad.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695829745; x=1696434545; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/r6KOsgeESFzwE8GogZqR7+l1+b42jLF1wzyemDGg0g=;
        b=0WuxS3SSrLzfOPGcBdrVto2tYC2+YRdcRQDtK8Jd5IUkx+5+W6EE3fGJXJ/l3QzVE9
         JZfu0XOnP/I7WTOmC/IuWrmciQsbqAgPWlYaM1nKgvvef8/6WiA1CKiCYhlkgQKxak4I
         rVA1Ozl/beEQNDZdDSfkv5jgFfGeEB89NeoVKzI33OEo+jKs/49EP7uY3vr3hJOB7ODW
         7AaxHrixlQknJ1dsGZRBiBANBgIcYiiORSkeOZReRBPAvxFEDs5ZUeWmpQpDSGQp7KG+
         gGvyIxczcvr5J4RYq+EaLAbSFyzJSst60Y1iAipo8o1z/5Yl/hVFvejnrUxbpW77Dpz7
         B3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829745; x=1696434545;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/r6KOsgeESFzwE8GogZqR7+l1+b42jLF1wzyemDGg0g=;
        b=WImvxj9uiO6anr5x7KvPNYq21aEfCwq1iP14wDBwM6qtPrwTuD8q6xbqLchAFYINhP
         IRR42NHyHngTObtK1t8LHWKHlrIjuSLysBis33yKrqji9PWxAtqcX/DKkqRTA8pLLTB3
         wU/GyVEo1Nb1gs63bIgap/GERyoGrmbukrWLSB+4jJOxX+hUJx55hdT3wUjfUZbrNDJh
         LKkrkBwgWIt/RJk4IoGQeR83neBgARFxenZ/haNRNTDZ4DqnSOLhSnrovf/Qme8TIbGr
         2exejE8VSX7V9puOfLN4NAkdLxRjAX8QWVIvWVT3i2YgdgHvCQ8ud+WOSbLW4H0pmSQG
         m6Ow==
X-Gm-Message-State: AOJu0Yw684gM6Ax6WmBXtvuilU7rQXft6RhD++14tWsZYcG/wp5Vt5dg
        VOKvBmoGtfcaymKKex1Ke7Lo/N9zPIo7LiDhYCu9eg==
X-Google-Smtp-Source: AGHT+IHBshtPQqRzTXSNG492CZ07TCdRu0MLoIEO/qr3TF02e3g2vskr5MXDpl6cENe79mlrK3LvpA==
X-Received: by 2002:a17:902:c946:b0:1c5:d063:b70e with SMTP id i6-20020a170902c94600b001c5d063b70emr2715925pla.53.1695829745209;
        Wed, 27 Sep 2023 08:49:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b001b5656b0bf9sm7677314plq.286.2023.09.27.08.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:49:04 -0700 (PDT)
Message-ID: <65144ef0.170a0220.f5d4f.a08c@mx.google.com>
Date:   Wed, 27 Sep 2023 08:49:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc3-47-ga2577d67cb05
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 47 runs,
 3 regressions (v6.6-rc3-47-ga2577d67cb05)
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

pm/testing baseline: 47 runs, 3 regressions (v6.6-rc3-47-ga2577d67cb05)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =

r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc3=
-47-ga2577d67cb05/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc3-47-ga2577d67cb05
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a2577d67cb05d6553674e7ddda362d22096a955b =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6514444bff70ab9ed78a0a4f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc3-47-ga2577d=
67cb05/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc3-47-ga2577d=
67cb05/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6514444bff70ab9ed78a0a58
        failing since 15 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, fir=
st fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-09-27T15:03:15.987761  + set<8>[   29.746556] <LAVA_SIGNAL_ENDRUN =
0_dmesg 136329_1.5.2.4.1>
    2023-09-27T15:03:15.988342   +x
    2023-09-27T15:03:16.096790  / # #
    2023-09-27T15:03:17.262682  export SHELL=3D/bin/sh
    2023-09-27T15:03:17.268837  #
    2023-09-27T15:03:18.768176  / # export SHELL=3D/bin/sh. /lava-136329/en=
vironment
    2023-09-27T15:03:18.774212  =

    2023-09-27T15:03:21.497994  / # . /lava-136329/environment/lava-136329/=
bin/lava-test-runner /lava-136329/1
    2023-09-27T15:03:21.504727  =

    2023-09-27T15:03:21.506416  / # /lava-136329/bin/lava-test-runner /lava=
-136329/1 =

    ... (12 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/651444337196eb0ec58a0b2f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc3-47-ga2577d=
67cb05/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc3-47-ga2577d=
67cb05/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651444337196eb0ec58a0b38
        failing since 69 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-27T15:07:19.953344  / # #

    2023-09-27T15:07:20.053818  export SHELL=3D/bin/sh

    2023-09-27T15:07:20.053955  #

    2023-09-27T15:07:20.154408  / # export SHELL=3D/bin/sh. /lava-11628446/=
environment

    2023-09-27T15:07:20.154547  =


    2023-09-27T15:07:20.255073  / # . /lava-11628446/environment/lava-11628=
446/bin/lava-test-runner /lava-11628446/1

    2023-09-27T15:07:20.255358  =


    2023-09-27T15:07:20.267527  / # /lava-11628446/bin/lava-test-runner /la=
va-11628446/1

    2023-09-27T15:07:20.320745  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-27T15:07:20.320909  + cd /lava-116284<8>[   20.417311] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11628446_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65144443fa30c64eff8a0a9f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc3-47-ga2577d=
67cb05/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc3-47-ga2577d=
67cb05/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65144443fa30c64eff8a0aa8
        failing since 69 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-27T15:03:23.626469  / # #

    2023-09-27T15:03:24.704302  export SHELL=3D/bin/sh

    2023-09-27T15:03:24.705596  #

    2023-09-27T15:03:26.193726  / # export SHELL=3D/bin/sh. /lava-11628426/=
environment

    2023-09-27T15:03:26.195505  =


    2023-09-27T15:03:28.912170  / # . /lava-11628426/environment/lava-11628=
426/bin/lava-test-runner /lava-11628426/1

    2023-09-27T15:03:28.913523  =


    2023-09-27T15:03:28.918043  / # /lava-11628426/bin/lava-test-runner /la=
va-11628426/1

    2023-09-27T15:03:28.982901  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-27T15:03:28.983346  + cd /lava-116284<8>[   28.533649] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11628426_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =20
