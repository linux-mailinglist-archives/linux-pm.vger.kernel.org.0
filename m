Return-Path: <linux-pm+bounces-5744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59F893798
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 05:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13041C20A59
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 03:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE139444;
	Mon,  1 Apr 2024 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF4fw1X3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F9BA2B;
	Mon,  1 Apr 2024 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940480; cv=none; b=GmmSgQNieDcpEJgXXHT7EmCKab9p55xTo3dyxx1ELgGzcydXoG48WCc1q4pDcN0myhFx7KW2kCI4kJ+dNofDDTCMCGRoRRWc2lwQxxw6uyQlqw5gLOPvWRXNNwvWYZHJI8s6GFI0NwPZ3VX61s4kE/K0xXl64RFn35AeeToectQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940480; c=relaxed/simple;
	bh=II3WcklFT4vc71YiPvas+ZBSQTksCjF6+Z2zutxVTko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogwhL3d339iyRToWyj9xUtKoVm92+0tZ0od7cfxXIwFaRwJ74dIJWS8IziPtBGRGUQUdelDBgO+YQc5iVjgjjaEQllbkW/p1MOWNTicEEDGav4ODnqaJexmAQHLEEuFro/rI8SVCDj49gnDsFqgo9Jzi5Z17TERZwW8qH6uM0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF4fw1X3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47446C433B1;
	Mon,  1 Apr 2024 03:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711940480;
	bh=II3WcklFT4vc71YiPvas+ZBSQTksCjF6+Z2zutxVTko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GF4fw1X3ESSa7gfymTe/8l6qGIHFGrBnZH6rv5zv5QBZvKg+JlUqyfv1+kxKdv8O/
	 NQLls838EZSNwy0zqx1JZkrMJNlgkgNEyt35sRIAZ/9NKMn67L8jUntoMBo+YjA4km
	 9kgX8txtopFF0b8SM4+ywvcQtNMZ8m4ht8NgWI+T9BJJW4ISjSnBrUUB4avlMt0nl7
	 6FbvnxpK0ICJFibJ3jG4qRgR+7646Je16gOWKS8RENeUl08yLmYl4y2KsZsIXn9Fz5
	 cEQ51uIeJBu4O5xZNg30Kg72uaCP/OiO3bwA+3Rv/9vnAH6kYvxjH6AZJC/RxX8KfK
	 D7dWqzg4x4WEw==
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
Subject: [PATCH v2 4/6] power: supply: cros_pchg: provide ID table for avoiding fallback match
Date: Mon,  1 Apr 2024 11:00:50 +0800
Message-ID: <20240401030052.2887845-5-tzungbi@kernel.org>
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
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- No code changes.
- Add R-b tags.

 drivers/power/supply/cros_peripheral_charger.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
index a204f2355be4..d406f2a78449 100644
--- a/drivers/power/supply/cros_peripheral_charger.c
+++ b/drivers/power/supply/cros_peripheral_charger.c
@@ -5,6 +5,7 @@
  * Copyright 2020 Google LLC.
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/platform_data/cros_ec_commands.h>
@@ -367,16 +368,22 @@ static int __maybe_unused cros_pchg_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(cros_pchg_pm_ops, NULL, cros_pchg_resume);
 
+static const struct platform_device_id cros_pchg_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_pchg_id);
+
 static struct platform_driver cros_pchg_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &cros_pchg_pm_ops,
 	},
-	.probe = cros_pchg_probe
+	.probe = cros_pchg_probe,
+	.id_table = cros_pchg_id,
 };
 
 module_platform_driver(cros_pchg_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ChromeOS EC peripheral device charger");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


