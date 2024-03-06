Return-Path: <linux-pm+bounces-4742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9125873A02
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E361C20985
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F356113443C;
	Wed,  6 Mar 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ChN9PY7S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91013442A
	for <linux-pm@vger.kernel.org>; Wed,  6 Mar 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737226; cv=none; b=IWJ2TBoAIL8S/L7jgB9S0/gc0eOL8wQ2omT33SgNjJn/MO04VAPlOad6/G39NLTBTyPImDhTEObGvORTUY/BWUFwjL/ocSAhbzTscg2Ax9SBSYesDKTXdXwMkxhj39OdDmwQKGlGPj3jQISuu+4XStV+Q+WMOXZEhW3aGkbHdLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737226; c=relaxed/simple;
	bh=TUGQ4gPbF0KXPGsqGWfvnJ5L+GYoxxQAI4VF7MHBnKw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ijFqnGcXaquooFAcATGiGS11Pz26ZNjKFyyy6H9gnTjIEJYh3PwA7RTm1ehmwlLTDsmnQLxBh/nwRU77iL5F0XOVNFSTwNqXqTlJwVjEW5qRAiEOvvF6yIefVgq5wZ74hUAQsldG6dxKmC2mel4yzmpCLEnbqq62f9tz8nPrYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ChN9PY7S; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso6398091a12.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Mar 2024 07:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709737224; x=1710342024; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y71OVdkIze1FX79HKIiba0z9GCviagtoytFb7K2n3y0=;
        b=ChN9PY7SbpJlAA1Dv5Wo+gBpw44ey3bvH99vPQjuq4eDEgPmddggbmvBy2gYIA6bwg
         Zubqm3NbqDkiPQK4dqyze7d9eUZ5XwGmR8uimPc6BGHDm+Kr/+JFqUdnsF8dnZD2ri5N
         3/BLiqzm01yBeugpH1NVOuRYrzm83bm1XpfTy6H63+mBkEX7BHaldBH2urRhNiFVB8MF
         iVrDR7TTyYB09HsBhszYt5uGHkQ2qu9p6VedcUbCEne2blqTaNcViIfLjpC6uUc8wKfe
         eheoRSLkaGks+Gab8RQ4Jlb6wPpbZNMyRhySP4squWZavSIi4Tt9FgLERaJzo+AZvvAk
         Ghbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737224; x=1710342024;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y71OVdkIze1FX79HKIiba0z9GCviagtoytFb7K2n3y0=;
        b=h2zd9jK8D2HJLoyTE43SJAs6oZWkuAe6wNxr4yeTpJ/cj4oRxKiu6J0xkfGqNNsYcS
         XG/4zvzlguWGDnRlcfCdnwk+qTihDiE9zV+ntHAt/vYxQ652AYIDz+eFF69oiF1Yg6i5
         zpvyGx/FsxosZ2agI3vNSca3SNrw1oQNw31EzsyeArMz0IrLX2hchgpFx8nQ0OP6Ss2J
         a6gBxOY+R20/TRPxyvf/gySw3EGc1K6mqNAdyuTibYNEyXMVeA/3cE+atRl0OU5lT1Pl
         4M+hJpg33zcTZlNOkd6kzfIb2eBV8/7gloj3C0MZdI2Oof2C4l2jksg+UrmR0cIt+xBR
         sjXA==
X-Forwarded-Encrypted: i=1; AJvYcCVs1pPedL6sKccxlLWvvj44J5hO0eObGAmhmpFSwMuqTOipC675E8YIOnzvpS9zVJxvNr2fQ9OQBPLbwPKP2JIeppKC6lVpSLc=
X-Gm-Message-State: AOJu0YwLmg6PnZyKGQ3WgxdJDt9LvCMpGEpceaOA/CRvaVoun37UswRm
	X0ZRqlMgEdCNK5njSDv3lsG8zJ39+M8IB2n62lAWC2IEbBecz1jcUVjlktNa8LM=
X-Google-Smtp-Source: AGHT+IGW6gPv9qmLoZ+/9am/Utg1YTMNPHqMro41mg8hEnVqlWPJE4VPZW5dow7Qth8VY602HkBSEg==
X-Received: by 2002:a17:90a:9a98:b0:29a:6cf0:57a3 with SMTP id e24-20020a17090a9a9800b0029a6cf057a3mr12141547pjp.8.1709737223210;
        Wed, 06 Mar 2024 07:00:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sk6-20020a17090b2dc600b0029abe1c3f26sm13960613pjb.1.2024.03.06.07.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:00:22 -0800 (PST)
