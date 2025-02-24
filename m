Return-Path: <linux-pm+bounces-22848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E55CA430B0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 00:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3583B8110
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F005220E6E4;
	Mon, 24 Feb 2025 23:22:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5720E31E;
	Mon, 24 Feb 2025 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439322; cv=none; b=AawfaYTTBLfW9rA+WmRON8SjBxy9mFgxF0MC4f7E33b+ot4atBCjx1eDttkR3YPEzE8BCGPqcpZvjDKGNdgmyu5zst4Fj7FppEf3NOSlmGDKi4deOgDI2Di0SKipiQCVzGg9NJBkLPO2zNWlKv9j6zlx10ZJqksk+X0uBkztS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439322; c=relaxed/simple;
	bh=511brLxdmW1LmKJ2YEH7hXNc3fca9+EzIlpO7BItZAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgRX4zf1TMCaWN7MthRs4txbITtO8Wf2GbisMXm6UlFGDNwAySm1lNz/Dqwn67NXjvr48TYKxGNKUbI3JS3yCcrLjz/jDKmdIAxnajmR1AvvCmbrMryLsF9dC0/wfG5I5SsQcEwL57nOD6W3qmbp0uSFqg728JEMoJs++a5RZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41024C4CEEF;
	Mon, 24 Feb 2025 23:22:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 4C9DF18067D; Tue, 25 Feb 2025 00:21:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 25 Feb 2025 00:21:38 +0100
Subject: [PATCH 5/7] power: supply: core: remove of_node from
 power_supply_config
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-psy-core-convert-to-fwnode-v1-5-d5e4369936bb@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=511brLxdmW1LmKJ2YEH7hXNc3fca9+EzIlpO7BItZAM=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBnvP8VHH3zVpqr2x6FqT/EUtdHjjGEDOfvsYOf/
 449y0YhxYWJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZ7z/FQAKCRDY7tfzyDv6
 msflD/9zp4jHuSncqxBwwfyBiowNkH4qjozD3duNH/lddjXP3Bz6FOuhNq2IErX2bDICSE6eaUL
 OsyVRlYYLhj19hD4j9t0nxcul9NQqMGKBaD6oTcR6Ug1tZmR3SBWF5dfOYM4fDhlq80ZiLoWmGi
 8v5iigmnWwP2zFt35yeJ+tM3BNAD4SgPvcpY4YL2D76oiLATP2iyW/QrSweecSPtM69+3OzK5Qs
 7oaSu2B72IFbRa9SxNuCPkwtNuDxsDWgNrpLCn6yIr1DgDtUYIT6T+duLSKwsLJyGxXxA6d0b0f
 ZDL8Sbn4dkkKSGcHLmMJreFysEKsx3fWw4/wAfP6h28ILufrvirl4xlYBE1SHv0Z7VuZ7xJqnsb
 NBF4BAG4OS3wzuiK1z9/W5FNZZ0d65hCI6QocaoITcT8gBCW8umHpFtFLR6b2yw1RHA80J+1A3p
 IgEbvUYCmgvPL9tCApqvpdkAkby9B+PlnaVoguQQZHKA3MRqg3ajboLtuB1s7vO6m9qDRn4+UUT
 lWIiN66XVEJOuPI7L9ubb5g2gb3fNWjFklHwONqWbJ04kDVkN6+TXlsVN/IB5dp9h0BjgVbN8vo
 rk867bG08JullRP6G5qAeZDBHSsXqfqAW64e/opyICsWLqNvJHt8Fu4figcDtRfss5kk+4PNmph
 j87sZSCAsKEnQjA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

All drivers have been migrated from .of_node to .fwnode,
so let's kill the former.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 3 +--
 include/linux/power_supply.h             | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 11030035da6f121ca76bebf800c06cfd5db57578..c43539ea1318506ada0a6fcbcdbf7ece253f5257 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1542,10 +1542,9 @@ __power_supply_register(struct device *parent,
 	dev_set_drvdata(dev, psy);
 	psy->desc = desc;
 	if (cfg) {
+		device_set_node(dev, cfg->fwnode);
 		dev->groups = cfg->attr_grp;
 		psy->drv_data = cfg->drv_data;
-		dev->of_node =
-			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
 		psy->supplied_to = cfg->supplied_to;
 		psy->num_supplicants = cfg->num_supplicants;
 	}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 975ccab56597ef579ef0c9dc913dcb0a26b5855a..a785742f97721e7e70d0e4c17a1ded7b985acb6d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -229,7 +229,6 @@ struct power_supply;
 
 /* Run-time specific power supply configuration */
 struct power_supply_config {
-	struct device_node *of_node;
 	struct fwnode_handle *fwnode;
 
 	/* Driver private data */

-- 
2.47.2


