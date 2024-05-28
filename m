Return-Path: <linux-pm+bounces-8210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45FB8D11DF
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 04:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F629284E3D
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 02:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E6F9DA;
	Tue, 28 May 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVYl4P0+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD17316F;
	Tue, 28 May 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862765; cv=none; b=h3TV12duoNf548ws/1RpCBNeLK5q5IFTOg1DvMEqGJPbZ9gimOtU527kNjnN7dSWc4XPZkViZYcMTbEnI88WY86G77G+0EeHkZoDUDjByc46Rt9xT970ON/2p7YdfKzhaj05lcbIQHBEl/zmY9mNybZwtstU2jRmqLPnIqTZByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862765; c=relaxed/simple;
	bh=FZCY3iTAJh1S9EP9/Qn1j7myPIFxD/sPPvDvlpMXCJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/FpOD2/iHj69z+rJ6JShUWQ9e9AgEEdO+IrVNrgcJvHatv16WVA2jT9i5f6MTcuM4+mRCOcTwESTGjlz1Qm3adb3vIwp3GFa61+DV1WhvZwfbIwGApAFcyGhA7R03aKUUS7SngO5Z7o7Z+3whqQearZJGWWgt5PMq83MLALQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVYl4P0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8DEC32782;
	Tue, 28 May 2024 02:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862765;
	bh=FZCY3iTAJh1S9EP9/Qn1j7myPIFxD/sPPvDvlpMXCJA=;
	h=From:To:Cc:Subject:Date:From;
	b=AVYl4P0+5MoUdEVaX3DZaGdhtiuHl36nHa4jdTM989WFqNA+oNJbUDpyxfrOuSnKu
	 KvTCC6ZlMlXMKjsnTJV/lyFpa5yB3nwGBWOcRBkIqXRSqCGroNbiZ7+kGhatdeSW4E
	 Rs0bIiLBCq1QDVN5KWO0WJJdtv7Ih6qUeuPmFtw8voOjke/S1oBkfdaBMkyVajobGI
	 r1ymUw6ruNcn9hZ8YDayRSy+ksuarb4wv81gG1CNGqrdp+wBzNOmAGO2gHZtko+I/t
	 xCcJzcANSCusONcFHvCTFijCNh0vzT6OAear4tVGm5LI6A+2YBeE48uONzBpFZl6/X
	 l7PkL2BGgywKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/2] power: supply: cros_usbpd: provide ID table for avoiding fallback match
Date: Mon, 27 May 2024 22:19:20 -0400
Message-ID: <20240528021921.3905481-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit 0f8678c34cbfdc63569a9b0ede1fe235ec6ec693 ]

Instead of using fallback driver name match, provide ID table[1] for the
primary match.

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353

Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://lore.kernel.org/r/20240401030052.2887845-4-tzungbi@kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/cros_usbpd-charger.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 0a4f02e4ae7ba..d7ee1eb9ca880 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2014 - 2018 Google, Inc
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -711,16 +712,22 @@ static int cros_usbpd_charger_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cros_usbpd_charger_pm_ops, NULL,
 			 cros_usbpd_charger_resume);
 
+static const struct platform_device_id cros_usbpd_charger_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_usbpd_charger_id);
+
 static struct platform_driver cros_usbpd_charger_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &cros_usbpd_charger_pm_ops,
 	},
-	.probe = cros_usbpd_charger_probe
+	.probe = cros_usbpd_charger_probe,
+	.id_table = cros_usbpd_charger_id,
 };
 
 module_platform_driver(cros_usbpd_charger_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ChromeOS EC USBPD charger");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.43.0


