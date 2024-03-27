Return-Path: <linux-pm+bounces-5513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC4F88E6CD
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 15:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178FD1F2971F
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621413BC26;
	Wed, 27 Mar 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="ysCsRKKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FhHOaj60"
X-Original-To: linux-pm@vger.kernel.org
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BD12FF8E;
	Wed, 27 Mar 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546246; cv=none; b=AW0nG4jBGJP0Ixu/rPqAXGkZtW+bBHGM/T4ncfbuQwmFwMd/N8xREAXTvJRFrY3EaNtl81vGi7Z6rMwrJgH4etXlKgdTL5tfwynxAyDwCspKWqnLaMPwX3XfEd1093T2DTTACJnefvsgf2ddr72hcZlx7va9HqFCbya1Ii3jOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546246; c=relaxed/simple;
	bh=rm0etaNjerSM1EXOhxa6ogACZ8fGfq4o2808PBH2dAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qxawz1RLkYfl+FZi4HO4cV5STdjo3TA61oMtJAeTtU5j+uD1w2vrR1rdsL8yHDBL6MyXYONZKJrGlHp6y+ZOndxd5sIHQg2kmIC+5ewEPfeF6+lYSHb3Joev7kZEXE727sr5YkgSNZv90iF/V33UJcbdhV75Yc4ASi389YodX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=ysCsRKKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FhHOaj60; arc=none smtp.client-ip=66.111.4.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id B6AD05809B6;
	Wed, 27 Mar 2024 09:30:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 Mar 2024 09:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711546242;
	 x=1711549842; bh=JuiRcU6bRV5EIkmJeZwCKqyX8kOuTRy877azNmY6MZM=; b=
	ysCsRKKaLmn4hHZQhyXpzVJOS8U/B9gObM4uY+JbEwzDEebYEfUeJJN7mEQZlgSJ
	thd9kTcPS96dicoJeyD3yqgHKlC9iOsp4CqpmH8eMzfQKAqrGQeiB0JRXz6VvGEy
	5Hz284hTbOjv+7QpNOoY2keBzSzGjj0OqG+Sz/LuI8jL2VGKzLt4512bJcqmU4bJ
	Q1jQ8tO/ewPOX1X6kA7v+Ec7LTUSdZpqkd5njdztXCKokQqZqaI/mPDl2S93rYWY
	eTRRF9IOyRXATWKJ0msIOgLHcm4Q6EaAUpN28ALpsMkR4q8bbs9rARRLf+R950OV
	iS/KX7ZL6H42CMywnpYOMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711546242; x=
	1711549842; bh=JuiRcU6bRV5EIkmJeZwCKqyX8kOuTRy877azNmY6MZM=; b=F
	hHOaj60yBpHnFdiCfSbTyj2bLBhpV6jKtPBNymLoS4CxsRrx3KMPlXhuWVc9lAkZ
	UiCLcahILbhSH0+yQzY/c7/lEaRDkmWt0795JYRlKcFz6LVWYRGiNVtHJh4034rT
	CnH3RokiK2OE6+CQ0Y5HURybXvDrt5y6M7rQ3asoEIltXX9bBCoqSRyRFk1RjoHB
	+EYB/7WnUlE7T5Nm35cXY60O+KyLfz3Pq6pNFkP1uHnvoAW0Yean6slrqXOuvApN
	qYJ0zmsfJH+etdnSDgJkt5+DR2meD05aZ7NFA0ZFFEFJ8puVyl5Vnuv9PZ2YHxqy
	wFdteDzEGZbzxIgV+CkgA==
X-ME-Sender: <xms:gh8EZl3MJt7RV5Kp853mSIbyrKJ4bf8tR1OAnN6UZmUUFohJfPvFqA>
    <xme:gh8EZsGt0sXH6K9ZFp8QFCrDOz6dyjeIXx20xxrOD7SoJnSazVshvtk4d3Qy853AU
    Co_DI-bqbKN9tsXnjQ>
