Return-Path: <linux-pm+bounces-5619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA58914D8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A66B219DD
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E5A52F8C;
	Fri, 29 Mar 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qf7ugtGc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546147F48;
	Fri, 29 Mar 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699072; cv=none; b=fedXY0qkCQxBcP2ia9OhOTwJ0KHePVJG2WzMGbyormWmhpJr1+vPqdVT6N6xjaom2rfNF8vMaJjhXhcswxP4sfbaTMCwGTH7jaeYTorlZcf+brWvg66Fu9e3e5DwJR4Jsdk+FErWYbOLp8k34tCLtEqYNsYuIBd8PKPQSQDApQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699072; c=relaxed/simple;
	bh=4e4mdaC9+ut9ho/8Cbu6zu6HdmLrwy31JPW9A85whXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDIHyz3Em9McEBDTOg9SUToPUdjgHW/aiEsaJMmS9NX3gx8c2oMekp6ZJL9JpE1qLExI5PQvxxLEp8EvW3SzXWM2TTHm8YoMqK3X+VYXfjpHz4yV0LscGQq7DYlmeSHaTIjmaCFv1Ff9KLowMZSq76gF8Mdn+++O+dJilKC4MX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qf7ugtGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061B2C43390;
	Fri, 29 Mar 2024 07:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699071;
	bh=4e4mdaC9+ut9ho/8Cbu6zu6HdmLrwy31JPW9A85whXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qf7ugtGcSXi7b6itGxoljjpdciz+grtZPYJTpnDg19QfoFkX83p45SJBRxQI64aEr
	 AlAHdBslS/zFwGzC3Kvpnvsm3l8JBZz74xwdF6tuRCEfqb7VHiuAt37wjnYEjGXblr
	 4g5+pDQwdwuWrMs3Wlm20Lh/FQTk6arbWYJq2y31Qi7p9U2M3yc275hlppDqWAHvz9
	 2ex/Qu++fw50q6NPAt+2fA9oHM0bQfNZ/NSTFhe5BbokERNwMWB3Um0i8MsLt0ga7U
	 fYRJo8zhUl3VR5/DgDrfTNtWYW4wcZ7o8G0lqLzO+9J28GpQOeIYPkeMhiYakwYnSk
	 u6+Wi4ml0FnIg==
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
Subject: [PATCH 13/18] platform/chrome: cros_ec_vbc: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:25 +0800
Message-ID: <20240329075630.2069474-14-tzungbi@kernel.org>
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
 drivers/platform/chrome/cros_ec_vbc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index 274ea0c64b33..787a19db4911 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -6,6 +6,7 @@
 
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -133,16 +134,22 @@ static void cros_ec_vbc_remove(struct platform_device *pd)
 			   &cros_ec_vbc_attr_group);
 }
 
+static const struct platform_device_id cros_ec_vbc_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_vbc_id);
+
 static struct platform_driver cros_ec_vbc_driver = {
 	.driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_ec_vbc_probe,
 	.remove_new = cros_ec_vbc_remove,
+	.id_table = cros_ec_vbc_id,
 };
 
 module_platform_driver(cros_ec_vbc_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Expose the vboot context nvram to userspace");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.44.0.478.gd926399ef9-goog


