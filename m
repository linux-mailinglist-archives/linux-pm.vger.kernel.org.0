Return-Path: <linux-pm+bounces-40492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB3DD04A84
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 18:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CA3F303E0ED
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D374D23645D;
	Thu,  8 Jan 2026 16:55:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2325392A;
	Thu,  8 Jan 2026 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891317; cv=none; b=G9eB1vpbedZxmnEsIf6jL1c6UmSRLkqKMOGnPhokBOMJ7ssaG2S5golE6q50j07+t4GS5oYOwwj71namsgkZTVO6dhSScUHqwjb8qP+CUPS4vteS6jbaQTV2B37aZIdKnOpY+FHMZN56kS9g4DpQ8HIrU4ID0CE+zU3aIJBfOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891317; c=relaxed/simple;
	bh=9GaYbDl06I3YClJ+EoXI5k8smm2kY0F6rU6kYhqu3VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOAGKlm+g/t2EGTZHHvrgzCJpD/Ayh8eHqtGD4wuRQgFKj1J9LO7c0fAE0H4iWTKIKn6UVzYXv09VqJKNtKbHjebePpoXTEpXhr/KtOzlEtZu1TueO11Yt2y8FYwhR+gc1dppn0O5AKGvkItdMhypA29Zsaw39IARTSmm6SiiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: yiuLw3wxRL+xmaxlX4ENSw==
X-CSE-MsgGUID: 2Fv8Ua9iTo2d+niJwQtFFw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jan 2026 01:55:11 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.68])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 17FA240313E8;
	Fri,  9 Jan 2026 01:55:06 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v4 5/5] thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
Date: Thu,  8 Jan 2026 18:53:24 +0200
Message-ID: <20260108165324.11376-6-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108165324.11376-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260108165324.11376-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V4:
 * pick up John's Reviewed-by and Tested-by
 * replace new macro TSU_TEMP_MASK usage with existing macro
   TSU_CODE_MAX

V3:
 * no changes

V2:
 * no changes

 drivers/thermal/renesas/rzg3e_thermal.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index c1b586128fa6..ba13ca8cbb8c 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -70,6 +70,10 @@
 #define TSU_POLL_DELAY_US	10	/* Polling interval */
 #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
 
+#define RZ_SIP_SVC_GET_SYSTSU	0x82000022
+#define OTP_TSU_REG_ADR_TEMPHI	0x01DC
+#define OTP_TSU_REG_ADR_TEMPLO	0x01DD
+
 struct rzg3e_thermal_priv;
 
 struct rzg3e_thermal_info {
@@ -362,6 +366,21 @@ static int rzg3e_thermal_get_syscon_trim(struct rzg3e_thermal_priv *priv)
 	return 0;
 }
 
+static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv *priv)
+{
+	struct arm_smccc_res local_res;
+
+	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
+		      0, 0, 0, 0, 0, 0, &local_res);
+	priv->trmval0 = local_res.a0 & TSU_CODE_MAX;
+
+	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPHI,
+		      0, 0, 0, 0, 0, 0, &local_res);
+	priv->trmval1 = local_res.a0 & TSU_CODE_MAX;
+
+	return 0;
+}
+
 static int rzg3e_thermal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -524,8 +543,15 @@ static const struct rzg3e_thermal_info rzg3e_thermal_info = {
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
2.52.0

