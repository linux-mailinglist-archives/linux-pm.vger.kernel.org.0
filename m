Return-Path: <linux-pm+bounces-5611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4318914B7
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1FC1C23541
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BC848CFC;
	Fri, 29 Mar 2024 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7nVqqqD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A53C466;
	Fri, 29 Mar 2024 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699049; cv=none; b=HBH7LYsGo/RDqAJ5iXdBwnVAvqdMQq5IHykeM1aljUJwrPhsVFBU7w4FDrcFNb1VK1IoBgJCpQrLSqwgB9yEQIGfjZyYsTuvYkK/MMx08tgyW6azxyIIE5sBiZtiL4gpzgSf9CaT08W9CMFbMe/gcCPDKhdoNW69om0TgrRxQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699049; c=relaxed/simple;
	bh=PMydpdwXkX2S8GFW09p1L1gawoJinB3dIyCrvfl03lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1lE8MH2JR8uWGM08A6v5xWApeYPpVyRsxFSOOxc6x6xfC3dkZnxoywXVciFsRGqSoQaSGbnMbAQkUmz9GLxp3H9f5Ad45XxAlENmEjzRfVlz9pzn6wr8UbVctGy7vkMTKkfFcgYjFdgd+DA7jjXCz1kjo+MWohG0fWbSmQNIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7nVqqqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6445C433B1;
	Fri, 29 Mar 2024 07:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699049;
	bh=PMydpdwXkX2S8GFW09p1L1gawoJinB3dIyCrvfl03lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7nVqqqDKe6Rb4gHJVQZSQZZ6McgSYRqfFJyHxJByCa6jpcuE9yXcbZkqpJHp9qDN
	 dZy+aX1PhekQWGg9zXSi2OWWhs5qyKGoB+8Zhr185TaxLdDQHsXaRiufwT3tIbufyN
	 XK49Eby8VK6eoe8wLiExY0k5812hBtAk9pG1OXbByxe6iq94JMo0PfUF4IjCbY8ZXE
	 RU0XkpjRejGlkAnOQH7M8aVTVqvzZL9d6ekYC7Ix9ERPyuc3qdFpo+5cggw2afQuy6
	 4z8Ho8fwWjX9YSf/xQCIr7SzSHFlhEmxhA1eYWQFqD78blzX0gchcy0AwXEqmaJdWs
	 3R1Rq7I8W52eg==
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
Subject: [PATCH 05/18] power: supply: cros_usbpd: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:17 +0800
Message-ID: <20240329075630.2069474-6-tzungbi@kernel.org>
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
 drivers/power/supply/cros_usbpd-charger.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index b6c96376776a..8008e31c0c09 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2014 - 2018 Google, Inc
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -711,16 +712,22 @@ static int cros_usbpd_charger_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cros_usbpd_charger_pm_ops, NULL,
 			 cros_usbpd_charger_resume);
 
+static const struct platform_device_id cros_usbpd_charger_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_usbpd_charger_id);
+
 static struct platform_driver cros_usbpd_charger_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &cros_usbpd_charger_pm_ops,
 	},
-	.probe = cros_usbpd_charger_probe
+	.probe = cros_usbpd_charger_probe,
+	.id_table = cros_usbpd_charger_id,
 };
 
 module_platform_driver(cros_usbpd_charger_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ChromeOS EC USBPD charger");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


