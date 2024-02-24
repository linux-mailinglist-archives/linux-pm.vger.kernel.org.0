Return-Path: <linux-pm+bounces-4363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9965862285
	for <lists+linux-pm@lfdr.de>; Sat, 24 Feb 2024 04:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9632EB23D57
	for <lists+linux-pm@lfdr.de>; Sat, 24 Feb 2024 03:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D4AD54;
	Sat, 24 Feb 2024 03:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="VB8lnCx/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8C13AC8
	for <linux-pm@vger.kernel.org>; Sat, 24 Feb 2024 03:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708745900; cv=none; b=mwbshheTRjFMDVi7JKsOCw1EY0r0RzeQRnYjFb1vrVCNvSljr3WYDljvSo+6Cq+H6tBiK87flhFpok5NQdgnjr9nipWf+KExfzu09bGENYsRci3veytdC7lcU59z3CmHrAmcv5D6rnG564+VMTmBxP8jkiFamVs3ae0BQih82FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708745900; c=relaxed/simple;
	bh=Bwbn4/Csrl2KxIBXAqYvD/oLK92h4DcFxwezLFzl34I=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=in2WAMRIUluxBA1K+2G48OYV/zvAW7GMxxJa7zQ93OExMau9gT/ejzEHu1HJUPYGuhDbcpA4kBsGxn+8TjzfEiuvpew9oxFtLJWNJokUuQ/bVOgLEod57nrzZi/OEbNw1lnpvotZrjbtwll9DW6qsZ8f9hyypasHILsBqntIfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=VB8lnCx/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so1081315a12.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Feb 2024 19:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708745898; x=1709350698; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hnOh9BNYZJu70hGL0vfSBLR93lyr5gtqHtT1bAFCLWQ=;
        b=VB8lnCx/esebaeG2Gez+7kMc6WFnTF6hyjVU27S4TrwnBO8mSWvfp+u7kZRq44Y079
         AnxPDkyHpGl7jJ4yo7rZSokF9nT2tkINtCrrF/7z+eqH9DtyYC+Zq6lqXzav85Hd1Fxc
         KioO2tSifC5KtltkDhX1XToQZwupEORiA5TOLk0Wyj+mV3STh9lG17FGz3/qf0mw6QYk
         3YtW0UcvAB0pVZASh2NAzIj1bTpjylngurgoBU2q8MMkoC9XwurggMOlBQUtccD8AOyB
         vueaOGAVLNAOnKtazkbDD9jK6hQLVkEIatjb72isYRKW9Zv1V5jSmodsa4zOvxiJhyNs
         7LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708745898; x=1709350698;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnOh9BNYZJu70hGL0vfSBLR93lyr5gtqHtT1bAFCLWQ=;
        b=DrBoziTaXGuB/VSmqwJ5B1rnk+iOYn1leGJt+yS1alDXcy77bwbpJmJwElATm8BJdO
         uf3W6pMtKCU4H6Mj86CIqFcKKZIqM8U/1z85AUIzxfq+mHM+2DF9AzcjFnXvItmef95i
         9tX1n69IlTfVRxE8VH7GlR7GD7simY/x1VzaJv1OlkWyIPpAYkazwF2yHW3JdHA0Sg0W
         U6ZrF087BXsl/3B0BzfeIhZnlz3TivorEZt8jgmQoyxIjAuFtJllKd1ASWqhSfao+Was
         3Rpzg3/rgiF93etfnUO5vT7nk8NZ+vO3JyefLVp3M6JgrJy4OHO/hozu+0RLl82vyno8
         Fq9g==
X-Forwarded-Encrypted: i=1; AJvYcCVqgHRe+BWzc1m19LPwTUHnSJ0w04/bCHP7uefPz7zsjAswLjxX4rUc6v9DJp0YTS6cVjFZz0jgAKaId61fEvdWOvQLAtPf3po=
X-Gm-Message-State: AOJu0YxgM0Dem9/KvoDtbANtumuArLrRDGaz6XfAwjskXbL1DkMDSmEz
	87pn48E4wJEqdX7bhr3jZYvgn0w1fJZ2cc3CzhO9eLFOT5W3Zrq8SKgFe5+YrGCtwgsmxfZVI0r
	2jrY=
