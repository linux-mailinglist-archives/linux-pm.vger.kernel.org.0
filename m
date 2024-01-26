Return-Path: <linux-pm+bounces-2784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC48B83D19B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 01:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438281F25000
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 00:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998C385;
	Fri, 26 Jan 2024 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ANImgQh+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53CD362
	for <linux-pm@vger.kernel.org>; Fri, 26 Jan 2024 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706229840; cv=none; b=LZy8XiUP/pnPCD+TAc0nEId3vSB9dqZ1aM0BzvL7sfysYRXXWs1rk9DPmPnfhdJdhJWOPLmaSYiqoYlZG7mEKIX6O8DDTBhtmQW9nPHQK3hKFOGjhEMSOxzKVa+wIuOu4Hs0JwRFSXpNPlbQ1TuPyBXXw2mvho+fdom5QMowP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706229840; c=relaxed/simple;
	bh=7N+0clwta7AhBGaTp8V9E5iQiB3NJchrxHZUEjdhG8w=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=IOqJH8uWUEu1ds3Y129YfjDAIe4+3TEda3a64chzsOiBy0Hm7Ygu/b9tKYICZttKf42SLffwBZkvGIX0DYc0Dj79TOOfjvnX2Ujged8UZUGDk3LhoGX03TYpMgCckF6UHkqc02GJVdIDAh3qwk6twjS+rhAjGYgRYfVL9i4AXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ANImgQh+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-290a55f3feaso3785873a91.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 16:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706229837; x=1706834637; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fd0gq6XwmlmbiHe4krrwVUv7P/etTNsTkcoy9sxTbBQ=;
        b=ANImgQh+J906eeCgtp5syeU/tzoVOE82Ok2fCkr7Q04A9nVYS0sxpZFSsSxZUKJylY
         SA4nQXHSraLIxQo7yoCeqto5fxJfk6Z4RS2nfeyQIMvxm1VZ1QqGSuSe9wdlcHbJKV/i
         GwEoNVvI37QwkfvTM67ZZNbQQdcCmAMlPWZO3CnAfiBDjaOcU6zaSSs8QpiWtSd4hcbg
         uHY3z/OQYufCAPapB5nJ8V/rxhccXIeicTDzXxwOl90X5hk3Xu4SHAlTMVvXyns3dZ9J
         dPzTXZLgTQ5bMf++MNqC0Ad4tIJ6dgCC0R1gSjW7VID5U/J3wPe7EX88CUkGYO1CsOXq
         A7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706229837; x=1706834637;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fd0gq6XwmlmbiHe4krrwVUv7P/etTNsTkcoy9sxTbBQ=;
        b=l80mh1pi+aaiqXpE/SnKJvQJWCUlt1eVIZCHc+OZ91NclOcyWLvcqDT43xjCkBJ0zj
         mNLtFsnqYSMlxbX9P/8tSWzLC0fGcwEkXoQ4fhwLni+64Egrz8GFhiBjOZZiERFgiJWk
         UdiZ/086mRxWszx0FPbZIO075q3UKH0kPZdsAIZgkNFmcMH1B/EfrmoIeohfa7E2bqUo
         /bx9eome6Xrbb1ECyJMtsEEWxIKWXfai+DPDt1q6q8o35WWL9BrFmbOUDWIpAbhQIcV7
         imTy0xQJvzU5UUDu86p3u5miHtnN89Dd/lK6u6fKqOdB8c4XgLbW3PCSeF0DOgBjhWDE
         TkAQ==
X-Gm-Message-State: AOJu0YzureSg+8DLElL0lUO/P6uGLl/6zxsGNi+GhUv1kKIJnptFkGaR
	79Ylp+z6KuhXeOcTYpVM9/0gkc10K9uz+TeIzPFo+aXFjD8c6rtwrUoHnSCSbEE=
