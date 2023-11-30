Return-Path: <linux-pm+bounces-535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBB97FE956
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 07:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03BD1C20A1E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E17A154B8;
	Thu, 30 Nov 2023 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cfgos/gf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D491AD
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 22:51:24 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c230c79c0bso514441a12.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 22:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701327084; x=1701931884; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pwqcjaCKqdwJDrSE6ACpo1UwGj3tGCYG+RW8or856Uw=;
        b=cfgos/gfsFUKl2Uyw52aRDYyHNpkyAURoMdkZeQfDesuIdlZIaDx57AfFnfaWYmV9b
         Vb16aeB+Fl2Tj1oyjxCIQ0mGi7Qx5jRyMf0llGXxUHtUDEY52FFASNyUd6N0JWx1PHTz
         KHe2Q2fmM359YdYXM0tVBy4DbBrgADvom+TNsCH9RtH0iaFkSa7U5mmy3AgWvaIMrlV2
         XDLcG01qkq3u9HP434VkznlobrxL0S8x7VrJ3Z9vm1pfPFPIaf1peKzVNJDFdTzaWso1
         E5Lyw/1k2v/JTlQkrvb8MBPss8HMdu2FskG4XLeO0WZJVnh7rq31yqwi2EY6lLXEbw/i
         VLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701327084; x=1701931884;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwqcjaCKqdwJDrSE6ACpo1UwGj3tGCYG+RW8or856Uw=;
        b=K4r0mS9mucP9bkg8w691UvTubeXNJqNtKHRobsIWjQKYt1tdBQTw0WKHpGh1Aaw9ie
         tZH3XnKTUxKbDBKNwiUfHeEmKqeeVB7QhmsVEOVpOyLToD3B94CDHDtFg8TW1+673ZzQ
         +FvvV92+FvN8q2dBclXrN9BweHcO73tINNoMJPQz/XdUMPrayMPA1bNG/d/+D6zz1X+p
         dyFEdTuy2VtX0yGphtTCQt7mxCwrSqqSK37ZLCBITbjfZg/wwSDEWUgC9zsI+Fe2xsok
         M47we+7lUpfPOl8CACTanN036GHsJYux05agnjyapkIRmu+5cezIZb12ddNKNrHThZP2
         LNjw==
X-Gm-Message-State: AOJu0YyOv7V91DtuBeF+uL3xjfrc4mTE5zxuXi1UiX4k7Ui/7/CD3/+z
	GZHKK95PjACYi+YGduxmOTPKp5mX2LGxdaLyaRsvuQ==
X-Google-Smtp-Source: AGHT+IFgXMmeDEcjRz5tFsxdRnVhTL7LDEyg+nRorxIbQl4YWre5xl45fYkBOSDjvNNNpxSWTGqHIw==
X-Received: by 2002:a05:6a20:3d84:b0:18c:41cd:c74d with SMTP id s4-20020a056a203d8400b0018c41cdc74dmr16421021pzi.5.1701327084223;
        Wed, 29 Nov 2023 22:51:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a18-20020a17090acb9200b002839d7d8bf3sm2459504pju.55.2023.11.29.22.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 22:51:23 -0800 (PST)
Message-ID: <656830eb.170a0220.ca1e3.7bde@mx.google.com>
Date: Wed, 29 Nov 2023 22:51:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.7-rc3-56-gd9670e2b27245
Subject: pm/testing baseline: 60 runs,
 1 regressions (v6.7-rc3-56-gd9670e2b27245)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 60 runs, 1 regressions (v6.7-rc3-56-gd9670e2b27245)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.7-rc3=
-56-gd9670e2b27245/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.7-rc3-56-gd9670e2b27245
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d9670e2b27245a223eb61a1636e87b169570786c =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/656827a77cef7d9d147e4ac0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.7-rc3-56-gd9670e=
2b27245/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.7-rc3-56-gd9670e=
2b27245/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656827a77cef7d9d147e4=
ac1
        new failure (last pass: v6.7-rc3-43-g3f96bebf018e) =

 =20

