Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7530464854D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiLIP1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiLIP0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771169077C
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:37 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWUnWkOMV9TwhxEbPqCurbgb+Ox0ysT1ee4+r622yC0=;
        b=SLHVWJhl1puQ7yD8C9M91vIUB6XZ9PgTY9XiWwVrkziEWhXjp1yOsp4z8ZYbIVgULD0g80
        0533wE6dADsuPMmJrX4PA1ebB5lo64Ajglgfu+HfXrRE7XUQVjAuK16Wm9n00WJsAwG9PV
        jrsE17F1j2GmkPmGXvzNja5A1PlQoKMg2RcUZd1EsnnF/AX4rzdGuVG3aeXReX8G7vVhuv
        ArHBz9ApdC1Oe4z8zNGq/zvaPAgGPoZWi6oORrmz+tm3aJdD2YNi11d6Z6Af0DjtNl53QY
        cGfuRE/GsZwAS7ElJFommYIIsc91KJFtn21EPxJ2ut2itqnm2JS5/wxkmBhzMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWUnWkOMV9TwhxEbPqCurbgb+Ox0ysT1ee4+r622yC0=;
        b=htsOB0biMxY2auAbq1105QLdovT0Wwt0w1w2f96c9U5+B63X7TftrHzhKzXDD67kmFYE/U
        Jy/3lD5nsZiuv/BA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Remove of_thermal_get_ntrips()
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20221003092602.1323944-17-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-17-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959410.4906.231807288200002119.tip-bot2@tip-bot2>
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

Commit-ID:     a16eb9df9322755d7222a51b244e93357560a66a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a16eb9df9322755d7222a51b244e93357560a66a
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:49 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:42 +01:00

thermal/of: Remove of_thermal_get_ntrips()

The thermal OF code uses the generic trip points to initialize the
thermal zone. Consequently thermal_zone_get_num_trips() can be used
and the of_thermal_get_ntrips() is no longer needed. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20221003092602.1323944-17-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.h |  5 -----
 drivers/thermal/thermal_of.c   | 16 ----------------
 2 files changed, 21 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index ef7800a..6cda4a1 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -140,13 +140,8 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
-int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
 #else
-static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
-{
-	return 0;
-}
 static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 					    int trip)
 {
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 2f533fc..89afa59 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -20,22 +20,6 @@
 #include "thermal_core.h"
 
 /**
- * of_thermal_get_ntrips - function to export number of available trip
- *			   points.
- * @tz: pointer to a thermal zone
- *
- * This function is a globally visible wrapper to get number of trip points
- * stored in the local struct __thermal_zone
- *
- * Return: number of available trip points, -ENODEV when data not available
- */
-int of_thermal_get_ntrips(struct thermal_zone_device *tz)
-{
-	return tz->num_trips;
-}
-EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
-
-/**
  * of_thermal_is_trip_valid - function to check if trip point is valid
  *
  * @tz:	pointer to a thermal zone
