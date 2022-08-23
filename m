Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299E859E6F1
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244463AbiHWQWL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244470AbiHWQVx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:21:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE916D2CD
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:42:46 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NdK6tgMqhuVYD37LZ41cVeRyp/AztC1pWQUvIEtKN+g=;
        b=KUJmeN76dC8IGYG7EljqHX2v+ct4vvGG1Q3GzizcJI39+5JcjeiVHfOvY4lk8PBzNlrPVl
        KI/JU/ivoqABbAJqOE0Wm7KA46gJDN8dB06SOUKLx3Gve2IZQ59HDgqxy3EWKQ9DZ/cydS
        hyyjpOaGPo+DHe6SLJEvQs0kehfGe2k3aDPxywxcLCVYTBE86tGsE44uDfCxym7SN76vTT
        Vi0mYPWwQFOYEymv8tTGQgFv9YwXHx9que18GZc9NY7jl+KGoGcLMVzeo4m2qPrq0UAW9/
        5Yj4znohaOva2+p0yYOGkkrMD1aFt1Sx8scHx4JRVgDG4lHt9ytFm6qCitSLLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NdK6tgMqhuVYD37LZ41cVeRyp/AztC1pWQUvIEtKN+g=;
        b=zVXxAXEkiDH0g9F3znsvmjiI9466kc1xpBL4USwunpfqmriiiCsBH5QGBkjN3lRAHhWlRE
        kQsg4/nzkW4iR8AQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Rearm the monitoring only one time
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
References: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <166125856384.401.8782554627619918395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     9662756a9a1c34b3ee606dcddfda6a457f89b07f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//9662756a9a1c34b3ee606dcddfda6a457f89b07f
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Fri, 05 Aug 2022 17:38:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:39 +02:00

thermal/core: Rearm the monitoring only one time

The current code calls monitor_thermal_zone() inside the
handle_thermal_trip() function. But this one is called in a loop for
each trip point which means the monitoring is rearmed several times
for nothing (assuming there could be several passive and active trip
points).

Move the monitor_thermal_zone() function out of the
handle_thermal_trip() function and after the thermal trip loop, so the
timer will be disabled or rearmed one time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220805153834.2510142-1-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 69447ab..ea41ea6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -383,11 +383,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 		handle_critical_trips(tz, trip, trip_temp, type);
 	else
 		handle_non_critical_trips(tz, trip);
-	/*
-	 * Alright, we handled this trip successfully.
-	 * So, start monitoring again.
-	 */
-	monitor_thermal_zone(tz);
 }
 
 static void update_temperature(struct thermal_zone_device *tz)
@@ -503,6 +498,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	for (count = 0; count < tz->num_trips; count++)
 		handle_thermal_trip(tz, count);
+
+	monitor_thermal_zone(tz);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
