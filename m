Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B40163A510
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 10:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiK1JaP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 04:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiK1JaN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 04:30:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA04B7F3
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 01:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669627755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1LuRfEf5SKUjpKCDthBmOH2R9bxLXZrk4kFgi8k8Yw=;
        b=K5lqFISjZiUsXny61GvMLq+t1ePgdrL80VASwaC7LC7uhGtcc5WwuWIVxvbv5iaNHQ0A23
        tzHUdNho32XJryC8eAImrdeDRcE+gDzOxv+fXWxUxZeKChCA8jH7QYUTNy8JX0R+lUDtdW
        5Qk4HkBVsdWgZyiZNYkiJ+VhUQTqzBc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-8VNf1a1mMCOj5L0UOnvhfw-1; Mon, 28 Nov 2022 04:29:11 -0500
X-MC-Unique: 8VNf1a1mMCOj5L0UOnvhfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D3F43C10146;
        Mon, 28 Nov 2022 09:29:11 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.195.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05B32FD48;
        Mon, 28 Nov 2022 09:29:09 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 8/9] power: supply: bq25890: Add support for having a secondary charger IC
Date:   Mon, 28 Nov 2022 10:28:55 +0100
Message-Id: <20221128092856.71619-9-hdegoede@redhat.com>
In-Reply-To: <20221128092856.71619-1-hdegoede@redhat.com>
References: <20221128092856.71619-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some devices, such as the Lenovo Yoga Tab 3 Pro (YT3-X90F) have multiple
batteries with a separate bq25890 charger for each battery.

This requires some coordination between the chargers specifically
the main charger needs to put the secondary charger in Hi-Z mode when:

1. Enabling its 5V boost (OTG) output to power an external USB device,
   to avoid the secondary charger IC seeing this as external Vbus and
   then trying to charge the secondary battery from this.

2. Talking the Pump Express protocol to increase the external Vbus voltage.
   Having the secondary charger drawing current when the main charger is
   trying to talk the Pump Express protocol results in the external Vbus
   voltage not being raised.

Add a new "linux,secondary-charger-name" string device-property, which
can be set to the power_supply class device's name of the secondary
charger when there is a secondary charger; and make the Vbus regulator and
Pump Express code put the secondary charger in Hi-Z mode when necessary.

So far this new property is only used on x86/ACPI (non devicetree) devs,
IOW it is not used in actual devicetree files. The devicetree-bindings
maintainers have requested properties like these to not be added to the
devicetree-bindings, so the new property is deliberately not added
to the existing devicetree-bindings.

Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 45 +++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 30854d08bba9..aff55bf3ecc3 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -108,6 +108,7 @@ struct bq25890_device {
 	struct i2c_client *client;
 	struct device *dev;
 	struct power_supply *charger;
+	struct power_supply *secondary_chrg;
 	struct power_supply_desc desc;
 	char name[28]; /* "bq25890-charger-%d" */
 	int id;
@@ -1042,10 +1043,17 @@ static void bq25890_pump_express_work(struct work_struct *data)
 {
 	struct bq25890_device *bq =
 		container_of(data, struct bq25890_device, pump_express_work.work);
+	union power_supply_propval value;
 	int voltage, i, ret;
 
 	dev_dbg(bq->dev, "Start to request input voltage increasing\n");
 
+	/* If there is a second charger put in Hi-Z mode */
+	if (bq->secondary_chrg) {
+		value.intval = 0;
+		power_supply_set_property(bq->secondary_chrg, POWER_SUPPLY_PROP_ONLINE, &value);
+	}
+
 	/* Enable current pulse voltage control protocol */
 	ret = bq25890_field_write(bq, F_PUMPX_EN, 1);
 	if (ret < 0)
@@ -1077,6 +1085,11 @@ static void bq25890_pump_express_work(struct work_struct *data)
 
 	bq25890_field_write(bq, F_PUMPX_EN, 0);
 
+	if (bq->secondary_chrg) {
+		value.intval = 1;
+		power_supply_set_property(bq->secondary_chrg, POWER_SUPPLY_PROP_ONLINE, &value);
+	}
+
 	dev_info(bq->dev, "Hi-voltage charging requested, input voltage is %d mV\n",
 		 voltage);
 
@@ -1123,6 +1136,17 @@ static int bq25890_usb_notifier(struct notifier_block *nb, unsigned long val,
 static int bq25890_vbus_enable(struct regulator_dev *rdev)
 {
 	struct bq25890_device *bq = rdev_get_drvdata(rdev);
+	union power_supply_propval val = {
+		.intval = 0,
+	};
+
+	/*
+	 * When enabling 5V boost / Vbus output, we need to put the secondary
+	 * charger in Hi-Z mode to avoid it trying to charge the secondary
+	 * battery from the 5V boost output.
+	 */
+	if (bq->secondary_chrg)
+		power_supply_set_property(bq->secondary_chrg, POWER_SUPPLY_PROP_ONLINE, &val);
 
 	return bq25890_set_otg_cfg(bq, 1);
 }
@@ -1130,8 +1154,19 @@ static int bq25890_vbus_enable(struct regulator_dev *rdev)
 static int bq25890_vbus_disable(struct regulator_dev *rdev)
 {
 	struct bq25890_device *bq = rdev_get_drvdata(rdev);
+	union power_supply_propval val = {
+		.intval = 1,
+	};
+	int ret;
+
+	ret = bq25890_set_otg_cfg(bq, 0);
+	if (ret)
+		return ret;
 
-	return bq25890_set_otg_cfg(bq, 0);
+	if (bq->secondary_chrg)
+		power_supply_set_property(bq->secondary_chrg, POWER_SUPPLY_PROP_ONLINE, &val);
+
+	return 0;
 }
 
 static int bq25890_vbus_is_enabled(struct regulator_dev *rdev)
@@ -1342,6 +1377,14 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 {
 	int ret;
 	struct bq25890_init_data *init = &bq->init_data;
+	const char *str;
+
+	ret = device_property_read_string(bq->dev, "linux,secondary-charger-name", &str);
+	if (ret == 0) {
+		bq->secondary_chrg = power_supply_get_by_name(str);
+		if (!bq->secondary_chrg)
+			return -EPROBE_DEFER;
+	}
 
 	/* Optional, left at 0 if property is not present */
 	device_property_read_u32(bq->dev, "linux,pump-express-vbus-max",
-- 
2.37.3

