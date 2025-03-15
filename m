Return-Path: <linux-pm+bounces-24092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F3EA628E7
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 09:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1462A176D2A
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 08:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676CD1F4706;
	Sat, 15 Mar 2025 08:17:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F431F4621;
	Sat, 15 Mar 2025 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742026679; cv=none; b=Qy6pOWvk1OK4qxT2c8900j5vq0hMvp8bf3l5A3lQCHLXYbTELVQX/LkEry8x/hE/Oo0/xyCogc/4jRtXuRfFsWVqjkEkKDnC2ZOWi2qlG1BJuYSzsN4XLM3oDJ1Ekky+SUSSinBUXOCupAKGNa7E5jQC8+tWhS/99xeK/CrdOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742026679; c=relaxed/simple;
	bh=8QBgTkKz3cFJL3hfoL1IzwRU4LKOJHZTLCz8cQgx5DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGh3qxTci6eUdIduOfL8yuVZCD6/jKO9w5fAFwx0mK+KUiC273JBMsyr3gHeebEpKTiJPH+r7YQLZhNy5h8Y07WXKnof+m+U+Zr2xzM7ox1ljmy6N/zyRNF8K+JsQKMsLe59Gnm/nqCzxYxt1D7tRUu5MwjFrmzav4xvSYVyLZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: uDpomQj8Q8ulFVlm2oW+UQ==
X-CSE-MsgGUID: DpuT2HaARgm2SpHw2aRewQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Mar 2025 17:12:54 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.58])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 35A9C41BFA47;
	Sat, 15 Mar 2025 17:12:49 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert+renesas@glider.be,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: magnus.damm@gmail.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	sboyd@kernel.org,
	biju.das.jz@bp.renesas.com,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v3 4/6] thermal: renesas: rzg3e: Add safety check when reading temperature
Date: Sat, 15 Mar 2025 09:12:14 +0100
Message-ID: <20250315081225.92118-5-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
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
v2 -> v3: no changes

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


