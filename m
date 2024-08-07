Return-Path: <linux-pm+bounces-11967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF3194A362
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 10:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692DF1F23F4C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0B71D2788;
	Wed,  7 Aug 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NOJBF9RD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1451CB325
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020562; cv=none; b=FKm3ZBPNEj1z1vkSfgcaabwz0Ik16pPvgqouVWGQFBMl9SgPnoOSj86S6LWc0CpJiwh0F9MhyaO7yoER6K0265qstiNg8rRD28xddEihaTMpxj1WwXyQau9KmufY0PhmeTL9lxJFO6NuldMymWizvTWZumXFW3fsD7DrJTD4DO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020562; c=relaxed/simple;
	bh=SOGMsrjPkiU3PLcJY/glIJLauRZTzqveqjccNNZRE/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=f2aZzeLw6d8WRcuk2kuO/zxL82z0ewYrGONPTLCxmqQIvY6bRQ6in6YyBKCAEOPEIcpHxFPtbKlU/Ga4/XfBAY6UqnINkakw28nwQI+10zJozuD2VjorS1vsEplyA2Ax+T9gFvvXGYkGkStE6payoXL+lUOytNdwGHI/xefGRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NOJBF9RD; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240807084917euoutp020e479a43323e16a126404d56de1d2e04~pZhFkbtWP3051330513euoutp02G
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240807084917euoutp020e479a43323e16a126404d56de1d2e04~pZhFkbtWP3051330513euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723020557;
	bh=wWDOc77i40xWqwppTMXqliBmUhNF+BAGs3t/PtPEG68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOJBF9RDQ79QkJ/XcxQ98p0IU28WjOCdW1GDHpn22B5c6Oluff0SCZJfELlosDcbG
	 bnM7x3vD0zkLutTbgEAymREDGAAVqBeOguXnc+gtvkYR1u1dWWZIOnEp/+tT4FQadk
	 7JSlK9uUqJ8ITqNdRFT+iZVZcq0g9q/YES5GkbPo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240807084916eucas1p1b0195611cf05627c5670837bd20b771c~pZhE_Cwvf2890928909eucas1p13;
	Wed,  7 Aug 2024 08:49:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 02.12.09624.C0533B66; Wed,  7
	Aug 2024 09:49:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240807084916eucas1p2171af1654fc2e2701726eb8bf9869cfd~pZhEcizDx2792927929eucas1p2Y;
	Wed,  7 Aug 2024 08:49:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240807084916eusmtrp18829566533f0c7b5d26d1f7e745dee82~pZhEb1UjN0287102871eusmtrp1S;
	Wed,  7 Aug 2024 08:49:16 +0000 (GMT)
X-AuditID: cbfec7f2-488bda8000002598-3e-66b3350ceb27
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id AD.DC.09010.B0533B66; Wed,  7
	Aug 2024 09:49:15 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240807084915eusmtip28e26704722ffd0b3a84f168bd082ccd9~pZhDZnTdQ1686216862eusmtip2q;
	Wed,  7 Aug 2024 08:49:14 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, Anand
	Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 5/6] drivers/thermal/exynos: add initial Exynos850
 support
