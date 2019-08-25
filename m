Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF99C4BC
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2019 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfHYPly (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Aug 2019 11:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfHYPly (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 25 Aug 2019 11:41:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C97387642;
        Sun, 25 Aug 2019 15:41:54 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-48.ams2.redhat.com [10.36.116.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0919919C70;
        Sun, 25 Aug 2019 15:41:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] power: supply: axp288_fuel_gauge: Sort the DMI blacklist alphabetically
Date:   Sun, 25 Aug 2019 17:41:51 +0200
Message-Id: <20190825154152.80087-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 25 Aug 2019 15:41:54 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The blacklist is getting big enough that it is good to have some sort
of fixed order for it, sort it alphabetically.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 44169dabb705..6db2e86098e9 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -674,6 +674,7 @@ static void fuel_gauge_init_irq(struct axp288_fg_info *info)
 /*
  * Some devices have no battery (HDMI sticks) and the axp288 battery's
  * detection reports one despite it not being there.
+ * Please keep this listed sorted alphabetically.
  */
 static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 	{
@@ -696,6 +697,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
 		},
 	},
+	{
+		/* ECS EF20EA */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
+		},
+	},
 	{
 		/* Intel Cherry Trail Compute Stick, Windows version */
 		.matches = {
@@ -719,12 +726,6 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
 		},
 	},
-	{
-		/* ECS EF20EA */
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
-		},
-	},
 	{}
 };
 
-- 
2.23.0

