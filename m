Return-Path: <linux-pm+bounces-28886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CF1ADC71E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 11:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81ED5189ABCF
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE3A2E06FC;
	Tue, 17 Jun 2025 09:50:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668102DF3FF
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153809; cv=none; b=X50JObn4hkzDQMoJTnFOXrKlvzSviDK+EUYcrhpTxt5q8skcX3PWPG/oVJY6NE82Sm5yI6tgKsqUPjTsytKOgKi1nJUw01WIMUtl2onP7hM6IZn348Oztit7oHOAY80ZaJJjyrcjL1ohPXTp1bfjAA50+kQP0DRUaM0assEkGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153809; c=relaxed/simple;
	bh=XGojHH9F0Yv1Zaj14e+r4bcattMMcYs/2iz2DruAfIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c02m0xjj1wvAjlkESmnmnvd33bDh2SE+rZDt+p4p2wFjs6m3bXDFiH3IPZhraR3/DJAogVFQPxBIE6DSjFrouEeFzxFhf9QUH/falNpgyQZUVyOEgrM6o75wxYOyXsFGYLy7FEje/z8K89pyObLaAYpN7Z/JeGQxTmDnLhe6YI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uRSwt-0005fF-0H; Tue, 17 Jun 2025 11:49:47 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRSws-003x53-19;
	Tue, 17 Jun 2025 11:49:46 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRSws-00FBhE-0k;
	Tue, 17 Jun 2025 11:49:46 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v10 5/7] nvmem: add support for device and sysfs-based cell lookups
Date: Tue, 17 Jun 2025 11:49:43 +0200
Message-Id: <20250617094945.3619360-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617094945.3619360-1-o.rempel@pengutronix.de>
References: <20250617094945.3619360-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Introduce new API functions to allow looking up NVMEM devices and cells
by name, enhancing flexibility in cases where devicetree-based  lookup
is not available.

Key changes:
- Added `nvmem_device_get_by_name()`: Enables retrieving an NVMEM device by
  its name for systems where direct device reference is needed.
- Added `nvmem_cell_get_by_sysfs_name()`: Allows retrieving an NVMEM cell
  based on its sysfs-style name (e.g., "cell@offset,bits"), making it
  possible to identify cells dynamically.
- Introduced `nvmem_find_cell_entry_by_sysfs_name()`: A helper function
  that constructs sysfs-like names and searches for matching cell entries.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v5:
- fix build we NVMEM=n
---
 drivers/nvmem/core.c           | 105 +++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |  18 ++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 59c295a11d86..d310fd8ca9c0 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1177,6 +1177,23 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 EXPORT_SYMBOL_GPL(of_nvmem_device_get);
 #endif
 
