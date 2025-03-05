Return-Path: <linux-pm+bounces-23498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6777A506BA
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 18:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7393A5F74
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D37198A0D;
	Wed,  5 Mar 2025 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="JWtETU1k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uQKJF7xl"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26E2505B8;
	Wed,  5 Mar 2025 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196847; cv=none; b=CEHzmLxp4pmnO5JdhU/QFMRuRShUXnH9btZwN7uo0+/l0Su3Yw+LufmM3Q/LPQUdvpeYBd6Qk36vO0yjh7JW/nmp71yS0fBDc7OJHoxJ+biB3rb385lHt67T4N7B800KvJ8dNm6cv00kzaVhE6j7lUl/OUxwvmAxUQatnJ0X6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196847; c=relaxed/simple;
	bh=ks56H3AiBmMIjouAI4Dhs1hONb0Y4tyZn132g7FieAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwDD4vEe5nkUoIxVd50cmmkfqMyKTjv4J1NiKsQcNCaolDI9K6xdA4tZ7fkDFl4UJI/09cu/0kj2Rak8JT30mNTx2mZ0+CIi6rYjCSY/lGO53ulyFDnNyKToiMuLkhTDQaJCbRThcmfAf+Q1tlklGFUL9xjLE6Pt/vs/hy/mbZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=JWtETU1k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uQKJF7xl; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id EDDD813826D9;
	Wed,  5 Mar 2025 12:47:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 05 Mar 2025 12:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741196844;
	 x=1741283244; bh=geSrkPbfTasR9PztTyigP59TRSgZrIn0wXQcKuj0LcQ=; b=
	JWtETU1kqwLYSIK/MUd+brOAKLxYp6UEm7DJn7gt1Wq6gXPYKmiiNnd9oovPX22j
	rkj9AslAepjGxzV9pOuK5OPvi7JLbPOubgypOblYKi36hWOAqzqbm360tU02bFIw
	waYpFVtYpwA67PdVUEANSg6mMcg6nDlvoWiXC3UycIET1J1zYcHakg2pu51zYXNc
	+sQrKYFdAKES1hzL9g+Rwg0zHu995ommQ/pTLoqZhWXtsVZVHeprnyqXghCdjofn
	qwsLi9EBzVWUHMetS9v2YFM1lZZOePYmNGFBIHx3ecW06R69oCFEA1Jq7Za3RkrQ
	Ze3T+wZTaSgolx5ozbed2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741196844; x=
	1741283244; bh=geSrkPbfTasR9PztTyigP59TRSgZrIn0wXQcKuj0LcQ=; b=u
	QKJF7xlebRWVJ8/7cJUC5HCaOI5fcHJq67WVIYkM6zXeLXsvKY71VjhoixDMFKCS
	9m1YL7jv9osTBLVSQOKWtcXGggSG6pQuTjZCb+ERcTIgVj0uwW9odzImrtJ8A/dW
	hguvtrqUZC+jg5Mk8EfTqRfY8Ro++3BvjaXcPeL1SrqmtOILtOGRuABJJgeOIn9R
	v4g4W9fEKCvB53sedYwcm6H/jmUMMZ3zN07G/Vyu1HSSeOG23eQXuJS63RZtIzV2
	1Vq4x3Tb0R6xHiioehNB/VZm9FIg/WbBfA+sfGcC62wbZcdICLNq70HbPWKWG0tL
	hjGJ9amLbnZm/DP1NDV4A==
X-ME-Sender: <xms:LI7IZ_TACW3o8wdts1kwj4dWjTAB0sjS7dkPEg_C3IoGLEmVMwVjiw>
    <xme:LI7IZwx8aPFc88ezVvfd-YOwgtiYqVP34zVJmqpgCr0MyBNS2o_SMjybPF8fcgm-Z
    u1HZ49seZFiwLqIrfs>
