Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C94AB13E
	for <lists+linux-pm@lfdr.de>; Sun,  6 Feb 2022 19:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345986AbiBFSgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Feb 2022 13:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiBFSgC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Feb 2022 13:36:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA29DC043184
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 10:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644172560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKCL19dsb6kFwMmN5tlInwL0e0eF4SS/UJqQdCVlOOA=;
        b=MuLlC+KL13K+OwkfTmpVyfzDZCpAua4dthbRmp4Kfgh/lJELtmOpJhpi7u+ISPHgOPYtE4
        FyxImIDweZd+rqvOy3LIC9D/Q/uDte3fLH1feJ5ZsWMRSH8Vs8ppoD9i9P59o2LhvhY+Lr
        4QbURT19qC5MX0S+1GikBCUpDOY5q/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-RunkeghQNvGPNO18zB7E9A-1; Sun, 06 Feb 2022 13:35:57 -0500
X-MC-Unique: RunkeghQNvGPNO18zB7E9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4450801B0D;
        Sun,  6 Feb 2022 18:35:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4FFB85EE4;
        Sun,  6 Feb 2022 18:35:55 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH v2 3/8] power: supply: bq24190_charger: Turn off 5V boost regulator on shutdown
Date:   Sun,  6 Feb 2022 19:35:38 +0100
Message-Id: <20220206183543.51200-4-hdegoede@redhat.com>
In-Reply-To: <20220206183543.51200-1-hdegoede@redhat.com>
References: <20220206183543.51200-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Turn off the 5V boost regulator on shutdown, there are 3 reasons for
doing this:

1. It drains he battery if left on
2. If left on the device will not charge when plugged into a charger
3. If left on and the powered peripheral attached to a Type-C port is
   removed before the next boot, then the Type-C port-controller will
   see VBus being present while nothing is attached confusing the
   TCPM state-machine.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index a1c957a26f07..7414830a70e4 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -497,10 +497,8 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 }
 #endif
 
-#ifdef CONFIG_REGULATOR
-static int bq24190_set_charge_mode(struct regulator_dev *dev, u8 val)
+static int bq24190_set_charge_mode(struct bq24190_dev_info *bdi, u8 val)
 {
-	struct bq24190_dev_info *bdi = rdev_get_drvdata(dev);
 	int ret;
 
 	ret = pm_runtime_get_sync(bdi->dev);
@@ -520,14 +518,17 @@ static int bq24190_set_charge_mode(struct regulator_dev *dev, u8 val)
 	return ret;
 }
 
+#ifdef CONFIG_REGULATOR
 static int bq24190_vbus_enable(struct regulator_dev *dev)
 {
-	return bq24190_set_charge_mode(dev, BQ24190_REG_POC_CHG_CONFIG_OTG);
+	return bq24190_set_charge_mode(rdev_get_drvdata(dev),
+				       BQ24190_REG_POC_CHG_CONFIG_OTG);
 }
 
 static int bq24190_vbus_disable(struct regulator_dev *dev)
 {
-	return bq24190_set_charge_mode(dev, BQ24190_REG_POC_CHG_CONFIG_CHARGE);
+	return bq24190_set_charge_mode(rdev_get_drvdata(dev),
+				       BQ24190_REG_POC_CHG_CONFIG_CHARGE);
 }
 
 static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
@@ -1870,6 +1871,14 @@ static int bq24190_remove(struct i2c_client *client)
 	return 0;
 }
 
+static void bq24190_shutdown(struct i2c_client *client)
+{
+	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
+
+	/* Turn off 5V boost regulator on shutdown */
+	bq24190_set_charge_mode(bdi, BQ24190_REG_POC_CHG_CONFIG_CHARGE);
+}
+
 static __maybe_unused int bq24190_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1980,6 +1989,7 @@ MODULE_DEVICE_TABLE(of, bq24190_of_match);
 static struct i2c_driver bq24190_driver = {
 	.probe		= bq24190_probe,
 	.remove		= bq24190_remove,
+	.shutdown	= bq24190_shutdown,
 	.id_table	= bq24190_i2c_ids,
 	.driver = {
 		.name		= "bq24190-charger",
-- 
2.33.1

