Return-Path: <linux-pm+bounces-32457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D126CB2887D
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 00:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472895633BA
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03949262FD8;
	Fri, 15 Aug 2025 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFb9IImI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C802264B1;
	Fri, 15 Aug 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297977; cv=none; b=hk0Xvz8DOz8raUz+auTq91GJjJrtqzQgqJCngbsYvXpIydmzALGezhRI4Vs8bnl4Eys9xFynVCDgmLxJqqo8zwiEytYuuzEqXOWX9WaB6C4WkHGrqr3OAYGc4GGYOzHttCh2aALLpSX0eRV0lE8oeJE3E0C/sx3AFLF6pd3PGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297977; c=relaxed/simple;
	bh=nTrDeurMGxl2lF9oLF6Hn3KKDLdUdZ8Q5sKmSFjl8e0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbI71WM1QEnzIOFF2CRECLx0ohUMKB7NdYy7kA+w6/FvCJ0Xl05ymrDKpiv4q//+qZOUNX4sDjoCJc4shZa+dHRV/ZytGFPhLFoxkSCi6g1Ny3R9DK0XjEi+vEQ+1NvP0LwPaAPeZ3B4E7SgHDF/ZGVvFujxIClVBpXLpm9Czew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFb9IImI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755297976; x=1786833976;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nTrDeurMGxl2lF9oLF6Hn3KKDLdUdZ8Q5sKmSFjl8e0=;
  b=KFb9IImIvvxstLGFZuU3LknuiGoMHF1vQjct+ijdILC3liOE9BJl35/l
   1kl7iP2kR2E6waEF/YcFAsvOk9+B14HTLngTMmB0FyDsHS7C7MsSxr5Tk
   fxMDpPWPruuSDDLkQd80PJi1MQa8eUjUcyGsWwLPhb7C0rolqCpByIIe9
   Dk69uaLLwOeJH80EpPOpnEgrGlqCKMs4S6hXPg1x39k/qHnFRu70v0O81
   8A+1zqu0yO3adfaohCilRBbVwAu5ej6dW0gVMokqfuLgT1nws78Jn586g
   L++BWrA7c84WO1WC4bfN3Fvc7pkIqxqHoNBj9ApOoCi5f4DWFHdiIplWp
   A==;
X-CSE-ConnectionGUID: IUETszo9RROLRk1t3Tz2bw==
X-CSE-MsgGUID: D3sm64vSSDuw4HU9IhJmFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57724934"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57724934"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:15 -0700
X-CSE-ConnectionGUID: cBbYpqoQQO2z8r5nmljPpw==
X-CSE-MsgGUID: UOtyGzYqTIaE5gbALmp4zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166734409"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.223.173])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:14 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 1/6] platform/x86:intel/pmc: Enable SSRAM support for Lunar Lake
Date: Fri, 15 Aug 2025 15:45:59 -0700
Message-ID: <20250815224611.2460255-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
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


