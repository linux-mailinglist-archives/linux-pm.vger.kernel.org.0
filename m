Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DE84A4B1B
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jan 2022 16:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379948AbiAaP6L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jan 2022 10:58:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379956AbiAaP6L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jan 2022 10:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643644690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KBLgfrsHEKSGKzRABKEVELtvzK9ZeUNQgooOKejRok=;
        b=BPQ+a0ouhxTzEMVOmWbNZuF4xAZQDYji2TQNBKdDBqFQ4i44Ic1oV8Brt6DfC3+Uw0CqHa
        v+5ka8awhzh81ZP8q4KLPLwmMR+S0qKBYmR0+hm1n2evVf/EIUcGSQSGzh+i/i6yWrUF8V
        C1a5H2V9ZI5rMJxLRjbFFo5DEuD4VDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-hh-QrJ-sM8WAEd_DRGC17g-1; Mon, 31 Jan 2022 10:58:08 -0500
X-MC-Unique: hh-QrJ-sM8WAEd_DRGC17g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADF3036393;
        Mon, 31 Jan 2022 15:58:07 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90DAA79529;
        Mon, 31 Jan 2022 15:58:03 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH 6/8] power: supply: bq24190_charger: Program charger with fwnode supplied ccc_ireg and cvc_vreg
Date:   Mon, 31 Jan 2022 16:57:28 +0100
Message-Id: <20220131155730.309513-7-hdegoede@redhat.com>
In-Reply-To: <20220131155730.309513-1-hdegoede@redhat.com>
References: <20220131155730.309513-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

So far the bq24190_charger driver has been relying on either the chips
default constant_charge_current_max_ua and constant_charge_voltage_max_uv
values, or on the BIOS or bootloader to program these for us.

This does not happen on all boards, causing e.g. the wrong (too low)
values to be used on Lenovo Yoga Tablet 2 830F/L and 1050F/L tablets.

If power_supply_get_battery_info() provides us with values for these
settings, then program the charger accordingly.

And if the user later overrides these values then save the user-values
so that these will be restored after a suspend/resume.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 51 +++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index cb36ccbb731a..974e4b6b8d4d 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -165,7 +165,9 @@ struct bq24190_dev_info {
 	u16				sys_min;
 	u16				iprechg;
 	u16				iterm;
+	u32				ichg;
 	u32				ichg_max;
+	u32				vreg;
 	u32				vreg_max;
 	struct mutex			f_reg_lock;
 	u8				f_reg;
@@ -662,6 +664,28 @@ static int bq24190_set_config(struct bq24190_dev_info *bdi)
 			return ret;
 	}
 
+	if (bdi->ichg) {
+		ret = bq24190_set_field_val(bdi, BQ24190_REG_CCC,
+					    BQ24190_REG_CCC_ICHG_MASK,
+					    BQ24190_REG_CCC_ICHG_SHIFT,
+					    bq24190_ccc_ichg_values,
+					    ARRAY_SIZE(bq24190_ccc_ichg_values),
+					    bdi->ichg);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (bdi->vreg) {
+		ret = bq24190_set_field_val(bdi, BQ24190_REG_CVC,
+					    BQ24190_REG_CVC_VREG_MASK,
+					    BQ24190_REG_CVC_VREG_SHIFT,
+					    bq24190_cvc_vreg_values,
+					    ARRAY_SIZE(bq24190_cvc_vreg_values),
+					    bdi->vreg);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -995,10 +1019,16 @@ static int bq24190_charger_set_current(struct bq24190_dev_info *bdi,
 	if (v)
 		curr *= 5;
 
-	return bq24190_set_field_val(bdi, BQ24190_REG_CCC,
+	ret = bq24190_set_field_val(bdi, BQ24190_REG_CCC,
 			BQ24190_REG_CCC_ICHG_MASK, BQ24190_REG_CCC_ICHG_SHIFT,
 			bq24190_ccc_ichg_values,
 			ARRAY_SIZE(bq24190_ccc_ichg_values), curr);
+	if (ret < 0)
+		return ret;
+
+	bdi->ichg = curr;
+
+	return 0;
 }
 
 static int bq24190_charger_get_voltage(struct bq24190_dev_info *bdi,
@@ -1020,10 +1050,18 @@ static int bq24190_charger_get_voltage(struct bq24190_dev_info *bdi,
 static int bq24190_charger_set_voltage(struct bq24190_dev_info *bdi,
 		const union power_supply_propval *val)
 {
-	return bq24190_set_field_val(bdi, BQ24190_REG_CVC,
+	int ret;
+
+	ret = bq24190_set_field_val(bdi, BQ24190_REG_CVC,
 			BQ24190_REG_CVC_VREG_MASK, BQ24190_REG_CVC_VREG_SHIFT,
 			bq24190_cvc_vreg_values,
 			ARRAY_SIZE(bq24190_cvc_vreg_values), val->intval);
+	if (ret < 0)
+		return ret;
+
+	bdi->vreg = val->intval;
+
+	return 0;
 }
 
 static int bq24190_charger_get_iinlimit(struct bq24190_dev_info *bdi,
@@ -1701,6 +1739,15 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 		else
 			dev_warn(bdi->dev, "invalid value for battery:charge-term-current-microamp: %d\n",
 				 v);
+
+		/* These are optional, so no warning when not set */
+		v = info->constant_charge_current_max_ua;
+		if (v >= bq24190_ccc_ichg_values[0] && v <= bdi->ichg_max)
+			bdi->ichg = v;
+
+		v = info->constant_charge_voltage_max_uv;
+		if (v >= bq24190_cvc_vreg_values[0] && v <= bdi->vreg_max)
+			bdi->vreg = v;
 	}
 
 	return 0;
-- 
2.33.1

