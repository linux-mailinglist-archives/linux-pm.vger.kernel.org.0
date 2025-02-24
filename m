Return-Path: <linux-pm+bounces-22844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A60A4309E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 00:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B973AD04D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 23:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D497D20B7F2;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00371EEA4E;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439320; cv=none; b=d7E0qbcDiZXs0FC80wJY4qF28S5ryrmlL8Ww+spOcV0w73Kx9mS3MGln1m/MuRlZqBn+cJIivtMPToWkY70OvQh4KKlACE8gPqZ1llcNzI9e0NLLIk0jiORU/Jq9hTwHzu2Q9OKXnaJUUYXJcKrpZpr+z1AhibZ/1kNVw+cPItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439320; c=relaxed/simple;
	bh=QKY3PTyYmEm+cEdjzXqQF41L9DqH+mU5dbNV5sPtDaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rMacCA1LZafO3afru4GwVj5ThUwVgY5F62QZ+GVEqpFrU7SloH1av6SHabO/sAqXF0HrfxgWG5T1INITjlAGBkkNzB2E4vgaSSuxJLWBT/UhEaulaLSijKdB6xUCJ3I37Lm8+vfNtY3UJ5UJUXnPEy9enznTDE8SxE9/VtQF7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228DAC4CEE6;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 443AD18066E; Tue, 25 Feb 2025 00:21:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 25 Feb 2025 00:21:34 +0100
Subject: [PATCH 1/7] power: supply: core: get rid of of_node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-psy-core-convert-to-fwnode-v1-1-d5e4369936bb@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3060;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=QKY3PTyYmEm+cEdjzXqQF41L9DqH+mU5dbNV5sPtDaM=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBnvP8TOdMot9PQtethDjqEyfHqR6xxTbTQsfBlw
 8mEd4upDXmJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZ7z/EwAKCRDY7tfzyDv6
 mgJ1D/4+BYlcCsk5XiDQ6TjNon6jTYwL6NAwYYW2+Fk77yDPgHAlNcMqIjzTuPInpKddPtoYT/s
 hUJh+DdhYK6iBjffxQ0EX/Sd18zIFgkzKBPnSQYXzr+bJIKTWyK7HclXNEr9yj9slfq1E8Vpsv/
 gJ3dI2WLavtgABq0JTehVeUgDrPNdwGu37il+ttiBHWwAplsHkkkveIQ7ZNSigHCcwz5GFzb1Vv
 nsfK4fOmuqA3XeMwEbxp8KWlxwa2T3zjfv5ujPRYo4BQ9AXetwvVfpSuAzKLdD8HCouQ3XCkFxo
 yK+qYxyyuXC+mi63KkHvguAYOdq8iBxCVq3ZISe/TQaWJBeKjaj6NfjR+4b3f4pscR4SnG0wnXY
 W2B3CSAe2M2MIyKOpkadwT0a9Q+7xZsKyy0oYxSb00LqJ3Iw7CVYNGGW0zB2UZkHizXLjFSan5G
 dvZ8bYd/s1zW49+TeQZmraYfU6KBRYgDMC4j5zuAFV+oGRlBYyT+x1E90mscXmTS95oJc2yLSrV
 If44wTSvpgD+WhS/Rda95i2O7Wo0EAOQdSkUyVwomkEaGoSWUw3EDGsPZLce/J8Db+xXRnXfKkM
 /YQ7mgA3vvAGPUvA7eYJexIYrs3eIwhZ2QqrD2JpBM2DmiT+YXR5Ch5ku+eC49DBiN6SdpYryKa
 Sa2v9AnC39QUBbQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

This removes .of_node from 'struct power_supply', since there
is already a copy in .dev.of_node and there is no need to have
two copies.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 17 ++++++++---------
 include/linux/power_supply.h             |  1 -
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d0bb52a7a0367a8e07787be211691cad14a41a54..11030035da6f121ca76bebf800c06cfd5db57578 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -200,11 +200,11 @@ static int __power_supply_populate_supplied_from(struct power_supply *epsy,
 	int i = 0;
 
 	do {
-		np = of_parse_phandle(psy->of_node, "power-supplies", i++);
+		np = of_parse_phandle(psy->dev.of_node, "power-supplies", i++);
 		if (!np)
 			break;
 
-		if (np == epsy->of_node) {
+		if (np == epsy->dev.of_node) {
 			dev_dbg(&psy->dev, "%s: Found supply : %s\n",
 				psy->desc->name, epsy->desc->name);
 			psy->supplied_from[i-1] = (char *)epsy->desc->name;
@@ -235,7 +235,7 @@ static int  __power_supply_find_supply_from_node(struct power_supply *epsy,
 	struct device_node *np = data;
 
 	/* returning non-zero breaks out of power_supply_for_each_psy loop */
-	if (epsy->of_node == np)
+	if (epsy->dev.of_node == np)
 		return 1;
 
 	return 0;
@@ -270,13 +270,13 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		return 0;
 
 	/* No device node found, nothing to do */
-	if (!psy->of_node)
+	if (!psy->dev.of_node)
 		return 0;
 
 	do {
 		int ret;
 
-		np = of_parse_phandle(psy->of_node, "power-supplies", cnt++);
+		np = of_parse_phandle(psy->dev.of_node, "power-supplies", cnt++);
 		if (!np)
 			break;
 
@@ -606,8 +606,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	const __be32 *list;
 	u32 min_max[2];
 
-	if (psy->of_node) {
-		battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
+	if (psy->dev.of_node) {
+		battery_np = of_parse_phandle(psy->dev.of_node, "monitored-battery", 0);
 		if (!battery_np)
 			return -ENODEV;
 
@@ -1544,9 +1544,8 @@ __power_supply_register(struct device *parent,
 	if (cfg) {
 		dev->groups = cfg->attr_grp;
 		psy->drv_data = cfg->drv_data;
-		psy->of_node =
+		dev->of_node =
 			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
-		dev->of_node = psy->of_node;
 		psy->supplied_to = cfg->supplied_to;
 		psy->num_supplicants = cfg->num_supplicants;
 	}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 6ed53b292162469d7b357734d5589bff18a201d0..975ccab56597ef579ef0c9dc913dcb0a26b5855a 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -316,7 +316,6 @@ struct power_supply {
 
 	char **supplied_from;
 	size_t num_supplies;
-	struct device_node *of_node;
 
 	/* Driver private data */
 	void *drv_data;

-- 
2.47.2


