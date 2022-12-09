Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30EF648558
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiLIP1b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiLIP0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB7892315
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:38 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4JWyStf4qRr+mL5KFmKCEwQFcQxCCkbrd1WKAzDHcHs=;
        b=1w06QhOfWksl9XhFXmaOfo7eZ05KosAp4H3yJqZHYxK3cMZwD8dY5g4GfoEk3Vk88NPodD
        RNXttAhwp4p+5IhZe1MemWJCkbR60WgHA/5kY3BvpOl+mHy1EbJr1Lvyx4x1ALBG45n9eP
        Y3127xa1l3qzr0A5MpgXltuR+UoGElXHeKP22ATIYrQVXPzA9mYWV/3kWtdpUWPp4BG5Yl
        OfzLaBm/6ER8ig8Mpk0++GtnGAKzw8HDTAsW/SRHqNA3mRSeBGE0I5QDak4Du37mcH8ORb
        eSp8rsKnYeKblE4RWl1rX8FqpE6g0eRKgdsaB9GXYMuCy1q89eQNiSkw8cABQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4JWyStf4qRr+mL5KFmKCEwQFcQxCCkbrd1WKAzDHcHs=;
        b=kdUnqVFL89OkJBYRmQgflbwer5Zei4g7wEw6cd3XR7xzqQEkdZ5n8e1n+H3lyw8WZFsHpo
        i+T1Ny2sWOwTkVBg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Remove unused functions
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20221003092602.1323944-7-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-7-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959570.4906.15272772099334791638.tip-bot2@tip-bot2>
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

Commit-ID:     a2288791cb52b34a2bd1fe9ddd6879d54a87005b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a2288791cb52b34a2bd1fe9ddd6879d54a87005b
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:39 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:42 +01:00

thermal/of: Remove unused functions

Remove the dead code: of_thermal_get_trip_points()

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20221003092602.1323944-7-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.h |  7 -------
 drivers/thermal/thermal_of.c   | 17 -----------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 5f475b0..ef7800a 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -142,8 +142,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 #ifdef CONFIG_THERMAL_OF
 int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
-const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *);
 #else
 static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
@@ -154,11 +152,6 @@ static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 {
 	return false;
 }
-static inline const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
-{
-	return NULL;
-}
 #endif
 
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5cce836..2f533fc 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -54,23 +54,6 @@ bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
 }
 EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
 
-/**
- * of_thermal_get_trip_points - function to get access to a globally exported
- *				trip points
- *
- * @tz:	pointer to a thermal zone
- *
- * This function provides a pointer to trip points table
- *
- * Return: pointer to trip points table, NULL otherwise
- */
-const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
-{
-	return tz->trips;
-}
-EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
