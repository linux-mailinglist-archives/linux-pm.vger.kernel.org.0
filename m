Return-Path: <linux-pm+bounces-11354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8428F93AAE7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 04:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7D53B2317D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 02:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2680E56A;
	Wed, 24 Jul 2024 02:07:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8E518EA8;
	Wed, 24 Jul 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786853; cv=none; b=fJ/Ty0ze1jXh71J8ZyhtTA2oqrIC+480gtFn9dwZd3Qecc6K8KS7yz0gA58bZOvlCBEUwiMlFwzfCLQVr/vT2n0X8EaMETDT5z+1huEDo9Hlh2XFfem7dgGU4oPtDg60RYZf6SLLhJZWUU/gMEaUD9Fukh8jGlktY/0YhMbxh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786853; c=relaxed/simple;
	bh=47Oeu0Ayicn9e+NdP2km+fcM/qCnx21RPdegfi73hiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U49xsPex3ghe6bzo0MWyLXjsvSl+BGer4V42fecB9JgDNERaM85q0A4t+wBXNH1kFuKTOF2hd26u3YTXnmlb5g1Un9oSDEz7+97fCboBbSbCM8wSqYtgSE3mZQrmPGp+SmNMnkNRiHN0R2RR6hmugMmnF2DFDl6Ad5GFck5vd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id CBDA4115A11; Tue, 23 Jul 2024 22:07:31 -0400 (EDT)
Received: from 5400 (unknown [172.56.164.186])
	by spindle.queued.net (Postfix) with ESMTPSA id 645B5115A0E;
	Tue, 23 Jul 2024 22:07:29 -0400 (EDT)
Date: Tue, 23 Jul 2024 22:07:24 -0400
From: Andres Salomon <dilinger@queued.net>
To: linux-kernel@vger.kernel.org
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 "Ilpo =?UTF-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: [PATCH v2 2/2] platform/x86:dell-laptop: remove duplicate code w/
 battery function
Message-ID: <20240723220724.4f8eaf49@5400>
In-Reply-To: <20240723220502.77cb0401@5400>
References: <20240723220502.77cb0401@5400>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

The dell battery patch added dell_send_request_by_token_loc(), which
encapsulates a very common pattern when SMBIOS queries are addressed
to token->location. This sets up the function to be used throughout
the dell laptop code, and calls it in various places allowing us to
delete a bunch of code.

Also some very minor cleanups:
  - mark the kbd init functions as __init
  - don't read buffer.output unless dell_send_request() was successful.

No behavior changes, other than the delayed read of buffer.output.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/platform/x86/dell/dell-laptop.c | 148 ++++++++----------------
 1 file changed, 48 insertions(+), 100 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index aae9a95fb188..facf00c8289d 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -367,6 +367,25 @@ static const struct dmi_system_id dell_quirks[] __initconst = {
 	{ }
 };
 
