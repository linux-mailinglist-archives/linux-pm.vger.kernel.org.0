Return-Path: <linux-pm+bounces-19497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089D9F75AD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 08:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41D717039C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 07:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49215218AD9;
	Thu, 19 Dec 2024 07:32:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366D218AAF
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593546; cv=none; b=KE6xTjuUKdU2dDIDKDwV3e8ytjjTIqojAvjxkIlVZrUdbpmntoW1MaebMzk0LSkFwsR4RnDscw/T+ZWshfKKe7AL0mQohPX+T2h6vOtSHGnKoX+aF+lSjRDBzTy/GjDLEvW2f7tjPw2s0v7hiZoWL7dRFn5oFolX288KnAQ6Hfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593546; c=relaxed/simple;
	bh=nnySu/T6vxGoHdqmXCcTqun4NtEMjOGvzUrN/x/++lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VUWwuqyj3IftVPWdAM6ezA+iyy6K12XqW804esnyf6xl8/dxjRkhJ2XJJIoDKcw1pluQyasUFrDRU3Zgn5DxfMNr4FkgquDISDuL0LtEiAzYPbpyAiJkFjGDx9wV8wxtrFPN46uc6/Qlsj+yNJvBAz8ro21Sv7mBKLJcRZYu6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0O-00088W-1f; Thu, 19 Dec 2024 08:31:32 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0L-004APr-25;
	Thu, 19 Dec 2024 08:31:30 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0M-00GkbH-0n;
	Thu, 19 Dec 2024 08:31:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Thu, 19 Dec 2024 08:31:25 +0100
Subject: [PATCH 04/11] reboot: rename now misleading hw_protection symbols
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-hw_protection-reboot-v1-4-263a0c1df802@pengutronix.de>
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

The __hw_protection_shutdown, hw_failure_emergency_poweroff_work and
hw_failure_emergency_poweroff_func symbol names have become misleading,
because they can either cause a shutdown (poweroff) or a reboot
depending on an argument or a global variable.

To avoid further confusion, let's rename them, so they don't suggest
that a poweroff is all they can do.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 include/linux/reboot.h |  8 ++++----
 kernel/reboot.c        | 22 +++++++++++-----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index d6780fbf51535e1f98b576da0a06701402dfd447..b1e2c86d29a281abbcfe69bc00321df185c32c91 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -180,17 +180,17 @@ extern void orderly_reboot(void);
 
 enum hw_protection_action { HWPROT_ACT_SHUTDOWN, HWPROT_ACT_REBOOT };
 
-void __hw_protection_shutdown(const char *reason, int ms_until_forced,
-			      enum hw_protection_action action);
+void __hw_protection_trigger(const char *reason, int ms_until_forced,
+			     enum hw_protection_action action);
 
 static inline void hw_protection_reboot(const char *reason, int ms_until_forced)
 {
-	__hw_protection_shutdown(reason, ms_until_forced, HWPROT_ACT_REBOOT);
+	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_REBOOT);
 }
 
 static inline void hw_protection_shutdown(const char *reason, int ms_until_forced)
 {
-	__hw_protection_shutdown(reason, ms_until_forced, HWPROT_ACT_SHUTDOWN);
+	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_SHUTDOWN);
 }
 
 /*
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 8e3680d36654587b57db44806a3d7b0228b10f67..da6c8bdeeefe627a76c7ec6e8926138ebbe3ae4e 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -947,13 +947,13 @@ static const char *hw_protection_action_str(enum hw_protection_action action)
 static enum hw_protection_action hw_failure_emergency_action;
 
 /**
- * hw_failure_emergency_poweroff_func - emergency poweroff work after a known delay
- * @work: work_struct associated with the emergency poweroff function
+ * hw_failure_emergency_action_func - emergency action after a known delay
+ * @work: work_struct associated with the emergency action function
  *
  * This function is called in very critical situations to force
- * a kernel poweroff after a configurable timeout value.
+ * a kernel poweroff or reboot after a configurable timeout value.
  */
-static void hw_failure_emergency_poweroff_func(struct work_struct *work)
+static void hw_failure_emergency_action_func(struct work_struct *work)
 {
 	const char *action_str = hw_protection_action_str(hw_failure_emergency_action);
 
@@ -981,8 +981,8 @@ static void hw_failure_emergency_poweroff_func(struct work_struct *work)
 	emergency_restart();
 }
 
-static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
-			    hw_failure_emergency_poweroff_func);
+static DECLARE_DELAYED_WORK(hw_failure_emergency_action_work,
+			    hw_failure_emergency_action_func);
 
 /**
  * hw_failure_emergency_schedule - Schedule an emergency system shutdown or reboot
@@ -996,12 +996,12 @@ static void hw_failure_emergency_schedule(enum hw_protection_action action,
 	if (poweroff_delay_ms <= 0)
 		return;
 	hw_failure_emergency_action = action;
-	schedule_delayed_work(&hw_failure_emergency_poweroff_work,
+	schedule_delayed_work(&hw_failure_emergency_action_work,
 			      msecs_to_jiffies(poweroff_delay_ms));
 }
 
 /**
- * __hw_protection_shutdown - Trigger an emergency system shutdown or reboot
+ * __hw_protection_trigger - Trigger an emergency system shutdown or reboot
  *
  * @reason:		Reason of emergency shutdown or reboot to be printed.
  * @ms_until_forced:	Time to wait for orderly shutdown or reboot before
@@ -1018,8 +1018,8 @@ static void hw_failure_emergency_schedule(enum hw_protection_action action,
  * pending even if the previous request has given a large timeout for forced
  * shutdown/reboot.
  */
-void __hw_protection_shutdown(const char *reason, int ms_until_forced,
-			      enum hw_protection_action action)
+void __hw_protection_trigger(const char *reason, int ms_until_forced,
+			     enum hw_protection_action action)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
@@ -1039,7 +1039,7 @@ void __hw_protection_shutdown(const char *reason, int ms_until_forced,
 	else
 		orderly_poweroff(true);
 }
-EXPORT_SYMBOL_GPL(__hw_protection_shutdown);
+EXPORT_SYMBOL_GPL(__hw_protection_trigger);
 
 static int __init reboot_setup(char *str)
 {

-- 
2.39.5


