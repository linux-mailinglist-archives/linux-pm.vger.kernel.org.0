Return-Path: <linux-pm+bounces-4776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB818875B25
	for <lists+linux-pm@lfdr.de>; Fri,  8 Mar 2024 00:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0691F22104
	for <lists+linux-pm@lfdr.de>; Thu,  7 Mar 2024 23:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBD03FE31;
	Thu,  7 Mar 2024 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KaXXnNX8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92E3309C
	for <linux-pm@vger.kernel.org>; Thu,  7 Mar 2024 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854389; cv=none; b=eBsGuHltBxIU+JuZozCrSWV/0TolL75AbwUPK9XlCMXVVsPrCTjWG6v6vC0S790pkpU1LwJU3YXl7EYO+fvQIISBi2SCDbH4VVco1VjMppa3Y4BvaU4HXkhWmQhBC5DeOU4Uzxc7o/NN7E18hUVSfnJgQ3ImWsLr+aj8zeQjUGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854389; c=relaxed/simple;
	bh=CztAUeJFuSV8ZTc3yUqzvVLsO9pl7qAH90cAQgIrOG0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Ze+Ba7jpqhvojc0fqQYNVDhLDtHKIQ8aesx+8MSOPjbaF8vkvhNsRI85+0DsE/CQxTs+nc01mD0Td7xSnfHEoiMpKKOJ1kxReiIHMcw7wayv36bTHRDJ7vq2PATKXCthYIHBaj/Te3Wf6rG/wfhaohcYW2krxY8fJV92bnp//C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=KaXXnNX8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so11227665ad.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Mar 2024 15:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709854386; x=1710459186; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mBAbO4Ub0OvPMTegbR4TjPfoozEEq9HogcwBzxu0Neg=;
        b=KaXXnNX8s1qdhxCUSxHsSVI9DaCz7VsfKLufFfqmngVZRXzGTOHLbMKfU56IWqVc+o
         zwc6t5iG1HfePaAGy8rKB9NHywD+mFqIc6k23IfbAJVIHKnXJbLYN2HLuR65Q7Eonaqv
         +lzeILF/N4mbAz851c+PohlXG3fTo5Z3H8gRY9L6p3HiHn6uwP7fKNcoyhKqH74Vl0Dr
         uqnB1zU8vlDtChkMvApYbi13apl9gVzZYexXpwaNunzqsFYRStgL3OAZ9PfMPtH9Q9wj
         z55owcDteJtDLhxjL9hVK/cElUnI6WYyaGYwSwDZfhatRBajgKIAQVWv9coJgpAOyRsu
         F2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709854386; x=1710459186;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBAbO4Ub0OvPMTegbR4TjPfoozEEq9HogcwBzxu0Neg=;
        b=Fdxa8g1mcREcxDJOx5Q0hccMVIXacOrXlLkoved9AZfs3TXlqxh7py4N6ocEC8UXa2
         hhXwVvJEhgwAj3Q0GZG11l/S1GIHl4TzL6aQczvdw15jw2JrDOIurHxLy0RniLClFAfn
         /oFf3hIJeiK/Xl+iMs5Kcm3LDs+edCnVCGfPbnt7Rb7ib1Cprr7UHvvPQ9IGF3Rl6SGK
         fXQAtVWVkPLC3HRvo8+b/22wfih+PMMzmkcl6TFjP5wDFyVpESAPycciVyP6nVdOwt6G
         Czme03Fdpmg2c0qY0uDyJrsJ1Kv9SgUrgWHVOkAyQ7LxjVNxS6pwSW4Nw2AuAVceZRH4
         UQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/fxbtrwrA7FyuEt1FcjUf+eqyo+ZRVhKZilby418cdLdc8lIvET+yqLw/0sddyEAnMKBH4NVSbowSaQNunvSiGyMlfIubufk=
X-Gm-Message-State: AOJu0Yzohosj75/mrtSWAic8eaxjmI4TygocyonCy+KZvidId1MgqVSU
	z1LYq7Z2eJDEjAXuRCK+uMwK76Prk3AbFd8L3oQ++VliKfMjJw6S2+DJnyW4KoHf4BC9fKRCCuB
	mUI0=
