Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CCD6E324C
	for <lists+linux-pm@lfdr.de>; Sat, 15 Apr 2023 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDOQIf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Apr 2023 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDOQIf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2023 12:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516483A8D
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681574874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YThcj2qtTbxSX+mn9TfsRoP5EDyFMjMFMuvOeXi5q+g=;
        b=Am3pOnS3nu6B5La/qHY5AWxA+8kCt3m+kFipVGj/AsIAy11JD5/A1mv/xTTxk2pMdynRuK
        o9/0Qs0RYFqgwrkc/NCpDEhg8zyBjf5uE7SoBopH37WqeWlM9Pi90HzeiENGOt2ee0fZbB
        dqm/cwM2lM0Tyfcms/+oiQIG7SgwAi4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-1Y76vm7EPFenae5BJEOJQQ-1; Sat, 15 Apr 2023 12:07:43 -0400
X-MC-Unique: 1Y76vm7EPFenae5BJEOJQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F179811E7C;
        Sat, 15 Apr 2023 16:07:43 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1417A2166B26;
        Sat, 15 Apr 2023 16:07:41 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>
Subject: [PATCH 5/6] power: supply: max17042_battery: Refactor max17042_external_power_changed()
Date:   Sat, 15 Apr 2023 18:07:33 +0200
Message-Id: <20230415160734.70475-6-hdegoede@redhat.com>
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

max17042_external_power_changed() is a wrapper around
"power_supply_changed(psy);" and it has the same prototype.

Remove it, replacing it with making the external_power_changed
callback directly point to power_supply_changed.

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc: Purism Kernel Team <kernel@puri.sm>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/max17042_battery.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 89cabe8ed3b0..6a2d00d95a39 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -499,11 +499,6 @@ static int max17042_property_is_writeable(struct power_supply *psy,
 	return ret;
 }
 
-static void max17042_external_power_changed(struct power_supply *psy)
-{
-	power_supply_changed(psy);
-}
-
 static int max17042_write_verify_reg(struct regmap *map, u8 reg, u32 value)
 {
 	int retries = 8;
@@ -1016,7 +1011,7 @@ static const struct power_supply_desc max17042_psy_desc = {
 	.get_property	= max17042_get_property,
 	.set_property	= max17042_set_property,
 	.property_is_writeable	= max17042_property_is_writeable,
-	.external_power_changed	= max17042_external_power_changed,
+	.external_power_changed	= power_supply_changed,
 	.properties	= max17042_battery_props,
 	.num_properties	= ARRAY_SIZE(max17042_battery_props),
 };
-- 
2.39.1

