Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A57A4A4B1A
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jan 2022 16:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379954AbiAaP6K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jan 2022 10:58:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232673AbiAaP6I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jan 2022 10:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643644687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Zz8lrDxlo4FuqIPlxk3k2zkD/N6oyUkKUAqsEk6uzI=;
        b=XnFmwllEJzZ07Vli3j73BCwiMAZMGQnD9vwFS6AXJrpiZ3G5xQpgguCcGw+LMcUcywpp4o
        C1mnYer5zWBqMZw/U5vyPBPJWjWikqV3n6FfGAim1WrrELx60k9RTgMlrzN+BnnLN1JIpc
        Ur5x0lCyajSgfA1ydcmiiWgwX9EIe/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-TzlCetGwNvuWEKxRcDSjAQ-1; Mon, 31 Jan 2022 10:58:04 -0500
X-MC-Unique: TzlCetGwNvuWEKxRcDSjAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33522185302A;
        Mon, 31 Jan 2022 15:58:03 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8B3679529;
        Mon, 31 Jan 2022 15:58:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH 5/8] power: supply: bq24190_charger: Store ichg-max and vreg-max in bq24190_dev_info
Date:   Mon, 31 Jan 2022 16:57:27 +0100
Message-Id: <20220131155730.309513-6-hdegoede@redhat.com>
In-Reply-To: <20220131155730.309513-1-hdegoede@redhat.com>
References: <20220131155730.309513-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Store ichg-max and vreg-max in bq24190_dev_info once from
bq24190_get_config() and drop the bq24190_charger_get_current_max() and
bq24190_charger_get_voltage_max() helpers.

This is a preparation patch for honoring the
constant_charge_current_max_ua and constant_charge_voltage_max_uv
values from power_supply_get_battery_info().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 34 ++++++++++----------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 83873119ba24..cb36ccbb731a 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -165,6 +165,8 @@ struct bq24190_dev_info {
 	u16				sys_min;
 	u16				iprechg;
 	u16				iterm;
+	u32				ichg_max;
+	u32				vreg_max;
 	struct mutex			f_reg_lock;
 	u8				f_reg;
 	u8				ss_reg;
@@ -977,15 +979,6 @@ static int bq24190_charger_get_current(struct bq24190_dev_info *bdi,
 	return 0;
 }
 
-static int bq24190_charger_get_current_max(struct bq24190_dev_info *bdi,
-		union power_supply_propval *val)
-{
-	int idx = ARRAY_SIZE(bq24190_ccc_ichg_values) - 1;
-
-	val->intval = bq24190_ccc_ichg_values[idx];
-	return 0;
-}
-
 static int bq24190_charger_set_current(struct bq24190_dev_info *bdi,
 		const union power_supply_propval *val)
 {
@@ -1024,15 +1017,6 @@ static int bq24190_charger_get_voltage(struct bq24190_dev_info *bdi,
 	return 0;
 }
 
-static int bq24190_charger_get_voltage_max(struct bq24190_dev_info *bdi,
-		union power_supply_propval *val)
-{
-	int idx = ARRAY_SIZE(bq24190_cvc_vreg_values) - 1;
-
-	val->intval = bq24190_cvc_vreg_values[idx];
-	return 0;
-}
-
 static int bq24190_charger_set_voltage(struct bq24190_dev_info *bdi,
 		const union power_supply_propval *val)
 {
@@ -1109,13 +1093,15 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 		ret = bq24190_charger_get_current(bdi, val);
 		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-		ret = bq24190_charger_get_current_max(bdi, val);
+		val->intval = bdi->ichg_max;
+		ret = 0;
 		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		ret = bq24190_charger_get_voltage(bdi, val);
 		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
-		ret = bq24190_charger_get_voltage_max(bdi, val);
+		val->intval = bdi->vreg_max;
+		ret = 0;
 		break;
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		ret = bq24190_charger_get_iinlimit(bdi, val);
@@ -1682,7 +1668,13 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 {
 	const char * const s = "ti,system-minimum-microvolt";
 	struct power_supply_battery_info *info;
-	int v;
+	int v, idx;
+
+	idx = ARRAY_SIZE(bq24190_ccc_ichg_values) - 1;
+	bdi->ichg_max = bq24190_ccc_ichg_values[idx];
+
+	idx = ARRAY_SIZE(bq24190_cvc_vreg_values) - 1;
+	bdi->vreg_max = bq24190_cvc_vreg_values[idx];
 
 	if (device_property_read_u32(bdi->dev, s, &v) == 0) {
 		v /= 1000;
-- 
2.33.1

