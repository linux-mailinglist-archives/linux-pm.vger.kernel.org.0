Return-Path: <linux-pm+bounces-5746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325BE89379E
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 05:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DD51C20C4F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 03:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D9A5382;
	Mon,  1 Apr 2024 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaUjs4a2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEDE522E;
	Mon,  1 Apr 2024 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940485; cv=none; b=Ew/dDYgP1u658KvLkd2a8g9GT11A+sQHj1eE6rn9L0I0GUt30sp9Se2h70ONnX+eQxkxCaGfiUSs0tNoO58z9m7VEEJdbwVDd2v9uNNLc3BLpTPAkXFbz44e4/OFmse5Q1aRJfnSDZlaNtwlADqCSzcjkxBJK2aBXLVJ/DldxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940485; c=relaxed/simple;
	bh=A+qPC2CmbjWZ3WbNj/6Wuu/Fd+PX1XeYGNBZm8njWhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8hiZyoGR9reJBddGZJynLcZvK7PdZNDPD1oBNTzvV5HmBTFbVzawcHWbXN1GyKtorKbkKyjHyOPMRYLdRF9Yyc3OuTKu6xbwXtrJdYVga80zqF6BseKwdQjNSb5+Xedm2YWjVmXIfF1+XLW7iNYcJYBLGii7GbGEq4INBnzxW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaUjs4a2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B07FC433A6;
	Mon,  1 Apr 2024 03:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711940485;
	bh=A+qPC2CmbjWZ3WbNj/6Wuu/Fd+PX1XeYGNBZm8njWhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaUjs4a2yxCB/+gsFIjoaChWfPRPIjedHabjlZvIjm17ePfktlRvz1lY7OTPRHopO
	 BsKz8RnHcsDeb1vhCBK7A1OA25kLiWy5zxokzfhWfDub1EaNEnMQnA5Z56HE7eOeUG
	 gO+ZIu9FexgO6CLqdE2qx4Oqgws9Y5ePQ9Z/UyRdkWJUZ5I1IvCGbJ+8YjALQSYw2m
	 JtamcEKOuT18h3L/daQ4ODBu4X5U585uc+zqV6BLElUfwcsEp59ZJu/hHw9YWCP44j
	 rCSkaDfvFutYKHOo6cE/cq5DRgCJrqR6nX7wU09aXWOXX7NuuomJ7KTkOxg5HcyHHK
	 4MDCe/BnTsfww==
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
Subject: [PATCH v2 6/6] platform/chrome: cros_kbd_led_backlight: provide ID table for avoiding fallback match
Date: Mon,  1 Apr 2024 11:00:52 +0800
Message-ID: <20240401030052.2887845-7-tzungbi@kernel.org>
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

Instead of using fallback driver name match, provide ID table[1] for the
primary match.

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353

Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1 (https://patchwork.kernel.org/project/chrome-platform/patch/20240329075630.2069474-15-tzungbi@kernel.org/):
- Split from "platform/chrome: cros_kbd_led_backlight: provide ID table for
  avoiding fallback match".
- Add R-b tags.

 drivers/platform/chrome/cros_kbd_led_backlight.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index 814846a66e95..b83e4f328620 100644
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
@@ -247,6 +248,12 @@ static const struct of_device_id keyboard_led_of_match[] = {
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
 		.name	= "cros-keyboard-leds",
@@ -254,10 +261,10 @@ static struct platform_driver keyboard_led_driver = {
 		.of_match_table = of_match_ptr(keyboard_led_of_match),
 	},
 	.probe		= keyboard_led_probe,
+	.id_table	= keyboard_led_id,
 };
 module_platform_driver(keyboard_led_driver);
 
 MODULE_AUTHOR("Simon Que <sque@chromium.org>");
 MODULE_DESCRIPTION("ChromeOS Keyboard backlight LED Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:cros-keyboard-leds");
-- 
2.44.0.478.gd926399ef9-goog


