Return-Path: <linux-pm+bounces-17781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADCB9D2D95
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 19:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F86B36CA9
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E462F1D27B3;
	Tue, 19 Nov 2024 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="gBIlrp6m"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE31D26EE;
	Tue, 19 Nov 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039734; cv=none; b=rCrXq0vhwURPCa7JwNf6cLwpUNLmSSJ0Vhe2w+gwPSo0aQaoHNorDkJ/ypgtBE1VNjzn0uO7iqusAE4MH+ulDocgqcm4eWv1wJMEH36sSAtjjPCX5QH7dlxA/GPDDzcHWNMGgz+qJmDfePtZuDGwN/mnq/UDqMhUCpUziN6RpOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039734; c=relaxed/simple;
	bh=vuOOK+U5WrD7tWqN/sFbcO5YyAPBbBZbIjQiQcz6qJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJyT4uennfiI9G9ZNZrOkGpJn+UWRkQczsRGrB2W1bRBJnRjDWBEYq9enkmHu6fg3/c+t1GZv/QO0n+rCrsdjTyZ1f9nSQTRCgDrjGfdRr/7Ep2gx9g4M2vIs+RY3q3epzpdzymOK4eOLaJBZH44iwa1QcuiAkySUSsF7LeNA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=gBIlrp6m; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C394FA03F3;
	Tue, 19 Nov 2024 19:08:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=8bpGk/M9Syo4f0SQyoPf
	vzyT6m9JNNElUy7BTI2BHuA=; b=gBIlrp6mShrekk/BRZnFDwsl75SVpvp4j4YW
	mcFTiv+T+Bxq+M71hCxW9ci27CLs9TuXKSGetqtEN2Uro2icOaiaDuArF3BL7eDl
	VtFRypuccXSlbYISwf5S3i56F1UVsg0AIH0Ayx5rWygUny7Itkaf/5vmvOr+JEKd
	2GYFqVM0nHbpO7ygrTrhi2YL1WHCiYqVOQ5or7lk9ZeeQw36xuYqsqHssX6QN7PJ
	Ogwnmk45GLZQ16XvtoL21sRkuOlTRLq22u7sDG1XtQhl2ImQG91DkQ89VEL1e3Cl
	VUwhnHvpcuI7yMjoYkqhsS0tbvt1sQoOPFMJXfVYRtS/AHuxFEOlst/2S59L4ivR
	rIO98L8r3U7xbIdxygwpDI3cy9JhtmphLg/JLmmE+Nk4/r/k7XoUFL6CUZhmt44L
	66GeS6o5CLBz3GUhux9i/T/evnKLFVVFVM22D18ReQDMLuQFRfIB9auIa+R5AdWu
	Y5/7epgCu9Vry7RqnIYGNvtplcV1NPyJL5LA7x+gh9Dk+mBITUMHvXQjbqxc+35E
	ZqP3Pl6f7oZqsZ6qcl/PFSM8deDyiT18xBU4+xtY/+vp7qh7dWxUZ1XmsV65xESB
	nG8cZBNySeADMa2Wx1fFyHK4eLlSzyBhuUX7i4qZsNTAGqGTlOJsIjOW51JcpDOH
	VfQ3mSU=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Samuel
 Holland" <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v5 3/8] power: ip5xxx_power: Allow for more parameters to be configured
Date: Tue, 19 Nov 2024 19:07:35 +0100
Message-ID: <20241119180741.2237692-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119180741.2237692-1-csokas.bence@prolan.hu>
References: <20241119180741.2237692-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732039722;VERSION=7980;MC=2825214959;ID=46208;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560766B

Other parts such as IP5306 may support other battery voltages and
have different constants for input voltage regulation. Allow these
to be passed from `struct ip5xxx_regfield_config`.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 43 ++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 41d91504eb32..a939dbfe8d23 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -96,6 +96,20 @@ struct ip5xxx {
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
+	/* Whether regs.charger.chg_end is inverted */
+	u8 chg_end_inverted;
 };
 
 /* Register fields layout. Unsupported registers marked as { .lsb = 1 } */
@@ -133,6 +147,12 @@ struct ip5xxx_regfield_config {
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
@@ -328,6 +348,9 @@ static int ip5xxx_battery_get_voltage_max(struct ip5xxx *ip5xxx, int *val)
 	if (ret)
 		return ret;
 
+	if (*val > ip5xxx->vbat_max)
+		return -EINVAL;
+
 	/*
 	 * It is not clear what this will return if
 	 * IP5XXX_CHG_CTL4_BAT_TYPE_SEL_EN is not set...
@@ -422,7 +445,7 @@ static int ip5xxx_battery_get_property(struct power_supply *psy,
 		if (ret)
 			return ret;
 
-		val->intval = 100000 * rval;
+		val->intval = ip5xxx->const_curr.setpoint + 100000 * rval;
 		return 0;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
@@ -515,7 +538,7 @@ static int ip5xxx_battery_set_property(struct power_supply *psy,
 		return ip5xxx_battery_set_voltage_max(ip5xxx, val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		rval = val->intval / 100000;
+		rval = (val->intval - ip5xxx->const_curr.setpoint) / 100000;
 		return ip5xxx_write(ip5xxx, ip5xxx->regs.charger.const_curr_sel, rval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
@@ -581,7 +604,8 @@ static int ip5xxx_boost_get_property(struct power_supply *psy,
 		if (ret)
 			return ret;
 
-		val->intval = 4530000 + 100000 * rval;
+		val->intval = ip5xxx->boost_undervolt.setpoint +
+			      ip5xxx->boost_undervolt.microvolts_per_bit * rval;
 		return 0;
 
 	default:
@@ -606,7 +630,8 @@ static int ip5xxx_boost_set_property(struct power_supply *psy,
 		return ip5xxx_write(ip5xxx, ip5xxx->regs.boost.enable, !!val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		rval = (val->intval - 4530000) / 100000;
+		rval = (val->intval - ip5xxx->boost_undervolt.setpoint) /
+			ip5xxx->boost_undervolt.microvolts_per_bit;
 		return ip5xxx_write(ip5xxx, ip5xxx->regs.boost.undervolt_limit, rval);
 
 	default:
@@ -670,6 +695,10 @@ static struct ip5xxx_regfield_config ip51xx_fields = {
 	.wled_enable = REG_FIELD(0x01, 3, 3),
 	.wled_detect_en = REG_FIELD(0x01, 4, 4),
 	.wled_present = REG_FIELD(0x72, 7, 7),
+
+	.vbat_max = 4350000,
+	.boost_undervolt_setpoint = 4530000,
+	.boost_undervolt_uv_per_bit = 100000,
 };
 
 #define ip5xxx_setup_reg(_field, _reg) \
@@ -718,6 +747,12 @@ static void ip5xxx_setup_regs(struct device *dev, struct ip5xxx *ip5xxx,
 	ip5xxx_setup_reg(wled_enable, wled.enable);
 	ip5xxx_setup_reg(wled_detect_en, wled.detect_en);
 	ip5xxx_setup_reg(wled_present, wled.present);
+
+	ip5xxx->vbat_max = cfg->vbat_max;
+	ip5xxx->boost_undervolt.setpoint = cfg->boost_undervolt_setpoint;
+	ip5xxx->boost_undervolt.microvolts_per_bit = cfg->boost_undervolt_uv_per_bit;
+	ip5xxx->const_curr.setpoint = cfg->const_curr_setpoint;
+	ip5xxx->chg_end_inverted = cfg->chg_end_inverted;
 }
 
 static int ip5xxx_power_probe(struct i2c_client *client)
-- 
2.34.1



