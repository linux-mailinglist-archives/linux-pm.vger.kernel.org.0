Return-Path: <linux-pm+bounces-4457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD54869D51
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4499D287704
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E2C2836D;
	Tue, 27 Feb 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GL9pCtJ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28EB3EA93
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054168; cv=none; b=W9N8YtF9okKdydnoT7HdJBt834sh+a3h0x0MKZs9tt9kemUGzOaHI91td9WHGaAiaDe5UXJF7oIIMEHCM6B7aRs7zsbF9l32WBxGRllevu4YC+X529GzZQDgnmxQ086ExDyr0u8IOnmHnJgsV4J3LUFGAKO8L+et2ozpnDByHbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054168; c=relaxed/simple;
	bh=KZsdsQpY4yL0ouRbMBbZkgPR7O7eNQSNKV3NLXJ55co=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=MbyXybKgsLPWm1KVPaRv+xJE4YtnSLtlf1myEX/mZawGAwxijo0AklGSn7RjhrYmVaV4/ZQ1HYlg2UhCZGE5LKdNUKg5dz/yOMxEEPCxcFaZlTpJ5PQxSJnzTIjQFuGIclCTTZGsDHmVrTwaMd3/N5KR/Ht+9FyG1za8b/SBh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=GL9pCtJ+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-299a2456948so3155919a91.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 09:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709054165; x=1709658965; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UbhqtXr7CQepDP1TWtkbR+y3AJG2XLhEEYgb7RoF6F8=;
        b=GL9pCtJ+cxwZHf3h1eRcr2Pkv6h4CF3avVPEWsuT2HsuRHuVq3h1sBLcOOpJAnlyT8
         HyORtbEqPGQAA718gCkL8eWhFJwmke9lplb7VTwdXSqY+6okIPjg69Tsx+uAKaU9O4Fz
         wf+ef76Wut3K90FHqrg8SwLpp3DvgCEIoDFoXPdRolbl8Ui4PnLLwZ/RqZg8EDS2Jn7I
         pOv15aWTr4AM201X47XVsmFJv/FBvC0j+9Uh/YpZ49cSh0w/s6AMmhTXVBzNDm7P9+GC
         RpmFj8kV+7ZDFfjI5XmcZX0dP8ARaZQR9nnj5tx4PEdqZpR8Zgj6NEojdQF7C0RIBzXw
         R9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054165; x=1709658965;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbhqtXr7CQepDP1TWtkbR+y3AJG2XLhEEYgb7RoF6F8=;
        b=g2bLkxB1NMvml50Hyu4IjTOemJqRUHiWoeQYubtEsJHV2rq3zwth885frqtOg4eNfM
         TpaaQH2HnXlJbZCqG8paC/hxZKUkrVWeHjoYFADqnDGN2nny+n0ihyZcJBZvExGqBQZD
         jXakXJgKXCvVVkiYFIrYoX5ZZsUpgGKns2Tl2XFpmU6KgIBBfmqyo13PNQir6n7yDhqz
         FyQB2oujjE+BZIlaZCt6BoGy9Co6so6t1YPpsU3aTDT06uQLNse2MDD3ywWK3HERYhzw
         3DZj1KBOE4AkUWoBA2IbApdWEd2IuJprfL35CJUf4qRvjF3AlrDBI/fsuIA328HedXmt
         VxvA==
X-Forwarded-Encrypted: i=1; AJvYcCXjzioY1drQMHjD2sFnQtpOwXK0jAd194soY7QRGMleIFt/IEBFOAOLOlhsk0gmstAZnAl7fGfBCBi8Q8iAcND3Y9DZkMQ7IaM=
X-Gm-Message-State: AOJu0YzyNdLqpbGIDMu938d9VTa9MTObdtD3aOUC+myNfyhdz0tMzGzc
	J2GtFlVXOSY6MfFhrKlriwadzGgkhE7SJkqbaXVuW+XXTCWlJxZfpfqst9tv8mg=
X-Google-Smtp-Source: AGHT+IFsgnpGQlETmXJf48d36mVDtk5Rp1xXawpPse2Cmsd3A4cXeDSVsjzKqU55AlHNOKGRk1xZFA==
X-Received: by 2002:a17:90b:8c:b0:29a:e9cd:74aa with SMTP id bb12-20020a17090b008c00b0029ae9cd74aamr1227891pjb.35.1709054164818;
        Tue, 27 Feb 2024 09:16:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n15-20020a17090ade8f00b002995e9aca72sm6816942pjv.29.2024.02.27.09.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:16:04 -0800 (PST)
Message-ID: <65de18d4.170a0220.c5c7d.7cc0@mx.google.com>
Date: Tue, 27 Feb 2024 09:16:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.8-rc6-119-g377070604cce
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 54 runs,
 8 regressions (v6.8-rc6-119-g377070604cce)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 54 runs, 8 regressions (v6.8-rc6-119-g377070604cce)

Regressions Summary
-------------------

platform               | arch  | lab             | compiler | defconfig    =
      | regressions
-----------------------+-------+-----------------+----------+--------------=
------+------------
imx53-qsrb             | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig | 1          =

