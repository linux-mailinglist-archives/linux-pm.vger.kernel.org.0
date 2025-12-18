Return-Path: <linux-pm+bounces-39686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BFCCDD25
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 23:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E49B3304F129
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60308331A75;
	Thu, 18 Dec 2025 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MS5gvi9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72695330B27;
	Thu, 18 Dec 2025 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096771; cv=none; b=a5W7RhUaSME/tG6ZxdhKXHMMGoJGgbakoFO4vs2nufk12VlJodCpyFgDw2iFsd3OyZ/Jl+21MjoxFd7dwbgJP02nPUHGqtxEAej5MmMHs6+bMYBy4+6tnzeMaSx5xdMj7PXgCS8m2vKLm/s0H+gYqGsFL9XX88iwq5Xc4BmNPPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096771; c=relaxed/simple;
	bh=b5eBYNVbYP3v2tQ9LvDk90S1WPWl6xGg9yg3gB/kiQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL7K/cjg8zidCjLzUORnRE1PJIhh+6h3bwhGs4uiULYoMzEaVyWQeVOQk9cKNVpU/on3AM7AFCHcp+7FMmVX3MjrkxEXmNnDJp78krrOJE5LDLj0rtW42walGqyK00lvARUx08z6eNbnpTpvWy3rntwM634do8djjbJScjjwcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MS5gvi9T; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766096769; x=1797632769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b5eBYNVbYP3v2tQ9LvDk90S1WPWl6xGg9yg3gB/kiQg=;
  b=MS5gvi9TeagyQimK2MkV28CGr7RvkYLYOzJLavkhXxo8jN+e3jR3nWVn
   tUEu4oGyAGvxUvK73Owd5jYrtdXRIDyB1OaEWOEmQ6Evqj929Ug2bWvAU
   Eb7zs/XtJWuDJJ+1gX9qC90fw6KMJyJe7NDNI1olTZOaRCNWGtxQtPY5k
   bPnz3N3RIc2MXoEhKe8PHu+oBctw83t2r/95WPFjPa0HeiW16YN35dL6S
   YEMAxATBEMwWiiEOUvP2vZRpLYtO83He9+a6bvL/rmlv0dNTdrjA7tQQv
   Ztjh2WYDrxOO7b5YJPPcKoZKpPEdVEAg3ba+Eh6d1MbGiY+ySsHImHgLJ
   A==;
X-CSE-ConnectionGUID: 7IxkeTDtRM6rrF5pxP3u3Q==
X-CSE-MsgGUID: QmRrpDkqShmAjRf2aUL8wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="79519092"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="79519092"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 14:26:06 -0800
X-CSE-ConnectionGUID: FcDgeX3QRoCY/OxC1+9lGQ==
X-CSE-MsgGUID: tG+OOcjKQVajdqbyJqiuzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="197851497"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa006.jf.intel.com with ESMTP; 18 Dec 2025 14:26:06 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] thermal: int340x: processor_thermal: Enable slow workload type hints
Date: Thu, 18 Dec 2025 14:25:58 -0800
Message-ID: <20251218222559.4110027-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218222559.4110027-1-srinivas.pandruvada@linux.intel.com>
References: <20251218222559.4110027-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On processors starting from Panther Lake additional hints are provided.
The hardware analyzes workload residencies over an extended period to
determine whether the workload classification tends toward idle/battery
life states or sustained/performance states. Based on this long-term
analysis, it classifies:
Power Classification: If the workload exhibits more idle or battery life
residencies, it is classified as "power". This is indicated by
setting the bit 4 of the current workload type.
Performance Classification: If the workload exhibits more sustained or
performance residencies, it is classified as "performance". This is
indicated by resetting the bit 4 of the current workload type.

This approach enables applications to ignore short-term workload
fluctuations and instead respond to longer-term power vs. performance
trends. This types of hints are called slow workload hints.

To get notifications for slow workload hints, a new bit 22 is added
to thermal mailbox to configure workload interrupts. This is possible
to exclusively only enable slow workload hints or enable in addition to
the current workload hints.

To enable slow workload hint a new attribute is added to the existing
workload hint attributes:
workload_slow_hint_enable (RW): Write 1 to enable, 0 to disable.
Reading this attribute shows the current state.

This attribute is not present any previous generation of processors.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../driver-api/thermal/intel_dptf.rst         |  3 +
 .../processor_thermal_wt_hint.c               | 61 ++++++++++++++++---
 2 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index 916bf0f36a03..4adfa1eb74db 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -375,6 +375,9 @@ based on the processor generation.
 ``workload_hint_enable`` (RW)
 	Enable firmware to send workload type hints to user space.
 
