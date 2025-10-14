Return-Path: <linux-pm+bounces-36101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AADEBDB734
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 23:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BDD8501B07
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 21:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76F230E0C0;
	Tue, 14 Oct 2025 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHBQ7unR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FC730DD0C;
	Tue, 14 Oct 2025 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478387; cv=none; b=t+HFN2E2JtSiUKPUstlL6M/FVWNAF/B9Z9Ml/6v02xh5AMgWf3lfu/DHlVOxFP5wM6EyFlj7pR2yNw/TVWAL2JVEjzNWsx+p2HUBDYSXqA2OtTzIV0eQT6rWJFiq1QbxtiSm3HYk4FJyl/YCiRxC5T2HQIBrNXE4dIJ3HEP+DJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478387; c=relaxed/simple;
	bh=T4YSAgFQWRrKRhaETs7U3RY8Kh4OIIO53punfbcIfQ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7huMfkgNqvV5xT1P0R2O59LzmTzEFo77nOUIe639xzwpMw/tE9BNgG5Smvzwu5ftQXuAy64uwtG2HJEaEWKDQandZfg5tRPLbTkW6fEPWuMtCqxhRSm546Sxw+OuZf/ByVVBk38LUzgZ6DFxy0itX1gL0YEbfhJHTKaLHQAWJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHBQ7unR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760478386; x=1792014386;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=T4YSAgFQWRrKRhaETs7U3RY8Kh4OIIO53punfbcIfQ0=;
  b=bHBQ7unRR85z3kqbixi1MrdM/Gw2IErHd8BRpwPQzOAeU3NEtNWoqYsh
   gsXzqhtufcgK8r31PPkmt80zHjyV0rh5OAra7zftvUQcUPz59n67n5I4C
   hsKk70vZdhnaB5iLFgy10A/LcGouhB3/UKtblV9e6+zpltPz/uWcAB6Mk
   pG+2CXBQS/UxNhY5tzDY6gJ2/jtiqGF2uPm6sImG949XYwTqjJIzQrsG1
   4yMD9y058k25Rgl7XMXv6Y+CO+bx7rleWWkrPlrU7s8ychOlESa4v2OJI
   TG8No5RilAHRDZGVSgIDadtaeI+hyLmkfHZjptkPOSzF+a/7De7hkz/bJ
   A==;
X-CSE-ConnectionGUID: bKpkK8QyRLmnUsVVxa1KmA==
X-CSE-MsgGUID: +hr1h0djRlKyUlcBIhsbNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62682447"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62682447"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:22 -0700
X-CSE-ConnectionGUID: CnXS4/XHSq6T+41S1BDlbQ==
X-CSE-MsgGUID: uv6w6jH2SvKRkCLSFlhwsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="187300343"
Received: from kcaccard-desk.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.111.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:21 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 3/6] platform/x86:intel/pmc: Add DMU GUID to Arrow Lake U/H
Date: Tue, 14 Oct 2025 14:45:31 -0700
Message-ID: <20251014214548.629023-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014214548.629023-1-xi.pardee@linux.intel.com>
References: <20251014214548.629023-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arrow Lake U/H platforms may have multiple GUIDs pointing to the
same telemetry region. Add the second possible GUID to the GUID
list to support the Arrow Lake U/H platforms with this GUID.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 2 +-
 drivers/platform/x86/intel/pmc/core.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index cc05a168c3721..c0698ef35df89 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -733,7 +733,7 @@ struct pmc_dev_info arl_pmc_dev = {
 	.sub_req = pmc_core_pmt_get_lpm_req,
 };
 
-static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, 0x0};
+static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, ARL_H_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info arl_h_pmc_dev = {
 	.pci_func = 2,
 	.dmu_guids = ARL_H_PMT_DMU_GUIDS,
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 83d6e2e833785..d80257b37ca98 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -283,6 +283,7 @@ enum ppfear_regs {
 #define MTL_PMT_DMU_DIE_C6_OFFSET		15
 #define MTL_PMT_DMU_GUID			0x1A067102
 #define ARL_PMT_DMU_GUID			0x1A06A102
+#define ARL_H_PMT_DMU_GUID			0x1A06A101
 
 #define LNL_PMC_MMIO_REG_LEN			0x2708
 #define LNL_PMC_LTR_OSSE			0x1B88
-- 
2.43.0