X-Google-Smtp-Source: AGHT+IHK0pSdOOtvtfdkiFJvwX/oP9Pdy+b0T9znBf4IoCDlbTT94jq0+Qs4Lp+qQ1yyzE+3ucY7sw==
X-Received: by 2002:a05:6a21:2d8e:b0:19e:bf18:61fe with SMTP id ty14-20020a056a212d8e00b0019ebf1861femr2605293pzb.11.1708745897912;
        Fri, 23 Feb 2024 19:38:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bt12-20020a17090af00c00b0029a73913ae8sm275509pjb.40.2024.02.23.19.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 19:38:17 -0800 (PST)
Message-ID: <65d964a9.170a0220.6f799.1066@mx.google.com>
Date: Fri, 23 Feb 2024 19:38:17 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc5-119-gbc3fe166fc9a9
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 50 runs,
 9 regressions (v6.8-rc5-119-gbc3fe166fc9a9)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 50 runs, 9 regressions (v6.8-rc5-119-gbc3fe166fc9a9)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig  =
        | regressions
-------------------------+-------+-----------------+----------+------------=
--------+------------
imx53-qsrb               | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig | 1          =

imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig  =
        | 1          =

kontron-kbox-a-230-ls    | arm64 | lab-kontron     | gcc-10   | defconfig  =
        | 5          =

kontron-sl28-var3-ads2   | arm64 | lab-kontron     | gcc-10   | defconfig  =
        | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc5=
-119-gbc3fe166fc9a9/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc5-119-gbc3fe166fc9a9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      bc3fe166fc9a98640b34558fe3cbe8a0d3173b48 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig  =
        | regressions
-------------------------+-------+-----------------+----------+------------=
--------+------------
imx53-qsrb               | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65d95a66ad81350e2b637064

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc5-119-gbc3fe=
166fc9a9/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc5-119-gbc3fe=
166fc9a9/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d95a66ad81350e2b637069
        failing since 392 days (last pass: v6.1-rc8-156-g0a9e32afe717, firs=
t fail: acpi-6.2-rc6-146-g628c61874ffd)

    2024-02-24T02:54:06.900600  + set +x
    2024-02-24T02:54:06.900739  [   13.515627] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1028253_1.5.2.3.1>
    2024-02-24T02:54:07.007237  / # #
    2024-02-24T02:54:07.108380  export SHELL=3D/bin/sh
    2024-02-24T02:54:07.108868  #
    2024-02-24T02:54:07.209680  / # export SHELL=3D/bin/sh. /lava-1028253/e=
nvironment
    2024-02-24T02:54:07.210114  =

    2024-02-24T02:54:07.310929  / # . /lava-1028253/environment/lava-102825=
3/bin/lava-test-runner /lava-1028253/1
    2024-02-24T02:54:07.311558  =

    2024-02-24T02:54:07.314905  / # /lava-1028253/bin/lava-test-runner /lav=
a-1028253/1 =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
        | regressions
-------------------------+-------+-----------------+----------+------------=
--------+------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65d9599da2861200e8637095

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc5-119-gbc3fe=
166fc9a9/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb=
15-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc5-119-gbc3fe=
166fc9a9/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb=
15-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65d9599da2861200e8637=
096
        new failure (last pass: v6.8-rc5-92-g4cb5c331c4dfd) =

 =



platform                 | arch  | lab             | compiler | defconfig  =
        | regressions
