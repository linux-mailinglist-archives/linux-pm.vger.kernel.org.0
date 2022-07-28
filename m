Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6A4584344
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiG1Pll (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiG1Plk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4608675B7
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:38 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6eEutLvgCRlSC6a1f1agxHuNs8GYM8RlkWjms2GVCQY=;
        b=Io6ZTucasYx4+UtIkGzFiBakR2e581aiiCVmVy56T8S5s/Y4oKI/+aUzzLPp/rE+25lS1a
        pv85QWuQ8t6BvHeLImycOkJmly3KMEauzKT2Th/oKfGhkXJ3qfoyIWiy8pXpGEhcAmdUHZ
        yWPcnovmeroztI2sopMOEL09Szo+QnthtnCOKP+NJIRtqqHbx+FzdMwEEj+ssdHabm9PBv
        cVEqzlWf0CrEm1ScPvJgIOX+XhaVmgMcuqb/4Jbhk8ytL/uw6hZo6YZb7p43B7zUgCwI46
        0kSAxWcm4Zd2f2woyx20pywh0rAirIzqBk1j49bke+KJywkylOupQHet5IE85Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6eEutLvgCRlSC6a1f1agxHuNs8GYM8RlkWjms2GVCQY=;
        b=SgH3Gcp8a1lU4QV9NDN64yuGm4uQ8d8ODoNcUATCT93w7CVQ1AXpeK/zTAwb0eID/emuAL
        z9w012Kgt/wcf/Cw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Move thermal_trip structure to thermal.h
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linexp.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220722200007.1839356-5-daniel.lezcano@linexp.org>
References: <20220722200007.1839356-5-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <165902289638.15455.13883495498163325300.tip-bot2@tip-bot2>
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

Commit-ID:     646274ddaf756dc549fc98cc581fc1ce4fef517a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//646274ddaf756dc549fc98cc581fc1ce4fef517a
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 22 Jul 2022 22:00:01 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:54 +02:00

thermal/of: Move thermal_trip structure to thermal.h

The structure thermal_trip is now generic and will be usable by the
different sensor drivers in place of their own structure.

Move its definition to thermal.h to make it accessible.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20220722200007.1839356-5-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 12 ------------
 include/linux/thermal.h        | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index ff10cdd..60844e2 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -68,18 +68,6 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 void thermal_cdev_update(struct thermal_cooling_device *);
 void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
-/**
- * struct thermal_trip - representation of a point in temperature domain
- * @temperature: temperature value in miliCelsius
- * @hysteresis: relative hysteresis in miliCelsius
- * @type: trip point type
- */
-struct thermal_trip {
-	int temperature;
-	int hysteresis;
-	enum thermal_trip_type type;
-};
-
 int get_tz_trend(struct thermal_zone_device *tz, int trip);
 
 struct thermal_instance *
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 231bac2..7e66970 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -78,6 +78,18 @@ struct thermal_zone_device_ops {
 	void (*critical)(struct thermal_zone_device *);
 };
 
+/**
+ * struct thermal_trip - representation of a point in temperature domain
+ * @temperature: temperature value in miliCelsius
+ * @hysteresis: relative hysteresis in miliCelsius
+ * @type: trip point type
+ */
+struct thermal_trip {
+	int temperature;
+	int hysteresis;
+	enum thermal_trip_type type;
+};
+
 struct thermal_cooling_device_ops {
 	int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
 	int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);
