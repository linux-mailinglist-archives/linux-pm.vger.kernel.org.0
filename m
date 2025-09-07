Return-Path: <linux-pm+bounces-34111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE12FB47C22
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 17:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650133ABE8D
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E0F277017;
	Sun,  7 Sep 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cWAiZK0+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SC9AHSrK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A2B15667D;
	Sun,  7 Sep 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757259735; cv=none; b=dwOXOp7HqSZyneKbDYk0gyLqXF8FG1plOCetp0x1DwwAOTd2YWGEXLjjU92cN+YFhur6jZjT48Z4CfQ199KAHcYikpJFGijuld/QtHoHhYJnFJ5mTw0slJNPUCb5p6jcu4fHDzuSsm4MY/hA45B4+DxoDehbTtflOZEQX3E8DL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757259735; c=relaxed/simple;
	bh=K7NJ68o8i0sSlMsAcTHigJ/Z7kn33sPqjLQuXKnkZAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vag/p/TMmdVv4WgDuu9zlHaBk8gKJ3cFkt5vr9GSJr7ysw2ikj+GLFObT8rJ7ti5GWuHEA00mNlgF23nFVV2sORsNeL6dYSwrOfhMG7scPOQl22rwSDRy4jwXhOWRKpp1w0sjUq13iX4ohtiCBHxpVWGjbD4aD705AAzaTfiMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cWAiZK0+; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SC9AHSrK; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cKZ8F3QG2z9sNt;
	Sun,  7 Sep 2025 17:42:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757259725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r8ZyPJlnK88y58nk5PDDlvvHiR6G9HAR+z7l0FP9g8M=;
	b=cWAiZK0+l4h0XvJXgSLiAS8NgFP78J66iixaOEiqPVMNUz+U7KMUCuFcSw+rw3bPJEMQaN
	kM5XhCOynHe86PZgQJVokb4gfTT3EWLfV0SGeviBO6LjV9lBAl6Vjr3Lx/9UHwNskTqNuZ
	l3dhIgXrHTJfpRsWprT3+FXpChNLQShJ35sOO+2vS1G4JvZfgQ0b4m1nEytd0ObiAGkL85
	jVseyPWwsvP/QO0PmPQ/ShkfnuQ1538wV/27fxHlhoPgC9xHjKFiX72usEuOKsjdAnQkkQ
	vEqULhAamXrau4R3tDqHJp2uUENEl3TnKLsWmr+VPM23ZJQghwgaGCFM2sxXMw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=SC9AHSrK;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757259723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r8ZyPJlnK88y58nk5PDDlvvHiR6G9HAR+z7l0FP9g8M=;
	b=SC9AHSrK9xzsCBCrrrUG1vAH/UYNhSTkhY6rWgSwhLjipANSNqiELzP4BCAoeXH2UaiBPJ
	Lf5HbknorM4Z2fwcDI6rej6P8927U7QKuoM7MiFvrPJLUaAJo6DJ4/1wXonW4oZZHOEZrD
	eoB+P9BoBCFLrjzOZWPCStp9xi+5EIbaMoJUm+8jYtBuTmI90oexsBOxEZsRIExTRCkrpI
	9Hf3w+BmgYzLtqeg2ntbpf3jRGbxQoquY7FGy5BMkBwX+VR+jlwgP6qjdOlFIqTMrF/WTh
	K4XhU7C2gsfqLfqfPYKSV2IqHuGfdB6eKMa7Ffn4KF33JTAh7+YaQWfbglismw==
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
Subject: [PATCH] thermal/drivers/rcar_gen3: Fix comment typo
Date: Sun,  7 Sep 2025 17:41:38 +0200
Message-ID: <20250907154148.171496-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 854210152853a8b1908
X-MBO-RS-META: k3qby57p35eqdwjxhsp6d534hgui11c6
X-Rspamd-Queue-Id: 4cKZ8F3QG2z9sNt

Fix typo to millidegree Celsius. This aligns the comment with
another comment later on the same function. No functional change.

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
NOTE: Sent with -U25 for the extra context which spans both comments,
      the later one is at the end.
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 45151a1733a94..af0bfe2555cb7 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -149,51 +149,51 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 
 static void rcar_gen3_thermal_shared_coefs(struct rcar_gen3_thermal_priv *priv)
 {
 	priv->tj_t =
 		DIV_ROUND_CLOSEST((priv->ptat[1] - priv->ptat[2]) * priv->info->scale,
 				  priv->ptat[0] - priv->ptat[2])
 		+ priv->info->adj_below;
 }
 static void rcar_gen3_thermal_tsc_coefs(struct rcar_gen3_thermal_priv *priv,
 					struct rcar_gen3_thermal_tsc *tsc)
 {
 	tsc->coef.below.a = priv->info->scale * (priv->ptat[2] - priv->ptat[1]);
 	tsc->coef.above.a = priv->info->scale * (priv->ptat[0] - priv->ptat[1]);
 
 	tsc->coef.below.b = (priv->ptat[2] - priv->ptat[0]) * (tsc->thcode[2] - tsc->thcode[1]);
 	tsc->coef.above.b = (priv->ptat[0] - priv->ptat[2]) * (tsc->thcode[1] - tsc->thcode[0]);
 }
 
 static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct rcar_gen3_thermal_tsc *tsc = thermal_zone_device_priv(tz);
 	struct rcar_gen3_thermal_priv *priv = tsc->priv;
 	const struct equation_set_coef *coef;
 	int adj, decicelsius, reg, thcode;
 
-	/* Read register and convert to mili Celsius */
+	/* Read register and convert to millidegree Celsius */
 	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
 
 	if (reg < tsc->thcode[1]) {
 		adj = priv->info->adj_below;
 		coef = &tsc->coef.below;
 		thcode = tsc->thcode[2];
 	} else {
 		adj = priv->info->adj_above;
 		coef = &tsc->coef.above;
 		thcode = tsc->thcode[0];
 	}
 
 	/*
 	 * The dividend can't be grown as it might overflow, instead shorten the
 	 * divisor to convert to decidegree Celsius. If we convert after the
 	 * division precision is lost as we will scale up from whole degrees
 	 * Celsius.
 	 */
 	decicelsius = DIV_ROUND_CLOSEST(coef->a * (thcode - reg), coef->b / 10);
 
 	/* Guaranteed operating range is -40C to 125C. */
 
 	/* Reporting is done in millidegree Celsius */
 	*temp = decicelsius * 100 + adj * 1000;
 
-- 
2.51.0