X-ME-Received: <xmr:gh8EZl65Gwann_4JH9ipNrl5pc8R93cxfO521YFdc758CTMMoKHBPXFm3OM_fJFBVGvfwEKBDmy0PBlnfvu_1dpQqyViZI23ieOn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeehiefgueev
    uedtfefhheegkeevtdelueeukeevfeduhefhhfejfffggeffleefgeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:gh8EZi3N4y1Tz5guQ28ZppFfNBW7TZCyRomNpv5ejTKzuUP_OzVP_g>
    <xmx:gh8EZoGOFJytgpWXF2c-UVXVXppHvpnLrI3cgVLM8kOgLYQyeZZFSA>
    <xmx:gh8EZj8vm6p2VnpgMor0X9V5mE6uOxinY_KKSc7A9CR3setw0a86Ig>
    <xmx:gh8EZllJN7NjwZsENvyujIRes8mT7inLh3rRlQkRd07FV5Vk2aem9w>
    <xmx:gh8EZma1wzrh3p-ud0fcRbjSLJjLwjAPTD6WXJi5rvSkBBoeUOzilw>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 09:30:41 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 2/2] thermal: rcar_gen3: Update temperature approximation calculation
Date: Wed, 27 Mar 2024 14:30:13 +0100
Message-ID: <20240327133013.3982199-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327133013.3982199-1-niklas.soderlund+renesas@ragnatech.se>
References: <20240327133013.3982199-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The initial driver used a formula to approximate the temperature and
register values reversed engineered from an out-of-tree BSP driver. This
was needed as the datasheet at the time did not contain any information
on how to do this. Later Gen3 (Rev 2.30) and Gen4 (all) now contains
this information.

Update the approximation formula to use the datasheet's information
instead of the reversed-engineered one.

On an idle M3-N without fused calibration values for PTAT and THCODE the
old formula reports,

    zone0: 52000
    zone1: 53000
    zone2: 52500

While the new formula under the same circumstances reports,

    zone0: 52500
    zone1: 54000
    zone2: 54000

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v1
- Fix spelling in commit message and code comments.
- Improve calculation per Geert's suggestion of calculating directly in
  decidegrees. This allowed squashing patch 3/3/ in v1 into patch 2/2 in
  v2.
---
 drivers/thermal/rcar_gen3_thermal.c | 156 ++++++++++++++--------------
 1 file changed, 78 insertions(+), 78 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 7c1ca912b9b1..02494fa142c3 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -65,26 +65,29 @@
 
 #define TSC_MAX_NUM	5
 
-/* Structure for thermal temperature calculation */
-struct equation_coefs {
-	int a1;
-	int b1;
-	int a2;
-	int b2;
-};
-
 struct rcar_gen3_thermal_priv;
 
 struct rcar_thermal_info {
-	int ths_tj_1;
+	int scale;
+	int adj_below;
+	int adj_above;
 	void (*read_fuses)(struct rcar_gen3_thermal_priv *priv);
 };
 
+struct equation_set_coef {
+	int a;
+	int b;
+};
+
 struct rcar_gen3_thermal_tsc {
 	struct rcar_gen3_thermal_priv *priv;
 	void __iomem *base;
 	struct thermal_zone_device *zone;
-	struct equation_coefs coef;
+	/* Different coefficients are used depending on a threshold. */
+	struct {
+		struct equation_set_coef below;
+		struct equation_set_coef above;
+	} coef;
 	int thcode[3];
 };
 
