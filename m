Return-Path: <linux-pm+bounces-13289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FCA967223
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BE9B21F70
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1617C7C1;
	Sat, 31 Aug 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8KPWcgk"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B543170A27
	for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725114091; cv=none; b=RCPRFi9ObmH06b3FO6GrSlkACLbCT49xEYiR3nbB+Q1+CKJf4N5yoLAEpXo5hZfWkr8f7d7hpfBceWVwJTXVJXyUK/1jsQsfCO0gz1n/Oj/ggNMFuIir2GAslK3BK96bSL2wr1Mknk+CGOOzL/IZhVAkKCtntIpJncUSdtvnTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725114091; c=relaxed/simple;
	bh=MoQfVPPSri47OxiryUK8FhlNWVXFwbIPcathpNHwoPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvOv84CBtHZ+HlNYOu+3XPKXYnL2182ds++XFIoV4qKQfMdjPZR7H5byvVSKI/1GQ9IJa0+sJ+V0YcFlMaIDB8CxpT6Mz1iv5O2sZY4dvTzZIFxzgzrm9VO5MEJGduxVoilYuQshNLRlyrupAvRjRWH+bqOM3yV24vMfkU6J5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8KPWcgk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725114087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnZoYL2d+p7AwIZZPmMmbvjdXDJ16rJ3VReMdEA9e+k=;
	b=E8KPWcgkL0GV0y22f/5+srq/dXrk7cjInrmTm/yHi02MEvKYgXxlRS6xNhEl9GLyi80uRk
	DgEeREVrKiZKX3JcBce5p/yDNgL608TvHo8t/2p3Ubiam9XX+imfA6lZ1JPk21JIjPJolf
	4QrMX4CnTr45dfs+n9p380zfiA9Dbmk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-zc_pK1DFMn6UEVJ23jPwBw-1; Sat,
 31 Aug 2024 10:21:20 -0400
X-MC-Unique: zc_pK1DFMn6UEVJ23jPwBw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B14521956048;
	Sat, 31 Aug 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4701030001A4;
	Sat, 31 Aug 2024 14:21:14 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Enric Balletbo Serra <enric.balletbo@collabora.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: [PATCH 6/6] power: supply: Change usb_types from an array into a bitmask
Date: Sat, 31 Aug 2024 16:20:39 +0200
Message-ID: <20240831142039.28830-7-hdegoede@redhat.com>
In-Reply-To: <20240831142039.28830-1-hdegoede@redhat.com>
References: <20240831142039.28830-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The bit_types array just hold a list of valid enum power_supply_usb_type
values which map to 0 - 9. This can easily be represented as a bitmap.

This reduces the size of struct power_supply_desc and further reduces
the data section size by drivers no longer needing to store the array.

This also unifies how usb_types are handled with charge_behaviours,
which allows power_supply_show_usb_type() to be removed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-cht-wc.c          | 15 +++----
 drivers/phy/ti/phy-tusb1210.c                 | 11 ++---
 drivers/power/supply/axp20x_usb_power.c       | 13 ++----
 drivers/power/supply/bq256xx_charger.c        | 15 +++----
 drivers/power/supply/cros_usbpd-charger.c     | 22 ++++------
 .../power/supply/lenovo_yoga_c630_battery.c   |  7 +---
 drivers/power/supply/mp2629_charger.c         | 15 +++----
 drivers/power/supply/mt6360_charger.c         | 13 ++----
 drivers/power/supply/mt6370-charger.c         | 13 ++----
 drivers/power/supply/power_supply_core.c      |  4 --
 drivers/power/supply/power_supply_sysfs.c     | 40 ++-----------------
 drivers/power/supply/qcom_battmgr.c           | 37 +++++++++--------
 drivers/power/supply/qcom_pmi8998_charger.c   | 13 ++----
 drivers/power/supply/rk817_charger.c          |  9 +----
 drivers/power/supply/rn5t618_power.c          | 13 ++----
 drivers/power/supply/rt9467-charger.c         | 13 ++----
 drivers/power/supply/rt9471.c                 | 15 +++----
 drivers/power/supply/ucs1002_power.c          | 15 +++----
 drivers/usb/typec/anx7411.c                   | 11 ++---
 drivers/usb/typec/rt1719.c                    | 11 ++---
 drivers/usb/typec/tcpm/tcpm.c                 | 11 ++---
 drivers/usb/typec/tipd/core.c                 |  9 +----
 drivers/usb/typec/ucsi/psy.c                  | 11 ++---
 include/linux/power_supply.h                  |  3 +-
 24 files changed, 102 insertions(+), 237 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 733c470c3102..93552dc3c895 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -461,14 +461,6 @@ static int cht_wc_extcon_psy_get_prop(struct power_supply *psy,
 	return 0;
 }
 
