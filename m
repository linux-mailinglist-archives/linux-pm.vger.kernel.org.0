Return-Path: <linux-pm+bounces-13092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0249634D1
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CBB1C244CA
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B511B1424;
	Wed, 28 Aug 2024 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixzDptns"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8391AED59;
	Wed, 28 Aug 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884184; cv=none; b=Ro1pYzAnw/c4BnoWnF7RI8ZGsV1Kyst2Mi6GUTxj3p/71UwPxNHJDR0S+wyX7og4bK7H9icxG3aclI0zDSETRFWOXnPZ09KraxOkjsw9jZfC0BTtQXOo91lqHRjkbiVt1th2zrdofRMyS9s9Nr0NrVoQwi1zD1OXqq38dR+13TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884184; c=relaxed/simple;
	bh=+6ypUREh6CjBpq87FU9GWpMAMxnxx2K9+TbnHVMNd/A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZduDiKmj6sm+hNfMZn5cu4uqcHR8K7+uyh3tH0jBNpUocAdo0h980NMBDQmaXEuNKCdojlo8pRpd7YcZVc8KuyIk/turm2+UEE/n5dkmvfpcZCyRqjW/rur37u81R8EyXiA5PdM1IoeHptjH2nWFiPmkPQPIIvaTn4SVZmpX/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixzDptns; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884183; x=1756420183;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+6ypUREh6CjBpq87FU9GWpMAMxnxx2K9+TbnHVMNd/A=;
  b=ixzDptns+Pjho/ZbxR4pn4yhvy5XMaFTyDbdBt7mbPG/VrSqbsc0OYSJ
   +fJf6RECD/LDRFErYEFOy/e5vbBS+gjNUffaFYda57A3KAckS+ER7F+r4
   EVAwbHoljl25tlElJnLe18mv0QElOYwTh3jeKuasUwUzkvpGdC88wdwCW
   ea2P+B2zC1ORfSBb+12WxS7VwoROy18IAMJavdeUQnOzOf91pE1lCLn00
   K+PEb5kKNir2fp7W9129bOI/ZFlY/GF5v18C+sgN5Rk3LYjsJyv0FSM2e
   HP/Vd6WU8sjuFfiMzvZp1aJBSsMZiVLTKemmHnxP+B+fNNWtdgVAyNjwE
   A==;
X-CSE-ConnectionGUID: ILQOWaGbT4ChfcjW9LpdSw==
X-CSE-MsgGUID: Z4xGHwqWSG2WR/whgyxDDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23406494"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23406494"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:41 -0700
X-CSE-ConnectionGUID: ptA1ImA0SSOpx2e5f2XtnA==
X-CSE-MsgGUID: coBX8g0URLS3F4RrrZFS8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271830"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.220.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:42 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 10/11] platform/x86:intel/pmt: Get PMC from SSRAM for Lunar Lake
Date: Wed, 28 Aug 2024 15:29:25 -0700
Message-ID: <20240828222932.1279508-11-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to discover and achieve PMC information from Intel
SSRAM Telemetry driver for Lunar Lake platforms.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/lnl.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index e7a8077d1a3e..109b08d43fc8 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -13,6 +13,14 @@
 
 #include "core.h"
 
+static struct pmc_info lnl_pmc_info_list[] = {
+	{
+		.devid	= PMC_DEVID_LNL_SOCM,
+		.map	= &lnl_socm_reg_map,
+	},
+	{}
+};
+
 const struct pmc_bit_map lnl_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
@@ -561,10 +569,20 @@ int lnl_core_init(struct pmc_dev *pmcdev)
 	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = lnl_resume;
 
-	pmc->map = &lnl_socm_reg_map;
-	ret = get_primary_reg_base(pmc);
-	if (ret)
-		return ret;
+	pmcdev->regmap_list = lnl_pmc_info_list;
+	ret = pmc_core_ssram_get_reg_base(pmcdev);
+
+	/* Try again later after Intel PMC SSRAM Telemetry driver finishes probe */
+	if (ret == -EAGAIN)
+		return -EPROBE_DEFER;
+
+	/* If regbase not assigned, set map and discover using legacy method */
+	if (ret) {
+		pmc->map = &lnl_socm_reg_map;
+		ret = get_primary_reg_base(pmc);
+		if (ret)
+			return ret;
+	}
 
 	pmc_core_get_low_power_modes(pmcdev);
 
-- 
2.43.0


