Return-Path: <linux-pm+bounces-26397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93139AA3BC3
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 00:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1851B6857C
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDCF2BCF75;
	Tue, 29 Apr 2025 22:55:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D02729E077;
	Tue, 29 Apr 2025 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967308; cv=none; b=M8os08ujbhGZ6QIyiReLDs7ZN4frXQ8kvAQHVwU9rp6LGyE2hdaPiobZX+Tc3i19eOhS8i5yztZV+Br9IMBao5A9KkmZ6XSQBWlYGshyju4Zvyeb0VFRcoeY8O1G9k6mrniIiknIC57SCbJPZtGqlmnWegYyE3BeYV9yz50FXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967308; c=relaxed/simple;
	bh=z6RCFb2/vB/uPI6y66W4S0l3zN9napepWbci1XWwVNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=awa0GMFDaL7LRYBzduXNwy+n/oQPkqOVjraV1xgJ01+zZkwq+MbTMajPceIPhbp3NO4TTeQ8CPeZhy6CYigJMYldBTWWDsSmOHEos8TBZ9gabzABobL/Z6zkU43BNlwWWSkUykkuQhenJsvdo/joS9ymv2r4mmWMynBH4Ed6mg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B68C4AF0C;
	Tue, 29 Apr 2025 22:55:07 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 996A9180D29; Wed, 30 Apr 2025 00:55:05 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 30 Apr 2025 00:54:23 +0200
Subject: [PATCH v2 1/5] regulator: act8865-regulator: switch psy_cfg from
 of_node to fwnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-psy-core-convert-to-fwnode-v2-1-f9643b958677@collabora.com>
References: <20250430-psy-core-convert-to-fwnode-v2-0-f9643b958677@collabora.com>
In-Reply-To: <20250430-psy-core-convert-to-fwnode-v2-0-f9643b958677@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-phy@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=z6RCFb2/vB/uPI6y66W4S0l3zN9napepWbci1XWwVNA=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBoEVjHDxq9L2bIbtg8Ask+9Zi5ANVFY3lYCI4aQ
 1JyhAehH1mJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaBFYxwAKCRDY7tfzyDv6
 mjzDD/wOGjU5SJQHiuXe/cZCCPiDYMgcjvExrnrRPHAsmfQ8cA56gJqkfcj22CNOu04ye4imlhi
 yUknuYuBnQa1uK65tN0iWjEWkdMjQoapGiAOdjyc1CItMevOZ+LEXb5t6OVn1Jd4pM2QJfL3ITx
 +v1G8aXTtwnwewtK1FXzlGB8tvQAYiucZ5/luThafwsWgkQcGA5gB4ie74ISTSKR7b68bwwBQdk
 ho/W+nyVJGcmJxN7pc2P6YhXLArH9v/5xPfR4rb6q8lI+eN4HVHwAeuqxsF4/JC54F7Yz+B8VPJ
 Zg9Py/7RnrqoHvqu45i0/xJOiSsuLArj/PwZjKHLU8Oy6p5Syff0diY41bI9WgHxL4mmKyJaqGO
 801NMGkeYzbp3zWU42RGDEMpoIuttu2wPGWCN3mUtG64Qa4HVTParjzQWbMSVRcwOv5SNZmea8P
 o70TPGBPoAkvhhzwvRD/ZqXFAOVeEMtiaXZAabNCT2ArJsGwF14GyUaTTcsSKCu3X9nI3JOU9Jq
 RA5Cg1FqJDdTLzBMmJhJr9RXsXa+zmC1a9eR7KV9oDZajKQqWt4BN0JlPVf/NcUbCIQdT+F/dvx
 FlX6e7P4bJ85YDuKHUF6/5hE4carsmjdi6jZQ4QoXMNduuXw97fAvcY/efVaRTvfUiGEmwHmsVK
 cNdFp9Tw6gpu91A==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

In order to remove .of_node from the power_supply_config struct,
use .fwnode instead.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/regulator/act8865-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 0457af23c55acdd97b2cdc6fd6bfd07ae0f9d11f..b2a6ddc6f56d32e8758977e25858b972e294bc84 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -643,7 +643,7 @@ static int act8600_charger_probe(struct device *dev, struct regmap *regmap)
 	struct power_supply *charger;
 	struct power_supply_config cfg = {
 		.drv_data = regmap,
-		.of_node = dev->of_node,
+		.fwnode = dev_fwnode(dev),
 	};
 
 	charger = devm_power_supply_register(dev, &act8600_charger_desc, &cfg);

-- 
2.47.2


