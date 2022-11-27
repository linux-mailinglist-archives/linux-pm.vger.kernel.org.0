Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D13639C34
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiK0SD5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 13:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0SDz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 13:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC8965AD
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 10:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669572177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pijH1z+M3PSlhe30cfhOPB6wsddKrVE1+7oCB/HoGw4=;
        b=ivNJDScpVztE05DbCdkT8WVLcLJN1pOT1s2lDKRRgZ6XS8nG67KeOFKk5SmSOnpehdgmXD
        fx+P05KL4vpYAJnr4NS2vpwX3gTVLG12WHGNcEl3dFNTikrHUbsGeDCgN3qSghfNq6o5T7
        C1NmFPsx2dXNozC05F926LuTcuSvUZM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-4jdKcoxkNPK68HIljNCrNw-1; Sun, 27 Nov 2022 13:02:53 -0500
X-MC-Unique: 4jdKcoxkNPK68HIljNCrNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E23468027EC;
        Sun, 27 Nov 2022 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B279140EBF5;
        Sun, 27 Nov 2022 18:02:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 10/10] power: supply: bq25890: Add new linux,iinlim-percentage property
Date:   Sun, 27 Nov 2022 19:02:33 +0100
Message-Id: <20221127180233.103678-11-hdegoede@redhat.com>
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

This requires the maximum current the external power-supply can deliver
to be divided over the chargers. The Android vendor kernel shipped
on the YT3-X90F divides this current with a 40/60 percent split so that
batteries are done charging at approx. the same time if both were fully
empty at the start.

Add support for a new "linux,iinlim-percentage" percentage property which
can be set to indicate that a bq25890 charger should only use that
percentage of the external power-supply's maximum current.

So far this new property is only used on x86/ACPI (non devicetree) devs,
IOW it is not used in actual devicetree files. The devicetree-bindings
maintainers have requested properties like these to not be added to the
devicetree-bindings, so the new property is deliberately not added
to the existing devicetree-bindings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index b0d07ff24ace..2bd7721b969f 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -126,6 +126,7 @@ struct bq25890_device {
 	bool read_back_init_data;
 	bool force_hiz;
 	u32 pump_express_vbus_max;
+	u32 iinlim_percentage;
 	enum bq25890_chip_version chip_version;
 	struct bq25890_init_data init_data;
 	struct bq25890_state state;
@@ -727,6 +728,18 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
 	}
 }
 
+/*
+ * If there are multiple chargers the maximum current the external power-supply
+ * can deliver needs to be divided over the chargers. This is done according
+ * to the bq->iinlim_percentage setting.
+ */
+static int bq25890_charger_get_scaled_iinlim_regval(struct bq25890_device *bq,
+						    int iinlim_ua)
+{
+	iinlim_ua = iinlim_ua * bq->iinlim_percentage / 100;
+	return bq25890_find_idx(iinlim_ua, TBL_IINLIM);
+}
+
 /* On the BQ25892 try to get charger-type info from our supplier */
 static void bq25890_charger_external_power_changed(struct power_supply *psy)
 {
@@ -745,7 +758,7 @@ static void bq25890_charger_external_power_changed(struct power_supply *psy)
 
 	switch (val.intval) {
 	case POWER_SUPPLY_USB_TYPE_DCP:
-		input_current_limit = bq25890_find_idx(2000000, TBL_IINLIM);
+		input_current_limit = bq25890_charger_get_scaled_iinlim_regval(bq, 2000000);
 		if (bq->pump_express_vbus_max) {
 			queue_delayed_work(system_power_efficient_wq,
 					   &bq->pump_express_work,
@@ -754,11 +767,11 @@ static void bq25890_charger_external_power_changed(struct power_supply *psy)
 		break;
 	case POWER_SUPPLY_USB_TYPE_CDP:
 	case POWER_SUPPLY_USB_TYPE_ACA:
-		input_current_limit = bq25890_find_idx(1500000, TBL_IINLIM);
+		input_current_limit = bq25890_charger_get_scaled_iinlim_regval(bq, 1500000);
 		break;
 	case POWER_SUPPLY_USB_TYPE_SDP:
 	default:
-		input_current_limit = bq25890_find_idx(500000, TBL_IINLIM);
+		input_current_limit = bq25890_charger_get_scaled_iinlim_regval(bq, 500000);
 	}
 
 	bq25890_field_write(bq, F_IINLIM, input_current_limit);
@@ -1390,6 +1403,11 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 	device_property_read_u32(bq->dev, "linux,pump-express-vbus-max",
 				 &bq->pump_express_vbus_max);
 
+	/* Optional, left at 100% if property is not present */
+	bq->iinlim_percentage = 100;
+	device_property_read_u32(bq->dev, "linux,iinlim-percentage",
+				 &bq->iinlim_percentage);
+
 	bq->skip_reset = device_property_read_bool(bq->dev, "linux,skip-reset");
 	bq->read_back_init_data = device_property_read_bool(bq->dev,
 						"linux,read-back-settings");
-- 
2.38.1

