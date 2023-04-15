Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F86E3249
	for <lists+linux-pm@lfdr.de>; Sat, 15 Apr 2023 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDOQIb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Apr 2023 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjDOQI2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2023 12:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FD930F3
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 09:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681574865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=useEt/taU7+rp1Vfh9SeNhZNj5VIMkx1sdw+zWx8ybg=;
        b=DzfIbNOWFbagpFeeO7wCG+ZTHpNsLwR52XE+3rEdt8FjiU0TGpkE3GHew4sqtH4CZY+cjf
        yMOxwXcgusaeYvw10Rg8u8ihJrNUKWn8dS2c16Tb4dDDB90/EOjXrld3JGICQCdWl58o3c
        Q5SEkq7swT9Gqw7bh8sf3Zb/teoDexc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-VmfAGl5yNDi7ZWq8xdZgdw-1; Sat, 15 Apr 2023 12:07:42 -0400
X-MC-Unique: VmfAGl5yNDi7ZWq8xdZgdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7920185A790;
        Sat, 15 Apr 2023 16:07:41 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5B952166B26;
        Sat, 15 Apr 2023 16:07:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 4/6] power: supply: sc27xx: Fix external_power_changed race
Date:   Sat, 15 Apr 2023 18:07:32 +0200
Message-Id: <20230415160734.70475-5-hdegoede@redhat.com>
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

sc27xx_fgu_external_power_changed() dereferences data->battery,
which gets sets in ab8500_btemp_probe() like this:

	data->battery = devm_power_supply_register(dev, &sc27xx_fgu_desc,
                                                   &fgu_cfg);

As soon as devm_power_supply_register() has called device_add()
the external_power_changed callback can get called. So there is a window
where sc27xx_fgu_external_power_changed() may get called while
data->battery has not been set yet leading to a NULL pointer dereference.

Fixing this is easy. The external_power_changed callback gets passed
the power_supply which will eventually get stored in data->battery,
so sc27xx_fgu_external_power_changed() can simply directly use
the passed in psy argument which is always valid.

After this change sc27xx_fgu_external_power_changed() is reduced to just
"power_supply_changed(psy);" and it has the same prototype. While at it
simply replace it with making the external_power_changed callback
directly point to power_supply_changed.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this has been compile tested only
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 632977f84b95..bd23c4d9fed4 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -733,13 +733,6 @@ static int sc27xx_fgu_set_property(struct power_supply *psy,
 	return ret;
 }
 
-static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
-{
-	struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
-
-	power_supply_changed(data->battery);
-}
-
 static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 					    enum power_supply_property psp)
 {
@@ -774,7 +767,7 @@ static const struct power_supply_desc sc27xx_fgu_desc = {
 	.num_properties		= ARRAY_SIZE(sc27xx_fgu_props),
 	.get_property		= sc27xx_fgu_get_property,
 	.set_property		= sc27xx_fgu_set_property,
-	.external_power_changed	= sc27xx_fgu_external_power_changed,
+	.external_power_changed	= power_supply_changed,
 	.property_is_writeable	= sc27xx_fgu_property_is_writeable,
 	.no_thermal		= true,
 };
-- 
2.39.1

