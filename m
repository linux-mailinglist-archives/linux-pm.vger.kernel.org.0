Return-Path: <linux-pm+bounces-22847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095DFA430AF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 00:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED0F189F4CF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 23:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA620E33F;
	Mon, 24 Feb 2025 23:22:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E0101F2;
	Mon, 24 Feb 2025 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439322; cv=none; b=lu+dQwu4C/k6to5w8p8jCqzqxPMVjzlqTBfNqfpFAvIGbfugoGDc5YmKp0Yaabxpru5LHRNiT/ZM7Nw7/AfDS9JI5R1MfmKK9rV0tt2BRvPTU9PCCDn1n6ZJeaGJ9wA0zzXN3vk7DJkYVcgzBB27UcLgj2Ewx+4QqRWTpAQETaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439322; c=relaxed/simple;
	bh=3EWj8wydEal1AdBKhkc/cc9ZWdBhQhAMquhRLczJRC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2E4tZQBYvJ8H+MGKp/EHbhpgkqVtReq/t1ad+2VZf3OhhWoaYtDvWkot8371B/vG4yuBa3Tfj0z/ywXKuoP+EyHYcrT0LlZNb6nloGNI+9Bab2Y9f6xmRCFZSyoLOMWh/j5GpKu6bHq8g+v0z5nkUDdnXRxyxv0DUQwoDItC9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42913C4CEF1;
	Mon, 24 Feb 2025 23:22:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 4E1D3180665; Tue, 25 Feb 2025 00:21:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 25 Feb 2025 00:21:39 +0100
Subject: [PATCH 6/7] power: supply: core: battery-info: fully switch to
 fwnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-psy-core-convert-to-fwnode-v1-6-d5e4369936bb@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6392;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=3EWj8wydEal1AdBKhkc/cc9ZWdBhQhAMquhRLczJRC4=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBnvP8VJZw40VZ+5kAHfcQzqKYee3Q4orBeXO6F5
 kkSHkBj0S6JAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZ7z/FQAKCRDY7tfzyDv6
 mvPJD/9F8NWw5U7KxrbhD6aMHpKjS8DxiTv2n/0X6f1BVogwhklGLpdX6mNc1y98cshIPjFFJ+k
 U/PshiFvspaIQ1yxSmDJMvlUEsiPNWbH1l+QvzVKP736haoDH8UvOmxdtZzXU38R70m/oLMQ9Je
 JX0oIgfUlodpewdR7SQAWuBKvD7leAH4ow1fxwjaX1w+wrdOxm6Jnb55umC7pbkjsTsQVwVUnJa
 mFpWyCuHNpdmZX6/asmM8hhe/d+3+1QuJycQ8p/q9JVzK27622oEEMfxj7CW7SUqFh9VjEEws6G
 4rVvGnhhq3o121PlXicG0l2s/28oJcnIbJm4g0ZZ9n5pwfMcdsn0Yh4+JmJUrAbiKJr9g8RXyS2
 gSqmWw7lcKDVSzD9RdeGgchp9zb7leNu3ZC7QSlxZtp+vxfRv7YO7e6qOttAM2aErv98LJDzKYn
 xCXGrT3+XdJjxMOPgxcfhSyv1uglivrvr/IwL59LGzR9TwJcusrIjAAFDuifffGRlCnEwQ/O1/H
 y+KPhWt6WFefHRUg/bpy9puVmxYw//KJ3s/dytgSE9uBn7lVZdDssXago/ugmOWfpWQQml6B0mW
 wYsN6yxjGaUJcQFoBeuBltqJaVmlPzGCsslUNEc+ojp4Pw7MIyzwJH3MYESnOpxkZJQ9KlktJtL
 p1gWbzvzcINri2A==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Also use fwnode based parsing for "ocv-capacity-celsius" and
"resistance-temp-table", so that any DT specific bits are
removed from the power-supply core.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 109 ++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 46 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index c43539ea1318506ada0a6fcbcdbf7ece253f5257..0e5fa16fd8f832414f34fae31086128928fa57cc 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -598,32 +598,19 @@ int power_supply_get_battery_info(struct power_supply *psy,
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
@@ -753,15 +740,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
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
@@ -770,13 +749,13 @@ int power_supply_get_battery_info(struct power_supply *psy,
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
@@ -785,60 +764,98 @@ int power_supply_get_battery_info(struct power_supply *psy,
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


