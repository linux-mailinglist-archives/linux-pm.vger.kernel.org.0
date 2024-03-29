Return-Path: <linux-pm+bounces-5610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B540C8914B3
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66B01C2336F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3F482C2;
	Fri, 29 Mar 2024 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dosEoWd6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F494207A;
	Fri, 29 Mar 2024 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699047; cv=none; b=h1vw4IKH4+nRMEAbYiNJvIuoPq8ghXlR+vI1AORtHl1PH+kBW3m0uoQaAARxOSOVvpluIqsZKjKzB/zgaRq7gGKgbq+Thn5zd7ZvE6BhL4yF90LpZHXvJ3ihtt96fDlFBMWc3e8122X2w/sia94etzfaf3LA7v2sptcGZdfAu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699047; c=relaxed/simple;
	bh=w3WDie7qLPtYs8itn1a7yDwph7TvM2GRvT4tTmDak7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfErylVqPyHDXTVRosieG8fk67bIt6fELIN/4azK+/4Oea+ByWPRKU3CuVSCEnH13UB/vuTXI3ovJZAtYvi3ywTw03LIKm0tETL+5PYzMHsc3vcg5FnhCJBH2MyneDsR9w77vG0WuXECywLctnUwSy35gIeORmWanZUMQUQncXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dosEoWd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED746C433C7;
	Fri, 29 Mar 2024 07:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699046;
	bh=w3WDie7qLPtYs8itn1a7yDwph7TvM2GRvT4tTmDak7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dosEoWd658JBPAMadC3CzDn1Xjxo96AiEVnjtrl15VpVRJ0ZUBSMSLKkki2mV0X3X
	 zaCNYNRDd8TWHBqdfGTneLxGOEKK97xJ32NJZYzD1cYMJEMvTqjnFlXCigqVQRInPX
	 cZt3R9LSyscfKPvUEQRJDiup38C8wjX10w1kCJx/KK1zoJ79Ez842wgP4nVXrrOSt1
	 SX9p7rNFNFcnjWUOBoniCMW/vFesNwPoi3i5IpeY/BnA9+ch9Ch0WteqeFzM1Z87ln
	 jgmAMM/3uuDhbuCbp7L/nfMmyU/nH56VCl4/Gfrpkgnsl1/UTMZ26ci/OrUyJvrQMA
	 1j9ADRx7EENbw==
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
Subject: [PATCH 04/18] platform/chrome: cros_ec_sensorhub: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:16 +0800
Message-ID: <20240329075630.2069474-5-tzungbi@kernel.org>
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
 drivers/platform/chrome/cros_ec_sensorhub.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 31fb8bdaad5a..50cdae67fa32 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -8,6 +8,7 @@
 
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -247,17 +248,23 @@ static SIMPLE_DEV_PM_OPS(cros_ec_sensorhub_pm_ops,
 		cros_ec_sensorhub_suspend,
 		cros_ec_sensorhub_resume);
 
+static const struct platform_device_id cros_ec_sensorhub_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_sensorhub_id);
+
 static struct platform_driver cros_ec_sensorhub_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &cros_ec_sensorhub_pm_ops,
 	},
 	.probe = cros_ec_sensorhub_probe,
+	.id_table = cros_ec_sensorhub_id,
 };
 
 module_platform_driver(cros_ec_sensorhub_driver);
 
-MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
 MODULE_DESCRIPTION("ChromeOS EC MEMS Sensor Hub Driver");
 MODULE_LICENSE("GPL");
-- 
2.44.0.478.gd926399ef9-goog