-------------------------+-------+-----------------+----------+------------=
--------+------------
kontron-kbox-a-230-ls    | arm64 | lab-kontron     | gcc-10   | defconfig  =
        | 5          =


  Details:     https://kernelci.org/test/plan/id/65d95982c80249c9b863702f

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc5-119-gbc3fe=
166fc9a9/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc5-119-gbc3fe=
166fc9a9/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d95982c80249c9b8637036
        failing since 30 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T02:50:22.274056  / # #
    2024-02-24T02:50:22.375942  export SHELL=3D/bin/sh
    2024-02-24T02:50:22.376516  #
    2024-02-24T02:50:22.477496  / # export SHELL=3D/bin/sh. /lava-434408/en=
vironment
    2024-02-24T02:50:22.478143  =

    2024-02-24T02:50:22.579192  / # . /lava-434408/environment/lava-434408/=
bin/lava-test-runner /lava-434408/1
    2024-02-24T02:50:22.580157  =

    2024-02-24T02:50:22.585257  / # /lava-434408/bin/lava-test-runner /lava=
-434408/1
    2024-02-24T02:50:22.642626  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-24T02:50:22.643168  + <8>[   20.760240] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 434408_1.5.2.4.5> =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65d95982c80249c9b863703a
        failing since 30 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T02:50:24.749755  /lava-434408/1/../bin/lava-test-case
    2024-02-24T02:50:24.750148  <8>[   22.868425] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2024-02-24T02:50:24.750397  /lava-434408/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
d95982c80249c9b863703c
        failing since 30 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T02:50:25.807667  /lava-434408/1/../bin/lava-test-case
    2024-02-24T02:50:25.808201  <8>[   23.907169] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65d95982c80249c9b8637041
        failing since 30 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T02:50:26.884312  /lava-434408/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65d95982c80249c9b8637042
        failing since 30 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T02:50:26.887431  <8>[   25.020612] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-02-24T02:50:27.942745  /lava-434408/1/../bin/lava-test-case
    2024-02-24T02:50:27.942871  <8>[   26.042022] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2024-02-24T02:50:27.942961  /lava-434408/1/../bin/lava-test-case
    2024-02-24T02:50:27.943035  <8>[   26.059657] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-driver-present RESULT=3Dpass>
    2024-02-24T02:50:27.943108  /lava-434408/1/../bin/lava-test-case   =

 =



platform                 | arch  | lab             | compiler | defconfig  =
        | regressions
-------------------------+-------+-----------------+----------+------------=
--------+------------
kontron-sl28-var3-ads2   | arm64 | lab-kontron     | gcc-10   | defconfig  =
        | 2          =


  Details:     https://kernelci.org/test/plan/id/65d95985a2861200e8637025

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc5-119-gbc3fe=
166fc9a9/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc5-119-gbc3fe=
166fc9a9/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d95985a2861200e863702c
        failing since 30 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T02:50:24.943967  / # #
    2024-02-24T02:50:25.045648  export SHELL=3D/bin/sh
    2024-02-24T02:50:25.046374  #
    2024-02-24T02:50:25.147575  / # export SHELL=3D/bin/sh. /lava-434409/en=
vironment
    2024-02-24T02:50:25.148231  =

    2024-02-24T02:50:25.249354  / # . /lava-434409/environment/lava-434409/=
bin/lava-test-runner /lava-434409/1
    2024-02-24T02:50:25.250538  =

    2024-02-24T02:50:25.258376  / # /lava-434409/bin/lava-test-runner /lava=
-434409/1
    2024-02-24T02:50:25.319638  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-24T02:50:25.320149  + <8>[   21.018184] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 434409_1.5.2.4.5> =

    ... (11 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65d95985a2861200e863703f
        failing since 30 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T02:50:26.697574  <8>[   22.418535] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-driver-present RESULT=3Dpass>
    2024-02-24T02:50:27.755557  /lava-434409/1/../bin/lava-test-case
    2024-02-24T02:50:27.755741  <8>[   23.439707] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-02-24T02:50:27.755840  /lava-434409/1/../bin/lava-test-case   =

 =20

