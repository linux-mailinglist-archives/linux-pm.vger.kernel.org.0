Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7D639C2F
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 19:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiK0SDu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 13:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiK0SDs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 13:03:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA28D94
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 10:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669572173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8kJwWQaKJBkNmx8PHMokTdpIeK6mUWMQuiJmZufQsk=;
        b=ZNlfigVB2pUm9Q1Uru/z1vcQCvwTMZ0tZIVei8OR/WxW9FjHcHnA8brwebvsueWGzbHP+1
        +j8Z9PS8/0t+Z3iutXzExMITRXvghijlDywjRKZbICiXJaWNxxU9jjk/lambnDhyFOGC+7
        yUWDW+ca/vSAJYQs09ME6lmOPgAUZSo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-SjXBSJVUM-i2XQ1v2er9dQ-1; Sun, 27 Nov 2022 13:02:51 -0500
X-MC-Unique: SjXBSJVUM-i2XQ1v2er9dQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 209D8101A528;
        Sun, 27 Nov 2022 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E1BA140EBF5;
        Sun, 27 Nov 2022 18:02:50 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 08/10] power: supply: bq25890: Support boards with more then one charger IC
Date:   Sun, 27 Nov 2022 19:02:31 +0100
Message-Id: <20221127180233.103678-9-hdegoede@redhat.com>
In-Reply-To: <20221127180233.103678-1-hdegoede@redhat.com>
References: <20221127180233.103678-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some devices, such as the Lenovo Yoga Tab 3 Pro (YT3-X90F) have
multiple batteries with a separate bq25890 charger for each battery.

This requires the bq25890_charger code to use a unique name per
registered power_supply class device, rather then hardcoding
"bq25890-charger" as power_supply class device name.

Add a "-%d" prefix to the name, allocated through idr in the same way
as several other power_supply drivers are already doing this.

Note this also updates: drivers/platform/x86/x86-android-tablets.c
which refers to the charger by power_supply-class-device-name for
the purpose of setting the "supplied-from" property on the fuel-gauge
to this name.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
As the subsystem maintainer for drivers/platform/x86 I'm fine with
the small x86-android-tablets.c being merged through the
linux-power-supply tree.

Also note I did a full grep for "bq25890-charger" and
x86-android-tablets.c is the only file in the kernel tree referring
to this name.
---
 drivers/platform/x86/x86-android-tablets.c |  2 +-
 drivers/power/supply/bq25890_charger.c     | 29 +++++++++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
index dd933cf32b38..916e37a4f85e 100644
--- a/drivers/platform/x86/x86-android-tablets.c
+++ b/drivers/platform/x86/x86-android-tablets.c
@@ -187,7 +187,7 @@ struct x86_dev_info {
 /* Generic / shared charger / battery settings */
 static const char * const tusb1211_chg_det_psy[] = { "tusb1211-charger-detect" };
 static const char * const bq24190_psy[] = { "bq24190-charger" };
-static const char * const bq25890_psy[] = { "bq25890-charger" };
+static const char * const bq25890_psy[] = { "bq25890-charger-0" };
 
 static const struct property_entry fg_bq24190_supply_props[] = {
 	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", bq24190_psy),
diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 03e31c5b0df5..a0e20cbadeb8 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -108,6 +108,9 @@ struct bq25890_device {
 	struct i2c_client *client;
 	struct device *dev;
 	struct power_supply *charger;
+	struct power_supply_desc desc;
+	char name[28]; /* "bq25890-charger-%d" */
+	int id;
 
 	struct usb_phy *usb_phy;
 	struct notifier_block usb_nb;
@@ -129,6 +132,9 @@ struct bq25890_device {
 	struct mutex lock; /* protect state data */
 };
 
+static DEFINE_IDR(bq25890_id);
+static DEFINE_MUTEX(bq25890_id_mutex);
+
 static const struct regmap_range bq25890_readonly_reg_ranges[] = {
 	regmap_reg_range(0x0b, 0x0c),
 	regmap_reg_range(0x0e, 0x13),
@@ -989,7 +995,6 @@ static char *bq25890_charger_supplied_to[] = {
 };
 
 static const struct power_supply_desc bq25890_power_supply_desc = {
-	.name = "bq25890-charger",
 	.type = POWER_SUPPLY_TYPE_USB,
 	.properties = bq25890_power_supply_props,
 	.num_properties = ARRAY_SIZE(bq25890_power_supply_props),
@@ -1003,12 +1008,21 @@ static int bq25890_power_supply_init(struct bq25890_device *bq)
 {
 	struct power_supply_config psy_cfg = { .drv_data = bq, };
 
+	/* Get ID for the device */
+	mutex_lock(&bq25890_id_mutex);
+	bq->id = idr_alloc(&bq25890_id, bq, 0, 0, GFP_KERNEL);
+	mutex_unlock(&bq25890_id_mutex);
+	if (bq->id < 0)
+		return bq->id;
+
+	snprintf(bq->name, sizeof(bq->name), "bq25890-charger-%d", bq->id);
+	bq->desc = bq25890_power_supply_desc;
+	bq->desc.name = bq->name;
+
 	psy_cfg.supplied_to = bq25890_charger_supplied_to;
 	psy_cfg.num_supplicants = ARRAY_SIZE(bq25890_charger_supplied_to);
 
-	bq->charger = devm_power_supply_register(bq->dev,
-						 &bq25890_power_supply_desc,
-						 &psy_cfg);
+	bq->charger = devm_power_supply_register(bq->dev, &bq->desc, &psy_cfg);
 
 	return PTR_ERR_OR_ZERO(bq->charger);
 }
@@ -1354,6 +1368,12 @@ static void bq25890_non_devm_cleanup(void *data)
 	struct bq25890_device *bq = data;
 
 	cancel_delayed_work_sync(&bq->pump_express_work);
+
+	if (bq->id >= 0) {
+		mutex_lock(&bq25890_id_mutex);
+		idr_remove(&bq25890_id, bq->id);
+		mutex_unlock(&bq25890_id_mutex);
+	}
 }
 
 static int bq25890_probe(struct i2c_client *client)
@@ -1368,6 +1388,7 @@ static int bq25890_probe(struct i2c_client *client)
 
 	bq->client = client;
 	bq->dev = dev;
+	bq->id = -1;
 
 	mutex_init(&bq->lock);
 	INIT_DELAYED_WORK(&bq->pump_express_work, bq25890_pump_express_work);
-- 
2.38.1

