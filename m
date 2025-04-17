Return-Path: <linux-pm+bounces-25662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8637A92486
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472ED1B60C9C
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229325C6EA;
	Thu, 17 Apr 2025 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ET4fQz6f"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E3259CAD;
	Thu, 17 Apr 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912417; cv=none; b=O2M6voxqJu+ioSr5J8kG9HFNo9AVcByCP+LbeezP8CIB6CV7dIGiQU/pTRjR2PW2pjqmnGNP9roySjF/pPW4LbG42mPTl6GK6kCzBH0XSWZ+YxZcqnaDY+2pITgJoeNGwJp9vlCf10gV65GxAUiSKnI3ZwVMKnaaX58sOsVS3vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912417; c=relaxed/simple;
	bh=e9Hbc8ubwQ4WKqHswBn8INFYzOeYPNNIUDcFdGAEhr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGjLgEjraLDkDY6jHfBwW/5aZF/OdlQ+oa2afxE+kTxads7LP6793fXnVyrVo0o8YgS/SEU5ZGa7+yfFu2wICMZyvTN1Aju5TXFSN1Gby+aPxQowlXB1iyejcvM7zUDIfw39u4q711T5ddq6dv4a6YaCtvTGB6D9UqnSK4Z+MVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ET4fQz6f; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 5EEA52E08A2B;
	Thu, 17 Apr 2025 20:53:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1744912413;
	bh=6+NxRo4VNOh/wyitaaHROZSWCiVZG4W+kTfXNty+Of0=; h=From:To:Subject;
	b=ET4fQz6f2WFDrHTiVg1PLS4yBjAJBAOw5xj83U3MeeBwoNcnFZfLGkB3vzhxeNnqx
	 mvaAj4bxgOWD8lw0XOOHiE5u7n/0rhsRmzoe/4JQzT1KnhFpyHlbSgVNLmRL5geqtH
	 R40T5QPoyYu8MqOzLzj1iPIrF00rtR/K9pxoCoZA=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	mario.limonciello@amd.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v9 07/15] platform/x86: oxpec: Add turbo led support to X1
 devices
Date: Thu, 17 Apr 2025 19:53:02 +0200
Message-ID: <20250417175310.3552671-8-lkml@antheas.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175310.3552671-1-lkml@antheas.dev>
References: <20250417175310.3552671-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174491241307.25075.2973299611837331159@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The X1 and X1 mini lineups feature an LED nested within their turbo
button. When turbo takeover is not enabled, the turbo button allows
the device to switch from 18W to 25W TDP. When the device is in the
25W TDP mode, the LED is turned on.

However, when we engage turbo takeover, the turbo led remains on its
last state, which might be illuminated and cannot be currently
controlled. Therefore, add the register that controls it under sysfs,
to allow userspace to turn it off once engaging turbo takeover and
then control it as they wish.

2024 OneXPlayer devices, other than the X1s, do not have a turbo LED.
However, earlier models do, so this can be extended to them as well
when the register for it is found.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 84 ++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index ee37070ec54fc..e8f27441fa31f 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -87,6 +87,12 @@ static enum oxp_board board;
 
 #define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
 
+/* X1 Turbo LED */
+#define OXP_X1_TURBO_LED_REG           0x57
+
+#define OXP_X1_TURBO_LED_OFF           0x01
+#define OXP_X1_TURBO_LED_ON            0x02
+
 static const struct dmi_system_id dmi_table[] = {
 	{
 		.matches = {
@@ -434,6 +440,73 @@ static ssize_t tt_toggle_show(struct device *dev,
 
 static DEVICE_ATTR_RW(tt_toggle);
 
+/* Callbacks for turbo LED attribute */
+static umode_t tt_led_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
+{
+	switch (board) {
+	case oxp_x1:
+		return attr->mode;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static ssize_t tt_led_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	u8 reg, val;
+	bool value;
+	int ret;
+
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+
+	switch (board) {
+	case oxp_x1:
+		reg = OXP_X1_TURBO_LED_REG;
+		val = value ? OXP_X1_TURBO_LED_ON : OXP_X1_TURBO_LED_OFF;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = write_to_ec(reg, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t tt_led_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	long enval;
+	long val;
+	int ret;
+	u8 reg;
+
+	switch (board) {
+	case oxp_x1:
+		reg = OXP_X1_TURBO_LED_REG;
+		enval = OXP_X1_TURBO_LED_ON;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = read_from_ec(reg, 1, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", val == enval);
+}
+
+static DEVICE_ATTR_RW(tt_led);
+
 /* PWM enable/disable functions */
 static int oxp_pwm_enable(void)
 {
@@ -691,8 +764,19 @@ static const struct attribute_group oxp_tt_toggle_attribute_group = {
 	.attrs = oxp_tt_toggle_attrs,
 };
 
+static struct attribute *oxp_tt_led_attrs[] = {
+	&dev_attr_tt_led.attr,
+	NULL
+};
+
+static const struct attribute_group oxp_tt_led_attribute_group = {
+	.is_visible = tt_led_is_visible,
+	.attrs = oxp_tt_led_attrs,
+};
+
 static const struct attribute_group *oxp_ec_groups[] = {
 	&oxp_tt_toggle_attribute_group,
+	&oxp_tt_led_attribute_group,
 	NULL
 };
 
-- 
2.49.0


