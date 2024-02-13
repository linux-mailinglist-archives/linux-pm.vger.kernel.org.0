Return-Path: <linux-pm+bounces-3884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA08536E0
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 18:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930D91C244DB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57855FBB1;
	Tue, 13 Feb 2024 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="nRD3C074"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A658124
	for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844237; cv=none; b=o9EVnUI+Mzrwht8fOTJ3KaMfYNvpCXmZWLuSQS6TnhQ4s/yW8p5Y47JoH6gGswGtebkeXnS1S11BOE6tU5IilQNbGLvSlmXuupphUo3oJwPZo5Ie1w82RWZcgMLTfVrGiKklVUjXoNPRFHOuabZK8EJul0A6SRnWaYtEyEKpkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844237; c=relaxed/simple;
	bh=lmkBw8DaGjIHREW7fpJdShaY2swPzsnNkFm03mHZWCs=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=lxNq1cBd5OhZLfAxu8UejxTlFb/VSpSQohkTm+hG87bI8yJo44VKEcxXna2WzazlNFPCR2s4Ofm/TOupu5vK0MgRZPFCtLLU7B3mnKUZ3fNjt0j1IvlyToPc4ynlseWQpSz+QP6WlU9G7KwXoldeFmHjhiN5r2CPjptxPcY/Aa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=nRD3C074; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e0d085cf59so1940349b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 09:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707844235; x=1708449035; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwql1AhJJ4ZTSIZr9hA/JBwtlQDppX0DO+O2G4LgBSg=;
        b=nRD3C074ZyKPBMzmUhfLg3VYC55M4ftG6ysC65vn2qsVB3TQzREoNJMonAx8C0l3WM
         fPzU2TLzpKIdb2AbtMWTXhsNI5kLwkZTmG97NZL/83XhPuraIlXHaCiLiy6TMrv+Bsoi
         /s3KVv1CEMNTvMS/1M3QACc4LHwNyUmAjunB+MhXrHbjMkCRwpmvkjgDO54gpOR6I6UI
         248GVT8Z9tTCNVBuf0FzIzmqS6UxACGooEsJPdNY94WP/n2DD4o6PMHwMCK4oH5ucLnT
         L23hSvbpfolZRkEVp+R2KIShvTBDUIS/Zh78D0l69SvUW+Iot6/r667Po3lqHuIDarKx
         tBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844235; x=1708449035;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wwql1AhJJ4ZTSIZr9hA/JBwtlQDppX0DO+O2G4LgBSg=;
        b=jYgjkr2FliLs7YIPmD5+XP8Nr9bCQu5cjkO39bW4p61U83ht7B+72j6sLCRTUDyDMM
         +wEOnrItWfg6lg9y74+dVZ0aXaHvUsIJgfmbsxTQSkEent7XunmY/QYBTB/v21JLVbE8
         iBa6AJbECwEGIEvGNy4wiHtg0gUc/O3ByQnkuiX3rjEicjjAS0A3Fo4R8kS5H3kEbzRO
         K52YGI1gHPc2ITccU7A7otwgOcn/oDhLoLI/HrELkNmhq/i1cV4Irofz5eVS8avahIXI
         /cEHrambfCELZTvcJj0P7vu5LQAtxUzxgl7mjW5VDsiin+9Id9HYXbzGB175dQDWErLr
         Usqw==
X-Gm-Message-State: AOJu0Yz7cDDoj5bUYkMnaGwiL6ZlpS6cfvVO+1WsgOyJdsD/0wYOUb1e
	i+dCZ0MwEMSV53GmI+xMXrqL7YuVlEY8naHlNi2WFEWHWwvbwuctzHP8KIQaamA=
X-Google-Smtp-Source: AGHT+IFZMAfnuEpD5PT0IiXYUDhpuefRFTFvFjR0cFGnrIVaHAqkRCjN1110tIKpSEO0peekZbhM1Q==
X-Received: by 2002:a05:6a00:1398:b0:6dd:dc11:8dc2 with SMTP id t24-20020a056a00139800b006dddc118dc2mr15465289pfg.31.1707844235471;
        Tue, 13 Feb 2024 09:10:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaS9PTu/dDKnFSmq69UdbRyJoBYw/rifAu2MU9tswSJXANOcQvAU4dD2Vt7BYGQAOXUMeZNoLTX+iWJ3TB6AajaQ25kHWbqhVVnJPsCqVuN8QVIkCTlVvXO710K1DCJ7cLkk3hO+8bdyxfpf4AS/hrIMVyl2u3bsVALsFuSTM6f9MW7wnlLcnQucF4
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f5-20020aa79d85000000b006e0cfe94fc5sm5248531pfq.107.2024.02.13.09.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:10:34 -0800 (PST)
Message-ID: <65cba28a.a70a0220.9f63c.e56c@mx.google.com>
Date: Tue, 13 Feb 2024 09:10:34 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc4-78-gd3eb3447ef6be
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 46 runs,
 8 regressions (v6.8-rc4-78-gd3eb3447ef6be)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 46 runs, 8 regressions (v6.8-rc4-78-gd3eb3447ef6be)

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

