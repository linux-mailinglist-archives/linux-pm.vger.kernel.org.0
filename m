Return-Path: <linux-pm+bounces-3843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C70D851E32
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 20:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BC0B217AD
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFFA47F6C;
	Mon, 12 Feb 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="k6Qn8chA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A71447A6C
	for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767755; cv=none; b=cxLOjFHmTrkgfrPoGG2N6jIx6g1PFGmcZ8g/VDTO8QWaIQrJ0VQVG2FhxTBlazVs+61l8d2T/S7Ys2C5dLFcl5YgJZdqzfyxw7mmm6nTX7o6k9TqCF50B1HePCmVnCy4nGhuJfcjpCJkCje6bMa7Aj3htb15W6+CiH+J4OMxPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767755; c=relaxed/simple;
	bh=4cLHkKflW9wtOcfq7ahqfr6RfChlnh4C18rlfaglcJ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=g1CjqAW1AZxwo70D/ZT21nx3osom/kSy5TLbEEwzwJdjletjmaDu7mq3ZUBfUZzt4QsDqQ3Tlh5ZBqUo8qrfHzwLWR1Gy1u4AyKWpsdGXPdqlPR46cAzYU3oXdyCyedgVK0YdLrcZl19FPkdUZMc/Dn3qn9Ayt9RzOPys6P/5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=k6Qn8chA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6de3141f041so188558b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2024 11:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707767752; x=1708372552; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cgez2RAxYFLmPIyNpNmgodkoULAOgzFCXPFydTv3QI=;
        b=k6Qn8chA1ZIBvJo3G2DcXz4V1XcJ7Xb6eBe2kXWCm3qtyufyV1ndmGpu2emiOzRBGm
         8Gd4QUy4Ah9e0Vcjj7W5AtoNqI2bC2JPL0jW8UoJlwf57jbAVHyapLttl6g88nZw/Rm6
         My6EGVCR8rOTPq0V1BcFC0DtMKLL+WfGO4qBkINGT0sPlbiGfRn10unmhXdh1OFTynj+
         R/T3jMTsSb5zUXZYYYHCGbeWhIjngJ9CZGvAvn6+laRMSUZktKEI7UVDkvVEVyzzPbnn
         LpA96/ig0gDq/7M8AIIIWokQDdKN8GZg1HuaCgIRSvhS5MGQPiAPSxTudQ/oIHooZ603
         XiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767752; x=1708372552;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Cgez2RAxYFLmPIyNpNmgodkoULAOgzFCXPFydTv3QI=;
        b=O1KyyyA1KgTYF3DhbsR9AgRp65Z78NzgNT8bT7lN/YfAAXJmfD0clMrFLsf63e/KXr
         6H2oMR3Xcb6hR4GcgsN2kjQZPslkzd6CdvhyNezuef9iSFxrf79DqPwR7UOmSdRBd7VW
         wlQFibq594F8suiH9huOLgMCw8kkU1SPuPydGYvFnT40htKBYRyJouy8YmuJHFOwwwOH
         XcqAdjWMPOW7UXW0HCGJPSpK52FwztdVoNPWiIqJogPxc+K0/nBeRESBI2jkvqUNbzaZ
         OWix67rfWsQ1rJpSEfzzPXe7rsYgyZaqCw9mzTtIlEMgdR5QFZaHFXb8WUGIbeHxXUnr
         2BdQ==
X-Gm-Message-State: AOJu0Ywsmm4wsrxgjJuq7H5rrGRFKoST8hrtvZlySoNGBc1ZjXi4pgbM
	oF1NqMDJhA7wVg761GaY/Tkcsk+/KGpuFU65ehzO7578bSjoYCVNF67IFwxYHFs=
