Return-Path: <linux-pm+bounces-7828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D255C8C4F70
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FBFFB20D82
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8208413FD63;
	Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hcvZ6eqt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5UTezXV"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC308126F1B
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681944; cv=none; b=uIBgqZe14m/SQ86SM5LKa3iQ6/KFBuoIFPGoRTHyoXFEvHYdebxvgLC7smI2eoWmeYTbCfDmMUOTV46pPJIHZnioCs3yBa21yYWSrqDI1MZCT+Gz4jJYaEUU8xxhpGOlCYttnUnpy3oHviEaJrPZKSLZTwElNsNvaIpeJEDou6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681944; c=relaxed/simple;
	bh=FoL0WuzKtn2rYYJGkRokp+uzKuPY1M8MSZ8j2tlFQ5E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HMxCT9YFAu+Qb4BWKtkMDYFPzi5DV3RF5iUvFGhB6t3wQQ/S0LMxCSXVwIWE2iATpibt1cmUOtGFt1GvU9v9eV/Iq93SEzRINyNU3HbyuF3ZtuwtIl7ntYpdOWT/Eo8pwv/ezp+z0dv+1sGr81QBwoKIc3TkVZF17bvcE/I8Jcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hcvZ6eqt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L5UTezXV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HG4q1IvALgomvKBjTvLy3Eq2cKMpqeS4hZ5L8tqVS3s=;
	b=hcvZ6eqtuC7JKs79GAfrXIuKU5vi4G55pfmR9tnkI6wJb1F0BhkG9R7sIfC/RlGZAAXPJh
	HMcIXvd9kkXPfsMs4Mj7xLBJUL8MDL3Na1MwIuxEDFQpp2P3WsDxLahdKb96fSGldhDiiy
	CV7OHeniuahicNouJ4GPzhLtXi0vePfT0EDHxuxpWrxhCiUZ0dYg7joevHOrdu8VZ95mww
	epcEwvu/piOOBXk9jHk1WqHoBb8zeOwNnQuadS8hoWkPjvtIWHTjAKGITakeneEWplasx8
	ouaPm4yHZA2PcA2MFLjO/iV7q99Qk0WA5grjSzl6PRuju0kdkVisBnbZ3jnRXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HG4q1IvALgomvKBjTvLy3Eq2cKMpqeS4hZ5L8tqVS3s=;
	b=L5UTezXVV3tt+Qe5A9TWebivW5twRWvEs8TWpawz3I7F+m4qCglYTwur7sfDPU8hzGNuNk
	FT/IePuVhywvRrAQ==
From: "thermal-bot for Priyansh Jain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/tsens: Add suspend to RAM
 support for tsens
Cc: Priyansh Jain <quic_priyjain@quicinc.com>,
 Amit Kucheria <amitk@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 rui.zhang@intel.com
In-Reply-To: <20240328050230.31770-1-quic_priyjain@quicinc.com>
References: <20240328050230.31770-1-quic_priyjain@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193566.10875.13980439413009124087.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     34b9a92b6850279145430af181d2d2dedb98cc76
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//34b9a92b6850279145430af181d2d2dedb98cc76
Author:        Priyansh Jain <quic_priyjain@quicinc.com>
AuthorDate:    Thu, 28 Mar 2024 10:32:30 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/tsens: Add suspend to RAM support for tsens

As part of suspend to RAM, tsens hardware will be turned off.
While resume callback, re-initialize tsens hardware.

Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
Acked-by: Amit Kucheria <amitk@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240328050230.31770-1-quic_priyjain@quicinc.com
---
 drivers/thermal/qcom/tsens-v2.c |  1 +
 drivers/thermal/qcom/tsens.c    | 31 +++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h    |  5 +++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 29a61d2..0cb7301 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -107,6 +107,7 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
 	.get_temp	= get_temp_tsens_valid,
+	.resume		= tsens_resume_common,
 };
 
 struct tsens_plat_data data_tsens_v2 = {
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6d7c16c..1c9df4f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -17,6 +17,7 @@
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/thermal.h>
 #include "../thermal_hwmon.h"
 #include "tsens.h"
@@ -1193,6 +1194,36 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 	return ret;
 }
 
+#ifdef CONFIG_SUSPEND
+static int tsens_reinit(struct tsens_priv *priv)
+{
+	if (tsens_version(priv) >= VER_2_X) {
+		/*
+		 * Re-enable the watchdog, unmask the bark.
+		 * Disable cycle completion monitoring
+		 */
+		if (priv->feat->has_watchdog) {
+			regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
+			regmap_field_write(priv->rf[CC_MON_MASK], 1);
+		}
+
+		/* Re-enable interrupts */
+		tsens_enable_irq(priv);
+	}
+
+	return 0;
+}
+
+int tsens_resume_common(struct tsens_priv *priv)
+{
+	if (pm_suspend_target_state == PM_SUSPEND_MEM)
+		tsens_reinit(priv);
+
+	return 0;
+}
+
+#endif /* !CONFIG_SUSPEND */
+
 static int tsens_register(struct tsens_priv *priv)
 {
 	int i, ret;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index cb637fa..cab39de 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -634,6 +634,11 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
 int init_common(struct tsens_priv *priv);
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
 int get_temp_common(const struct tsens_sensor *s, int *temp);
+#ifdef CONFIG_SUSPEND
+int tsens_resume_common(struct tsens_priv *priv);
+#else
+#define tsens_resume_common            NULL
+#endif
 
 /* TSENS target */
 extern struct tsens_plat_data data_8960;

