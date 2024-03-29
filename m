Return-Path: <linux-pm+bounces-5621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE908914DF
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2D01F2315E
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412B481C4;
	Fri, 29 Mar 2024 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxvNTi1o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579E4120C;
	Fri, 29 Mar 2024 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699077; cv=none; b=Ld/IBH989UXnQfR5Sh0FrVMjDJ/c2JwW0JkTTTCCdEo0deU48WX7E+NXkqKbyLJbpsQDA9eFrXVfmAcvhAHWsVMO+RbyWRt9zpv1rJIToC4h8fLFf80j/ynRBEu6C+ayVuA/ZvanYb7+fuiYlRaJ/evbRoW/+7/c7a3b9OO3T84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699077; c=relaxed/simple;
	bh=lFOw5fKzQhBabthihGEd61vuz/8D+4zofg3e9FaPBrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQomGRYlhEZN5SB+ln/9cl1MgEfWI8B2G1ovMYgMhveOIvTgLgb4zn+Yr/BrWyJNCtrOwheo6Z+AfivC1g/PuEur2R7qtGFjt67DTPtVe7nSy2HqnonlYXtex1osPCxqurWA8hxi/AynlJ8ctYdcxibZQcYV4n+5OK203evrE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxvNTi1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BFCC433B1;
	Fri, 29 Mar 2024 07:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699077;
	bh=lFOw5fKzQhBabthihGEd61vuz/8D+4zofg3e9FaPBrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MxvNTi1ownDZ5TzUHkN3QCd8SFD8/TxANda/qG6OBvO59Vxyo6R6O73lCB2CYkKAM
	 Uaf3toEyBj9bS4IC419SCis7teVFTWMsBd2YlnUdSy9xETWFRvBMPEgu/6ilMjjVIN
	 jz193RqkjQLxBsgeLAeGSqkVglCqDzzcaPNQzc5SERm2sXGdhHWpSQyW/S0of8vho2
	 DIMX9wcQkNnySop02WqMDErdGKoVkvnd9WGjhNnsUVkVpVRuRqjiMUyufmJ4AI6WOD
	 04LXQ+xaXWlKxI5/GqArZRJRa8yLdwMboH0aeeCkMuXB3I7kImjqXZD7rRmJJTtPFr
	 skHqNZjLUDB2A==
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
Subject: [PATCH 15/18] platform/chrome: wilco_ec: telemetry: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:27 +0800
Message-ID: <20240329075630.2069474-16-tzungbi@kernel.org>
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
 drivers/platform/chrome/wilco_ec/telemetry.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index b7c616f3d179..21d4cbbb009a 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -30,6 +30,7 @@
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/fs.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/wilco-ec.h>
 #include <linux/platform_device.h>
@@ -409,12 +410,19 @@ static void telem_device_remove(struct platform_device *pdev)
 	put_device(&dev_data->dev);
 }
 
+static const struct platform_device_id telem_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, telem_id);
+
 static struct platform_driver telem_driver = {
 	.probe = telem_device_probe,
 	.remove_new = telem_device_remove,
 	.driver = {
 		.name = DRV_NAME,
 	},
+	.id_table = telem_id,
 };
 
 static int __init telem_module_init(void)
@@ -466,4 +474,3 @@ module_exit(telem_module_exit);
 MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
 MODULE_DESCRIPTION("Wilco EC telemetry driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


