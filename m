Return-Path: <linux-pm+bounces-29459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD65DAE7708
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 08:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D290D5A0509
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 06:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6842E1F37D4;
	Wed, 25 Jun 2025 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYM43tQX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95391A08BC;
	Wed, 25 Jun 2025 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833111; cv=none; b=ivBCh1fkbfXrfK0Y7WZKojaNh73cLLn2NhkuTGohwcDujUwtUMtas1aR4jFFL+9Fv7CiO18c8ab5AGVO4bmmxZX0F0ph+p3TwHXEf2Md0WlKVpe1ZKPl+DYO2NaSTzjAsHMgtYM+tGetRX6HkAGTcHd/jcYUjQGU4D1RW4VVj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833111; c=relaxed/simple;
	bh=gili3zJVF7ZQ9a+PUONOkac6Rm442IXQ0FJb+Dn1TgA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0hMmFnDYIWgiDJG3fmmpoXZhBftpKP6cgDWnj41WERijicGDIIE2n4NEv9pGnvfUJmMl7Sut2sbwZxAqUdAhIZLDyKsqsbRyf6c3siQ0KNtMC+2jyy9spkH3+BRoPfsr3zIDvzQaCzTb8jgNcUG0knXfMizgADcbhilGNJdD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYM43tQX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750833110; x=1782369110;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=gili3zJVF7ZQ9a+PUONOkac6Rm442IXQ0FJb+Dn1TgA=;
  b=LYM43tQXynulpfj1efVcfS8oTV0OQh2lqPA6P35Hw01Hm6hmLbmU+mi6
   H013fReh1Nf+uTo4XjhRG0tJ0s0JfT9mSBQdadhPixSzBgX4LXi+JGFnc
   xYU0KAaiJPX9P0r5VsEswwVbC1kfHw+HU4cgvmjhllZ/yEbYoWS+wvzZh
   f8YMWjk0NvN6P7AkC2P00PdtpXK3FFvJYezrqBS62vwZYpYW19wKQbFq2
   pMyERoPGeQ36cVlMc0PjMZf9dUF9nlvzy0+YfLoYYWfkvpgGZHt9xK2Ls
   T4Ir64hK7X6TZWhsrMyXK6txh+wYYBdqEI1dzfP/GaxfRXaKo1V4v/hNS
   Q==;
X-CSE-ConnectionGUID: 4hpAklPFQTaIbKIUIhZuOA==
X-CSE-MsgGUID: NZNGkdKqSvqtPtQGe8ucjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53187458"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53187458"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 23:31:49 -0700
X-CSE-ConnectionGUID: UjqQZ+DxT2+emUl8ZHy0Qg==
X-CSE-MsgGUID: +igOKoMORrKQpR8KzakBWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152257574"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.223.140])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 23:31:48 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/5] platform/x86:intel/pmc: Enable SSRAM support for Lunar Lake
Date: Tue, 24 Jun 2025 23:31:38 -0700
Message-ID: <20250625063145.624585-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625063145.624585-1-xi.pardee@linux.intel.com>
References: <20250625063145.624585-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Lunar Lake platforms to achieve PMC information from
Intel PMC SSRAM Telemetry driver and substate requirements data
from telemetry region.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
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


