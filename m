Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908C041AE5B
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 14:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbhI1MCI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 08:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbhI1MCH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 08:02:07 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BBEC061604
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 05:00:27 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:a9b1:8dc9:da2c:b028])
        by xavier.telenet-ops.be with bizsmtp
        id zQ0Q250023Yhtpx01Q0QgN; Tue, 28 Sep 2021 14:00:24 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mVBmZ-000JpQ-Kl; Tue, 28 Sep 2021 14:00:23 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mVBmZ-009dEZ-94; Tue, 28 Sep 2021 14:00:23 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] power: supply: core: Move psy_has_property() to fix build
Date:   Tue, 28 Sep 2021 14:00:19 +0200
Message-Id: <7b35a74f2c2ad19c8dc1ca60c59e48a14288677f.1632830348.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If CONFIG_THERMAL=n:

    drivers/power/supply/power_supply_core.c: In function ‘__power_supply_register’:
    drivers/power/supply/power_supply_core.c:1137:6: error: implicit declaration of function ‘psy_has_property’ [-Werror=implicit-function-declaration]
     1137 |  if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
	  |      ^~~~~~~~~~~~~~~~

Fix this by moving psy_has_property() outside the section protected by
CONFIG_THERMAL.

Fixes: 9ba533eb99bb2acf ("power: supply: core: Add psy_has_property()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/power/supply/power_supply_core.c | 32 ++++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 75575ea45f21ddc7..fc12a4f407f431a6 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -951,6 +951,22 @@ void power_supply_unreg_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(power_supply_unreg_notifier);
 
+static bool psy_has_property(const struct power_supply_desc *psy_desc,
+			     enum power_supply_property psp)
+{
+	bool found = false;
+	int i;
+
+	for (i = 0; i < psy_desc->num_properties; i++) {
+		if (psy_desc->properties[i] == psp) {
+			found = true;
+			break;
+		}
+	}
+
+	return found;
+}
+
 #ifdef CONFIG_THERMAL
 static int power_supply_read_temp(struct thermal_zone_device *tzd,
 		int *temp)
@@ -975,22 +991,6 @@ static struct thermal_zone_device_ops psy_tzd_ops = {
 	.get_temp = power_supply_read_temp,
 };
 
-static bool psy_has_property(const struct power_supply_desc *psy_desc,
-			     enum power_supply_property psp)
-{
-	bool found = false;
-	int i;
-
-	for (i = 0; i < psy_desc->num_properties; i++) {
-		if (psy_desc->properties[i] == psp) {
-			found = true;
-			break;
-		}
-	}
-
-	return found;
-}
-
 static int psy_register_thermal(struct power_supply *psy)
 {
 	int ret;
-- 
2.25.1

