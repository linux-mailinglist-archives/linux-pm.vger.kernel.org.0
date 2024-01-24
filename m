Return-Path: <linux-pm+bounces-2694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E15F83B074
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 18:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16AA1F217A3
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA997F7D2;
	Wed, 24 Jan 2024 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="og8O0gdZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8387E764
	for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118610; cv=none; b=VErlPOlt4jjIHwcSn3PAly9aJ9im6jlcYgkb72S7xP8h6nMFsXiIInoQAPCd33wtCvvWNHwnhxpJQQYzgHQq3V58Mh7RBUKynNkgIw9EM2kHWACBcsPJeTGJUHQdTsjTGaHjOOKlmVEUyRH1zPt4f1dOdDvzh7Q7DNbDoR+0ROY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118610; c=relaxed/simple;
	bh=JeH1VfPPYVoJ2IuUmIbaAu3umxmnAuDO7CdU9hGLp1o=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=LTjUPfhgDtesb9Mbc7rgNR/nTJKhZghEYdCd7C49pA6Xhnfc3Rdk0t5ldkO9hDEc7LQlEnyKBPD3+6M25We+XZQxrO8si6A2SfepOnvCJA0aDRvCRh82o+Tgm3tWNvXSsFanQ60OicHRmXdEBr6SG67tKzcNAQXLVQiOy5ueFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=og8O0gdZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d76671e5a4so21914235ad.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 09:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706118607; x=1706723407; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U2YFMX3siZNItNHBjsWWP7MNlr87ud4p6+IGSCXIp6c=;
        b=og8O0gdZXC4myzv+mXyjdfXNDK23jhlGZbZlo/vTYcfclcMc5dWof5ATxQKrb7sRsz
         UaJVQmivPiWttP5oXCnG2r37LkE2h/ZDXjqTkFZA3PyrhCfVUrYiaf2eZNSZBKD42sHB
         ZC2p7re+EL/+fUDqo/xfiRriTyQyPl/x4Qt+dW/b3d9Q/kVKQ/aXf6P3ncAp9hiqvViU
         32Dra7KVHEULMAVQmCjErMKyRcRgGSJYyeufesODSyoGMmnUYd+XnPX/5DjsF46tJMfT
         oGzDKI/9lexlHOyopJ0Dk6+VWc84dTzjQSzA+/u3xLAkJFaPoJe/2Fg2tvNBeS14fBRl
         jSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118607; x=1706723407;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2YFMX3siZNItNHBjsWWP7MNlr87ud4p6+IGSCXIp6c=;
        b=SOnbv0F9NA+O1g9XmNbHI8m5HSGKz9RfPh0y0qYpr72mL01A+tPZtCsKWhrjzOYI0b
         F4UH4ogYYSUEsSOtVYzaBSWUa5AXqIPyV6KnIZcwaZOO8Pk+OwCqd7Amwg5Xkb0oXF+G
         oMYrFbdpYAp7XUWe1Kkt+343sEc/E3LuUZZcPLG3A1nVQsm58kZ6rz7or8Og0UVLrC/7
         JNkF0KHvFTRP50cQr8PnUT3vCgbWOjyTrMD21Y0D9/BQSyF0vHjjYXKjl2qdOV4gnAqA
         s/N6t6LFLAh1LBVFFrtCdprHxeWQg422XqnhWXM6GF09VIyH/SSobovkI6qAkbTLTWKh
         EcAg==
X-Gm-Message-State: AOJu0YzjPDp3qCTj4Zziwg14weBnDbW7vp5GpDQarsqz8rruHZgMqsFV
	JZlyw9hAI+kuhF5ZDf0PrVhRwcUkLpnzYP5F/i1GU7KN1UQwF1ZjO+uJSq0e0txR1hnaR+7wLYP
	oEMw=
