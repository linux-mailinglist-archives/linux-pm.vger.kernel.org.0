Return-Path: <linux-pm+bounces-23696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EB9A583B1
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 12:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF4B16D59C
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266541D61B1;
	Sun,  9 Mar 2025 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="C77aWTIX"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C741D54E9;
	Sun,  9 Mar 2025 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741519298; cv=none; b=NdCOUQdo1uDrzRl1VSqzeHbcGunWwcMrDDja0Xg1GzQ9S4qHWSyY8gefXiYjn51Dp3NoIFS5wJW9nKE10Fw56cQ9NteZ/1aOdFyYWIWW9+CoDJG3mqNDJ+6dPqe+G4xwQD4m2/oHU/iJ+NEBld4FAosvkfBBJ7kEIc+DIx/Q0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741519298; c=relaxed/simple;
	bh=xiFvyTSNEj6uknrCjE3dRBRmGEVuydfgN+Meno6BDX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3qWrDhXnswxMlH7YUFtQg4xSLFemdU51oIlqjqm3q1cFnIvSxvPYTrPUDLQuQ4Vf/AEJTE7bpuyTic6fXgR/I5nqm8hIOXeSNFGTpc7kiaTebIb/sQMy3n8OEtUE+wszZYyBn6zs3nKbx2qZuSSL+0isbhcUbz+KKITifEV7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=C77aWTIX; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 76AA02E037CC;
	Sun,  9 Mar 2025 13:21:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741519294;
	bh=hjd2PtG36dN9YmJkYN2Cx8QhgwgpdAcd0LncGpMkQAs=; h=From:To:Subject;
	b=C77aWTIXWw44HH41+kgxYygewUwcm1vF4M/3/462BnqUu9HL5xnp218MUTXu4Bsso
	 7QQmVesf372d1BdH0wE9na2zEPjTkaf2VNcKj1l0a9oc8fu3k0ixjTd8sunZHZmJJJ
	 hxxrVlVChL2KFHXn96EJStJ9zQhjgNxuo7wzxIzo=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v3 08/12] platform/x86: oxpec: Add turbo led support to X1
 devices
Date: Sun,  9 Mar 2025 12:21:09 +0100
Message-ID: <20250309112114.1177361-9-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309112114.1177361-1-lkml@antheas.dev>
References: <20250309112114.1177361-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174151929376.29113.16665679798622710233@linux1587.grserver.gr>
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
index 9cb024325da5..eb7eafebbd37 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -106,6 +106,12 @@ static enum oxp_board board;
 #define OXP_X1_CHARGE_BYPASS_MASK_ALWAYS (OXP_X1_CHARGE_BYPASS_MASK_S0 | \
 	OXP_X1_CHARGE_BYPASS_MASK_S3S5)
 
+/* X1 Turbo LED */
+#define OXP_X1_TURBO_LED_REG           0x57
+
+#define OXP_X1_TURBO_LED_OFF           0x01
+#define OXP_X1_TURBO_LED_ON            0x02
+
 static const struct dmi_system_id dmi_table[] = {
 	{
 		.matches = {
@@ -453,6 +459,73 @@ static ssize_t tt_toggle_show(struct device *dev,
 
 static DEVICE_ATTR_RW(tt_toggle);
 
+/* Callbacks for turbo toggle attribute */
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
+	int rval;
+	bool value;
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
+	u8 reg;
+	long enval;
+	long val;
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
 /* Callbacks for turbo toggle attribute */
 static bool charge_behaviour_supported(void)
 {
@@ -898,8 +971,19 @@ static struct attribute_group oxp_tt_toggle_attribute_group = {
 	.attrs = oxp_tt_toggle_attrs,
 };
 
+static struct attribute *oxp_tt_led_attrs[] = {
+	&dev_attr_tt_led.attr,
+	NULL
+};
+
+static struct attribute_group oxp_tt_led_attribute_group = {
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


