Return-Path: <linux-pm+bounces-32970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D3B336B8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 08:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C2E3A26C6
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 06:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2361C28726B;
	Mon, 25 Aug 2025 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Uz8SK3iK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB3285078
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104586; cv=none; b=Tpnr7nG3yJJ8AMDaMI3iwvUuUkcLPzItk8jOR/YQViEjj0q5G2bdowmDsFbfV4C786qZB2wsZDANzFN0/gZBE1PIxR9ccvPl7anhzlMekV4WvBa0pjakh5Ysn7qL+r3tySqLT8QaLS9A7ZjieKWA/k4U/AwZbpGl/ldAze4/gLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104586; c=relaxed/simple;
	bh=fGXjVR47xmXCnKHaXH1JnYbajwgQhftGMW1OIzrqk/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=E65jcHWweIKywJ9j+xvlpsHzDcPpv5/M2jf5namcglWmRe1jLiljyeLOmtOVrtbKd9pudh7psNabrciSdAPeuvoIVGcV8E1s3FWr4/XhDsUxFNXcTIQtcILWGWBJJc0bsIEJlM3BSm+y49JhSvVukYlA14hef1hNMWnf8bri62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Uz8SK3iK; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250825064935epoutp03a57d7f300a0ca0aa0fd3b9b3896647c3~e786rE0md2210722107epoutp03X
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 06:49:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250825064935epoutp03a57d7f300a0ca0aa0fd3b9b3896647c3~e786rE0md2210722107epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756104575;
	bh=BvCmax7ffb3cXbAcpyJB3pHTDlaFx7rbmUGg3s54BhU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Uz8SK3iKcH3r2j4BEnzA0IjAtagCHegDJNfSIMtrcsiUPHGm7IKSoG5mbdAIY8HQD
	 7zOikww4xXtW1PpGqwAGgTLICJbTksrYKX+FGHIz5qpzfie0fPNObHpu8Z/H5Ot2GB
	 OnV7Vhtp1d63OLe8eYU9fEHT+wFEZYTxLrCtPV2c=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20250825064934epcas2p3d2a77215f5e4ca5413e5ae1529090e68~e786FGRi72272422724epcas2p3R;
	Mon, 25 Aug 2025 06:49:34 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.36.99]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c9Lxp2fslz6B9mF; Mon, 25 Aug
	2025 06:49:34 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250825064933epcas2p37665fae32f51b04a43e5395d76759143~e784xdhu70900609006epcas2p3a;
	Mon, 25 Aug 2025 06:49:33 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250825064933epsmtip128240768c19a2d7ff622f42d9a52d82d~e784qqAbX0875908759epsmtip1f;
	Mon, 25 Aug 2025 06:49:33 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Shin Son <shin.son@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add exynosautov920 thermal support
Date: Mon, 25 Aug 2025 15:49:26 +0900
Message-ID: <20250825064929.188101-1-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250825064933epcas2p37665fae32f51b04a43e5395d76759143
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250825064933epcas2p37665fae32f51b04a43e5395d76759143
References: <CGME20250825064933epcas2p37665fae32f51b04a43e5395d76759143@epcas2p3.samsung.com>

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

Shin Son (3):
  dt-bindings: thermal: samsung: Add tmu-name and sensor-index-ranges
    properties
  thermal: exynos_tmu: Support new hardware and update TMU interface
  arm64: dts: exynosautov920: Add tmu hardware binding

 .../thermal/samsung,exynos-thermal.yaml       |  23 +-
 .../boot/dts/exynos/exynosautov920-tmu.dtsi   |  92 +++++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  34 ++
 drivers/thermal/samsung/exynos_tmu.c          | 336 ++++++++++++++++--
 4 files changed, 447 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi

-- 
2.50.1