X-ME-Received: <xmr:LI7IZ03xX2OXEBHejO3-YlSRovgDvXrwbCGDNPUVo8QGSqAZAkRmdNB7lYz5WciDxnI-M0b_umzrAhozOVzwUDttgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpefpihhklhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrsh
    houggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffr
    rghtthgvrhhnpeehiefgueevuedtfefhheegkeevtdelueeukeevfeduhefhhfejfffgge
    ffleefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvpdhnsggprh
    gtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghfrggvlhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlih
    hnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
    pdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhope
    hgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhr
    vghnvghsrghsqdhsohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhikhhl
    rghsrdhsohguvghrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgdprh
    gtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsggv
X-ME-Proxy: <xmx:LI7IZ_BXhADPd3D9RJmAWKcw2xNTY-KxL-m68MTEdmUxg2cOJXuBnQ>
    <xmx:LI7IZ4jV3owaZrLu6Ou5eoIAhioPszJ5auCyhoK0K3jo-p1mGa-ltQ>
    <xmx:LI7IZzq3_3g6r1_YbW8XSJbsI_ZRPZK2v1ZnFhblmKlq4pJJu0-ovg>
    <xmx:LI7IZzixlOtf5zX89QDk2A9eDFhNgn_09o9cC5tvV8C_CgKkJm_Dfg>
    <xmx:LI7IZ7NUHyCDT0E_3pDgbLchUXvDjZjU4TEBC0HI_F_tKx0xAV6oYAGE>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 12:47:23 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 2/2] thermal: rcar_gen3: Reuse logic to read fuses on Gen3 and Gen4
Date: Wed,  5 Mar 2025 18:46:31 +0100
Message-ID: <20250305174631.4119374-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174631.4119374-1-niklas.soderlund+renesas@ragnatech.se>
References: <20250305174631.4119374-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hardware calibration is fused on some, but not all, Gen3 and Gen4
boards. The calibrations values are the same on both generations but
located at different register offsets.

Instead of having duplicated logic to read the and store the values
create structure to hold the register parameters and have a common
function do the reading.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
* Changes since v2
- Use a structure instead of two helper functions to store the
  parameters.
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 89 +++++++++------------
 1 file changed, 40 insertions(+), 49 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index deec17435901..24a702ee4c1f 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -67,11 +67,17 @@
 
 struct rcar_gen3_thermal_priv;
 
+struct rcar_gen3_thermal_fuse_info {
+	u32 ptat[3];
+	u32 thcode[3];
+	u32 mask;
+};
+
 struct rcar_thermal_info {
 	int scale;
 	int adj_below;
 	int adj_above;
-	void (*read_fuses)(struct rcar_gen3_thermal_priv *priv);
+	const struct rcar_gen3_thermal_fuse_info *fuses;
 };
 
 struct equation_set_coef {
@@ -253,59 +259,31 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void rcar_gen3_thermal_read_fuses_gen3(struct rcar_gen3_thermal_priv *priv)
+static void rcar_gen3_thermal_fetch_fuses(struct rcar_gen3_thermal_priv *priv)
 {
-	unsigned int i;
+	const struct rcar_gen3_thermal_fuse_info *fuses = priv->info->fuses;
 
 	/*
 	 * Set the pseudo calibration points with fused values.
 	 * PTAT is shared between all TSCs but only fused for the first
 	 * TSC while THCODEs are fused for each TSC.
 	 */
-	priv->ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT1) &
-		GEN3_FUSE_MASK;
-	priv->ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT2) &
-		GEN3_FUSE_MASK;
-	priv->ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT3) &
-		GEN3_FUSE_MASK;
+	priv->ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], fuses->ptat[0])
+		& fuses->mask;
+	priv->ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], fuses->ptat[1])
+		& fuses->mask;
+	priv->ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], fuses->ptat[2])
+		& fuses->mask;
 
