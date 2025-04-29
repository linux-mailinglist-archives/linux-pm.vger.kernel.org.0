Return-Path: <linux-pm+bounces-26401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7A5AA3BC7
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 00:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDA41B685CF
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303742BD581;
	Tue, 29 Apr 2025 22:55:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1782BCF49;
	Tue, 29 Apr 2025 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967308; cv=none; b=FR6NO2Ye8s2BtU/7RhdIGZAKrwBq6wtqJMpO5upSECMgSK6UfjQ/JwVfQLTyzkL9/FTaJ2iR5XHdv4Jj3bXQaTDCmMAEGAjYhr4fnx+C0qL33ljleXv2SQXuY8tl0+B0RaFP0g2ZhycxMaKFimUbx8LoUVbl3POr47bOzF8v3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967308; c=relaxed/simple;
	bh=Mf87Q1NReuMQ6nVtcCiED6x4UVx35A/lYEh1WPwLGFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQzeYndM2liUbqthFvGWNsqhWYNNkkzi1J984h1/imemNSgon2nyvFFJrcuMmlIlGRU5fDEk8YkSZg4WoFXLCOBU1PlmyzfIsjqYxII4yWTQoW2H3qOliv6B7Qif5+6C2sCRZrDxCSi4/rQggl9lSi/EgUWr5wJ/Hn84NIb4bxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A81C4CEEB;
	Tue, 29 Apr 2025 22:55:07 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 9D038180F47; Wed, 30 Apr 2025 00:55:05 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 30 Apr 2025 00:54:25 +0200
Subject: [PATCH v2 3/5] power: supply: core: battery-info: fully switch to
 fwnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-psy-core-convert-to-fwnode-v2-3-f9643b958677@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6475;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Mf87Q1NReuMQ6nVtcCiED6x4UVx35A/lYEh1WPwLGFU=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBoEVjIOugsWPH+KGkWoWwpex9riQL9D4JLnyjIH
 IWHyBHJJuiJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaBFYyAAKCRDY7tfzyDv6
 mtw3D/0XUhTBR6T3+jZ0aKBb3VfbUVGOz+ZCjiSo5lXG9hMTOt9FBudCKBWrZ8IxKuY+PWa2O1i
 OVX2M5zA7qpDB8k4X59SAkQejzXXtvQ0epB7qkE8tnYll9YmSNSQ1d4oHxa8wdKmayzKgBpvthC
 w8j9yP56g+Dl1efyxPB3dKMefceLD+p/6UUwCNVJ+RVWVEeGp19ip6Z293bjCAerJ1JgDDvzcaZ
 zSaXk9Asq903PZ49E9xiqQZ7q1Lo30BVn1f0sfiaaj3Pltda9KkgE+BsTsJchZJOm5PlQC8VpIQ
 8lkkHcndU1Dvj9gB34PeJzmNoLR0qiaIx8ETUiiWLD6anClYrYvE5du/jfDQAl/gEFgQRUEJ2kM
 jpCikhaSt34qo3h1m+cT5c2Q2gkCRp09zTLOzj85iDGlFRJ+9LRZcsbtNb8NJLICYI27RSZ7NlB
 lTFMxtB7d9eYjo4axES9Bjk13UCiHZJ0bRKgYasdPopI9vza5UMII5e7EyTMWyfy4hkKNipJ9Xf
 6NVBkgkw1vNziKyyd4Us3Bey8PxSHNV9D/d7vKxAnDQlwAWw+iNH2ivDbY9sbT7OYbt57f1VAaQ
 BdmfiLp/FBikYeiRqWgOnz0CDaxdcBtkO93HEhPRFZfSpdw0MNpP4OJ60XZOvqje6Xb7dR06ji8
 aIK0mnByuj9C2rA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Also use fwnode based parsing for "ocv-capacity-celsius" and
