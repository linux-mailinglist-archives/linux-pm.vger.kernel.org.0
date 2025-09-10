Return-Path: <linux-pm+bounces-34418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1E2B52338
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 23:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9ABC7B38AD
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 21:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77723043D1;
	Wed, 10 Sep 2025 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ee6yNLo/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE92D1F72;
	Wed, 10 Sep 2025 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538396; cv=none; b=upADakddHXiJqkqYZTdZqrL/f+op8TIYJ3rmtzy7ew52g4hhtz+4f9zHYSzPQ7mmZ7dLMGZHcdZsB7FVMMfB40eWa70YTOnGbfrB7qbS5t6lMbtnPEfCe51/m386DCNAEeA1XbTEjnMxQKINztSi8HJubirlCm1k6Yh9oqZoCIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538396; c=relaxed/simple;
	bh=nTrDeurMGxl2lF9oLF6Hn3KKDLdUdZ8Q5sKmSFjl8e0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=no7Rgc/TeyPbk6Zp4loihJw3RzV0gXHDRa+YWsST7Car3zxdyfcdUUgmRqZlPrVr4yVoHBLiWtDDKXObzJ1CrCYTv16RwmKfgFRBizD+a9JdnDHHni6lskVQByWfeibfGj+GHOZzw/qhbI8i6C6veJovP7b5eRpzGKwQ10/zcZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ee6yNLo/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757538395; x=1789074395;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nTrDeurMGxl2lF9oLF6Hn3KKDLdUdZ8Q5sKmSFjl8e0=;
  b=Ee6yNLo/TM7j/tgSchCrtXhxMgnLCLEve/pbdl3dyuQ0K1HV2+rXdfLV
   1VvN8XLeuBb5CVAGK+EoUo2ypNEX9Ffr4EA38CZCnWTs67QhuLKDG+hAS
   up5/dxv7pm22d9LHIih6x3fAeDG8Migjl/TInjGNs986pYPvww9E0EKRY
   qDOA8opWn6BUpO2eEn8oXUNbIzU6cOKt43zj/0lG0Xjt/awEGNU9ZOOxo
   f6d99YFUQa/KN1yW3ePaRdvE+ys8sQPjtao66uRvtkNEVo5s45fP71e9G
   EPI2qs9do48otpEEV6JZoZt2ICLz2FrZbgMlUznSEMfL7B9GjS1W/pPdd
   g==;
X-CSE-ConnectionGUID: u/eorHAuTuuEpwoas477Cg==
X-CSE-MsgGUID: sU6AUtZGSh2oIWy/4kieKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82448478"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82448478"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:34 -0700
X-CSE-ConnectionGUID: goxn+0jNRy+KNuQOs/eUfw==
X-CSE-MsgGUID: SRV0chvSQpOWGAxbfxMgyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="177842751"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:33 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 1/5] platform/x86:intel/pmc: Enable SSRAM support for Lunar Lake
Date: Wed, 10 Sep 2025 14:06:21 -0700
Message-ID: <20250910210629.11198-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910210629.11198-1-xi.pardee@linux.intel.com>
References: <20250910210629.11198-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable Lunar Lake platforms to achieve PMC information from
Intel PMC SSRAM Telemetry driver and substate requirements data
from telemetry region.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/lnl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index da513c234714b..e08a77c778c2c 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -13,6 +13,10 @@
 
 #include "core.h"
 
+#define SOCM_LPM_REQ_GUID	0x15099748
+
+static const u8 LNL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
+
 static const struct pmc_bit_map lnl_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
@@ -528,6 +532,16 @@ static const struct pmc_reg_map lnl_socm_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 	.s0ix_blocker_maps = lnl_blk_maps,
 	.s0ix_blocker_offset = LNL_S0IX_BLOCKER_OFFSET,
+	.lpm_reg_index = LNL_LPM_REG_INDEX,
+};
+
+static struct pmc_info lnl_pmc_info_list[] = {
+	{
+		.guid	= SOCM_LPM_REQ_GUID,
+		.devid	= PMC_DEVID_LNL_SOCM,
+		.map	= &lnl_socm_reg_map,
+	},
+	{}
 };
 
 #define LNL_NPU_PCI_DEV		0x643e
@@ -557,6 +571,8 @@ static int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info lnl_pmc_dev = {
+	.pci_func = 2,
+	.regmap_list = lnl_pmc_info_list,
 	.map = &lnl_socm_reg_map,
 	.suspend = cnl_suspend,
 	.resume = lnl_resume,
-- 
2.43.0