-	for (i = 0; i < priv->num_tscs; i++) {
+	for (unsigned int i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
-		tsc->thcode[0] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE1) &
-			GEN3_FUSE_MASK;
-		tsc->thcode[1] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE2) &
-			GEN3_FUSE_MASK;
-		tsc->thcode[2] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE3) &
-			GEN3_FUSE_MASK;
-	}
-}
-
-static void rcar_gen3_thermal_read_fuses_gen4(struct rcar_gen3_thermal_priv *priv)
-{
-	unsigned int i;
-
-	/*
-	 * Set the pseudo calibration points with fused values.
-	 * PTAT is shared between all TSCs but only fused for the first
-	 * TSC while THCODEs are fused for each TSC.
-	 */
-	priv->ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN4_THSFMON16) &
-		GEN4_FUSE_MASK;
-	priv->ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN4_THSFMON17) &
-		GEN4_FUSE_MASK;
-	priv->ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN4_THSFMON15) &
-		GEN4_FUSE_MASK;
-
-	for (i = 0; i < priv->num_tscs; i++) {
-		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
-
-		tsc->thcode[0] = rcar_gen3_thermal_read(tsc, REG_GEN4_THSFMON01) &
-			GEN4_FUSE_MASK;
-		tsc->thcode[1] = rcar_gen3_thermal_read(tsc, REG_GEN4_THSFMON02) &
-			GEN4_FUSE_MASK;
-		tsc->thcode[2] = rcar_gen3_thermal_read(tsc, REG_GEN4_THSFMON00) &
-			GEN4_FUSE_MASK;
+		tsc->thcode[0] = rcar_gen3_thermal_read(tsc, fuses->thcode[0])
+			& fuses->mask;
+		tsc->thcode[1] = rcar_gen3_thermal_read(tsc, fuses->thcode[1])
+			& fuses->mask;
+		tsc->thcode[2] = rcar_gen3_thermal_read(tsc, fuses->thcode[2])
+			& fuses->mask;
 	}
 }
 
@@ -316,7 +294,7 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 
 	/* If fuses are not set, fallback to pseudo values. */
 	thscp = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_THSCP);
-	if (!priv->info->read_fuses ||
+	if (!priv->info->fuses ||
 	    (thscp & THSCP_COR_PARA_VLD) != THSCP_COR_PARA_VLD) {
 		/* Default THCODE values in case FUSEs are not set. */
 		static const int thcodes[TSC_MAX_NUM][3] = {
@@ -342,7 +320,8 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 		return false;
 	}
 
-	priv->info->read_fuses(priv);
+	rcar_gen3_thermal_fetch_fuses(priv);
+
 	return true;
 }
 
@@ -370,25 +349,37 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
 	usleep_range(1000, 2000);
 }
 
+static const struct rcar_gen3_thermal_fuse_info rcar_gen3_thermal_fuse_info_gen3 = {
+	.ptat = { REG_GEN3_PTAT1, REG_GEN3_PTAT2, REG_GEN3_PTAT3 },
+	.thcode = { REG_GEN3_THCODE1, REG_GEN3_THCODE2, REG_GEN3_THCODE3 },
+	.mask = GEN3_FUSE_MASK,
+};
+
+static const struct rcar_gen3_thermal_fuse_info rcar_gen3_thermal_fuse_info_gen4 = {
+	.ptat = { REG_GEN4_THSFMON16, REG_GEN4_THSFMON17, REG_GEN4_THSFMON15 },
+	.thcode = { REG_GEN4_THSFMON01, REG_GEN4_THSFMON02, REG_GEN4_THSFMON00 },
+	.mask = GEN4_FUSE_MASK,
+};
+
 static const struct rcar_thermal_info rcar_m3w_thermal_info = {
 	.scale = 157,
 	.adj_below = -41,
 	.adj_above = 116,
-	.read_fuses = rcar_gen3_thermal_read_fuses_gen3,
+	.fuses = &rcar_gen3_thermal_fuse_info_gen3,
 };
 
 static const struct rcar_thermal_info rcar_gen3_thermal_info = {
 	.scale = 167,
 	.adj_below = -41,
 	.adj_above = 126,
-	.read_fuses = rcar_gen3_thermal_read_fuses_gen3,
+	.fuses = &rcar_gen3_thermal_fuse_info_gen3,
 };
 
 static const struct rcar_thermal_info rcar_gen4_thermal_info = {
 	.scale = 167,
 	.adj_below = -41,
 	.adj_above = 126,
-	.read_fuses = rcar_gen3_thermal_read_fuses_gen4,
+	.fuses = &rcar_gen3_thermal_fuse_info_gen4,
 };
 
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
-- 
2.48.1


