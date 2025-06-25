Return-Path: <linux-pm+bounces-29530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230B9AE8C2C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 20:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9FB4A616D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 18:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86282D5436;
	Wed, 25 Jun 2025 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OEvezP42";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dTc7ONhb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37832D5C8D;
	Wed, 25 Jun 2025 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875488; cv=none; b=ohAleVt/MEc9kpnEetMxLGSmF36O67nQ4kTjlkZ3LyDVSAIRMmw9kEcj6MjthSMtaz6lHdfGqNn+jIJ4p27w/HcAirxMjH/QCojbwZjZh2wBRYw5zeCHonzZadZHWkdaqCbJDBWYY5m8dGru043p8LSy4PDv3dKzCk5z9eEaMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875488; c=relaxed/simple;
	bh=W/zbPpbf0RvPEMTTCTLW12hN74dRuApMwJ7JDHdUseg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nvQ7tpP/b43VetE+FYtnXJ6l6DmNKod2R8Fn5b5cKdUdKFYzo2BeahNVRmx3aIBUSCeUitfX/8Jp3/KBgkATN/bz6oKWaYRunUa0AV7eFcF11s3Ka1BMLO4eNGvvwS3kXjCc6G+TKvpZinPsZBoF8A6GanTWgCaM/M9zPCJ5W+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OEvezP42; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dTc7ONhb; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bS96H2Hrkz9tdq;
	Wed, 25 Jun 2025 20:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750875479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bwkEg6xzPXySEtSLWRflCbZ9TrAwuDzKxLBcHCDf3+g=;
	b=OEvezP42eSR8jz8C+AIx5Z9xYQfGWdxCJoIDC4n6Q+lwyvajnWkGXWbJIBIBgjhMZrFmd9
	7zjYMLUhR/eLDhbJp7YQXr4/3YQyYKF+Vpnhnmp7lKHsmgpAwMKErWJQoLPHCXcWH0UTAm
	Qc1yc8dpHkgvDuwdCg1vZQlYYugfDIRBDFgJOCy2a3uLKwBcebyfbrgwwb+NIAwPUMCJnp
	beEcqD8/Z1ppl4oNM0r8NktvkRN4FRgoSFpEkPQol0U+zzqua+wyvIL37a+rAhuMzH4g+0
	ebHSKWSBCoaIqaMgTX4oxj3m8T3kXcUZAE2lQwBfKdM47eeDFykQ57v7UmM56Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750875477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bwkEg6xzPXySEtSLWRflCbZ9TrAwuDzKxLBcHCDf3+g=;
	b=dTc7ONhb/cMvQ34/cuN2vTHpC3rBGJXgX7eHzkYlLHxMNF1QU+eYhBaJBxIAIqxB0L2Gxo
	E2cEFmxHvUS9Ygp1PoVWTIPsDmy2Z4knC0tUN+iPKGuN+NHd2uDWkk/6AsCzXggFNk+BwM
	W1uiKcThS1NdOVaFmPyvFDshXzybtFCJms9KDc+qWn6RSdqC4Gk8sU+ALhPdu3ufaeCRWG
	P/tuKkTv1NNrw/WBCKJgzBja4loUu70nVpaFhHDu6Xngbd0jAoF1H+FHYFheTtsTk1zoTH
	+DKUx0thdRpIdvD+LXn6E8wIcqm8d8doijYil+FBSq3xUsHehX03GBwwu+buZQ==
To: linux-pm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 1/2] thermal: rcar_gen3: Add support for per-SoC default trim values
Date: Wed, 25 Jun 2025 20:16:57 +0200
Message-ID: <20250625181739.28391-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f54eb5a1f0d9a894733
X-MBO-RS-META: 18e7xn8q8jtt1pzuuhueajpxgth6w58r
X-Rspamd-Queue-Id: 4bS96H2Hrkz9tdq

The Working Sample R-Car SoCs may not yet have thermal sensor trimming
values programmed into fuses, those fuses are blank instead. For such
SoCs, the driver includes fallback trimming values. Those values are
currently applied to all SoCs which use this driver.

Introduce support for per-SoC fallback trimming values in preparation
for SoCs which do not use these current trimming values. No functional
change is intended here.

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
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
V2: - :%s@\<rcar_gen3_thermal_fuse_default_info\>@rcar_gen3_thermal_fuse_default@g
    - Put rcar_gen3_thermal_fuse_default_info_gen3 on single line
    - Add RB from Niklas
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 41 ++++++++++++++-------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 24a702ee4c1f..413b373523e4 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -73,11 +73,17 @@ struct rcar_gen3_thermal_fuse_info {
 	u32 mask;
 };
 
+struct rcar_gen3_thermal_fuse_default {
+	u32 ptat[3];
+	u32 thcodes[TSC_MAX_NUM][3];
+};
+
 struct rcar_thermal_info {
 	int scale;
 	int adj_below;
 	int adj_above;
 	const struct rcar_gen3_thermal_fuse_info *fuses;
+	const struct rcar_gen3_thermal_fuse_default *fuse_defaults;
 };
 
 struct equation_set_coef {
@@ -289,6 +295,7 @@ static void rcar_gen3_thermal_fetch_fuses(struct rcar_gen3_thermal_priv *priv)
 
 static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 {
+	const struct rcar_gen3_thermal_fuse_default *fuse_defaults = priv->info->fuse_defaults;
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
@@ -361,11 +360,23 @@ static const struct rcar_gen3_thermal_fuse_info rcar_gen3_thermal_fuse_info_gen4
 	.mask = GEN4_FUSE_MASK,
 };
 
+static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_default_info_gen3 = {
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
@@ -373,6 +384,7 @@ static const struct rcar_thermal_info rcar_gen3_thermal_info = {
 	.adj_below = -41,
 	.adj_above = 126,
 	.fuses = &rcar_gen3_thermal_fuse_info_gen3,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
 };
 
 static const struct rcar_thermal_info rcar_gen4_thermal_info = {
@@ -380,6 +392,7 @@ static const struct rcar_thermal_info rcar_gen4_thermal_info = {
 	.adj_below = -41,
 	.adj_above = 126,
 	.fuses = &rcar_gen3_thermal_fuse_info_gen4,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
 };
 
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
-- 
2.47.2


