Return-Path: <linux-pm+bounces-17305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A209C3925
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 08:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C26C1C21519
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 07:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A0715B14B;
	Mon, 11 Nov 2024 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="LtLskC1Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E5B67F;
	Mon, 11 Nov 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311279; cv=none; b=kwruPiZFx4skHd0LmRyBoggm+dwfD9cz5PjAnH5NvXUg+qzen0gHZ3yYfukWMNdILyy47UMCwZrdGI6tG+To67M3L0uZW9QpDLv1i6JPRjbmi474FVsLErzhVet9jXl2bNAgqOkFKPU1PxfBzavaUBKjBCGH9I7qg19qJP1UHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311279; c=relaxed/simple;
	bh=7O6l3W8jdtTHFsZPhIqdpPWwmQl3mjScIw0wphIRdpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvenMbiKrUmUkG6TU9B7JgjcMj6MyVgKK4hAfmTvN+OLJSyJG+oy7OTC49jTaAEQunJZpXhKZmHpTuO+Vd7YcAwCCT2fW9y5D8jtOkdJQ9Lz/zTozhp4rlg5pwGfP/v3P92Rw/9OvHuCJkU7dGlh5+e2DKO1s7M5jRU4hXHv1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=LtLskC1Q; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id AA7A3A03A7;
	Mon, 11 Nov 2024 08:47:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=4KBnznNW4mW6T1wsXkeA
	urj0zCpvuCLbvvtqL+9elhw=; b=LtLskC1QbGzjLUC0bsrVKJYe/I0+g2rZ1IGi
	x5IFpOvcbB7tp7K7uGEBJlpoH5LZKU/aAx7i1J9oDEx/vcS9Cut+CnBDUUv7guvl
	hCUXeBYh4AhGePNWQ7L9uOsVOwNIV4l+NB9R/M8+6izE8h1G1qLNBVWPZ6ARTF7d
	r85xsdI8jiRnN1/UykWtONcxCyO5DBCXOGzmVNNrVeVrtvy88WAlhb45C6CAOT/o
	HiMiQLP8u2zz5X+Wn+z52mcccwISDe+KDkVCmKoJH+qBltdmzPFGVniCiRObEMRO
	3MZ7ZSkarwjGBWNaiCz5QVQ1pmBMU3KcjJeG73w3m2REhnzPwb+TW8z/AZW1SiM9
	lew4vcV4JRh/GkjSfpdaRhA6xEEpJ5L/+NCYCl38EHFAovtujCQGFBz/7t7mBlYE
	dH2D37ffTCAMuWGpOtQRwnVqC9/zg8MuY99CZaVdGFjwusfJu4yPf2EGdOV3Kglg
	BI9LmNdUFjvJCNS3njm4fRoTrNoQtFPusxqrUvgpy6U/fKwCpcoxkhz9788er3Kc
	CH6EdEQQV1UgHbPa2KVZuMIRSzD6Qxv+HcgvPzZAIMKcLgLbHzjgRbEB0+YMuHWW
	MeHBzWZPVM+OPBS6PuYfvwOBovvi+W3+t75gw1JRwKcJNSyh7+kAyizMGvkpqcpZ
	oLMUwdQ=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Samuel
 Holland" <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v4 3/7] power: ip5xxx_power: Allow for more parameters to be configured
Date: Mon, 11 Nov 2024 08:47:16 +0100
Message-ID: <20241111074720.1727163-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111074720.1727163-1-csokas.bence@prolan.hu>
References: <20241111074720.1727163-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1731311267;VERSION=7980;MC=599170532;ID=287557;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485561716B

Other parts such as IP5306 may support other battery voltages and
have different constants for input voltage regulation. Allow these
to be passed from `struct ip5xxx_regfield_config`.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 40 ++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 41d91504eb32..a55441f87cc1 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -96,6 +96,18 @@ struct ip5xxx {
 			struct regmap_field *present;
 		} wled;
 	} regs;
