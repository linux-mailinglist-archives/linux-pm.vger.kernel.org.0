Return-Path: <linux-pm+bounces-28260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2DAD1445
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39713188A359
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87E7254876;
	Sun,  8 Jun 2025 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPrg2+P+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4961224FA
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415228; cv=none; b=IXhGW2vljydg6p82rbtS5OSxGtczNHDz5CHNcXFoAVV0kL3A1IsSJzcnJBQ/9HSXfVAdGdL0FpDkjzTAIN6pJp1t3YVmpdEwPP0hMnPsohBCh6utbgedGfMfnjqnnNBzSu6NLuCBmuXnhfPKeEPma2JB08nBWuRr5t1UY/qEpqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415228; c=relaxed/simple;
	bh=x1mMn/wY5QTaCLUxdwr5SYEvhcXaA8+bA4Kkj9HXJ1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI16GIUaVizp4ZAI7k1XN3rq1tkCdfIDkNJB4UkCeEwwL1TOa+SgGmaIRmAIkhh6E6jqCvcCg+ufwcyvPD48X2RcRh43n1ANyIVGRZzhhdEMyzE4xPTBRgua9nxYIGDwbJZGh8jmgQ2XPxawLsw7mwGhPo6td43IqGlZ2jkxekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPrg2+P+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E383CC4CEEE;
	Sun,  8 Jun 2025 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749415228;
	bh=x1mMn/wY5QTaCLUxdwr5SYEvhcXaA8+bA4Kkj9HXJ1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPrg2+P++/pUoyYWq8goX6A2TrNfXcUqZEYiz+rRD9EgZHa8NYsnaalOhL6vhExLm
	 FhmLtfzHbTxl8VmZTuV11RqWKhEJsdoOzCtgFGjQ9zulBp0iDRItc/kvuCDwmYtFN8
	 w2ivp3sd9lYipV4I7/S+nvkUZrA1Bpob451L+Kiew4WrQs40hq47xeiQl83Xql9mdn
	 zSDUrmITPgI1g0C/Ai/fdQqADrdXNxpCU4lY77xBtep/ebu3LJdQdVOTk9p7tVMPyD
	 Fx75+xltaZqos5eWgQBA7xXzz0Quox8V1dLyE/lGcM09vasPR9S7cT1pGlbEu3pTa2
	 J/l1pvpLbYfFA==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 07/10] power: supply: core: rename power_supply_get_by_phandle to power_supply_get_by_reference
Date: Sun,  8 Jun 2025 22:40:07 +0200
Message-ID: <20250608204010.37482-8-hansg@kernel.org>
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

