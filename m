Return-Path: <linux-pm+bounces-23550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC59A5469A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 10:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0058165D49
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F7B20B7E9;
	Thu,  6 Mar 2025 09:39:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784E20AF78
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253961; cv=none; b=YdqWfit3lRIcvyavdFO9Ppmtq8rq43bjhrraNvDYR8gkohI5stpowfhUTm0RaXcaS8iwzN8h/7KoADsazRJr5aTRJ4igMV158O3FP6f1SejmZsIrjFkCnZ3/4WIco7hUPzPHi/UBfjmmz+8mR8xOD+VlMvWChvnXAZbyC0d/VK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253961; c=relaxed/simple;
	bh=97NucGCt7fLDCBZsxvtwk7nqDHmguV4mhYEZZK4elfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WdD9ChpOUCJ96yxi7pKKj3mRqloGgFPkJyC3Sc+xSAIW0KBY42crmju6wKBCObRqTgbWlSD/hrD7m/+zJqSep/4R71RONLj9F8FgPxUqh3+5ReFPHC5u4zkmK9WmvkFd4grbvRsCShhVIp0//7Bou2zUb5lP306WyXInaHZqJpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tq7h0-0002QP-Iy; Thu, 06 Mar 2025 10:39:02 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tq7gz-004I9d-2D;
	Thu, 06 Mar 2025 10:39:01 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tq7gz-009ECI-1x;
	Thu, 06 Mar 2025 10:39:01 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v4 4/7] nvmem: add support for device and sysfs-based cell lookups
Date: Thu,  6 Mar 2025 10:38:56 +0100
Message-Id: <20250306093900.2199442-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306093900.2199442-1-o.rempel@pengutronix.de>
References: <20250306093900.2199442-1-o.rempel@pengutronix.de>
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
- Added `nvmem_device_get_by_name()`: Enables retrieving an NVMEM device by its
  name for systems where direct device reference is needed.
- Added `nvmem_cell_get_by_sysfs_name()`: Allows retrieving an NVMEM cell based
  on its sysfs-style name (e.g., "cell@offset,bits"), making it possible to
  identify cells dynamically.
- Introduced `nvmem_find_cell_entry_by_sysfs_name()`: A helper function that
  constructs sysfs-like names and searches for matching cell entries.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/nvmem/core.c           | 91 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h | 14 ++++++
 2 files changed, 105 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 928ac15f04a0..2ff0926dea23 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1203,6 +1203,20 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
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
+	return __nvmem_device_get((void *)name, device_match_name);
+}
+EXPORT_SYMBOL_GPL(nvmem_device_get_by_name);
+
 /**
  * nvmem_device_get() - Get nvmem device from a given id
  *
@@ -1516,6 +1530,83 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
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
+	char *tmp;
+
+	mutex_lock(&nvmem_mutex);
+	list_for_each_entry(entry, &nvmem->cells, node) {
+		/* Reconstruct how the sysfs name is assigned */
+		tmp = kasprintf(GFP_KERNEL, "%s@%x,%u", entry->name,
+				entry->offset, entry->bit_offset);
+		if (!tmp)
+			continue;
+
+		if (!strcmp(tmp, sysfs_name)) {
+			kfree(tmp);
+			mutex_unlock(&nvmem_mutex);
+			return entry;
+		}
+		kfree(tmp);
+	}
+	mutex_unlock(&nvmem_mutex);
+
+	return NULL;
+}
+
+/**
+ * nvmem_cell_get_by_sysfs_name - Get a cell by its sysfs name from a given
+ *				  nvmem_device.
+ * @nvmem:      The nvmem_device pointer where the cell is located.
+ * @sysfs_name: The sysfs-style name, e.g. "mycell@0x100,8".
+ *
+ * This function uses nvmem_find_cell_entry_by_sysfs_name() to locate the cell
+ * entry, increments the reference counts for the matching NVMEM device, and
+ * then creates a struct nvmem_cell for the caller.
+ *
+ * Return: On success, a valid pointer to an nvmem_cell. On failure, an
+ * ERR_PTR() encoded error (e.g., -ENOENT if the cell entry is not found).
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
index bcb0e17e415d..6fc12cce8eb2 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -52,6 +52,8 @@ enum {
 /* Cell based interface */
 struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
 struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
+struct nvmem_cell *nvmem_cell_get_by_sysfs_name(struct nvmem_device *nvmem,
+						const char *cell_name);
 void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
@@ -70,6 +72,7 @@ int nvmem_cell_read_variable_le_u64(struct device *dev, const char *cell_id,
 struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
 struct nvmem_device *devm_nvmem_device_get(struct device *dev,
 					   const char *name);
+struct nvmem_device *nvmem_device_get_by_name(const char *name);
 void nvmem_device_put(struct nvmem_device *nvmem);
 void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem);
 int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
@@ -109,6 +112,12 @@ static inline struct nvmem_cell *devm_nvmem_cell_get(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+struct nvmem_cell *nvmem_cell_get_by_sysfs_name(struct nvmem_device *nvmem,
+						const char *cell_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline void devm_nvmem_cell_put(struct device *dev,
 				       struct nvmem_cell *cell)
 {
@@ -185,6 +194,11 @@ static inline struct nvmem_device *devm_nvmem_device_get(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+struct nvmem_device *nvmem_device_get_by_name(const char *name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline void nvmem_device_put(struct nvmem_device *nvmem)
 {
 }
-- 
2.39.5


