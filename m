Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DA819DF2C
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 22:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgDCUUe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 16:20:34 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:37268 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbgDCUUd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 16:20:33 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vBBl4yQjzqB;
        Fri,  3 Apr 2020 22:20:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585945231; bh=YiFWN6xOx5BwRik6WlkE3QdMHkXS7gn1p+WdXGp+C0s=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=CiIWM2Z45+1iJLtBk+bAXUuEFgNKGXEFckMvL1iZ6OOoVs+uropYVpVfeI+WFmDZO
         DPpe1hiTDG40X7Um/zuGqT3PUstNtr99vh4vLQ5fk8RoTxbySLwJij8pRaTA4iDe3n
         qmlnYq+ud3dRm0m0vgRDaygDd9WnW2Qiantpgqq7uPAlzThnONH0nkzlroA9/FOWyS
         3GlGIkNaTDbQRFAVz9pqY+WTRGBqmyMg1Z9nubKzGvaz4kB6mW200Y5aipYA/mcBzt
         c19zdFeZxkKLP1ym6AyrOoosguKjzY1l4g0doMlVmDTXrV+DBcZXAXEyMtfJM/1E4Y
         V57Ml/WFMzRNA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 22:20:31 +0200
Message-Id: <f44b3baa6349f9e86c0d06a32b5cf63ced727f7c.1585944770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 03/11] power: generic-adc-battery: fold psy_props[] to
 private data
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

psy_desc->properties will become pointer to const, so we can't use it
for filling the property set. Let's append the list to private data
structure and avoid introducing another variable to temporarily hold
the pointer.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reported-by: kbuild test robot <lkp@intel.com>
---
v3: new patch, required before constification of property lists
---
 drivers/power/supply/generic-adc-battery.c | 30 ++++++++--------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index bc462d1ec963..b3b567914dd7 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -52,6 +52,7 @@ struct gab {
 	int	level;
 	int	status;
 	bool cable_plugged;
+	enum power_supply_property	psy_props[];
 };
 
 static struct gab *to_generic_bat(struct power_supply *psy)
@@ -246,7 +247,10 @@ static int gab_probe(struct platform_device *pdev)
 	int index = ARRAY_SIZE(gab_props);
 	bool any = false;
 
-	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
+	adc_bat = devm_kzalloc(&pdev->dev,
+		struct_size(adc_bat, psy_props,
+			ARRAY_SIZE(gab_props) + ARRAY_SIZE(gab_chan_name)),
+		GFP_KERNEL);
 	if (!adc_bat) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
 		return -ENOMEM;
@@ -264,20 +268,8 @@ static int gab_probe(struct platform_device *pdev)
 	psy_desc->external_power_changed = gab_ext_power_changed;
 	adc_bat->pdata = pdata;
 
-	/*
-	 * copying the static properties and allocating extra memory for holding
-	 * the extra configurable properties received from platform data.
-	 */
-	psy_desc->properties = kcalloc(ARRAY_SIZE(gab_props) +
-					ARRAY_SIZE(gab_chan_name),
-					sizeof(*psy_desc->properties),
-					GFP_KERNEL);
-	if (!psy_desc->properties) {
-		ret = -ENOMEM;
-		goto first_mem_fail;
-	}
-
-	memcpy(psy_desc->properties, gab_props, sizeof(gab_props));
+	/* copy static properties */
+	memcpy(adc_bat->psy_props, gab_props, sizeof(gab_props));
 
 	/*
 	 * getting channel from iio and copying the battery properties
@@ -294,12 +286,12 @@ static int gab_probe(struct platform_device *pdev)
 			int index2;
 
 			for (index2 = 0; index2 < index; index2++) {
-				if (psy_desc->properties[index2] ==
+				if (adc_bat->psy_props[index2] ==
 				    gab_dyn_props[chan])
 					break;	/* already known */
 			}
 			if (index2 == index)	/* really new */
-				psy_desc->properties[index++] =
+				adc_bat->psy_props[index++] =
 					gab_dyn_props[chan];
 			any = true;
 		}
@@ -317,6 +309,7 @@ static int gab_probe(struct platform_device *pdev)
 	 * as come channels may be not be supported by the device.So
 	 * we need to take care of that.
 	 */
+	psy_desc->properties = adc_bat->psy_props;
 	psy_desc->num_properties = index;
 
 	adc_bat->psy = power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
@@ -358,8 +351,6 @@ static int gab_probe(struct platform_device *pdev)
 			iio_channel_release(adc_bat->channel[chan]);
 	}
 second_mem_fail:
-	kfree(psy_desc->properties);
-first_mem_fail:
 	return ret;
 }
 
@@ -381,7 +372,6 @@ static int gab_remove(struct platform_device *pdev)
 			iio_channel_release(adc_bat->channel[chan]);
 	}
 
-	kfree(adc_bat->psy_desc.properties);
 	cancel_delayed_work(&adc_bat->bat_work);
 	return 0;
 }
-- 
2.20.1

