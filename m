Return-Path: <linux-pm+bounces-14830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75B79875E5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2EE1F27B0E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1EF149011;
	Thu, 26 Sep 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eixOsRh2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5E4142621
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361981; cv=none; b=CkgeaMzcKHX+uvlMnRhRzlQkDWPpV84fYO3abbcdJwzk30VBo613262YwzA3+aPhusrgQKD5HSEUJ7Vg7bBepXQg8sK1ShBPZW5GD9pEU/On+INg8PaBz/eL6awUtyp128VhiV4TnClrLISDsZa01uPzhrtsA6a6Ck7YTfJ1mB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361981; c=relaxed/simple;
	bh=6Dq4m0KU8HFl7HgUCWcdOyetC7wPu+vFt3xemJOkDCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TJsxSf8d6+wSbi1YOiWvRjRm2BXY9im3KjskiGU+4c+7id/rN7gobGJXeXE4GB8wt9EyccaUPzJYUCYJRmWe76OECKqZ/L3VENsIyBFiBIkEKwzNGqMcq+lopi/RtUHQjUUEAeplKGq5DunKPwwSxNxbk2FG3d1LXzPa1KDGIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eixOsRh2; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e042f4636dso711423b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727361979; x=1727966779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q3oii+Y14v4QUUmG0McaI/qXVEF0dPUXM0h4tdAPF8=;
        b=eixOsRh2Yc3ymxFoINXwFqdb+mgKU0DekHbG1ikt/Us1GcHzgXY05BMqWUP63z8sPU
         2B6p55rCqW52k5sheo1G8k1L/Z77ErtDtDwWIyifujVOFoExU9yFIfNfOXTsCOv+tSkM
         ydYKj2NaN77mq9/3uwdjs0FiQBbu7BCKDXIAues+XMdg1/vvkbN7ct2aoalFxu42Q3/q
         96qpwow/SzPZ7OLkZJkVcJo2D1FSENSyx3r/wUnl5jlcomn6ZOt+nZq1bwWM1iFKbZsZ
         65dxrwaEh+QOjwuy2uBruOHcE0/4bg6hxqMVx0jWsc70LKj8Q3XQE75OHbS7GEYWsKEB
         zRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727361979; x=1727966779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q3oii+Y14v4QUUmG0McaI/qXVEF0dPUXM0h4tdAPF8=;
        b=M/I9xs0ehdWC4BHKLALC2Gtus9XpXcSy9EuqQ0a/RCaT6GOB55CUCCBTQsqKP2A4vp
         U6CLEtqB3j3ILxfaPyZWibAwNLr7EQ3bZ4vMviWlc4ZJaiwOerFgMCx5YtLJzC427Zxf
         fSkeFmWGpySBuXB8HXY+n42Wo2CvUi4ItQQbeBt4GB8Ro5sHD0c/bTBszI8eXWEHqXyP
         GTcfpiF3ZbI5qwM3lfiEmSECRzJFpAz7ObAPPJtjH+pMclkw0BwaE9cKN5gPT9YmnJB4
         7PJzrO+uvnZduMWh4Hz+qeZ5QHotq5/Von0GxaTPPunYZ9ssVSUhybJ455pS6iRDbTRS
         XQZQ==
X-Gm-Message-State: AOJu0Yyj27YEXpMbrcBuD+cLjVMgyw8wPESuzsuDOX9F9xFkx1jVz3eT
	eBjUtZWvqxdKQG+49TqIePUoGI10VofWoeQl4JTOIgHNFAu1Si7CaSeglc6P
X-Google-Smtp-Source: AGHT+IF+yr7sQJ9/JDcYMMbOBV8UWPtA4+s3fJSaV0JjKz7wayWesuACBKH5eVe7VrJpBmMxh1EnGw==
X-Received: by 2002:a05:6808:f8f:b0:3e0:7530:2e90 with SMTP id 5614622812f47-3e29b79c374mr5374822b6e.24.1727361978983;
        Thu, 26 Sep 2024 07:46:18 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e39358753esm5268b6e.24.2024.09.26.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:46:18 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/2] power: supply: rk817: Update battery capacity calibration
Date: Thu, 26 Sep 2024 09:43:46 -0500
Message-Id: <20240926144346.94630-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926144346.94630-1-macroalpha82@gmail.com>
References: <20240926144346.94630-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

The battery capacity calibration function continues to be a source of
bugs for end users, especially when coming out of suspend. This occurs
when the device has incorrect readings for voltage, and causes the
current code to set fully charged capacity incorrectly.

