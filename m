Return-Path: <linux-pm+bounces-12281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E4953DF1
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 01:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001411C20D3F
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 23:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DFA155747;
	Thu, 15 Aug 2024 23:35:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B54D1AC88F;
	Thu, 15 Aug 2024 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723764952; cv=none; b=pWH4y/du6iZqJVPjc2I5ZoACQimjqdhu+1Io7AGFXU5iM9leCQLVygoEQBuly5NdlJoaJ6h5zkLaCMKfXHOyORoXiUbJnJKzO2VXEMB3vIqwTc8GOCR8jT2dYPPFiSwsMUHFbt8IzK5yF5P0+NbkG9NMJ73GpFz86RGKhCLqaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723764952; c=relaxed/simple;
	bh=Z8EOfb49CC3S7FBg8192Uau2gO3NkBrpQvt5ppCuULk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZxap0KQzHdGuy1H6+wi5VQT8guAv2pZjLiNnenZSRFircA7hYnsM+yS3lK4DZEw6DrDPTvFsc4HSsmVGXDh1QC/QRsuyo0ituqEdHVRV7tLMf3PS6DnG8ov+ICgl5NfK1olCqv4Ml6tax8cK2h/F5NlAtIjWKgwZteW3SThTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id A81481160A7; Thu, 15 Aug 2024 19:35:50 -0400 (EDT)
Received: from 5400 (unknown [172.56.34.244])
	by spindle.queued.net (Postfix) with ESMTPSA id 1A453115D1B;
	Thu, 15 Aug 2024 19:35:49 -0400 (EDT)
Date: Thu, 15 Aug 2024 19:35:46 -0400
From: Andres Salomon <dilinger@queued.net>
To: linux-kernel@vger.kernel.org
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 "Ilpo =?UTF-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: [PATCH v2 2/2] platform/x86:dell-laptop: remove duplicate code w/
 battery function
Message-ID: <20240815193546.2123b010@5400>
In-Reply-To: <20240815192848.3489d3e1@5400>
References: <20240815192848.3489d3e1@5400>
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
Changes in v2:
    - use renamed and helper functions dell_send_request_for_tokenid()
      and dell_set_std_token_value().
    - no longer need to move functions around
    - document the brightness_set_blocking hook changes
---
 drivers/platform/x86/dell/dell-laptop.c | 105 ++++++------------------
 1 file changed, 25 insertions(+), 80 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 8cc05f0fab91..5df0944e5bf6 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -935,43 +935,24 @@ static void dell_cleanup_rfkill(void)
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
+	u16 pwr;
 
-	return ret;
+	pwr = power_supply_is_system_supplied() > 0 ?
+			SELECT_TOKEN_AC : SELECT_TOKEN_BAT;
+	return dell_send_request_for_tokenid(&buffer, CLASS_TOKEN_WRITE,
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
+	ret = dell_send_request_for_tokenid(&buffer, CLASS_TOKEN_READ, pwr,
+			BRIGHTNESS_TOKEN, 0);
 	if (ret == 0)
 		ret = buffer.output[1];
 
@@ -1395,20 +1376,11 @@ static int kbd_set_state_safe(struct kbd_state *state, struct kbd_state *old)
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
@@ -1427,11 +1399,10 @@ static int kbd_get_token_bit(u8 bit)
 
 	dell_fill_request(&buffer, token->location, 0, 0, 0);
 	ret = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
-	val = buffer.output[1];
-
 	if (ret)
 		return ret;
 
+	val = buffer.output[1];
 	return (val == token->value);
 }
 
@@ -1537,7 +1508,7 @@ static inline int kbd_init_info(void)
 
 }
 
-static inline void kbd_init_tokens(void)
+static inline void __init kbd_init_tokens(void)
 {
 	int i;
 
@@ -1546,7 +1517,7 @@ static inline void kbd_init_tokens(void)
 			kbd_token_bits |= BIT(i);
 }
 
-static void kbd_init(void)
+static void __init kbd_init(void)
 {
 	int ret;
 
@@ -2171,21 +2142,11 @@ static int micmute_led_set(struct led_classdev *led_cdev,
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
+	return dell_set_std_token_value(&buffer, val, USE_TVAL);
 }
 
 static struct led_classdev micmute_led_cdev = {
@@ -2199,21 +2160,11 @@ static int mute_led_set(struct led_classdev *led_cdev,
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
+	return dell_set_std_token_value(&buffer, val, USE_TVAL);
 }
 
 static struct led_classdev mute_led_cdev = {
@@ -2498,7 +2449,7 @@ static void __exit dell_battery_exit(void)
 
 static int __init dell_init(void)
 {
-	struct calling_interface_token *token;
+	struct calling_interface_buffer buffer;
 	int max_intensity = 0;
 	int ret;
 
@@ -2560,16 +2511,10 @@ static int __init dell_init(void)
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