Date: Wed,  7 Aug 2024 10:48:24 +0200
Message-ID: <20240807084829.1037303-6-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240807084829.1037303-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djP87o8ppvTDL5Ol7d4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVcXHeXZaCBYkVC+9+ZWxgfBHYxcjJISFg
	InFmXhdzFyMXh5DACkaJjX03GCGcL4wS0x90sINUCQl8ZpT49jIepuPvud9MEEXLGSUaH++H
	clqZJO7M7mEDqWITMJB48GYZO0hCRGAxUNWPd6wgDrPAE2aJn68WM4JUCQv4S5w88wnMZhFQ
	lTjW9ZgVxOYVsJO4+6yXCWKfvETv/j4wm1PAXmJJdzcTRI2gxMmZT1hAbGagmuats8G+kBCY
	zimx+/FNNohmF4nOJxdZIGxhiVfHt7BD2DISpyf3QMXzJWZsfg9kcwDZFRJ3D3pBmNYSH88w
	g5jMApoS63fpQxQ7Sky6f4AZooJP4sZbQYgD+CQmbZsOFeaV6GgTgqhWlTi+ZxIzhC0t8aTl
	NtRPHhJb121km8CoOAvJK7OQvDILYe8CRuZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsY
	gWnu9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRHe5vBNaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1MTTPcY1e4X/J5tvmP/b2Ssi6hdYHvYzmDNQ+KSYUv
	MXpzbd6BWd+nePo35ti/f9V281DLQsPSnpT/VwWZk2tlZlq+nBKg1VXYdIcx0WXn9Mxpulyl
	R46v45wY0y/5+JuBZve6xV7vbmdzstQ8l9ysyqY8qzWb66j+tScNTpdd30m1Xp3Lm1kUslJC
	Xub7qYWXi5at6yiTMvn49vyPhqyVLWK2e5QLd02Zmb6FM1+Y0yMzrs+cLfjNBBbWLtNIvqXW
	lhGN/LIHty9227xpYpyOsdKx5XcT5LecePRv7oaPfW8u/9NRu67M+/vuyxy15b5R/Lvvv45l
	vPafd1HPRXHNPb2L2L7WFwbu7u2fEKOuxFKckWioxVxUnAgAfBUsfeIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7rcppvTDB48trJ4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXcXHeXZaCBYkVC+9+ZWxgfBHYxcjJISFgIvH33G+mLkYuDiGBpYwSzbeu
	sEMkpCUOf5kCZQtL/LnWxQZiCwk0M0lsPq4HYrMJGEg8eLMMrEZEYDmjxOZ2DxCbWeAds0T7
	eT8QW1jAV+LH77NMIDaLgKrEsa7HrCA2r4CdxN1nvUwQ8+Ulevf3gdmcAvYSS7q7mSB22Un0
	ftnJDFEvKHFy5hMWiPnyEs1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYiO94sTc4tK8dL3k
	/NxNjMCI3Hbs55YdjCtffdQ7xMjEwXiIUYKDWUmEtzl8U5oQb0piZVVqUX58UWlOavEhRlOg
	uycyS4km5wNTQl5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5PT
	i7uVJYmqsiZGEk6v/Fl9JvzSM8psSNyq9X77UqEXP3aW2v79uvn0/8C72p883vXcvKAh/VFX
	nKvjdvhG5lN3XQ90rdn2StFTfX/givqYlTm+ew0W3evZXDFNuKHdPO9Wef7S3w9255/Yq/HL
	/J17qQ9T9KQsv8mH7ptF9rDLca8xP3TwVgdb9F/b2zO3dAlO6i+r2Cjl9bFeqmzL/ZY5sS1M
	Gq9qjBZ5vGnf523wdxnfh1+mG3/tuD/97I7jV+PvVtyb/tAk7FEIQ1LKnvWS0e/2ckjli5r3
	8jzn4FNfYSz3roP5UkjKTd+Dx15632c3nfQjpazZKy/R5B3bzGJXzs9HNJd9W1B0MPnPiZdK
	LMUZiYZazEXFiQBQ3mhfUQMAAA==
X-CMS-MailID: 20240807084916eucas1p2171af1654fc2e2701726eb8bf9869cfd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240807084916eucas1p2171af1654fc2e2701726eb8bf9869cfd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240807084916eucas1p2171af1654fc2e2701726eb8bf9869cfd
References: <20240807084829.1037303-1-m.majewski2@samsung.com>
	<CGME20240807084916eucas1p2171af1654fc2e2701726eb8bf9869cfd@eucas1p2.samsung.com>

This is loosely adapted from an implementation available at
https://gitlab.com/Linaro/96boards/e850-96/kernel/-/blob/android-exynos-4.14-linaro/drivers/thermal/samsung/exynos_tmu.c
Some differences from that implementation:
- unlike that implementation, we do not use the ACPM mechanism, instead
  we just access the registers, like we do for other SoCs,
- the SoC is supposed to support multiple sensors inside one unit. The
  vendor implementation uses one kernel device per sensor, we would
  probably prefer to have one device for all sensors, have
  #thermal-sensor-cells = <1> and so on. We implemented this, but we
  could not get the extra sensors to work on our hardware so far. This
  might be due to a misconfiguration and we will probably come back to
  this, however our implementation only supports a single sensor for
  now,
- the vendor implementation supports disabling CPU cores as a cooling
  device. We did not attempt to port this, and this would not really fit
  this driver anyway.