+/* -1 is a sentinel value, telling us to use token->value */
+#define USE_TVAL ((u32) -1)
+static int dell_send_request_by_token_loc(struct calling_interface_buffer *buffer,
+					  u16 class, u16 select, int type,
+					  u32 val)
+{
+	struct calling_interface_token *token;
+
+	token = dell_smbios_find_token(type);
+	if (!token)
+		return -ENODEV;
+
+	if (val == USE_TVAL)
+		val = token->value;
+
+	dell_fill_request(buffer, token->location, val, 0, 0);
+	return dell_send_request(buffer, class, select);
+}
+
 /*
  * Derived from information in smbios-wireless-ctl:
  *
@@ -909,43 +928,24 @@ static void dell_cleanup_rfkill(void)
 static int dell_send_intensity(struct backlight_device *bd)
 {
 	struct calling_interface_buffer buffer;
-	struct calling_interface_token *token;
-	int ret;
-
-	token = dell_smbios_find_token(BRIGHTNESS_TOKEN);
-	if (!token)
-		return -ENODEV;
+	u16 pwr;
 
-	dell_fill_request(&buffer,
-			   token->location, bd->props.brightness, 0, 0);
-	if (power_supply_is_system_supplied() > 0)
-		ret = dell_send_request(&buffer,
-					CLASS_TOKEN_WRITE, SELECT_TOKEN_AC);
-	else
-		ret = dell_send_request(&buffer,
-					CLASS_TOKEN_WRITE, SELECT_TOKEN_BAT);
-
-	return ret;
+	pwr = power_supply_is_system_supplied() > 0 ?
+			SELECT_TOKEN_AC : SELECT_TOKEN_BAT;
+	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
+			pwr, BRIGHTNESS_TOKEN, bd->props.brightness);
 }
 
 static int dell_get_intensity(struct backlight_device *bd)
 {
 	struct calling_interface_buffer buffer;
-	struct calling_interface_token *token;
 	int ret;
+	u16 pwr;
 
-	token = dell_smbios_find_token(BRIGHTNESS_TOKEN);
-	if (!token)
-		return -ENODEV;
-
-	dell_fill_request(&buffer, token->location, 0, 0, 0);
-	if (power_supply_is_system_supplied() > 0)
-		ret = dell_send_request(&buffer,
-					CLASS_TOKEN_READ, SELECT_TOKEN_AC);
-	else
-		ret = dell_send_request(&buffer,
-					CLASS_TOKEN_READ, SELECT_TOKEN_BAT);
-
+	pwr = power_supply_is_system_supplied() > 0 ?
+			SELECT_TOKEN_AC : SELECT_TOKEN_BAT;
+	ret = dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_READ, pwr,
+			BRIGHTNESS_TOKEN, 0);
 	if (ret == 0)
 		ret = buffer.output[1];
 
@@ -1369,20 +1369,12 @@ static int kbd_set_state_safe(struct kbd_state *state, struct kbd_state *old)
 static int kbd_set_token_bit(u8 bit)
 {
 	struct calling_interface_buffer buffer;
-	struct calling_interface_token *token;
-	int ret;
 
 	if (bit >= ARRAY_SIZE(kbd_tokens))
 		return -EINVAL;
 
-	token = dell_smbios_find_token(kbd_tokens[bit]);
-	if (!token)
-		return -EINVAL;
-
-	dell_fill_request(&buffer, token->location, token->value, 0, 0);
-	ret = dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
-
-	return ret;
+	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
+			SELECT_TOKEN_STD, kbd_tokens[bit], USE_TVAL);
 }
 
 static int kbd_get_token_bit(u8 bit)
@@ -1401,11 +1393,10 @@ static int kbd_get_token_bit(u8 bit)
 
 	dell_fill_request(&buffer, token->location, 0, 0, 0);
 	ret = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
-	val = buffer.output[1];
-
 	if (ret)
 		return ret;
 
+	val = buffer.output[1];
 	return (val == token->value);
 }
 
@@ -1511,7 +1502,7 @@ static inline int kbd_init_info(void)
 
 }
 
-static inline void kbd_init_tokens(void)
+static inline void __init kbd_init_tokens(void)
 {
 	int i;
 
@@ -1520,7 +1511,7 @@ static inline void kbd_init_tokens(void)
 			kbd_token_bits |= BIT(i);
 }
 
-static void kbd_init(void)
+static void __init kbd_init(void)
 {
 	int ret;
 
@@ -2145,21 +2136,12 @@ static int micmute_led_set(struct led_classdev *led_cdev,
 			   enum led_brightness brightness)
 {
 	struct calling_interface_buffer buffer;
-	struct calling_interface_token *token;
 	int state = brightness != LED_OFF;
+	u32 val;
 
-	if (state == 0)
-		token = dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE);
-	else
-		token = dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE);
-
-	if (!token)
-		return -ENODEV;
-
-	dell_fill_request(&buffer, token->location, token->value, 0, 0);
-	dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
-
-	return 0;
+	val = state == 0 ? GLOBAL_MIC_MUTE_DISABLE : GLOBAL_MIC_MUTE_ENABLE;
+	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
+			SELECT_TOKEN_STD, val, USE_TVAL);
 }
 
 static struct led_classdev micmute_led_cdev = {
@@ -2173,21 +2155,12 @@ static int mute_led_set(struct led_classdev *led_cdev,
 			   enum led_brightness brightness)
 {
 	struct calling_interface_buffer buffer;
-	struct calling_interface_token *token;
 	int state = brightness != LED_OFF;
+	u32 val;
 
-	if (state == 0)
-		token = dell_smbios_find_token(GLOBAL_MUTE_DISABLE);
-	else
-		token = dell_smbios_find_token(GLOBAL_MUTE_ENABLE);
-
-	if (!token)
-		return -ENODEV;
-
-	dell_fill_request(&buffer, token->location, token->value, 0, 0);
-	dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
-
-	return 0;
+	val = state == 0 ? GLOBAL_MUTE_DISABLE : GLOBAL_MUTE_ENABLE;
+	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
+			SELECT_TOKEN_STD, val, USE_TVAL);
 }
 
 static struct led_classdev mute_led_cdev = {
@@ -2197,31 +2170,12 @@ static struct led_classdev mute_led_cdev = {
 	.default_trigger = "audio-mute",
 };
 
-static int dell_send_request_by_token_loc(struct calling_interface_buffer *buffer,
-					  u16 class, u16 select, int type,
-					  u32 val)
-{
-	struct calling_interface_token *token;
-
-	token = dell_smbios_find_token(type);
-	if (!token)
-		return -ENODEV;
-
-	/* -1 is a sentinel value, telling us to use token->value */
-	if (val == (u32)-1)
-		val = token->value;
-
-	dell_fill_request(buffer, token->location, val, 0, 0);
-	return dell_send_request(buffer, class, select);
-}
-
 static int dell_battery_set_mode(const int type)
 {
 	struct calling_interface_buffer buffer;
 
-	/* -1 means use the value from the token */
 	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
-			SELECT_TOKEN_STD, type, -1);
+			SELECT_TOKEN_STD, type, USE_TVAL);
 }
 
 static int dell_battery_read(const int type)
@@ -2470,7 +2424,7 @@ static void __exit dell_battery_exit(void)
 
 static int __init dell_init(void)
 {
-	struct calling_interface_token *token;
+	struct calling_interface_buffer buffer;
 	int max_intensity = 0;
 	int ret;
 
@@ -2532,16 +2486,10 @@ static int __init dell_init(void)
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return 0;
 
-	token = dell_smbios_find_token(BRIGHTNESS_TOKEN);
-	if (token) {
-		struct calling_interface_buffer buffer;
-
-		dell_fill_request(&buffer, token->location, 0, 0, 0);
-		ret = dell_send_request(&buffer,
-					CLASS_TOKEN_READ, SELECT_TOKEN_AC);
-		if (ret == 0)
-			max_intensity = buffer.output[3];
-	}
+	ret = dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_READ,
+			SELECT_TOKEN_AC, BRIGHTNESS_TOKEN, 0);
+	if (ret == 0)
+		max_intensity = buffer.output[3];
 
 	if (max_intensity) {
 		struct backlight_properties props;
-- 
2.39.2



-- 
I'm available for contract & employment work, see:
https://spindle.queued.net/~dilinger/resume-tech.pdf

