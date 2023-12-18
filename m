Return-Path: <linux-pm+bounces-1316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571C6817796
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 17:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D12F3B21593
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F50014AAB;
	Mon, 18 Dec 2023 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="MNYUFH6F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B81E4A3
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d393e5d325so11308695ad.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 08:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702917333; x=1703522133; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6m7fBfeMucLA4wX1KvwjV20hW/fs5UsteV58uQhPMzs=;
        b=MNYUFH6FvGuG+2ZMgfyTeSalpnGVr85unreYD3d1X7FgOpAQWEj1dr+2YUlauNkkVh
         c9yxfBZzLSt2PoBoWTIzGt2y5IAQ6Kpwg6iGLIrgYBxiRSa701bPtseIXmRMOqzc8h8s
         jLQ2uxN0impn6wwcIjXxY0Ogjhpza7AnVcJVG5FaD2z38HUNKRehTAZEZKyh4geVdHb/
         xPi5fknPWbTEp6tSG0S5nTgLbMpoCUhQ4G0kJamNoq87DsJbKzGW11lKU+AYVObGVKFT
         p1wMSc19zcY2i/C+814oO28dXAEU/3Ewl3CXIMM1QM6lPx1D52G7GFnbm+jIl/BvlAQN
         N26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917333; x=1703522133;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6m7fBfeMucLA4wX1KvwjV20hW/fs5UsteV58uQhPMzs=;
        b=YZwzCWAQlyajcICUL9FA2KK3ORgH1nnPC5AuaGLFTPy5/rM0QAlZEU+J6x0B8n0rVA
         JuONX5apb4ANv3rB8uTPiwGfGs81OZJ5itmfbzJRepu4OSXdIdi9Mk83DcWi9lstX0HN
         N82Bc25niXJkaXTcV8TuPOAKKi3/wd8otUPSBLkQrutELxkrhq8MQARnqO2fziusR4E4
         riaW4C+2vxbP0EdFlXmD+W9AxPpO0a102pe48IEye2Kn2RwYbZ/23xFxQ3rJnCzmJdZ0
         Sf4NPWr224PGdeP/eXelsGYWYbw0xG6Q4XBHJJOLW88laWReRZcrYM3tGh1h2NvH5FTb
         2gSg==
X-Gm-Message-State: AOJu0YzYg2txEWGr0NLamERqzqaODOJ2VvTpDeTvOknZi504mNkHPNvc
	PEBvta6FpOQ3nEnfIsmPZa0PDA==
X-Google-Smtp-Source: AGHT+IH0DP1mGoZIxznxGKwHzRSBLw6TmGFRKK6rn8lpcu0CDZRbGhdXinetjYijUM4YLjnjx/9AUQ==
X-Received: by 2002:a17:902:b197:b0:1d0:6ffd:6e66 with SMTP id s23-20020a170902b19700b001d06ffd6e66mr8031904plr.94.1702917333018;
        Mon, 18 Dec 2023 08:35:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001d1cd7e4ad2sm19162633plf.125.2023.12.18.08.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:35:32 -0800 (PST)
Message-ID: <658074d4.170a0220.36a76.95a1@mx.google.com>
Date: Mon, 18 Dec 2023 08:35:32 -0800 (PST)
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
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.7-rc6-87-gfbcc41b787013
Subject: pm/testing baseline: 37 runs,
 1 regressions (v6.7-rc6-87-gfbcc41b787013)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 37 runs, 1 regressions (v6.7-rc6-87-gfbcc41b787013)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.7-rc6=
-87-gfbcc41b787013/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.7-rc6-87-gfbcc41b787013
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fbcc41b78701321b5d7ba64b77bd1c19981d001f =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/658067f281dc6e69a4e13486

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.7-rc6-87-gfbcc41=
b787013/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.7-rc6-87-gfbcc41=
b787013/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658067f281dc6e69a4e13=
487
        new failure (last pass: v6.7-rc5-91-g3b6de08083e1f) =

 =20

