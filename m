Return-Path: <linux-pm+bounces-5617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD658914CF
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FDF286C4F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BF95026D;
	Fri, 29 Mar 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpEIwaDH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99942A89;
	Fri, 29 Mar 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699066; cv=none; b=e1QB1uI+dQmd42IO6ui3ShNn7ja0B3+DWNx6KaDjkFbBP+yJt4y+8bAXEhGZKNfk8Dub7w/9uGVhNLy3i5NKL9TwwEtNKBeYa0IVFR5r6hro8iQ2yAIt34FejyjC8kJwfK9RdOZWsbty+MLMAtPcveHqA9zb56ztgUtCmweKNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699066; c=relaxed/simple;
	bh=Vm6g+x6wCDY55Aqkfud76EpsXl8ECuaMa6XmXenymoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIAbMFF2B1JFR/SzPXL+feY40QOGM88cHifhg2sfgJrfnyFXeUlF3eTTKQGCyNQntsVD5FT8lhG/RO+ElkBDi+8TF7mUc7xdMXQP/s4pGNxgEEk+TUAV8CTI0ruYT3is8DkltXLMIc1m67F+5UUFQ1u8OKwCbhBz0SLld2rim4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpEIwaDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7352EC433C7;
	Fri, 29 Mar 2024 07:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699065;
	bh=Vm6g+x6wCDY55Aqkfud76EpsXl8ECuaMa6XmXenymoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VpEIwaDHfUuhv3t7+Y+HJGU+KQFrya5tsamaiMTd1n9VMD4ygWrdV21sfjFsFNkE6
	 9juwVX7JoEtiZ2ZrE2sjiuiYA2R/e2W7kKDXrevEIl/x5BupDVUjNYG7sVnsCN8ur2
	 shoTnfuTEmGx31oYqXbZy9e7M65Dpe0cV3Ilcq4d5scqdQcVva2hN4UmjzzITvVcy3
	 PR6OHvlSeP/AzWPxJ/8+QUSXubX/80ZWZdy6cb6WWjNF7yqPAFqejWiyR8dxl47/Lt
	 uWygFTbWe59Ipmy+lBShANg7ZoVraiqbPJ9llkY+vgazgxyrT38yNz+46LE51wQ3wE
	 PlV9a04IHqRhg==
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
Subject: [PATCH 11/18] power: supply: cros_pchg: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:23 +0800
Message-ID: <20240329075630.2069474-12-tzungbi@kernel.org>
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


