Return-Path: <linux-pm+bounces-4145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2907285C1E0
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 17:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9280FB22E6D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35C76905;
	Tue, 20 Feb 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="eZ3gQ3Pu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD2762EC
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448318; cv=none; b=b5ceR7HDcvMpAZSWBDGnFofQdH/5ya5Eobt8C3Gxcib166EhgNltb4sqIxkk1lJAuQzw1p/Oizkp1bd/wZoyxvsPWrwf29gxDFQhFwAvGOmGKhe70DSvc+5iQaCkrBBVWStSlQdlrX+EPZS+MnqbLn8DBizw6Rzf+PQoJoX3O9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448318; c=relaxed/simple;
	bh=+JJ/NL/rw/CahkKefht0h6UG4ipH0Eibxtqd17H/i9s=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=jhFs8Y3WUvgZ4Sh9YnQH85SAMmeyWusAAn0YAgO+8ZqgD/R32HHcmZiSyTzSpcZFGrdiDwwTwXrXTU3V2IqqC/wp8yPund3u34sov/I2h7beBz5+z+0n0ovEWzqL9DNNs/pCu1TlHqxCRbc5jV5wLwLX25vw4019RJpW6saLCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=eZ3gQ3Pu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2997a9f4d61so1947965a91.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 08:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708448315; x=1709053115; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Md2OgEW622p4At4+eJr2hAm+rofnTOlJgNkOHokftk0=;
        b=eZ3gQ3Pu8M9K1Ikr0iHtotfglZrKME+bUJPTG0sIv4c4FjlKdp9D5cmy1q0Y0ClPJP
         5dH5BGvSS/GXSVi6ej6k2iLUOmQeJ3MV+AVK93+LnIFvKIl8Q3pEAdI9/SYxSvv2Sduv
         umEiHAz5/XZP+KrKpkf22fbgaKpCeMcf8/g3QYTakd/9PkI0foUREB4c6NxiuT0KxWzA
         IzP/twTg6Ju1zScWLNz7l6gVyc4BI75R0qi90Mh8dYlIAFBc//MxdjcblM86XzMgYBYz
         sUVtWHpVsou0Uhr/OlA3NBx/9U7K7Fq6KGvIrDlKLJLlrWv8KOjX5dcE87gxm3fbSd/Q
         8ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708448315; x=1709053115;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md2OgEW622p4At4+eJr2hAm+rofnTOlJgNkOHokftk0=;
        b=eSbRiul6MjBPZX4qryycP1HaUoG6GuB3o1erWOd42ttChdyYkdNHj8xwQ0ZlAPSCrV
         Ip/m0d25yfacKOikPupd5Kh0UQJn+ng9g9RH/JysORZsxvkhfUOqjK2SXSlSIDUVsus3
         zBQcRN1N0ohx5sL0OwxkBjhPM2i3oMQd4CL36QcxzuqlVdtmH5ZWNvlfJXJ+YZXopDA4
         eCrc7xz+kmU473yo5Orz96wqC6pJ+86s/QwdeahwdvVJxXqRBUQib8497TJZ5KjnlWAv
         6USIfrSo5stJDEGMaA+Jk0UIUT5riA2F8hhHK72OgM34rjQ6KQcklAmk0XA+G41kLI/R
         c1sg==
X-Forwarded-Encrypted: i=1; AJvYcCWEc0RxRgwf+sudFQBz6klbbCyX7vXi7eDGwmn+5y5KKbod4OZ2RWHv6g9KrWtyJW2pUqyJMtZMCBhYujtkrLeiL8Ar4GkGw80=
X-Gm-Message-State: AOJu0Yz2z1iJyX7DtsnY4/KHUZd1V0t613z/cY+VkPb+ofpTAZTmkzTq
	PQyPRTPL8i1wt/MrYoKl4g1VyHmpAE6wynKf4oop+vY3YDAIDIp6MuZ5cEiaOvA=
X-Google-Smtp-Source: AGHT+IH5dLTiKCXjMw+iz/ekFfGbOa10wVN4HgD3fDsQE9TtQTKL4fhj8qtqIoaSJJay6S8fEBhhhQ==
X-Received: by 2002:a17:90a:d995:b0:299:e591:6a5a with SMTP id d21-20020a17090ad99500b00299e5916a5amr1777858pjv.3.1708448315496;
        Tue, 20 Feb 2024 08:58:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090ab38c00b00298e11b600dsm7657230pjr.27.2024.02.20.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 08:58:34 -0800 (PST)
Message-ID: <65d4da3a.170a0220.9a953.72cd@mx.google.com>
Date: Tue, 20 Feb 2024 08:58:34 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc5-92-g4cb5c331c4dfd
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 52 runs,
 8 regressions (v6.8-rc5-92-g4cb5c331c4dfd)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 52 runs, 8 regressions (v6.8-rc5-92-g4cb5c331c4dfd)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc5=
-92-g4cb5c331c4dfd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc5-92-g4cb5c331c4dfd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4cb5c331c4dfd553077664717ed061ecc8d2a0f7 =



Test Regressions
---------------- =



platform               | arch  | lab             | compiler | defconfig    =
      | regressions