Add checks to ensure we don't attempt a capacity calibration when we
have invalid voltage values or no battery present, and remove the code
that attempts to automatically set the fully charged capacity in lieu of
making the value writeable. This way userspace is able to adjust the
fully charged capacity for a degraded battery.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/rk817_charger.c | 101 +++++++++++++++------------
 1 file changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index d81fc7bd1cd2..958d375e1063 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -240,9 +240,32 @@ static int rk817_record_battery_nvram_values(struct rk817_charger *charger)
 static int rk817_bat_calib_cap(struct rk817_charger *charger)
 {
 	struct rk808 *rk808 = charger->rk808;
-	int tmp, charge_now, charge_now_adc, volt_avg;
+	int charge_now, charge_now_adc;
 	u8 bulk_reg[4];
 
+	/* Don't do anything if there's no battery. */
+	if (!charger->battery_present)
+		return 0;
+
+	/*
+	 * When resuming from suspend, sometimes the voltage value would be
+	 * incorrect. BSP would simply wait two seconds and try reading the
+	 * values again. Do not do any sort of calibration activity when the
+	 * reported value is incorrect. The next scheduled update of battery
+	 * vaules should then return valid data and the driver can continue.
+	 * Use 2.7v as the sanity value because per the datasheet the PMIC
+	 * can in no way support a battery voltage lower than this. BSP only
+	 * checked for values too low, but I'm adding in a check for values
+	 * too high just in case; again the PMIC can in no way support
+	 * voltages above 4.45v, so this seems like a good value.
+	 */
+	if ((charger->volt_avg_uv < 2700000) || (charger->volt_avg_uv > 4450000)) {
+		dev_dbg(charger->dev,
+			"Battery voltage of %d is invalid, ignoring.\n",
+			charger->volt_avg_uv);
+		return -EINVAL;
+	}
+
 	/* Calibrate the soc and fcc on a fully charged battery */
 
 	if (charger->charge_status == CHARGE_FINISH && (!charger->soc_cal)) {
@@ -304,51 +327,6 @@ static int rk817_bat_calib_cap(struct rk817_charger *charger)
 		}
 	}
 
-	/*
-	 * Calibrate the fully charged capacity when we previously had a full
-	 * battery (soc_cal = 1) and are now empty (at or below minimum design
-	 * voltage). If our columb counter is still positive, subtract that
-	 * from our fcc value to get a calibrated fcc, and if our columb
-	 * counter is negative add that to our fcc (but not to exceed our
-	 * design capacity).
-	 */
-	regmap_bulk_read(charger->rk808->regmap, RK817_GAS_GAUGE_BAT_VOL_H,
-			 bulk_reg, 2);
-	tmp = get_unaligned_be16(bulk_reg);
-	volt_avg = (charger->voltage_k * tmp) + 1000 * charger->voltage_b;
-	if (volt_avg <= charger->bat_voltage_min_design_uv &&
-	    charger->soc_cal) {
-		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
-				 bulk_reg, 4);
-		charge_now_adc = get_unaligned_be32(bulk_reg);
-		charge_now = ADC_TO_CHARGE_UAH(charge_now_adc,
-					       charger->res_div);
-		/*
-		 * Note, if charge_now is negative this will add it (what we
-		 * want) and if it's positive this will subtract (also what
-		 * we want).
-		 */
-		charger->fcc_mah = charger->fcc_mah - (charge_now / 1000);
-
-		dev_dbg(charger->dev,
-			"Recalibrating full charge capacity to %d uah\n",
-			charger->fcc_mah * 1000);
-	}
-
-	/*
-	 * Set the SOC to 0 if we are below the minimum system voltage.
-	 */
-	if (volt_avg <= charger->bat_voltage_min_design_uv) {
-		charger->soc = 0;
-		charge_now_adc = CHARGE_TO_ADC(0, charger->res_div);
-		put_unaligned_be32(charge_now_adc, bulk_reg);
-		regmap_bulk_write(rk808->regmap,
-				  RK817_GAS_GAUGE_Q_INIT_H3, bulk_reg, 4);
-		dev_warn(charger->dev,
-			 "Battery voltage %d below minimum voltage %d\n",
-			 volt_avg, charger->bat_voltage_min_design_uv);
-		}
-
 	rk817_record_battery_nvram_values(charger);
 
 	return 0;
@@ -648,6 +626,24 @@ static irqreturn_t rk817_plug_out_isr(int irq, void *cg)
 	return IRQ_HANDLED;
 }
 
+static int rk817_bat_set_prop(struct power_supply *ps,
+			      enum power_supply_property prop,
+			      const union power_supply_propval *val)
+{
+	struct rk817_charger *charger = power_supply_get_drvdata(ps);
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		if ((val->intval < 500000) ||
+			(val->intval > charger->bat_charge_full_design_uah))
+			return -EINVAL;
+		charger->fcc_mah = val->intval / 1000;
+		return rk817_bat_calib_cap(charger);
+	default:
+		return -EINVAL;
+	}
+}
+
 static enum power_supply_property rk817_bat_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_STATUS,
@@ -673,12 +669,25 @@ static enum power_supply_property rk817_chg_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_AVG,
 };
 
+static int rk817_bat_prop_writeable(struct power_supply *psy,
+				    enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static const struct power_supply_desc rk817_bat_desc = {
 	.name = "rk817-battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
 	.properties = rk817_bat_props,
+	.property_is_writeable	= rk817_bat_prop_writeable,
 	.num_properties = ARRAY_SIZE(rk817_bat_props),
 	.get_property = rk817_bat_get_prop,
+	.set_property = rk817_bat_set_prop,
 };
 
 static const struct power_supply_desc rk817_chg_desc = {
-- 
2.34.1


