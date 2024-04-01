Return-Path: <linux-pm+bounces-5745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AAC89379B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 05:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340B91F21767
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 03:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DFB4A15;
	Mon,  1 Apr 2024 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gurkVG5E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9C28FD;
	Mon,  1 Apr 2024 03:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940483; cv=none; b=fzF92WM8pst6KRF+o3aJXu+bCXHXJ0j4YmMLgVSBLfMF35WahK8UGPbOPdwKD3wT1md0D6dpIecazZtI7BHEF43Y+trpQgJNH4D/Wz6igTaKoWK6dLwRlqpg6ZwLZD6SnwW8ySX7D0zQs5aL02Xl6TmQ3u4z7FMPRrq+AXDSiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940483; c=relaxed/simple;
	bh=U2QyvRi4B4O/vWCYyQuc0N4V9PTSI3JDLev+EAurHcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4bVxROSN0C5hbMvxqYxqTjr677byKUrMwB54ZOq6IinIAbaXlgRugHx5gKK5ZnQ2GNQWWLx9mg7Omlm2V8Ddj8q+5KCiRRl/p3hk8EkjctN/a8j54PePf078xYjY0lwtdrxQXctoOxxTNnh+/qIepBLNlH3ZPBWcBOoyz3oInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gurkVG5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEB7C43141;
	Mon,  1 Apr 2024 03:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711940482;
	bh=U2QyvRi4B4O/vWCYyQuc0N4V9PTSI3JDLev+EAurHcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gurkVG5E5VfHJui8kssoMJTVD7Q5C8e6ZcAoIM04tzEq/h2FwtduC3rA6RGoqze5n
	 4ivdegU3juNCUi3nJFGpZX+AloPaFgFIORb90k3wcwySuXeREByG5/ssRyU5rLyMXb
	 iaQco4Y++BniFAdkYVjBwJSacHiSS7iAnBS5hO6kd/ZNrMefE/AyQVZ8u0kXosDz7o
	 CtNilghSYgVRwIbdakSQ9Yy6OZXYv/geBUG1jR/gki700Q5vsBSsIq6qqJ+nlN/JdL
	 SLKbXiYeK71y/IC3pilXTMb7Dc1e9nZCPL/S/b+Tu5U35v0+LsElkENvQwCCadaLHP
	 +0BMOJqrulkyw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	groeck@chromium.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	hverkuil-cisco@xs4all.nl,
	mchehab@kernel.org,
	sre@kernel.org
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	pmalani@chromium.org,
	linux-gpio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	krzk@kernel.org
Subject: [PATCH v2 5/6] platform/chrome: cros_kbd_led_backlight: shrink the driver name
Date: Mon,  1 Apr 2024 11:00:51 +0800
Message-ID: <20240401030052.2887845-6-tzungbi@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240401030052.2887845-1-tzungbi@kernel.org>
References: <20240401030052.2887845-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to provide platform_device_id table.  Shrink the driver name for
fitting to [1].

[1]: https://elixir.bootlin.com/linux/v6.8/source/include/linux/mod_devicetable.h#L608

Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1 (https://patchwork.kernel.org/project/chrome-platform/patch/20240329075630.2069474-15-tzungbi@kernel.org/):
- Split from "platform/chrome: cros_kbd_led_backlight: provide ID table for
  avoiding fallback match".
- Add R-b tags.

 drivers/platform/chrome/cros_kbd_led_backlight.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index 793fd3f1015d..814846a66e95 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -249,7 +249,7 @@ MODULE_DEVICE_TABLE(of, keyboard_led_of_match);
 
 static struct platform_driver keyboard_led_driver = {
 	.driver		= {
-		.name	= "chromeos-keyboard-leds",
+		.name	= "cros-keyboard-leds",
 		.acpi_match_table = ACPI_PTR(keyboard_led_acpi_match),
 		.of_match_table = of_match_ptr(keyboard_led_of_match),
 	},
@@ -260,4 +260,4 @@ module_platform_driver(keyboard_led_driver);
 MODULE_AUTHOR("Simon Que <sque@chromium.org>");
 MODULE_DESCRIPTION("ChromeOS Keyboard backlight LED Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:chromeos-keyboard-leds");
+MODULE_ALIAS("platform:cros-keyboard-leds");
-- 
2.44.0.478.gd926399ef9-goog


