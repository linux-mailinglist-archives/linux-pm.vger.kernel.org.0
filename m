Return-Path: <linux-pm+bounces-29489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D50AE7E65
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 12:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528E13B7B2B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2800F29C34E;
	Wed, 25 Jun 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kagMj2Gv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nOe0EyDx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99929B226;
	Wed, 25 Jun 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845706; cv=none; b=dI1YoMldGOvpQKnSTNJLVlt9qlsDCCiQtufojUbpzqRyCzKvMBXAoMwBxWcmeIVxW8Ld/vXpnbruwrLMaUNBOso5bwlzu9AGuzzcSU0V1c78IryMR89x8SgN2fIqJOY+xIlbRQa+N4/2g85bPuDGX3VJXXcEbFJvUA3dnAAHUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845706; c=relaxed/simple;
	bh=svphOZS307LIrrPIDuwxos4MBk44z9rlufFBMhm4U3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ahf6S2V7DxarMdCs73DUj2M3rBgFYvcMuo0jX4XyWIcqnwkpqQ6heDrUkdN1emhXeVDMXIzaXzpeBS5u7GHYWKI/+MGNABmGi6syejTtmHyeWrA678Fjajmq4QYEi8ghj2NQQ0Xw6WQn5pnwYJW7eY8o8wlCIs7bARVYRLUZZhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kagMj2Gv; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nOe0EyDx; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bRy5W5byLz9v0F;
	Wed, 25 Jun 2025 12:01:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750845695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hAvawe2U0y9jVamrDwvXMVw9fNVlgFW9WWVUGDRJ+aY=;
	b=kagMj2GvPcEQEy+SnL5yaQmTsIaFUm1H1xPewJv+w27hI2d6qDgDiLDR610tTIyAccuy6X
	d7GemU+HDH9fOPBEofw6QG1K5VxTQ0rH/dhgqLDgPZH6aJ+RuO2OBJXPO2h/r9mOUbHln1
	YC1uSFw7WxuBeFq2WTcgfccjCCs4BpapRHj+BFLRSUKICkZ/xUTX7eoTvDfXdr5AnesLq+
	xfzXTr5EdsLSkqI3J6EvBW7cVGcdIgs1P1HmtVNZ63SIKxgyl0B+9GZt0iMj1pX9f3vvjQ
	grgevuCGgPQqvUuzHzz0peTIwU3REQbg69avYUBf4+dUqVBv3TYNpTDn3ojrGg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750845693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hAvawe2U0y9jVamrDwvXMVw9fNVlgFW9WWVUGDRJ+aY=;
	b=nOe0EyDxiETTuM1Hp1O+H6NnqCt4tYnTYPLEGUN32L/qzPOW5aBsoxjA2pN4LqcCyqqe0T
	LWEesEO2h34cbasFyxxQG/JPXkFKvnQ8Cu9USFVaUdQNwQmw8yXFJCkDfkB6dmM837hwk5
	9M/nRvY8faVppBObggaw0A6cwUX8jLxKTnVSZzqmrkQ/5Z9T8AzpZ0L+nGTaCbRt0AwgT+
	nxWgQ5cNediZ+gfO14L1tHekGfL9gXMNE5RDsJuTMQFG5ZRqhDo/0DQvFTDjUNVU2Uf6aS
	y2KoIUYc4u4zy5LPB//q0NI19Kjpmgg3YmV5SyMSZgFJcui3qn3Vr2oa+/8JLQ==
To: linux-pm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] thermal: rcar_gen3: Add support for per-SoC default trim values
Date: Wed, 25 Jun 2025 11:59:58 +0200
Message-ID: <20250625100116.7538-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zjjs9toye7r3gqzsryx91u81t4pq7edm
X-MBO-RS-ID: 1eaaae78d78e9653239
X-Rspamd-Queue-Id: 4bRy5W5byLz9v0F

The Working Sample R-Car SoCs may not yet have thermal sensor trimming
values programmed into fuses, those fuses are blank instead. For such
SoCs, the driver includes fallback trimming values. Those values are
currently applied to all SoCs which use this driver.

