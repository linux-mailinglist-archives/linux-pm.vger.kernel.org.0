Return-Path: <linux-pm+bounces-5618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A448914D3
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581C61C235F9
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F363D47F47;
	Fri, 29 Mar 2024 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JucFa9+I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B594596C;
	Fri, 29 Mar 2024 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699068; cv=none; b=jSzsdLWsXASiAf9I5l4sD1KNYk4v9Smv/MX6mojCIrArKbjPtKPLrbrAZzI/L/TXb1fgtoBy2hRnv3BWB0UdIRc1J6MffkaLUIO/oqS4nVTG2+05+MdHonTtGaqolJgw0w0nnaHRH8m1DoRrbcuS0dmLT7FXFVVMDm6Wwbwez44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699068; c=relaxed/simple;
	bh=KKHQzxGzOFug2U4pQlP8FzTiyW4FgKwsmWbgaFAKMaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrscGShWpmXk7q+BZYniTa+tnDSV4Ow2+MjqCh7zFjPNjbBb3hHYQ6LdMxYh8mpYI9TjZa6s6xdPi3ySZOJxLCSyxn7h87KovduJt01WT38b5XbnPAQLMFqp9P2LffNv4e+LmazzTugNQOTQ/dN1hh2pdDDy0Zxoq3n/4eVUImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JucFa9+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA71C433F1;
	Fri, 29 Mar 2024 07:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699068;
	bh=KKHQzxGzOFug2U4pQlP8FzTiyW4FgKwsmWbgaFAKMaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JucFa9+IGlANxRGZfbjh9YL65VO8TYQw7o5mpMf9Lnt4UD/GyIGEzyZYXTcOY51/R
	 VhUZ3wKQbFOfc6GCQ2SIzQ135zErSmcNOgysLws4XcMFBi4JCK6envUBzSFPhWYbVk
	 q5zUZcH+xUsCNQzZSakmVHEjkhhpCxiP0n1ZZuHoxBSgfWJN9ofUQuIT7Hq9hMq+YQ
	 nukR4lVxcvrL9qxjm/gsjXweno2pve4gPcb8gwOFpsppi/LOER8k/W0+8O5xNs1nKk
	 MiKC8Ml9f5tWMZMbpFOF+cDaYZw4+8dnacCyExQ/t9KpRO5IAW+cBXdR7mntUXVrBE
	 OjMWu7CHkwymQ==
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
Subject: [PATCH 12/18] platform/chrome: cros_ec_lightbar: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:24 +0800
Message-ID: <20240329075630.2069474-13-tzungbi@kernel.org>
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
 drivers/platform/chrome/cros_ec_lightbar.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 6677cc6c4984..1e69f61115a4 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/kobject.h>
 #include <linux/kstrtox.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -594,6 +595,12 @@ static int __maybe_unused cros_ec_lightbar_suspend(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cros_ec_lightbar_pm_ops,
 			 cros_ec_lightbar_suspend, cros_ec_lightbar_resume);
 
+static const struct platform_device_id cros_ec_lightbar_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_lightbar_id);
+
 static struct platform_driver cros_ec_lightbar_driver = {
 	.driver = {
 		.name = DRV_NAME,
@@ -602,10 +609,10 @@ static struct platform_driver cros_ec_lightbar_driver = {
 	},
 	.probe = cros_ec_lightbar_probe,
 	.remove_new = cros_ec_lightbar_remove,
+	.id_table = cros_ec_lightbar_id,
 };
 
 module_platform_driver(cros_ec_lightbar_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Expose the Chromebook Pixel's lightbar to userspace");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


