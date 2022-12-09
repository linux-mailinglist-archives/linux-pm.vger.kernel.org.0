Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8BD648554
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiLIP1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLIP0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98058DFEC
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:39 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2tpGikmuIXtR9aOT094x9elmkMmOZJ3phHe/nHFe2U=;
        b=VtM0+G4Rn4nO4Zvv2YeSQ5IdsaypAuTRdFUnS9YCYZnpN2FmqdMBUqM9OTE5ZarGHjIZtb
        td0ZPcCsz1OP6AYmnyDEfSI8+JREbpCqmecWWbwFJ0sUasiRc6R9owSX0cVR8iANnPKcuI
        2nBTi5ugawGiCgDBm11Xyaxj8tii99Sd7I7rJfUP9/14SefoCt8WZaH0C2Fvbd23Eqs4bi
        e0DipjbQL88KwcdtwpxD3rXXY/mKhbyFyoXv5fAqmBZg1RsLvL6Cr5XK0RVOv35mqDpwtl
        I4sMdPQeOvqgzBuzlIa8JPI12wA6LGGNtQTKJsq2cOCiCDAeC5Oi5LB6HoJ46A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2tpGikmuIXtR9aOT094x9elmkMmOZJ3phHe/nHFe2U=;
        b=RTDgbkeZsAnP1Hamxtdp4u//h6VhZrJd1FgunEjzHAbv76akRkiWtADIHAoGYflU6VugMN
        mYPiNliRcr6rseCQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/sysfs: Always expose hysteresis attributes
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221003092602.1323944-3-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959637.4906.512594957193307166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d75af335875228b435b09d97d9bf49ed6ab9034b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d75af335875228b435b09d97d9bf49ed6ab9034b
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:35 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 12:24:16 +01:00

thermal/sysfs: Always expose hysteresis attributes

Instead of avoiding to expose the hysteresis attributes of a thermal
zone when its get_trip_hyst() operation is not defined, which is
confusing, expose them always and use the default
thermal_zone_get_trip() function returning 0 hysteresis when that
operation is not present.

The hysteresis of 0 is perfectly valid, so this change should not
introduce any backwards compatibility issues.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20221003092602.1323944-3-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_sysfs.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 137bbf6..d2d4500 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -477,23 +477,20 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		return -ENOMEM;
 	}
 
-	if (tz->ops->get_trip_hyst) {
-		tz->trip_hyst_attrs = kcalloc(tz->num_trips,
-					      sizeof(*tz->trip_hyst_attrs),
-					      GFP_KERNEL);
-		if (!tz->trip_hyst_attrs) {
-			kfree(tz->trip_type_attrs);
-			kfree(tz->trip_temp_attrs);
-			return -ENOMEM;
-		}
+	tz->trip_hyst_attrs = kcalloc(tz->num_trips,
+				      sizeof(*tz->trip_hyst_attrs),
+				      GFP_KERNEL);
+	if (!tz->trip_hyst_attrs) {
+		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_temp_attrs);
+		return -ENOMEM;
 	}
 
 	attrs = kcalloc(tz->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
-		if (tz->ops->get_trip_hyst)
-			kfree(tz->trip_hyst_attrs);
+		kfree(tz->trip_hyst_attrs);
 		return -ENOMEM;
 	}
 
@@ -526,9 +523,6 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
-		/* create Optional trip hyst attribute */
-		if (!tz->ops->get_trip_hyst)
-			continue;
 		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_hyst", indx);
 
@@ -565,8 +559,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
-	if (tz->ops->get_trip_hyst)
-		kfree(tz->trip_hyst_attrs);
+	kfree(tz->trip_hyst_attrs);
 	kfree(tz->trips_attribute_group.attrs);
 }
 
