Return-Path: <linux-pm+bounces-35571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8DCBAAD36
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 02:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C021922BE0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 00:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50471C861A;
	Tue, 30 Sep 2025 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F08kBBKZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CAE18871F
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759193515; cv=none; b=BEcC4+QUOrswutpCGnD5Tl7o5U08tlx9Zqcx/x2Fkizxyp1TYHg34L5uTjt33VHFnbyIKFWLS7fGYpZNXNRyKpXu33aJKXFVImMUBs26KxB+oe3u23b5n8BnGzqcW2e8tI1+GC13wu9RyheP2IURrUAERLaRqbkfqBQGfHup5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759193515; c=relaxed/simple;
	bh=T4ISR1GIOkbT9BMWirj+as+5c6tDPDqoXja51DTSV2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=Ra/rhQd96NHSgoWJ+oxTlgH6vnxwHr3mOrzQhajOacIROSI+QDyYoCoXYQ0m4z+eJaJdfXFcxWQHB4Ax4xwHZK0kfOZN+yyASRqLtq1hIwhL5HC3AnCyfBV/RorT8bRl1xM6TpD5tfoqUjlLnA2CpdR/RuFClzPYSLC53b8aPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F08kBBKZ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250930005149epoutp01425901be88c151d6f5bd3b63ff2dba6c~p6S0XIcAv0349803498epoutp01l
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 00:51:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250930005149epoutp01425901be88c151d6f5bd3b63ff2dba6c~p6S0XIcAv0349803498epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759193509;
	bh=9ogVqn3pQ7TBJXc/xpq6DvXIo0NamG6SUGhoitEXyNA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=F08kBBKZTdXZ9frtXPIw35melJSGt3EdS/fa2bTIZV3d0L8+rC/TtsmGffSmqtajL
	 SX+SyzGb1zTlJ4rcYGtMf1pDCGxi0ghsemeJpmafDw4E/Q9eV0mAa5POVxUMx/A3yb
	 Lg5tflLii6PnNpiMaEIICsnaTUqb1EknegRPJgN4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250930005148epcas2p13b5b5974d6039ca2c2edd6afbffeda4c~p6Sz0KEbz0653306533epcas2p1q;
	Tue, 30 Sep 2025 00:51:48 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.210]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cbKJN2W9nz6B9m9; Tue, 30 Sep
	2025 00:51:48 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250930005147epcas2p36e57d022e5c2df908550b920aafd41c0~p6Sy5o6091112811128epcas2p3r;
	Tue, 30 Sep 2025 00:51:47 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250930005147epsmtip25ee377061c0f74467dad29514b78c7f2~p6SyzpvRW1168411684epsmtip2C;
	Tue, 30 Sep 2025 00:51:47 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Henrik Grimler
	<henrik@grimler.se>
Cc: Shin Son <shin.son@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] Add exynosautov920 thermal support
Date: Tue, 30 Sep 2025 09:51:36 +0900
Message-ID: <20250930005139.1424963-1-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250930005147epcas2p36e57d022e5c2df908550b920aafd41c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250930005147epcas2p36e57d022e5c2df908550b920aafd41c0
References: <CGME20250930005147epcas2p36e57d022e5c2df908550b920aafd41c0@epcas2p3.samsung.com>

This patch series adds support for exynosautov920, automotive-grade
processor. Although the exynosautov920's TMU hardware differs slightly
from exisiting platform, its read and calibration logic closely follow
our legacy TMU interface. To prevent runtime and build time errors,
it is kept as a single change rather than being split.

This change merges the new exynosautov920-specific register definitions and
timing parameters into the exynos-tmu driver, ensuring consistent behavior
across all Exynos series. All new code paths have been tested on a
exynosautov920 board and verified to correctly read temperatures and
emulate behavior.

Changes in v6:
- Add a reviewer for the thermal driver patch.

Changes in v5:
- Changed the maximum number of thermal sensors to 15.

Changes in v4:
- Kept 'addtionalProperties: false'.
- Removed the 'samsung,hw-sensor-indices' property in the binding.
- Added the 'samsung,sensors' property in the binding.
- Dropped code-like formatting and rewrote the description in plain,
  hardware-focused language in the commit message.
- Removed the bitmap and replaced the tz_count to sensor_count.

Changes in v3:
- Removed redundant commit message.
- Rephrased the sentences to describe the hardware clearly.
- Restricted sensor indices to V920.
- Set #thermal-sensor-cells per variant.
- Replaced 'additionalProperties' with 'unevaluatedProperties'.
- Removed the duplicate #define and use the original.
- Used lowercase hex in #define.
- Simplified 'temp_to_code' and 'code_to_temp' to one computation
  path by normalizing calib_temp.

Changes in v2:
- Replace the generic property with a vendor-specific one.
- Added an indices property instead of ranges.
- Shortened thermal node name and made them more generic.
- Updated the indices logic accordingly after removing the ranges property.

Shin Son (3):
  dt-bindings: thermal: samsung: Adjust '#thermal-sensor-cells' to 1
  thermal: exynos_tmu: Support new hardware and update TMU interface
  arm64: dts: exynosautov920: Add multiple sensors

 .../thermal/samsung,exynos-thermal.yaml       |  32 +-
 .../boot/dts/exynos/exynosautov920-tmu.dtsi   | 377 ++++++++++++++++++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  31 ++
 drivers/thermal/samsung/exynos_tmu.c          | 322 +++++++++++++--
 4 files changed, 724 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi

-- 
2.50.1


