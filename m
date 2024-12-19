Return-Path: <linux-pm+bounces-19494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2549F75BC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 08:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E805D188753D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 07:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E119218AAA;
	Thu, 19 Dec 2024 07:32:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5FC217673
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593536; cv=none; b=UsYzUt5lEc4UBR8ihh2NhOj/jGqRrLWB7JWUXNEUqFpayyAgCjM5T3RDfnX+v6nWLCMa1NS5pM08pOK78ch1/aQQAqzvuaAKgY0oM8yIVcwFg5v5FA91iMC2nuDxFpPybLlxbapVN2RAM+DXjpRXEl6kKon0hlNgnzgRRFRpsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593536; c=relaxed/simple;
	bh=kYgKdKaP/JPHzEu3qpEwsNrhXqPcqBKY/KOWofPl+Ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrG/Pbk93OB8rGnro0DZBAKxc/8lLsp6Qg8b/J3gyCA3cnVZfUcIulcSFpULMV45aw9StPo1R6XsWBrSdUXRAozoQoHuvv5zFs2/Uyl0AIc4zRv8xhXBPFt/wkOCG1JPxjuSiQxvQzJD0vjLhx5Gedp9qOothj2naMlYg7bclZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0O-00088X-1Y; Thu, 19 Dec 2024 08:31:32 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0L-004APp-24;
	Thu, 19 Dec 2024 08:31:30 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0M-00GkbH-0l;
	Thu, 19 Dec 2024 08:31:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Thu, 19 Dec 2024 08:31:23 +0100
Subject: [PATCH 02/11] reboot: reboot, not shutdown, on
 hw_protection_reboot timeout
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-hw_protection-reboot-v1-2-263a0c1df802@pengutronix.de>
References: <20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de>
In-Reply-To: <20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Fabio Estevam <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org, 
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

hw_protection_shutdown() will kick off an orderly shutdown and if that
takes longer than a configurable amount of time, an emergency shutdown
will occur.

Recently, hw_protection_reboot() was added for those systems that don't
implement a proper shutdown and are better served by rebooting and
having the boot firmware worry about doing something about the critical
condition.

On timeout of the orderly reboot of hw_protection_reboot(), the system
would go into shutdown, instead of reboot. This is not a good idea, as
going into shutdown was explicitly not asked for.

Fix this by always doing an emergency reboot if hw_protection_reboot()
is called and the orderly reboot takes too long.

Fixes: 79fa723ba84c ("reboot: Introduce thermal_zone_device_critical_reboot()")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 kernel/reboot.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index f92aa66cbfec0f57ded43ba352a39c54d0c24a25..8e3680d36654587b57db44806a3d7b0228b10f67 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -932,6 +932,20 @@ void orderly_reboot(void)
 }
 EXPORT_SYMBOL_GPL(orderly_reboot);
 
+static const char *hw_protection_action_str(enum hw_protection_action action)
+{
+	switch (action) {
+	case HWPROT_ACT_SHUTDOWN:
+		return "shutdown";
+	case HWPROT_ACT_REBOOT:
+		return "reboot";
+	default:
+		return "undefined";
+	}
+}
+
+static enum hw_protection_action hw_failure_emergency_action;
+
 /**
  * hw_failure_emergency_poweroff_func - emergency poweroff work after a known delay
  * @work: work_struct associated with the emergency poweroff function
@@ -941,21 +955,29 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
  */
 static void hw_failure_emergency_poweroff_func(struct work_struct *work)
 {
+	const char *action_str = hw_protection_action_str(hw_failure_emergency_action);
+
+	pr_emerg("Hardware protection timed-out. Trying forced %s\n",
+		 action_str);
+
 	/*
-	 * We have reached here after the emergency shutdown waiting period has
-	 * expired. This means orderly_poweroff has not been able to shut off
-	 * the system for some reason.
+	 * We have reached here after the emergency action waiting period has
+	 * expired. This means orderly_poweroff/reboot has not been able to
+	 * shut off the system for some reason.
 	 *
-	 * Try to shut down the system immediately using kernel_power_off
-	 * if populated
+	 * Try to shut off the system immediately if possible
 	 */
-	pr_emerg("Hardware protection timed-out. Trying forced poweroff\n");
-	kernel_power_off();
+
+	if (hw_failure_emergency_action == HWPROT_ACT_REBOOT)
+		kernel_restart(NULL);
+	else
+		kernel_power_off();
 
 	/*
 	 * Worst of the worst case trigger emergency restart
 	 */
-	pr_emerg("Hardware protection shutdown failed. Trying emergency restart\n");
+	pr_emerg("Hardware protection %s failed. Trying emergency restart\n",
+		 action_str);
 	emergency_restart();
 }
 
@@ -963,15 +985,17 @@ static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
 			    hw_failure_emergency_poweroff_func);
 
 /**
- * hw_failure_emergency_poweroff - Trigger an emergency system poweroff
+ * hw_failure_emergency_schedule - Schedule an emergency system shutdown or reboot
  *
  * This may be called from any critical situation to trigger a system shutdown
  * after a given period of time. If time is negative this is not scheduled.
  */
-static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
+static void hw_failure_emergency_schedule(enum hw_protection_action action,
+					  int poweroff_delay_ms)
 {
 	if (poweroff_delay_ms <= 0)
 		return;
+	hw_failure_emergency_action = action;
 	schedule_delayed_work(&hw_failure_emergency_poweroff_work,
 			      msecs_to_jiffies(poweroff_delay_ms));
 }
@@ -1009,7 +1033,7 @@ void __hw_protection_shutdown(const char *reason, int ms_until_forced,
 	 * Queue a backup emergency shutdown in the event of
 	 * orderly_poweroff failure
 	 */
-	hw_failure_emergency_poweroff(ms_until_forced);
+	hw_failure_emergency_schedule(action, ms_until_forced);
 	if (action == HWPROT_ACT_REBOOT)
 		orderly_reboot();
 	else

-- 
2.39.5


