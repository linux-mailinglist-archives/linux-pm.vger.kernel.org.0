Return-Path: <linux-pm+bounces-35143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A9B8EEC4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 06:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111211897CA8
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500862F0690;
	Mon, 22 Sep 2025 04:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JFg9q5lp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DB2D94A2
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 04:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758514755; cv=none; b=XjEVJbttM5a65gvxXEVYHlbACTEbps0L/UsXdVa2lVKYRxSjg/hAszrnnOg/OVjhTDVuwlVdPzXKx9hX17sQDo2y1qvTpQ9WoveilshYnChiwvAJslGR90GE9IpSwjt/pakz66mk/DTGOKF/nwn+k3Gqx4tNLMIH8SazwfCUN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758514755; c=relaxed/simple;
	bh=9mQfF97iUqTuIDpHjmThzhD8K+3px3mB/MpG9m45V0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=G7fCIFnUIvbop/IwuDCDp05mZ1cy5ZfLVDvW2g2guPTwXv7KkF/bRCtdWtDpUfGb1x2uvvj3gieX+H4atnhdBuzn36e2gbYIhg7phGi8K7e5rPkUVVbsxRsFd1cYzKbMrX5HQxD00nScNZyQLzpW9wBAeHHONfc4vvGMHt3l+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JFg9q5lp; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250922041903epoutp022b4bf283b9bacc530103892a3dec17d1~nf9encMnh0983409834epoutp02O
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 04:19:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250922041903epoutp022b4bf283b9bacc530103892a3dec17d1~nf9encMnh0983409834epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758514743;
	bh=/rbB9Qe0PyGkKDgc61OqgDnmcVxYp84SH6KpmgRnDqk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=JFg9q5lp2AvZG+s2v9yqSJYiyLRqq5TGmjseJ4vuImH8CIb8ZNXzn5UmPJZ9F2Bru
	 rXLgQdtKScCD/c1Ry5UUKvrselcHHOD+EqC/h51o5zTypIkyrSsQEXRqCRmm7URsUo
	 BDmidaatle3pKocdAQ+O7/nUeluXcvC9lVV0M+hg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20250922041903epcas2p26df62412d40a7074b3c1ff6923629832~nf9eF2NSc1765817658epcas2p2D;
	Mon, 22 Sep 2025 04:19:03 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cVVHB3pytz6B9mB; Mon, 22 Sep
	2025 04:19:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250922041901epcas2p2d3d164ea9421e57d9327f29782f955df~nf9c3FJsN1765817658epcas2p2C;
	Mon, 22 Sep 2025 04:19:01 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250922041901epsmtip2d12fca8c5826a6ab1078b93f6091d011~nf9cxel3W0606606066epsmtip2I;
	Mon, 22 Sep 2025 04:19:01 +0000 (GMT)
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
Subject: [PATCH v4 0/3] Add exynosautov920 thermal support
Date: Mon, 22 Sep 2025 13:18:54 +0900
Message-ID: <20250922041857.1107445-1-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250922041901epcas2p2d3d164ea9421e57d9327f29782f955df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250922041901epcas2p2d3d164ea9421e57d9327f29782f955df
References: <CGME20250922041901epcas2p2d3d164ea9421e57d9327f29782f955df@epcas2p2.samsung.com>

This change merges the new exynosautov920-specific register definitions and
timing parameters into the exynos-tmu driver, ensuring consistent behavior
across all Exynos series. All new code paths have been tested on a
exynosautov920 board and verified to correctly read temperatures and
emulate behavior.

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


