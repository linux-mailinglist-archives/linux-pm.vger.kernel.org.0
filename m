Return-Path: <linux-pm+bounces-1861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF1E824844
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 19:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BB7287867
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA0B28E09;
	Thu,  4 Jan 2024 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+ls1HpM"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E7A28E02
	for <linux-pm@vger.kernel.org>; Thu,  4 Jan 2024 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704393329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVzDIX7FkKogLK6ba4KT468sEChh9J813vSnLoAxxr0=;
	b=N+ls1HpMHSzTH5BYERImqrZY5KU7GLpzQci6f/pdOB7sxzO/isZYFoiXBD6vPtB/volZq1
	AERfjl6doLdZuBCDl6DVqftAGb8rhRUATDeUvUWLk7E+aRQtYzrdOXE7XEOkwFRiHYlRZu
	43dudeFPXV57w8utRUYkO/KMpjC5uXI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-_d3Q2_GrOnWMrm13bjVIZA-1; Thu,
 04 Jan 2024 13:35:28 -0500
X-MC-Unique: _d3Q2_GrOnWMrm13bjVIZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2CF23C02B64;
	Thu,  4 Jan 2024 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 318D33C27;
	Thu,  4 Jan 2024 18:35:27 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 3/3] power: supply: axp288_charger: Add charge-inhibit support
Date: Thu,  4 Jan 2024 19:35:16 +0100
Message-ID: <20240104183516.312044-3-hdegoede@redhat.com>
In-Reply-To: <20240104183516.312044-1-hdegoede@redhat.com>
References: <20240104183516.312044-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Add charge-inhibit support by adding a rw status attribute and
inhibiting charging when "Not charging" or "Discharging"
is written to it.

The userspace API with status being writable is a bit weird,
but this is already done this way in the following psy drivers:
axp20x_battery.c, bq24735-charger.c, bq25980_charger.c, ip5xxx_power.c,
rt9467-charger.c, rt9471.c.

Note on systems with an AXP288 some (about 400mA depending on load)
current will be drawn from the battery when charging is disabled
even if there is an external power-supply which can provide all
the necessary current. So unfortunately one cannot simply disable
charging to keep the battery in good health when using a tablet
with an AXP288 permanently connected to an external power-supply.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 43 +++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index a327933cfd6a..351431f3cf0e 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -2,7 +2,7 @@
 /*
  * axp288_charger.c - X-power AXP288 PMIC Charger driver
  *
- * Copyright (C) 2016-2017 Hans de Goede <hdegoede@redhat.com>
+ * Copyright (C) 2016-2024 Hans de Goede <hdegoede@redhat.com>
  * Copyright (C) 2014 Intel Corporation
  * Author: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
  */
@@ -148,6 +148,8 @@ struct axp288_chrg_info {
 	unsigned int op_mode;
 	unsigned int backend_control;
 	bool valid;
+	bool charge_enable;
+	bool charge_inhibit;
 };
 
 static inline int axp288_charger_set_cc(struct axp288_chrg_info *info, int cc)
@@ -285,9 +287,9 @@ static int axp288_charger_vbus_path_select(struct axp288_chrg_info *info,
 	return ret;
 }
 
-static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
-								bool enable)
+static int axp288_charger_update_charge_en(struct axp288_chrg_info *info)
 {
+	bool enable = info->charge_enable && !info->charge_inhibit;
 	int ret;
 
 	if (enable)
@@ -302,6 +304,18 @@ static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
 	return ret;
 }
 
+static int axp288_charger_enable_charger(struct axp288_chrg_info *info, bool enable)
+{
+	info->charge_enable = enable;
+	return axp288_charger_update_charge_en(info);
+}
+
+static int axp288_charger_inhibit_charger(struct axp288_chrg_info *info, bool inhibit)
+{
+	info->charge_inhibit = inhibit;
+	return axp288_charger_update_charge_en(info);
+}
+
 static int axp288_get_charger_health(struct axp288_chrg_info *info)
 {
 	if (!(info->input_status & PS_STAT_VBUS_PRESENT))
@@ -327,6 +341,19 @@ static int axp288_charger_usb_set_property(struct power_supply *psy,
 
 	mutex_lock(&info->lock);
 	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		switch (val->intval) {
+		case POWER_SUPPLY_STATUS_CHARGING:
+			ret = axp288_charger_inhibit_charger(info, false);
+			break;
+		case POWER_SUPPLY_STATUS_DISCHARGING:
+		case POWER_SUPPLY_STATUS_NOT_CHARGING:
+			ret = axp288_charger_inhibit_charger(info, true);
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		scaled_val = min(val->intval, info->max_cc);
 		scaled_val = DIV_ROUND_CLOSEST(scaled_val, 1000);
@@ -423,6 +450,14 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 		goto out;
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (info->charge_enable && !info->charge_inhibit)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (info->charge_enable && info->charge_inhibit)
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		else /* !info->charge_enable && xxx */
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		/* Check for OTG case first */
 		if (info->otg.id_short) {
@@ -472,6 +507,7 @@ static int axp288_charger_property_is_writeable(struct power_supply *psy,
 	int ret;
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
@@ -485,6 +521,7 @@ static int axp288_charger_property_is_writeable(struct power_supply *psy,
 }
 
 static enum power_supply_property axp288_usb_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_TYPE,
-- 
2.43.0


