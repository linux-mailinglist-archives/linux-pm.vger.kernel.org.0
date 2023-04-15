Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03EC6E331D
	for <lists+linux-pm@lfdr.de>; Sat, 15 Apr 2023 20:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDOSYf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Apr 2023 14:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjDOSYe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2023 14:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D461E270A
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 11:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681583026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/OguBAG8ujVwLyROqRieaPOLAqeA9lkUfO9dNocElM=;
        b=NtGh4FEytzOQ0L6Yw3TuexjsSDZKdxEZ5STew04qUsrC+04YSpKkltvDAtafAzfKeEue3d
        dYpcwGCB3fTMP/8TZEd8LrydigzqYW0UG2sUjDBaC17FTfGmtwHWp0kpBWKyR/3iIti5iv
        EIqgENBYhC7c+1sQpmurZTfvlDN/UpQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-PqXvbXRiP_-nIX8yayjUWQ-1; Sat, 15 Apr 2023 14:23:45 -0400
X-MC-Unique: PqXvbXRiP_-nIX8yayjUWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08E3F1C05153;
        Sat, 15 Apr 2023 18:23:45 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29E7651FF;
        Sat, 15 Apr 2023 18:23:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Marek Vasut <marex@denx.de>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 02/10] power: supply: bq27xxx: Fix I2C IRQ race on remove
Date:   Sat, 15 Apr 2023 20:23:33 +0200
Message-Id: <20230415182341.86916-3-hdegoede@redhat.com>
In-Reply-To: <20230415182341.86916-1-hdegoede@redhat.com>
References: <20230415182341.86916-1-hdegoede@redhat.com>
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

devm_request_threaded_irq() requested IRQs are only free-ed after
the driver's remove function has ran. So the IRQ could trigger and
call bq27xxx_battery_update() after bq27xxx_battery_teardown() has
already run.

Switch to explicitly free-ing the IRQ in bq27xxx_battery_i2c_remove()
to fix this.

Fixes: 8807feb91b76 ("power: bq27xxx_battery: Add interrupt handling support")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index f8768997333b..6d3c74876339 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -179,7 +179,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, di);
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = request_threaded_irq(client->irq,
 				NULL, bq27xxx_battery_irq_handler_thread,
 				IRQF_ONESHOT,
 				di->name, di);
@@ -209,6 +209,7 @@ static void bq27xxx_battery_i2c_remove(struct i2c_client *client)
 {
 	struct bq27xxx_device_info *di = i2c_get_clientdata(client);
 
+	free_irq(client->irq, di);
 	bq27xxx_battery_teardown(di);
 
 	mutex_lock(&battery_mutex);
-- 
2.39.1

