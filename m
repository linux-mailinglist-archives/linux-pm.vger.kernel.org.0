Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8254A4B18
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jan 2022 16:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379949AbiAaP6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jan 2022 10:58:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379947AbiAaP6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jan 2022 10:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643644683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kgwIkyLEoI1ztcypjQTvNjSp3hAwBSYwLmCFO/fufd0=;
        b=ZCIgLCUnU8RNlW/+h8RUG8vZqadfOfUjGA+mSWV6aqlxpIyg0sex97kc1lW+DOEKR0ZgP4
        pOPx4re/7yXRm4l3TwHtz/Oh1NIndGlakL2mF8wLq5z8fGFkbdFjOD+naj2LVUmwzdDzux
        0PvcDGlyM8QFfewM5q6V5iJWfiIs8Dw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-iNTZUEGzN3KvFW0v7FFWjA-1; Mon, 31 Jan 2022 10:57:59 -0500
X-MC-Unique: iNTZUEGzN3KvFW0v7FFWjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD950363A5;
        Mon, 31 Jan 2022 15:57:58 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D65579529;
        Mon, 31 Jan 2022 15:57:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH 2/8] power: supply: core: Add support for generic fwnodes to power_supply_get_battery_info()
Date:   Mon, 31 Jan 2022 16:57:24 +0100
Message-Id: <20220131155730.309513-3-hdegoede@redhat.com>
In-Reply-To: <20220131155730.309513-1-hdegoede@redhat.com>
References: <20220131155730.309513-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

