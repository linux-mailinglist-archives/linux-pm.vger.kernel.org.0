Return-Path: <linux-pm+bounces-7533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9492F8BCEA6
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 15:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D1287A1E
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 13:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C61E5FB9A;
	Mon,  6 May 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cM5oAQxi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1B644C66
	for <linux-pm@vger.kernel.org>; Mon,  6 May 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000407; cv=none; b=gXuKV68pqbfTkgF1YeDJgzPwUkUJXlJ+9Yu5ABZFsCd1cBXpryLVZXoDvurl2jZMsW2ROQ/8KarXDX2Nbp3MOWCrOUx0I4UHfpY0VWTZAyNwdWWt5ILNT0LVfxIzo5S3ykUQIVCgNrBK4dler0a2m+j5fFtf9fy2fRJhDZt98ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000407; c=relaxed/simple;
	bh=ywisfgMQOkjU8YOo0FQYmZR02hz324EUcNjr0pgJlf8=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=t5zruhKSEil9dmJtVGeVUDlWDmqN4QdEd7orRqG6+kze7oEonzpgyoqoq9ovaPvkwTVeK6QK51TPwM5f36gzJ30vFfYESmv05yEPb+irWOrdXeNptiCPgCdn6fqfSr9FWsxFEdWqCvd4NVxXCAjpWQkDzpmIsmSR58mxXWYvxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=cM5oAQxi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f4496af4cdso1447670b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 06 May 2024 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1715000405; x=1715605205; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nix+2Iaw6Pb6IYP4quZILWH+yUtrb8GC7abGRKOKv0M=;
        b=cM5oAQxiMyRqU9E7aR2tBRESzxOUPzVCAmuGIIT0nwocMABZkV9zxS75clps7YfJFC
         yEskYmU9FTOQDiWsFg0dsMtkNqn8p18IPEbKUh9KddbS9t7znE+EQAkYHlcBHDaL9yPF
         DF0tTw1OcOA9C1yJHwmiDk/XAQRw8QhD40x2kv2boI63dDny3HCURMvBh0teYTS11/+E
         HP2w0sv270egA/Ayf8Jr9GQ0DUtiqlAvz1ddoly1fif/8jiDTPVzX8wwS1gWahMlA7xb
         TA5IZXtHUWTC6qqDdg4QXT/eWlKfJ2/FOAp66nTL8RM2BbAJGzOviKc7vkFldDKATAW8
         t88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715000405; x=1715605205;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nix+2Iaw6Pb6IYP4quZILWH+yUtrb8GC7abGRKOKv0M=;
        b=WVpdjAHmENHBl64e3rhEOyCgazvyq1qa+0tJIgqV2q2g+PHUxCiTN7g73TgfPH0bNP
         nYUhBLQqxpBMRvNMfPqLdE/L8elQWFh+mgMsbZzKXNcPrljG6R/MqyITXvhc+w7VZUJI
         sf1759zNNylYApuFnsBqMJ/emJNXY8U8dB8Ot+2kHjmzPIx6I4+6lEyroCdFWfw+9QHq
         piAJ2tWYLUxvuW3Yg807Z+TjGbcpyjTS7BvFWSrQeBWanM4Uql+7eRqTnOHk1xWR6aLk
         nKIRmPlhBugQC1YFBzSPJKqeM5EVcEvz0fMwadZNeKKBiqPjG4Ek0PKt1OtAnKXK9G1S
         YYpw==
X-Forwarded-Encrypted: i=1; AJvYcCUrosFqYXBeDft37hfeXSy0HARt5tNE+i9AhlUkqlPMCnG9HEW9NRBv/673/9fCKSelVHwlJJNT+EzjU4gZCojwiCFByrR2aAU=
X-Gm-Message-State: AOJu0Yw9+XhqpfL8H2sMXEe8yTzBlvJuS/Dk6wV0cMuXVokrFSb/YQHM
	53wagmfDjbSHPZAHodDwOsUgPB16i71D3ctV21oKLAddWo+IcQYzeI3k1pUT7oLl8vWSwdyCFcu
	cChg=
X-Google-Smtp-Source: AGHT+IFlu5GzkCY3WPAvt5TfN+6qAys0PlQUzAMxfHsnlMx/GqDmsNuLU+rq9xBSmuvB48Y0OP1hdw==
X-Received: by 2002:a05:6a00:1d11:b0:6f4:8008:5cd3 with SMTP id a17-20020a056a001d1100b006f480085cd3mr2128248pfx.34.1715000405105;
        Mon, 06 May 2024 06:00:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l23-20020a637017000000b0061c60a12026sm6514979pgc.72.2024.05.06.06.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 06:00:04 -0700 (PDT)
Message-ID: <6638d454.630a0220.d1983.288c@mx.google.com>
Date: Mon, 06 May 2024 06:00:04 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc7-218-gf471f351f0d8f
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 40 runs,
 1 regressions (v6.9-rc7-218-gf471f351f0d8f)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 40 runs, 1 regressions (v6.9-rc7-218-gf471f351f0d8f)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.9-rc7=
-218-gf471f351f0d8f/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.9-rc7-218-gf471f351f0d8f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f471f351f0d8fad64c86352521f1104ff2c3563f =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6638c7970475bd20654c42e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.9-rc7-218-gf471f=
351f0d8f/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb=
15-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.9-rc7-218-gf471f=
351f0d8f/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb=
15-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6638c7970475bd20654c4=
2ea
        new failure (last pass: v6.9-rc6-227-g058b3af4882a) =

 =20

