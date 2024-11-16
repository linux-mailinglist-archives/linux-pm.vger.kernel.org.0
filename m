Return-Path: <linux-pm+bounces-17670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F749D0016
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 18:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963DB1F2238B
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40FF18C006;
	Sat, 16 Nov 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="ewGp5DTh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJNBnnMC"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDDA191F9B;
	Sat, 16 Nov 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731778229; cv=none; b=FZaZaTymPSk2fuxaGj3DWLREiD9CKa3bnxw7dfOSYxbYTNhqo0NHNyMd5EwPquqKwj8Dz2q5o1V//JszSUIUuM8nYOKpszEttzFKckSysVKg8kZarsGgnrsG5Zn+zDp7cKMHOOw6E4R4bLhfW3WDy773hTLjLn2X9K0TjOhRnRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731778229; c=relaxed/simple;
	bh=bp7Tgf3jJXaGxigbFerzudL35KYiMQ6jR7Z+IvtxAPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJ//pM5iC3G93Qe5enbWzLmcwHns/7dEsJpSKwdk9GzgThBXZSL/htgw41EduGjAQAHWEXqwPeVH6JYVu8KVhQKB2zKTysPh9wvl4hAVuw5gKgkpzqx7+9zfKsH1SGwQLnqIxohrIqZqOolUZ0j363M/U1OzjxHc+d4Iznyg9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=ewGp5DTh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJNBnnMC; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id CB1C41140126;
	Sat, 16 Nov 2024 12:30:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sat, 16 Nov 2024 12:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731778225;
	 x=1731864625; bh=gebKZgGoCr+bken/kB1MDflE8lHODIfVqyMadWJhSPM=; b=
	ewGp5DTh5Q1vM0SOyaWeWUICwO+zoMx8bkQxjVxYDGNd9BEg/5bNIcE09IZTbQzK
	zyIm2j8yez9hzrVjFpD7QYZBIFYYK9ten+2+taovcYLyiWOC2NYvZxZFX6/huXhF
	F7DgnV/dsBms9yU3wnXVSS5rulx2kdN3p9DdHKDOXLiYZ6++FGpGWtswq1+pYmnZ
	Z7CYo4MB/W82rR8wVjTvlWIDZDFCRcBv6GYHj+NR9/U1LRIJySl6tIiLLKrtZH6I
	oKjQ6CTS1dz/FRkdfWhCJgyTyJsn6JzJN9/aYjSn6KbAklTTIJANHhGQzPZVHnbR
	8xw0AR8saR4JYJMNjWwNLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731778225; x=
	1731864625; bh=gebKZgGoCr+bken/kB1MDflE8lHODIfVqyMadWJhSPM=; b=O
	JNBnnMCmOi8z1HkePqa91VTIXDLRvCJWwTO8wZ6QioXZU8y1G6xYoBxXRNRkOyZ9
	0CGahPaP8Q+79lx1KmbHZPD0fK3Iglksdke8OaQnQM63dU4ixlZrRw7/2uAcLzhK
	NhXluaTTFmDgNr9fodiLR+HnQniHTnSNyV1e1bDtskfK9dKV9F88a93fruhTca/s
	yf1/0PDsbD540Q3tPKJw7/fPNR7GRs+EiiTLQgWmwSZNJ1w4JAiMCamH5QY/uhHS
	abJ13VhgKpm3QI7BdQMDQ8Bn3vbjq2rkMzMBslqv4mH6UFkFTXR6wz4yQtIPD9xz
	JYJscB7ex1aCJudQkODrA==
X-ME-Sender: <xms:sdY4Z0GRvaQ8dS6JrbzOdUsc-0EDYp7H2LaeYJxuGFBifl7F5NqsIw>
    <xme:sdY4Z9VaGQNlOghyqHypje-vecRhG7GENBxrqE7XYdyYZ8CMisUqWyBflkq5VFS20
    DKJFXORQSIAiSeUf0o>
X-ME-Received: <xmr:sdY4Z-JiI4PMi17tT_iAxwzKc9ZwXF0siHdx6cqqdbs8MsYWtakBixd0O9UeHz4dWUZGXdZfLjvd5FzmR4bSP2vtLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdelkecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:sdY4Z2GSIwpIX0AQ8tExg7auirTZ2_5FG4_yZpjYKNcT5GHFf1iJig>
    <xmx:sdY4Z6U9WJLhMBzSkORasHTPmjXGywiKTwoPYMCnBez2TaAELw1zkA>
    <xmx:sdY4Z5MZ9wERd4F2s5s_JmaBMn3d-GSc56fE-BwQqJt71O4QP53h4g>
    <xmx:sdY4Zx2HUVdDfzHDnAQBIjSqhw6UhxnD8iX-HZXm-7QEYZrwXU-vTQ>
    <xmx:sdY4Z1FEE_fddaugT1tCPQuHGh_hf56aqpjjvteBK6vC6bS4TjKgaiNL>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 12:30:24 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 2/2] thermal: rcar_gen3: Reuse logic to read fuses on Gen3 and Gen4
Date: Sat, 16 Nov 2024 18:29:34 +0100
Message-ID: <20241116172934.1829676-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116172934.1829676-1-niklas.soderlund+renesas@ragnatech.se>
References: <20241116172934.1829676-1-niklas.soderlund+renesas@ragnatech.se>
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
index 35b8ecb8877e..821b4405e346 100644
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


