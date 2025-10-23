Return-Path: <linux-pm+bounces-36699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF81BFFDC0
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8363ABD2F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8012F83AC;
	Thu, 23 Oct 2025 08:20:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0221C2F39B5;
	Thu, 23 Oct 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207645; cv=none; b=ogQVfY+LMobcYy2KQPCNzFIC30YEfi9YftnPs7aGooxuQ9+peVgF//w0//8aj756nDmESyPDNAC/dXxs0mK7ou982rHyFhMLtyUxBoiea3a8xjJM6Twn2ftYrdahnCKCRTnBeVsJX/1A1qgVUUAQZ9O9gwMAROvxKOuqArEAt4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207645; c=relaxed/simple;
	bh=MkbSgS4YkR93ogcEb+XS3z4L8GDw28CMziq/2/JDNmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfE1thGsvcEj/6fb0MomndG8KLl6p7ouIHmVRSF52dliCqbmhM5/ipZGI1wD0YX5p4N300wExCpqB90QnlyQYgOrXTgScoAn4ovswtXfHR3B+HQdoTX45wHcmQnU9/RSSyR1tYxQLJG7t5IW8tN0SZRsx5fauuGKbF5VVkuVr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: sze8qMMUReyzy9kyg3LcOA==
X-CSE-MsgGUID: wqceSkWbRlaxJV+DuS0Bfw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Oct 2025 17:20:41 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 375AC417CA94;
	Thu, 23 Oct 2025 17:20:35 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 06/10] thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
Date: Thu, 23 Oct 2025 11:19:20 +0300
Message-ID: <20251023081925.2412325-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
temperature calibration via SMC SIP and do not have a reset for the
TSU peripheral, and use different minimum and maximum temperature values
compared to the already supported RZ/G3E.

Although the calibration data is stored in an OTP memory, the OTP itself
is not memory-mapped, access to it is done through an OTP controller.

The OTP controller is only accessible from the secure world,
but the temperature calibration data stored in the OTP is exposed via
SMC.

Add support for retrieving the calibration data using arm_smcc_smc().

Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index d2525ad3ffcc..efd09c35b216 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -72,6 +72,10 @@
 
 #define TSU_TEMP_MASK		GENMASK(11, 0)
 
+#define RZ_SIP_SVC_GET_SYSTSU	0x82000022
+#define OTP_TSU_REG_ADR_TEMPHI	0x01DC
+#define OTP_TSU_REG_ADR_TEMPLO	0x01DD
+
 struct rzg3e_thermal_priv;
 
 struct rzg3e_thermal_info {
@@ -381,6 +385,21 @@ static int rzg3e_thermal_get_syscon_trim(struct rzg3e_thermal_priv *priv)
 	return 0;
 }
 
+static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv *priv)
+{
+	struct arm_smccc_res local_res;
+
+	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
+		      0, 0, 0, 0, 0, 0, &local_res);
+	priv->trmval0 = local_res.a0 & TSU_TEMP_MASK;
+
+	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPHI,
+		      0, 0, 0, 0, 0, 0, &local_res);
+	priv->trmval1 = local_res.a0 & TSU_TEMP_MASK;
+
+	return 0;
+}
+
 static int rzg3e_thermal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -539,8 +558,15 @@ static const struct rzg3e_thermal_info rzg3e_thermal_info = {
 	.temp_e_mc = 126000,
 };
 
+static const struct rzg3e_thermal_info rzt2h_thermal_info = {
+	.get_trim = rzg3e_thermal_get_smc_trim,
+	.temp_d_mc = -40000,
+	.temp_e_mc = 125000,
+};
+
 static const struct of_device_id rzg3e_thermal_dt_ids[] = {
 	{ .compatible = "renesas,r9a09g047-tsu", .data = &rzg3e_thermal_info },
+	{ .compatible = "renesas,r9a09g077-tsu", .data = &rzt2h_thermal_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg3e_thermal_dt_ids);
-- 
2.51.1.dirty