Message-ID: <65e88506.170a0220.52e36.9472@mx.google.com>
Date: Wed, 06 Mar 2024 07:00:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.8-rc7-157-g6959ac1fa147
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 32 runs,
 7 regressions (v6.8-rc7-157-g6959ac1fa147)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 32 runs, 7 regressions (v6.8-rc7-157-g6959ac1fa147)

Regressions Summary
-------------------

platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =

kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc7=
-157-g6959ac1fa147/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc7-157-g6959ac1fa147
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      6959ac1fa14728d2428e11fb2bf8125f131fe7b3 =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65e87939c58c6c58504c42de

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc7-157-g6959a=
c1fa147/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc7-157-g6959a=
c1fa147/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e87939c58c6c58504c42e5
        failing since 42 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-06T14:09:47.172436  / # #
    2024-03-06T14:09:47.274735  export SHELL=3D/bin/sh
    2024-03-06T14:09:47.275493  #
    2024-03-06T14:09:47.377029  / # export SHELL=3D/bin/sh. /lava-439483/en=
vironment
    2024-03-06T14:09:47.377792  =

    2024-03-06T14:09:47.479278  / # . /lava-439483/environment/lava-439483/=
bin/lava-test-runner /lava-439483/1
    2024-03-06T14:09:47.480484  =

    2024-03-06T14:09:47.498866  / # /lava-439483/bin/lava-test-runner /lava=
-439483/1
    2024-03-06T14:09:47.543108  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-06T14:09:47.543557  + <8>[   20.720486] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 439483_1.5.2.4.5> =

    ... (16 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65e87939c58c6c58504c42e9
        failing since 42 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-06T14:09:49.649382  /lava-439483/1/../bin/lava-test-case
    2024-03-06T14:09:49.649814  <8>[   22.827800] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2024-03-06T14:09:49.650148  /lava-439483/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
e87939c58c6c58504c42eb
        failing since 42 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-06T14:09:50.710213  /lava-439483/1/../bin/lava-test-case
    2024-03-06T14:09:50.710662  <8>[   23.868182] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2024-03-06T14:09:50.710935  /lava-439483/1/../bin/lava-test-case
    2024-03-06T14:09:50.711156  <8>[   23.884919] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65e87939c58c6c58504c42f0
        failing since 42 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-06T14:09:51.788996  /lava-439483/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65e87939c58c6c58504c42f1
        failing since 42 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-06T14:09:51.792338  <8>[   24.984744] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-03-06T14:09:52.850476  /lava-439483/1/../bin/lava-test-case
    2024-03-06T14:09:52.850976  <8>[   26.006482] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2024-03-06T14:09:52.851321  /lava-439483/1/../bin/lava-test-case   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65e87926f17899fc3d4c43c4

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc7-157-g6959a=
c1fa147/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc7-157-g6959a=
c1fa147/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e87926f17899fc3d4c43cb
        failing since 42 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-06T14:09:15.534868  / # #
    2024-03-06T14:09:15.636621  export SHELL=3D/bin/sh
    2024-03-06T14:09:15.637234  #
    2024-03-06T14:09:15.738425  / # export SHELL=3D/bin/sh. /lava-439486/en=
vironment
    2024-03-06T14:09:15.738745  =

    2024-03-06T14:09:15.839631  / # . /lava-439486/environment/lava-439486/=
bin/lava-test-runner /lava-439486/1
    2024-03-06T14:09:15.840164  =

    2024-03-06T14:09:15.846534  / # /lava-439486/bin/lava-test-runner /lava=
-439486/1
    2024-03-06T14:09:15.912610  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-06T14:09:15.912803  + <8>[   21.093421] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 439486_1.5.2.4.5> =

    ... (11 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65e87926f17899fc3d4c43de
        failing since 42 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-06T14:09:18.339911  /lava-439486/1/../bin/lava-test-case
    2024-03-06T14:09:18.340344  <8>[   23.511411] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-03-06T14:09:18.340671  /lava-439486/1/../bin/lava-test-case   =

 =20

