Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167F01C161B
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 16:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgEANj5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 09:39:57 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:23304 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731236AbgEANj4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 09:39:56 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49DCzY6Xj4z7N;
        Fri,  1 May 2020 15:39:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588340394; bh=/jLlputangsPP+b55RSTFIHnXSnuLA7C91+qL92JlCs=;
        h=Date:From:Subject:In-Reply-To:To:Cc:From;
        b=d4UrYz7eA6oL6JT7nGH+GCCO5ILfvvFRR4THomwkN1imzCtf8Xu1ZTum5nuTNbskC
         s/y9NJ0vIGFTKXXHQzBY3vK0JfegKRTMzr+ian5OHuuW8MfOpl4AJdt93kApnwEUyt
         CKR5T5tPokGTpX+ceptKT4UZPmzgMGbTXE6o2e7iSFfqCeYtLiSw0SiqKZE4PIAdEk
         wODz178taLb/kqGH0iWeFO3T465dW7j2TUy7I4OsyyW8PKP83MzaaYRyjlYBggyd67
         so0epaXCFiWpSquBFDLprlJPdQiwi5+fa7HlOp0/MJmre0xhaPwPK1eSZF/TEQ9y+d
         NXfFCtuEZjdWw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 01 May 2020 15:39:53 +0200
Message-Id: <995cf2c7d41d4895c319b60ea4ea83e858c34cef.1588340276.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] power: charger-manager: fix adding of optional properties
In-Reply-To: <20200501133008.GA8927@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use num_properties to index added property.
This will prevent overwriting POWER_SUPPLY_PROP_CHARGE_NOW with
POWER_SUPPLY_PROP_CURRENT_NOW and leaving the latter entry
uninitialized.

For clarity, num_properties is initialized with length of the copied
array instead of relying on previously memcpy'd value.

Fixes: 0a46510addc7 ("power: supply: charger-manager: Prepare for const properties")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/charger-manager.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index a71e2ee81423..2ef53dc1f2fb 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1729,7 +1729,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	memcpy(properties, default_charger_props,
 		sizeof(enum power_supply_property) *
 		ARRAY_SIZE(default_charger_props));
-	num_properties = psy_default.num_properties;
+	num_properties = ARRAY_SIZE(default_charger_props);
 
 	/* Find which optional psy-properties are available */
 	fuel_gauge = power_supply_get_by_name(desc->psy_fuel_gauge);
@@ -1740,14 +1740,14 @@ static int charger_manager_probe(struct platform_device *pdev)
 	}
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
-		properties[cm->charger_psy_desc.num_properties] =
+		properties[num_properties] =
 				POWER_SUPPLY_PROP_CHARGE_NOW;
 		num_properties++;
 	}
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CURRENT_NOW,
 					  &val)) {
-		properties[cm->charger_psy_desc.num_properties] =
+		properties[num_properties] =
 				POWER_SUPPLY_PROP_CURRENT_NOW;
 		num_properties++;
 	}
-- 
2.20.1

