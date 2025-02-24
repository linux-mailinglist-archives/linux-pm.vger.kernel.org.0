Return-Path: <linux-pm+bounces-22842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342ACA4309C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 00:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF4617AF8B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04EC20B213;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE0101F2;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439320; cv=none; b=YiMB/h1QF1zlmUf2sVIgLeWgS0aX9HCl7t5ZpA6DbpPguRAGWKqs5Zg3jwkq1vZdv0+Z486eyA2hdcghSqEnSCboWhNa50MNpwZrCYLSgud2/vWH7KwSV0IJ6IUTL3daY09Q1wVpSIpVHX6TtHT05XWGcVa+8m/gy0cac8LXLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439320; c=relaxed/simple;
	bh=z6RCFb2/vB/uPI6y66W4S0l3zN9napepWbci1XWwVNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3z1nQHBA+OaOTPCu1iu4uCfg2EkXA9QaZVWlG5pfCBD4coBSOUln+Xicr0K2eqrMfalrAlynodHExUyqB4viFW6N6rC61vDLt4sHWEzxbuP2S2P1yRSK8zlkDVcofuWoVp/n5InIaN0JH4oWgpHgnC1EtMWYaxQf5kDmOFTIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE11C4CED6;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 470D218066F; Tue, 25 Feb 2025 00:21:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 25 Feb 2025 00:21:35 +0100
Subject: [PATCH 2/7] regulator: act8865-regulator: switch psy_cfg from
 of_node to fwnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-psy-core-convert-to-fwnode-v1-2-d5e4369936bb@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=z6RCFb2/vB/uPI6y66W4S0l3zN9napepWbci1XWwVNA=;
 b=kA0DAAoB2O7X88g7+poByyZiAGe8/xSimcaazLXGcNG/1mTR16VIq9X7i+gMf3F5pKIfBdrFE
 4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJnvP8UAAoJENju1/PIO/qafVQP/11l
 j3+tzVXJQejIIWqovbTDKhcu5evCd64HmFmMcW/lxU7NGcV9hWKXIcrO7Vc/VWSFALTqK0vUA4L
 X/BPijrawRPWY5a5KZLd39MjVcApUCSZpDLcL9Qyb7maxy0Yu0KkR9znpYQtDl/BGcNcTowxPmt
 wxW75zdKnSbEnG06VR8OHwIBb/QcpYS8aiLV2WL36yQRGZfdpXOmeTLOII82zVI+CFYZX8pNhb7
 z7pHK74GC6Ec6RJ3hJJfCNLUbpFlwNdL+yMb2361EazgpKHXpmzv6mRA2EcB1qtKCgglogQ85HI
 ywvbZ2Fac/wmgvz9Bmn9hyQLMEhpL7gInMMluFZERAQQ0qYH4TugA09hHhAK9XsTFnVrLsD/lsC
 JRbIKqLR6uRRrsqEdqlTM+4YZBG0/7WlrSIgi94WiRDsbn+dKWp3u9En1YHhGJJI9B3kkhdubRg
 +aNOHqVbc3o7BX4m2T/X0svguaoFbaTF3/KCfdisxSvR1Y4eWzQ+ek4yql2FVBjgnLQAra0pW3B
 4FptwcIRqre30P4uAErYuqZGI8pliU/cn2OWfZ0f+m8SiUIamfFNkRiK0Fa+PZhLuMq8wiN04cJ
 HuuDNxsCoqByr0DotSzNt9i8FdjyLHtDGLuN0gADzgu7h2hqnKGg2A6ZfvilZeJbPSkA4UcJhMM
 9naKi
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