Additionally, some differences from the other SoCs supported by this
driver:
- we do not really constrain the e-fuse information like the other SoCs
  do (data->{min,max}_efuse_value). In our tests, those values (as well
  as the raw sensor values) were much higher than in the other SoCs, to
  the degree that reusing the data->{min,max}_efuse_value from the other
  SoCs would cause instant critical temperature reset on boot,
- this SoC provides more information in the e-fuse data than other SoCs,
  so we read some values inside exynos850_tmu_initialize instead of
  hardcoding them in exynos_map_dt_data.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: rename and reorder some registers, use the correct register
  offset for EXYNOS850_TMU_REG_AVG_CON, make the clock required,
  additionally do some minor style changes.

 drivers/thermal/samsung/exynos_tmu.c | 191 +++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 087a09628e23..2618a81fca53 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -117,6 +117,41 @@
 #define EXYNOS7_EMUL_DATA_SHIFT			7
 #define EXYNOS7_EMUL_DATA_MASK			0x1ff
 
+/* Exynos850 specific registers */
+#define EXYNOS850_TMU_REG_CURRENT_TEMP0_1	0x40
+#define EXYNOS850_TMU_REG_THD_TEMP0_RISE	0x50
+#define EXYNOS850_TMU_REG_THD_TEMP0_FALL	0x60
+
+#define EXYNOS850_TMU_TRIMINFO_SHIFT		4
+#define EXYNOS850_TMU_TRIMINFO_OFFSET(n) \
+	(EXYNOS_TMU_REG_TRIMINFO + (n) * EXYNOS850_TMU_TRIMINFO_SHIFT)
+#define EXYNOS850_TMU_T_TRIM0_SHIFT		18
+
+#define EXYNOS850_TMU_REG_CONTROL1		0x24
+#define EXYNOS850_TMU_LPI_MODE_MASK		1
+#define EXYNOS850_TMU_LPI_MODE_SHIFT		10
+
+#define EXYNOS850_TMU_REG_COUNTER_VALUE0	0x30
+#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK	0xffff
+#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT	0
+
+#define EXYNOS850_TMU_REG_COUNTER_VALUE1	0x34
+#define EXYNOS850_TMU_CLK_SENSE_ON_MASK		0xffff
+#define EXYNOS850_TMU_CLK_SENSE_ON_SHIFT	16
+
+#define EXYNOS850_TMU_REG_AVG_CON		0x38
+#define EXYNOS850_TMU_AVG_MODE_MASK		0x7
+#define EXYNOS850_TMU_DEM_ENABLE		BIT(4)
+
+#define EXYNOS850_TMU_REG_TRIM0			0x3c
+#define EXYNOS850_TMU_TRIM0_MASK		0xf
+#define EXYNOS850_TMU_VBEI_TRIM_SHIFT		8
+#define EXYNOS850_TMU_VREF_TRIM_SHIFT		12
+#define EXYNOS850_TMU_BGRI_TRIM_SHIFT		20
+
+#define EXYNOS850_TMU_TEM1051X_SENSE_VALUE	0x028a
+#define EXYNOS850_TMU_TEM1456X_SENSE_VALUE	0x0a28
+
 #define EXYNOS_FIRST_POINT_TRIM			25
 #define EXYNOS_SECOND_POINT_TRIM		85
 
