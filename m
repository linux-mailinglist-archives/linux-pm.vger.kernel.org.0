Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C922D1274
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLGNr4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 08:47:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36558 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLGNr4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 08:47:56 -0500
Date:   Mon, 07 Dec 2020 13:47:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607348834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PgDkGUQdw5kI9gWgdwAqnMTXxuPzeeW92eK6lXX2hQ=;
        b=dlX0FG905CMmj71m85VXEtq/mBt9uko+YrPzh/yOYDmbYHq0+JqTgNhCARmGmdntBQmK7a
        JUAIUopmokUERmaoDqICcEt8jF9Sgdc/2emmefNg9yuRlzjHT2Y21KGTfUjIGXYycCXsjm
        6kJaZB1ku3gXvUuMR/shCTcBTk71zzc0uVGfw3ulkXO1APasFdpPJ9tDBdEwQW3LDr7x4r
        viXjhaPGG4ZsVcNIF484H8JaoYJQCAD19ljTVbqnjlPDtDJrYucXb2DwHf++kQec62l5AF
        JPYRndJ+0LCgTWcaRtep3DVJqysmJ7kVpqSjM7NkZXA8PS0C2UsTUH3LyyCIYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607348834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PgDkGUQdw5kI9gWgdwAqnMTXxuPzeeW92eK6lXX2hQ=;
        b=Gm1y4W9xP5xuYTvieLVrQgF3QLTI0Assx3IN+Bcl9U87jZWAxWdEvHuPQtOEyhea6i/rAX
        FrT6z6cpy6KRGVBQ==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: power allocator: refactor
 sustainable power estimation
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201124161025.27694-3-lukasz.luba@arm.com>
References: <20201124161025.27694-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <160734883371.3364.3234203704313614987.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     eda1ecfa772f11b68b0ddb8d1c3948451fcff5d6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//eda1ecfa772f11b68b0ddb8d1c3948451fcff5d6
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Tue, 24 Nov 2020 16:10:24 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 26 Nov 2020 17:11:59 +01:00

thermal: power allocator: refactor sustainable power estimation

The sustainable power value might come from the Device Tree or can be
estimated in run time. The sustainable power might be updated by the user
via sysfs interface, which should trigger new estimation of PID
coefficients. There is no need to estimate it every time when the
governor is called and temperature is high. Instead, store the estimated
value and make it available via standard sysfs interface, so it can be
checked from the user-space.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201124161025.27694-3-lukasz.luba@arm.com
---
 drivers/thermal/gov_power_allocator.c | 52 ++++++++++++++++++++------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 2e20085..d7e4b9f 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -63,6 +63,8 @@ static inline s64 div_frac(s64 x, s64 y)
  * @trip_max_desired_temperature:	last passive trip point of the thermal
  *					zone.  The temperature we are
  *					controlling for.
+ * @sustainable_power:	Sustainable power (heat) that this thermal zone can
+ *			dissipate
  */
 struct power_allocator_params {
 	bool allocated_tzp;
@@ -70,6 +72,7 @@ struct power_allocator_params {
 	s32 prev_err;
 	int trip_switch_on;
 	int trip_max_desired_temperature;
+	u32 sustainable_power;
 };
 
 /**
@@ -118,10 +121,6 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
  *
  * This function is used to update the estimation of the PID
  * controller constants in struct thermal_zone_parameters.
- * Sustainable power is provided in case it was estimated.  The
- * estimated sustainable_power should not be stored in the
- * thermal_zone_parameters so it has to be passed explicitly to this
- * function.
  *
  * If @force is not set, the values in the thermal zone's parameters
  * are preserved if they are not zero.  If @force is set, the values
@@ -172,6 +171,42 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 }
 
 /**
+ * get_sustainable_power() - Get the right sustainable power
+ * @tz:		thermal zone for which to estimate the constants
+ * @params:	parameters for the power allocator governor
+ * @control_temp:	target temperature for the power allocator governor
+ *
+ * This function is used for getting the proper sustainable power value based
+ * on variables which might be updated by the user sysfs interface. If that
+ * happen the new value is going to be estimated and updated. It is also used
+ * after thermal zone binding, where the initial values where set to 0.
+ */
+static u32 get_sustainable_power(struct thermal_zone_device *tz,
+				 struct power_allocator_params *params,
+				 int control_temp)
+{
+	u32 sustainable_power;
+
+	if (!tz->tzp->sustainable_power)
+		sustainable_power = estimate_sustainable_power(tz);
+	else
+		sustainable_power = tz->tzp->sustainable_power;
+
+	/* Check if it's init value 0 or there was update via sysfs */
+	if (sustainable_power != params->sustainable_power) {
+		estimate_pid_constants(tz, sustainable_power,
+				       params->trip_switch_on, control_temp,
+				       true);
+
+		/* Do the estimation only once and make available in sysfs */
+		tz->tzp->sustainable_power = sustainable_power;
+		params->sustainable_power = sustainable_power;
+	}
+
+	return sustainable_power;
+}
+
+/**
  * pid_controller() - PID controller
  * @tz:	thermal zone we are operating in
  * @control_temp:	the target temperature in millicelsius
@@ -200,14 +235,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 
 	max_power_frac = int_to_frac(max_allocatable_power);
 
-	if (tz->tzp->sustainable_power) {
-		sustainable_power = tz->tzp->sustainable_power;
-	} else {
-		sustainable_power = estimate_sustainable_power(tz);
-		estimate_pid_constants(tz, sustainable_power,
-				       params->trip_switch_on, control_temp,
-				       true);
-	}
+	sustainable_power = get_sustainable_power(tz, params, control_temp);
 
 	err = control_temp - tz->temperature;
 	err = int_to_frac(err);
