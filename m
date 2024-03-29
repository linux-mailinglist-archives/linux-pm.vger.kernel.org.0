Return-Path: <linux-pm+bounces-5612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0305E8914BA
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29F028833B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8EB4AEED;
	Fri, 29 Mar 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKZK8dYf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B14087D;
	Fri, 29 Mar 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699052; cv=none; b=UFiioGBcrh7gKn0d11R3rhmguns0u6ZJz5/DwTGuQP3YAvZaZ2I6FrO8zW31Bfk/IG/1GDmyVBz5sNNFDZCMnMqQQtuf9Ci8jsqbdCh9FpSSKtT16LZu8AyelUelDrLlNB2N5w103KjEU9JeOwKtwaaHdmONmq26tEJBlc0MAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699052; c=relaxed/simple;
	bh=czC94b4Twsr7/x4CY2fDtnSsNR3c5nsq3qe0GMVI8mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qrn7yU3+8x26/Xp8O7/fscfNJZKGmETu+j3TTQipauXzRKSAmHyalaRKh+wQ3Zhp4474dDZEgXsRv+lNEb9H0LCbFFryQ7wAFDS1vZBmm5pGdjy6LiIjJbI2vwVT01ldX6B2kUlNjCU6Crltjwm+f/LK2nMpMbjbBUlarBfoQlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKZK8dYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8248FC433A6;
	Fri, 29 Mar 2024 07:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699052;
	bh=czC94b4Twsr7/x4CY2fDtnSsNR3c5nsq3qe0GMVI8mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKZK8dYfV7Rh+EyDYPTDY5PO8mGM2jximwTKmYff7/vsQW43r/7h6cGUYITHBJHSO
	 cS0NZGuGiVU6bepokvFCLyOec826KuzMniBsrlkCsw5mkA0FEv3nwq7Jh6RrPob4Bk
	 XOy7VN3DO3312H278PmiRPAKHXbNOU+kSTa3unWYMReHVYLIjR3cAlZ0PX6sPmPLvn
	 BujOwT5jE3DycxoNvd+Bf4rusAUQIfE9EoJP+a1KVvQ7SJek/TmXEnWTuY5ZXKkB5m
	 MLsFxHK2X5pe1+zbJNU6ypQhFEeyfc9ah79jzPryPL4Syw7E0qsS7OaeU0lPemEj85
	 ahGWETmbPfw9w==
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
Subject: [PATCH 06/18] platform/chrome: cros_usbpd_logger: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:18 +0800
Message-ID: <20240329075630.2069474-7-tzungbi@kernel.org>
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
 drivers/platform/chrome/cros_usbpd_logger.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index f618757f8b32..930c2f47269f 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -7,6 +7,7 @@
 
 #include <linux/ktime.h>
 #include <linux/math64.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -249,6 +250,12 @@ static int __maybe_unused cros_usbpd_logger_suspend(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cros_usbpd_logger_pm_ops, cros_usbpd_logger_suspend,
 			 cros_usbpd_logger_resume);
 
+static const struct platform_device_id cros_usbpd_logger_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_usbpd_logger_id);
+
 static struct platform_driver cros_usbpd_logger_driver = {
 	.driver = {
 		.name = DRV_NAME,
@@ -256,10 +263,10 @@ static struct platform_driver cros_usbpd_logger_driver = {
 	},
 	.probe = cros_usbpd_logger_probe,
 	.remove_new = cros_usbpd_logger_remove,
+	.id_table = cros_usbpd_logger_id,
 };
 
 module_platform_driver(cros_usbpd_logger_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Logging driver for ChromeOS EC USBPD Charger.");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


