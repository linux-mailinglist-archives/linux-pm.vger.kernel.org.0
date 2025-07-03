Return-Path: <linux-pm+bounces-30049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF72AF7726
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD683AA109
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCF32E9742;
	Thu,  3 Jul 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4+qJx9x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204EB2E8E0B;
	Thu,  3 Jul 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552481; cv=none; b=NVjsScCc4lX2itNMlZr88chnKOuIbmRpyJb0mrgN5eb91VgEiWVOr1yLa/HlgP5CMd667IU4LqNGTh//Tqgh7b9v/e7coq7dqUhm2gIVNxUkhfzjf1UT1LzYaQJ/6QctlijG7lZTMCNH8k9AteyP9V9+gAl6IiCRCBRqqrtEVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552481; c=relaxed/simple;
	bh=zImvd/kgd1afrH/UXH2667AxFgtQy1j88l6X4nP2wM8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LihSi2zsdfiNU/9mtap9p4v3g7Sbuc3aExFagkmDLcSb3y+yu2HkEjNfGddLpCr7eT7MOmJ2qZIk+xRqEAGSprFqZujNzf8lyMKacizgn6myZSOq/2oB2UHCR6swEEDEr3m7sOKc85npKHZ1/wa89q2IxbjGXTtbWIzfWN2lUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4+qJx9x; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553b60de463so6470966e87.3;
        Thu, 03 Jul 2025 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751552477; x=1752157277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FklnJtDo9yeFD4xiZdN1VsVaoDfKdcDRiLzMHURLjos=;
        b=k4+qJx9x1T7RdUSUvkEWLftdx1cMk5VqvTGFmrMDUXe4R7T/UzScLTqD1SO+2E1bk6
         uwp9jSQp9h61i8TCHrGaCGWc+87FakdiaRmF1wwBb0yCmXc8/PdQKk8tjJrt6DNT+ZDt
         Ge7eJCtiQzqriRQEw1dyREB4xthXHuSjL2O9DDkyh5f1OWZ6VcJkWpIm4fJkG7cmoyy+
         5O1S13p/sXliW3mB2MR6740YgNRlCvVBGhEAenfvnt5Qx6AMzOHupXoiDOXFkZvPQ85U
         PZvD9lMM7tg6UZ8bZFBnBBfsAL/meAKAl9RvJkDLR9m/rADDlrlMqqmDixAasgEzIe4a
         r3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552477; x=1752157277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FklnJtDo9yeFD4xiZdN1VsVaoDfKdcDRiLzMHURLjos=;
        b=crVUqfuXYla7J65jAYUdoF6U2jNvXnButkndBfDPhh41bqwQaAiB9GW4jsII0Ppdlg
         5+bP3w75UnF+7bU6ZJoFhqQfphW1KJgjHfEFzD+nSDRhnKuvE5NniRh4I8R74/IMP6g6
         OhwN62o7NLnpYHB1N0hIfv2pdGpZiS1BOwfEqIxIpbOwY+vJLKicSLgAjx2u3bEzx7Ro
         pDmS9rmLvfHyRCii3fo7o1MT9JDEmE2CiGTfer5A8h35k5J5xbPujhjloC6Pdg2Y8X/M
         Idv1RYb0g1zE/8viKP8p+CHRZh86pS+ssIJtxOwK+79hTGcBvyLmgtsuz6XWUi4ELYJt
         Y4fw==
X-Forwarded-Encrypted: i=1; AJvYcCUScmyho3X0rxE48ra2pFFpuaB5VV4LiQ1AwNtD8G9fRin/cAaHVIou+bVxZz4OPqrUvrAQ2SyvVMOe@vger.kernel.org, AJvYcCVJgOCqQGPtfdQ2CiBLLnpyJqLgmYSIpxR8Ri0oLKfta7n96hKqwRf4BSqLNOuU0+8oxbiNe6COQBc=@vger.kernel.org, AJvYcCVv3Aw/bBc/88BdH56SrR1x7BncHYBUgqS8A3mRsg7gw2odKWnCyPO7RVoqmXDYkWHWY5UT7mKNJEHFLQ83@vger.kernel.org
X-Gm-Message-State: AOJu0YzTMkQVGnxZIOF5ATZn9n+arX2CoSeAbvflAtOoisGhOAo1SLgL
	kIiRZeaN9uS9F9odT2kkbH7/YU185uN95Te3riSouRxM68n9yiCtSrh8
