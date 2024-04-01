Return-Path: <linux-pm+bounces-5742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4E893792
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 05:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A0DB20C25
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 03:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13859A48;
	Mon,  1 Apr 2024 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjhUsO4J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B69444;
	Mon,  1 Apr 2024 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940476; cv=none; b=m13c+oA67RbnDiT5cvqUs+6zgga7jqWbfjI6aqf7Oi047DTsOxqTjZXP25cznGJc0pdso29opQXjLink6DBLkjzBgWg1htrzq1vSYhR2zjOnrb+Loj+m6PJuiHRzLKWUEahqWgeOKplUYsm4pfASGOwE33j5JhxLs4YFPd0pPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940476; c=relaxed/simple;
	bh=sIWuWcJLnkR80gZ4RYZ2oWSIHilGYeXqbxT24GsMd7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJ1nKd7oSHNWLt9kRq+iHnrQWGoa2+M2ts92yKbVGLxuBC5CWhCsgU4UfUIYrLlk4Pz848g7AoZ/RXZPZe0gD/j834B4GmPnJ3V9W4hVcjeWkR0YwfHwfXMUaanBHQJe2maBfCnWUBeIjZOhks0ngIowtyH03CT/yZ0H3IZ5vxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjhUsO4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18265C43390;
	Mon,  1 Apr 2024 03:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711940475;
	bh=sIWuWcJLnkR80gZ4RYZ2oWSIHilGYeXqbxT24GsMd7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjhUsO4JCytAgyUS0TbNKqGQxTICFLVZM12SwBwR8hWvoYz+Dpg886bWhYGhWa5In
	 JvBcpShd7UvFRAiphxrEUfyPCFafL1Edkxd1wd0X6aOfgKHFQyFSKK+kak9YHpPZbg
	 yObEfECRmDFJ5NkgeYi+X9VJK40YFRmz7ICf/ir9IzPtJTn/ufI+w1b5aFGKOIotVn
	 jejvF3a/GOM07Yv0y1OKtsZdef5/7gsxnDYYqih+BTRltoTJtRUcx5mPtYp/SPfUC9
	 c+pyPgJZNGKQdXUKVC0IZ6mdizN0lRJWGzz/fmhnDaJSp3duzttLpXDyrhe8ru1tOS
	 FXNmKTNecGS1Q==
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
Subject: [PATCH v2 2/6] gpio: cros-ec: provide ID table for avoiding fallback match
Date: Mon,  1 Apr 2024 11:00:48 +0800
Message-ID: <20240401030052.2887845-3-tzungbi@kernel.org>
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
primary match.  Also allow automatic module loading by adding
MODULE_DEVICE_TABLE().

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353

Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- No code changes.
- Add R-b tags.

 drivers/gpio/gpio-cros-ec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-cros-ec.c b/drivers/gpio/gpio-cros-ec.c
index 842e1c060414..0c09bb54dc0c 100644
--- a/drivers/gpio/gpio-cros-ec.c
+++ b/drivers/gpio/gpio-cros-ec.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -197,11 +198,18 @@ static int cros_ec_gpio_probe(struct platform_device *pdev)
 	return devm_gpiochip_add_data(dev, gc, cros_ec);
 }
 
+static const struct platform_device_id cros_ec_gpio_id[] = {
+	{ "cros-ec-gpio", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_gpio_id);
+
 static struct platform_driver cros_ec_gpio_driver = {
 	.probe = cros_ec_gpio_probe,
 	.driver = {
 		.name = "cros-ec-gpio",
 	},
+	.id_table = cros_ec_gpio_id,
 };
 module_platform_driver(cros_ec_gpio_driver);
 
-- 
2.44.0.478.gd926399ef9-goog


