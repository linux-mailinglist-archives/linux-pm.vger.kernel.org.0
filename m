Return-Path: <linux-pm+bounces-5613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA98914BE
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADBB1C2335F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B094D9E8;
	Fri, 29 Mar 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHd9wuV7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96CF446B3;
	Fri, 29 Mar 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699055; cv=none; b=caangYbkDhgWFt4K7/ghMqST93IcQkPBuKjrgYF2IdM9yG9Re1iAjSTGfMLiood427moEhW1DWbr+as2/GvYXNAqdTtoo2iDYYmEbhZPz/xNeswXWd+YeyUa4hy4Uhpuo1FGxo2HAsQHbsFxYEhttavM12Qr0f5DssxdWgE6Ayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699055; c=relaxed/simple;
	bh=QA/VEwsMDJYJl/wcNQFK+4ALan5uuRiCuOFDMWE5qh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqvrto86i6rt2q6Mzzn0F+sPmqPJDkvsQq+nkpk8vjXc18cHH4i5CL3zTR16LTHyiT+5+lhS2w88NEEJGfz3I2YBAqemINC1PMuWnJefA4iJvjK+pktVYKewhGwNi6tp/t+HoNIhRzzya7DoOGDCh8Ln9Mk+tdZnPeYO2iFaucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHd9wuV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5357BC433F1;
	Fri, 29 Mar 2024 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699054;
	bh=QA/VEwsMDJYJl/wcNQFK+4ALan5uuRiCuOFDMWE5qh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHd9wuV7mQFb6M8tPNRM4/QQvzNNwy4QeYf6cMzilbdAUxyagKZ3s0oSAdhaPvlYH
	 XAPs5GNMlWKy+xMayw5NP/jsKAu9vmcmhViClgXd7lvsPn/6d7VvK7fyByT5xRrsI2
	 OX/TvDOFfeE1/rDN6sx7O3LmOEtIWte2kMaSGFfF6mmEqLaZRBcBdGpbgPF0jLoZdo
	 +zzIWFBJ073emiK/bDCJZR7RNL8mvWmCqWA5hje3v5nAhZeFjRztzYWKLEo7Mop5I5
	 1OPDEPV+WjsOLzQWjQ94CnQvCSNMGzx3YCpDDueeeh8FCJUcI++AruussJnIXPuBvh
	 XZDsM+e2HpqRg==
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
Subject: [PATCH 07/18] platform/chrome: cros_usbpd_notify: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:19 +0800
Message-ID: <20240329075630.2069474-8-tzungbi@kernel.org>
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
 drivers/platform/chrome/cros_usbpd_notify.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index aacad022f21d..c83f81d86483 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_data/cros_usbpd_notify.h>
@@ -218,12 +219,19 @@ static void cros_usbpd_notify_remove_plat(struct platform_device *pdev)
 					   &pdnotify->nb);
 }
 
+static const struct platform_device_id cros_usbpd_notify_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_usbpd_notify_id);
+
 static struct platform_driver cros_usbpd_notify_plat_driver = {
 	.driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_usbpd_notify_probe_plat,
 	.remove_new = cros_usbpd_notify_remove_plat,
+	.id_table = cros_usbpd_notify_id,
 };
 
 static int __init cros_usbpd_notify_init(void)
@@ -258,4 +266,3 @@ module_exit(cros_usbpd_notify_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
 MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


