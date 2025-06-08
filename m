Return-Path: <linux-pm+bounces-28258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7DDAD1443
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332CA3AABD6
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3E225487D;
	Sun,  8 Jun 2025 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwPT832j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF318CC1C
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415224; cv=none; b=P3xTrWlAWhYmZGdXSszKR/USUe/zm6k9tmj7n54Sl808i0FgcoBNrcb2Cjxscl90QjfJO/FY6TplpinzsEUVq5otRwByTlDf+DkfsQ4F5NlBao2t7/KHCLoYN8c2nVkRe7dopGwjO8Smbl32/5mibJkhC8K/r6rD7qY9k/qNf4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415224; c=relaxed/simple;
	bh=XjWXf4ihzkPZQ/GBJNNvWYLpMFhhjXWcLArLlUN5BXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHieqp+0eYfNOp06p9MDFPtGcnpTRmT47fozYKPr3El43SBOVSKCkphfMzeHfkzomt2dILpLAJngVBVANDr0unbrviUROZ42+5nDIftZmoqVAqoxRq57bZPPjIYKyuH7dCaus1+mvUp4nx/ZIioX0PENdz7O63o2d54ihhIB71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwPT832j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA467C4CEEE;
	Sun,  8 Jun 2025 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749415224;
	bh=XjWXf4ihzkPZQ/GBJNNvWYLpMFhhjXWcLArLlUN5BXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WwPT832jsmabkb09kW2+L+TuHHIrAmhzn7yUm1chbREj0Oxb39Wutyn22HaOb0QVA
	 5N/8s6zGVf5nblQfOZNNxxNlwgMOUGpw579qdC0y0YM9q1vQQyXpmoEzmsQqBRc/z8
	 ebUW1pamKiNo6SG2ezNFhGgBW4YUNcqzWBt/wEI9beTaAt/tw3jeflZBtDvLOdXQ7N
	 GKmxkBPuJ+i60jl167uKPe8CUd+yD1RaZONG4kFVdsZ80YqgmVkXcKfWmV/mjxeTBV
	 cRRPxxyFM+C/668Gspm3yCFT0iU2FBE3BGErvTo0epli0HM+BTPQrjANcTwugrUyJJ
	 wXxK6EoUAnb6g==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 05/10] fixup! power: supply: core: battery-info: fully switch to fwnode
Date: Sun,  8 Jun 2025 22:40:05 +0200
Message-ID: <20250608204010.37482-6-hansg@kernel.org>
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

propname must NOT be manually free-ed here since it is marked
__free(kfree), freeing it will cause a double-free bug.

Also move propdata to be a __free(kfree) value for consistency
and also for cleaner code.

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 9bbc3be2e483..f2c79f15838d 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -588,7 +588,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	struct fwnode_handle *srcnode, *fwnode;
 	const char *value;
 	int err, len, index, proplen;
-	u32 *propdata;
+	u32 *propdata __free(kfree) = NULL;
 	u32 min_max[2];
 
 	srcnode = dev_fwnode(&psy->dev);
@@ -758,9 +758,9 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			err = -EINVAL;
 			goto out_put_node;
 		}
-		propdata = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
+
+		u32 *propdata __free(kfree) = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
 		if (!propdata) {
-			kfree(propname);
 			power_supply_put_battery_info(psy, info);
 			err = -EINVAL;
 			goto out_put_node;
@@ -768,8 +768,6 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		err = fwnode_property_read_u32_array(fwnode, propname, propdata, proplen);
 		if (err < 0) {
 			dev_err(&psy->dev, "failed to get %s\n", propname);
-			kfree(propname);
-			kfree(propdata);
 			power_supply_put_battery_info(psy, info);
 			goto out_put_node;
 		}
@@ -780,7 +778,6 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		info->ocv_table[index] = table =
 			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
 		if (!info->ocv_table[index]) {
-			kfree(propdata);
 			power_supply_put_battery_info(psy, info);
 			err = -ENOMEM;
 			goto out_put_node;
@@ -790,8 +787,6 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			table[i].ocv = propdata[i*2];
 			table[i].capacity = propdata[i*2+1];
 		}
-
-		kfree(propdata);
 	}
 
 	proplen = fwnode_property_count_u32(fwnode, "resistance-temp-table");
@@ -814,7 +809,6 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	err = fwnode_property_read_u32_array(fwnode, "resistance-temp-table",
 					     propdata, proplen);
 	if (err < 0) {
-		kfree(propdata);
 		power_supply_put_battery_info(psy, info);
 		goto out_put_node;
 	}
@@ -825,7 +819,6 @@ int power_supply_get_battery_info(struct power_supply *psy,
 							 sizeof(*resist_table),
 							 GFP_KERNEL);
 	if (!info->resist_table) {
-		kfree(propdata);
 		power_supply_put_battery_info(psy, info);
 		err = -ENOMEM;
 		goto out_put_node;
@@ -836,8 +829,6 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		resist_table[index].resistance = propdata[index*2+1];
 	}
 
-	kfree(propdata);
-
 out_ret_pointer:
 	/* Finally return the whole thing */
 	*info_out = info;
-- 
2.49.0


