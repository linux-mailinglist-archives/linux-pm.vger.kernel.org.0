Return-Path: <linux-pm+bounces-22116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE42A367AF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 22:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8459616C256
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2151EEA4E;
	Fri, 14 Feb 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSkcSXCP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D511DC198;
	Fri, 14 Feb 2025 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569463; cv=none; b=WDY3go2mi9PYsjrJqwSylcIqCK6TJy0kidRY13KHG/qw/J14S7zhn4hA2d3uGxijz6S17CxH26Lp4Qk+eHfL1ytX+2pp/MENP/E+ZLPO6Gdi4rrMCce9LLwVvt9wFyYBZklCJD8bqNd4Qbah/82gb7yTiF2b4hk4Ve4i+EZTSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569463; c=relaxed/simple;
	bh=jFwXObLbAoOQ6HM+co2CGEUGsLMoofoyAZ8wYObsmMs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtnqJtmDO6UH+s6yfYkQkj2Zod6WnbEGm5NqbHsbr8r0Z4E9UEscDubRV4suPA//Jt0sZlBGF9zksTUWBFM3ETazm17HmzyLTJFUNN8DM1l9F1ceH9pV/j7wbEsQuv1zY+Hf0Qe2U+9jAuLWaGcaVVYrqXg0ioLGinR2VzUi+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSkcSXCP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739569462; x=1771105462;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=jFwXObLbAoOQ6HM+co2CGEUGsLMoofoyAZ8wYObsmMs=;
  b=aSkcSXCPupllFx5Lru/QE7thINOw4WND8WWIrRATvtgpAE61NxoEZM6k
   YdrfUABKcz/2JtPcYLs0ARgR0iVRJYai6b0hcd3+eyOtYvHsEo7UFwpVE
   BlIRmrPyVGHymZww6D/sk2zkbhsspHPGDLUEBo7pr2u+9r+/u7QBrT1ds
   BWEg9WdmJRmgSDp+lMFFhAxXnzDi+rSmxn15JtlXt3+sziNUicw9i8Yyj
   riCb4K/Ee7HNmHlkC4X8FLEEFgDTaUhqMxV4MAFcMxmDe01V6r/5M3Jes
   n6WWc2eUjER4fPf1bG8IwWzz/Ilo98BIMiIZOcMOcNA1XiJKexaKFXrOv
   w==;
X-CSE-ConnectionGUID: Twsstv+CRkCjEtNJDf0k1Q==
X-CSE-MsgGUID: s4ThZnplQmKQ2CRLO+VppQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40253129"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40253129"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 13:44:21 -0800
X-CSE-ConnectionGUID: 3ntd6YJNQv+/jT40yqhbFQ==
X-CSE-MsgGUID: ZyGBSRpSQm6qNnN6Uc+WiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="113546316"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.223.241])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 13:44:20 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	rajvi0912@gmail.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 3/3] platform/x86/intel/pmc: Remove unneeded extern keyword in header
Date: Fri, 14 Feb 2025 13:44:11 -0800
Message-ID: <20250214214416.10150-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214214416.10150-1-xi.pardee@linux.intel.com>
References: <20250214214416.10150-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unneeded extern keyword in header file. Functions are
extern by default so extern keyword is not unnecessary for
function declaration.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 21c247beee50d..945a1c440ccab 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -484,17 +484,17 @@ extern const struct pmc_bit_map mtl_socm_signal_status_map[];
 extern const struct pmc_reg_map mtl_socm_reg_map;
 extern const struct pmc_reg_map mtl_ioep_reg_map;
 
-extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
-extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
+void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
+int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
 int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
-extern void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
-extern void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid);
-extern void pmc_core_set_device_d3(unsigned int device);
+void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
+void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid);
+void pmc_core_set_device_d3(unsigned int device);
 
-extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
+int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
 
 int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
 
-- 
2.43.0