(devm_)power_supply_get_by_phandle now internally uses fwnode and are no
longer DT specific. Thus drop the ifdef check for CONFIG_OF and rename
to (devm_)power_supply_get_by_reference to avoid the DT terminology.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20250430-psy-core-convert-to-fwnode-v2-5-f9643b958677@collabora.com
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/phy/allwinner/phy-sun4i-usb.c    |  2 +-
 drivers/power/supply/bq2415x_charger.c   |  2 +-
 drivers/power/supply/power_supply_core.c | 22 ++++++++++------------
 include/linux/power_supply.h             | 15 +++------------
 4 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 29b8fd4b9351..8873aed3a52a 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -754,7 +754,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_present(np, "usb0_vbus_power-supply")) {
-		data->vbus_power_supply = devm_power_supply_get_by_phandle(dev,
+		data->vbus_power_supply = devm_power_supply_get_by_reference(dev,
 						     "usb0_vbus_power-supply");
 		if (IS_ERR(data->vbus_power_supply)) {
 			dev_err(dev, "Couldn't get the VBUS power supply\n");
diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 1ecbca510bba..917c26ee56bc 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -1674,7 +1674,7 @@ static int bq2415x_probe(struct i2c_client *client)
 	/* Query for initial reported_mode and set it */
 	if (bq->nb.notifier_call) {
 		if (np) {
-			notify_psy = power_supply_get_by_phandle(of_fwnode_handle(np),
+			notify_psy = power_supply_get_by_reference(of_fwnode_handle(np),
 						"ti,usb-charger-detection");
 			if (IS_ERR(notify_psy))
 				notify_psy = NULL;
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 2d83bb125a48..aedb20c1d276 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -496,14 +496,13 @@ void power_supply_put(struct power_supply *psy)
 }
 EXPORT_SYMBOL_GPL(power_supply_put);
 
-#ifdef CONFIG_OF
 static int power_supply_match_device_fwnode(struct device *dev, const void *data)
 {
 	return dev->parent && dev_fwnode(dev->parent) == data;
 }
 
 /**
- * power_supply_get_by_phandle() - Search for a power supply and returns its ref
+ * power_supply_get_by_reference() - Search for a power supply and returns its ref
  * @fwnode: Pointer to fwnode holding phandle property
  * @property: Name of property holding a power supply name
  *
@@ -514,8 +513,8 @@ static int power_supply_match_device_fwnode(struct device *dev, const void *data
  * Return: On success returns a reference to a power supply with
  * matching name equals to value under @property, NULL or ERR_PTR otherwise.
  */
-struct power_supply *power_supply_get_by_phandle(struct fwnode_handle *fwnode,
-						 const char *property)
+struct power_supply *power_supply_get_by_reference(struct fwnode_handle *fwnode,
+						   const char *property)
 {
 	struct fwnode_handle *power_supply_fwnode;
 	struct power_supply *psy = NULL;
@@ -537,7 +536,7 @@ struct power_supply *power_supply_get_by_phandle(struct fwnode_handle *fwnode,
 
 	return psy;
 }
-EXPORT_SYMBOL_GPL(power_supply_get_by_phandle);
+EXPORT_SYMBOL_GPL(power_supply_get_by_reference);
 
 static void devm_power_supply_put(struct device *dev, void *res)
 {
@@ -547,16 +546,16 @@ static void devm_power_supply_put(struct device *dev, void *res)
 }
 
 /**
- * devm_power_supply_get_by_phandle() - Resource managed version of
- *  power_supply_get_by_phandle()
+ * devm_power_supply_get_by_reference() - Resource managed version of
+ *  power_supply_get_by_reference()
  * @dev: Pointer to device holding phandle property
  * @property: Name of property holding a power supply phandle
  *
  * Return: On success returns a reference to a power supply with
  * matching name equals to value under @property, NULL or ERR_PTR otherwise.
  */
-struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
-						      const char *property)
+struct power_supply *devm_power_supply_get_by_reference(struct device *dev,
+							const char *property)
 {
 	struct power_supply **ptr, *psy;
 
@@ -567,7 +566,7 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	psy = power_supply_get_by_phandle(dev_fwnode(dev), property);
+	psy = power_supply_get_by_reference(dev_fwnode(dev), property);
 	if (IS_ERR_OR_NULL(psy)) {
 		devres_free(ptr);
 	} else {
@@ -576,8 +575,7 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
 	}
 	return psy;
 }
-EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
-#endif /* CONFIG_OF */
+EXPORT_SYMBOL_GPL(devm_power_supply_get_by_reference);
 
 int power_supply_get_battery_info(struct power_supply *psy,
 				  struct power_supply_battery_info **info_out)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c22ecb46098f..73bf20031449 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -806,19 +806,10 @@ static inline void power_supply_put(struct power_supply *psy) {}
 static inline struct power_supply *power_supply_get_by_name(const char *name)
 { return NULL; }
 #endif
-#ifdef CONFIG_OF
-extern struct power_supply *power_supply_get_by_phandle(struct fwnode_handle *fwnode,
-							const char *property);
-extern struct power_supply *devm_power_supply_get_by_phandle(
+extern struct power_supply *power_supply_get_by_reference(struct fwnode_handle *fwnode,
+							  const char *property);
+extern struct power_supply *devm_power_supply_get_by_reference(
 				    struct device *dev, const char *property);
-#else /* !CONFIG_OF */
-static inline struct power_supply *
-power_supply_get_by_phandle(struct device_node *np, const char *property)
-{ return NULL; }
-static inline struct power_supply *
-devm_power_supply_get_by_phandle(struct device *dev, const char *property)
-{ return NULL; }
-#endif /* CONFIG_OF */
 
 extern const enum power_supply_property power_supply_battery_info_properties[];
 extern const size_t power_supply_battery_info_properties_size;
-- 
2.49.0


