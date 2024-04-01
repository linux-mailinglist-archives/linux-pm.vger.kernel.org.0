Return-Path: <linux-pm+bounces-5743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45024893794
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 05:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7675D1C20B47
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 03:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9C1FAA;
	Mon,  1 Apr 2024 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mebPtSk0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A09479;
	Mon,  1 Apr 2024 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940478; cv=none; b=JouRWj3O+eSDTRCW5qoYfzgBLHxQklUhOHn1WF+pL55zCCZJu0EOLxGL4gMoh+oIOWnXwaSRAuyzRxLl/qOU5bl4BN9MZHgkyiJJwKZWx5MW1+WxnXVKZHy/yxAl5B91z15mpcP6EbyuI5U64wA8pYpILI+9hZgaoarxSz9oD/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940478; c=relaxed/simple;
	bh=4ygibtdsXHmh6yImp9+dJnz+FeRFzVHcQC/vXMVmzw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWHcT4d/WK7ysymB/sWtaMulCMd/BNxrAwYbHQdjHZJfXbPvhuI/CWL+Gsp021XZcC7+5a/QOb/blwL1JGIfyZqOtOIr6Z5iWoe0oCZW8KcNqd0NXoIoD5GwlU82QBvIbLQdgW+54dt/eAq9GxEmUNmVyX2uiikUdSwAooqOF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mebPtSk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BADC433C7;
	Mon,  1 Apr 2024 03:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711940477;
	bh=4ygibtdsXHmh6yImp9+dJnz+FeRFzVHcQC/vXMVmzw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mebPtSk0wpcjcPQXHOz8Y1t+WhXzZzXMH2Z9UOnJ1ZWIEOq1Fcu7UmFtglVIoriWe
	 Uwq35FjC6fi2bX6dJi9OagYNPQ8egNJtvBgHbU6ZUqPBRz5+Y2a0Oq2yh+ZAuqqUfn
	 noDu8tHmEUfQEN8yExP2o3ZE2JMRZSModdcQZlgp42MEco/p97kc3lHv/e4fpbBSg3
	 3xSzYaVID6wWiqmWe8gbMtit6G1s0fxcYCIhnTBae4BBIoBHyODelPMwXCjTXDgAPI
	 B8HdK/54OvslIiX5uhzW6wsDdjlIOCMc5Ip4cky0OsXVYQ5aAA7nShBvDUl+T6Zowv
	 Y1qRVabPWEhsA==
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
	krzk@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/6] power: supply: cros_usbpd: provide ID table for avoiding fallback match
Date: Mon,  1 Apr 2024 11:00:49 +0800
Message-ID: <20240401030052.2887845-4-tzungbi@kernel.org>
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
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- No code changes.
- Add R-b tags.

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


