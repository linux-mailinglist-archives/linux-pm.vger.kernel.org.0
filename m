Return-Path: <linux-pm+bounces-3299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18BC8484E9
	for <lists+linux-pm@lfdr.de>; Sat,  3 Feb 2024 10:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2F41F21AA2
	for <lists+linux-pm@lfdr.de>; Sat,  3 Feb 2024 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773394EB4A;
	Sat,  3 Feb 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="082mSCN3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465C5C918
	for <linux-pm@vger.kernel.org>; Sat,  3 Feb 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706951769; cv=none; b=OIJL/Zcd/tq7NfDgsYloC/naqPZGUJLSW0RuXY/0M7EYeevu4r72wdqjOwfhjLjRyCmFsfeKWID4MHP28xxArGl8KT+LQ/kMyldhQNEHB/BDf6lTl9yL2P1LW7jZGmB/Wys6VPwbAvb0uKTH4ixnfSutN67B1TQKcKtlCoclWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706951769; c=relaxed/simple;
	bh=2s5EtbtvzAECNpF3+0WBRXmGIwE1rc5AQQwGc58qq4M=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ukidfkb97ZEifR+xhC1olti5WVIBlkJed3BgFepXDVCFKvFLaevRyx6lxRWauVHFAxgeag2QlF5owIVw12VDfhVHkqJ5cmTGm7k/MrUlHzGHrBNpo1jaQ9F6hTkF8uF/rZ/XUlv2ui4EImxokM/2zbRb/2yS92FSucDiLdoORwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=082mSCN3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2137146a12.2
        for <linux-pm@vger.kernel.org>; Sat, 03 Feb 2024 01:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706951767; x=1707556567; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iqZ4HMiLRIBl5Zoy/AvD7CBk/Dh+HngdoQufeXF/AqE=;
        b=082mSCN3/5lJIU1YdxgLvRfpJJIuzmAcKcJDhrbCZluYiX4SvMGAWk/OV6Xy+oENWP
         iMfggoRFESokUgxjKmFyLkMrQ9J9h8+aI3iPOy5lz2J22kSfuWIF92/GkyOfXBJ9LmvA
         O44TqfyNtP7Ws/S3OeEEhUXdKsKMpvOPcR+HRGhZoslaiKWBAMX6Y6jJ7bHxd1uekHRX
         XZTAAcQrp1rvYiRBHktr1I6EfAATH8A+qZjFOOuAuRaktHyPvfJ4LFXk5ZtyG90o1mTi
         K8m1ZHtoeaYY91wXimdivl6A0INFlMJU4iyPtjG1VerSSkP1XDLVfjjMMtjAs/S0L2X0
         +Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706951767; x=1707556567;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqZ4HMiLRIBl5Zoy/AvD7CBk/Dh+HngdoQufeXF/AqE=;
        b=sNbHxRr0T79qnDedVtWLqpWG8x9U5fFUy8LyasDXT16y9rldgnxxxLREbsPulJOa+6
         AsEHm94Ir9a8DZk0GMEI7u2SiyyRvzeF8WSZIWVEMKrPRzpF+0UyfDpmliXiuYbceWPe
         sukcr9L4magi82n6pGE9vX3w6FPcoo+RTe+xjfAce0v7/p9+Fy1UlbfmjWMIGZdDjY+/
         o94iUmOxyUyql0+wCE+1afJW1eTG94Y4BlW26PgOPgWdkAuC/Sg+580mCxU5lhprYmZA
         ooDnzBZWe290IqUh6rLlK0t4G2MeEVpIFkEhgwEnoJBRUhhUwcwoeLImSnr69js+KWG+
         qsFg==
X-Gm-Message-State: AOJu0YwVScK0cA8bYeUgJ/KzqgJkNrf/8tgFFWfcikFcF7oPPKA1b1mM
	2kx7BRgH6r65rrtU6SW3DmTYjzahCCPfAJB1m0JcJiE+AaBC0W4GN8A+Pft6db8=