X-Gm-Gg: ASbGncsc3KICjCMWfmuOQbd8RHtfYDlDi/EI3WT6cQjR6359TXeTKAMFsEu6X/KdgGS
	PMPieegUAjhxTbnxxQJJfHZ1vO0ojBUtyNBaUT1rl1OW1Xv8bFzxh++H2LUBrDXmMisVjDEZSWs
	o0mgM4X7DDaCaQtWYopUIMFyTidGQ8BSuR2toeiC1vo+a9Df1Cv6dKiETkDqJohYK5RWbJA1DjO
	lERvLkG4R4M7c6g3XjdAx9dqfFfKTH/rHZAvE0w7MwahFmWkCco2T6u03Saejh/640Br/W9iMIn
	3Z9SlmtTsy6OSAey5vGYigTAacWSASa2hvpWArthLjbuNCFBYrYCvJENNnOL+bYtMdXeGs0=
X-Google-Smtp-Source: AGHT+IFUX1eZbzcysBzHHtBsEBGjLX6NVKG8N8wt7URL6mkGsrdwM/ImOqWq0Nxkz3QPURabSYjy1A==
X-Received: by 2002:a05:6512:2307:b0:553:2868:6355 with SMTP id 2adb3069b0e04-5562ee3f0d8mr1549077e87.18.1751552476789;
        Thu, 03 Jul 2025 07:21:16 -0700 (PDT)
Received: from localhost.localdomain ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2a861esm2483058e87.97.2025.07.03.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:21:16 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/8] Allwinner: A523: add support for A523 THS0/1 controllers
Date: Thu,  3 Jul 2025 22:20:32 +0800
Message-ID: <20250703142040.2639742-1-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

This patch series adds temperature sensor support for the Allwinner A523
family of processors (same die with H728/A527/T527)

Changes:
1) dt-bindings: nvmem: SID: Add binding for A523 SID controller
 - added new patch

2) dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
 - changed clock order
 - added additional nvmem cell with calibration data
 - added requirements for new controllers
 - added description

3) thermal/drivers/sun8i: add gpadc clock
 - removed unnecessary call to clk_prepare_enable() since
 devm_clk_get_enabled()includes this

4) thermal/drivers/sun8i: replace devm_reset_control_get to
 - original function replaced with devm_reset_control_get_shared_deasserted()
 - removed some of the repetitive code executed by 
 devm_reset_control_get_shared_deasserted()

5) thermal/drivers/sun8i: get calibration data from two nvmem cells
 - added possibility to get calibration data from two independent cells

6) thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
 - removed magic digits
 - changed description of calibration data procedure for A523
 - changed numbers of array elements with calibration data

7) arm64: dts: allwinner: A523: Add SID controller node
 - fix typo (sun50i->sun55i)

8) arm64: dts: allwinner: A523: Add thermal sensors and zones
 - cell with calibration data divided into two
 - added passive trips for gpu
 - added information that information obtained from BSP

v1: https://lore.kernel.org/linux-sunxi/20250411003827.782544-1-iuncuim@gmail.com

Mikhail Kalashnikov (8):
  dt-bindings: nvmem: SID: Add binding for A523 SID controller
  dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
  thermal/drivers/sun8i: add gpadc clock
  thermal/drivers/sun8i: replace devm_reset_control_get to
    devm_reset_control_get_shared_deasserted
  thermal/drivers/sun8i: get calibration data from two nvmem cells
  thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
  arm64: dts: allwinner: A523: Add SID controller node
  arm64: dts: allwinner: A523: Add thermal sensors and zones

 .../nvmem/allwinner,sun4i-a10-sid.yaml        |   1 +
 .../thermal/allwinner,sun8i-a83t-ths.yaml     |  49 +++-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 162 ++++++++++++
 drivers/thermal/sun8i_thermal.c               | 240 ++++++++++++++----
 4 files changed, 406 insertions(+), 46 deletions(-)

-- 
2.49.0