X-Google-Smtp-Source: AGHT+IG9znW7XJA8FgUCdNWkeVFeXtOjWdP6kjk61D0fPRb+RK9hHuJ9zlq7MH0b5cosHG+iCmnbyw==
X-Received: by 2002:a17:90a:e550:b0:28e:82bb:1373 with SMTP id ei16-20020a17090ae55000b0028e82bb1373mr5259342pjb.29.1706118607639;
        Wed, 24 Jan 2024 09:50:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090a061700b0028e023be116sm15201245pjj.49.2024.01.24.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:50:07 -0800 (PST)
Message-ID: <65b14dcf.170a0220.4c955.7511@mx.google.com>
Date: Wed, 24 Jan 2024 09:50:07 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-7-g8831e2e9bce4c
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 46 runs,
 7 regressions (v6.8-rc1-7-g8831e2e9bce4c)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 46 runs, 7 regressions (v6.8-rc1-7-g8831e2e9bce4c)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc1=
-7-g8831e2e9bce4c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc1-7-g8831e2e9bce4c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8831e2e9bce4caf7e069ad047eeca56d604abc23 =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65b1437d46d6949edd52a3fd

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc1-7-g8831e2e=
9bce4c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc1-7-g8831e2e=
9bce4c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65b1437d46d6949edd52a404
        failing since 0 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-24T17:05:39.305467  / # #
    2024-01-24T17:05:39.407074  export SHELL=3D/bin/sh
    2024-01-24T17:05:39.407530  #
    2024-01-24T17:05:39.508431  / # export SHELL=3D/bin/sh. /lava-421542/en=
vironment
    2024-01-24T17:05:39.508949  =

    2024-01-24T17:05:39.610382  / # . /lava-421542/environment/lava-421542/=
bin/lava-test-runner /lava-421542/1
    2024-01-24T17:05:39.611576  =

    2024-01-24T17:05:39.618443  / # /lava-421542/bin/lava-test-runner /lava=
-421542/1
    2024-01-24T17:05:39.715942  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-24T17:05:39.716234  + cd /lava-421542/1/tests/1_bootrr =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65b1437d46d6949edd52a408
        failing since 0 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-24T17:05:41.931023  /lava-421542/1/../bin/lava-test-case
    2024-01-24T17:05:41.957918  <8>[   26.061792] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
b1437d46d6949edd52a40a
        failing since 0 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-24T17:05:43.019718  /lava-421542/1/../bin/lava-test-case
    2024-01-24T17:05:43.046508  <8>[   27.150284] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65b1437d46d6949edd52a40f
        failing since 0 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-24T17:05:44.278703  /lava-421542/1/../bin/lava-test-case
    2024-01-24T17:05:44.305754  <8>[   28.409281] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65b1437d46d6949edd52a410
        failing since 0 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-24T17:05:45.329623  /lava-421542/1/../bin/lava-test-case
    2024-01-24T17:05:45.356320  <8>[   29.459250] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65b143199f7ec2530952a432

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc1-7-g8831e2e=
9bce4c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc1-7-g8831e2e=
9bce4c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65b143199f7ec2530952a439
        failing since 0 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-24T17:04:02.869464  / # #
    2024-01-24T17:04:02.970128  export SHELL=3D/bin/sh
    2024-01-24T17:04:02.970361  #
    2024-01-24T17:04:03.070867  / # export SHELL=3D/bin/sh. /lava-421544/en=
vironment
    2024-01-24T17:04:03.071101  =

    2024-01-24T17:04:03.171621  / # . /lava-421544/environment/lava-421544/=
bin/lava-test-runner /lava-421544/1
    2024-01-24T17:04:03.171963  =

    2024-01-24T17:04:03.183397  / # /lava-421544/bin/lava-test-runner /lava=
-421544/1
    2024-01-24T17:04:03.277278  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-24T17:04:03.277422  + cd /lava-421544/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65b1431a9f7ec2530952a44c
        failing since 0 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-24T17:04:06.209283  /lava-421544/1/../bin/lava-test-case
    2024-01-24T17:04:06.237240  <8>[   27.081664] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =20