kontron-kbox-a-230-ls  | arm64 | lab-kontron     | gcc-10   | defconfig    =
      | 5          =

kontron-sl28-var3-ads2 | arm64 | lab-kontron     | gcc-10   | defconfig    =
      | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc6=
-119-g377070604cce/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc6-119-g377070604cce
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      377070604cce56dce4b795d8cb26bcd5e13bf2af =



Test Regressions
---------------- =



platform               | arch  | lab             | compiler | defconfig    =
      | regressions
-----------------------+-------+-----------------+----------+--------------=
------+------------
imx53-qsrb             | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65de0e2b496159f1b7637055

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc6-119-g37707=
0604cce/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc6-119-g37707=
0604cce/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65de0e2b496159f1b763705a
        failing since 395 days (last pass: v6.1-rc8-156-g0a9e32afe717, firs=
t fail: acpi-6.2-rc6-146-g628c61874ffd)

    2024-02-27T16:30:15.677867  + set +x
    2024-02-27T16:30:15.678020  [   13.502505] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1029457_1.5.2.3.1>
    2024-02-27T16:30:15.785607  / # #
    2024-02-27T16:30:15.886818  export SHELL=3D/bin/sh
    2024-02-27T16:30:15.887291  #
    2024-02-27T16:30:15.988012  / # export SHELL=3D/bin/sh. /lava-1029457/e=
nvironment
    2024-02-27T16:30:15.988423  =

    2024-02-27T16:30:16.089247  / # . /lava-1029457/environment/lava-102945=
7/bin/lava-test-runner /lava-1029457/1
    2024-02-27T16:30:16.089844  =

    2024-02-27T16:30:16.093289  / # /lava-1029457/bin/lava-test-runner /lav=
a-1029457/1 =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
      | regressions
-----------------------+-------+-----------------+----------+--------------=
------+------------
kontron-kbox-a-230-ls  | arm64 | lab-kontron     | gcc-10   | defconfig    =
      | 5          =


  Details:     https://kernelci.org/test/plan/id/65de0e8802aa6713c0637017

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc6-119-g37707=
0604cce/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc6-119-g37707=
0604cce/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65de0e8802aa6713c063701e
        failing since 34 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-27T16:31:45.055097  / # #
    2024-02-27T16:31:45.157262  export SHELL=3D/bin/sh
    2024-02-27T16:31:45.158001  #
    2024-02-27T16:31:45.259388  / # export SHELL=3D/bin/sh. /lava-435704/en=
vironment
    2024-02-27T16:31:45.260085  =

    2024-02-27T16:31:45.361604  / # . /lava-435704/environment/lava-435704/=
bin/lava-test-runner /lava-435704/1
    2024-02-27T16:31:45.362878  =

    2024-02-27T16:31:45.410381  / # /lava-435704/bin/lava-test-runner /lava=
-435704/1
    2024-02-27T16:31:45.425390  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-27T16:31:45.425822  + <8>[   20.726163] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 435704_1.5.2.4.5> =

    ... (15 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65de0e8802aa6713c0637022
        failing since 34 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-27T16:31:47.533362  /lava-435704/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
de0e8902aa6713c0637024
        failing since 34 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-27T16:31:48.591574  /lava-435704/1/../bin/lava-test-case
    2024-02-27T16:31:48.592069  <8>[   23.874034] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65de0e8902aa6713c0637029
        failing since 34 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-27T16:31:49.665082  /lava-435704/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65de0e8902aa6713c063702a
        failing since 34 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-27T16:31:49.667343  <8>[   24.983921] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-02-27T16:31:50.727779  /lava-435704/1/../bin/lava-test-case   =

 =



platform               | arch  | lab             | compiler | defconfig    =
      | regressions
-----------------------+-------+-----------------+----------+--------------=
------+------------
kontron-sl28-var3-ads2 | arm64 | lab-kontron     | gcc-10   | defconfig    =
      | 2          =


  Details:     https://kernelci.org/test/plan/id/65de0e9df36fea77f9637044

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc6-119-g37707=
0604cce/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc6-119-g37707=
0604cce/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65de0e9df36fea77f963704b
        failing since 34 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-27T16:32:05.961217  / # #
    2024-02-27T16:32:06.062404  export SHELL=3D/bin/sh
    2024-02-27T16:32:06.062716  #
    2024-02-27T16:32:06.163775  / # export SHELL=3D/bin/sh. /lava-435707/en=
vironment
    2024-02-27T16:32:06.165868  =

    2024-02-27T16:32:06.269915  / # . /lava-435707/environment/lava-435707/=
bin/lava-test-runner /lava-435707/1
    2024-02-27T16:32:06.272974  =

    2024-02-27T16:32:06.275946  / # /lava-435707/bin/lava-test-runner /lava=
-435707/1
    2024-02-27T16:32:06.342712  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-27T16:32:06.345886  + <8>[   21.002583] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 435707_1.5.2.4.5> =

    ... (13 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65de0e9df36fea77f963705e
        failing since 34 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-27T16:32:08.766590  /lava-435707/1/../bin/lava-test-case
    2024-02-27T16:32:08.766731  <8>[   23.418085] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-02-27T16:32:08.766821  /lava-435707/1/../bin/lava-test-case   =

 =20

