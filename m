Return-Path: <linux-pm+bounces-4022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA2858BCD
	for <lists+linux-pm@lfdr.de>; Sat, 17 Feb 2024 01:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2C11F2134B
	for <lists+linux-pm@lfdr.de>; Sat, 17 Feb 2024 00:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C18D149E16;
	Sat, 17 Feb 2024 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Hnhepnh9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32B1B945
	for <linux-pm@vger.kernel.org>; Sat, 17 Feb 2024 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129320; cv=none; b=QfHdRieAaevttL1hhQ7gcNOFWo04xJ6bibK7fugKBEgACcS4Naw6nR8ckcSyYt+xOk6yI8iActxd6hU+9ddqAW1EGQw4TTxhAm9Zx88n2ht5wuzDNWKdZuOzB+WHEsEyma9Tj3HCJx+K1/0tDyDLoQoR0moCEbIRcHEACFaAQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129320; c=relaxed/simple;
	bh=+mYe0wKHCCztaM5Nfp3WvNK+bWd52Oo/BvtPGKdy+iY=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=XqzcnZt9TnYs9T9CyaI2JCAS7mRtcLH1CN6Vax++yuEP23jDTsFaKKVNXeA0uMNW7VvhQ6pj3EFPaJP05Zqm9cH6j3aR3S8vFI08FjeeuiLIMugWZnPNuusZaYRKA1i23Gt7ctvrt0kF7QwUBFtHKrrorHF30UH1urn3Sajjllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Hnhepnh9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d91397bd22so22866565ad.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Feb 2024 16:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708129317; x=1708734117; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5CEIHUvFzvaea3/TlbyjG9IxjIZ5zaPOmUNcJjpkxM=;
        b=Hnhepnh90rERViclfQm+pnUE49X6Jo5wqOxmOXYC+ZXXZt/k7iAV7+wtVo5tTuNJQq
         A5dQqwtzd98yFtFeuI0XdVM9GeNgRH4ffRaeEFOReTTZh0Aj1CNYL+yKERYsR/eFam12
         mJ2Jgjw83uEDdy3hb1eZqZcVONHfFkDIZb4Mmrivc2aVucMIa1SKzcyOE/ZW3v0mThB5
         PFk1ZqOcxgsqWXS2NkRuNAiJ11Cd6WSIcNpYIciKaGugQzaNhYiN6pLafcqvoKyY+NpS
         aB9mv9xN7AyRscKSKigwVkISSjaOnslx84jif2F6q9w8i4l1dEMSZCSFNxYYq0nEWGSi
         6y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708129317; x=1708734117;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5CEIHUvFzvaea3/TlbyjG9IxjIZ5zaPOmUNcJjpkxM=;
        b=dc69AYInVT75WwveFLIRRIferNWmrtY4992TNCHTH1lvDaqKsPXPqodpL0q5UenB5I
         aGemLz1PS9ipGVNdMFyUiI7MaLl+85CsDruE5IzRXWzCb3XoN5SoagMEkv8MKR3AR2dH
         xtZV3nVAxd9a2Kbh3fYbBYxayTZPod9EcWg/K9asfoz7vfKh26t+h1+dkE/LzHB5xZe9
         KknkpBNG7i1HVV+FwcmoxowTgZninLZduism8g7149pjRolIqjXkcdOKvB9QH/IpdvU4
         4lReDiQJm3CE9zrbSQnO72km+ZQVvoWjuLY4nvhe5peWOQZoFvwk4GCIYXFWgmBtTeuw
         buiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgDj3BVAHYRR8Z9QJtMAhnCyEf/eSJ/HpV+Q75G/NP36xns799voyfNHkIS1HS/0BDbSaWwisNWc99lxnkdNdiY+zgu/t6+PE=
X-Gm-Message-State: AOJu0YzP+qgs41y7OnBb/bPrwxDJXXET++iuDa5MOGUiiQGXCWk5yybb
	CcmeQk3kbHAy7hnfrzjUl9GKNpwhVtwqex/YfmYbWdRpJGA9R8TA6XShsv2bU4g=
