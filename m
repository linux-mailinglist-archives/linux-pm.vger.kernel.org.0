Return-Path: <linux-pm+bounces-13085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DC49634BC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4077C1F22E63
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F671AE040;
	Wed, 28 Aug 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcDohHN4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E681AD413;
	Wed, 28 Aug 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884180; cv=none; b=ufUnXmWtQHQ9Bv/pwg+QQzz4wlFa/CLCZ5SeYJOU0C4pPgNenEkgmDFzOppKScejAGH21IxgZtOb6GPWW940ficUGWyXNsVq1277UtbMif0JYvcFDj1KHws57Ouni4wlUXh0M9OCA8hQWnyalLEMD7EPugRQMhnG4kz1oUFtBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884180; c=relaxed/simple;
	bh=U1A696TgMwoQFywvda9mLAsMEuUIakY4TjYmGm+CI/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDT/HmEB1ZGo56Ob735pPQrVe/pIPgqm07+Ue3mFtA0j8cVnByN3tzxga2k8f3JwVQR3VDqFdUS0/DlPlsiUZ7UaBDTBoFtCPnTC2p/ujWw0wT6d2lA9p09bSyqSQeoHZNEXcfU1Gim7KS80uf++3yfzCXmwElMIZa3Dhcj1Yrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcDohHN4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884178; x=1756420178;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=U1A696TgMwoQFywvda9mLAsMEuUIakY4TjYmGm+CI/4=;
  b=YcDohHN4QbzpBHckHsu2GcRb5NY7W4BnDi92rWdG/5jAu8GBzcC4omCd
   Z38b7gav0pQL8EykpPFhvuHT7SiMY9LsRrTD76v+lRR5ati8jOWjorlYQ
   5i9EnxPHuR5tx91B3cWUOxqgH7ySxdxoC+2s2Je+s2asY2htnTeQB8zNg
   JUa4F6ncaNpYYOEAMK/fgEBN0iM3OkZXbUz5pTQI1fV6z/O/nEbFJ5bcN
   RaxoNJyO6YbI5OenVL7jDji/a9ZV7ZKO5LqUxAlmmnHlgPYqYF525MZlT
   iwqecJC5zc2eWGKK5ARX3Bn0grBd/On67TSwZT+BoPlHue3Ll00FlCANn
   g==;
X-CSE-ConnectionGUID: ibEBIjTlSQm8uJKWH3rbEw==
X-CSE-MsgGUID: 10HAuw9GStGqqEnRAS70vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23406464"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23406464"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:37 -0700
X-CSE-ConnectionGUID: POyY0v0ERwCmN+qTqJIUYA==
X-CSE-MsgGUID: 7Ld5R8abQOiKyKvxIIb/Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271795"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.220.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:37 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 03/11] platform/x86:intel/pmc: Move PMC devid to core.h
Date: Wed, 28 Aug 2024 15:29:18 -0700
Message-ID: <20240828222932.1279508-4-xi.pardee@linux.intel.com>
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

Move PMC devid definition for each PMC of Arrow Lake and Meteor
Lake platforms to core.h. This patch is a preparation step to
introduce a new SSRAM Telemetry driver which will be using the
PMC devid.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  |  9 +++------
 drivers/platform/x86/intel/pmc/core.h | 10 ++++++++++
 drivers/platform/x86/intel/pmc/mtl.c  |  9 +++------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index e10527c4e3e0..870da98ceb41 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -650,23 +650,20 @@ const struct pmc_reg_map arl_pchs_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
-#define PMC_DEVID_SOCS 0xae7f
-#define PMC_DEVID_IOEP 0x7ecf
-#define PMC_DEVID_PCHS 0x7f27
 static struct pmc_info arl_pmc_info_list[] = {
 	{
 		.guid	= IOEP_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_IOEP,
+		.devid	= PMC_DEVID_MTL_IOEP,
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
 	{}
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 9a1cc01f31d9..6763e59180a4 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -290,6 +290,16 @@ enum ppfear_regs {
 #define LNL_PPFEAR_NUM_ENTRIES			12
 #define LNL_S0IX_BLOCKER_OFFSET			0x2004
 
+/* SSRAM PMC Device ID*/
+/* ARL */
+#define PMC_DEVID_ARL_SOCS	0xae7f
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
index c7d15d864039..908b5f8bb6e5 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -947,23 +947,20 @@ const struct pmc_reg_map mtl_ioem_reg_map = {
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


