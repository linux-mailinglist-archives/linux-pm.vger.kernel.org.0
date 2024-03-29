Return-Path: <linux-pm+bounces-5615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D98914C7
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391301C23A63
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038264F8A9;
	Fri, 29 Mar 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSOxjVBS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7A44C6E;
	Fri, 29 Mar 2024 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699060; cv=none; b=Q3yEgmMn9+krYAVMAoWs2zQBKI4BM4pALQENJFagxGpaS24HWfMj1Mo6VcCFfautuz+NSwHdHVQ30oscj90g9qTWYYzjAENjLlALDxK0E3Jllk7u7Daf7UixTii4bP9zFKH4T+Kel6hyyx6RpNnS79KTmVB0PECf4Tx1RV1lLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699060; c=relaxed/simple;
	bh=M+NHbhc/maaG6/S40kpqOW0Ck2sbT8PDO3AsjSVfB9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojZbpnO5LIhRX4Zwk/ZKji0k0+E38U7Ti2FFDEOBicA40DfaX1VtnlQQnCop8eNTNOgQKShnwPueuIV/VAYICNwRvVff2QjRC/AVyx4EaWwKO8IzTiloyz0EyJWNRAoo57lprjzd7PCHqD1yottjeV6zc1QQO0xSPadbXECcwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSOxjVBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA79C43399;
	Fri, 29 Mar 2024 07:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699060;
	bh=M+NHbhc/maaG6/S40kpqOW0Ck2sbT8PDO3AsjSVfB9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSOxjVBSJjriBM9WOQX006hm1khF69+mtE7sl9LOh9d8YFYwES2rvQNqKpGuN+3Ur
	 sTHBTBeeiU52M9fyLVF24JXhOhE9ymqUUZYFGqiJ+ir84WJdV5w361FF3XciYnUWbb
	 lYa+tHF7cf06BN/COqf1D04J4YQF6IYwVuNKZtqB1pZ9xH31PSVeapFJiZWyBpJ+eJ
	 PeX4FwEJ02ywlWi2zCloEyeW3Nd58oZiph7cTOqksTUHFnzRgN4Ckuz8deRbQQ0spB
	 PCkTl5MSf1tdrIlk9nN+3M4/vtWmxqrZvdHy8+4pJPRPG8LWkQ3mG8waKMY7aURtQA
	 pZpTn4T+G4AMQ==
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
Subject: [PATCH 09/18] platform/chrome: cros_ec_debugfs: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:21 +0800
Message-ID: <20240329075630.2069474-10-tzungbi@kernel.org>
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
 drivers/platform/chrome/cros_ec_debugfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 6bf6f0e7b597..e1d313246beb 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -7,6 +7,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_data/cros_ec_commands.h>
@@ -564,6 +565,12 @@ static int __maybe_unused cros_ec_debugfs_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cros_ec_debugfs_pm_ops,
 			 cros_ec_debugfs_suspend, cros_ec_debugfs_resume);
 
+static const struct platform_device_id cros_ec_debugfs_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_debugfs_id);
+
 static struct platform_driver cros_ec_debugfs_driver = {
 	.driver = {
 		.name = DRV_NAME,
@@ -572,10 +579,10 @@ static struct platform_driver cros_ec_debugfs_driver = {
 	},
 	.probe = cros_ec_debugfs_probe,
 	.remove_new = cros_ec_debugfs_remove,
+	.id_table = cros_ec_debugfs_id,
 };
 
 module_platform_driver(cros_ec_debugfs_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Debug logs for ChromeOS EC");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


