Return-Path: <linux-pm+bounces-18707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D09E741F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 16:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E4C1885346
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67920ADF4;
	Fri,  6 Dec 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="ZG7CFXwY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="skrdUP+t"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187E84A3E;
	Fri,  6 Dec 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499087; cv=none; b=C835JjhvgorEGrhk/j+JSCHI/1rwpIPsPEId4S5nHDNQcM12W4v+PcvF6r0J1HHRlvVdpgp1XSyjebnrGByCJQdz/ev2+14nMC/GIj4P/Vgcuqh+6DmQFQgUdZY3oDlpkcDNx6tArQ1r0bbrXO5zeakbIQuG++oGoYAE1n78ZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499087; c=relaxed/simple;
	bh=y4TwTmoHPNsLxVD5+XOYg9aH5Q1MSMOOzsowWTurdvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jI3Uj68bZEyNuZzeV6hHsFtzELCPsFLufu+d3CNGcrxVA2SoT5iQEUQ66/UuvVjtxv4wCG59OlbQc94CKwipa+Cv1J0YX077aFCoP3Fw+FjQ/WZfAaeCSPFbcZ3vUDnNWWdG1fyy3THVc2krGZBCZTbTfr4MT4pHbvgG/HAChtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=ZG7CFXwY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=skrdUP+t; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A0FA11400CB;
	Fri,  6 Dec 2024 10:31:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Dec 2024 10:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733499084;
	 x=1733585484; bh=uSkYUlgQyCkK84pn4HZ/yDTRTvwxHRjJ+Kpt3BHcEnc=; b=
	ZG7CFXwYpH0ZugUn0EeDuRHSBoxbY/4t6ksu4y+fIK1G5Z09ocR2M6ZSdixYB9SC
	HjiPU+UxwWp0y0SshB40LTdgvvTpb72codsflm3rUoT9PS3y/a5j/RMqRc8aiv8/
	kpjI5FTc1EACTUn/1aAIcjn8Voy7qsvhdLE+wLfkA7f3Zhv+NSKcRCziXlqRmqoR
	s/hbPcKi4/Mg0T3nSAujW76zNy8V+3RL5jAuKxpCdYgTdo+tpjEggZonA4pChNL9
	EGCZVUAQkZQhViTA1aTCEXM9znIwJiQ0cyeb8BdSSfr5j1S3BsmY0F2XUXJ2v7cb
	5hOTX7PG0fXTfag1BB3hew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733499084; x=
	1733585484; bh=uSkYUlgQyCkK84pn4HZ/yDTRTvwxHRjJ+Kpt3BHcEnc=; b=s
	krdUP+tmldH+qwEd5wjgnVp/wWkeV7DKPA+lGOWKSTxEumhz2SEtQbpVKQMeIebp
	EaZK36VuM8tlISiPU5SSPgLYczbF1LM8Q3/xi9HThVqSdg103692Cpbx1TckWu6w
	ipYK8KYZVcOHi0TekR26qVb06enkPYqKBML5VjAQCVEgqHaInlaACA9Td7QqSn33
	cZCC2/UczBe+T5fzpqmQaxKGQD8BJvDhcVGakDVLJUpSYA6kOL/o3abLTrsLDkU4
	OfXIOBRCBfONA6VZOAGfbadB1BgvEdyMNdAZRhBfuqvc7KS8JU6MadrXTNA6vLYp
	eo/uXzPXMZlpL3UcNXEDA==
X-ME-Sender: <xms:yxhTZzyZOBS5AT2RUnqk4qS-cNIT2vUr25w5sFJiHCg5B_l_ZJwBsw>
    <xme:yxhTZ7RCCwkFXSH4rxlC-l5-gEfuAiCTF3KtqbSGRl8kSrIzwLMWQMWo2tG7sz2Aa
    -ZG1O_Dlkgx4E_shwo>
X-ME-Received: <xmr:yxhTZ9V2CYUvwfcPtAjRKVsh8rXeTx--c6fiMW_ZkxDJ1GqSagZmnHdM5fWcaCjsohuzGfEavh8bTlzgj2zPceiB0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeen
    ucfhrhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvg
    hrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthht
    vghrnhepheeigfeuveeutdefhfehgeekvedtleeuueekveefudehhffhjeffgfegffelfe
    egnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhi
    khhlrghsrdhsohguvghrlhhunhgusehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpth
    htohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrfhgrvghlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrh
    hordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgt
    phhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepghgvvg
    hrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgvnhgv
    shgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihhklhgrshdr
    shhouggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:yxhTZ9hiCq1PirSjHLZMwK0J22yKRH0dfF48xQEhpIWrBaxnoBTEzg>
    <xmx:yxhTZ1Dqna0sjBJf7W89odhJlJPLF1UTHj5g1wWiqjrYpLX6DCJiNw>
    <xmx:yxhTZ2JAZ6-5MyizeCiHX4Am9ubP5uhPuP6QMXA3RgD2dl5aMzXHrg>
    <xmx:yxhTZ0AHxDv5q7ge7uo-XbW7gi1B1XO-ux5jeIxF9jHaZlt8ysSH6g>
    <xmx:zBhTZ52-h8pUPRiWsF4kxAHZSB-5dd1UUoc3yLVaZJXg9p7-5F85mITI>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 10:31:23 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 2/2] thermal: rcar_gen3: Reuse logic to read fuses on Gen3 and Gen4
Date: Fri,  6 Dec 2024 16:30:50 +0100
Message-ID: <20241206153050.3693454-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206153050.3693454-1-niklas.soderlund+renesas@ragnatech.se>
References: <20241206153050.3693454-1-niklas.soderlund+renesas@ragnatech.se>
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
2.47.1


