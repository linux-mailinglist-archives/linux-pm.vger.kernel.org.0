Return-Path: <linux-pm+bounces-5624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C958E8914EB
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F931F23152
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52FC4A99C;
	Fri, 29 Mar 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6Ro7Iyp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695142A89;
	Fri, 29 Mar 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699085; cv=none; b=W5z8j+YJEAGMSUziOkpEMi0WA0VbHM4Io+KFhr1f/L04CIn5hrH9DiUU+1CRW+xX7HKwmhFYqP3kYTk/YjNi6HO31DZ7W1pS8hFt7DRwbigR1myhgdqKYx0l1yEUUWduF95tHN1MsWAlqQozltP3X/Ay+XY38hR66MPkp7T2YOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699085; c=relaxed/simple;
	bh=/0ERKwQzbBcB03sGj+BkH3NQoyRfCHwh6GJ4EJSb/CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IteTTMdtt33yvJUZ5vsr5/AqXjCAOTVjTRKiteTbqk2oC5JK2r4msrS72Xiwoai/2ltelwrGRMxH4fkzqEJsds+96QYdEimvjIlXEWu65aTO22opG5sqHAUXRqBxLoLeU2Fmzy0p1+vbPm6rusvBHS4TpsYVTdBN37zaf8FJj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6Ro7Iyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88EAC433A6;
	Fri, 29 Mar 2024 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699085;
	bh=/0ERKwQzbBcB03sGj+BkH3NQoyRfCHwh6GJ4EJSb/CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6Ro7IypfmmWT7+JB6cNSgt06PrnA0g9HQADZagCxBLlztHncSV7w6D4WThSgswst
	 /cEg1NxBMmp/JmhYRSnp1pMsjTMEepimEnC4gLM6i5hDunE+9FThU2Nemev6020fZG
	 FvYHgFezABxppwogbspyV0tRUzxgV6r1zb+gdyrZGGhNunruycYy4zphPgyFWdvXIv
	 6CsMxQKPtVANGXFdlnOae7pCC0ujLvp84US4cghLp8CVfzRtFY9AIlxxgyvYHFSS+E
	 bNgcf/igsA8CEvB2UnIv7BRu8Res/4KuF4JNjH/lw+sErxxaI0qID3tC4Vj62vxwBw
	 lycphMMQ1P1/Q==
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
Subject: [PATCH 18/18] platform/chrome/wilco_ec: core: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:30 +0800
Message-ID: <20240329075630.2069474-19-tzungbi@kernel.org>
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
 drivers/platform/chrome/wilco_ec/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 9b59a1bed286..3e6b6cd81a9b 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/ioport.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/wilco-ec.h>
 #include <linux/platform_device.h>
@@ -150,6 +151,12 @@ static const struct acpi_device_id wilco_ec_acpi_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, wilco_ec_acpi_device_ids);
 
+static const struct platform_device_id wilco_ec_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, wilco_ec_id);
+
 static struct platform_driver wilco_ec_driver = {
 	.driver = {
 		.name = DRV_NAME,
@@ -157,6 +164,7 @@ static struct platform_driver wilco_ec_driver = {
 	},
 	.probe = wilco_ec_probe,
 	.remove_new = wilco_ec_remove,
+	.id_table = wilco_ec_id,
 };
 
 module_platform_driver(wilco_ec_driver);
@@ -165,4 +173,3 @@ MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
 MODULE_AUTHOR("Duncan Laurie <dlaurie@chromium.org>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("ChromeOS Wilco Embedded Controller driver");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


