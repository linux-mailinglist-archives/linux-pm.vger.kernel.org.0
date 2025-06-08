Return-Path: <linux-pm+bounces-28259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC87EAD1444
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31183A7B82
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105F254855;
	Sun,  8 Jun 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESA/kaG6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086F18CC1C
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415227; cv=none; b=LWxO+OdHSemcLSDN7zWif8j9K7R+f83tsLTEfjeZXwtG9G51vMchWqmULw0xdzsq3YSYDK6hfCwsYNNQGtFESgu+eg+CUpGMe02CgtaxmmCYEaKZF/boHNB9VuUMPV34QXGLtJ20gDr0F48aJfm5qhdgMQH6aYjPQi9o+ZENKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415227; c=relaxed/simple;
	bh=hPu2LL4qVzNGjA9lUidgftSqpBH/n84hvsTHJ5/6g7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+f3YDdx73NODjxIg2RlKV0Aupwfv1OZHARf3Sjj1AKmDNKvlmXw2bIZziJ440CcMG/IWtU1wmbCq6wM0vxLtzAMMurWFWR0FHdv2TeWL4SfmESRMdWG9z72De8b0gQ3DwBcYz0cXUN+A4yOmQu7XbxKAmmAdctigPp6Ymgu5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESA/kaG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12C0C4CEF2;
	Sun,  8 Jun 2025 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749415226;
	bh=hPu2LL4qVzNGjA9lUidgftSqpBH/n84hvsTHJ5/6g7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ESA/kaG6ruIs4KA6EpGUqm1MhenI4zUfVp4XLMDdPZg7PN+QNZmWgtMzavpYEQUrx
	 1cC1FAs7voSiJkQw1RKl3GJccxAhvUX05q6J8zKLroZ+UfQ3V7gq57j0Gai9FZgI8Z
	 y1dqRkFP6evJYptywEAM6vyEsyh1xobTxIkJoSRkXS85XjwZs3f/tZMOEVZidQM6Ix
	 3d8sh0aHdShRy0W139OmRmiTH2bbrCgVN8ApGPij9D/vhWZkYE4D9NfpvP4kHJkH0D
	 l7RTRi4Tpxtpw2qm7pCPLMd3x2filUBUWRE0VgPATa5KWkl6qLEoUN2j2MkfbYrvzN
	 96CtXxw0SayLw==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 06/10] power: supply: core: convert to fwnnode
Date: Sun,  8 Jun 2025 22:40:06 +0200
Message-ID: <20250608204010.37482-7-hansg@kernel.org>
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