X-Google-Smtp-Source: AGHT+IEeZ0uCoag/WQrICYzFidttjGbUa9cPpWGJMhmyEN3heaR37Eub2DbUom36WTiB6Via0KLi2g==
X-Received: by 2002:a05:6a00:9285:b0:6e0:cbc3:aa39 with SMTP id jw5-20020a056a00928500b006e0cbc3aa39mr6844296pfb.1.1707767752636;
        Mon, 12 Feb 2024 11:55:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQDh2W2/tdJp6W2VQxKUsAyW5gInNke5gbxSPKGRyqDQz25OQ9bsnZdY3uOnUxwNUxmIUsQ0nSs62ki7JTfMWK+tjnCkvgjEFFgmHXWAtx4j3fXD+k+cl/FD2sP17eauy9MuoN5egIYQJ1VcOVY3tsiMtPDfsbre68Nh0J6T7K20ORU4iPlSGsmPKv
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t31-20020a056a00139f00b006e0a895d2e9sm4748959pfg.211.2024.02.12.11.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:55:51 -0800 (PST)
Message-ID: <65ca77c7.050a0220.f6fbb.ae88@mx.google.com>
Date: Mon, 12 Feb 2024 11:55:51 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc4-60-g496258bf75632
Subject: pm/testing baseline: 45 runs,
 7 regressions (v6.8-rc4-60-g496258bf75632)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 45 runs, 7 regressions (v6.8-rc4-60-g496258bf75632)

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
-60-g496258bf75632/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc4-60-g496258bf75632
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      496258bf75632ee2a5d497f954312471392d0e30 =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65ca6c3587dc83e5398e1e79

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc4-60-g496258=
bf75632/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc4-60-g496258=
bf75632/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ca6c3587dc83e5398e1e7c
        failing since 19 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-12T19:05:53.638627  + set<8>[   23.365421] <LAVA_SIGNAL_ENDRUN =
0_dmesg 428826_1.5.2.4.1>
    2024-02-12T19:05:53.639064   +x
    2024-02-12T19:05:53.744204  / # #
    2024-02-12T19:05:53.846391  export SHELL=3D/bin/sh
    2024-02-12T19:05:53.847094  #
    2024-02-12T19:05:53.948669  / # export SHELL=3D/bin/sh. /lava-428826/en=
vironment
    2024-02-12T19:05:53.949368  =

    2024-02-12T19:05:54.050660  / # . /lava-428826/environment/lava-428826/=
bin/lava-test-runner /lava-428826/1
    2024-02-12T19:05:54.051790  =

    2024-02-12T19:05:54.070171  / # /lava-428826/bin/lava-test-runner /lava=
-428826/1 =

    ... (16 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65ca6c3587dc83e5398e1e80
        failing since 19 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-12T19:05:56.370081  /lava-428826/1/../bin/lava-test-case
    2024-02-12T19:05:56.397119  <8>[   26.128530] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
ca6c3587dc83e5398e1e82
        failing since 19 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-12T19:05:57.458360  /lava-428826/1/../bin/lava-test-case
    2024-02-12T19:05:57.484963  <8>[   27.216772] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65ca6c3587dc83e5398e1e87
        failing since 19 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-12T19:05:58.718709  /lava-428826/1/../bin/lava-test-case
    2024-02-12T19:05:58.745693  <8>[   28.476735] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65ca6c3587dc83e5398e1e88
        failing since 19 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-12T19:05:59.769184  /lava-428826/1/../bin/lava-test-case
    2024-02-12T19:05:59.795326  <8>[   29.526776] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65ca6c332c70a6a2878e2215

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc4-60-g496258=
bf75632/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc4-60-g496258=
bf75632/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ca6c332c70a6a2878e2218
        failing since 19 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-12T19:06:01.848666  / # #
    2024-02-12T19:06:01.950811  export SHELL=3D/bin/sh
    2024-02-12T19:06:01.951682  #
    2024-02-12T19:06:02.053264  / # export SHELL=3D/bin/sh. /lava-428825/en=
vironment
    2024-02-12T19:06:02.054247  =

    2024-02-12T19:06:02.155446  / # . /lava-428825/environment/lava-428825/=
bin/lava-test-runner /lava-428825/1
    2024-02-12T19:06:02.156397  =

    2024-02-12T19:06:02.176172  / # /lava-428825/bin/lava-test-runner /lava=
-428825/1
    2024-02-12T19:06:02.263854  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-12T19:06:02.264309  + cd /lava-428825/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65ca6c332c70a6a2878e222b
        failing since 19 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-12T19:06:05.189818  /lava-428825/1/../bin/lava-test-case
    2024-02-12T19:06:05.218023  <8>[   27.073523] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =20