-static const enum power_supply_usb_type cht_wc_extcon_psy_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_ACA,
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-};
-
 static const enum power_supply_property cht_wc_extcon_psy_props[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -477,8 +469,11 @@ static const enum power_supply_property cht_wc_extcon_psy_props[] = {
 static const struct power_supply_desc cht_wc_extcon_psy_desc = {
 	.name = "cht_wcove_pwrsrc",
 	.type = POWER_SUPPLY_TYPE_USB,
-	.usb_types = cht_wc_extcon_psy_usb_types,
-	.num_usb_types = ARRAY_SIZE(cht_wc_extcon_psy_usb_types),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA) |
+		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 	.properties = cht_wc_extcon_psy_props,
 	.num_properties = ARRAY_SIZE(cht_wc_extcon_psy_props),
 	.get_property = cht_wc_extcon_psy_get_prop,
diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index 751fecd466e3..c3ae9d7948d7 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -411,12 +411,6 @@ static int tusb1210_psy_get_prop(struct power_supply *psy,
 	return 0;
 }
 
-static const enum power_supply_usb_type tusb1210_psy_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-};
-
 static const enum power_supply_property tusb1210_psy_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_USB_TYPE,
@@ -426,8 +420,9 @@ static const enum power_supply_property tusb1210_psy_props[] = {
 static const struct power_supply_desc tusb1210_psy_desc = {
 	.name = "tusb1211-charger-detect",
 	.type = POWER_SUPPLY_TYPE_USB,
-	.usb_types = tusb1210_psy_usb_types,
-	.num_usb_types = ARRAY_SIZE(tusb1210_psy_usb_types),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 	.properties = tusb1210_psy_props,
 	.num_properties = ARRAY_SIZE(tusb1210_psy_props),
 	.get_property = tusb1210_psy_get_prop,
diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 69fbb5861934..7b1bf6766ff7 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -456,13 +456,6 @@ static enum power_supply_property axp813_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 };
 
-static enum power_supply_usb_type axp813_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-};
-
 static const struct power_supply_desc axp20x_usb_power_desc = {
 	.name = "axp20x-usb",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -491,8 +484,10 @@ static const struct power_supply_desc axp813_usb_power_desc = {
 	.property_is_writeable = axp20x_usb_power_prop_writeable,
 	.get_property = axp20x_usb_power_get_property,
 	.set_property = axp20x_usb_power_set_property,
-	.usb_types = axp813_usb_types,
-	.num_usb_types = ARRAY_SIZE(axp813_usb_types),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 };
 
 static const char * const axp20x_irq_names[] = {
diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 1a935bc88510..5514d1896bb8 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -334,14 +334,6 @@ static const int bq25618_619_ichg_values[] = {
 	1290000, 1360000, 1430000, 1500000
 };
 
-static enum power_supply_usb_type bq256xx_usb_type[] = {
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-	POWER_SUPPLY_USB_TYPE_ACA,
-};
-
 static int bq256xx_array_parse(int array_size, int val, const int array[])
 {
 	int i = 0;
@@ -1252,8 +1244,11 @@ static int bq256xx_property_is_writeable(struct power_supply *psy,
 static const struct power_supply_desc bq256xx_power_supply_desc = {
 	.name = "bq256xx-charger",
 	.type = POWER_SUPPLY_TYPE_USB,
-	.usb_types = bq256xx_usb_type,
-	.num_usb_types = ARRAY_SIZE(bq256xx_usb_type),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA) |
+		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 	.properties = bq256xx_power_supply_props,
 	.num_properties = ARRAY_SIZE(bq256xx_power_supply_props),
 	.get_property = bq256xx_get_charger_property,
diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 8008e31c0c09..bed3e2e9bfea 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -73,17 +73,6 @@ static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
 
-static enum power_supply_usb_type cros_usbpd_charger_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-	POWER_SUPPLY_USB_TYPE_C,
-	POWER_SUPPLY_USB_TYPE_PD,
-	POWER_SUPPLY_USB_TYPE_PD_DRP,
-	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID
-};
-
 /* Input voltage/current limit in mV/mA. Default to none. */
 static u16 input_voltage_limit = EC_POWER_LIMIT_NONE;
 static u16 input_current_limit = EC_POWER_LIMIT_NONE;
@@ -643,9 +632,14 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 			psy_desc->properties = cros_usbpd_charger_props;
 			psy_desc->num_properties =
 				ARRAY_SIZE(cros_usbpd_charger_props);
-			psy_desc->usb_types = cros_usbpd_charger_usb_types;
-			psy_desc->num_usb_types =
-				ARRAY_SIZE(cros_usbpd_charger_usb_types);
+			psy_desc->usb_types = BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
+					      BIT(POWER_SUPPLY_USB_TYPE_SDP)     |
+					      BIT(POWER_SUPPLY_USB_TYPE_DCP)     |
+					      BIT(POWER_SUPPLY_USB_TYPE_CDP)     |
+					      BIT(POWER_SUPPLY_USB_TYPE_C)       |
+					      BIT(POWER_SUPPLY_USB_TYPE_PD)      |
+					      BIT(POWER_SUPPLY_USB_TYPE_PD_DRP)  |
+					      BIT(POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID);
 		}
 
 		psy_desc->name = port->name;
diff --git a/drivers/power/supply/lenovo_yoga_c630_battery.c b/drivers/power/supply/lenovo_yoga_c630_battery.c
index d4d422cc5353..f98f65e00831 100644
--- a/drivers/power/supply/lenovo_yoga_c630_battery.c
+++ b/drivers/power/supply/lenovo_yoga_c630_battery.c
@@ -353,15 +353,10 @@ static enum power_supply_property yoga_c630_psy_adpt_properties[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 };
 
-static const enum power_supply_usb_type yoga_c630_psy_adpt_usb_type[] = {
-	POWER_SUPPLY_USB_TYPE_C,
-};
-
 static const struct power_supply_desc yoga_c630_psy_adpt_psy_desc = {
 	.name = "yoga-c630-adapter",
 	.type = POWER_SUPPLY_TYPE_USB,
-	.usb_types = yoga_c630_psy_adpt_usb_type,
-	.num_usb_types = ARRAY_SIZE(yoga_c630_psy_adpt_usb_type),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_C),
 	.properties = yoga_c630_psy_adpt_properties,
 	.num_properties = ARRAY_SIZE(yoga_c630_psy_adpt_properties),
 	.get_property = yoga_c630_psy_adpt_get_property,
diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply/mp2629_charger.c
index 3a2a28fbba73..d281c1059629 100644
--- a/drivers/power/supply/mp2629_charger.c
+++ b/drivers/power/supply/mp2629_charger.c
@@ -94,14 +94,6 @@ struct mp2629_prop {
 	int shift;
 };
 
-static enum power_supply_usb_type mp2629_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-	POWER_SUPPLY_USB_TYPE_PD_DRP,
-	POWER_SUPPLY_USB_TYPE_UNKNOWN
-};
-
 static enum power_supply_property mp2629_charger_usb_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_USB_TYPE,
@@ -487,8 +479,11 @@ static irqreturn_t mp2629_irq_handler(int irq, void *dev_id)
 static const struct power_supply_desc mp2629_usb_desc = {
 	.name		= "mp2629_usb",
 	.type		= POWER_SUPPLY_TYPE_USB,
-	.usb_types      = mp2629_usb_types,
-	.num_usb_types  = ARRAY_SIZE(mp2629_usb_types),
+	.usb_types	= BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+			  BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+			  BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+			  BIT(POWER_SUPPLY_USB_TYPE_PD_DRP) |
+			  BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 	.properties	= mp2629_charger_usb_props,
 	.num_properties	= ARRAY_SIZE(mp2629_charger_usb_props),
 	.get_property	= mp2629_charger_usb_get_prop,
diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index aca123783efc..e99e55148976 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -154,13 +154,6 @@ enum mt6360_pmu_chg_type {
 	MT6360_CHG_TYPE_MAX,
 };
 
-static enum power_supply_usb_type mt6360_charger_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-};
-
 static int mt6360_get_chrdet_ext_stat(struct mt6360_chg_info *mci,
 					     bool *pwr_rdy)
 {
@@ -574,8 +567,10 @@ static const struct power_supply_desc mt6360_charger_desc = {
 	.get_property		= mt6360_charger_get_property,
 	.set_property		= mt6360_charger_set_property,
 	.property_is_writeable	= mt6360_charger_property_is_writeable,
-	.usb_types		= mt6360_charger_usb_types,
-	.num_usb_types		= ARRAY_SIZE(mt6360_charger_usb_types),
+	.usb_types		= BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+				  BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+				  BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+				  BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 };
 
 static const struct regulator_ops mt6360_chg_otg_ops = {
diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index e24fce087d80..ad8793bf997e 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -624,13 +624,6 @@ static enum power_supply_property mt6370_chg_properties[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 };
 
-static enum power_supply_usb_type mt6370_chg_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-};
-
 static const struct power_supply_desc mt6370_chg_psy_desc = {
 	.name = "mt6370-charger",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -639,8 +632,10 @@ static const struct power_supply_desc mt6370_chg_psy_desc = {
 	.get_property = mt6370_chg_get_property,
 	.set_property = mt6370_chg_set_property,
 	.property_is_writeable = mt6370_chg_property_is_writeable,
-	.usb_types = mt6370_chg_usb_types,
-	.num_usb_types = ARRAY_SIZE(mt6370_chg_usb_types),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 };
 
 static const struct regulator_ops mt6370_chg_otg_ops = {
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 3614d263ddad..0417fb34e846 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1360,10 +1360,6 @@ __power_supply_register(struct device *parent,
 		pr_warn("%s: Expected proper parent device for '%s'\n",
 			__func__, desc->name);
 
-	if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
-	    (!desc->usb_types || !desc->num_usb_types))
-		return ERR_PTR(-EINVAL);
-
 	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
 	if (!psy)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c98a6de59d3b..16b3c5880cd8 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -268,40 +268,6 @@ static ssize_t power_supply_show_enum_with_available(
 	return count;
 }
 
-static ssize_t power_supply_show_usb_type(struct device *dev,
-					  const struct power_supply_desc *desc,
-					  union power_supply_propval *value,
-					  char *buf)
-{
-	enum power_supply_usb_type usb_type;
-	ssize_t count = 0;
-	bool match = false;
-	int i;
-
-	for (i = 0; i < desc->num_usb_types; ++i) {
-		usb_type = desc->usb_types[i];
-
-		if (value->intval == usb_type) {
-			count += sysfs_emit_at(buf, count, "[%s] ",
-					 POWER_SUPPLY_USB_TYPE_TEXT[usb_type]);
-			match = true;
-		} else {
-			count += sysfs_emit_at(buf, count, "%s ",
-					 POWER_SUPPLY_USB_TYPE_TEXT[usb_type]);
-		}
-	}
-
-	if (!match) {
-		dev_warn(dev, "driver reporting unsupported connected type\n");
-		return -EINVAL;
-	}
-
-	if (count)
-		buf[count - 1] = '\n';
-
-	return count;
-}
-
 static ssize_t power_supply_show_property(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf) {
@@ -331,8 +297,10 @@ static ssize_t power_supply_show_property(struct device *dev,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_USB_TYPE:
-		ret = power_supply_show_usb_type(dev, psy->desc,
-						&value, buf);
+		ret = power_supply_show_enum_with_available(
+				dev, POWER_SUPPLY_USB_TYPE_TEXT,
+				ARRAY_SIZE(POWER_SUPPLY_USB_TYPE_TEXT),
+				psy->desc->usb_types, value.intval, buf);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
 		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 46f36dcb185c..56c8021383da 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -786,19 +786,6 @@ static int qcom_battmgr_usb_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static const enum power_supply_usb_type usb_psy_supported_types[] = {
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-	POWER_SUPPLY_USB_TYPE_ACA,
-	POWER_SUPPLY_USB_TYPE_C,
-	POWER_SUPPLY_USB_TYPE_PD,
-	POWER_SUPPLY_USB_TYPE_PD_DRP,
-	POWER_SUPPLY_USB_TYPE_PD_PPS,
-	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,
-};
-
 static const enum power_supply_property sc8280xp_usb_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
@@ -809,8 +796,16 @@ static const struct power_supply_desc sc8280xp_usb_psy_desc = {
 	.properties = sc8280xp_usb_props,
 	.num_properties = ARRAY_SIZE(sc8280xp_usb_props),
 	.get_property = qcom_battmgr_usb_get_property,
-	.usb_types = usb_psy_supported_types,
-	.num_usb_types = ARRAY_SIZE(usb_psy_supported_types),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
+		     BIT(POWER_SUPPLY_USB_TYPE_SDP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_C)       |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD)      |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD_DRP)  |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD_PPS)  |
+		     BIT(POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID),
 };
 
 static const enum power_supply_property sm8350_usb_props[] = {
@@ -829,8 +824,16 @@ static const struct power_supply_desc sm8350_usb_psy_desc = {
 	.properties = sm8350_usb_props,
 	.num_properties = ARRAY_SIZE(sm8350_usb_props),
 	.get_property = qcom_battmgr_usb_get_property,
-	.usb_types = usb_psy_supported_types,
-	.num_usb_types = ARRAY_SIZE(usb_psy_supported_types),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
+		     BIT(POWER_SUPPLY_USB_TYPE_SDP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_C)       |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD)      |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD_DRP)  |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD_PPS)  |
+		     BIT(POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID),
 };
 
 static const u8 sm8350_wls_prop_map[] = {
diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index 9bb777406013..81acbd8b2169 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -411,13 +411,6 @@ static enum power_supply_property smb2_properties[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 };
 
-static enum power_supply_usb_type smb2_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-};
-
 static int smb2_get_prop_usb_online(struct smb2_chip *chip, int *val)
 {
 	unsigned int stat;
@@ -775,8 +768,10 @@ static irqreturn_t smb2_handle_wdog_bark(int irq, void *data)
 static const struct power_supply_desc smb2_psy_desc = {
 	.name = "pmi8998_charger",
 	.type = POWER_SUPPLY_TYPE_USB,
-	.usb_types = smb2_usb_types,
-	.num_usb_types = ARRAY_SIZE(smb2_usb_types),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 	.properties = smb2_properties,
 	.num_properties = ARRAY_SIZE(smb2_properties),
 	.get_property = smb2_get_property,
diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 7ca91739c6cc..a3d377a32b49 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -673,11 +673,6 @@ static enum power_supply_property rk817_chg_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_AVG,
 };
 
-static enum power_supply_usb_type rk817_usb_type[] = {
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-};
-
 static const struct power_supply_desc rk817_bat_desc = {
 	.name = "rk817-battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
@@ -689,8 +684,8 @@ static const struct power_supply_desc rk817_bat_desc = {
 static const struct power_supply_desc rk817_chg_desc = {
 	.name = "rk817-charger",
 	.type = POWER_SUPPLY_TYPE_USB,
-	.usb_types = rk817_usb_type,
-	.num_usb_types = ARRAY_SIZE(rk817_usb_type),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 	.properties = rk817_chg_props,
 	.num_properties = ARRAY_SIZE(rk817_chg_props),
 	.get_property = rk817_chg_get_prop,
diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
index ebea3522a2ac..40dec55a9f73 100644
--- a/drivers/power/supply/rn5t618_power.c
+++ b/drivers/power/supply/rn5t618_power.c
@@ -70,13 +70,6 @@ struct rn5t618_power_info {
 	int irq;
 };
 
-static enum power_supply_usb_type rn5t618_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-	POWER_SUPPLY_USB_TYPE_UNKNOWN
-};
-
 static enum power_supply_property rn5t618_usb_props[] = {
 	/* input current limit is not very accurate */
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
@@ -681,8 +674,10 @@ static const struct power_supply_desc rn5t618_adp_desc = {
 static const struct power_supply_desc rn5t618_usb_desc = {
 	.name                   = "rn5t618-usb",
 	.type                   = POWER_SUPPLY_TYPE_USB,
-	.usb_types		= rn5t618_usb_types,
-	.num_usb_types		= ARRAY_SIZE(rn5t618_usb_types),
+	.usb_types		= BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+				  BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+				  BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+				  BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 	.properties             = rn5t618_usb_props,
 	.num_properties         = ARRAY_SIZE(rn5t618_usb_props),
 	.get_property           = rn5t618_usb_get_property,
diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index f935bd761ac1..235169c85c5d 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -630,13 +630,6 @@ static int rt9467_psy_set_ieoc(struct rt9467_chg_data *data, int microamp)
 	return ret;
 }
 
-static const enum power_supply_usb_type rt9467_chg_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-};
-
 static const enum power_supply_property rt9467_chg_properties[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -771,8 +764,10 @@ static int rt9467_chg_prop_is_writeable(struct power_supply *psy,
 static const struct power_supply_desc rt9467_chg_psy_desc = {
 	.name = "rt9467-charger",
 	.type = POWER_SUPPLY_TYPE_USB,
-	.usb_types = rt9467_chg_usb_types,
-	.num_usb_types = ARRAY_SIZE(rt9467_chg_usb_types),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 	.properties = rt9467_chg_properties,
 	.num_properties = ARRAY_SIZE(rt9467_chg_properties),
 	.property_is_writeable = rt9467_chg_prop_is_writeable,
diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
index 868b0703d15c..c04af1ee89c6 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -333,14 +333,6 @@ static enum power_supply_property rt9471_charger_properties[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-static enum power_supply_usb_type rt9471_charger_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,
-};
-
 static int rt9471_charger_property_is_writeable(struct power_supply *psy,
 						enum power_supply_property psp)
 {
@@ -726,8 +718,11 @@ static int rt9471_register_psy(struct rt9471_chip *chip)
 
 	desc->name = psy_name;
 	desc->type = POWER_SUPPLY_TYPE_USB;
-	desc->usb_types = rt9471_charger_usb_types;
-	desc->num_usb_types = ARRAY_SIZE(rt9471_charger_usb_types);
+	desc->usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+			  BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+			  BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+			  BIT(POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID) |
+			  BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN);
 	desc->properties = rt9471_charger_properties;
 	desc->num_properties = ARRAY_SIZE(rt9471_charger_properties);
 	desc->get_property = rt9471_charger_get_property;
diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index b67d5b03d93e..7382bec6a43c 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -296,14 +296,6 @@ static int ucs1002_set_max_current(struct ucs1002_info *info, u32 val)
 	return 0;
 }
 
-static enum power_supply_usb_type ucs1002_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_PD,
-	POWER_SUPPLY_USB_TYPE_SDP,
-	POWER_SUPPLY_USB_TYPE_DCP,
-	POWER_SUPPLY_USB_TYPE_CDP,
-	POWER_SUPPLY_USB_TYPE_UNKNOWN,
-};
-
 static int ucs1002_set_usb_type(struct ucs1002_info *info, int val)
 {
 	unsigned int mode;
@@ -431,8 +423,11 @@ static int ucs1002_property_is_writeable(struct power_supply *psy,
 static const struct power_supply_desc ucs1002_charger_desc = {
 	.name			= "ucs1002",
 	.type			= POWER_SUPPLY_TYPE_USB,
-	.usb_types		= ucs1002_usb_types,
-	.num_usb_types		= ARRAY_SIZE(ucs1002_usb_types),
+	.usb_types		= BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+				  BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+				  BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+				  BIT(POWER_SUPPLY_USB_TYPE_PD)  |
+				  BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
 	.get_property		= ucs1002_get_property,
 	.set_property		= ucs1002_set_property,
 	.property_is_writeable	= ucs1002_property_is_writeable,
diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 5a5bf3532ad7..31e3e9544bc0 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -1339,12 +1339,6 @@ static void anx7411_get_gpio_irq(struct anx7411_data *ctx)
 		dev_err(dev, "failed to get GPIO IRQ\n");
 }
 
-static enum power_supply_usb_type anx7411_psy_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_C,
-	POWER_SUPPLY_USB_TYPE_PD,
-	POWER_SUPPLY_USB_TYPE_PD_PPS,
-};
-
 static enum power_supply_property anx7411_psy_props[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -1422,8 +1416,9 @@ static int anx7411_psy_register(struct anx7411_data *ctx)
 
 	psy_desc->name = psy_name;
 	psy_desc->type = POWER_SUPPLY_TYPE_USB;
-	psy_desc->usb_types = anx7411_psy_usb_types;
-	psy_desc->num_usb_types = ARRAY_SIZE(anx7411_psy_usb_types);
+	psy_desc->usb_types = BIT(POWER_SUPPLY_USB_TYPE_C)  |
+			      BIT(POWER_SUPPLY_USB_TYPE_PD) |
+			      BIT(POWER_SUPPLY_USB_TYPE_PD_PPS);
 	psy_desc->properties = anx7411_psy_props;
 	psy_desc->num_properties = ARRAY_SIZE(anx7411_psy_props);
 
diff --git a/drivers/usb/typec/rt1719.c b/drivers/usb/typec/rt1719.c
index be02d420920e..0b0c23a0b014 100644
--- a/drivers/usb/typec/rt1719.c
+++ b/drivers/usb/typec/rt1719.c
@@ -109,12 +109,6 @@ struct rt1719_data {
 	u16 conn_stat;
 };
 
-static const enum power_supply_usb_type rt1719_psy_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_C,
-	POWER_SUPPLY_USB_TYPE_PD,
-	POWER_SUPPLY_USB_TYPE_PD_PPS
-};
-
 static const enum power_supply_property rt1719_psy_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_USB_TYPE,
@@ -572,8 +566,9 @@ static int devm_rt1719_psy_register(struct rt1719_data *data)
 
 	data->psy_desc.name = psy_name;
 	data->psy_desc.type = POWER_SUPPLY_TYPE_USB;
-	data->psy_desc.usb_types = rt1719_psy_usb_types;
-	data->psy_desc.num_usb_types = ARRAY_SIZE(rt1719_psy_usb_types);
+	data->psy_desc.usb_types = BIT(POWER_SUPPLY_USB_TYPE_C)  |
+				   BIT(POWER_SUPPLY_USB_TYPE_PD) |
+				   BIT(POWER_SUPPLY_USB_TYPE_PD_PPS);
 	data->psy_desc.properties = rt1719_psy_properties;
 	data->psy_desc.num_properties = ARRAY_SIZE(rt1719_psy_properties);
 	data->psy_desc.get_property = rt1719_psy_get_property;
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 26f9006e95e1..0bd9c9569fb7 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7484,12 +7484,6 @@ static int tcpm_psy_prop_writeable(struct power_supply *psy,
 	}
 }
 
-static enum power_supply_usb_type tcpm_psy_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_C,
-	POWER_SUPPLY_USB_TYPE_PD,
-	POWER_SUPPLY_USB_TYPE_PD_PPS,
-};
-
 static const char *tcpm_psy_name_prefix = "tcpm-source-psy-";
 
 static int devm_tcpm_psy_register(struct tcpm_port *port)
@@ -7510,8 +7504,9 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
 		 port_dev_name);
 	port->psy_desc.name = psy_name;
 	port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
-	port->psy_desc.usb_types = tcpm_psy_usb_types;
-	port->psy_desc.num_usb_types = ARRAY_SIZE(tcpm_psy_usb_types);
+	port->psy_desc.usb_types = BIT(POWER_SUPPLY_USB_TYPE_C)  |
+				   BIT(POWER_SUPPLY_USB_TYPE_PD) |
+				   BIT(POWER_SUPPLY_USB_TYPE_PD_PPS);
 	port->psy_desc.properties = tcpm_psy_props;
 	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props);
 	port->psy_desc.get_property = tcpm_psy_get_prop;
diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index ea768b19a7f1..7512f0c3f6cb 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -150,11 +150,6 @@ static enum power_supply_property tps6598x_psy_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
-static enum power_supply_usb_type tps6598x_psy_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_C,
-	POWER_SUPPLY_USB_TYPE_PD,
-};
-
 static const char *tps6598x_psy_name_prefix = "tps6598x-source-psy-";
 
 /*
@@ -827,8 +822,8 @@ static int devm_tps6598_psy_register(struct tps6598x *tps)
 
 	tps->psy_desc.name = psy_name;
 	tps->psy_desc.type = POWER_SUPPLY_TYPE_USB;
-	tps->psy_desc.usb_types = tps6598x_psy_usb_types;
-	tps->psy_desc.num_usb_types = ARRAY_SIZE(tps6598x_psy_usb_types);
+	tps->psy_desc.usb_types = BIT(POWER_SUPPLY_USB_TYPE_C) |
+				  BIT(POWER_SUPPLY_USB_TYPE_PD);
 	tps->psy_desc.properties = tps6598x_psy_props;
 	tps->psy_desc.num_properties = ARRAY_SIZE(tps6598x_psy_props);
 	tps->psy_desc.get_property = tps6598x_psy_get_prop;
diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index e623d80e177c..1c631c7855a9 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -254,12 +254,6 @@ static int ucsi_psy_get_prop(struct power_supply *psy,
 	}
 }
 
-static enum power_supply_usb_type ucsi_psy_usb_types[] = {
-	POWER_SUPPLY_USB_TYPE_C,
-	POWER_SUPPLY_USB_TYPE_PD,
-	POWER_SUPPLY_USB_TYPE_PD_PPS,
-};
-
 int ucsi_register_port_psy(struct ucsi_connector *con)
 {
 	struct power_supply_config psy_cfg = {};
@@ -276,8 +270,9 @@ int ucsi_register_port_psy(struct ucsi_connector *con)
 
 	con->psy_desc.name = psy_name;
 	con->psy_desc.type = POWER_SUPPLY_TYPE_USB;
-	con->psy_desc.usb_types = ucsi_psy_usb_types;
-	con->psy_desc.num_usb_types = ARRAY_SIZE(ucsi_psy_usb_types);
+	con->psy_desc.usb_types = BIT(POWER_SUPPLY_USB_TYPE_C)  |
+				  BIT(POWER_SUPPLY_USB_TYPE_PD) |
+				  BIT(POWER_SUPPLY_USB_TYPE_PD_PPS);
 	con->psy_desc.properties = ucsi_psy_props;
 	con->psy_desc.num_properties = ARRAY_SIZE(ucsi_psy_props);
 	con->psy_desc.get_property = ucsi_psy_get_prop;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 72dc7e45c90c..910d407ebe63 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -243,8 +243,7 @@ struct power_supply_desc {
 	const char *name;
 	enum power_supply_type type;
 	u8 charge_behaviours;
-	const enum power_supply_usb_type *usb_types;
-	size_t num_usb_types;
+	u32 usb_types;
 	const enum power_supply_property *properties;
 	size_t num_properties;
 
-- 
2.46.0


