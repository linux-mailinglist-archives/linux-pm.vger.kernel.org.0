Return-Path: <linux-pm+bounces-33688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAFDB416D5
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 09:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BB41BA2BDB
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 07:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B62DEA73;
	Wed,  3 Sep 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c7/JdKyn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615372639
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885021; cv=none; b=YuhWR3Ito6Bvtbb6DWR6hDSOtpCBfAaT8nFqskSlld4er5cOcGO4Y8QBzzBjImdVa4hzz8VA+teq3+BE933DZHsOYvnSZR+e/FuJhLtA8rnhlvJ9oPKcB3/u2no3PDKBdi8K+8tJe3rGhmSjrDvDxfsYCy6a5CCaUF3G/Gpygdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885021; c=relaxed/simple;
	bh=oI9ruJXE3Tfc8ztXuSdTu88fF7VUxQLNLARHE417v/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=gQk+fIFKBP5/+Umjo+ThPYWBCq3yBpXkDZRFmr3vr3Hg8pYZcovMvfbs1xBy2xtjI/ugEkf4Yi2bKj/lQmmCIADdOFW2vrG1DfN9JgNtTuj7z8NsnJRGq21p40m2NAJnaUQ6m68dXe3FD/AgD1qPIpvyNUfjUaDzk5saljGFNLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=c7/JdKyn; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250903073655epoutp0230e1b9a765fea8032d6c3acdb957bca7~htZzuSSF-0737707377epoutp02b
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 07:36:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250903073655epoutp0230e1b9a765fea8032d6c3acdb957bca7~htZzuSSF-0737707377epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756885015;
	bh=C12f3ohxzfB7ELhKTKFriefQ22srh7Dm7SaUfSw9ItU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=c7/JdKyn/F49h+qTEcpbCur/8gcRIn6vSjY5zLeR+CxRp+/zMwcPToPlAv7kKfXv5
	 /kSXJz8riaYpfO/GsDBr6dZ2chwTdTaYLWgC+lXQGZkmqCe8VgZ3h7VYH8x79B74rv
	 mw5ruNare//yysMwFJvmTeew2LWX1QYstdoJmtAQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20250903073654epcas2p2fc7ce62b8c242ddfec893d303b523a5e~htZzMZIvH0888008880epcas2p2L;
	Wed,  3 Sep 2025 07:36:54 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.99]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cGvZG0kxsz2SSKn; Wed,  3 Sep
	2025 07:36:54 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250903073653epcas2p49e89e5face6059bc8a58f212faa835d1~htZx8PTcr0925409254epcas2p4v;
	Wed,  3 Sep 2025 07:36:53 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250903073653epsmtip27f0a34b766443223f32830a2ec8775eb~htZx3tggi2959129591epsmtip2E;
	Wed,  3 Sep 2025 07:36:53 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Shin Son <shin.son@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add exynosautov920 thermal support
Date: Wed,  3 Sep 2025 16:36:31 +0900
Message-ID: <20250903073634.1898865-1-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250903073653epcas2p49e89e5face6059bc8a58f212faa835d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903073653epcas2p49e89e5face6059bc8a58f212faa835d1
References: <CGME20250903073653epcas2p49e89e5face6059bc8a58f212faa835d1@epcas2p4.samsung.com>

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

Changes in v2:
- Replace the generic property with a vendor-specific one.
- Added an indices property instead of ranges.
- Shortened thermal node name and made them more generic.
- Updated the indices logic accordingly after removing the ranges property.

Shin Son (3):
  dt-bindings: thermal: samsung: Add tmu-name and sensor-index-ranges
    properties
  thermal: exynos_tmu: Support new hardware and update TMU interface
  arm64: dts: exynosautov920: Add tmu hardware binding

 .../thermal/samsung,exynos-thermal.yaml       |  16 +-
 .../boot/dts/exynos/exynosautov920-tmu.dtsi   |  97 +++++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  31 ++
 drivers/thermal/samsung/exynos_tmu.c          | 340 ++++++++++++++++--
 4 files changed, 446 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi

-- 
2.50.1