+/**
+ * nvmem_device_get_by_name - Look up an NVMEM device by its device name
+ * @name: String matching device name in the provider
+ *
+ * Return: A valid pointer to struct nvmem_device on success,
+ * or ERR_PTR(...) on failure. The caller must later call nvmem_device_put() to
+ * release the reference.
+ */
+struct nvmem_device *nvmem_device_get_by_name(const char *name)
+{
+	if (!name)
+		return ERR_PTR(-EINVAL);
+
+	return __nvmem_device_get((void *)name, device_match_name);
+}
+EXPORT_SYMBOL_GPL(nvmem_device_get_by_name);
+
 /**
  * nvmem_device_get() - Get nvmem device from a given id
  *
@@ -1490,6 +1507,94 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
 #endif
 
+/**
+ * nvmem_find_cell_entry_by_sysfs_name - Find an NVMEM cell entry by its sysfs
+ *					 name.
+ * @nvmem:      The nvmem_device pointer where the cell is located.
+ * @sysfs_name: The full sysfs cell name, e.g. "mycell@0x100,8".
+ *
+ * This function constructs the sysfs-like name for each cell and compares it
+ * to @sysfs_name. If a match is found, the matching nvmem_cell_entry pointer
+ * is returned. This is analogous to nvmem_find_cell_entry_by_name(), except
+ * it matches on the sysfs naming convention used in the device's attributes.
+ *
+ * Return: Pointer to the matching nvmem_cell_entry on success, or NULL if no
+ * match is found.
+ */
+static struct nvmem_cell_entry *
+nvmem_find_cell_entry_by_sysfs_name(struct nvmem_device *nvmem,
+				    const char *sysfs_name)
+{
+	struct nvmem_cell_entry *entry;
+	char tmp[NVMEM_CELL_NAME_MAX];
+
+	mutex_lock(&nvmem_mutex);
+	list_for_each_entry(entry, &nvmem->cells, node) {
+		int len = snprintf(tmp, NVMEM_CELL_NAME_MAX, "%s@%x,%u",
+				   entry->name, entry->offset,
+				   entry->bit_offset);
+
+		if (len >= NVMEM_CELL_NAME_MAX) {
+			pr_warn("nvmem: cell name too long (max %zu bytes): %s\n",
+				NVMEM_CELL_NAME_MAX, sysfs_name);
+			continue;
+		}
+
+		if (len < 0) {
+			pr_warn("nvmem: error formatting cell name\n");
+			continue;
+		}
+
+		if (!strcmp(tmp, sysfs_name)) {
+			mutex_unlock(&nvmem_mutex);
+			return entry;
+		}
+	}
+
+	mutex_unlock(&nvmem_mutex);
+	return NULL;
+}
+
+/**
+ * nvmem_cell_get_by_sysfs_name - Retrieve an NVMEM cell using a sysfs-style
+ *				  name.
+ * @nvmem: Pointer to the `struct nvmem_device` containing the cell.
+ * @sysfs_name: The sysfs-style cell name, formatted as
+ *		"<cell_name>@<offset>,<bits>".
+ *
+ * This function enables dynamic lookup of NVMEM cells via sysfs-style
+ * identifiers. It is useful when devicetree-based lookup is unavailable or when
+ * cells are managed dynamically.
+ *
+ * Example Usage:
+ *   nvmem_cell_get_by_sysfs_name(nvmem, "mycell@0x100,8");
+ *
+ * Return: Pointer to `struct nvmem_cell` on success. On error, an ERR_PTR() is
+ * returned with the appropriate error code.
+ */
+struct nvmem_cell *nvmem_cell_get_by_sysfs_name(struct nvmem_device *nvmem,
+						const char *sysfs_name)
+{
+	struct nvmem_cell_entry *entry;
+	struct nvmem_cell *cell;
+
+	entry = nvmem_find_cell_entry_by_sysfs_name(nvmem, sysfs_name);
+	if (!entry)
+		return ERR_PTR(-ENOENT);
+
+	if (!try_module_get(nvmem->owner))
+		return ERR_PTR(-EINVAL);
+
+	kref_get(&nvmem->refcnt);
+
+	cell = nvmem_create_cell(entry, entry->name, 0);
+	if (IS_ERR(cell))
+		__nvmem_device_put(nvmem);
+
+	return cell;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_get_by_sysfs_name);
+
 /**
  * nvmem_cell_get() - Get nvmem cell of device form a given cell name
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index bcb0e17e415d..2b5e06f457b0 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -20,6 +20,10 @@ struct nvmem_cell;
 struct nvmem_device;
 struct nvmem_cell_info;
 
+#define NVMEM_CELL_NAME_MAX \
+	(sizeof("very_long_cell_name_with_some_extra_chars_12345678@0x12345678,128"))
+
+
 /**
  * struct nvmem_cell_lookup - cell lookup entry
  *
@@ -52,6 +56,8 @@ enum {
 /* Cell based interface */
 struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
 struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
+struct nvmem_cell *nvmem_cell_get_by_sysfs_name(struct nvmem_device *nvmem,
+						const char *cell_name);
 void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
@@ -70,6 +76,7 @@ int nvmem_cell_read_variable_le_u64(struct device *dev, const char *cell_id,
 struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
 struct nvmem_device *devm_nvmem_device_get(struct device *dev,
 					   const char *name);
+struct nvmem_device *nvmem_device_get_by_name(const char *name);
 void nvmem_device_put(struct nvmem_device *nvmem);
 void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem);
 int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
@@ -109,6 +116,12 @@ static inline struct nvmem_cell *devm_nvmem_cell_get(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct nvmem_cell *
+nvmem_cell_get_by_sysfs_name(struct nvmem_device *nvmem, const char *cell_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline void devm_nvmem_cell_put(struct device *dev,
 				       struct nvmem_cell *cell)
 {
@@ -185,6 +198,11 @@ static inline struct nvmem_device *devm_nvmem_device_get(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct nvmem_device *nvmem_device_get_by_name(const char *name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline void nvmem_device_put(struct nvmem_device *nvmem)
 {
 }
-- 
2.39.5