@@ -134,6 +169,7 @@ enum soc_type {
 	SOC_ARCH_EXYNOS5420_TRIMINFO,
 	SOC_ARCH_EXYNOS5433,
 	SOC_ARCH_EXYNOS7,
+	SOC_ARCH_EXYNOS850,
 };
 
 /**
@@ -232,12 +268,14 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 
 static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 {
-	u16 tmu_temp_mask =
-		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
-						: EXYNOS_TMU_TEMP_MASK;
-	int tmu_85_shift =
-		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_SHIFT
-						: EXYNOS_TRIMINFO_85_SHIFT;
+	u16 tmu_temp_mask = (data->soc == SOC_ARCH_EXYNOS7 ||
+			     data->soc == SOC_ARCH_EXYNOS850) ?
+				    EXYNOS7_TMU_TEMP_MASK :
+				    EXYNOS_TMU_TEMP_MASK;
+	int tmu_85_shift = (data->soc == SOC_ARCH_EXYNOS7 ||
+			    data->soc == SOC_ARCH_EXYNOS850) ?
+				   EXYNOS7_TMU_TEMP_SHIFT :
+				   EXYNOS_TRIMINFO_85_SHIFT;
 
 	data->temp_error1 = trim_info & tmu_temp_mask;
 	if (!data->temp_error1 ||
@@ -587,6 +625,114 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
 	sanitize_temp_error(data, trim_info);
 }
 
+static void exynos850_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	exynos_tmu_update_temp(data, EXYNOS850_TMU_REG_THD_TEMP0_FALL + 12, 0,
+			       temp);
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT + 0, true);
+}
+
+static void exynos850_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	exynos_tmu_update_temp(data, EXYNOS850_TMU_REG_THD_TEMP0_RISE + 12, 16,
+			       temp);
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, true);
+}
+
+static void exynos850_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT + 0, false);
+}
+
+static void exynos850_tmu_disable_high(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, false);
+}
+
+static void exynos850_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	exynos_tmu_update_temp(data, EXYNOS850_TMU_REG_THD_TEMP0_RISE + 0, 16,
+			       temp);
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_CONTROL,
+			      EXYNOS_TMU_THERM_TRIP_EN_SHIFT, true);
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 7, true);
+}
+
+static void exynos850_tmu_initialize(struct platform_device *pdev)
+{
+	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
+	u32 cal_type, avg_mode, reg, bgri, vref, vbei;
+
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(0));
+	cal_type = (reg & EXYNOS5433_TRIMINFO_CALIB_SEL_MASK) >>
+		   EXYNOS5433_TRIMINFO_CALIB_SEL_SHIFT;
+	data->reference_voltage = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
+				  EXYNOS_TMU_REF_VOLTAGE_MASK;
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(1));
+	data->gain = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
+		     EXYNOS_TMU_BUF_SLOPE_SEL_MASK;
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(2));
+	avg_mode = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
+		   EXYNOS850_TMU_AVG_MODE_MASK;
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(3));
+	bgri = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) & EXYNOS850_TMU_TRIM0_MASK;
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(4));
+	vref = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) & EXYNOS850_TMU_TRIM0_MASK;
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(5));
+	vbei = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) & EXYNOS850_TMU_TRIM0_MASK;
+
+	data->cal_type = cal_type == EXYNOS5433_TRIMINFO_TWO_POINT_TRIMMING ?
+				 TYPE_TWO_POINT_TRIMMING :
+				 TYPE_ONE_POINT_TRIMMING;
+
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(0));
+	sanitize_temp_error(data, reg);
+
+	dev_info(&pdev->dev, "Calibration type is %d-point calibration\n",
+		 cal_type ? 2 : 1);
+
+	reg = readl(data->base + EXYNOS850_TMU_REG_AVG_CON);
+	reg &= ~EXYNOS850_TMU_AVG_MODE_MASK;
+	reg &= ~EXYNOS850_TMU_DEM_ENABLE;
+	if (avg_mode) {
+		reg |= avg_mode;
+		reg |= EXYNOS850_TMU_DEM_ENABLE;
+	}
+	writel(reg, data->base + EXYNOS850_TMU_REG_AVG_CON);
+
+	reg = readl(data->base + EXYNOS850_TMU_REG_COUNTER_VALUE0);
+	reg &= ~(EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK
+		 << EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT);
+	reg |= EXYNOS850_TMU_TEM1051X_SENSE_VALUE
+	       << EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT;
+	writel(reg, data->base + EXYNOS850_TMU_REG_COUNTER_VALUE0);
+
+	reg = readl(data->base + EXYNOS850_TMU_REG_COUNTER_VALUE1);
+	reg &= ~(EXYNOS850_TMU_CLK_SENSE_ON_MASK
+		 << EXYNOS850_TMU_CLK_SENSE_ON_SHIFT);
+	reg |= EXYNOS850_TMU_TEM1051X_SENSE_VALUE
+	       << EXYNOS850_TMU_CLK_SENSE_ON_SHIFT;
+	writel(reg, data->base + EXYNOS850_TMU_REG_COUNTER_VALUE1);
+
+	reg = readl(data->base + EXYNOS850_TMU_REG_TRIM0);
+	reg &= ~(EXYNOS850_TMU_TRIM0_MASK << EXYNOS850_TMU_BGRI_TRIM_SHIFT);
+	reg &= ~(EXYNOS850_TMU_TRIM0_MASK << EXYNOS850_TMU_VREF_TRIM_SHIFT);
+	reg &= ~(EXYNOS850_TMU_TRIM0_MASK << EXYNOS850_TMU_VBEI_TRIM_SHIFT);
+	reg |= bgri << EXYNOS850_TMU_BGRI_TRIM_SHIFT;
+	reg |= vref << EXYNOS850_TMU_VREF_TRIM_SHIFT;
+	reg |= vbei << EXYNOS850_TMU_VBEI_TRIM_SHIFT;
+	writel(reg, data->base + EXYNOS850_TMU_REG_TRIM0);
+
+	reg = readl(data->base + EXYNOS850_TMU_REG_CONTROL1);
+	reg &= ~(EXYNOS850_TMU_LPI_MODE_MASK << EXYNOS850_TMU_LPI_MODE_SHIFT);
+	writel(reg, data->base + EXYNOS850_TMU_REG_CONTROL1);
+}
+
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -676,7 +822,8 @@ static u32 get_emul_con_reg(struct exynos_tmu_data *data, unsigned int val,
 
 		val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
 		val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
-		if (data->soc == SOC_ARCH_EXYNOS7) {
+		if (data->soc == SOC_ARCH_EXYNOS7 ||
+		    data->soc == SOC_ARCH_EXYNOS850) {
 			val &= ~(EXYNOS7_EMUL_DATA_MASK <<
 				EXYNOS7_EMUL_DATA_SHIFT);
 			val |= (temp_to_code(data, temp) <<
@@ -706,7 +853,8 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
 		emul_con = EXYNOS5260_EMUL_CON;
 	else if (data->soc == SOC_ARCH_EXYNOS5433)
 		emul_con = EXYNOS5433_TMU_EMUL_CON;
-	else if (data->soc == SOC_ARCH_EXYNOS7)
+	else if (data->soc == SOC_ARCH_EXYNOS7 ||
+		 data->soc == SOC_ARCH_EXYNOS850)
 		emul_con = EXYNOS7_TMU_REG_EMUL_CON;
 	else
 		emul_con = EXYNOS_EMUL_CON;
@@ -761,6 +909,12 @@ static int exynos7_tmu_read(struct exynos_tmu_data *data)
 		EXYNOS7_TMU_TEMP_MASK;
 }
 
+static int exynos850_tmu_read(struct exynos_tmu_data *data)
+{
+	return readw(data->base + EXYNOS850_TMU_REG_CURRENT_TEMP0_1) &
+	       EXYNOS7_TMU_TEMP_MASK;
+}
+
 static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 {
 	struct exynos_tmu_data *data = id;
@@ -787,7 +941,8 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	if (data->soc == SOC_ARCH_EXYNOS5260) {
 		tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
 		tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR;
-	} else if (data->soc == SOC_ARCH_EXYNOS7) {
+	} else if (data->soc == SOC_ARCH_EXYNOS7 ||
+		   data->soc == SOC_ARCH_EXYNOS850) {
 		tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
 		tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
 	} else if (data->soc == SOC_ARCH_EXYNOS5433) {
@@ -838,6 +993,9 @@ static const struct of_device_id exynos_tmu_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-tmu",
 		.data = (const void *)SOC_ARCH_EXYNOS7,
+	}, {
+		.compatible = "samsung,exynos850-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS850,
 	},
 	{ },
 };
@@ -950,6 +1108,21 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->min_efuse_value = 15;
 		data->max_efuse_value = 100;
 		break;
+	case SOC_ARCH_EXYNOS850:
+		data->tmu_set_low_temp = exynos850_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos850_tmu_set_high_temp;
+		data->tmu_disable_low = exynos850_tmu_disable_low;
+		data->tmu_disable_high = exynos850_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos850_tmu_set_crit_temp;
+		data->tmu_initialize = exynos850_tmu_initialize;
+		data->tmu_control = exynos4210_tmu_control;
+		data->tmu_read = exynos850_tmu_read;
+		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
+		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->efuse_value = 55;
+		data->min_efuse_value = 0;
+		data->max_efuse_value = 511;
+		break;
 	default:
 		dev_err(&pdev->dev, "Platform not supported\n");
 		return -EINVAL;
-- 
2.45.1


