Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD641C51D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 15:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbhI2NEH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 09:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343889AbhI2NEG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Sep 2021 09:04:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DBB3613A5;
        Wed, 29 Sep 2021 13:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632920545;
        bh=WInTJmPiSK4jMGGCnR7R3DLEsIBs9v+fGwXm3Laif7A=;
        h=From:To:Cc:Subject:Date:From;
        b=LHJ38MYpGDL+jDZKAZDlTYgADdLTbpPLmrxyindyeKDB+zYkkiuQuieJy433JjiU4
         CkKwzudBdTfYOcBqSfB6qTsTiVpx/zTsdc/7vmQub/vAstww7RxEIhbm/A5Y/g7bU6
         92QMkP8N8sRXzrsL5D6hxOwsFg6NEx/fVm3MDpZ6zmlE/nlfds1ixjW36mNiePxAiP
         Aa46bZC6tp4knxL4T231HDDOcuuFOHImmecvO1nRXp274yl6ndZX/SB8q9p1dty6TT
         6mkC8J9SQHLQxMnlbyURB2UXPU9lwMrhZJyg42pK+H56gqzGnyVozhsEq4y1lhp20X
         9sYyK5KBNLNzg==
From:   SeongJae Park <sj@kernel.org>
To:     sre@kernel.org
Cc:     mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] power: supply: core: Fix a build failure due to psy_has_property() definition location
Date:   Wed, 29 Sep 2021 13:02:18 +0000
Message-Id: <20210929130218.26598-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 9ba533eb99bb ("power: supply: core: Add psy_has_property()") in -next
tree defines 'psy_has_property()' when 'CONFIG_THERMAL' is set.  But, it is
also called from '__power_supply_register()', which is defined even if
'CONFIG_THERMAL' is unset.  As a result, the build fails when 'CONFIG_THERMAL'
is undefined as below.

    .../drivers/power/supply/power_supply_core.c: In function '__power_supply_register':
    .../drivers/power/supply/power_supply_core.c:1137:6: error: implicit declaration of function 'psy_has_property' [-Werror=implicit-function-declaration]
     1137 |  if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
          |      ^~~~~~~~~~~~~~~~
    cc1: some warnings being treated as errors
    .../scripts/Makefile.build:288: recipe for target 'drivers/power/supply/power_supply_core.o' failed
    make[4]: *** [drivers/power/supply/power_supply_core.o] Error 1

This commit fixes the issue by moving the definition out of the '#ifdef' block.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 32 ++++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 75575ea45f21..fc12a4f407f4 100644
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
2.17.1

