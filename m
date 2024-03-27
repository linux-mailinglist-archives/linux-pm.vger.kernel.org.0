Return-Path: <linux-pm+bounces-5512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E203C88E6CC
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 15:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115561C2E3F1
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792483CB2;
	Wed, 27 Mar 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="pry82kj+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ksdgb2Td"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9B12837C;
	Wed, 27 Mar 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546245; cv=none; b=HBLtKWej76mEiOHrfRCFlnmpECUobs5RM8mqNOR8qtSotq01jPhxAujsj7F8bl82k2wsJAHLRDqNzQLrkAEmzlw2aQTw+Nnv1F61Ih9Aeh5nM0BuIFOQf3ETxZS0GwkqdFLRwG7QbsMErqhIAw63zaS59Kn449tz2f7aMfD4nSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546245; c=relaxed/simple;
	bh=kkMk6kbrbyabGxOnG78Kuo3lHMoI++LBsUJ5IP9P7c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuUMinE/n3AiSHNO54Sk3wT6oXdWqGHU3a6T8JCw4CdBTgIUOGEu2NtlYUnLoK1Ld0wbSYbytaXw8sGp7UMmbZ8omLz89d6pgTh0lW7P57SxQLydPI6rSz07vjeT9U0Z/h/Mehq8DCjf6I42Tnj5OE7BW32XhMFxnA0ptPWFUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=pry82kj+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ksdgb2Td; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id E3AA52002D4;
	Wed, 27 Mar 2024 09:30:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 09:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711546240;
	 x=1711549840; bh=LwFseyHzOcxWOixgTcTvHvy3OjSZuHBtoaBbQG1jQkE=; b=
	pry82kj+BJgUgbE7F+KNe1mFytm3+CMLffhyOnd/aXNqy7zOEzs4tAAGgV65oLcI
	BV6vXKu6fnWtvDe6Qf0QuPKCzVXVO7TcZeeQqYKkZ0IkR6y+D0dAQ83ezYIEucFN
	2fQUQVMfuE0ePOnlsVuGzHqK6yJM8bT4zwpXngn7i0aAHhbPXQL784/a0AVas/lR
	WIc2wvCrfrrdzWTzHYR4vI3B2ey9jWuUvdBbhvWVsPBbsWmtOcH/GXA74dOh6zY8
	aIKPd+rNLPC1UTmxp6zXqHVYljlEMFUdBqA6PK6iEh/nmOQ1HEjFtdtz+C5tE43y
	zBK61+EdOPy/ICcAlgWoOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711546240; x=
	1711549840; bh=LwFseyHzOcxWOixgTcTvHvy3OjSZuHBtoaBbQG1jQkE=; b=K
	sdgb2TdesPlwNHAPmIpB5Y7y4WdwGTaFy96xtbDEBoOPChbByPdH0BRQNFau3Hkn
	cIa4IHrqcdt5Kfus8Whg4h3VcvLKf1maCmPLz5HwixKGveU1/xARVYAcuQyANWaG
	yUIUL2RH5l5w+I7+CZzZBvH54vO1Mq5a+NFw9Fmz4kxNmwpxcXD1zVbHF/B47oJt
	G7ujZyfIDsyksCl9Q817QGY9xDUU+Qd0PxaofrJUu8j4C6I5NXMGl0a/YVndyONS
	itlbz2maVf1gPtmAAo+aj7h4AeTR0uVlvUhBbDhekOyElO1tbCXx2ETySC8DzVvu
	n7KNrOWvfUI0RLE66SDyQ==
X-ME-Sender: <xms:gB8EZm2AsDKdC6V2O4mZnDIaJvYGq7jseMfv0Lk_qHs9THQisXvw_A>
    <xme:gB8EZpG4-lqC2EL6fD7fakvTZdh4dDbxDdWbGgVLb1n7Z1NS25ZAKFPelPb2MZJc0
    aswV4Bs4meJvqlZqKw>
X-ME-Received: <xmr:gB8EZu4zn9k5fhOHDn_obCf1lCxCtvdqpnLay2M9lw15lzOFNBeJfR5QoqgGkER8u2dV3zITmZu0T9M_upw0Iw7v5ChraKZXTEbx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeehiefgueev
    uedtfefhheegkeevtdelueeukeevfeduhefhhfejfffggeffleefgeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:gB8EZn1cvDldxdYeKuFdLsSS0vKEiNGK5linaTMcuQIEac1u6Czq0A>
    <xmx:gB8EZpFzy7Va-_0stVaFQpsDHA1LnqML9O_NizfuewSyCYVZ2b0uEw>
    <xmx:gB8EZg8XB_qRXj6vkdvsW0gtKPxXcmHD8bwZS5PN4NwmgC37_vxi7g>
    <xmx:gB8EZuncLYoceJLepP4Kc9FumwogP3WzKFWl_5OETIcW44Olp35apg>
    <xmx:gB8EZvbzWn_aqRhKcwwxbldw7_zeuV6hilEeDaG-tIVounoueNsWA0-f0ic>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 09:30:39 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 1/2] thermal: rcar_gen3: Move Tj_T storage to shared private data
