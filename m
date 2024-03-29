Return-Path: <linux-pm+bounces-5607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3AF8914A5
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBA41C2240A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27C642070;
	Fri, 29 Mar 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSw0TcbA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140B3B78E;
	Fri, 29 Mar 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699038; cv=none; b=mI9KGVRQgLXYherBOaQwiqx/z8X8S8BKp9TGYuwKc3HaauNBKDM6sZEpBEmEbRFAg+jM2h/kTtBn6vu+2HaUUo1mZyyQq8oKUbbLBSG51SFZi9PzAvGVBSNbHu9zx56pQiTMFOx+VulaYVIxDWA2tlmwmkhtzSLixPSi+6Y7qlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699038; c=relaxed/simple;
	bh=rYj4oByNDWSNNv8deLJRnMMa9IMZFSG3YNnpzY4T5ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLRE5HgMQmqyT0qKDju3Ulz1YScm9P0g702YIR8ZUGukSyWezELzgb+gXdCk+TFHeZOOeVF2mWt+9RQ6WSCqmEvB3W8FVvyqmnH7MtSGYzBMjYBIBhItyk9ASsNstEmSS9xETQFhfIk/LG+k8+pu+4z6/pqAIpaFt1qkD32TsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSw0TcbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9483C433A6;
	Fri, 29 Mar 2024 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699038;
	bh=rYj4oByNDWSNNv8deLJRnMMa9IMZFSG3YNnpzY4T5ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sSw0TcbAmrkw0IVVPBM+6Xb00vXRMrrkPRxwhXo+SWmEp9geg2jy74+FkG9UDt1H2
	 FQqeZ8Y+IDVij/AMfEm1gYMMWgofQEpF8bFN97vxvVtSGas/NJtBjN/RdMRAaXk/l7
	 o1Kr5HwT9buz1Cj6kHgsBcP/3QFOSZMdi63x9JX4CiM7jbuFgBrMRVSzl662X2bv9v
	 2oAs3fTaUog2/um27x06mMcBCNBpk8R7gddsF/rOQZ5TrJdLptC5wp4IQYzqT4J7nU
	 ZMgqzomA3BpbA/9RowBzCeEpwOjIOwV+2I//5V+APXQGduMMX+pgSXQpkTVMkKjLRX
	 8JEpWp5cxFFhw==
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
Subject: [PATCH 01/18] media: platform: cros-ec: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:13 +0800
Message-ID: <20240329075630.2069474-2-tzungbi@kernel.org>
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
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 48ed2993d2f0..8fbbb4091455 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/dmi.h>
 #include <linux/pci.h>
@@ -573,6 +574,12 @@ static void cros_ec_cec_remove(struct platform_device *pdev)
 	}
 }
 
+static const struct platform_device_id cros_ec_cec_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_cec_id);
+
 static struct platform_driver cros_ec_cec_driver = {
 	.probe = cros_ec_cec_probe,
 	.remove_new = cros_ec_cec_remove,
@@ -580,6 +587,7 @@ static struct platform_driver cros_ec_cec_driver = {
 		.name = DRV_NAME,
 		.pm = &cros_ec_cec_pm_ops,
 	},
+	.id_table = cros_ec_cec_id,
 };
 
 module_platform_driver(cros_ec_cec_driver);
@@ -587,4 +595,3 @@ module_platform_driver(cros_ec_cec_driver);
 MODULE_DESCRIPTION("CEC driver for ChromeOS ECs");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