+``workload_slow_hint_enable`` (RW)
+	Enable firmware to send slow workload type hints to user space.
+
 ``notification_delay_ms`` (RW)
 	Minimum delay in milliseconds before firmware will notify OS. This is
 	for the rate control of notifications. This delay is between changing
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
index 68e8391af8f4..826775ad8f6c 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
@@ -34,6 +34,7 @@
 
 #define SOC_WT				GENMASK_ULL(47, 40)
 
+#define SOC_WT_SLOW_PREDICTION_INT_ENABLE_BIT	22
 #define SOC_WT_PREDICTION_INT_ENABLE_BIT	23
 
 #define SOC_WT_PREDICTION_INT_ACTIVE	BIT(2)
@@ -47,6 +48,7 @@ static u16 notify_delay_ms = 1024;
 
 static DEFINE_MUTEX(wt_lock);
 static u8 wt_enable;
+static u8 wt_slow_enable;
 
 /* Show current predicted workload type index */
 static ssize_t workload_type_index_show(struct device *dev,
@@ -59,7 +61,7 @@ static ssize_t workload_type_index_show(struct device *dev,
 	int wt;
 
 	mutex_lock(&wt_lock);
-	if (!wt_enable) {
+	if (!wt_enable && !wt_slow_enable) {
 		mutex_unlock(&wt_lock);
 		return -ENODATA;
 	}
@@ -84,9 +86,9 @@ static ssize_t workload_hint_enable_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", wt_enable);
 }
 
-static ssize_t workload_hint_enable_store(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t size)
+static ssize_t workload_hint_enable(struct device *dev, u8 enable_bit, u8 *status,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	u8 mode;
@@ -99,17 +101,17 @@ static ssize_t workload_hint_enable_store(struct device *dev,
 
 	if (mode)
 		ret = processor_thermal_mbox_interrupt_config(pdev, true,
-							      SOC_WT_PREDICTION_INT_ENABLE_BIT,
+							      enable_bit,
 							      notify_delay);
 	else
 		ret = processor_thermal_mbox_interrupt_config(pdev, false,
-							      SOC_WT_PREDICTION_INT_ENABLE_BIT, 0);
+							      enable_bit, 0);
 
 	if (ret)
 		goto ret_enable_store;
 
 	ret = size;
-	wt_enable = mode;
+	*status = mode;
 
 ret_enable_store:
 	mutex_unlock(&wt_lock);
@@ -117,8 +119,28 @@ static ssize_t workload_hint_enable_store(struct device *dev,
 	return ret;
 }
 
+static ssize_t workload_hint_enable_store(struct device *dev, struct device_attribute *attr,
+					  const char *buf, size_t size)
+{
+	return workload_hint_enable(dev, SOC_WT_PREDICTION_INT_ENABLE_BIT, &wt_enable,
+				    attr, buf, size);
+}
 static DEVICE_ATTR_RW(workload_hint_enable);
 
+static ssize_t workload_slow_hint_enable_show(struct device *dev, struct device_attribute *attr,
+					       char *buf)
+{
+	return sysfs_emit(buf, "%d\n", wt_slow_enable);
+}
+
+static ssize_t workload_slow_hint_enable_store(struct device *dev, struct device_attribute *attr,
+					       const char *buf, size_t size)
+{
+	return workload_hint_enable(dev, SOC_WT_SLOW_PREDICTION_INT_ENABLE_BIT, &wt_slow_enable,
+				    attr, buf, size);
+}
+static DEVICE_ATTR_RW(workload_slow_hint_enable);
+
 static ssize_t notification_delay_ms_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -178,16 +200,39 @@ static ssize_t notification_delay_ms_store(struct device *dev,
 
 static DEVICE_ATTR_RW(notification_delay_ms);
 
+static umode_t workload_hint_attr_visible(struct kobject *kobj, struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev;
+
+	if (attr != &dev_attr_workload_slow_hint_enable.attr)
+		return attr->mode;
+
+	pdev = to_pci_dev(dev);
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_INTEL_LNLM_THERMAL:
+	case PCI_DEVICE_ID_INTEL_MTLP_THERMAL:
+	case PCI_DEVICE_ID_INTEL_ARL_S_THERMAL:
+		return 0;
+	default:
+		break;
+	}
+
+	return attr->mode;
+}
+
 static struct attribute *workload_hint_attrs[] = {
 	&dev_attr_workload_type_index.attr,
 	&dev_attr_workload_hint_enable.attr,
+	&dev_attr_workload_slow_hint_enable.attr,
 	&dev_attr_notification_delay_ms.attr,
 	NULL
 };
 
 static const struct attribute_group workload_hint_attribute_group = {
 	.attrs = workload_hint_attrs,
-	.name = "workload_hint"
+	.name = "workload_hint",
+	.is_visible = workload_hint_attr_visible
 };
 
 /*
-- 
2.51.0