X-Google-Smtp-Source: AGHT+IE7qO6T/9+qPlF9hA6eLKX7/HlZ004AkmimM1k63zLjNxrTzSnXhEa367Dz+49Ss/RRCb6+Fw==
X-Received: by 2002:a05:6a00:26c8:b0:6e0:31c4:3f09 with SMTP id p8-20020a056a0026c800b006e031c43f09mr77255pfw.3.1706951766796;
        Sat, 03 Feb 2024 01:16:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXe7Z/vbVS41+FiSfmZL9uVxRKLKfJb11PuOOKOh/tiNwzCSIuYEoYYiAeHnJRYMnsuNuEc5jiYnAPpmzKg5myYQzVndiXwMMDVUYMWWbpDKSgBQGUJiYLirw3/s8Ite+QzDLERTzzb4DqMuA77zAUiBZrFwVlewvlDoY3GBUHiws3o2IyIRJHvem8Y
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78717000000b006dfed5251easm2973203pfo.76.2024.02.03.01.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 01:16:06 -0800 (PST)
Message-ID: <65be0456.a70a0220.ab5b9.b633@mx.google.com>
Date: Sat, 03 Feb 2024 01:16:06 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc2-29-gc24c55a0329d1
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 51 runs,
 7 regressions (v6.8-rc2-29-gc24c55a0329d1)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 51 runs, 7 regressions (v6.8-rc2-29-gc24c55a0329d1)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc2=
-29-gc24c55a0329d1/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc2-29-gc24c55a0329d1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c24c55a0329d1c36fc0b8e550427db107aabdfac =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65bdf9ece140d0cd3a00a039

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc2-29-gc24c55=
a0329d1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc2-29-gc24c55=
a0329d1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bdf9ece140d0cd3a00a040
        failing since 10 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-03T08:31:24.181835  / # #
    2024-02-03T08:31:24.283801  export SHELL=3D/bin/sh
    2024-02-03T08:31:24.284335  #
    2024-02-03T08:31:24.385553  / # export SHELL=3D/bin/sh. /lava-425689/en=
vironment
    2024-02-03T08:31:24.386324  =

    2024-02-03T08:31:24.487719  / # . /lava-425689/environment/lava-425689/=
bin/lava-test-runner /lava-425689/1
    2024-02-03T08:31:24.488850  =

    2024-02-03T08:31:24.493212  / # /lava-425689/bin/lava-test-runner /lava=
-425689/1
    2024-02-03T08:31:24.556661  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-03T08:31:24.591491  + cd /lava-425689/1/tests/1_bootrr =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65bdf9ece140d0cd3a00a044
        failing since 10 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-03T08:31:26.806231  /lava-425689/1/../bin/lava-test-case
    2024-02-03T08:31:26.834469  <8>[   26.208126] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
bdf9ece140d0cd3a00a046
        failing since 10 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-03T08:31:27.895401  /lava-425689/1/../bin/lava-test-case
    2024-02-03T08:31:27.922279  <8>[   27.296706] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65bdf9ece140d0cd3a00a04b
        failing since 10 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-03T08:31:29.153116  /lava-425689/1/../bin/lava-test-case
    2024-02-03T08:31:29.181141  <8>[   28.555070] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65bdf9ece140d0cd3a00a04c
        failing since 10 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-03T08:31:30.204418  /lava-425689/1/../bin/lava-test-case
    2024-02-03T08:31:30.231573  <8>[   29.604909] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65bdf9ea0d61e3559200a055

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc2-29-gc24c55=
a0329d1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc2-29-gc24c55=
a0329d1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bdf9ea0d61e3559200a05c
        failing since 10 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-03T08:31:22.811396  / # #
    2024-02-03T08:31:22.912491  export SHELL=3D/bin/sh
    2024-02-03T08:31:22.913294  #
    2024-02-03T08:31:23.014574  / # export SHELL=3D/bin/sh. /lava-425687/en=
vironment
    2024-02-03T08:31:23.015238  =

    2024-02-03T08:31:23.116392  / # . /lava-425687/environment/lava-425687/=
bin/lava-test-runner /lava-425687/1
    2024-02-03T08:31:23.117403  =

    2024-02-03T08:31:23.158353  / # /lava-425687/bin/lava-test-runner /lava=
-425687/1
    2024-02-03T08:31:23.186711  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-03T08:31:23.220664  + cd /lava-425687/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65bdf9ea0d61e3559200a06f
        failing since 10 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-03T08:31:26.149322  /lava-425687/1/../bin/lava-test-case
    2024-02-03T08:31:26.177403  <8>[   27.162451] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =20

