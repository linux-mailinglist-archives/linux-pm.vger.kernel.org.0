Return-Path: <linux-pm+bounces-22846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA1AA430A0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 00:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB0818983A3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 23:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124A520C02C;
	Mon, 24 Feb 2025 23:22:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24B20969D;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439320; cv=none; b=sTTMI23F5eUcQbdtyjyAqkN3Fr7ErfhGPOzdNkrmMNtYA0bUHXqsvqYxk3hnspk6bZ0lbFmstILR3YDsBhgqR3dx4pUPfTyGdE4YDG9zdT+Zv4inGpMzwRMfp2slOLHBt9CzQQ0//NXE/2Q6UoL7i9YLsIFXIPA7xt/2jRaZAC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439320; c=relaxed/simple;
	bh=uzPXWIS9wiOW79/JSZO2CHjg9YrfY89iBDn3F99mMoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPN99AhXWsPiw21clwrlPnHJVVE4Q0wTWBfakMlRHDhk0R8+g31RKcV46T3xxLALjiAM4jnZsEdhzIlPLdOezTRPUG704Po4wzUuO9/hHR+F+SY2nMVxhIKo2JGw/OvE15iNo8AKnG+zqPm9ycIX41+oG+gA+laqbYzYVr4mFXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57039C4CEEA;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 48EC2180670; Tue, 25 Feb 2025 00:21:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 25 Feb 2025 00:21:36 +0100
Subject: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, Samuel Holland <samuel@sholland.org>, 
 David Lechner <david@lechnology.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=uzPXWIS9wiOW79/JSZO2CHjg9YrfY89iBDn3F99mMoA=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBnvP8UYJ+0B3ptqT3rXwREAooFmD/swymICio8W
 pnPXcJgGfCJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZ7z/FAAKCRDY7tfzyDv6
 mhDbD/wPcjHYHqB7mWdnW0pSNyWcUXdbmSEDURYINy7zI99wrkA/LWWxAFFYRbfTt2W3TN81jDg
 +gIkNHV5UvwYKZexxSpNauGWbL8+nNAMbydAmAscz3cVVIytG2cvlnrjdJUVinzZkC8f0FnsKXS
 KslyWepD9DXE/luVAEuoKLB4rmnjw0cmHqHhMiquMBzxIEsoL+j+cnzehZBhdGJqcAvjdaMingD
 6Xj4wybnES19QVzcW5fTMVS5VOjqoeJpKMc4ao+Fy7zcrAimxo8Yw/uLIMHgPNVwb8ckXDt7Chs
 rZZQ4muc0MgVgt5+FflH9CVmTQRxRxrGYhuE2MWm0bnC8xVGzHAdxPCBmavimApX45L6AYiT7ld
 7hFAB5UA58VHqSmgHyG1vyvH2/Hewbf0SIwmTFHAoTzmCionvtAJiPg2kp4uzLH2Y7xm50+R9nW
 t88nwfk7ht9SipZt2G0Wi/Jmg3b6z94oNTFus0sSYr6QTtgMnxZghX3K6BmOUDyizaJkcDOyxvn
 Xmsww8Oox+9z7uMHzA4iPWLdypB7gZts/19/JBs0BStW6rJx2iN/jqVxjypGVNQpp/52ipVESt5
 tBmz1K0AtGNPgWlA55B8K9sLKJS7zL/Bzq3OZeXqMzrSE3Gj5ZCsBhOGaiUA1C54EfmogjtGZbr
 qxREWTr8WxmDiTg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

In order to remove .of_node from the power_supply_config struct,
use .fwnode instead.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/usb/common/usb-conn-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index aa710b50791b0282be0a6a26cffdd981b794acaa..1e36be2a28fd5ca5e1495b7923e4d3e25d7cedef 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -158,7 +158,7 @@ static int usb_conn_psy_register(struct usb_conn_info *info)
 	struct device *dev = info->dev;
 	struct power_supply_desc *desc = &info->desc;
 	struct power_supply_config cfg = {
-		.of_node = dev->of_node,
+		.fwnode = dev_fwnode(dev),
 	};
 
 	desc->name = "usb-charger";

-- 
2.47.2