X-Google-Smtp-Source: AGHT+IE50Nvgsq+dBE4DDsf/v4OSNLy/fC3QsQ7a1vGnTC5Zb02Xl33Ka2NnGnnTYvnJoZUYdXE3EA==
X-Received: by 2002:a17:903:22cb:b0:1db:bfea:3657 with SMTP id y11-20020a17090322cb00b001dbbfea3657mr1133081plg.22.1708129317475;
        Fri, 16 Feb 2024 16:21:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mi11-20020a170902fccb00b001db608107ecsm411498plb.167.2024.02.16.16.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:21:56 -0800 (PST)
Message-ID: <65cffc24.170a0220.66083.3106@mx.google.com>
Date: Fri, 16 Feb 2024 16:21:56 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc4-91-g833dbcc88dd9f
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 51 runs,
 7 regressions (v6.8-rc4-91-g833dbcc88dd9f)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 51 runs, 7 regressions (v6.8-rc4-91-g833dbcc88dd9f)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc4=
-91-g833dbcc88dd9f/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc4-91-g833dbcc88dd9f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      833dbcc88dd9f7c8d3a82200a75cb39f1e35b1ce =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65cff1f3d83a58321663702e

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc4-91-g833dbc=
c88dd9f/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc4-91-g833dbc=
c88dd9f/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cff1f3d83a583216637031
        failing since 23 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-16T23:37:54.414202  / # #
    2024-02-16T23:37:54.516205  export SHELL=3D/bin/sh
    2024-02-16T23:37:54.516925  #
    2024-02-16T23:37:54.618455  / # export SHELL=3D/bin/sh. /lava-431353/en=
vironment
    2024-02-16T23:37:54.619171  =

    2024-02-16T23:37:54.720454  / # . /lava-431353/environment/lava-431353/=
bin/lava-test-runner /lava-431353/1
    2024-02-16T23:37:54.721666  =

    2024-02-16T23:37:54.762373  / # /lava-431353/bin/lava-test-runner /lava=
-431353/1
    2024-02-16T23:37:54.790233  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-16T23:37:54.824215  + cd /lava-431353/1/tests/1_bootrr =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65cff1f3d83a583216637035
        failing since 23 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-16T23:37:57.041982  /lava-431353/1/../bin/lava-test-case
    2024-02-16T23:37:57.069150  <8>[   26.433801] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
cff1f3d83a583216637037
        failing since 23 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-16T23:37:58.130309  /lava-431353/1/../bin/lava-test-case
    2024-02-16T23:37:58.157976  <8>[   27.522928] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65cff1f3d83a58321663703c
        failing since 23 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-16T23:37:59.391684  /lava-431353/1/../bin/lava-test-case
    2024-02-16T23:37:59.419858  <8>[   28.783772] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65cff1f3d83a58321663703d
        failing since 23 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-16T23:38:00.443100  /lava-431353/1/../bin/lava-test-case
    2024-02-16T23:38:00.470239  <8>[   29.834320] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65cff1f11229bbf54e637027

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc4-91-g833dbc=
c88dd9f/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc4-91-g833dbc=
c88dd9f/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cff1f11229bbf54e63702a
        failing since 23 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-16T23:38:03.834608  / # #
    2024-02-16T23:38:03.935625  export SHELL=3D/bin/sh
    2024-02-16T23:38:03.936325  #
    2024-02-16T23:38:04.037777  / # export SHELL=3D/bin/sh. /lava-431351/en=
vironment
    2024-02-16T23:38:04.038531  =

    2024-02-16T23:38:04.139842  / # . /lava-431351/environment/lava-431351/=
bin/lava-test-runner /lava-431351/1
    2024-02-16T23:38:04.141000  =

    2024-02-16T23:38:04.149618  / # /lava-431351/bin/lava-test-runner /lava=
-431351/1
    2024-02-16T23:38:04.245633  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-16T23:38:04.246108  + cd /lava-431351/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65cff1f11229bbf54e63703d
        failing since 23 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-16T23:38:07.177015  /lava-431351/1/../bin/lava-test-case
    2024-02-16T23:38:07.207138  <8>[   27.275477] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =20