Date: Wed, 27 Mar 2024 14:30:12 +0100
Message-ID: <20240327133013.3982199-2-niklas.soderlund+renesas@ragnatech.se>
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

The calculated Tj_T constant is calculated from the PTAT data either
read from the first TSC zone on the device if calibration data is fused,
or from fallback values in the driver itself. The value calculated is
shared among all TSC zones.

Move the Tj_T constant to the shared private data structure instead of
duplicating it in each TSC private data. This requires adding a pointer
to the shared data to the TSC private data structure. This back pointer
make it easier to further rework the temperature conversion logic.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v1
- Insert tj_t member in struct rcar_gen3_thermal_priv in reverse
  Christmas-tree ordering.
- Only calculate Tj_T once, instead of once for each TSC zone.
- Fix misspelling in commit message.
---
 drivers/thermal/rcar_gen3_thermal.c | 35 +++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index a764cb1115a5..7c1ca912b9b1 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -81,10 +81,10 @@ struct rcar_thermal_info {
 };
 
 struct rcar_gen3_thermal_tsc {
+	struct rcar_gen3_thermal_priv *priv;
 	void __iomem *base;
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
-	int tj_t;
 	int thcode[3];
 };
 
@@ -93,6 +93,7 @@ struct rcar_gen3_thermal_priv {
 	struct thermal_zone_device_ops ops;
 	unsigned int num_tscs;
 	int ptat[3];
+	int tj_t;
 	const struct rcar_thermal_info *info;
 };
 
@@ -136,26 +137,32 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 /* no idea where these constants come from */
 #define TJ_3 -41
 
-static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_priv *priv,
-					 struct rcar_gen3_thermal_tsc *tsc,
-					 int ths_tj_1)
+static void rcar_gen3_thermal_shared_coefs(struct rcar_gen3_thermal_priv *priv)
 {
+	int tj1 = priv->info->ths_tj_1;
+
+	priv->tj_t = (FIXPT_INT((priv->ptat[1] - priv->ptat[2]) * (tj1 - TJ_3))
+		      / (priv->ptat[0] - priv->ptat[2])) + FIXPT_INT(TJ_3);
+}
+
+static void rcar_gen3_thermal_tsc_coefs(struct rcar_gen3_thermal_priv *priv,
+					struct rcar_gen3_thermal_tsc *tsc)
+{
+	int tj1 = priv->info->ths_tj_1;
+
 	/* TODO: Find documentation and document constant calculation formula */
 
 	/*
 	 * Division is not scaled in BSP and if scaled it might overflow
 	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
 	 */
-	tsc->tj_t = (FIXPT_INT((priv->ptat[1] - priv->ptat[2]) * (ths_tj_1 - TJ_3))
-		     / (priv->ptat[0] - priv->ptat[2])) + FIXPT_INT(TJ_3);
-
 	tsc->coef.a1 = FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[2]),
-				 tsc->tj_t - FIXPT_INT(TJ_3));
+				 priv->tj_t - FIXPT_INT(TJ_3));
 	tsc->coef.b1 = FIXPT_INT(tsc->thcode[2]) - tsc->coef.a1 * TJ_3;
 
 	tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[0]),
-				 tsc->tj_t - FIXPT_INT(ths_tj_1));
-	tsc->coef.b2 = FIXPT_INT(tsc->thcode[0]) - tsc->coef.a2 * ths_tj_1;
+				 priv->tj_t - FIXPT_INT(tj1));
+	tsc->coef.b2 = FIXPT_INT(tsc->thcode[0]) - tsc->coef.a2 * tj1;
 }
 
 static int rcar_gen3_thermal_round(int temp)
@@ -196,10 +203,11 @@ static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
 					      int mcelsius)
 {
+	struct rcar_gen3_thermal_priv *priv = tsc->priv;
 	int celsius, val;
 
 	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
-	if (celsius <= INT_FIXPT(tsc->tj_t))
+	if (celsius <= INT_FIXPT(priv->tj_t))
 		val = celsius * tsc->coef.a1 + tsc->coef.b1;
 	else
 		val = celsius * tsc->coef.a2 + tsc->coef.b2;
@@ -516,6 +524,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
+		tsc->priv = priv;
 		tsc->base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(tsc->base)) {
 			ret = PTR_ERR(tsc->base);
@@ -530,11 +539,13 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	if (!rcar_gen3_thermal_read_fuses(priv))
 		dev_info(dev, "No calibration values fused, fallback to driver values\n");
 
+	rcar_gen3_thermal_shared_coefs(priv);
+
 	for (i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
 		rcar_gen3_thermal_init(priv, tsc);
-		rcar_gen3_thermal_calc_coefs(priv, tsc, priv->info->ths_tj_1);
+		rcar_gen3_thermal_tsc_coefs(priv, tsc);
 
 		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
 		if (IS_ERR(zone)) {
-- 
2.44.0


