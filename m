Return-Path: <linux-pm+bounces-19490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBE89F75AF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 08:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB96C18988A0
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 07:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF6217649;
	Thu, 19 Dec 2024 07:31:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BAD217718
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593517; cv=none; b=B2cUwTwP8h7rwLzbnlroJXi0WfT9uPdEwPbh8l2Cr1prUV0cDp0mvE1TMhBdX0DDeoG6rcM3Smy+DY7Qz9CGu31t6YDsYeTbmpU71JyVRjzh9+Vjz8J89X0sRJej3FIJhWOr11o5tvkFmlx/GcKrN71qaj3mIaWRVu1lrpsUwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593517; c=relaxed/simple;
	bh=w1Y0I3/qSUoo/iH5tfBjW87bvXpJZD1VvJ1gBWyIYr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvxcXzFk0aQ8BRqCmh2lj/ak00NoGLCk0S32AgvHGQl0cumBbY1ENNMGEWoAeuFJ5CuQg2XkKl0oFoEaWhqhkaxlJOhbqSvazmpcVbnbEnMW6yJTq5F32mxHeJz2WtSyEmTxyv9oXkoPInfaEoZH5i3BSPnJk3Tc5YaxDt/+HII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0O-00088S-1W; Thu, 19 Dec 2024 08:31:32 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0L-004APn-1n;
	Thu, 19 Dec 2024 08:31:30 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0M-00GkbH-0k;
	Thu, 19 Dec 2024 08:31:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Thu, 19 Dec 2024 08:31:22 +0100
Subject: [PATCH 01/11] reboot: replace __hw_protection_shutdown bool action
 parameter with an enum
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-hw_protection-reboot-v1-1-263a0c1df802@pengutronix.de>
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

Currently __hw_protection_shutdown() either reboots or shuts down the
system according to its shutdown argument.

To make the logic easier to follow, both inside __hw_protection_shutdown
and at caller sites, lets replace the bool parameter with an enum.

This will be extra useful, when in a later commit, a third action is
added to the enumeration.

No functional change.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 include/linux/reboot.h | 10 +++++++---
 kernel/reboot.c        |  9 +++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index abcdde4df697969a8027bcb052efc00daabbbf6a..d6780fbf51535e1f98b576da0a06701402dfd447 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -177,16 +177,20 @@ void ctrl_alt_del(void);
 
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
-void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown);
+
+enum hw_protection_action { HWPROT_ACT_SHUTDOWN, HWPROT_ACT_REBOOT };
+
+void __hw_protection_shutdown(const char *reason, int ms_until_forced,
+			      enum hw_protection_action action);
 
 static inline void hw_protection_reboot(const char *reason, int ms_until_forced)
 {
-	__hw_protection_shutdown(reason, ms_until_forced, false);
+	__hw_protection_shutdown(reason, ms_until_forced, HWPROT_ACT_REBOOT);
 }
 
 static inline void hw_protection_shutdown(const char *reason, int ms_until_forced)
 {
-	__hw_protection_shutdown(reason, ms_until_forced, true);
+	__hw_protection_shutdown(reason, ms_until_forced, HWPROT_ACT_SHUTDOWN);
 }
 
 /*
diff --git a/kernel/reboot.c b/kernel/reboot.c
index a701000bab3470df28665e8c9591cd82a033c6c2..f92aa66cbfec0f57ded43ba352a39c54d0c24a25 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -994,7 +994,8 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
  * pending even if the previous request has given a large timeout for forced
  * shutdown/reboot.
  */
-void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown)
+void __hw_protection_shutdown(const char *reason, int ms_until_forced,
+			      enum hw_protection_action action)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
@@ -1009,10 +1010,10 @@ void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shut
 	 * orderly_poweroff failure
 	 */
 	hw_failure_emergency_poweroff(ms_until_forced);
-	if (shutdown)
-		orderly_poweroff(true);
-	else
+	if (action == HWPROT_ACT_REBOOT)
 		orderly_reboot();
+	else
+		orderly_poweroff(true);
 }
 EXPORT_SYMBOL_GPL(__hw_protection_shutdown);
 

-- 
2.39.5


