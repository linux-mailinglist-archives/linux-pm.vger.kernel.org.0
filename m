Return-Path: <linux-pm+bounces-32973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C40B336BF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 08:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2541897BB9
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 06:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6233028751B;
	Mon, 25 Aug 2025 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uAIEGHXm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739CF28724D
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104587; cv=none; b=f19QVUbp4PnZzaqCsEdHcShMkQ1WwgffIMGBFUXi+DxIxUXib7EzIm/DcVF0WW4ekJU99JEYH9Q+NTkZv8vahTXB3EZikgJx0VVuaqdEiDrD4aqtxG0KNUdlSLerpl8Tc0hA42zN0zMD/EOVonaZn0Ev6NIDZKFP1QLwM0/8v9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104587; c=relaxed/simple;
	bh=zwVCNwbrPR8Fz97qVRWHXSwLilO9xALTy7Yg9KAPOC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=KeW8cFtWZ2E8lgIzDtUOTKGe/KKQ4Ip+m4cmqfkbRq2BSwCYXMFk7ZLbpe+okTlr72DQp+OQMwRSVOJDT3wl8ZVZirCjz/fNNOtllTOh6xM9quufYkBrK6VHEUa76wJ8Ap/00gTU+sn4QEW0RYu+mrrL58TVeuegfEZQgpPgKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uAIEGHXm; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250825064937epoutp0209e74ff1883601c526f7b87300ed6ac3~e787-Tv620936409364epoutp02e
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 06:49:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250825064937epoutp0209e74ff1883601c526f7b87300ed6ac3~e787-Tv620936409364epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756104577;
	bh=0zwQfWuay3Ty+3wy9YuLNvvoME7SVXZGWCq6pQVnpEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uAIEGHXma4HZSl2fsbsc3mCLD/zlITFY5Pm8mhXFSOmNs09x4TwdQOjvsEwwfjzKW
	 tgkn9E/M63/X209K326yOMvIYTdz2ODqQjPR7qqRq3YKnJ50WDIq1xoW/AW4W1jRjM
	 6IMdBXTybpqnhecQMz5wbnwE9mzVrROUB9P+Xdik=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20250825064936epcas2p33792ac8d90efc01b8f72a26355bc8127~e787MDXBE2272422724epcas2p3X;
	Mon, 25 Aug 2025 06:49:36 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.36.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4c9Lxq4FB7z6B9mB; Mon, 25 Aug
	2025 06:49:35 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250825064933epcas2p33e2b4566b5911fef8d7127900fc10002~e7845FXJB0891608916epcas2p3q;
	Mon, 25 Aug 2025 06:49:33 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250825064933epsmtip191c5581a57f6f807063d18c0d2c7beb1~e784yJ9FZ1035610356epsmtip1p;
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
Subject: [PATCH 1/3] dt-bindings: thermal: samsung: Add tmu-name and
 sensor-index-ranges properties
Date: Mon, 25 Aug 2025 15:49:27 +0900
Message-ID: <20250825064929.188101-2-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825064929.188101-1-shin.son@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250825064933epcas2p33e2b4566b5911fef8d7127900fc10002
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250825064933epcas2p33e2b4566b5911fef8d7127900fc10002
References: <20250825064929.188101-1-shin.son@samsung.com>
	<CGME20250825064933epcas2p33e2b4566b5911fef8d7127900fc10002@epcas2p3.samsung.com>

The exynosautov920 TMU requires per-sensor interrupt enablement
for its critical trip points.
Add two new DT properties to the Samsung thermal bindings
to support this requirement:

- **tmu-name**: an explicit identifier for each TMU,
		used to skip specific sensors
(e.g., sensor 5 is temporarily disabled on the TMU_SUB1 block).

- **sensor-index-ranges**: defines valid sensor index ranges
			   for the driver’s bitmap in private data,
			   enabling per-sensor interrupt setup and data access.

Signed-off-by: Shin Son <shin.son@samsung.com>
---
 .../thermal/samsung,exynos-thermal.yaml       | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
index 29a08b0729ee..420fb7a944e3 100644
--- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
@@ -8,6 +8,7 @@ title: Samsung Exynos SoC Thermal Management Unit (TMU)
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
+  - Shin Son <shin.son@samsung.com>
 
 description: |
   For multi-instance tmu each instance should have an alias correctly numbered
@@ -27,6 +28,7 @@ properties:
       - samsung,exynos5420-tmu-ext-triminfo
       - samsung,exynos5433-tmu
       - samsung,exynos7-tmu
+      - samsung,exynosautov920-tmu
 
   clocks:
     minItems: 1
@@ -62,11 +64,29 @@ properties:
     minItems: 1
 
   '#thermal-sensor-cells':
-    const: 0
+    enum:
+      - 0
+      - 1
 
   vtmu-supply:
     description: The regulator node supplying voltage to TMU.
 
+  tmu-name:
+    description: The TMU hardware name.
+    $ref: /schemas/types.yaml#/definitions/string-array
+    minItems: 1
+    maxItems: 1
+
+  sensor-index-ranges:
+    description: |
+      Valid Sensor index ranges for the TMU hardware.
+
+      Note:: On the ExynosautoV920 variant, the fifth sensor in the TMU SUB1 is disabled,
+      so the driver skips it when matching by tmu-name.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+
 required:
   - compatible
   - clocks
@@ -131,6 +151,7 @@ allOf:
               - samsung,exynos5250-tmu
               - samsung,exynos5260-tmu
               - samsung,exynos5420-tmu
+              - samsung,exynosautov920-tmu
     then:
       properties:
         clocks:
-- 
2.50.1


