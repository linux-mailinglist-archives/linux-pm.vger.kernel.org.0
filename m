Return-Path: <linux-pm+bounces-5614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733CF8914C3
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC7F288386
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCBA4F5E6;
	Fri, 29 Mar 2024 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rkrc1jBx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320D42A89;
	Fri, 29 Mar 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699058; cv=none; b=OMg1jF9dnaKQcAcT6mIvs7peeEXWUzzlKuxve4rb1qW6E6oBUNutr9L7xtEqsMwfnwEwel45vVRosPIaAOlEVZSogwBYirLhoLZHmXBA9nxHcfCp4OC+++UwuUlGItAvdCiODAjICPALsDQWzf6bsWZUQ0YNyWyB8pH4cajwUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699058; c=relaxed/simple;
	bh=naQ4XLQ0Lyzu8tBIZlJX0LmtXIL5RjubTvqFMDzZDwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fyt2W+3JCa/j55zJk9eCQppNxNDHC6n1odSdvbhiy3xjwNihCbm06nxetNKSk3vXgLBbOhT2PUu8x32Dgo8QaOAPEn0DsRLR270EDlkOYe8wq9Ba7z4DOYsA59ghFhBWGLk/3CZqDQJAesyOpAiru5GoHgW26WsuxfaXCmyMNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rkrc1jBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D08AC433B2;
	Fri, 29 Mar 2024 07:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699057;
	bh=naQ4XLQ0Lyzu8tBIZlJX0LmtXIL5RjubTvqFMDzZDwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rkrc1jBxDhJzBE8lP3MrwstyEhXWeYtaF7VTiIJcLyQNw0fJsQoFuIZmgGZ4cVP39
	 9If8YZv3cIXZdGeJ0/T4wFoOdNGfSSkpbeCESMqmrhPIXhbLZK8ZpisPzXlrDVz8FA
	 RFVXX8VLoceDlXrNW9I8ScqxiaLsE0aNbLYcsihoi1aYvWyYLYeNZK62VFZkbrb/hJ
	 3yH0G7AzXkTVPjkERWPipYkMDnDM1ibAcRgQrBrNTDd6MT/eA3xgj6Ua/m1+riXkre
	 FYBv1DuuzwiRDMVq18Yy7Mynf9wHqhJJAQ7LMo05SnYkfCcZA1m68lvcyKQ4Pa4VUn
	 Eku9n6HkPaPnQ==
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
Subject: [PATCH 08/18] platform/chrome: cros_ec_chardev: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:20 +0800
Message-ID: <20240329075630.2069474-9-tzungbi@kernel.org>
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

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_chardev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index 81950bb2c6da..7f034ead7ae4 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/platform_data/cros_ec_chardev.h>
@@ -403,17 +404,23 @@ static void cros_ec_chardev_remove(struct platform_device *pdev)
 	misc_deregister(&data->misc);
 }
 
+static const struct platform_device_id cros_ec_chardev_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_chardev_id);
+
 static struct platform_driver cros_ec_chardev_driver = {
 	.driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_ec_chardev_probe,
 	.remove_new = cros_ec_chardev_remove,
+	.id_table = cros_ec_chardev_id,
 };
 
 module_platform_driver(cros_ec_chardev_driver);
 
-MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");
 MODULE_DESCRIPTION("ChromeOS EC Miscellaneous Character Driver");
 MODULE_LICENSE("GPL");
-- 
2.44.0.478.gd926399ef9-goog


