Return-Path: <linux-pm+bounces-28256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A424AD1441
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F71D3AAB75
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF39253F2D;
	Sun,  8 Jun 2025 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzVoUQ1O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1C18CC1C
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415222; cv=none; b=Gm+LeTxMPCj5mhyDfDO5A3dcyjE4ZkH+VnCQTfO7LJMIw0Nt0eFAnzSpzi/d0RvnQyEfhVVsylLfaS0LBUYvvZG3pw4GnK51Q6WxkEk8skSy03KMhPnbam+V1TFx1RdHmVFyOKmP7BWio5QWhYjI1UcIZEt+vHpTf1lzytSqnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415222; c=relaxed/simple;
	bh=yHuzgDhKmYHqcVVXHvrFIheirJD1TcGoM1Q2eK6mQ0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o054pmpGrG5PbI97lb/ozh9YowzZsv4O0Z8qXHpUe2awhlTH6QiZi5NCz9O9UM2IPR4pwI1ZVBoYxXKLMIBlLl+O6Xgt91Pmty678bO1uMdL2ESpEMQ4QMdQRnD+egVmGaiOgV42U5wJknyuFSVT0IfsS/aWG0fzNb0Yr0tcsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzVoUQ1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAB6C4CEEE;
	Sun,  8 Jun 2025 20:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749415220;
	bh=yHuzgDhKmYHqcVVXHvrFIheirJD1TcGoM1Q2eK6mQ0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pzVoUQ1OLkcaqRYfeeklALeyW05aLAfGuywcphI+4OrwQMLFVkt59IJ7D2+yEizer
	 SmjB+wKqB9xEcnS47bYAgmvLS0a9rstupUUTI0ZD+Xn4Vp+9opcB+h8QCy5EcIrKDr
	 u0hsBR38EhlNE2SHWpr+whPoFv+LFREGDHnGcdlG2ICWGBkGmbqKt5K23tSMaZpgYd
	 OhZmaxroP5k6u5fOjf+/AoWzaJ+4krxiQbez6Rh7IGgPCEN7H+20fBFZBSP3aXuzpI
	 IjNxJQw1W+aGiJYZclFgvBJYOOE/rPMb7Lq2DUCpuSLeqp9Xc//u8VisjDbZVSg9F4
	 U/FkJRhiBH35Q==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 03/10] power: supply: core: battery-info: fully switch to fwnode
Date: Sun,  8 Jun 2025 22:40:03 +0200
Message-ID: <20250608204010.37482-4-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608204010.37482-1-hansg@kernel.org>
References: <20250608204010.37482-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Also use fwnode based parsing for "ocv-capacity-celsius" and
"resistance-temp-table", so that any DT specific bits are
removed from the power-supply core.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20250430-psy-core-convert-to-fwnode-v2-3-f9643b958677@collabora.com
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 109 +++++++++++++----------
 1 file changed, 63 insertions(+), 46 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 89947f1fe610..a8d1fe66e248 100644
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
2.49.0


