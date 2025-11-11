Return-Path: <linux-pm+bounces-37770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66AC49E6D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 01:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 500F24F09B9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 00:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE1425A341;
	Tue, 11 Nov 2025 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JR52Qve7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2774C97;
	Tue, 11 Nov 2025 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821959; cv=none; b=i1Q8Y32RRDGUosgVmhmwqZeUMI7ZpUGN8L3rPfNPgW/tSo6SW0/CRwshHm8fCFyxIkZHIkqAj8FEIRiH+2XUZdKCDQSrE4vdxWqnDBD/SabdYx+j7lCLRNVXZ/BXg5BzwDfZRHv2pPNo6dE9zaDHxxoigTePS/KjnEmAr4dTHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821959; c=relaxed/simple;
	bh=wvtoHzkkdrPaPdhqQzaS4d2r83Edx3kLgjMSyep4WVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7fEJTxwNwu4lM6iclbaqNTc/3hkmaxmpIS3XcVe/zK6ETMRmXV970XuuiV8GxIQdaSIR6/Enm1smv9/F+r77ZuqWoz2TKHvL6hsfOsnYnz4IG9ZcNJ1rwXWTn5XC1zaJD28Lg03CZjfD59rf4qwH/ytD/uu1nWn0RYPqXxRMFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JR52Qve7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762821957; x=1794357957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvtoHzkkdrPaPdhqQzaS4d2r83Edx3kLgjMSyep4WVQ=;
  b=JR52Qve7DcrBTLxozM8Gq69+hZG7EqnNdTJxqN3ePObD+f2U9KcOYoCr
   8c3tDuuEXiS02PtCbnzkfquZ6gw+eDJmJpkqqnNf6z3pfe/66GnesmQsw
   9MNtO6wLIJlGaTP+cIjjTMd4foYe1KpkrJgS883MA0dtxcNYWWFOYwkMn
   Z3udWelZxCgTLAbmZhFWUjvnbBXppQP+cLbtcCZqakqmMyyNte2djLR+h
   5ttleAS7cYwMn4eIJF/vYd7DsIrxe8zjjBgkSU1W/BHstjocOL4I0zX49
   XGUDd/L/P1KR6i2Ji73HwlnAOhMNhmcXhSN2AyWJl3BQUZg6aHXboK35h
   w==;
X-CSE-ConnectionGUID: tys7KT53QWOAgTcggM1a2g==
X-CSE-MsgGUID: Qo8ToNG6SSWKwIbDAmQ1Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64792713"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64792713"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 16:45:54 -0800
X-CSE-ConnectionGUID: sHboRTI8Q36qWNG/+BTrTQ==
X-CSE-MsgGUID: nVArwOQdQouSRgQU7aciBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="189258886"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa009.fm.intel.com with ESMTP; 10 Nov 2025 16:45:54 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] ACPI: DPTF: Support Nova Lake
Date: Mon, 10 Nov 2025 16:45:52 -0800
Message-ID: <20251111004552.137984-3-srinivas.pandruvada@linux.intel.com>
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

Add Nova Lake ACPI IDs for DPTF.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/dptf/dptf_power.c                          | 2 ++
 drivers/acpi/fan.h                                      | 1 +
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
 4 files changed, 5 insertions(+)

diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index 776914f31b9e..55ccbb8ddbe3 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -240,6 +240,8 @@ static const struct acpi_device_id int3407_device_ids[] = {
 	{"INTC10D9", 0},
 	{"INTC1100", 0},
 	{"INTC1101", 0},
+	{"INTC10F7", 0},
+	{"INTC10F8", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index bedbab0e8e4e..c9583b05d3fb 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -21,6 +21,7 @@
 	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
 	{"INTC10D6", }, /* Fan for Panther Lake generation */ \
 	{"INTC10FE", }, /* Fan for Wildcat Lake generation */ \
+	{"INTC10F5", }, /* Fan for Nova Lake generation */ \
 	{"PNP0C0B", } /* Generic ACPI fan */
 
 #define ACPI_FPS_NAME_LEN	20
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 908cc1bf57f1..866ea9927ab1 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -691,6 +691,7 @@ static const struct acpi_device_id int3400_thermal_match[] = {
 	{"INTC10A0", 0},
 	{"INTC10D4", 0},
 	{"INTC10FC", 0},
+	{"INTC10F3", 0},
 	{}
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index ba63796761eb..264c9bc8e645 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -277,6 +277,7 @@ static const struct acpi_device_id int3403_device_ids[] = {
 	{"INTC10A1", 0},
 	{"INTC10D5", 0},
 	{"INTC10FD", 0},
+	{"INTC10F4", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
-- 
2.51.0