Introduce support for per-SoC fallback trimming values in preparation
for SoCs which do not use these current trimming values. No functional
change is intended here.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 42 ++++++++++++++-------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 24a702ee4c1f..a388bd3135e4 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -73,11 +73,17 @@ struct rcar_gen3_thermal_fuse_info {
 	u32 mask;
 };
 
+struct rcar_gen3_thermal_fuse_default_info {
+	u32 ptat[3];
+	u32 thcodes[TSC_MAX_NUM][3];
+};
+
 struct rcar_thermal_info {
 	int scale;
 	int adj_below;
 	int adj_above;
 	const struct rcar_gen3_thermal_fuse_info *fuses;
+	const struct rcar_gen3_thermal_fuse_default_info *fuse_defaults;
 };
 
 struct equation_set_coef {
@@ -289,6 +295,7 @@ static void rcar_gen3_thermal_fetch_fuses(struct rcar_gen3_thermal_priv *priv)
 
 static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 {
+	const struct rcar_gen3_thermal_fuse_default_info *fuse_defaults = priv->info->fuse_defaults;
 	unsigned int i;
 	u32 thscp;
 
@@ -297,24 +304,16 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 	if (!priv->info->fuses ||
 	    (thscp & THSCP_COR_PARA_VLD) != THSCP_COR_PARA_VLD) {
 		/* Default THCODE values in case FUSEs are not set. */
-		static const int thcodes[TSC_MAX_NUM][3] = {
-			{ 3397, 2800, 2221 },
-			{ 3393, 2795, 2216 },
-			{ 3389, 2805, 2237 },
-			{ 3415, 2694, 2195 },
-			{ 3356, 2724, 2244 },
-		};
-
-		priv->ptat[0] = 2631;
-		priv->ptat[1] = 1509;
-		priv->ptat[2] = 435;
+		priv->ptat[0] = fuse_defaults->ptat[0];
+		priv->ptat[1] = fuse_defaults->ptat[1];
+		priv->ptat[2] = fuse_defaults->ptat[2];
 
 		for (i = 0; i < priv->num_tscs; i++) {
 			struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
-			tsc->thcode[0] = thcodes[i][0];
-			tsc->thcode[1] = thcodes[i][1];
-			tsc->thcode[2] = thcodes[i][2];
+			tsc->thcode[0] = fuse_defaults->thcodes[i][0];
+			tsc->thcode[1] = fuse_defaults->thcodes[i][1];
+			tsc->thcode[2] = fuse_defaults->thcodes[i][2];
 		}
 
 		return false;
@@ -361,11 +360,24 @@ static const struct rcar_gen3_thermal_fuse_info rcar_gen3_thermal_fuse_info_gen4
 	.mask = GEN4_FUSE_MASK,
 };
 
+static const struct rcar_gen3_thermal_fuse_default_info
+	rcar_gen3_thermal_fuse_default_info_gen3 = {
+	.ptat = { 2631, 1509, 435 },
+	.thcodes = {
+		{ 3397, 2800, 2221 },
+		{ 3393, 2795, 2216 },
+		{ 3389, 2805, 2237 },
+		{ 3415, 2694, 2195 },
+		{ 3356, 2724, 2244 },
+	},
+};
+
 static const struct rcar_thermal_info rcar_m3w_thermal_info = {
 	.scale = 157,
 	.adj_below = -41,
 	.adj_above = 116,
 	.fuses = &rcar_gen3_thermal_fuse_info_gen3,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
 };
 
 static const struct rcar_thermal_info rcar_gen3_thermal_info = {
@@ -373,6 +385,7 @@ static const struct rcar_thermal_info rcar_gen3_thermal_info = {
 	.adj_below = -41,
 	.adj_above = 126,
 	.fuses = &rcar_gen3_thermal_fuse_info_gen3,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
 };
 
 static const struct rcar_thermal_info rcar_gen4_thermal_info = {
@@ -380,6 +393,7 @@ static const struct rcar_thermal_info rcar_gen4_thermal_info = {
 	.adj_below = -41,
 	.adj_above = 126,
 	.fuses = &rcar_gen3_thermal_fuse_info_gen4,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
 };
 
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
-- 
2.47.2


