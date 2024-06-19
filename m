Return-Path: <linux-pm+bounces-9575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEC990EB65
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65F61C218E9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848D414B06C;
	Wed, 19 Jun 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFmyU1UD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3F1474B9;
	Wed, 19 Jun 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801174; cv=none; b=k3ngL976BO7HwTctIGXt6a/hpry5akgIF3hID8/Vs29NAwjQTtTRDb+iLE8PY0hKduZwhzTkzuvsIGpoctUDXB5frFef7BHOLpSI07Ex1lUyr56jHgU8qfHA2SVYY2xpMsmtTYjIlDwfkcUy5uIod8hJrthLOeEeHOMQF1gohaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801174; c=relaxed/simple;
	bh=zHrdmRn3vT/3yPX4SIXso4Q7h68C/2nf1+jDZ31aq7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL9PBCfnmX4CpSFdFaR2v1AxM6VBEpcLuavdP/aI2sePT9Gj8pYwjV8w0jGlzUwWsspxgnLfzP1ERLD+1VlfNkwtJJLILEh6x2j2nadI67laU/I+L2xCSfJ1sYW5cbC+jc/I+AyWX/yhIoxRBz+PkpHPD7Zx99j9ujhX0Co0zB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFmyU1UD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718801173; x=1750337173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zHrdmRn3vT/3yPX4SIXso4Q7h68C/2nf1+jDZ31aq7E=;
  b=aFmyU1UD6S6A8/ldlD6upBQiUYjaiKwwBO6OmEd48FRomHAFmOEBndp7
   uc/2GPqji03Q5hc4IrbSnaV6uPKvqLE7fOIO+lk+L8+4fFH7Sj0ZIPR+2
   nnZJaK26t3aQ6mwjes56/iCSSA4q2N7Wf0/JhlJ8VXeaNLEnThrp1eldF
   X+j9MT8Wx/mSFAhC3/YKVZf6jzK2qWG4G1509i9/b5iYd0rSO5/lIYPVG
   KNFI2+uaSEcMupVZbx7xOgKzHkC8Ul/xkymxDgk2FrXG3Ylu3gfGw3der
   48Jcam5++S2ZFquk+giqQHBosbfsptKOhqZ20VGoyEXksg1uq9pdGg4Lw
   Q==;
X-CSE-ConnectionGUID: RvNyLOkdTTG3KU1cxEToOw==
X-CSE-MsgGUID: i3DQ0QKTSDqM93QoG57L2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15449944"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="15449944"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 05:46:09 -0700
X-CSE-ConnectionGUID: 6rWS8J3JQWqnjVcKA+PfWw==
X-CSE-MsgGUID: QypkMPpGQe+WsmUyk30ccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="46344349"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa005.fm.intel.com with ESMTP; 19 Jun 2024 05:46:08 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] thermal: intel: int340x: Add DLVR support for Lunar Lake
Date: Wed, 19 Jun 2024 05:46:00 -0700
Message-ID: <20240619124600.491168-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619124600.491168-1-srinivas.pandruvada@linux.intel.com>
References: <20240619124600.491168-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for DLVR (Digital Linear Voltage Regulator) for Lunar Lake.
There are no new sysfs attributes or difference in operation compared
to prior generations.

MMIO offset and bit positions are changed compared to Meteor Lake
processors. Also for two attributes dlvr_frequency_mhz and
dlvr_frequency_select, the value presented or accepted by the firmware
is not raw frequency value but an index.
For example:
RFI_FREQ_SELECT and RFI_FREQ
	: 0 DLVR freq point 2227.2 MHz
	: 1 DLVR freq point 2140 MHz

Hence create a mapping table for Lunar Lake to map user space values
to the firmware accepted values.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../processor_thermal_device_pci.c            |  3 +-
 .../int340x_thermal/processor_thermal_rfim.c  | 33 +++++++++++++++++--
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 4a1bfebb1b8e..b6bb96d07ce2 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -408,7 +408,8 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_thermal_pci_suspend,
 static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
-	{ PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
+	{ PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_RAPL |
+	  PROC_THERMAL_FEATURE_DLVR) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
 	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index c9c77bca2014..0e2dc1426282 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -68,6 +68,25 @@ static const struct mmio_reg dlvr_mmio_regs[] = {
 	{ 1, 0x15A10, 1, 0x1, 16}, /* dlvr_pll_busy */
 };
 
+static const struct mmio_reg lnl_dlvr_mmio_regs[] = {
+	{ 0, 0x5A08, 5, 0x1F, 0}, /* dlvr_spread_spectrum_pct */
+	{ 0, 0x5A08, 1, 0x1, 5}, /* dlvr_control_mode */
+	{ 0, 0x5A08, 1, 0x1, 6}, /* dlvr_control_lock */
+	{ 0, 0x5A08, 1, 0x1, 7}, /* dlvr_rfim_enable */
+	{ 0, 0x5A08, 2, 0x3, 8}, /* dlvr_freq_select */
+	{ 1, 0x5A10, 2, 0x3, 30}, /* dlvr_hardware_rev */
+	{ 1, 0x5A10, 2, 0x3, 0}, /* dlvr_freq_mhz */
+	{ 1, 0x5A10, 1, 0x1, 23}, /* dlvr_pll_busy */
+};
+
+static const struct mapping_table lnl_dlvr_mapping[] = {
+	{"dlvr_freq_select", 0, "2227.2"},
+	{"dlvr_freq_select", 1, "2140"},
+	{"dlvr_freq_mhz", 0, "2227.2"},
+	{"dlvr_freq_mhz", 1, "2140"},
+	{NULL, 0, NULL},
+};
+
 static int match_mapping_table(const struct mapping_table *table, const char *attr_name,
 			       bool match_int_value, const u32 value, const char *value_str,
 			       char **result_str, u32 *result_int)
@@ -167,7 +186,12 @@ static ssize_t suffix##_show(struct device *dev,\
 		mmio_regs = adl_dvfs_mmio_regs;\
 	} else if (table == 2) { \
 		match_strs = (const char **)dlvr_strings;\
-		mmio_regs = dlvr_mmio_regs;\
+		if (pdev->device == PCI_DEVICE_ID_INTEL_LNLM_THERMAL) {\
+			mmio_regs = lnl_dlvr_mmio_regs;\
+			mapping = lnl_dlvr_mapping;\
+		} else {\
+			mmio_regs = dlvr_mmio_regs;\
+		} \
 	} else {\
 		match_strs = (const char **)fivr_strings;\
 		mmio_regs = tgl_fivr_mmio_regs;\
@@ -206,7 +230,12 @@ static ssize_t suffix##_store(struct device *dev,\
 		mmio_regs = adl_dvfs_mmio_regs;\
 	} else if (table == 2) { \
 		match_strs = (const char **)dlvr_strings;\
-		mmio_regs = dlvr_mmio_regs;\
+		if (pdev->device == PCI_DEVICE_ID_INTEL_LNLM_THERMAL) {\
+			mmio_regs = lnl_dlvr_mmio_regs;\
+			mapping = lnl_dlvr_mapping;\
+		} else {\
+			mmio_regs = dlvr_mmio_regs;\
+		} \
 	} else {\
 		match_strs = (const char **)fivr_strings;\
 		mmio_regs = tgl_fivr_mmio_regs;\
-- 
2.40.1


