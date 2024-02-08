Return-Path: <linux-pm+bounces-3574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F57F84D6D5
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 01:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840F31C21D54
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264CF173;
	Thu,  8 Feb 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="mKXZGZ6l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30246EC9
	for <linux-pm@vger.kernel.org>; Thu,  8 Feb 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350426; cv=none; b=cZYDH5eKo5xZP1OR+CUXdkdBZrKMAeFUcGGDoqSbmJj0M2FZnpppIM8zS4gq6BxvVLDln82EwbOBK2U4n0K7whv2pwBKPIX3K+jcr268aUrX8mg34tOZJ3b1L4TgzXEyh4YOiURnhx4YrLb0GCnymWdML+51KdQLJ1CO7aR+mBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350426; c=relaxed/simple;
	bh=RmFn9KyOjZ3ejt47qAosjcCaMzybm6duCPb8opsv68M=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=PQLL0UlkttUS8pI47eFgw6Wf4tjfC6oRERaUa4PSMo4QJIJIsGlT0lrCJRLxFkuyeGAWrthVFGZgTc2XDUML0hQN+WEigfw92IOuzXwMCEbpqfQcuTH8QKrykI0g13uA6Qy5sumkpAqCVTrBhDVehsk2TiYKp/ZfV0Y4uEAS+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=mKXZGZ6l; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5986d902ae6so622610eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Feb 2024 16:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707350423; x=1707955223; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VgPxpQHIs6H8a505luO/YYZYedOtJNmw/dL87f5cxmk=;
        b=mKXZGZ6l4PnLVsTifHmOkq6kEZZaGcjpfHFiEZ2iaHFnORS8ULV+OMrxZarcuIPPDJ
         u5oXpZi/wl/dB1TrfZoiz2nne97hCg7BsB6eOZfI23MT2B+kjAzi0jvsu41xuaWwdn9L
         zTxES0yrADE65R+7Mc92sEZ9WcPCDefsUT3H3GGzXjdNQBGBvMQukWJRQLOBaYHyMcwO
         WEB+2oACUvBkJCXbS91UrezGvy+xYI9aPk3r4xSLYiuefgLcrbYZ/FxtwUIGMZUZ5sQ2
         wHZHfnj4LOqJwPeycripNHMHqEde77LfNx41zhOsv0t6TLUtmW7PXkRtxFfFL5mxYqkF
         1gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707350423; x=1707955223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgPxpQHIs6H8a505luO/YYZYedOtJNmw/dL87f5cxmk=;
        b=n8wPpWwWx06Nas5H/O3DaWQOGXE+1QsjUhihmW7LhuAyPkHXaWB2SfnAMU2LQsLZ4B
         auNK1AaYfFls0BeDOSvRhUlii9tAPY4GJQHlXFgkbB4642u/I5jGLv+x1uyaLsIha+WZ
         nEYnobD8BYK2aZHMOOqOLASHpv56C7rRrMT3EOBDzL4ZKhUq/dVT7sOTBiK3jF5XIjLR
         j2u07YSfuP5VB0cncdqGxxnlxEiyM0l6cApOT7Kbx6Ugwu1jCreQUYTHb6dIP84NZvTx
         KLIVkgUFb3GoL/pzaBSm9C7LZQ0CSRYqWHZrmO6pCQ9uIUeKijwMGrSPwNmPQ6R3Hg3f
         +W5w==
X-Gm-Message-State: AOJu0YwyRsHPme6iQig1KISeNoHR5kyG+513yqqo5up3Efe1Yi+BiZQc
	hHV/+623aaS0wcQ/KPsk5SXbp6lSS8r0L+kQVLGGB8Yy/GpwkWAwhP0Mw+f4RqGUaz0N9UcenVu
	isA8=
X-Google-Smtp-Source: AGHT+IGW/kcutek4rrVRzLwF95JQezgS8uMQYUIr4TNNuYgy67j44Ue8K02GK4o9CAPdESVEKglMiQ==
X-Received: by 2002:a05:6358:7f17:b0:178:a202:66b1 with SMTP id p23-20020a0563587f1700b00178a20266b1mr5273233rwn.25.1707350423045;
        Wed, 07 Feb 2024 16:00:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1qtLRnADUQfDP1OZVDsUrZhnOLQB5DU6NVEHCjnnT5HHOo6WPUIO9qkYxMNmEhzeRAC0Mo1/C/5B+lyOfK98U/MNcBkeK8BzyMYUNTiTg40KiOG7IHs4sovoFS3RAH79icJnSiyyvmrp8qqt7NktINJ3+pdnECtRFUGBkmTH3uQJgoFX2Nb5Mj8Xq
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r18-20020aa78b92000000b006e04d2be954sm2258114pfd.187.2024.02.07.16.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 16:00:22 -0800 (PST)
Message-ID: <65c41996.a70a0220.d2040.7c8d@mx.google.com>
Date: Wed, 07 Feb 2024 16:00:22 -0800 (PST)
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
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.8-rc3-33-gda60429b5e6b
Subject: pm/testing baseline: 52 runs,
 8 regressions (v6.8-rc3-33-gda60429b5e6b)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 52 runs, 8 regressions (v6.8-rc3-33-gda60429b5e6b)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc3=
