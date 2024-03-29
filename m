Return-Path: <linux-pm+bounces-5622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6548914E2
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098A328488B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1530553E38;
	Fri, 29 Mar 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJs1zzf5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836D481DF;
	Fri, 29 Mar 2024 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699080; cv=none; b=COV5ZGhcu8fZkX128sPcnROKoL72fLtz0YTY6ROeGlv9LeVcXfAijFQPi2t8yNn+EYuzlOeZ1RsbtAhMDmVH9yc4RoAQFj4ov78VkEXqUpJj9iWRN0KvDbPovpZ2eITkY2amfHlKQEBVMqvr5Clrmid56rmtXJSr6yNK97cJQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699080; c=relaxed/simple;
	bh=aGfaQOx1BwBsZYBo3nJwWSfL7KIuqoNe+5Rb0dp4jDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJXKykAxxj+u6cC3tTzSQnEdZ9UwKSVAQUZ5WHevvE3Oteg6+kDl8VKBSjar90LPbnidYcW9tdjLwXQ4Y/7GnOUb8LUrOeI0L+w5tuJq/jpmhn9aW8w2fs5QL9BYDLK3v57YQcC0PXYBXA9C7iPcSU7DaytnqYOHaNU5TEsoo4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJs1zzf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F830C433A6;
	Fri, 29 Mar 2024 07:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699079;
	bh=aGfaQOx1BwBsZYBo3nJwWSfL7KIuqoNe+5Rb0dp4jDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJs1zzf5Gw4KtZsf96BiLjR8qz5rVVMpnQ6kKQV8SpSPNoaFjeqpz/rjkK8zLd7bn
	 dj0Vz0Hyf4aF0dVt01H04OSHxPeYzODAlLzsJblWLn476VcRJ5ryM4b+Fc8ijOB0v7
	 w1p4f7gG3DO9d9tufxhuw7e9ij5brqQKQQyQrUd6vqhANg0WEVkTHw2Xem86a9vJrV
	 co1IfOQmF2zjlpgTh5o6oEfZ5794RED55OKO+Mb7alSBaa8aYDr1JGaq3zxoU5IwHS
	 P9jeohzugn/IjHEIxjuH8ffzbML6Ecl0jV3GdAW7N3JfiCA30+ga+OvgvOgqn2IsF2
	 XmTbHD+ynVy3w==
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
Subject: [PATCH 16/18] platform/chrome: wilco_ec: debugfs: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:28 +0800
Message-ID: <20240329075630.2069474-17-tzungbi@kernel.org>
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
 drivers/platform/chrome/wilco_ec/debugfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index 93c11f81ca45..983f2fa44ba5 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -10,6 +10,7 @@
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/fs.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/wilco-ec.h>
 #include <linux/platform_device.h>
@@ -265,17 +266,23 @@ static void wilco_ec_debugfs_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(debug_info->dir);
 }
 
+static const struct platform_device_id wilco_ec_debugfs_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, wilco_ec_debugfs_id);
+
 static struct platform_driver wilco_ec_debugfs_driver = {
 	.driver = {
 		.name = DRV_NAME,
 	},
 	.probe = wilco_ec_debugfs_probe,
 	.remove_new = wilco_ec_debugfs_remove,
+	.id_table = wilco_ec_debugfs_id,
 };
 
 module_platform_driver(wilco_ec_debugfs_driver);
 
-MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Wilco EC debugfs driver");
-- 
2.44.0.478.gd926399ef9-goog


