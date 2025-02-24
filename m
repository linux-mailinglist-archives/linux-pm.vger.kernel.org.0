Return-Path: <linux-pm+bounces-22849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7FA430AE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 00:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C308189F268
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 23:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F052320E6E7;
	Mon, 24 Feb 2025 23:22:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB220E31F;
	Mon, 24 Feb 2025 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439322; cv=none; b=cfctbLsi+jrvVwCAGN8VMUzeRBNXDY3yQ/JPIiGxC3ZRjfYl9iTXW/jc1vYTERH7r4TgnohX4kKmkZJx4DSw0w1nYTiNkwp0eo7pzSIE6kwv2LeaIs0+dFBoCzw8yy4ShFft0EC+GhKlw+loPcFbMmkzatKephg9Z8XjZDsQ6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439322; c=relaxed/simple;
	bh=nnV9DZFOn7haUOjP0I2UK6z0S6sV69e9OGIuX6qRp3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UngklJzhCvZFEe51ZdBtktbpMVEgSFwVTkQkvnrszTVyijEcAjtjx6R1o+B9bZp6aVatVsPqVAOMdS5WlC6s/+d61rvF7LvoroVC6dlPkq9MGg5m4cDbrbZjJub1PBjuXrN90QobJoc/zZBVDYcCTBPVrkIICl1/deDiS7lAYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42836C4CEED;
	Mon, 24 Feb 2025 23:22:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 5031F18067F; Tue, 25 Feb 2025 00:21:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 25 Feb 2025 00:21:40 +0100
Subject: [PATCH 7/7] power: supply: core: convert to fwnnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-psy-core-convert-to-fwnode-v1-7-d5e4369936bb@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7861;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=nnV9DZFOn7haUOjP0I2UK6z0S6sV69e9OGIuX6qRp3k=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBnvP8Vyowp/5XDLVpgtqLj5BRsrdZ0KwiEX2JvW
 KFTFVKHaPuJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZ7z/FQAKCRDY7tfzyDv6
 mn5ND/98EYA0PlXxgmLRMa9fPfAg5Ed50YVwJL59fCMW5ha/jRoCUuwVNFTgEC+6hmINGNG8ODN
 +MFwKOrvcRzKBa78Yo7FGxTTN3jWcGKtO1Vu0Na4hnD38OoABDEyOjr4ZegySNLFAgSyBXaaofI
 QA87R2YimROI1m+SCrTz4ZF3u1uQAb+vf94cwmeoGDDOqeL5aqeNcvsr9agGVV5o+t0D6RSo2Vj
 SBcTXQ9GmvPFuesK9AyEcQdpJ15UDGEnY5cKBVYe+BVMLe/LHvjkbTZ3Ws2mYdeg3y0Vo2duFnk
 gPukpCmIyscM4Uj0wBOtORCm/NZXW2021se0PmebPGRuEU8FduzAwCFKbALM+k5bw62sQbyIIth
 IvC69gatLauYVn8B4nZ2O9aSKtVtAZ3T5ZFOetqjqccgIp8cNKA/xJh5S9L0Ba4RgaXEFKBEAZ6
 asgfmoLao5zp6TmU6mBkJoyi5h0POAcgNkz1iNjKVmwkKK5cDDdG6/lXqIiLNyX+GDgNjGFuoF/
 F3Gf/Fj/V7ItLWFT3MhFJG5KMp8+z1u1Nn36xCoDAVeZflHaZRsSfnJGT4WAhdvBnfsRSWBlmw9
 +j4ncNHD8sWlVYRFixjCAobqfNe+Zs0Sgr6h24cHQvOGHgxdXj11oL23OkDyt5DoJEB9hmRmqRl
 6DswGO0R2FlI/3w==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Replace any DT specific code with fwnode in the power-supply
core.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/bq2415x_charger.c   |  2 +-
 drivers/power/supply/power_supply_core.c | 65 ++++++++++++++++----------------
 include/linux/power_supply.h             |  2 +-
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 9e3b9181ee76a4f473228bba022917677acce256..1ecbca510bba99ee7abcda33a719035adfceeb5f 100644
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
index 0e5fa16fd8f832414f34fae31086128928fa57cc..a01e6e1815da2ac70ce93d8bd5d06517a0eb1082 100644
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
@@ -511,14 +510,14 @@ void power_supply_put(struct power_supply *psy)
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
@@ -528,21 +527,21 @@ static int power_supply_match_device_node(struct device *dev, const void *data)
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
@@ -574,14 +573,14 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
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
index a785742f97721e7e70d0e4c17a1ded7b985acb6d..9afde8c04efc72691c81a373d8dd03477b4efd7e 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -805,7 +805,7 @@ static inline struct power_supply *power_supply_get_by_name(const char *name)
 { return NULL; }
 #endif
 #ifdef CONFIG_OF
-extern struct power_supply *power_supply_get_by_phandle(struct device_node *np,
+extern struct power_supply *power_supply_get_by_phandle(struct fwnode_handle *fwnode,
 							const char *property);
 extern struct power_supply *devm_power_supply_get_by_phandle(
 				    struct device *dev, const char *property);

-- 
2.47.2


