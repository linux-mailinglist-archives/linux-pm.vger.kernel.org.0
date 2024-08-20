Return-Path: <linux-pm+bounces-12536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B48957FBD
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EC21F21FC8
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D6B1898F0;
	Tue, 20 Aug 2024 07:33:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8309B16D313;
	Tue, 20 Aug 2024 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139220; cv=none; b=g+rB04zGi5c7s0LtOOsyeslEs9zCB+2WVKlhalbkJtPCjIc+0Tl3RxO+qo2yRlhcPlvMxzYEj42d6fovNW79022Re0KPr6hX1/SNEQTsQLyPWS8kjF+MEx7YvFEv5i2unEAh2Mdz89EP/G4RyFC2Ib84za8Xg3pr2A1ebX3IAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139220; c=relaxed/simple;
	bh=JDACkyW1TTrmAWoS65/RBl27s5tJ/g77kCWCBAvBEHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIHNlJOTQ21wi5SZjtXHwCeRHokr9azOmBXDPPGeQ4WlwChkNRjStahwHKQGRDfo8ZWcuL63s2/XWXUHr88Z22qm6pN5DnaNWlBavJAwHLL12rMvvri8Ejq2fqw44be0WtNWitaXNagmz64Mr0Dz2n+SOUcCperIAmK8/b4lL4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id F378010A89A; Tue, 20 Aug 2024 03:33:37 -0400 (EDT)
Received: from 5400 (unknown [172.56.34.244])
	by spindle.queued.net (Postfix) with ESMTPSA id CB259108E13;
	Tue, 20 Aug 2024 03:33:36 -0400 (EDT)
Date: Tue, 20 Aug 2024 03:33:35 -0400
From: Andres Salomon <dilinger@queued.net>
To: linux-kernel@vger.kernel.org
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 "Ilpo =?UTF-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: [PATCH v3 2/2] platform/x86:dell-laptop: remove duplicate code w/
 battery function
Message-ID: <20240820033335.4f68b162@5400>
In-Reply-To: <20240820033005.09e03af1@5400>
References: <20240820033005.09e03af1@5400>
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

The dell battery patch added dell_send_request_for_tokenid() and
dell_set_std_token_value(), which encapsulates a very common pattern
when SMBIOS queries are addressed to token->location. This calls them
in various places outside of the dell laptop code, allowing us to delete
a bunch of code.

Also some very minor cleanups:
  - mark the kbd init functions as __init
  - don't read buffer.output unless dell_send_request() was successful.
  - actually return errors from micmute_led_set/mute_led_set instead of
    always returning 0.

Only minor behavior changes; the delayed read of buffer.output and
actually returning errors for the brightness_set_blocking hooks.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
Changes in v3:
    - rename some variables & also drop confusing 'state' variable
Changes in v2:
    - use renamed and helper functions dell_send_request_for_tokenid()
      and dell_set_std_token_value().
    - no longer need to move functions around
    - document the brightness_set_blocking hook changes
---
 drivers/platform/x86/dell/dell-laptop.c | 109 ++++++------------------
 1 file changed, 27 insertions(+), 82 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 4053af8f7676..a9de19799f01 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -937,43 +937,24 @@ static void dell_cleanup_rfkill(void)
 static int dell_send_intensity(struct backlight_device *bd)
 {
 	struct calling_interface_buffer buffer;
-	struct calling_interface_token *token;
-	int ret;
-
-	token = dell_smbios_find_token(BRIGHTNESS_TOKEN);
-	if (!token)
-		return -ENODEV;
-
-	dell_fill_request(&buffer,
-			   token->location, bd->props.brightness, 0, 0);
-	if (power_supply_is_system_supplied() > 0)
-		ret = dell_send_request(&buffer,
-					CLASS_TOKEN_WRITE, SELECT_TOKEN_AC);
-	else
-		ret = dell_send_request(&buffer,
-					CLASS_TOKEN_WRITE, SELECT_TOKEN_BAT);
+	u16 select;
 
-	return ret;
+	select = power_supply_is_system_supplied() > 0 ?
+			SELECT_TOKEN_AC : SELECT_TOKEN_BAT;
+	return dell_send_request_for_tokenid(&buffer, CLASS_TOKEN_WRITE,
+			select, BRIGHTNESS_TOKEN, bd->props.brightness);
 }
 
 static int dell_get_intensity(struct backlight_device *bd)
 {
 	struct calling_interface_buffer buffer;
-	struct calling_interface_token *token;
 	int ret;
+	u16 select;
 
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
+	select = power_supply_is_system_supplied() > 0 ?
+			SELECT_TOKEN_AC : SELECT_TOKEN_BAT;
+	ret = dell_send_request_for_tokenid(&buffer, CLASS_TOKEN_READ,
+			select, BRIGHTNESS_TOKEN, 0);
 	if (ret == 0)
 		ret = buffer.output[1];
 
@@ -1397,20 +1378,11 @@ static int kbd_set_state_safe(struct kbd_state *state, struct kbd_state *old)
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
+	return dell_set_std_token_value(&buffer, kbd_tokens[bit], USE_TVAL);
 }
 
 static int kbd_get_token_bit(u8 bit)
