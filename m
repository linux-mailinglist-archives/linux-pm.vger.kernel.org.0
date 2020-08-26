Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F094225319C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 16:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHZOmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 10:42:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43844 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHZOmE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 10:42:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8345E2994D6
Received: by jupiter.universe (Postfix, from userid 1000)
        id 57832480113; Wed, 26 Aug 2020 16:42:00 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 2/2] power: supply: smb347-charger: Use generic property framework
Date:   Wed, 26 Aug 2020 16:41:59 +0200
Message-Id: <20200826144159.353837-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826144159.353837-1-sebastian.reichel@collabora.com>
References: <20200826144159.353837-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simplify the driver and remove the DT specific code by
using the generic device property framework.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/smb347-charger.c | 40 +++++++++++++--------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index b182727dfc90..d3bf35ed12ce 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/power_supply.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/power/summit,smb347-charger.h>
@@ -1176,7 +1177,7 @@ static bool smb347_readable_reg(struct device *dev, unsigned int reg)
 
 static void smb347_dt_parse_dev_info(struct smb347_charger *smb)
 {
-	struct device_node *np = smb->dev->of_node;
+	struct device *dev = smb->dev;
 
 	smb->soft_temp_limit_compensation =
 					SMB3XX_SOFT_TEMP_COMPENSATE_DEFAULT;
@@ -1190,32 +1191,29 @@ static void smb347_dt_parse_dev_info(struct smb347_charger *smb)
 	smb->hard_hot_temp_limit  = SMB3XX_TEMP_USE_DEFAULT;
 
 	/* Charging constraints */
-	of_property_read_u32(np, "summit,fast-voltage-threshold-microvolt",
-			     &smb->pre_to_fast_voltage);
-	of_property_read_u32(np, "summit,mains-current-limit-microamp",
-			     &smb->mains_current_limit);
-	of_property_read_u32(np, "summit,usb-current-limit-microamp",
-			     &smb->usb_hc_current_limit);
+	device_property_read_u32(dev, "summit,fast-voltage-threshold-microvolt",
+				 &smb->pre_to_fast_voltage);
+	device_property_read_u32(dev, "summit,mains-current-limit-microamp",
+				 &smb->mains_current_limit);
+	device_property_read_u32(dev, "summit,usb-current-limit-microamp",
+				 &smb->usb_hc_current_limit);
 
 	/* For thermometer monitoring */
-	of_property_read_u32(np, "summit,chip-temperature-threshold-celsius",
-			     &smb->chip_temp_threshold);
-	of_property_read_u32(np, "summit,soft-compensation-method",
-			     &smb->soft_temp_limit_compensation);
-	of_property_read_u32(np, "summit,charge-current-compensation-microamp",
-			     &smb->charge_current_compensation);
+	device_property_read_u32(dev, "summit,chip-temperature-threshold-celsius",
+				 &smb->chip_temp_threshold);
+	device_property_read_u32(dev, "summit,soft-compensation-method",
+				 &smb->soft_temp_limit_compensation);
+	device_property_read_u32(dev, "summit,charge-current-compensation-microamp",
+				 &smb->charge_current_compensation);
 
 	/* Supported charging mode */
-	smb->use_mains =
-		of_property_read_bool(np, "summit,enable-mains-charging");
-	smb->use_usb =
-		of_property_read_bool(np, "summit,enable-usb-charging");
-	smb->use_usb_otg =
-		of_property_read_bool(np, "summit,enable-otg-charging");
+	smb->use_mains = device_property_read_bool(dev, "summit,enable-mains-charging");
+	smb->use_usb = device_property_read_bool(dev, "summit,enable-usb-charging");
+	smb->use_usb_otg = device_property_read_bool(dev, "summit,enable-otg-charging");
 
 	/* Select charging control */
-	of_property_read_u32(np, "summit,enable-charge-control",
-			     &smb->enable_control);
+	device_property_read_u32(dev, "summit,enable-charge-control",
+				 &smb->enable_control);
 }
 
 static int smb347_get_battery_info(struct smb347_charger *smb)
-- 
2.28.0

