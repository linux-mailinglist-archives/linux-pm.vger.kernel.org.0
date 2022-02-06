Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185284AB13D
	for <lists+linux-pm@lfdr.de>; Sun,  6 Feb 2022 19:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbiBFSgC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Feb 2022 13:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiBFSgB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Feb 2022 13:36:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEA98C06173B
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644172560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kgwIkyLEoI1ztcypjQTvNjSp3hAwBSYwLmCFO/fufd0=;
        b=DGDLmHO0U1QEB/rhMgmj15QQvCMoGsNjOY46aT8Iekl5jiRNLR1U9NYA3bulomU5NqmRG1
        nXU0XsQZvcv7eAtBtQmSo1ZuMW0jrLBBMyP5GKs8VcxqMOKmE7PzB6Uhi9OUiJR7ZIqgxO
        z0FLIiipnqWs6OpZO1ANXtGZfDak2nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-aHRV9wQtNtaqF5pB3zZMvA-1; Sun, 06 Feb 2022 13:35:56 -0500
X-MC-Unique: aHRV9wQtNtaqF5pB3zZMvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E18D180FCAC;
        Sun,  6 Feb 2022 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CDCA8795B;
        Sun,  6 Feb 2022 18:35:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/8] power: supply: core: Add support for generic fwnodes to power_supply_get_battery_info()
Date:   Sun,  6 Feb 2022 19:35:37 +0100
Message-Id: <20220206183543.51200-3-hdegoede@redhat.com>
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

Add support to power_supply_get_battery_info() to read the properties from
other fwnode types such as swnodes added by platform code on x86 devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_core.c | 26 +++++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index fd08c018c18e..1a2440e212a7 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -571,7 +571,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 {
 	struct power_supply_resistance_temp_table *resist_table;
 	struct power_supply_battery_info *info;
-	struct device_node *battery_np;
+	struct device_node *battery_np = NULL;
+	struct fwnode_reference_args args;
 	struct fwnode_handle *fwnode;
 	const char *value;
 	int err, len, index;
@@ -610,17 +611,21 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		info->ocv_table_size[index]  = -EINVAL;
 	}
 
-	if (!psy->of_node) {
-		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
-			 __func__);
-		return -ENXIO;
-	}
+	if (psy->of_node) {
+		battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
+		if (!battery_np)
+			return -ENODEV;
 
-	battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
-	if (!battery_np)
-		return -ENODEV;
+		fwnode = fwnode_handle_get(of_fwnode_handle(battery_np));
+	} else {
+		err = fwnode_property_get_reference_args(
+					dev_fwnode(psy->dev.parent),
+					"monitored-battery", NULL, 0, 0, &args);
+		if (err)
+			return err;
 
-	fwnode = of_fwnode_handle(battery_np);
+		fwnode = args.fwnode;
+	}
 
 	err = fwnode_property_read_string(fwnode, "compatible", &value);
 	if (err)
@@ -778,6 +783,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	*info_out = info;
 
 out_put_node:
+	fwnode_handle_put(fwnode);
 	of_node_put(battery_np);
 	return err;
 }
-- 
2.33.1

