Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41FA2B7D6D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 13:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKRMNW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 07:13:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgKRMNW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 07:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605701600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=seIJSZO4a6Gn0MTD1oL0YAI60L4ED6sSQHzUCcH54s4=;
        b=FuqIIBZyXCS1khJlUIyLrxAF1TwLml7ZThK5M8hG4EzroJueLqQnrRwGLxxSDVitlgCU7z
        auhgE5M6nFvBMdxIDO+yO8nPw9NTLxcHCSLNkiEzACYqZtSWb/NsJ61EmFj5MFT0KqD0HU
        qYQBcsfAYNQ+pJ5mACIbdyhoGEPnvUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-vLTFWlJzPr-FyiRTPFISlw-1; Wed, 18 Nov 2020 07:13:17 -0500
X-MC-Unique: vLTFWlJzPr-FyiRTPFISlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D576557205;
        Wed, 18 Nov 2020 12:13:14 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-94.ams2.redhat.com [10.36.114.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2A8B1759F;
        Wed, 18 Nov 2020 12:13:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: axp288_charger: Fix HP Pavilion x2 10 DMI matching
Date:   Wed, 18 Nov 2020 13:13:12 +0100
Message-Id: <20201118121312.11304-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 9c80662a74cd ("power: supply: axp288_charger: Add special handling
for HP Pavilion x2 10") added special handling for HP Pavilion x2 10
models which use the weird combination of a Type-C connector and the
non Type-C aware AXP288 PMIC.

This special handling was activated by a DMI match a the product-name
of "HP Pavilion x2 Detachable". Recently I've learned that there are
also older "HP Pavilion x2 Detachable" models with an AXP288 PMIC +
a micro-usb connector where we should not activate the special handling
for the Type-C connectors.

Extend the matching to also match on the DMI board-name and match on the
2 boards (one Bay Trail based one Cherry Trail based) of which we are
certain that they use the AXP288 + Type-C connector combination.

Note the DSDT code from these older (AXP288 + micro-USB) models contains
some AML code (which never runs under Linux) which reads the micro-USB
connector id-pin and if it is pulled to ground, which would normally mean
the port is in host mode!, then it sets the input-current-limit to 3A,
it seems HP is using the micro-USB port as a charging only connector
and identifies their own 3A capable charger though this hack which is a
major violation of the USB specs. Note HP also hardcodes a 2A limit
when the id-pin is not pulled to ground, which is also in violation
of the specs.

I've no intention to add support for HP's hack to support 3A charging
on these older models. By making the DMI matches for the Type-C equipped
models workaround more tighter, these older models will be treated just
like any other AXP288 + micro-USB equipped device and the input-current
limit will follow the BC 1.2 spec (using the defacto standard values
there where the BC 1.2 spec defines a range).

Fixes: 9c80662a74cd ("power: supply: axp288_charger: Add special handling for HP Pavilion x2 10")
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1896924
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 28 ++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 9d981b76c1e7..a4df1ea92386 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -548,14 +548,15 @@ static irqreturn_t axp288_charger_irq_thread_handler(int irq, void *dev)
 
 /*
  * The HP Pavilion x2 10 series comes in a number of variants:
- * Bay Trail SoC    + AXP288 PMIC, DMI_BOARD_NAME: "815D"
- * Cherry Trail SoC + AXP288 PMIC, DMI_BOARD_NAME: "813E"
- * Cherry Trail SoC + TI PMIC,     DMI_BOARD_NAME: "827C" or "82F4"
+ * Bay Trail SoC    + AXP288 PMIC, Micro-USB, DMI_BOARD_NAME: "8021"
+ * Bay Trail SoC    + AXP288 PMIC, Type-C,    DMI_BOARD_NAME: "815D"
+ * Cherry Trail SoC + AXP288 PMIC, Type-C,    DMI_BOARD_NAME: "813E"
+ * Cherry Trail SoC + TI PMIC,     Type-C,    DMI_BOARD_NAME: "827C" or "82F4"
  *
- * The variants with the AXP288 PMIC are all kinds of special:
+ * The variants with the AXP288 + Type-C connector are all kinds of special:
  *
- * 1. All variants use a Type-C connector which the AXP288 does not support, so
- * when using a Type-C charger it is not recognized. Unlike most AXP288 devices,
+ * 1. They use a Type-C connector which the AXP288 does not support, so when
+ * using a Type-C charger it is not recognized. Unlike most AXP288 devices,
  * this model actually has mostly working ACPI AC / Battery code, the ACPI code
  * "solves" this by simply setting the input_current_limit to 3A.
  * There are still some issues with the ACPI code, so we use this native driver,
@@ -578,12 +579,17 @@ static irqreturn_t axp288_charger_irq_thread_handler(int irq, void *dev)
  */
 static const struct dmi_system_id axp288_hp_x2_dmi_ids[] = {
 	{
-		/*
-		 * Bay Trail model has "Hewlett-Packard" as sys_vendor, Cherry
-		 * Trail model has "HP", so we only match on product_name.
-		 */
 		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion x2 Detachable"),
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP Pavilion x2 Detachable"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "815D"),
+		},
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP Pavilion x2 Detachable"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "813E"),
 		},
 	},
 	{} /* Terminating entry */
-- 
2.28.0

