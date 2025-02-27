Return-Path: <linux-pm+bounces-23067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D061AA47DBF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 13:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EDF7A8E29
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1A22F3BD;
	Thu, 27 Feb 2025 12:25:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B345C22F39C;
	Thu, 27 Feb 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659144; cv=none; b=NJ+Bac9PfR0N0N7AsaM8/w7gJVZuJmA+G3fbOnKdtf5ncpZ2u+oNMcl5Ew+WDF96MDhMRA7gJ2KjRyCTy9SXt0FPU4lHXN1VnClMSAlkrNWeXIcDvWHjGL7mqOtaYhKVSyybk0GWOR/gKDueAV5Y8SrpgzzbkHUcgq7zaDL7Bqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659144; c=relaxed/simple;
	bh=iiZTxlZ4v9CBxD38DMq3wM8RKawmOzPy97ICG5RNomo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuMOA6NgiNG0zJ74Q92B2fYechGRpDPn2Wi33yL2Zlo/1vTlAF/o5XdfpAIWcPdod4v95ocB1OHkSaJaVwGtsLJh+Kbf7EVZEC+uzVdkLvd+5l9Og1Mc76C2afiGYOBh+Dhu+lbXwEY8EJhW07WLhHg8RlHsZ52M1hHbyMBm4tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: yBFGoVt4TKauLojNfmO+9g==
X-CSE-MsgGUID: TYxiKB1vSN+0/gxkx2XnNw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Feb 2025 21:25:42 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.68])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4EFEF4007D01;
	Thu, 27 Feb 2025 21:25:35 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: john.madieu.xa@bp.renesas.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: john.madieu@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	biju.das.jz@bp.renesas.com
Subject: [PATCH v2 5/7] thermal: renesas: rzg3e: Add safety check when reading temperature
Date: Thu, 27 Feb 2025 13:24:41 +0100
Message-ID: <20250227122453.30480-6-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Becaure reading temperature may fail, add mechanism to panic in case
reading the temperature fails after a given number of trials. This is due
to the thermal core disabling the thermal zone device after a couple of
consecutive attempt failures.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
v1 -> v2: no changes

 drivers/thermal/renesas/rzg3e_thermal.c | 38 +++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index be9e1d118a67..ff80d1b517c8 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -83,6 +83,19 @@
 #define TSU_TIMEOUT_US		10000
 #define TSU_MIN_CLOCK_RATE	24000000
 
+/*
+ * Number of consecutive errors before shutdown
+ *
+ * While simulating thermal sensor failure, we have noticed that the thermal
+ * core tries to fetch the temperature a couple times and then disable the
+ * thermal zone device. In case of extreme heat, this might lead to SoC
+ * destruction.
+ *
+ * Let's prevent this by limitating the number of failure and panic in
+ * case it happens.
+ */
+#define MAX_TEMP_READ_ERRORS       10
+
 /**
  * struct rzg3e_thermal_priv - RZ/G3E thermal private data structure
  * @base: TSU base address
@@ -93,6 +106,7 @@
  * @conv_complete: ADC conversion completion
  * @reg_lock: protect shared register access
  * @cached_temp: last computed temperature (milliCelsius)
+ * @error_count: Track consecutive errors
  * @trmval: trim (calibration) values
  */
 struct rzg3e_thermal_priv {
@@ -104,6 +118,7 @@ struct rzg3e_thermal_priv {
 	struct completion conv_complete;
 	spinlock_t reg_lock;
 	int cached_temp;
+	atomic_t error_count;
 	u32 trmval[2];
 };
 
@@ -200,6 +215,7 @@ static irqreturn_t rzg3e_thermal_adc_irq(int irq, void *dev_id)
 static int rzg3e_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 {
 	struct rzg3e_thermal_priv *priv = thermal_zone_device_priv(zone);
+	int error_count;
 	u32 val;
 	int ret;
 
@@ -217,7 +233,7 @@ static int rzg3e_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 					TSU_POLL_DELAY_US, TSU_TIMEOUT_US);
 	if (ret) {
 		dev_err(priv->dev, "ADC conversion timed out\n");
-		return ret;
+		goto handle_error;
 	}
 
 	/* Start conversion */
@@ -225,15 +241,33 @@ static int rzg3e_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 
 	if (!wait_for_completion_timeout(&priv->conv_complete,
 					 msecs_to_jiffies(100))) {
+		ret = -ETIMEDOUT;
 		dev_err(priv->dev, "ADC conversion completion timeout\n");
-		return -ETIMEDOUT;
+		goto handle_error;
 	}
 
 	scoped_guard(spinlock_irqsave, &priv->reg_lock) {
 		*temp = priv->cached_temp;
 	}
 
+	/* Reset error count on successful read */
+	atomic_set(&priv->error_count, 0);
 	return 0;
+
+handle_error:
+	error_count = atomic_inc_return(&priv->error_count);
+	if (error_count >= MAX_TEMP_READ_ERRORS) {
+		dev_emerg(priv->dev,
+			"Failed to read temperature %d times, initiating emergency shutdown\n",
+			error_count);
+		mdelay(100);
+		panic("Temperature sensor failure - emergency shutdown");
+	}
+
+	dev_err(priv->dev, "Failed to read temperature (error %d), attempt %d/%d\n",
+		ret, error_count, MAX_TEMP_READ_ERRORS);
+
+	return ret;
 }
 
 /* Convert temperature in milliCelsius to raw sensor code */
-- 
2.25.1


