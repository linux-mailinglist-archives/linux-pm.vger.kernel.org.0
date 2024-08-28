Return-Path: <linux-pm+bounces-13086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D5B9634C0
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6821F1F227F9
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2465D1AE845;
	Wed, 28 Aug 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpBcd2gx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24B1AD9F4;
	Wed, 28 Aug 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884181; cv=none; b=Av0gJDleUsHOziqCVct7nHa+50JaRx2fnZE5o0ip7kqqBRk+WKmg3UlvHlNJciKpNS9apUk8uQgEVfnpbygjlp2leDP2oOQEj5Ez8ZaA6dpUp+k+1SFFvfC9QbEzP4p+V5OhZA490UsZZs4RcG+7TWKD0V9fAzxHTGbNQeawuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884181; c=relaxed/simple;
	bh=LBN1S2oETKSvm4chJQ2hHMQbGl5tWy33z3L1pdFM2ww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXpipJ3YmYDeD0kvmffAXa1z8VXOSp+0nfSsSQl1JPKqBlol+FKFzTRFhi9dVGs5QpTdmJFsC8mRzGVC1lo6u/lOQ3QdsG+Tj0JgIdDgWXyGoffAvB+9HEt4kQ8wJ42ilmV780kkKLIauS9AHiQQebWW1wknVTVJNurJt6Cbo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpBcd2gx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884179; x=1756420179;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=LBN1S2oETKSvm4chJQ2hHMQbGl5tWy33z3L1pdFM2ww=;
  b=XpBcd2gxK3XxgVgreO/HCP6dYRDF9XfoI4Dw5VEpnA7R7d8UfIHDx7Wl
   sozQIUjLaxuEHbzk9n4Cn45ubFVTsv5UbD4we96jfI2aHxGOgwY9jH7qz
   vz6L96d27AZk3eyanR73/tp83Nkfw26tvc273IxQ5X6T3BmkIX7yiokP5
   2WScIPHF3ll2mpSoCt1UK/h/3a5soC74Q1xZ38lhJDHWmG/oLYmQHwzjd
   lySLduZkac3n3uoHhuhA2IJsZnt10P3S1s9D94dE13uA+mEniOTyHS2Q+
   NcrpEIMcJWDJhmv56Rw8NEbEHNIRO2kiyw+X9ZIqFwKaDxTw1NOLYqAH/
   Q==;
X-CSE-ConnectionGUID: 1xzgqbEsTd+iF8nOcXtsqQ==
X-CSE-MsgGUID: +fOu2RBdR3O96WpLgyRENg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23406467"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23406467"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:38 -0700
X-CSE-ConnectionGUID: t/oweOxyQwWA30V03I91ng==
X-CSE-MsgGUID: gbmpdlddStWdF+wmRiKf6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271798"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.220.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:38 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 04/11] platform/x86:intel/pmc: Convert index variables to be unsigned
Date: Wed, 28 Aug 2024 15:29:19 -0700
Message-ID: <20240828222932.1279508-5-xi.pardee@linux.intel.com>
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

Convert the index variables type to be unsigned to avoid confusion
and error.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c            | 5 +++--
 drivers/platform/x86/intel/pmc/core.h            | 2 +-
 drivers/platform/x86/intel/pmc/ssram_telemetry.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 630ce2087552..8984041f35f4 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1716,7 +1716,8 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
 
 int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
 {
-	int ret, i;
+	unsigned int i;
+	int ret;
 
 	if (!pmcdev->ssram_pcidev)
 		return -ENODEV;
@@ -1743,7 +1744,7 @@ const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
 }
 
 int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
-		     const struct pmc_reg_map *reg_map, int pmc_index)
+		     const struct pmc_reg_map *reg_map, unsigned int pmc_index)
 {
 	struct pmc *pmc = pmcdev->pmcs[pmc_index];
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 6763e59180a4..5af1d41a83f7 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -606,7 +606,7 @@ extern void pmc_core_set_device_d3(unsigned int device);
 extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
 extern const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid);
 extern int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
-			    const struct pmc_reg_map *reg_map, int pmc_index);
+			    const struct pmc_reg_map *reg_map, unsigned int pmc_index);
 
 int spt_core_init(struct pmc_dev *pmcdev);
 int cnp_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
index 0a2bfca5ff41..4b21d9cf310a 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -75,7 +75,7 @@ static inline u64 get_base(void __iomem *addr, u32 offset)
 }
 
 static int
-pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
+pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, unsigned int pmc_idx, u32 offset)
 {
 	struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
 	void __iomem __free(pmc_core_iounmap) *tmp_ssram = NULL;
-- 
2.43.0