X-Google-Smtp-Source: AGHT+IGFrkP1v5NVpRFeF18TfDbnzHXpa7e490HKU00xB8fcJ2yOUb/yFb/ZWxVANBNadSwbWa02Ww==
X-Received: by 2002:a17:90a:fb57:b0:28d:dbe8:aa6c with SMTP id iq23-20020a17090afb5700b0028ddbe8aa6cmr408761pjb.36.1706229836994;
        Thu, 25 Jan 2024 16:43:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902d28900b001d73a2acc2bsm87054plc.142.2024.01.25.16.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 16:43:56 -0800 (PST)
Message-ID: <65b3004c.170a0220.1db40.04da@mx.google.com>
Date: Thu, 25 Jan 2024 16:43:56 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-9-g7c67bc59f33e0
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 48 runs,
 7 regressions (v6.8-rc1-9-g7c67bc59f33e0)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 48 runs, 7 regressions (v6.8-rc1-9-g7c67bc59f33e0)

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
-9-g7c67bc59f33e0/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc1-9-g7c67bc59f33e0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7c67bc59f33e03c4b44e6855df57681c921c065d =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65b2f5fe2445ec6ffb52a3f3

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc1-9-g7c67bc5=
9f33e0/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc1-9-g7c67bc5=
9f33e0/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65b2f5ff2445ec6ffb52a3fa
        failing since 1 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-25T23:59:42.915435  / # #
    2024-01-25T23:59:43.017723  export SHELL=3D/bin/sh
    2024-01-25T23:59:43.018582  #
    2024-01-25T23:59:43.119982  / # export SHELL=3D/bin/sh. /lava-422239/en=
vironment
    2024-01-25T23:59:43.120707  =

    2024-01-25T23:59:43.222115  / # . /lava-422239/environment/lava-422239/=
bin/lava-test-runner /lava-422239/1
    2024-01-25T23:59:43.223318  =

    2024-01-25T23:59:43.227322  / # /lava-422239/bin/lava-test-runner /lava=
-422239/1
    2024-01-25T23:59:43.291557  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-25T23:59:43.331118  + cd /lava-422239/1/tests/1_bootrr =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65b2f5ff2445ec6ffb52a3fe
        failing since 1 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-25T23:59:45.542067  /lava-422239/1/../bin/lava-test-case
    2024-01-25T23:59:45.567933  <8>[   26.117441] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
b2f5ff2445ec6ffb52a400
        failing since 1 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-25T23:59:46.629518  /lava-422239/1/../bin/lava-test-case
    2024-01-25T23:59:46.656069  <8>[   27.205022] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65b2f5ff2445ec6ffb52a405
        failing since 1 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-25T23:59:47.886717  /lava-422239/1/../bin/lava-test-case
    2024-01-25T23:59:47.914765  <8>[   28.463296] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65b2f5ff2445ec6ffb52a406
        failing since 1 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-25T23:59:48.936975  /lava-422239/1/../bin/lava-test-case
    2024-01-25T23:59:48.964239  <8>[   29.513054] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65b2f6012445ec6ffb52a454

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc1-9-g7c67bc5=
9f33e0/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc1-9-g7c67bc5=
9f33e0/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65b2f6012445ec6ffb52a45b
        failing since 1 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-25T23:59:43.430027  / # #
    2024-01-25T23:59:43.532143  export SHELL=3D/bin/sh
    2024-01-25T23:59:43.532848  #
    2024-01-25T23:59:43.634397  / # export SHELL=3D/bin/sh. /lava-422240/en=
vironment
    2024-01-25T23:59:43.635104  =

    2024-01-25T23:59:43.736411  / # . /lava-422240/environment/lava-422240/=
bin/lava-test-runner /lava-422240/1
    2024-01-25T23:59:43.737291  =

    2024-01-25T23:59:43.741952  / # /lava-422240/bin/lava-test-runner /lava=
-422240/1
    2024-01-25T23:59:43.805998  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-25T23:59:43.839932  + cd /lava-422240/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65b2f6012445ec6ffb52a46e
        failing since 1 day (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4,=
 first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-25T23:59:46.767528  /lava-422240/1/../bin/lava-test-case
    2024-01-25T23:59:46.794494  <8>[   27.046063] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =20