"resistance-temp-table", so that any DT specific bits are
removed from the power-supply core.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 109 ++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 46 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 89947f1fe610d8a75756e1e4e5339b06349f9ab8..a8d1fe66e2486a833ccaa3ed77b861c6e52c5760 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -585,32 +585,19 @@ int power_supply_get_battery_info(struct power_supply *psy,
 {
 	struct power_supply_resistance_temp_table *resist_table;
 	struct power_supply_battery_info *info;
-	struct device_node *battery_np = NULL;
-	struct fwnode_reference_args args;
-	struct fwnode_handle *fwnode = NULL;
+	struct fwnode_handle *srcnode, *fwnode;
 	const char *value;
-	int err, len, index;
-	const __be32 *list;
+	int err, len, index, proplen;
+	u32 *propdata;
 	u32 min_max[2];
 
-	if (psy->dev.of_node) {
-		battery_np = of_parse_phandle(psy->dev.of_node, "monitored-battery", 0);
-		if (!battery_np)
-			return -ENODEV;
+	srcnode = dev_fwnode(&psy->dev);
+	if (!srcnode && psy->dev.parent)
+		srcnode = dev_fwnode(psy->dev.parent);
 
-		fwnode = fwnode_handle_get(of_fwnode_handle(battery_np));
-	} else if (psy->dev.parent) {
-		err = fwnode_property_get_reference_args(
-					dev_fwnode(psy->dev.parent),
-					"monitored-battery", NULL, 0, 0, &args);
-		if (err)
-			return err;
-
-		fwnode = args.fwnode;
-	}
-
-	if (!fwnode)
-		return -ENOENT;
+	fwnode = fwnode_find_reference(srcnode, "monitored-battery", 0);
+	if (IS_ERR(fwnode))
+		return PTR_ERR(fwnode);
 
 	err = fwnode_property_read_string(fwnode, "compatible", &value);
 	if (err)
@@ -740,15 +727,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		info->temp_max = min_max[1];
 	}
 
-	/*
-	 * The below code uses raw of-data parsing to parse
-	 * /schemas/types.yaml#/definitions/uint32-matrix
-	 * data, so for now this is only support with of.
-	 */
-	if (!battery_np)
-		goto out_ret_pointer;
-
-	len = of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
+	len = fwnode_property_count_u32(fwnode, "ocv-capacity-celsius");
 	if (len < 0 && len != -EINVAL) {
 		err = len;
 		goto out_put_node;
@@ -757,13 +736,13 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		err = -EINVAL;
 		goto out_put_node;
 	} else if (len > 0) {
-		of_property_read_u32_array(battery_np, "ocv-capacity-celsius",
+		fwnode_property_read_u32_array(fwnode, "ocv-capacity-celsius",
 					   info->ocv_temp, len);
 	}
 
 	for (index = 0; index < len; index++) {
 		struct power_supply_battery_ocv_table *table;
-		int i, tab_len, size;
+		int i, tab_len;
 
 		char *propname __free(kfree) = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d",
 							 index);
@@ -772,60 +751,98 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			err = -ENOMEM;
 			goto out_put_node;
 		}
-		list = of_get_property(battery_np, propname, &size);
-		if (!list || !size) {
+		proplen = fwnode_property_count_u32(fwnode, propname);
+		if (proplen < 0 || proplen % 2 != 0) {
 			dev_err(&psy->dev, "failed to get %s\n", propname);
 			power_supply_put_battery_info(psy, info);
 			err = -EINVAL;
 			goto out_put_node;
 		}
+		propdata = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
+		if (!propdata) {
+			kfree(propname);
+			power_supply_put_battery_info(psy, info);
+			err = -EINVAL;
+			goto out_put_node;
+		}
+		err = fwnode_property_read_u32_array(fwnode, propname, propdata, proplen);
+		if (err < 0) {
+			dev_err(&psy->dev, "failed to get %s\n", propname);
+			kfree(propname);
+			kfree(propdata);
+			power_supply_put_battery_info(psy, info);
+			goto out_put_node;
+		}
 
-		tab_len = size / (2 * sizeof(__be32));
+		tab_len = proplen / 2;
 		info->ocv_table_size[index] = tab_len;
 
 		info->ocv_table[index] = table =
 			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
 		if (!info->ocv_table[index]) {
+			kfree(propdata);
 			power_supply_put_battery_info(psy, info);
 			err = -ENOMEM;
 			goto out_put_node;
 		}
 
 		for (i = 0; i < tab_len; i++) {
-			table[i].ocv = be32_to_cpu(*list);
-			list++;
-			table[i].capacity = be32_to_cpu(*list);
-			list++;
+			table[i].ocv = propdata[i*2];
+			table[i].capacity = propdata[i*2+1];
 		}
+
+		kfree(propdata);
 	}
 
-	list = of_get_property(battery_np, "resistance-temp-table", &len);
-	if (!list || !len)
+	proplen = fwnode_property_count_u32(fwnode, "resistance-temp-table");
+	if (proplen < 0 || proplen % 2 != 0) {
+		power_supply_put_battery_info(psy, info);
+		err = -ENOMEM;
 		goto out_ret_pointer;
+	} else if (proplen == 0) {
+		goto out_ret_pointer;
+	}
 
-	info->resist_table_size = len / (2 * sizeof(__be32));
+	propdata = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
+	if (!propdata) {
+		power_supply_put_battery_info(psy, info);
+		err = -ENOMEM;
+		goto out_ret_pointer;
+	}
+
+	err = fwnode_property_read_u32_array(fwnode, "resistance-temp-table",
+					     propdata, proplen);
+	if (err < 0) {
+		kfree(propdata);
+		power_supply_put_battery_info(psy, info);
+		goto out_put_node;
+	}
+
+	info->resist_table_size = proplen / 2;
 	info->resist_table = resist_table = devm_kcalloc(&psy->dev,
 							 info->resist_table_size,
 							 sizeof(*resist_table),
 							 GFP_KERNEL);
 	if (!info->resist_table) {
+		kfree(propdata);
 		power_supply_put_battery_info(psy, info);
 		err = -ENOMEM;
 		goto out_put_node;
 	}
 
 	for (index = 0; index < info->resist_table_size; index++) {
-		resist_table[index].temp = be32_to_cpu(*list++);
-		resist_table[index].resistance = be32_to_cpu(*list++);
+		resist_table[index].temp = propdata[index*2];
+		resist_table[index].resistance = propdata[index*2+1];
 	}
 
+	kfree(propdata);
+
 out_ret_pointer:
 	/* Finally return the whole thing */
 	*info_out = info;
 
 out_put_node:
 	fwnode_handle_put(fwnode);
-	of_node_put(battery_np);
 	return err;
 }
 EXPORT_SYMBOL_GPL(power_supply_get_battery_info);

-- 
2.47.2


