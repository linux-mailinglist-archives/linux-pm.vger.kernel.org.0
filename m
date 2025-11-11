Return-Path: <linux-pm+bounces-37769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE7FC49E61
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 01:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ABFE734BC26
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 00:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3A257849;
	Tue, 11 Nov 2025 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsXSh999"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33981F4CBF;
	Tue, 11 Nov 2025 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821958; cv=none; b=NN71fR2OMDbmcsB1plQGcg1/YYeV9tpwB3KhzPfGYGiLI1FuKG/wTK8nvUQXsl5HLznZyaVgQWhqbFdy5vg1wPIgHGeP87kfjrb3kEcn70lT/+Pvh8aJrdFWXlSXGQtg3gn4AmiBcFnubPmDLXPUnabTRd0q+cICIMoQJcdfQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821958; c=relaxed/simple;
	bh=vRDjUtgaWUTuxIfML4ycZFJf6BaGaB6qUFkOesTi2xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jayiiWPzWMuPgoXMuyNsd1jWtodLCWMZm8Kf5SU27SxfevcHbdpYaHEQlDX6uO0p2VbqxWBNROZVEGDjA9OyNUCu2xQaX7SpGOyxP4n41QzofUBYw5JrtiSrLOx+v4XNqk5p6iAk5BE4AmeIscta16XgFZDXB7Wxnwikri+Qhw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsXSh999; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762821957; x=1794357957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vRDjUtgaWUTuxIfML4ycZFJf6BaGaB6qUFkOesTi2xw=;
  b=FsXSh999tcjzN31c/5nriYUeYrC9qumnJ3/GAzxK6citwEnvcaobdMNF
   QAHyzVU/yK9gAUSLs0SGt4SybR1GtUlPh7qpY3TdzlIsYfpMDnevXfIsq
   USQXCs/c+0aBaksLCtPuo7DTc8q4ze/pRSgzcTNnbW8DfYcB74O5FGrwd
   ubUEn1/2YdTXR9ltKzCUhbZsrg6uXRNqhmcRP8w1fOxJuYzwF9czBdg2D
   TGnbN4bxeX7yE+Xl6cpejOiJNgRd6RqmkRWL4Bw5dDMU473NFjkKW4c9u
   tvvcBJHd2aDVPe8pYzTO8OWHF0lgA4qS7lzxr1qsXd3ml40hUyy0OQV9A
   w==;
X-CSE-ConnectionGUID: T+xAGwMfQ1WIOtAua4NPng==
X-CSE-MsgGUID: CwzXA9EjSwu+pIkD4Jd/Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64792709"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64792709"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 16:45:54 -0800
X-CSE-ConnectionGUID: HMkPAvFLRBa9qCyFftB2Lw==
X-CSE-MsgGUID: 3rLTge4NQeifPUjXEU7VIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="189258885"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa009.fm.intel.com with ESMTP; 10 Nov 2025 16:45:54 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] thermal: intel: int340x: Add DLVR support for Nova Lake
Date: Mon, 10 Nov 2025 16:45:51 -0800
Message-ID: <20251111004552.137984-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111004552.137984-1-srinivas.pandruvada@linux.intel.com>
References: <20251111004552.137984-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for DLVR (Digital Linear Voltage Regulator) for Nova Lake.
There are no new sysfs attributes or difference in operations compared
to prior generations.

MMIO offset and bit positions are changed. Also no mapping is required
as units are already in MHz.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_rfim.c      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 1f3d22b659db..589a3a71f0c4 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -87,6 +87,17 @@ static const struct mapping_table lnl_dlvr_mapping[] = {
 	{NULL, 0, NULL},
 };
 
+static const struct mmio_reg nvl_dlvr_mmio_regs[] = {
+	{ 0, 0x19208, 5, 0x1F, 0}, /* dlvr_spread_spectrum_pct */
+	{ 0, 0x19208, 1, 0x1, 5}, /* dlvr_control_mode */
+	{ 0, 0x19208, 1, 0x1, 6}, /* dlvr_control_lock */
+	{ 0, 0x19208, 1, 0x1, 7}, /* dlvr_rfim_enable */
+	{ 0, 0x19208, 12, 0xFFF, 8}, /* dlvr_freq_select */
+	{ 1, 0x19210, 2, 0x3, 30}, /* dlvr_hardware_rev */
+	{ 1, 0x19210, 16, 0xFFFF, 0}, /* dlvr_freq_mhz */
+	{ 1, 0x19210, 1, 0x1, 16}, /* dlvr_pll_busy */
+};
+
 static int match_mapping_table(const struct mapping_table *table, const char *attr_name,
 			       bool match_int_value, const u32 value, const char *value_str,
 			       char **result_str, u32 *result_int)
@@ -446,6 +457,10 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 			dlvr_mmio_regs_table = lnl_dlvr_mmio_regs;
 			dlvr_mapping = lnl_dlvr_mapping;
 			break;
+		case PCI_DEVICE_ID_INTEL_NVL_H_THERMAL:
+		case PCI_DEVICE_ID_INTEL_NVL_S_THERMAL:
+			dlvr_mmio_regs_table = nvl_dlvr_mmio_regs;
+			break;
 		default:
 			dlvr_mmio_regs_table = dlvr_mmio_regs;
 			break;
-- 
2.51.0


