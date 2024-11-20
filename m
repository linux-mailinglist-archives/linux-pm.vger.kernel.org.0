Return-Path: <linux-pm+bounces-17816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDE69D3A2F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 13:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259481F21440
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 12:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8197F19F424;
	Wed, 20 Nov 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="mb5tlaod";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3LqxJQaW"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC721A255A;
	Wed, 20 Nov 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104251; cv=none; b=ZnGY39WxEW+1q5pqdrRJDc+WlDeCE/kSetweKyR3rlQo5GtGgYNXDEJQuBEY2dExZzhxpMG6eOz+k6DWTbCZbJGTVU4Yj6wOvJaEogoQjBlPCo2/ENxvI1xWQHfRcTj2Afxw1j9GeVMgtRKSC6amweUkJkKzelu75h2HOSU7QJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104251; c=relaxed/simple;
	bh=hEd3g7fDPK11l/5d5FbPMXrF8PX2Wj8EbZwusGCBJlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLS0peK9zg1iOphJelhTFmP87JEPgKsnmb6+MCu2XVr1G7ZULnoD9x2Hj3Ltl/XY81cYAL5IMqEkTVNq4pHqEOHpUXO9OEUr0xSgu0DU04+/SA0doiG88XjEviBjG5D7AgtI3glAJp800IpEWgeAv8Xx/F4cYlM8psjKJTxwvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=mb5tlaod; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3LqxJQaW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id AD81813806B6;
	Wed, 20 Nov 2024 07:04:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 20 Nov 2024 07:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732104248;
	 x=1732190648; bh=BUZASvGHhI99mp2A2UEOVv5dmxCopVfkBTQJrK0adBI=; b=
	mb5tlaodyBqoO9yheyScyNuwfZLkpP/7rcJ+rcFLh9TgREfHPG0pCqnmdj86uU33
	UTJH4SpQPODv6rsqlLtmCzETN6XxNqolkNPe0WCT0EfWLag8f7DYCqvWkEEmANhs
	mQeFZ7XaSzoSRlVx0d6uJkaipa2dOduzK9hEMyzMFVqFq1IS5xRyJu8gHsLit4Ht
	eL4V8seVCJkluYNeQKcekkZ4vYWyc5sX7FHY7AQ6oJcKrKMP4EBzDLe1B8lMau0s
	VMF6fsqY+3a0qwe3X5xicJVcVA3WEvtc50tZc37Nk/8qyNYyzNeccli3ZSNn3p4D
	LYjg4NjWFXuSuXTIgXAkFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732104248; x=
	1732190648; bh=BUZASvGHhI99mp2A2UEOVv5dmxCopVfkBTQJrK0adBI=; b=3
	LqxJQaW/0dxgiu7pTOvpaVaC+3mFOsGP0Av1k6YwXeqkfIZpNf17KWODDAWkUseC
	Xd/udivMbtbXsMhVyEaI1lO4/O1+SucD61FG4rg0OfBKL4oRoehQL1FogOWACMIU
	WZHeO3kqSJl+K8+RgVYGYsj0XhwmBnt5ZBMGLXoI3DwJM/ydkR/FZ7ieIpPlJ1Cx
	1BaYn95qQiJ3Ou8iuujCudIfYMdjwiDnlbUuMv7FA4RbwXY/xpodaBxPZgrgp0RG
	B6qEbKa27+/BuM8QcOSWYxUNUvJjl5a4DUTbGlDsxnqhOZb1h6NFEGXjExpPRPcr
	8aquueK25WV0XzTZZcirQ==
X-ME-Sender: <xms:ONA9Z4jGo6J7fC4xUOfD_ctBQc2jw5haZqHyF5MTNRVB72wJItsT2A>
    <xme:ONA9ZxDUb6EWZ66RPdHO9ibpOI3Ne8znly_xdxUPPKrUjWMi6SpABobS8ShH_nV5w
    m_bnCXPhYlpnlTxumE>
X-ME-Received: <xmr:ONA9ZwEDRIthJk4VHZQRHN5DQW-qh5qqd8899H7rBawNo9tghHZgJU1sS2euScdbZKp_AxUp0v7iZ4xhYdr--zA_2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeen
    ucfhrhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvg
    hrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthht
    vghrnhepheeigfeuveeutdefhfehgeekvedtleeuueekveefudehhffhjeffgfegffelfe
    egnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhi
    khhlrghsrdhsohguvghrlhhunhgusehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpth
    htohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrfhgrvghlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrh
    hordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgt
    phhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqrhgvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hnihhklhgrshdrshhouggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdr
    shgv
