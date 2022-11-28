Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C689763A506
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 10:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiK1JaD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 04:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiK1JaC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 04:30:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D01150
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669627744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lWkHuXdWa9N3RsWNfsjEbQcS12A1DO2kHVpt1AdJHw=;
        b=I+edB+8yk6kR1g43CDzgf8v6TEQ89KK6J4tbSeFIFpKYNSYeRkbmVC6RdaU0LAtIfMALHl
        dSjrnV4H+UQ/6nNLYqPrpBerrQHBoOT8oMfXmVVhOh7d+ck2EqYfpeo5y/9WGAymucMKke
        533anknGRXMmgv0lp6ehagXiCZsMgtE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-rBkknbhJP52z4fVprjZatg-1; Mon, 28 Nov 2022 04:29:03 -0500
X-MC-Unique: rBkknbhJP52z4fVprjZatg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B03D7106D0D3;
        Mon, 28 Nov 2022 09:29:02 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.195.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9639FD48;
        Mon, 28 Nov 2022 09:29:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/9] power: supply: bq25890: Fix usb-notifier probe and remove races
Date:   Mon, 28 Nov 2022 10:28:49 +0100
Message-Id: <20221128092856.71619-3-hdegoede@redhat.com>
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

There are 2 races surrounding the usb-notifier:

1. The notifier, and thus usb_work, may run before the bq->charger
   power_supply class device is registered. But usb_work may call
   power_supply_changed() which relies on the psy device being registered.

2. usb_work may be pending/running at remove() time, so it needs to be
   cancelled on remove after unregistering the usb-notifier.

Fix 1. by moving usb-notifier registration to after the power_supply
registration.

Fix 2. by adding a cancel_work_sync() call directly after the usb-notifier
unregistration.

Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use return dev_err_probe() for the exit path previously using goto
---
 drivers/power/supply/bq25890_charger.c | 30 +++++++++++---------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 866c475bb735..2d731ea58323 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1391,40 +1391,34 @@ static int bq25890_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	if (!IS_ERR_OR_NULL(bq->usb_phy)) {
-		INIT_WORK(&bq->usb_work, bq25890_usb_work);
-		bq->usb_nb.notifier_call = bq25890_usb_notifier;
-		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
-	}
-
 	ret = bq25890_power_supply_init(bq);
-	if (ret < 0) {
-		dev_err(dev, "Failed to register power supply\n");
-		goto err_unregister_usb_notifier;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "registering power supply\n");
 
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					bq25890_irq_handler_thread,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					BQ25890_IRQ_PIN, bq);
 	if (ret)
-		goto err_unregister_usb_notifier;
-
-	return 0;
+		return ret;
 
-err_unregister_usb_notifier:
-	if (!IS_ERR_OR_NULL(bq->usb_phy))
-		usb_unregister_notifier(bq->usb_phy, &bq->usb_nb);
+	if (!IS_ERR_OR_NULL(bq->usb_phy)) {
+		INIT_WORK(&bq->usb_work, bq25890_usb_work);
+		bq->usb_nb.notifier_call = bq25890_usb_notifier;
+		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
+	}
 
-	return ret;
+	return 0;
 }
 
 static void bq25890_remove(struct i2c_client *client)
 {
 	struct bq25890_device *bq = i2c_get_clientdata(client);
 
-	if (!IS_ERR_OR_NULL(bq->usb_phy))
+	if (!IS_ERR_OR_NULL(bq->usb_phy)) {
 		usb_unregister_notifier(bq->usb_phy, &bq->usb_nb);
+		cancel_work_sync(&bq->usb_work);
+	}
 
 	if (!bq->skip_reset) {
 		/* reset all registers to default values */
-- 
2.37.3

