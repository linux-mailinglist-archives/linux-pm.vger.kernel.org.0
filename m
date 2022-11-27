Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E04639C30
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 19:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiK0SDu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 13:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiK0SDs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 13:03:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A66358
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 10:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669572169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2I0caNdjcs4I6PtwGdpYPZhG3olKWZffSgdsnKbX3UI=;
        b=cEX95jkVKEyE1M0TX5SR1klCZNP/0KzBUEa55FXxas5PF0di2rsb1ZEbDczNmkEbbqnhFX
        54YvW5lH/esB3v0x5qgmMEE914XzOXL7VEnibMv/iDy1G7I26Gh7fczzvWxNoy4UwzRVsC
        ynBqV/GyoXsssO/jD/zFGcYro8C/K6M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-Zf2aiyHeOsK4XNhWApcdxw-1; Sun, 27 Nov 2022 13:02:46 -0500
X-MC-Unique: Zf2aiyHeOsK4XNhWApcdxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3B77380452F;
        Sun, 27 Nov 2022 18:02:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E9D3140EBF5;
        Sun, 27 Nov 2022 18:02:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 02/10] power: supply: bq25890: Ensure pump_express_work is cancelled on remove
Date:   Sun, 27 Nov 2022 19:02:25 +0100
Message-Id: <20221127180233.103678-3-hdegoede@redhat.com>
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

The pump_express_work which gets queued from an external_power_changed
callback might be pending / running on remove() (or on probe failure).

Add a devm action cancelling the work, to ensure that it is cancelled.

Note the devm action is added before devm_power_supply_register(), making
it run after devm unregisters the power_supply, so that the work cannot
be queued anymore (this is also why a devm action is used for this).

Fixes: 48f45b094dbb ("power: supply: bq25890: Support higher charging voltages through Pump Express+ protocol")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 512c81662eea..30d77afab839 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1317,6 +1317,13 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 	return 0;
 }
 
+static void bq25890_non_devm_cleanup(void *data)
+{
+	struct bq25890_device *bq = data;
+
+	cancel_delayed_work_sync(&bq->pump_express_work);
+}
+
 static int bq25890_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1372,6 +1379,10 @@ static int bq25890_probe(struct i2c_client *client)
 	/* OTG reporting */
 	bq->usb_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
 
+	ret = devm_add_action_or_reset(dev, bq25890_non_devm_cleanup, bq);
+	if (ret)
+		return ret;
+
 	ret = bq25890_register_regulator(bq);
 	if (ret)
 		return ret;
-- 
2.38.1

