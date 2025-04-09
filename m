Return-Path: <linux-pm+bounces-25039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB98A83014
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EBB189107B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CEE27BF65;
	Wed,  9 Apr 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWtA+k4X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36145277801;
	Wed,  9 Apr 2025 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225865; cv=none; b=OfFtACvcfUgTuzUFWo39F7EMDu/MFkFtYNuvMoHd8wMoXRBAlHNqBILrynhjZJ2t8/aCOuiPmG+1a4nH0maX6l/PNzAKn2cBRleO2rdzONR9Ui+pXJCCMsqoGxNNKRx3lWW/Jvsr+ORmC3xKfJyWnlXMkOh8nDF3qrir1XCoTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225865; c=relaxed/simple;
	bh=XrkOz4zdjQP0Y7svw7ZGaYJQkN9aHF2bxU6CsHIHtpc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0n89hsNlg7rXTcV+kfoFllXWXWspZfZrtiWSlpxPUXV3U7UD07reDBJg2oN36slGfkO4cE65l/3layXL49IUM83+vljbQaiEJa8wyOhn6/kOlEDTLJKsJdsJ0pzYgWTkf1TqYclTCIifX9Ny/SOpLd32KyBqpEcdHPoKslO1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWtA+k4X; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744225864; x=1775761864;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=XrkOz4zdjQP0Y7svw7ZGaYJQkN9aHF2bxU6CsHIHtpc=;
  b=aWtA+k4Xu2ZNDFKdNv0d8jBo1O/K4frRkl97u9yCE+5HP7M7gYYOPK8U
   Gw1Pgb7x0G82KpTTElFwCs0M10HPhvuWHCgQS38VrmQXMJ/ZG3NuSLqQT
   R4UVVNVPnjZN6itaZHp44DKFH6AMGGOyZ383a9Y8iOdyBx72f9chvU0/g
   AYtjyRRvWpSwUpLEajtlGHzRJB3q+4zCsegSw7cxEEKXWS6pGi3N/eml7
   ui9jP5SHQPi+GbnxPxDqYn8pKifsjfk+FeJitd4w6iWtT+M3QxygeLlfw
   9rcbghsLiMRANG05bEdsSLtblkzD6qhcL6PXS9pNx21mjo9LKNBZT/lmc
   g==;
X-CSE-ConnectionGUID: l1Cy0jKAQ7Osqvjk2MruMw==
X-CSE-MsgGUID: /52H8CjqSymEo+pG/K/0uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56386770"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56386770"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:02 -0700
X-CSE-ConnectionGUID: AORIQy2jS8m/10fwXFq8eA==
X-CSE-MsgGUID: lbI226v8SQy2g5QyQD+Ssw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="133401236"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.250])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:01 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 3/8] platform/x86:intel/pmc: Move PMC devid to core.h
Date: Wed,  9 Apr 2025 12:10:45 -0700
Message-ID: <20250409191056.15434-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409191056.15434-1-xi.pardee@linux.intel.com>
References: <20250409191056.15434-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move PMC devid definition for each PMC of Arrow Lake and Meteor
Lake platforms to core.h. This patch is a preparation step to
introduce a new SSRAM Telemetry driver which will be using the
PMC devid.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 12 ++++--------
 drivers/platform/x86/intel/pmc/core.h | 12 ++++++++++++
 drivers/platform/x86/intel/pmc/mtl.c  |  9 +++------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 320993bd6d31..a6b2eb850ff0 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -651,29 +651,25 @@ static const struct pmc_reg_map arl_pchs_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
-#define PMC_DEVID_SOCM 0x777f
-#define PMC_DEVID_SOCS 0xae7f
-#define PMC_DEVID_IOEP 0x7ecf
-#define PMC_DEVID_PCHS 0x7f27
 static struct pmc_info arl_pmc_info_list[] = {
 	{
 		.guid	= IOEP_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_IOEP,
+		.devid	= PMC_DEVID_ARL_IOEP,
 		.map	= &mtl_ioep_reg_map,
 	},
 	{
 		.guid	= SOCS_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_SOCS,
+		.devid	= PMC_DEVID_ARL_SOCS,
 		.map	= &arl_socs_reg_map,
 	},
 	{
 		.guid	= PCHS_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_PCHS,
+		.devid	= PMC_DEVID_ARL_PCHS,
 		.map	= &arl_pchs_reg_map,
 	},
 	{
 		.guid	= SOCM_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_SOCM,
+		.devid	= PMC_DEVID_ARL_SOCM,
 		.map	= &mtl_socm_reg_map,
 	},
 	{}
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 09aac6daabbd..ce1b949b1004 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -298,6 +298,18 @@ enum ppfear_regs {
 #define PTL_PMC_LTR_CUR_PLT			0x1C2C
 #define PTL_PCD_PMC_MMIO_REG_LEN		0x31A8
 
+/* SSRAM PMC Device ID */
+/* ARL */
+#define PMC_DEVID_ARL_SOCM	0x777f
+#define PMC_DEVID_ARL_SOCS	0xae7f
+#define PMC_DEVID_ARL_IOEP	0x7ecf
+#define PMC_DEVID_ARL_PCHS	0x7f27
+
+/* MTL */
+#define PMC_DEVID_MTL_SOCM	0x7e7f
+#define PMC_DEVID_MTL_IOEP	0x7ecf
+#define PMC_DEVID_MTL_IOEM	0x7ebf
+
 extern const char *pmc_lpm_modes[];
 
 struct pmc_bit_map {
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 8862829694a7..8f1b01657277 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -947,23 +947,20 @@ static const struct pmc_reg_map mtl_ioem_reg_map = {
 	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
-#define PMC_DEVID_SOCM	0x7e7f
-#define PMC_DEVID_IOEP	0x7ecf
-#define PMC_DEVID_IOEM	0x7ebf
 static struct pmc_info mtl_pmc_info_list[] = {
 	{
 		.guid	= SOCP_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_SOCM,
+		.devid	= PMC_DEVID_MTL_SOCM,
 		.map	= &mtl_socm_reg_map,
 	},
 	{
 		.guid	= IOEP_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_IOEP,
+		.devid	= PMC_DEVID_MTL_IOEP,
 		.map	= &mtl_ioep_reg_map,
 	},
 	{
 		.guid	= IOEM_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_IOEM,
+		.devid	= PMC_DEVID_MTL_IOEM,
 		.map	= &mtl_ioem_reg_map
 	},
 	{}
-- 
2.43.0