@@ -112,90 +115,75 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 /*
  * Linear approximation for temperature
  *
- * [reg] = [temp] * a + b => [temp] = ([reg] - b) / a
+ * [temp] = ((thadj - [reg]) * a) / b + adj
+ * [reg] = thadj - ([temp] - adj) * b / a
  *
  * The constants a and b are calculated using two triplets of int values PTAT
  * and THCODE. PTAT and THCODE can either be read from hardware or use hard
- * coded values from driver. The formula to calculate a and b are taken from
- * BSP and sparsely documented and understood.
+ * coded values from the driver. The formula to calculate a and b are taken from
+ * the datasheet. Different calculations are needed for a and b depending on
+ * if the input variables ([temp] or [reg]) are above or below a threshold. The
+ * threshold is also calculated from PTAT and THCODE using formulas from the
+ * datasheet.
  *
- * Examining the linear formula and the formula used to calculate constants a
- * and b while knowing that the span for PTAT and THCODE values are between
- * 0x000 and 0xfff the largest integer possible is 0xfff * 0xfff == 0xffe001.
- * Integer also needs to be signed so that leaves 7 bits for binary
- * fixed point scaling.
+ * The constant thadj is one of the THCODE values, which one to use depends on
+ * the threshold and input value.
+ *
+ * The constants adj is taken verbatim from the datasheet. Two values exists,
+ * which one to use depends on the input value and the calculated threshold.
+ * Furthermore different SoC models supported by the driver have different sets
+ * of values. The values for each model are stored in the device match data.
  */
 
-#define FIXPT_SHIFT 7
-#define FIXPT_INT(_x) ((_x) << FIXPT_SHIFT)
-#define INT_FIXPT(_x) ((_x) >> FIXPT_SHIFT)
-#define FIXPT_DIV(_a, _b) DIV_ROUND_CLOSEST(((_a) << FIXPT_SHIFT), (_b))
-#define FIXPT_TO_MCELSIUS(_x) ((_x) * 1000 >> FIXPT_SHIFT)
-
-#define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
-
-/* no idea where these constants come from */
-#define TJ_3 -41
-
 static void rcar_gen3_thermal_shared_coefs(struct rcar_gen3_thermal_priv *priv)
 {
-	int tj1 = priv->info->ths_tj_1;
-
-	priv->tj_t = (FIXPT_INT((priv->ptat[1] - priv->ptat[2]) * (tj1 - TJ_3))
-		      / (priv->ptat[0] - priv->ptat[2])) + FIXPT_INT(TJ_3);
+	priv->tj_t =
+		DIV_ROUND_CLOSEST((priv->ptat[1] - priv->ptat[2]) * priv->info->scale,
+				  priv->ptat[0] - priv->ptat[2])
+		+ priv->info->adj_below;
 }
-
 static void rcar_gen3_thermal_tsc_coefs(struct rcar_gen3_thermal_priv *priv,
 					struct rcar_gen3_thermal_tsc *tsc)
 {
-	int tj1 = priv->info->ths_tj_1;
+	tsc->coef.below.a = priv->info->scale * (priv->ptat[2] - priv->ptat[1]);
+	tsc->coef.above.a = priv->info->scale * (priv->ptat[0] - priv->ptat[1]);
 
-	/* TODO: Find documentation and document constant calculation formula */
-
-	/*
-	 * Division is not scaled in BSP and if scaled it might overflow
-	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
-	 */
-	tsc->coef.a1 = FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[2]),
-				 priv->tj_t - FIXPT_INT(TJ_3));
-	tsc->coef.b1 = FIXPT_INT(tsc->thcode[2]) - tsc->coef.a1 * TJ_3;
-
-	tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[0]),
-				 priv->tj_t - FIXPT_INT(tj1));
-	tsc->coef.b2 = FIXPT_INT(tsc->thcode[0]) - tsc->coef.a2 * tj1;
-}
-
-static int rcar_gen3_thermal_round(int temp)
-{
-	int result, round_offs;
-
-	round_offs = temp >= 0 ? RCAR3_THERMAL_GRAN / 2 :
-		-RCAR3_THERMAL_GRAN / 2;
-	result = (temp + round_offs) / RCAR3_THERMAL_GRAN;
-	return result * RCAR3_THERMAL_GRAN;
+	tsc->coef.below.b = (priv->ptat[2] - priv->ptat[0]) * (tsc->thcode[2] - tsc->thcode[1]);
+	tsc->coef.above.b = (priv->ptat[0] - priv->ptat[2]) * (tsc->thcode[1] - tsc->thcode[0]);
 }
 
 static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct rcar_gen3_thermal_tsc *tsc = thermal_zone_device_priv(tz);