X-ME-Proxy: <xmx:ONA9Z5SZd04Pyxl36cNtDZHNIEtVu2OMIkD1lotYXHyuk4BCzOQPjw>
    <xmx:ONA9Z1wgmwXTjw5b7zqwWLg-IRTWvdL5vS3xeLKpdRHOenmPr6rCbQ>
    <xmx:ONA9Z34L1t-_k7UIC9ema9UA-AByIMNlVW5a1_D3PfR8xUomQDYhUw>
    <xmx:ONA9ZyyqO-t2iQrzNu7hNh17YzH4Gu_V203fF4hrO7payBbury9Eug>
    <xmx:ONA9Z0yCtuY5I4GJ-AFLNEyM738kdirGHkTEP1ySgglgcNswZrhwtAeA>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 07:04:08 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 2/2] thermal: rcar_gen3: Reuse logic to read fuses on Gen3 and Gen4
Date: Wed, 20 Nov 2024 13:03:36 +0100
Message-ID: <20241120120336.1063979-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120120336.1063979-1-niklas.soderlund+renesas@ragnatech.se>
References: <20241120120336.1063979-1-niklas.soderlund+renesas@ragnatech.se>
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
create a helper function to do the reading and just feed it with the
correct register addresses for each generation,

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 79 ++++++++-------------
 1 file changed, 31 insertions(+), 48 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 95b636f79e07..5f54e235da2f 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -253,60 +253,43 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void rcar_gen3_thermal_fetch_fuses(struct rcar_gen3_thermal_priv *priv,
+					  u32 ptat0, u32 ptat1, u32 ptat2,
+					  u32 thcode0, u32 thcode1, u32 thcode2,
+					  u32 mask)
+{
+	/*
+	 * Set the pseudo calibration points with fused values.
+	 * PTAT is shared between all TSCs but only fused for the first
+	 * TSC while THCODEs are fused for each TSC.
+	 */
+	priv->ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], ptat0) & mask;
+	priv->ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], ptat1) & mask;
+	priv->ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], ptat2) & mask;
+
+	for (unsigned int i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+
+		tsc->thcode[0] = rcar_gen3_thermal_read(tsc, thcode0) & mask;
+		tsc->thcode[1] = rcar_gen3_thermal_read(tsc, thcode1) & mask;
+		tsc->thcode[2] = rcar_gen3_thermal_read(tsc, thcode2) & mask;
+	}
+}
+
 static void rcar_gen3_thermal_read_fuses_gen3(struct rcar_gen3_thermal_priv *priv)
 {
-	unsigned int i;
-
-	/*
-	 * Set the pseudo calibration points with fused values.
-	 * PTAT is shared between all TSCs but only fused for the first
-	 * TSC while THCODEs are fused for each TSC.
-	 */
-	priv->ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT1) &
-		GEN3_FUSE_MASK;
-	priv->ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT2) &
-		GEN3_FUSE_MASK;
-	priv->ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT3) &
-		GEN3_FUSE_MASK;
-
-	for (i = 0; i < priv->num_tscs; i++) {
-		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
-
-		tsc->thcode[0] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE1) &
-			GEN3_FUSE_MASK;
-		tsc->thcode[1] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE2) &
-			GEN3_FUSE_MASK;
-		tsc->thcode[2] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE3) &
-			GEN3_FUSE_MASK;
-	}
+	rcar_gen3_thermal_fetch_fuses(priv,
+				      REG_GEN3_PTAT1, REG_GEN3_PTAT2, REG_GEN3_PTAT3,
+				      REG_GEN3_THCODE1, REG_GEN3_THCODE2, REG_GEN3_THCODE3,
+				      GEN3_FUSE_MASK);
 }
 
 static void rcar_gen3_thermal_read_fuses_gen4(struct rcar_gen3_thermal_priv *priv)
 {
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
-	}
+	rcar_gen3_thermal_fetch_fuses(priv,
+				      REG_GEN4_THSFMON16, REG_GEN4_THSFMON17, REG_GEN4_THSFMON15,
+				      REG_GEN4_THSFMON01, REG_GEN4_THSFMON02, REG_GEN4_THSFMON00,
+				      GEN4_FUSE_MASK);
 }
 
 static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
-- 
2.47.0


