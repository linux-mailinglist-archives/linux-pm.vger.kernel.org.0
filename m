Return-Path: <linux-pm+bounces-26402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 907C4AA3BCD
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 00:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35341B68A22
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FAC2BF3E7;
	Tue, 29 Apr 2025 22:55:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4602BF3D8;
	Tue, 29 Apr 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967310; cv=none; b=l+CnNroYYIDHW6QeS/ryjBAO9BhzOoqRjrhzgVSHcrOWolc02GGZTyTX7HnwFwTdURSU9gy8YuLV3nIgFVmMFirZXD71Z+SWvZbmwtrWVonNqvfJUH6vKos8PVxYplIxtRrcla8bTAMxkH/PRdtSA5o2nTacN1MEzFeHZQRtwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967310; c=relaxed/simple;
	bh=QCJ6iYp20NqIOjw/5OGJ6nPJ1tBnqyJTLxoCDobBKRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ok4mjz9FujNApXT39tSWYCacCjf6kih7ZFwikgInwNxN7eCRJC5aw/YiAHSMOxEbffCYW4uOP0Zx/GtUARrtYYRmC977AuQ+qqR9lM/4jM11Zzi4u7rtdZSB6Rl7f5+d/rDyeXgZkikhnUxz+9lGdRB++8+70DXIhgMqCRmnv0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5DCC4CEEF;
	Tue, 29 Apr 2025 22:55:09 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 9FB04180F4D; Wed, 30 Apr 2025 00:55:05 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 30 Apr 2025 00:54:27 +0200
Subject: [PATCH v2 5/5] power: supply: core: rename
 power_supply_get_by_phandle to power_supply_get_by_reference
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-psy-core-convert-to-fwnode-v2-5-f9643b958677@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6652;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=QCJ6iYp20NqIOjw/5OGJ6nPJ1tBnqyJTLxoCDobBKRw=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBoEVjJpX1UmjvjOF0iMgntcGqelQSYOvUFrG93Q
 WpCpFWGtcSJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaBFYyQAKCRDY7tfzyDv6
 mu1OD/4pl7iQ24/sd8C6sHQIcDbnP/beMQiThkWKCe5430ZMYjCW7jBKdzLbngDpKsGgLTiiHr3
 jVBQ6VNViOZ9QiRkEP6FSUHdFUHlZs7dGBJwotx4/Xl2GQ4gkKkf39UGiNudlbcp0wOu9b4sd16
 et50HbgnQCxnunFRJVJpyvHyNvaXEZR0KP21Gj23jnzj1u7yD2J9zpQIq6fpdT2s71mz+ZIOTs/
 37Tho4hsKIh9evuRW9FLznvK8zj48g83PJD5eZYdgmpLnCePP2w0fkEpALpNQCUp47iCfFUX0uZ
 NTodYD6JWfFa6AJjm1W6pLG1nj7iSAJhYCOWLqYiNynoYpwn9IsT7d6h9Z0IkiT0LTLV81tsj41
 xLEQzYGEUxzSb7WhOKxi5pKnOzysN501Z3HzbB9/z6EXSt/m3N3LyvVmpT+RoNDe/7FS2siUGqx
 CA1JK+3gqPzLj2N/9omQxiqk0JKgbuj2H4a/L+rXyYyDgve/1WttG6Qac1w3KMt5+MX2JkE6Enp
 sjWp9G7SsakQkPykzYS5vigMzBBkqBPigtbOsWZbgSsV29R+AcTa76HkuUBdPqw134oF7Tor6M5
 1NUo2YKtQDTZe4R1Iy5Cq2izD5sF3zfbBbYNkkOPQlDFETit9RKK1Lj+t+A7DKR7eyhtXqNTOAN
 PWHoOJR0Z9Nyr0g==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

(devm_)power_supply_get_by_phandle now internally uses fwnode and are no
longer DT specific. Thus drop the ifdef check for CONFIG_OF and rename
to (devm_)power_supply_get_by_reference to avoid the DT terminology.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c    |  2 +-
 drivers/power/supply/bq2415x_charger.c   |  2 +-
 drivers/power/supply/power_supply_core.c | 22 ++++++++++------------
 include/linux/power_supply.h             | 15 +++------------
 4 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 29b8fd4b935113f3e4790ee7f78141226048492d..8873aed3a52aa3f26564b6b2e576110c4069d28c 100644
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
index 1ecbca510bba99ee7abcda33a719035adfceeb5f..917c26ee56bc9f9da2f95f75a7d7f1afb0cea8d8 100644
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
index 1d53ceaa8fd161e7e72b90befabb9380393c99f2..37b9fa48faab27754d14d8379ed40d9bdda098ef 100644
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
index c95f098374cbdeafe8cddb52da3903f4f0e0f0fc..158227e86cfcb91b0fae7b1f9c944c5c395969ca 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -804,19 +804,10 @@ static inline void power_supply_put(struct power_supply *psy) {}
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
2.47.2