-33-gda60429b5e6b/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc3-33-gda60429b5e6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      da60429b5e6b47f941e6ee4366a64b8335df1b27 =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65c40f5f611056f14d8e1e94

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc3-33-gda6042=
9b5e6b/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc3-33-gda6042=
9b5e6b/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c40f5f611056f14d8e1e97
        failing since 14 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-07T23:16:16.038221  / # #
    2024-02-07T23:16:16.140242  export SHELL=3D/bin/sh
    2024-02-07T23:16:16.140969  #
    2024-02-07T23:16:16.242471  / # export SHELL=3D/bin/sh. /lava-427168/en=
vironment
    2024-02-07T23:16:16.243195  =

    2024-02-07T23:16:16.344759  / # . /lava-427168/environment/lava-427168/=
bin/lava-test-runner /lava-427168/1
    2024-02-07T23:16:16.345934  =

    2024-02-07T23:16:16.386370  / # /lava-427168/bin/lava-test-runner /lava=
-427168/1
    2024-02-07T23:16:16.453746  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-07T23:16:16.454166  + cd /lava-427168/1/tests/1_bootrr =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65c40f5f611056f14d8e1e9b
        failing since 14 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-07T23:16:18.666811  /lava-427168/1/../bin/lava-test-case
    2024-02-07T23:16:18.694970  <8>[   26.225957] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
c40f5f611056f14d8e1e9d
        failing since 14 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-07T23:16:19.755262  /lava-427168/1/../bin/lava-test-case
    2024-02-07T23:16:19.781835  <8>[   27.313740] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65c40f5f611056f14d8e1ea2
        failing since 14 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-07T23:16:21.015591  /lava-427168/1/../bin/lava-test-case
    2024-02-07T23:16:21.042654  <8>[   28.573554] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65c40f5f611056f14d8e1ea3
        failing since 14 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-07T23:16:22.065650  /lava-427168/1/../bin/lava-test-case
    2024-02-07T23:16:22.092729  <8>[   29.624034] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65c40f63c99842f5458e1e7f

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc3-33-gda6042=
9b5e6b/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc3-33-gda6042=
9b5e6b/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c40f63c99842f5458e1e82
        failing since 14 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-07T23:16:33.869488  / # #
    2024-02-07T23:16:33.971737  export SHELL=3D/bin/sh
    2024-02-07T23:16:33.972447  #
    2024-02-07T23:16:34.073895  / # export SHELL=3D/bin/sh. /lava-427171/en=
vironment
    2024-02-07T23:16:34.074611  =

    2024-02-07T23:16:34.176126  / # . /lava-427171/environment/lava-427171/=
bin/lava-test-runner /lava-427171/1
    2024-02-07T23:16:34.177288  =

    2024-02-07T23:16:34.196837  / # /lava-427171/bin/lava-test-runner /lava=
-427171/1
    2024-02-07T23:16:34.284493  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-07T23:16:34.284916  + cd /lava-427171/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65c40f63c99842f5458e1e95
        failing since 14 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-07T23:16:37.215028  /lava-427171/1/../bin/lava-test-case
    2024-02-07T23:16:37.245202  <8>[   27.053043] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
rk3399-roc-pc          | arm64 | lab-broonie | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/65c4115db6f458fa7c8e1e80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc3-33-gda6042=
9b5e6b/arm64/defconfig/gcc-10/lab-broonie/baseline-rk3399-roc-pc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc3-33-gda6042=
9b5e6b/arm64/defconfig/gcc-10/lab-broonie/baseline-rk3399-roc-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c4115db6f458fa7c8e1=
e81
        failing since 2 days (last pass: v6.8-rc2-29-gc24c55a0329d1, first =
fail: v6.8-rc3-31-g7cfffced6d0e) =

 =20

