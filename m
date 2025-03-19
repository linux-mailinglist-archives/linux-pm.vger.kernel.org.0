Return-Path: <linux-pm+bounces-24298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF96A69705
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FACB8A10A1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 17:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45062147F3;
	Wed, 19 Mar 2025 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="dyJWXR1u"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DF207DE6;
	Wed, 19 Mar 2025 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406941; cv=none; b=Qdj7xwGqjtT1sIU4KaeTPmwP2xALy6JhUL7ZWPjBzRwk2W6muw55TRF0M9Uyw9AoqVlTE+Bq4HbwYjXpv6+W2YLq41piMJFsTZdpeShkax3MfmZvkjLo/0r27Y2HlBcny2DdMKZl6RfwKAqRyv4d57aMYTRXy8/OU8Di0ZwfTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406941; c=relaxed/simple;
	bh=uPtiGnqY+hsUkisIfEexep2oPEcqnNYHyRKuachv5TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qseIZhngpRHE/Aemar4hV45c4aS12cm20cQlfGl1S5slZldjxlG07ClCYOaqxUY4rype/MtKKeVVUPAAdrw6yxY16PKnRITciJuBDVnaVuzPg1Q7at+Nlr5HYlLd2RdMay1bfXFCwihYkEuk7A9DaffY47J2s5dtRludYuiNXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=dyJWXR1u; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 016C02E093E2;
	Wed, 19 Mar 2025 19:55:35 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742406938;
	bh=5+eUBrMzjifSoU5zI6yTZnsEnDtAJuJGoODYEyKJBsI=; h=From:To:Subject;
	b=dyJWXR1uFahq3hXMDNrM2Zr0YhQVFBE8MPdoQddZWriynpCl+VRxuH2KiUQsKKwRq
	 JXfRu8o/Dg7uX8Nq3iBWQFr1car/6vl1gSrsyyDOv0FlsklxG2KLq4Hnqx6GxRh1p4
	 wrX40X8hzVX9hyzZvqk+/NSGmf1AnVw1+9nmX9s8=
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
Subject: [PATCH v6 07/14] platform/x86: oxpec: Add turbo led support to X1
 devices
Date: Wed, 19 Mar 2025 18:55:02 +0100
Message-ID: <20250319175512.27059-8-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319175512.27059-1-lkml@antheas.dev>
References: <20250319175512.27059-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174240693768.24875.17257859864580517653@linux1587.grserver.gr>
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

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 84 ++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 78ab87be3dbf7..1fbf733f98ec6 100644
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
+	int rval;
+
+	rval = kstrtobool(buf, &value);
+	if (rval)
+		return rval;
+
+	switch (board) {
+	case oxp_x1:
+		reg = OXP_X1_TURBO_LED_REG;
+		val = value ? OXP_X1_TURBO_LED_ON : OXP_X1_TURBO_LED_OFF;
+		break;
+	default:
+		return -EINVAL;
+	}
+	rval = write_to_ec(reg, val);
+
+	if (rval)
+		return rval;
+
+	return count;
+}
+
+static ssize_t tt_led_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	int retval;
+	long enval;
+	long val;
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
+	retval = read_from_ec(reg, 1, &val);
+	if (retval)
+		return retval;
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
 
+static const struct attribute *oxp_tt_led_attrs[] = {
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
2.48.1