+
+	/* Maximum supported battery voltage (via regs.battery.type) */
+	int vbat_max;
+	/* Scaling constants for regs.boost.undervolt_limit */
+	struct {
+		int setpoint;
+		int microvolts_per_bit;
+	} boost_undervolt;
+	/* Scaling constants for regs.charger.const_curr_sel */
+	struct {
+		int setpoint;
+	} const_curr;
 };
 
 /* Register fields layout. Unsupported registers marked as { .lsb = 1 } */
@@ -133,6 +145,12 @@ struct ip5xxx_regfield_config {
 	const struct reg_field wled_enable;
 	const struct reg_field wled_detect_en;
 	const struct reg_field wled_present;
+
+	int vbat_max;
+	int boost_undervolt_setpoint;
+	int boost_undervolt_uv_per_bit;
+	int const_curr_setpoint;
+	u8  chg_end_inverted;
 };
 
 /*
@@ -328,6 +346,9 @@ static int ip5xxx_battery_get_voltage_max(struct ip5xxx *ip5xxx, int *val)
 	if (ret)
 		return ret;
 
+	if (*val > ip5xxx->vbat_max)
+		return -EINVAL;
+
 	/*
 	 * It is not clear what this will return if
 	 * IP5XXX_CHG_CTL4_BAT_TYPE_SEL_EN is not set...
@@ -422,7 +443,7 @@ static int ip5xxx_battery_get_property(struct power_supply *psy,
 		if (ret)
 			return ret;
 
-		val->intval = 100000 * rval;
+		val->intval = ip5xxx->const_curr.setpoint + 100000 * rval;
 		return 0;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
@@ -515,7 +536,7 @@ static int ip5xxx_battery_set_property(struct power_supply *psy,
 		return ip5xxx_battery_set_voltage_max(ip5xxx, val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		rval = val->intval / 100000;
+		rval = (val->intval - ip5xxx->const_curr.setpoint) / 100000;
 		return ip5xxx_write(ip5xxx, ip5xxx->regs.charger.const_curr_sel, rval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
@@ -581,7 +602,8 @@ static int ip5xxx_boost_get_property(struct power_supply *psy,
 		if (ret)
 			return ret;
 
-		val->intval = 4530000 + 100000 * rval;
+		val->intval = ip5xxx->boost_undervolt.setpoint +
+			      ip5xxx->boost_undervolt.microvolts_per_bit * rval;
 		return 0;
 
 	default:
@@ -606,7 +628,8 @@ static int ip5xxx_boost_set_property(struct power_supply *psy,
 		return ip5xxx_write(ip5xxx, ip5xxx->regs.boost.enable, !!val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		rval = (val->intval - 4530000) / 100000;
+		rval = (val->intval - ip5xxx->boost_undervolt.setpoint) /
+			ip5xxx->boost_undervolt.microvolts_per_bit;
 		return ip5xxx_write(ip5xxx, ip5xxx->regs.boost.undervolt_limit, rval);
 
 	default:
@@ -670,6 +693,10 @@ static struct ip5xxx_regfield_config ip51xx_fields = {
 	.wled_enable = REG_FIELD(0x01, 3, 3),
 	.wled_detect_en = REG_FIELD(0x01, 4, 4),
 	.wled_present = REG_FIELD(0x72, 7, 7),
+
+	.vbat_max = 4350000,
+	.boost_undervolt_setpoint = 4530000,
+	.boost_undervolt_uv_per_bit = 100000,
 };
 
 #define ip5xxx_setup_reg(_field, _reg) \
@@ -718,6 +745,11 @@ static void ip5xxx_setup_regs(struct device *dev, struct ip5xxx *ip5xxx,
 	ip5xxx_setup_reg(wled_enable, wled.enable);
 	ip5xxx_setup_reg(wled_detect_en, wled.detect_en);
 	ip5xxx_setup_reg(wled_present, wled.present);
+
+	ip5xxx->vbat_max = cfg->vbat_max;
+	ip5xxx->boost_undervolt.setpoint = cfg->boost_undervolt_setpoint;
+	ip5xxx->boost_undervolt.microvolts_per_bit = cfg->boost_undervolt_uv_per_bit;
+	ip5xxx->const_curr.setpoint = cfg->const_curr_setpoint;
 }
 
 static int ip5xxx_power_probe(struct i2c_client *client)
-- 
2.34.1



