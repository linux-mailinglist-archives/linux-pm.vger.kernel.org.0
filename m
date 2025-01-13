Return-Path: <linux-pm+bounces-20356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF49A0BDC9
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 17:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10AA188818D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5B1C5D6F;
	Mon, 13 Jan 2025 16:40:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B7229807
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786404; cv=none; b=GF2ZA8ETTAfqC5h4Z4ERLgfG8Cel0591zBJ6bvYIdOQWkrfamvKEwqXLfnbpIm+tauM+UTQ8JYDtBnXTYGGs1jz5fC3AtKWZHPxJ5T6QNLX6AqyhLJrEAQ0tjJz/wPWs12zLo9EL263AZc72f4HKRQNwZ2xZW1cf/NeJZNKLNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786404; c=relaxed/simple;
	bh=LN/2GKVWP8SVrflImM2f/d6NIlKudTEI+VcMQwEcCKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSoIY5Y8j8KnfpDEX2HX2ja1Gb/CAJfdsusroIRUImLouxeJ4rKmfZcsch2/bg4SQuY+8RMaaN0sOZ0FDa+OhnZhN7H7yiMEKtibOD+EWDa6uJbKJrWHKPLCqbUfeo/PW3MD7HazYK4g5SRP5WwrAeuPCQhDram82f2LhCHbxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNTL-0001hK-Kt; Mon, 13 Jan 2025 17:39:27 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNTJ-000I5o-2V;
	Mon, 13 Jan 2025 17:39:26 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNFq-007FQL-34;
	Mon, 13 Jan 2025 17:25:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 13 Jan 2025 17:25:36 +0100
Subject: [PATCH v2 11/12] thermal: core: allow user configuration of
 hardware protection action
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-hw_protection-reboot-v2-11-161d3fc734f0@pengutronix.de>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
In-Reply-To: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
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

In the general case, we don't know which of system shutdown or
reboot is the better action to take to protect hardware in an emergency
situation. We thus allow the policy to come from the device-tree in the
form of an optional critical-action OF property, but so far there was no
way for the end user to configure this.

With recent addition of the hw_protection parameter, the user can now
choose a default action for the case, where the driver isn't fully sure
what's the better course of action.

Let's make use of this by passing HWPROT_ACT_DEFAULT in absence of the
critical-action OF property.

As HWPROT_ACT_DEFAULT is shutdown by default, this introduces no
functional change for users, unless they start using the new parameter.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 17 ++++++++++-------
 drivers/thermal/thermal_core.h |  1 +
 drivers/thermal/thermal_of.c   |  7 +++++--
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 19a3894ad752a91ef621794abbeec9abfb2323ec..abe990b7b40b0c7fa5034093b961e239840a18c1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -369,7 +369,8 @@ void thermal_governor_update_tz(struct thermal_zone_device *tz,
 	tz->governor->update_tz(tz, reason);
 }
 
-static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdown)
+static void thermal_zone_device_halt(struct thermal_zone_device *tz,
+				     enum hw_protection_action action)
 {
 	/*
 	 * poweroff_delay_ms must be a carefully profiled positive value.
@@ -380,21 +381,23 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdo
 
 	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
 
-	if (shutdown)
-		hw_protection_shutdown(msg, poweroff_delay_ms);
-	else
-		hw_protection_reboot(msg, poweroff_delay_ms);
+	__hw_protection_trigger(msg, poweroff_delay_ms, action);
 }
 
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
 {
-	thermal_zone_device_halt(tz, true);
+	thermal_zone_device_halt(tz, HWPROT_ACT_DEFAULT);
 }
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
+void thermal_zone_device_critical_shutdown(struct thermal_zone_device *tz)
+{
+	thermal_zone_device_halt(tz, HWPROT_ACT_SHUTDOWN);
+}
+
 void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz)
 {
-	thermal_zone_device_halt(tz, false);
+	thermal_zone_device_halt(tz, HWPROT_ACT_REBOOT);
 }
 
 static void handle_critical_trips(struct thermal_zone_device *tz,
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index be271e7c8f4141146a03efecc82fc4036ec12df6..7d6637126007168ac05010af0f16a4c8012a0d77 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -262,6 +262,7 @@ int thermal_build_list_of_policies(char *buf);
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event);
 void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz);
+void thermal_zone_device_critical_shutdown(struct thermal_zone_device *tz);
 void thermal_governor_update_tz(struct thermal_zone_device *tz,
 				enum thermal_notify_event reason);
 
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index fab11b98ca4952d23d0232998433bd0650b53d24..c574e775d686599deddd08f932a5a6dd781d342e 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -396,9 +396,12 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	of_ops.should_bind = thermal_of_should_bind;
 
 	ret = of_property_read_string(np, "critical-action", &action);
-	if (!ret)
-		if (!of_ops.critical && !strcasecmp(action, "reboot"))
+	if (!ret && !of_ops.critical) {
+		if (!strcasecmp(action, "reboot"))
 			of_ops.critical = thermal_zone_device_critical_reboot;
+		else if (!strcasecmp(action, "shutdown"))
+			of_ops.critical = thermal_zone_device_critical_shutdown;
+	}
 
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
 						     data, &of_ops, &tzp,

-- 
2.39.5


