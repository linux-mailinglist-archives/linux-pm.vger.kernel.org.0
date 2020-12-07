Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9643E2D1277
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 14:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLGNr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 08:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgLGNr5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 08:47:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC4CC0613D4
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 05:47:16 -0800 (PST)
Date:   Mon, 07 Dec 2020 13:47:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607348833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVdu/jEThY9VCnVsDu2R9NQwAXH8HaZZSmrxlQTPAHY=;
        b=iZLx35MRWCz86rlL0/ERbHFBCU6f/SzLxx3C5iJletOyneGkHpuP/2R+0VcTdsA6YeNSW7
        UW6hvz04cxxN6Ga1Foe4qEFr4Q6AaatOeixyzJF337sarpgjVseEHjhphd4DBbI+7zmDun
        OYB5t3SesPmyAwBdpFqYwPRtTCve4zatxGucPIp9LjUxbYhWDVIEJTaOQCF+zo4O6vaSwq
        1ivm9unMT8hJfWiieag2T6b02NRyTQrZR5C6ZiUWJmhU8TKDvrlHb54rdQqDmNjqdbSwRt
        3jftJQas+IlVRmnkqeHAn88NjCQOOegHrZDnulxBoOhZlVAalhpQ+xC4CyDf9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607348833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVdu/jEThY9VCnVsDu2R9NQwAXH8HaZZSmrxlQTPAHY=;
        b=WgP9xL0muDIvzDxCHTcUeSTztQWR5/UIp6M5iiqIyGGETdbyf+D9owyFLzy5IsMD5t4gXh
        ywxoxgG5HRON6zBA==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: power allocator: change the 'k_*'
 always in estimate_pid_constants()
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201124161025.27694-4-lukasz.luba@arm.com>
References: <20201124161025.27694-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <160734883337.3364.2328247855489585620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     90a996544946d1d4834ec2ec8add586edd905779
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//90a996544946d1d4834ec2ec8add586edd905779
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Tue, 24 Nov 2020 16:10:25 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 26 Nov 2020 17:11:59 +01:00

thermal: power allocator: change the 'k_*' always in estimate_pid_constants()

The PID coefficients should be estimated again when there was a change to
sustainable power value made by user. This change removes unused argument
'force' and makes the function ready for such updates.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201124161025.27694-4-lukasz.luba@arm.com
---
 drivers/thermal/gov_power_allocator.c | 28 ++++++++------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index d7e4b9f..7a4170a 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -117,18 +117,13 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
  * @sustainable_power:	sustainable power for the thermal zone
  * @trip_switch_on:	trip point number for the switch on temperature
  * @control_temp:	target temperature for the power allocator governor
- * @force:	whether to force the update of the constants
  *
  * This function is used to update the estimation of the PID
  * controller constants in struct thermal_zone_parameters.
- *
- * If @force is not set, the values in the thermal zone's parameters
- * are preserved if they are not zero.  If @force is set, the values
- * in thermal zone's parameters are overwritten.
  */
 static void estimate_pid_constants(struct thermal_zone_device *tz,
 				   u32 sustainable_power, int trip_switch_on,
-				   int control_temp, bool force)
+				   int control_temp)
 {
 	int ret;
 	int switch_on_temp;
@@ -151,18 +146,14 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 	if (!temperature_threshold)
 		return;
 
-	if (!tz->tzp->k_po || force)
-		tz->tzp->k_po = int_to_frac(sustainable_power) /
-			temperature_threshold;
+	tz->tzp->k_po = int_to_frac(sustainable_power) /
+		temperature_threshold;
 
-	if (!tz->tzp->k_pu || force)
-		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
-			temperature_threshold;
+	tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
+		temperature_threshold;
 
-	if (!tz->tzp->k_i || force) {
-		k_i = tz->tzp->k_pu / 10;
-		tz->tzp->k_i = k_i > 0 ? k_i : 1;
-	}
+	k_i = tz->tzp->k_pu / 10;
+	tz->tzp->k_i = k_i > 0 ? k_i : 1;
 
 	/*
 	 * The default for k_d and integral_cutoff is 0, so we can
@@ -195,8 +186,7 @@ static u32 get_sustainable_power(struct thermal_zone_device *tz,
 	/* Check if it's init value 0 or there was update via sysfs */
 	if (sustainable_power != params->sustainable_power) {
 		estimate_pid_constants(tz, sustainable_power,
-				       params->trip_switch_on, control_temp,
-				       true);
+				       params->trip_switch_on, control_temp);
 
 		/* Do the estimation only once and make available in sysfs */
 		tz->tzp->sustainable_power = sustainable_power;
@@ -640,7 +630,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		if (!ret)
 			estimate_pid_constants(tz, tz->tzp->sustainable_power,
 					       params->trip_switch_on,
-					       control_temp, false);
+					       control_temp);
 	}
 
 	reset_pid_controller(params);