Replace any DT specific code with fwnode in the power-supply
core.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20250430-psy-core-convert-to-fwnode-v2-4-f9643b958677@collabora.com
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/bq2415x_charger.c   |  2 +-
 drivers/power/supply/power_supply_core.c | 65 ++++++++++++------------
 include/linux/power_supply.h             |  2 +-
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 9e3b9181ee76..1ecbca510bba 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -1674,7 +1674,7 @@ static int bq2415x_probe(struct i2c_client *client)
 	/* Query for initial reported_mode and set it */
 	if (bq->nb.notifier_call) {
 		if (np) {
-			notify_psy = power_supply_get_by_phandle(np,
+			notify_psy = power_supply_get_by_phandle(of_fwnode_handle(np),
 						"ti,usb-charger-detection");
 			if (IS_ERR(notify_psy))
 				notify_psy = NULL;
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index f2c79f15838d..2d83bb125a48 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -18,7 +18,6 @@
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/err.h>
-#include <linux/of.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/thermal.h>
@@ -196,24 +195,24 @@ static int __power_supply_populate_supplied_from(struct power_supply *epsy,
 						 void *data)
 {
 	struct power_supply *psy = data;
-	struct device_node *np;
+	struct fwnode_handle *np;
 	int i = 0;
 
 	do {
-		np = of_parse_phandle(psy->dev.of_node, "power-supplies", i++);
-		if (!np)
+		np = fwnode_find_reference(psy->dev.fwnode, "power-supplies", i++);
+		if (IS_ERR(np))
 			break;
 
-		if (np == epsy->dev.of_node) {
+		if (np == epsy->dev.fwnode) {
 			dev_dbg(&psy->dev, "%s: Found supply : %s\n",
 				psy->desc->name, epsy->desc->name);
 			psy->supplied_from[i-1] = (char *)epsy->desc->name;
 			psy->num_supplies++;
-			of_node_put(np);
+			fwnode_handle_put(np);
 			break;
 		}
-		of_node_put(np);
-	} while (np);
+		fwnode_handle_put(np);
+	} while (!IS_ERR(np));
 
 	return 0;
 }
@@ -232,16 +231,16 @@ static int power_supply_populate_supplied_from(struct power_supply *psy)
 static int  __power_supply_find_supply_from_node(struct power_supply *epsy,
 						 void *data)
 {
-	struct device_node *np = data;
+	struct fwnode_handle *fwnode = data;
 
 	/* returning non-zero breaks out of power_supply_for_each_psy loop */
-	if (epsy->dev.of_node == np)
+	if (epsy->dev.fwnode == fwnode)
 		return 1;
 
 	return 0;
 }
 
-static int power_supply_find_supply_from_node(struct device_node *supply_node)
+static int power_supply_find_supply_from_fwnode(struct fwnode_handle *supply_node)
 {
 	int error;
 
@@ -249,7 +248,7 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 	 * power_supply_for_each_psy() either returns its own errors or values
 	 * returned by __power_supply_find_supply_from_node().
 	 *
-	 * __power_supply_find_supply_from_node() will return 0 (no match)
+	 * __power_supply_find_supply_from_fwnode() will return 0 (no match)
 	 * or 1 (match).
 	 *
 	 * We return 0 if power_supply_for_each_psy() returned 1, -EPROBE_DEFER if
@@ -262,7 +261,7 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 
 static int power_supply_check_supplies(struct power_supply *psy)
 {
-	struct device_node *np;
+	struct fwnode_handle *np;
 	int cnt = 0;
 
 	/* If there is already a list honor it */
@@ -270,24 +269,24 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		return 0;
 
 	/* No device node found, nothing to do */
-	if (!psy->dev.of_node)
+	if (!psy->dev.fwnode)
 		return 0;
 
 	do {
 		int ret;
 
-		np = of_parse_phandle(psy->dev.of_node, "power-supplies", cnt++);
-		if (!np)
+		np = fwnode_find_reference(psy->dev.fwnode, "power-supplies", cnt++);
+		if (IS_ERR(np))
 			break;
 
-		ret = power_supply_find_supply_from_node(np);
-		of_node_put(np);
+		ret = power_supply_find_supply_from_fwnode(np);
+		fwnode_handle_put(np);
 
 		if (ret) {
 			dev_dbg(&psy->dev, "Failed to find supply!\n");
 			return ret;
 		}
-	} while (np);
+	} while (!IS_ERR(np));
 
 	/* Missing valid "power-supplies" entries */
 	if (cnt == 1)
@@ -498,14 +497,14 @@ void power_supply_put(struct power_supply *psy)
 EXPORT_SYMBOL_GPL(power_supply_put);
 
 #ifdef CONFIG_OF
-static int power_supply_match_device_node(struct device *dev, const void *data)
+static int power_supply_match_device_fwnode(struct device *dev, const void *data)
 {
-	return dev->parent && dev->parent->of_node == data;
+	return dev->parent && dev_fwnode(dev->parent) == data;
 }
 
 /**
  * power_supply_get_by_phandle() - Search for a power supply and returns its ref
- * @np: Pointer to device node holding phandle property
+ * @fwnode: Pointer to fwnode holding phandle property
  * @property: Name of property holding a power supply name
  *
  * If power supply was found, it increases reference count for the
@@ -515,21 +514,21 @@ static int power_supply_match_device_node(struct device *dev, const void *data)
  * Return: On success returns a reference to a power supply with
  * matching name equals to value under @property, NULL or ERR_PTR otherwise.
  */
-struct power_supply *power_supply_get_by_phandle(struct device_node *np,
-							const char *property)
+struct power_supply *power_supply_get_by_phandle(struct fwnode_handle *fwnode,
+						 const char *property)
 {
-	struct device_node *power_supply_np;
+	struct fwnode_handle *power_supply_fwnode;
 	struct power_supply *psy = NULL;
 	struct device *dev;
 
-	power_supply_np = of_parse_phandle(np, property, 0);
-	if (!power_supply_np)
-		return ERR_PTR(-ENODEV);
+	power_supply_fwnode = fwnode_find_reference(fwnode, property, 0);
+	if (IS_ERR(power_supply_fwnode))
+		return ERR_CAST(power_supply_fwnode);
 
-	dev = class_find_device(&power_supply_class, NULL, power_supply_np,
-				power_supply_match_device_node);
+	dev = class_find_device(&power_supply_class, NULL, power_supply_fwnode,
+				power_supply_match_device_fwnode);
 
-	of_node_put(power_supply_np);
+	fwnode_handle_put(power_supply_fwnode);
 
 	if (dev) {
 		psy = dev_to_psy(dev);
@@ -561,14 +560,14 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
 {
 	struct power_supply **ptr, *psy;
 
-	if (!dev->of_node)
+	if (!dev_fwnode(dev))
 		return ERR_PTR(-ENODEV);
 
 	ptr = devres_alloc(devm_power_supply_put, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	psy = power_supply_get_by_phandle(dev->of_node, property);
+	psy = power_supply_get_by_phandle(dev_fwnode(dev), property);
 	if (IS_ERR_OR_NULL(psy)) {
 		devres_free(ptr);
 	} else {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3e52883f866b..c22ecb46098f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -807,7 +807,7 @@ static inline struct power_supply *power_supply_get_by_name(const char *name)
 { return NULL; }
 #endif
 #ifdef CONFIG_OF
-extern struct power_supply *power_supply_get_by_phandle(struct device_node *np,
+extern struct power_supply *power_supply_get_by_phandle(struct fwnode_handle *fwnode,
 							const char *property);
 extern struct power_supply *devm_power_supply_get_by_phandle(
 				    struct device *dev, const char *property);
-- 
2.49.0


