Return-Path: <linux-pm+bounces-4894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5C487B143
	for <lists+linux-pm@lfdr.de>; Wed, 13 Mar 2024 20:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088C11F27B01
	for <lists+linux-pm@lfdr.de>; Wed, 13 Mar 2024 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E99E61689;
	Wed, 13 Mar 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="mGatjuTE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61561688
	for <linux-pm@vger.kernel.org>; Wed, 13 Mar 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354904; cv=none; b=G/gHSvp+fTOaknsEMZSL6JS+aqNO88ECj1bWtCz5fkmywUxhO5BFXXLeM6EHoWACQ0hd9y7aX2nb34tqCr6U86FtA65V43hk4akl64rk+iFwVHN1GC7zBoVA5FRD3n4iT7n7LXUo9a3S5Ade6o6AvNG5Z6Eu6ZVT7v6PSS19U7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354904; c=relaxed/simple;
	bh=SmXPwENReONI/Tb0XEFm+68mcfRY16tCwLogIhCoHlk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=j6ytEVd4L2STyUVr7xOfWYUg7jpElGIXSmQzMu8U/etQ2qakF3eVRtfCaYnyGJs/OSPWoUMTZ7a7izvMYfIb/iSiUaNEoZATH+uuLAdVwj6xF/LSB8xFpGEz3tFH7c855OT0xUvF47JmBZw5caFO7oMPhSGF2vyLmFkGerbOOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=mGatjuTE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dda51bb52eso896915ad.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Mar 2024 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1710354902; x=1710959702; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RgVSN18z4sE5FWzAZLACE319viTtC2c1i9MB9bHY0vM=;
        b=mGatjuTE3SEXeifLo9PNIinyZj1vB3T3Vrhpiwr9Pw1EGXp5zvrIlG6LE8s/+Q5A9M
         YIfBtd+/5sFrcSz4qVLotQ+SIw0tSvn33W/V33VeMtLCFRTnAMxhjdVDy/rJ7gouk/yU
         TYxaKjkrELibGSDrh4KsHvTT63D2YMHpa+yQxyIz1BRSW5O2mxX9XwnDFSRIzuTHBq/t
         D7Rj2eX057quVnojWksn6y3HJwgFVkJ6P47XXFC14TLHGP/lhB++XTVZdxsIk+nXjkv8
         ue68hEifM7xQEC+rF2GdqSZN/klrJQm7c+Fpnz6IFeo0+QTsHvN9CzqlWAcvEQMR1UUn
         eHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354902; x=1710959702;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgVSN18z4sE5FWzAZLACE319viTtC2c1i9MB9bHY0vM=;
        b=EtpMIAM/BvcUh+SP07wV1R+0+uuDkNIdDJhQ8IgG2MmRX5mEEfqLhcmAB1R32LCoE+
         3Si6F8vB80KzOI78aV9n97dOtIAQgPNJOGtCAzbo2yklfgj1/cNRlm9Zrfsh5/CA0q2I
         xV1RhJ4udnbhCcWIxWo9IAnX5NPI43JwZSeQ1UcyNdImpIGPjcZgh/Hs6kizdxdX/frB
         s20DoSY7PRldgKuP1Qx/wRlGmidbTjpxGwPTMtH0AJn7iDSASh/N5jVJzCBiEY9P8cR6
         mWf5agXpFSoe3tXjEEB8fxsA8LuM/IqkwZykq25hnXzrams0AbFpgLFqVj9SyqMApm5C
         SQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUlIYRqxUxSpBUca9YttRYavDwOW2OQ7AduytxVz8FMJPapHTCq+Tay0OrzyiTxPPy/R4YYzA7WMj1vU1jMmyblYZ2bMYrL98U=
X-Gm-Message-State: AOJu0YyBCGVhxbUfeT/1Fr5l1lkIkmmfI6XHunujKVBaaaU2xEBVA/M4
	3w948lJZvXvl0fEZ3ziaghLm3IvxAJ/R7stEmVVb1fdyEfxifi+UhTJpqco91wU=
X-Google-Smtp-Source: AGHT+IHKf9aD+jyASr4eGVC9bVP3VDJ1sUiJ5MiS8bjXPf0qz5PzG/tNsi7uRND0RWQyRHDhauzHjQ==
X-Received: by 2002:a17:902:7084:b0:1dd:7de5:88fd with SMTP id z4-20020a170902708400b001dd7de588fdmr4771207plk.66.1710354902103;
        Wed, 13 Mar 2024 11:35:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k15-20020a170902c40f00b001dd59b54f9fsm1991192plk.136.2024.03.13.11.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:35:01 -0700 (PDT)
Message-ID: <65f1f1d5.170a0220.7e676.76ef@mx.google.com>
Date: Wed, 13 Mar 2024 11:35:01 -0700 (PDT)
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
X-Kernelci-Kernel: v6.8-rc7-179-g7a90d40a48f4
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 39 runs,
 8 regressions (v6.8-rc7-179-g7a90d40a48f4)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 39 runs, 8 regressions (v6.8-rc7-179-g7a90d40a48f4)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =

kontron-kbox-a-230-ls    | arm64 | lab-kontron     | gcc-10   | defconfig |=
 5          =

kontron-sl28-var3-ads2   | arm64 | lab-kontron     | gcc-10   | defconfig |=
 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc7=
-179-g7a90d40a48f4/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc7-179-g7a90d40a48f4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7a90d40a48f41b40f1cc555d4f8f58a659cde09f =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65f1e51d8d003504074c4348

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc7-179-g7a90d=
40a48f4/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc7-179-g7a90d=
40a48f4/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65f1e51d8d003504074c4=
349
        new failure (last pass: v6.8-rc7-160-g268314880cd43) =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
kontron-kbox-a-230-ls    | arm64 | lab-kontron     | gcc-10   | defconfig |=
 5          =


  Details:     https://kernelci.org/test/plan/id/65f1e6055232e842614c4347

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc7-179-g7a90d=
40a48f4/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc7-179-g7a90d=
40a48f4/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65f1e6055232e842614c434e
        failing since 49 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-13T17:44:10.335442  / # #
    2024-03-13T17:44:10.437803  export SHELL=3D/bin/sh
    2024-03-13T17:44:10.438618  #
    2024-03-13T17:44:10.540142  / # export SHELL=3D/bin/sh. /lava-442583/en=
vironment
    2024-03-13T17:44:10.540904  =

    2024-03-13T17:44:10.642325  / # . /lava-442583/environment/lava-442583/=
bin/lava-test-runner /lava-442583/1
    2024-03-13T17:44:10.643390  =

    2024-03-13T17:44:10.663595  / # /lava-442583/bin/lava-test-runner /lava=
-442583/1
    2024-03-13T17:44:10.706284  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-13T17:44:10.706722  + <8>[   20.778639] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 442583_1.5.2.4.5> =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65f1e6055232e842614c4352
        failing since 49 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-13T17:44:12.812090  /lava-442583/1/../bin/lava-test-case
    2024-03-13T17:44:12.812542  <8>[   22.885754] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2024-03-13T17:44:12.812982  /lava-442583/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
f1e6055232e842614c4354
        failing since 49 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-13T17:44:13.870027  /lava-442583/1/../bin/lava-test-case
    2024-03-13T17:44:13.870687  <8>[   23.924476] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2024-03-13T17:44:13.870945  /lava-442583/1/../bin/lava-test-case
    2024-03-13T17:44:13.871222  <8>[   23.941555] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2024-03-13T17:44:13.871508  /lava-442583/1/../bin/lava-test-case
    2024-03-13T17:44:13.871774  <8>[   23.960415] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2024-03-13T17:44:13.872039  /lava-442583/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65f1e6055232e842614c4359
        failing since 49 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-13T17:44:14.948524  /lava-442583/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65f1e6055232e842614c435a
        failing since 49 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-13T17:44:14.951647  <8>[   25.038981] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-03-13T17:44:16.011317  /lava-442583/1/../bin/lava-test-case
    2024-03-13T17:44:16.011759  <8>[   26.060635] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2024-03-13T17:44:16.012092  /lava-442583/1/../bin/lava-test-case
    2024-03-13T17:44:16.012370  <8>[   26.078298] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-driver-present RESULT=3Dpass>
    2024-03-13T17:44:16.012644  /lava-442583/1/../bin/lava-test-case
    2024-03-13T17:44:16.012909  <8>[   26.098205] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-probed RESULT=3Dpass>
    2024-03-13T17:44:16.013168  /lava-442583/1/../bin/lava-test-case   =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
kontron-sl28-var3-ads2   | arm64 | lab-kontron     | gcc-10   | defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/65f1e5118d003504074c42da

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc7-179-g7a90d=
40a48f4/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc7-179-g7a90d=
40a48f4/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65f1e5118d003504074c42e1
        failing since 49 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-13T17:40:10.353724  / # #
    2024-03-13T17:40:10.456018  export SHELL=3D/bin/sh
    2024-03-13T17:40:10.456768  #
    2024-03-13T17:40:10.558133  / # export SHELL=3D/bin/sh. /lava-442582/en=
vironment
    2024-03-13T17:40:10.558842  =

    2024-03-13T17:40:10.660175  / # . /lava-442582/environment/lava-442582/=
bin/lava-test-runner /lava-442582/1
    2024-03-13T17:40:10.661333  =

    2024-03-13T17:40:10.681386  / # /lava-442582/bin/lava-test-runner /lava=
-442582/1
    2024-03-13T17:40:10.733901  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-13T17:40:10.734294  + <8>[   20.966362] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 442582_1.5.2.4.5> =

    ... (11 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65f1e5118d003504074c42f4
        failing since 49 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-13T17:40:13.163094  /lava-442582/1/../bin/lava-test-case
    2024-03-13T17:40:13.163549  <8>[   23.387501] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-03-13T17:40:13.163847  /lava-442582/1/../bin/lava-test-case   =

 =20

