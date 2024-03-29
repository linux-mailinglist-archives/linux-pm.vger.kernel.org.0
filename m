Return-Path: <linux-pm+bounces-5609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD498914AF
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FC32881DE
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1F444C85;
	Fri, 29 Mar 2024 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEh8Iftz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4447F6B;
	Fri, 29 Mar 2024 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699043; cv=none; b=f8LYeOmbXPHbgNWnh0kHuUupzz2S0Jn0Mi0rswfhZRbkT8vhIaADdtUMdRykOv/1g3BoZ9jYVgSgRh4U+Agx2Lp+qixCc4Rj4ua5TpRTYRyXMrD1tKXmUOGAQbohbZwPKphEpxbkiKEjkJey6gPkOLFI1A2nYqb4YEEpz4JlEMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699043; c=relaxed/simple;
	bh=xytDYpuJuP97x2NJwYryd3hBs9cZP32C1tuDo6lNnCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkYtvZ5U9ap3SKO+jxQCwR5F9TvEv/kkEHaef4BOZOW0Tbeim3k7huPziLbrx+smwORd4ynYY1jTifYZKbXevpp/YEQjWRVP+6ED7E+XHma+ym2ums0CksT6Dam0xUu9U6UrRzIhSC339FmlRpFMzXMYTEt+Q1hhlYHgezgLDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEh8Iftz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3483DC43394;
	Fri, 29 Mar 2024 07:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699043;
	bh=xytDYpuJuP97x2NJwYryd3hBs9cZP32C1tuDo6lNnCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OEh8IftzEnkGCe0GsGZofX85ARuQQ05ZWeRlb+6dp5DGjyeGGPq55ITUputUB+Mx/
	 DmS9WqunINKr+DehB3hzsmj3Z5oYaczmCtwO7aJoh0J/2ulMiEzchYyKSsjgxytDS6
	 Vics/arAvLb2SSMw9AgjsKVO8NnySl/NmZ781obPTuuy0PqxirVlBSTLAoEqRmaJ9/
	 3k/roWuXyTZFZlzT95xbXK/GuwR6rTtazDPkWvDjNA9lb/DBjXnCcOLOVTPf3eZcKW
	 B9UE0A2vvs9fqSJFYWtGcknvz4lTLyDpq5PReS5E0CScOl90iJJv+ov+gm8RyQbwoo
	 AKUUUkrS8wIYw==
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
Subject: [PATCH 03/18] rtc: cros-ec: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:15 +0800
Message-ID: <20240329075630.2069474-4-tzungbi@kernel.org>
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
 drivers/rtc/rtc-cros-ec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index 0cd397c04ff0..f57462c7b2c6 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -5,6 +5,7 @@
 // Author: Stephen Barber <smbarber@chromium.org>
 
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -392,6 +393,12 @@ static void cros_ec_rtc_remove(struct platform_device *pdev)
 		dev_err(dev, "failed to unregister notifier\n");
 }
 
+static const struct platform_device_id cros_ec_rtc_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_rtc_id);
+
 static struct platform_driver cros_ec_rtc_driver = {
 	.probe = cros_ec_rtc_probe,
 	.remove_new = cros_ec_rtc_remove,
@@ -399,6 +406,7 @@ static struct platform_driver cros_ec_rtc_driver = {
 		.name = DRV_NAME,
 		.pm = &cros_ec_rtc_pm_ops,
 	},
+	.id_table = cros_ec_rtc_id,
 };
 
 module_platform_driver(cros_ec_rtc_driver);
@@ -406,4 +414,3 @@ module_platform_driver(cros_ec_rtc_driver);
 MODULE_DESCRIPTION("RTC driver for Chrome OS ECs");
 MODULE_AUTHOR("Stephen Barber <smbarber@chromium.org>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


