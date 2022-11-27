Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD79639C2D
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 19:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiK0SDs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 13:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiK0SDr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 13:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F5EF67
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 10:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669572170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kL548M6tbzSDM0ghA+n44605jlsETPHGplCX3SsGsy4=;
        b=ZDdZMENiPxnZn0h92IM+xJpCsL1BxMBft35Yy0/GHdpoIfl1/9IldsWrnxRjKfDK3/+RVo
        xcPOjprijlmiHf+56hOatRK+FWWZTfs5IwyUQeh5IvQiBkNqaXSfuY2WkcCYrYna3RCLsN
        k6IsdQXyXLV63YIv8IStowvLMB0FjGI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-2Gr4rO6DPKCS1lRCMXQ_Zg-1; Sun, 27 Nov 2022 13:02:47 -0500
X-MC-Unique: 2Gr4rO6DPKCS1lRCMXQ_Zg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C9F529AA2FB;
        Sun, 27 Nov 2022 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9734140EBF5;
        Sun, 27 Nov 2022 18:02:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 03/10] power: supply: bq25890: Fix usb-notifier probe and remove races
Date:   Sun, 27 Nov 2022 19:02:26 +0100
Message-Id: <20221127180233.103678-4-hdegoede@redhat.com>
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

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 30d77afab839..032a10a3877b 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1387,16 +1387,10 @@ static int bq25890_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	if (!IS_ERR_OR_NULL(bq->usb_phy)) {
-		INIT_WORK(&bq->usb_work, bq25890_usb_work);
-		bq->usb_nb.notifier_call = bq25890_usb_notifier;
-		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
-	}
-
 	ret = bq25890_power_supply_init(bq);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register power supply\n");
-		goto err_unregister_usb_notifier;
+		return ret;
 	}
 
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
@@ -1404,23 +1398,25 @@ static int bq25890_probe(struct i2c_client *client)
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
2.38.1

