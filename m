Return-Path: <linux-pm+bounces-5616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3178914CA
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2464E283FA1
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FED50A72;
	Fri, 29 Mar 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONa31BvK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582F44C6E;
	Fri, 29 Mar 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699063; cv=none; b=sbWNFbO9+s+AtKLWNXIHePvKIUZYJJgGfd/YiQKKQpTwGUegeaTsXx2UMi/tUN8T2ZXvvAbbb8ZPKgjZVQySpGl8cU91wYH7lW3lNtAgp3asBJ82smxwUJ6IBX1lqDfoIv1JcHRy5KADLVYHVCkSMKu6JLLdDiecoQM5JX1aSWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699063; c=relaxed/simple;
	bh=kFeF0LIiPjmeikl5k/sexOPFplEdBUjUHzmZqIW6TVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1raPjIl5C7Vv9lAzjpxyYHu9cBL+aWpbdqC6KyosOcqG2y99jZChZPzR3G62NQ300/yL1H+guuCnORRhP1U9jT/XT4f0NgbBMNdJUxqYSpk8cmX9hNPCby8eW6ybB3T4R3GBRjQI6+2B3l0Rq7eZwsjpRnRnlhi+F6mt1il4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONa31BvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9144C433B2;
	Fri, 29 Mar 2024 07:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699063;
	bh=kFeF0LIiPjmeikl5k/sexOPFplEdBUjUHzmZqIW6TVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONa31BvKgAZzxdkWcrHr0H1WYMXtVhm71J2TqovxHmi5u8oA8B8MnD21JDbpvb77q
	 h7W3JDqrDxP1Chw8CRGHaH9zpLiuR/omBK19RMnY7frU7je9MdhJIin44aLets6Df1
	 VNaHQ/aXZsKsz18Cih5j1qACN5DLCG7IU9APPGlChbsvjC5j+gTT8rfoowtriODdgD
	 kSbF6M8wpvUAzqleq3UjIHFktKBlmuhrA+fKNKdbNG2RVzwrxXC4ridT7GxhtMwbJV
	 n59nFT549HsQy/osgijjCFaUtsfwNvj7rNGwvYnLpd7m2CHvzl5uhNFSBaZUG2H8Om
	 jOz0q1vZN6+fQ==
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
Subject: [PATCH 10/18] platform/chrome: cros_ec_sysfs: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:22 +0800
Message-ID: <20240329075630.2069474-11-tzungbi@kernel.org>
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
 drivers/platform/chrome/cros_ec_sysfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 93e67ab4af06..9c944146ee50 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/kobject.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -347,16 +348,22 @@ static void cros_ec_sysfs_remove(struct platform_device *pd)
 	sysfs_remove_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
 }
 
+static const struct platform_device_id cros_ec_sysfs_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_sysfs_id);
+
 static struct platform_driver cros_ec_sysfs_driver = {
 	.driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_ec_sysfs_probe,
 	.remove_new = cros_ec_sysfs_remove,
+	.id_table = cros_ec_sysfs_id,
 };
 
 module_platform_driver(cros_ec_sysfs_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Expose the ChromeOS EC through sysfs");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


