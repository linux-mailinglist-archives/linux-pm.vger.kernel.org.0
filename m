Return-Path: <linux-pm+bounces-5620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF158914DA
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693EC282B0F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F058537FB;
	Fri, 29 Mar 2024 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+fwJdaq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9C47F48;
	Fri, 29 Mar 2024 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699074; cv=none; b=CMWJ1dMZK46z/T6gTKotRjIWXCyvsyuiirTVNLdvRCesgZfx6rW+wwRcRgQH8k0qsRfE25dmG5+OGRclHbUDX5iTg78OS3lN8GKw8BbTDPuIs+5jVPrNAvKG9PAfsVas8q3/kA3ShnMxvytRlnHl8KuDcEVqzBKSv67shnii7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699074; c=relaxed/simple;
	bh=BgH88cOuBsp6Rcb7sjqjNz25lxzGf0AS7L5d/j/jfdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mA5Xmvml6a0pV+THM/SHuj7/lQKZYytfofP+Tdkt/MtkBsVwJei69y4r1fTX0tcDBfBb1tenRC0vlQQ6kLufQfydT/U5AC/ish95sttulsEv+Q1NtKuwLM5j4q4vxAr+CsURTyhy95wSA7KwSKkVimSTHzogEmAz4jECRWMZ+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+fwJdaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13CFC433A6;
	Fri, 29 Mar 2024 07:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699074;
	bh=BgH88cOuBsp6Rcb7sjqjNz25lxzGf0AS7L5d/j/jfdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+fwJdaqBx1Cy0+jCAhuQGnps1JLB82nxhdBDvMlQfNVPCrSVz6XclD7+80AclNsl
	 dWxWiB4hk8B5JeScudXSp9lQ+20sQ0q5Ba8o/9OXrO/2MEhRAu2OtheAmbfu0xLDiO
	 ggQGUw0QOPeNtnL6rvZMy3lLa2q+FZI4D9ur6h+fkYpmLBfzR9/tS2YR1MrL8mR7W0
	 Iu0EJaNQcSBYqgyBI26LV7E0thnRzemNBqqtVR9cWObR/DnLytnauD7LK6rhHmXBLW
	 9THgDc2HBAJY9IvHz+eM5IVYSN/8jROJY3cdQ1xJ7JXNZak5gzd+Qv0PhDYnf09ZCB
	 zpLyrtc1Zx9pw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	groeck@chromium.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	hverkuil-cisco@xs4all.nl,
	mchehab@kernel.org,
	sre@kernel.org,
	alexandre.belloni@bootlin.com
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	pmalani@chromium.org,
	linux-gpio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	krzk@kernel.org
Subject: [PATCH 14/18] platform/chrome: cros_kbd_led_backlight: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:26 +0800
Message-ID: <20240329075630.2069474-15-tzungbi@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240329075630.2069474-1-tzungbi@kernel.org>
References: <20240329075630.2069474-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using fallback driver name match, provide ID table[1] for the
primary match.

Also shrink the name for fitting to [2].

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353
[2]: https://elixir.bootlin.com/linux/v6.8/source/include/linux/mod_devicetable.h#L608

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_kbd_led_backlight.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index 793fd3f1015d..b83e4f328620 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
@@ -247,17 +248,23 @@ static const struct of_device_id keyboard_led_of_match[] = {
 MODULE_DEVICE_TABLE(of, keyboard_led_of_match);
 #endif
 
+static const struct platform_device_id keyboard_led_id[] = {
+	{ "cros-keyboard-leds", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, keyboard_led_id);
+
 static struct platform_driver keyboard_led_driver = {
 	.driver		= {
-		.name	= "chromeos-keyboard-leds",
+		.name	= "cros-keyboard-leds",
 		.acpi_match_table = ACPI_PTR(keyboard_led_acpi_match),
 		.of_match_table = of_match_ptr(keyboard_led_of_match),
 	},
 	.probe		= keyboard_led_probe,
+	.id_table	= keyboard_led_id,
 };
 module_platform_driver(keyboard_led_driver);
 
 MODULE_AUTHOR("Simon Que <sque@chromium.org>");
 MODULE_DESCRIPTION("ChromeOS Keyboard backlight LED Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:chromeos-keyboard-leds");
-- 
2.44.0.478.gd926399ef9-goog