-	int mcelsius, val;
-	int reg;
+	struct rcar_gen3_thermal_priv *priv = tsc->priv;
+	const struct equation_set_coef *coef;
+	int adj, decicelsius, reg, thcode;
 
 	/* Read register and convert to mili Celsius */
 	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
 
-	if (reg <= tsc->thcode[1])
-		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
-				tsc->coef.a1);
-	else
-		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
-				tsc->coef.a2);
-	mcelsius = FIXPT_TO_MCELSIUS(val);
+	if (reg < tsc->thcode[1]) {
+		adj = priv->info->adj_below;
+		coef = &tsc->coef.below;
+		thcode = tsc->thcode[2];
+	} else {
+		adj = priv->info->adj_above;
+		coef = &tsc->coef.above;
+		thcode = tsc->thcode[0];
+	}
+
+	/*
+	 * The dividend can't be grown as it might overflow, instead shorten the
+	 * divisor to convert to decidegree Celsius. If we convert after the
+	 * division precision is lost as we will scale up from whole degrees
+	 * Celsius.
+	 */
+	decicelsius = DIV_ROUND_CLOSEST(coef->a * (thcode - reg), coef->b / 10);
 
 	/* Guaranteed operating range is -40C to 125C. */
 
-	/* Round value to device granularity setting */
-	*temp = rcar_gen3_thermal_round(mcelsius);
+	/* Reporting is done in millidegree Celsius */
+	*temp = decicelsius * 100 + adj * 1000;
 
 	return 0;
 }
@@ -204,15 +192,21 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
 					      int mcelsius)
 {
 	struct rcar_gen3_thermal_priv *priv = tsc->priv;
-	int celsius, val;
+	const struct equation_set_coef *coef;
+	int adj, celsius, thcode;
 
 	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
-	if (celsius <= INT_FIXPT(priv->tj_t))
-		val = celsius * tsc->coef.a1 + tsc->coef.b1;
-	else
-		val = celsius * tsc->coef.a2 + tsc->coef.b2;
+	if (celsius < priv->tj_t) {
+		coef = &tsc->coef.below;
+		adj = priv->info->adj_below;
+		thcode = tsc->thcode[2];
+	} else {
+		coef = &tsc->coef.above;
+		adj = priv->info->adj_above;
+		thcode = tsc->thcode[0];
+	}
 
-	return INT_FIXPT(val);
+	return thcode - DIV_ROUND_CLOSEST((celsius - adj) * coef->b, coef->a);
 }
 
 static int rcar_gen3_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
@@ -377,17 +371,23 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
 }
 
 static const struct rcar_thermal_info rcar_m3w_thermal_info = {
-	.ths_tj_1 = 116,
+	.scale = 157,
+	.adj_below = -41,
+	.adj_above = 116,
 	.read_fuses = rcar_gen3_thermal_read_fuses_gen3,
 };
 
 static const struct rcar_thermal_info rcar_gen3_thermal_info = {
-	.ths_tj_1 = 126,
+	.scale = 167,
+	.adj_below = -41,
+	.adj_above = 126,
 	.read_fuses = rcar_gen3_thermal_read_fuses_gen3,
 };
 
 static const struct rcar_thermal_info rcar_gen4_thermal_info = {
-	.ths_tj_1 = 126,
+	.scale = 167,
+	.adj_below = -41,
+	.adj_above = 126,
 	.read_fuses = rcar_gen3_thermal_read_fuses_gen4,
 };
 
-- 
2.44.0


