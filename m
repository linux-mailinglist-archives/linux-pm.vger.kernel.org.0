Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5F76E324B
	for <lists+linux-pm@lfdr.de>; Sat, 15 Apr 2023 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjDOQIf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Apr 2023 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDOQIe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2023 12:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DB1358B
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681574866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uA9B5Txr/0nYZ59u2S5fdcHM1xEivz4h9GU45LLo4w=;
        b=UIWbhWQYf3FESRT8CKLf2DrwgXsWRx2d3T/FkakbehOro1OMwL1wh7uR+Av8JegBUrBNjZ
        H36eem9QLLyLO5eZ8RIqQLO87XAyvEOsYyMM9wciVlUnwcpVn3m7NdoAYlubO39fphI/4a
        Tw3j9+auF6K8O4ce5Ato1/hLPyIpzAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-7ZEDQp7xMkG7IoHdgoIKKQ-1; Sat, 15 Apr 2023 12:07:44 -0400
X-MC-Unique: 7ZEDQp7xMkG7IoHdgoIKKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13FB285A5B1;
        Sat, 15 Apr 2023 16:07:44 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F9C22166B26;
        Sat, 15 Apr 2023 16:07:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH 6/6] power: supply: twl4030_madc_battery: Refactor twl4030_madc_bat_ext_changed()
Date:   Sat, 15 Apr 2023 18:07:34 +0200
Message-Id: <20230415160734.70475-7-hdegoede@redhat.com>
In-Reply-To: <20230415160734.70475-1-hdegoede@redhat.com>
References: <20230415160734.70475-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

twl4030_madc_bat_ext_changed() is a wrapper around
"power_supply_changed(psy);" and it has the same prototype.

Remove it, replacing it with making the external_power_changed
callback directly point to power_supply_changed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this has been compile tested only
---
 drivers/power/supply/twl4030_madc_battery.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/power/supply/twl4030_madc_battery.c b/drivers/power/supply/twl4030_madc_battery.c
index 48649dcfe3a9..7fe029673b22 100644
--- a/drivers/power/supply/twl4030_madc_battery.c
+++ b/drivers/power/supply/twl4030_madc_battery.c
@@ -168,19 +168,13 @@ static int twl4030_madc_bat_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static void twl4030_madc_bat_ext_changed(struct power_supply *psy)
-{
-	power_supply_changed(psy);
-}
-
 static const struct power_supply_desc twl4030_madc_bat_desc = {
 	.name			= "twl4030_battery",
 	.type			= POWER_SUPPLY_TYPE_BATTERY,
 	.properties		= twl4030_madc_bat_props,
 	.num_properties		= ARRAY_SIZE(twl4030_madc_bat_props),
 	.get_property		= twl4030_madc_bat_get_property,
-	.external_power_changed	= twl4030_madc_bat_ext_changed,
-
+	.external_power_changed	= power_supply_changed,
 };
 
 static int twl4030_cmp(const void *a, const void *b)
-- 
2.39.1