@@ -1429,11 +1401,10 @@ static int kbd_get_token_bit(u8 bit)
 
 	dell_fill_request(&buffer, token->location, 0, 0, 0);
 	ret = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
-	val = buffer.output[1];
-
 	if (ret)
 		return ret;
 
+	val = buffer.output[1];
 	return (val == token->value);
 }
 
@@ -1539,7 +1510,7 @@ static inline int kbd_init_info(void)
 
 }
 
-static inline void kbd_init_tokens(void)
+static inline void __init kbd_init_tokens(void)
 {
 	int i;
 
@@ -1548,7 +1519,7 @@ static inline void kbd_init_tokens(void)
 			kbd_token_bits |= BIT(i);
 }
 
-static void kbd_init(void)
+static void __init kbd_init(void)
 {
 	int ret;
 
@@ -2173,21 +2144,11 @@ static int micmute_led_set(struct led_classdev *led_cdev,
 			   enum led_brightness brightness)
 {
 	struct calling_interface_buffer buffer;
-	struct calling_interface_token *token;
-	int state = brightness != LED_OFF;
-
-	if (state == 0)
-		token = dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE);
-	else
-		token = dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE);
-
-	if (!token)
-		return -ENODEV;
+	u32 tokenid;
 
-	dell_fill_request(&buffer, token->location, token->value, 0, 0);
-	dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
-
-	return 0;
+	tokenid = brightness == LED_OFF ?
+			GLOBAL_MIC_MUTE_DISABLE : GLOBAL_MIC_MUTE_ENABLE;
+	return dell_set_std_token_value(&buffer, tokenid, USE_TVAL);
 }
 
 static struct led_classdev micmute_led_cdev = {
@@ -2201,21 +2162,11 @@ static int mute_led_set(struct led_classdev *led_cdev,
 			   enum led_brightness brightness)
 {
 	struct calling_interface_buffer buffer;
-	struct calling_interface_token *token;
-	int state = brightness != LED_OFF;
-
-	if (state == 0)
-		token = dell_smbios_find_token(GLOBAL_MUTE_DISABLE);
-	else
-		token = dell_smbios_find_token(GLOBAL_MUTE_ENABLE);
+	u32 tokenid;
 
-	if (!token)
-		return -ENODEV;
-
-	dell_fill_request(&buffer, token->location, token->value, 0, 0);
-	dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
-
-	return 0;
+	tokenid = brightness == LED_OFF ?
+			GLOBAL_MUTE_DISABLE : GLOBAL_MUTE_ENABLE;
+	return dell_set_std_token_value(&buffer, tokenid, USE_TVAL);
 }
 
 static struct led_classdev mute_led_cdev = {
@@ -2492,7 +2443,7 @@ static void dell_battery_exit(void)
 
 static int __init dell_init(void)
 {
-	struct calling_interface_token *token;
+	struct calling_interface_buffer buffer;
 	int max_intensity = 0;
 	int ret;
 
@@ -2554,16 +2505,10 @@ static int __init dell_init(void)
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
+	ret = dell_send_request_for_tokenid(&buffer, CLASS_TOKEN_READ,
+			SELECT_TOKEN_AC, BRIGHTNESS_TOKEN, 0);
+	if (ret == 0)
+		max_intensity = buffer.output[3];
 
 	if (max_intensity) {
 		struct backlight_properties props;
-- 
2.39.2



-- 
I'm available for contract & employment work, please contact me if
interested.

