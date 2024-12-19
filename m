Return-Path: <linux-pm+bounces-19499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C20E99F7647
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 08:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C2397A55B3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 07:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE197218E9F;
	Thu, 19 Dec 2024 07:50:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9682163A9
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734594643; cv=none; b=Ptp7YiBPmfYOoGT1T9ibeXlETuhlpu3V5xSpSCYLjPOCMtsI2e9vxhiBhRTGbuhmRPPikh3gMZmiHH4mrhpuWoA6TK4XQEGoXhd7sHXUgiDa5sWVLlJ4GtlWIpXUg+CVHKNs9kAynkKvWCU+uzssgSUbx3InY/Blv2VDLMHTJXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734594643; c=relaxed/simple;
	bh=LN/2GKVWP8SVrflImM2f/d6NIlKudTEI+VcMQwEcCKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7m5fduDaD6LGR4kQMeAZh23/JMiy0xHfRhtLt3cOC7vA0DVKcgNGbIpISmgPUr4KD++/j+SMcccTEGX6EVzgyGLrM1hUeWSpxA/ET5AfD2n2GnYmFT8smit0uecKH69W6f6l9zUR43gUbtHYCalj+5WD6BVgnF34An/Ee9Ibc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOBId-0003kW-Pr; Thu, 19 Dec 2024 08:50:23 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOBIc-004AWn-17;
	Thu, 19 Dec 2024 08:50:23 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0M-00GkbH-0t;
	Thu, 19 Dec 2024 08:31:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Thu, 19 Dec 2024 08:31:31 +0100
Subject: [PATCH 10/11] thermal: core: allow user configuration of hardware
 protection action
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-hw_protection-reboot-v1-10-263a0c1df802@pengutronix.de>
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


