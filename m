Return-Path: <linux-pm+bounces-5741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77B689378E
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 05:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0951F217C0
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 03:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0E4A1B;
	Mon,  1 Apr 2024 03:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3owk23/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5F7F;
	Mon,  1 Apr 2024 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940473; cv=none; b=B9vU0NNZ4Ktaar4PjnGlQf0wLMvckQbPZwjig+1TqDk6YDANmH7erCFIKTxc9qlumH8eA8NG+hqnSAu67Lo+NEO54ccZ88f6fOI4xZbnVrGmOWfG9vP9l+rukdS1QEsf/CJzng0BtWsVEHZZuf3iAgxxogXY1Y4EtjFhIK/+WhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940473; c=relaxed/simple;
	bh=e0C3uXZCQKhBltbJhXyTZt3YJk6LWIsw+HanZYDGaWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9QJCttqfTTibji5H/IDV9khZ9ayz7QHQHmMi2FoTK9wRe0nsWV/F3yfHYyii1q4O04eMfkvXqCKOU7Hud94swGzod7KjMLOUP1TGP7W0RZ9UuzHt1EzSOAJJft/p7/EEt/hy3ywVF4gnYqo8ikn9cJGaeT2f/xRFkrjyDBAqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3owk23/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79472C433B1;
	Mon,  1 Apr 2024 03:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711940472;
	bh=e0C3uXZCQKhBltbJhXyTZt3YJk6LWIsw+HanZYDGaWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3owk23/gHwCL+OoZQzgtQa1QLuBX1IWSpzj2fExeV/B1UVRQop4CfmI8Tp0Ja2Mq
	 1ZUc/qzmhln3XaZTlWvsHBQpM9haeJQ4bcGBAWxh4toBozNlj9q9yTZO0/hopgCvP4
	 J9PqN/xIKTDqf5L6DCOzThqP/LjUBf1aUIUO/zBxMZ+55sjmi5t0wvHJu/RbjCmUd6
	 PapPAxG/nk7A9ug6bNrd+QODV2sdYQoOFVFHNpFLqJL/2sEgoF7CSEgxJefIGPchqy
	 RAY45FqpgU6uWdAosVK7gwDDN5OKy2QA9CBsNHrCk3rn1a8vVlwnkTdS7R3bMr7LGX
	 nSn6I8EPxlawg==
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
Subject: [PATCH v2 1/6] media: platform: cros-ec: provide ID table for avoiding fallback match
Date: Mon,  1 Apr 2024 11:00:47 +0800
Message-ID: <20240401030052.2887845-2-tzungbi@kernel.org>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- No code changes.
- Add R-b tags.

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