-----------------------+-------+-----------------+----------+--------------=
------+------------
imx53-qsrb             | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65d4cf959c94729642637042

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc5-92-g4cb5c3=
31c4dfd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc5-92-g4cb5c3=
31c4dfd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d4cf959c9472964263704b
        failing since 388 days (last pass: v6.1-rc8-156-g0a9e32afe717, firs=
t fail: acpi-6.2-rc6-146-g628c61874ffd)

    2024-02-20T16:12:53.621888  + set +x
    2024-02-20T16:12:53.622044  [   13.480105] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1026113_1.5.2.3.1>
    2024-02-20T16:12:53.729762  / # #
    2024-02-20T16:12:53.831177  export SHELL=3D/bin/sh
    2024-02-20T16:12:53.831665  #
    2024-02-20T16:12:53.932475  / # export SHELL=3D/bin/sh. /lava-1026113/e=
nvironment
    2024-02-20T16:12:53.933043  =

    2024-02-20T16:12:54.033928  / # . /lava-1026113/environment/lava-102611=
3/bin/lava-test-runner /lava-1026113/1
    2024-02-20T16:12:54.034678  =

    2024-02-20T16:12:54.038208  / # /lava-1026113/bin/lava-test-runner /lav=
a-1026113/1 =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
      | regressions
-----------------------+-------+-----------------+----------+--------------=
------+------------
kontron-kbox-a-230-ls  | arm64 | lab-kontron     | gcc-10   | defconfig    =
      | 5          =


  Details:     https://kernelci.org/test/plan/id/65d4d016626b461c5f637013

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc5-92-g4cb5c3=
31c4dfd/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc5-92-g4cb5c3=
31c4dfd/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d4d016626b461c5f63701a
        failing since 27 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-20T16:14:47.166902  <8>[   20.171732] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 432717_1.5.2.4.1>
    2024-02-20T16:14:47.271885  / # #
    2024-02-20T16:14:47.373924  export SHELL=3D/bin/sh
    2024-02-20T16:14:47.374695  #
    2024-02-20T16:14:47.476027  / # export SHELL=3D/bin/sh. /lava-432717/en=
vironment
    2024-02-20T16:14:47.476773  =

    2024-02-20T16:14:47.578050  / # . /lava-432717/environment/lava-432717/=
bin/lava-test-runner /lava-432717/1
    2024-02-20T16:14:47.579312  =

    2024-02-20T16:14:47.598533  / # /lava-432717/bin/lava-test-runner /lava=
-432717/1
    2024-02-20T16:14:47.646283  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (15 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65d4d016626b461c5f63701e
        failing since 27 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-20T16:14:49.716810  /lava-432717/1/../bin/lava-test-case
    2024-02-20T16:14:49.751614  <8>[   22.747851] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2024-02-20T16:14:49.751755  /lava-432717/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
d4d016626b461c5f637020
        failing since 27 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-20T16:14:50.811930  /lava-432717/1/../bin/lava-test-case
    2024-02-20T16:14:50.812160  <8>[   23.786591] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65d4d016626b461c5f637025
        failing since 27 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-20T16:14:51.891640  /lava-432717/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65d4d016626b461c5f637026
        failing since 27 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-20T16:14:51.894885  <8>[   24.902987] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-02-20T16:14:52.954022  /lava-432717/1/../bin/lava-test-case   =

 =



platform               | arch  | lab             | compiler | defconfig    =
      | regressions
-----------------------+-------+-----------------+----------+--------------=
------+------------
kontron-sl28-var3-ads2 | arm64 | lab-kontron     | gcc-10   | defconfig    =
      | 2          =


  Details:     https://kernelci.org/test/plan/id/65d4d02abf2bc9b03b63705b

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc5-92-g4cb5c3=
31c4dfd/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc5-92-g4cb5c3=
31c4dfd/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d4d02abf2bc9b03b637062
        failing since 27 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-20T16:15:20.547031  / # #
    2024-02-20T16:15:20.647970  export SHELL=3D/bin/sh
    2024-02-20T16:15:20.648615  #
    2024-02-20T16:15:20.749622  / # export SHELL=3D/bin/sh. /lava-432720/en=
vironment
    2024-02-20T16:15:20.749995  =

    2024-02-20T16:15:20.851136  / # . /lava-432720/environment/lava-432720/=
bin/lava-test-runner /lava-432720/1
    2024-02-20T16:15:20.852068  =

    2024-02-20T16:15:20.894113  / # /lava-432720/bin/lava-test-runner /lava=
-432720/1
    2024-02-20T16:15:20.924878  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-20T16:15:20.925272  + <8>[   20.882521] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 432720_1.5.2.4.5> =

    ... (11 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65d4d02abf2bc9b03b637075
        failing since 27 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-20T16:15:23.358765  /lava-432720/1/../bin/lava-test-case
    2024-02-20T16:15:23.359411  <8>[   23.304521] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-02-20T16:15:23.359671  /lava-432720/1/../bin/lava-test-case
    2024-02-20T16:15:23.359895  <8>[   23.322081] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-driver-present RESULT=3Dpass>
    2024-02-20T16:15:23.360109  /lava-432720/1/../bin/lava-test-case
    2024-02-20T16:15:23.360309  <8>[   23.341453] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-probed RESULT=3Dpass>
    2024-02-20T16:15:23.360509  /lava-432720/1/../bin/lava-test-case   =

 =20