X-Google-Smtp-Source: AGHT+IGOwniNse59eMaHcv0HO1NdtCyPKlOZbupQ9L8Jms+5VV0ud2IIOhZ8WKT/bykmTWLKBKUYBA==
X-Received: by 2002:a17:902:c402:b0:1db:28bd:2949 with SMTP id k2-20020a170902c40200b001db28bd2949mr11133257plk.0.1709854386568;
        Thu, 07 Mar 2024 15:33:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001dcc28544dbsm15184113pls.78.2024.03.07.15.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:33:06 -0800 (PST)
Message-ID: <65ea4eb2.170a0220.fb90e.a142@mx.google.com>
Date: Thu, 07 Mar 2024 15:33:06 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc7-160-g268314880cd43
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 48 runs,
 7 regressions (v6.8-rc7-160-g268314880cd43)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 48 runs, 7 regressions (v6.8-rc7-160-g268314880cd43)

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
-160-g268314880cd43/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc7-160-g268314880cd43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      268314880cd43b6b33f593977a635d0a111b899e =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65ea446f6cf207890e4c42fe

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc7-160-g26831=
4880cd43/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc7-160-g26831=
4880cd43/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ea446f6cf207890e4c4305
        failing since 43 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-07T22:49:01.777671  / # #
    2024-03-07T22:49:01.878395  export SHELL=3D/bin/sh
    2024-03-07T22:49:01.878661  #
    2024-03-07T22:49:01.979145  / # export SHELL=3D/bin/sh. /lava-440164/en=
vironment
    2024-03-07T22:49:01.979433  =

    2024-03-07T22:49:02.079965  / # . /lava-440164/environment/lava-440164/=
bin/lava-test-runner /lava-440164/1
    2024-03-07T22:49:02.080291  =

    2024-03-07T22:49:02.087754  / # /lava-440164/bin/lava-test-runner /lava=
-440164/1
    2024-03-07T22:49:02.144335  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-07T22:49:02.144803  + <8>[   20.608894] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 440164_1.5.2.4.5> =

    ... (16 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65ea446f6cf207890e4c4309
        failing since 43 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-07T22:49:04.248431  /lava-440164/1/../bin/lava-test-case
    2024-03-07T22:49:04.248548  <8>[   22.715278] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2024-03-07T22:49:04.248615  /lava-440164/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
ea446f6cf207890e4c430b
        failing since 43 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-07T22:49:05.309014  /lava-440164/1/../bin/lava-test-case
    2024-03-07T22:49:05.309224  <8>[   23.753759] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2024-03-07T22:49:05.309706  /lava-440164/1/../bin/lava-test-case
    2024-03-07T22:49:05.310078  <8>[   23.770903] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2024-03-07T22:49:05.310358  /lava-440164/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65ea446f6cf207890e4c4310
        failing since 43 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-07T22:49:06.384858  /lava-440164/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65ea446f6cf207890e4c4311
        failing since 43 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-07T22:49:06.387973  <8>[   24.868578] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-03-07T22:49:07.447770  /lava-440164/1/../bin/lava-test-case
    2024-03-07T22:49:07.448260  <8>[   25.890299] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2024-03-07T22:49:07.448625  /lava-440164/1/../bin/lava-test-case   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65ea4471c9f7a499644c42da

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc7-160-g26831=
4880cd43/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc7-160-g26831=
4880cd43/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ea4471c9f7a499644c42e1
        failing since 43 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-07T22:49:05.213239  / # #
    2024-03-07T22:49:05.315228  export SHELL=3D/bin/sh
    2024-03-07T22:49:05.315755  #
    2024-03-07T22:49:05.416879  / # export SHELL=3D/bin/sh. /lava-440167/en=
vironment
    2024-03-07T22:49:05.417976  =

    2024-03-07T22:49:05.519157  / # . /lava-440167/environment/lava-440167/=
bin/lava-test-runner /lava-440167/1
    2024-03-07T22:49:05.520109  =

    2024-03-07T22:49:05.527468  / # /lava-440167/bin/lava-test-runner /lava=
-440167/1
    2024-03-07T22:49:05.588575  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-07T22:49:05.589003  + <8>[   20.960052] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 440167_1.5.2.4.5> =

    ... (12 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65ea4471c9f7a499644c42f4
        failing since 43 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-07T22:49:08.029519  /lava-440167/1/../bin/lava-test-case
    2024-03-07T22:49:08.030042  <8>[   23.384311] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-03-07T22:49:08.030340  /lava-440167/1/../bin/lava-test-case   =

 =20

