Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0034A4B17
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jan 2022 16:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379946AbiAaP6D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jan 2022 10:58:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232673AbiAaP6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jan 2022 10:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643644682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKCL19dsb6kFwMmN5tlInwL0e0eF4SS/UJqQdCVlOOA=;
        b=IOx/kgOc8crrEzd42fHd/JPikvxQjHs+eG8CLG7aVzej1F7CynbnpthHnbYBDydbZ0PpjL
        bicowDoflV1V3x8B1CB2oCev3bn50HU/MKpuWAMq9OjgNUo5V0yZpqg/Bg0hVi49/VUx39
        XhFZJ08iSzoskdTB5OlSmyt0Q/WC7sU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-fBE7JC9SOUy2V-OzhBW33w-1; Mon, 31 Jan 2022 10:58:01 -0500
X-MC-Unique: fBE7JC9SOUy2V-OzhBW33w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D78D1853026;
        Mon, 31 Jan 2022 15:58:00 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15A7479529;
        Mon, 31 Jan 2022 15:57:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH 3/8] power: supply: bq24190_charger: Turn off 5V boost regulator on shutdown
Date:   Mon, 31 Jan 2022 16:57:25 +0100
Message-Id: <20220131155730.309513-4-hdegoede@redhat.com>
In-Reply-To: <20220131155730.309513-1-hdegoede@redhat.com>
References: <20220131155730.309513-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

