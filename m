Return-Path: <linux-pm+bounces-26201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAA4A9C727
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBA51BC44C4
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4C251783;
	Fri, 25 Apr 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="YitbNnhQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49424E00D;
	Fri, 25 Apr 2025 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579919; cv=none; b=F8RAs5o22V0Vs75I26glMXkKbOhIczb2oLOz3rhvcZhEePAZAqi4qDHwVpCTjZpb4k+gThMaOyXhTI5ztodISqEfyjG+4SuJgT038/8p5mQ/fbzPn00zSGqjzlGHOCYwIvGFcxF0fXINTOcGMS3jRnSU1vXcRAR+asvCz6mXeOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579919; c=relaxed/simple;
	bh=Ts9/6WmFW9d5WfyukcBjoPW8DshAtmG62UkMdczslsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F698HLKeh4mjEjviDqHodOGSwLITCTMNZYYc6EDEr5RSqmG31iqdoHWduhrLhYjTMNzvvHqsVFIaVJqz97F3P5Kz0R+TiS2LapMbN997QogJ9z3X4+/ZLIAtGuH55qufF3V8V0FcJD7HQjlthVLSyAMzjLakiLKqGAZFQPyL8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=YitbNnhQ; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8a3b:5a00:3490:6581:3910:8337])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 8A67F2E08DB8;
	Fri, 25 Apr 2025 14:18:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1745579915;
	bh=mQu2YgAJ9WbC5nTJ9MrzKK2HFf9ggMAcU2tfPiRdys8=; h=From:To:Subject;
	b=YitbNnhQ9G1o7k1DrIFVz6rkGUi7RaO32SdcEGh+W7j/IC+5JWDhwK2O8lKnxGO6Y
	 q7kgVoAwNZ0+c8Hw9BhFD9RXMLGOUTt7mfoIJsUn/n7fb2k1ECX1XtBus+7Jyz1lO/
	 3JkXlfHY79U99XkiPMPM53Qs76BNSN1X70DF0rZs=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8a3b:5a00:3490:6581:3910:8337) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
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
Subject: [PATCH v10 07/16] platform/x86: oxpec: Add turbo led support to X1
 devices
Date: Fri, 25 Apr 2025 13:18:12 +0200
Message-ID: <20250425111821.88746-8-lkml@antheas.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111821.88746-1-lkml@antheas.dev>
References: <20250425111821.88746-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174557991539.22675.6447176555898419901@linux1587.grserver.gr>
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
to allow userspace to turn it off once engaging turbo takeover and then
control it as they wish.

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
index ee37070ec54fc..97594fe614896 100644
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
+				 struct attribute *attr, int n)
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
+			    struct device_attribute *attr, const char *buf,
+			    size_t count)
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
+			   struct device_attribute *attr, char *buf)
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