rk3399-roc-pc          | arm64 | lab-broonie | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc4=
-78-gd3eb3447ef6be/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc4-78-gd3eb3447ef6be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d3eb3447ef6be8d2be125b991984438d5bc4b3e9 =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65cb98df4c1f2ab3d463705e

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc4-78-gd3eb34=
47ef6be/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc4-78-gd3eb34=
47ef6be/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cb98df4c1f2ab3d4637065
        failing since 20 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-13T16:28:53.482856  / # #
    2024-02-13T16:28:53.583742  export SHELL=3D/bin/sh
    2024-02-13T16:28:53.584475  #
    2024-02-13T16:28:53.685597  / # export SHELL=3D/bin/sh. /lava-429024/en=
vironment
    2024-02-13T16:28:53.686106  =

    2024-02-13T16:28:53.787217  / # . /lava-429024/environment/lava-429024/=
bin/lava-test-runner /lava-429024/1
    2024-02-13T16:28:53.788124  =

    2024-02-13T16:28:53.797497  / # /lava-429024/bin/lava-test-runner /lava=
-429024/1
    2024-02-13T16:28:53.892092  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-13T16:28:53.892271  + cd /lava-429024/1/tests/1_bootrr =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65cb98df4c1f2ab3d4637069
        failing since 20 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-13T16:28:56.108138  /lava-429024/1/../bin/lava-test-case
    2024-02-13T16:28:56.136124  <8>[   26.164609] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
cb98df4c1f2ab3d463706b
        failing since 20 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-13T16:28:57.197726  /lava-429024/1/../bin/lava-test-case
    2024-02-13T16:28:57.224755  <8>[   27.253106] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65cb98df4c1f2ab3d4637070
        failing since 20 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-13T16:28:58.457106  /lava-429024/1/../bin/lava-test-case
    2024-02-13T16:28:58.484060  <8>[   28.512139] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65cb98df4c1f2ab3d4637071
        failing since 20 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-13T16:28:59.507965  /lava-429024/1/../bin/lava-test-case
    2024-02-13T16:28:59.533891  <8>[   29.562385] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65cb98e2e85fe23f8063701d

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc4-78-gd3eb34=
47ef6be/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc4-78-gd3eb34=
47ef6be/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cb98e2e85fe23f80637024
        failing since 20 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-13T16:28:49.892904  / # #
    2024-02-13T16:28:49.994612  export SHELL=3D/bin/sh
    2024-02-13T16:28:49.995376  #
    2024-02-13T16:28:50.096620  / # export SHELL=3D/bin/sh. /lava-429027/en=
vironment
    2024-02-13T16:28:50.097328  =

    2024-02-13T16:28:50.198508  / # . /lava-429027/environment/lava-429027/=
bin/lava-test-runner /lava-429027/1
    2024-02-13T16:28:50.199504  =

    2024-02-13T16:28:50.204750  / # /lava-429027/bin/lava-test-runner /lava=
-429027/1
    2024-02-13T16:28:50.268873  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-13T16:28:50.302743  + cd /lava-429027/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65cb98e2e85fe23f80637037
        failing since 20 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-13T16:28:53.234850  /lava-429027/1/../bin/lava-test-case
    2024-02-13T16:28:53.260894  <8>[   27.284610] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
rk3399-roc-pc          | arm64 | lab-broonie | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/65cb996ddf02c3e822637070

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc4-78-gd3eb34=
47ef6be/arm64/defconfig/gcc-10/lab-broonie/baseline-rk3399-roc-pc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc4-78-gd3eb34=
47ef6be/arm64/defconfig/gcc-10/lab-broonie/baseline-rk3399-roc-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65cb996ddf02c3e822637=
071
        failing since 7 days (last pass: v6.8-rc2-29-gc24c55a0329d1, first =
fail: v6.8-rc3-31-g7cfffced6d0e) =

 =20

