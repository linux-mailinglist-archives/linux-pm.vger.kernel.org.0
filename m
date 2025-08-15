Return-Path: <linux-pm+bounces-32459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A0B28881
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 00:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD45C4726
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 22:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323DD2727E5;
	Fri, 15 Aug 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQe64OwF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C99426AA88;
	Fri, 15 Aug 2025 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297980; cv=none; b=HC7ZyesVV5d39iA/jNjY8ksgxrTgKR0Eqyga7yI3zN8DfTh21ujPfKIlmTl4vWHZjVqGkf7Gi087xDgcam6LcVsWcor93y+0yyndpZsEUpCEJTIjnaEqknN3nDLt/IVLaK3nKt90geiSF2vbGOxvBVHTWoSjSHy6FSjeRO8Qaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297980; c=relaxed/simple;
	bh=z3bNqdRrDC37+83dmJwKJUGvPN5EJnjUN4Qf25BVkDo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJOVu7IezXgsu+wqsJpczF1gx46Y14UQbLaVVXYn+zbuVC1RVC1o6720dgsgpdBc/OcaGKK1kzzRf9GHPWzQoiXKCqZZhhh6P4mNyVnJShdZaE1JgKpd3uc/JJL/0RGLudM6GE4IV1rJM9iGax+MCcoAZqwBBL5wjHBtlpPEMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQe64OwF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755297978; x=1786833978;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=z3bNqdRrDC37+83dmJwKJUGvPN5EJnjUN4Qf25BVkDo=;
  b=cQe64OwFBBCzEYx0ueNM0IwlHRoa8XjV/rnnYYh/BAnyPpqLI2GvvS1F
   RH0H2adXm+f9UKgVtIJ+nfZFpYuI4oIjqMH4dFg45EXEtNIfqto3EBc0y
   Rbdi4WbfeS0YRRbtvDdOUsYRINmmCu1t5dyPA2wY5o0TGQ7oyeUJRaXIz
   DEtYkPq3bEDRxDPJnIxeQMjrBnHSsKcVysshJ4fUTunVKIyUhyGVd7fdF
   M56gwYmLqJ0lz4Wps7vGPNNqzVqdVy6vqyInufDsRxZm17mw59rfSYx43
   /1JbidU+noUnh31R7Jpo8X3COuFp8+DzVDzRonmtRrGDYbC+OTkOK50Kw
   Q==;
X-CSE-ConnectionGUID: uUB/t1TNSfSygdCZ6rLa4A==
X-CSE-MsgGUID: SfTYwQGgTGaGxunMXd97wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57724948"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57724948"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:17 -0700
X-CSE-ConnectionGUID: YOL2IUhEQCebQ0Gd+SMCmA==
X-CSE-MsgGUID: gJHWa4tISl6ti6sBhcK7SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166734418"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.223.173])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:16 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 4/6] platform/x86:intel/pmc: Show substate requirement for S0ix blockers
Date: Fri, 15 Aug 2025 15:46:02 -0700
Message-ID: <20250815224611.2460255-5-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to read and show S0ix blocker substate requirements.
Starting from Panther Lake, substate requirement data is provided
based on S0ix blockers instead of all low power mode requirements.
For platforms that support this new feature, add support to display
substate requirements based on S0ix blockers.

Change the "substate_requirements" attribute of Intel PMC Core
driver to show the substate requirements for each S0ix blocker
and the corresponding S0ix blocker value.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  |   4 +
 drivers/platform/x86/intel/pmc/core.c | 126 ++++++++++++++++++++++++--
 drivers/platform/x86/intel/pmc/core.h |  14 +++
 drivers/platform/x86/intel/pmc/lnl.c  |   2 +
 drivers/platform/x86/intel/pmc/mtl.c  |   2 +
 5 files changed, 138 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 9d66d65e75779..17ad87b392abe 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -725,9 +725,11 @@ struct pmc_dev_info arl_pmc_dev = {
 	.dmu_guid = ARL_PMT_DMU_GUID,
 	.regmap_list = arl_pmc_info_list,
 	.map = &arl_socs_reg_map,
+	.sub_req_show = &pmc_core_substate_req_regs_fops,
 	.suspend = cnl_suspend,
 	.resume = arl_resume,
 	.init = arl_core_init,
+	.sub_req = pmc_core_pmt_get_lpm_req,
 };
 
 struct pmc_dev_info arl_h_pmc_dev = {
@@ -735,7 +737,9 @@ struct pmc_dev_info arl_h_pmc_dev = {
 	.dmu_guid = ARL_PMT_DMU_GUID,
 	.regmap_list = arl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
+	.sub_req_show = &pmc_core_substate_req_regs_fops,
 	.suspend = cnl_suspend,
 	.resume = arl_h_resume,
 	.init = arl_h_core_init,
+	.sub_req = pmc_core_pmt_get_lpm_req,
 };
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index cbfdcdc50ad21..a0b948a875a5a 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -851,6 +851,68 @@ static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index,
 	}
 }
 
+static int pmc_core_substate_blk_req_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	unsigned int pmc_index;
+
+	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs); pmc_index++) {
+		const struct pmc_bit_map **maps;
+		unsigned int arr_size, r_idx;
+		u32 offset, counter;
+		u32 *lpm_req_regs;
+		struct pmc *pmc;
+
+		pmc = pmcdev->pmcs[pmc_index];
+		if (!pmc || !pmc->lpm_req_regs)
+			continue;
+
+		lpm_req_regs = pmc->lpm_req_regs;
+		maps = pmc->map->s0ix_blocker_maps;
+		offset = pmc->map->s0ix_blocker_offset;
+		arr_size = pmc_core_lpm_get_arr_size(maps);
+
+		/* Display the header */
+		pmc_core_substate_req_header_show(s, pmc_index, HEADER_VALUE);
+
+		for (r_idx = 0; r_idx < arr_size; r_idx++) {
+			const struct pmc_bit_map *map;
+
+			for (map = maps[r_idx]; map->name; map++) {
+				int mode;
+
+				if (!map->blk)
+					continue;
+
+				counter = pmc_core_reg_read(pmc, offset);
+				seq_printf(s, "pmc%d: %34s |", pmc_index, map->name);
+				pmc_for_each_mode(mode, pmcdev) {
+					bool required = *lpm_req_regs & BIT(mode);
+
+					seq_printf(s, " %9s |", required ? "Required" : " ");
+				}
+				seq_printf(s, " %9d |\n", counter);
+				offset += map->blk * S0IX_BLK_SIZE;
+				lpm_req_regs++;
+			}
+		}
+	}
+	return 0;
+}
+
+static int pmc_core_substate_blk_req_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pmc_core_substate_blk_req_show, inode->i_private);
+}
+
+const struct file_operations pmc_core_substate_blk_req_fops = {
+	.owner		= THIS_MODULE,
+	.open		= pmc_core_substate_blk_req_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -941,7 +1003,19 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 	}
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_req_regs);
+
+static int pmc_core_substate_req_regs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pmc_core_substate_req_regs_show, inode->i_private);
+}
+
+const struct file_operations pmc_core_substate_req_regs_fops = {
+	.owner		= THIS_MODULE,
+	.open		= pmc_core_substate_req_regs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 
 static unsigned int pmc_core_get_crystal_freq(void)
 {
@@ -1274,7 +1348,7 @@ static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 	debugfs_remove_recursive(pmcdev->dbgfs_dir);
 }
 
-static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
+static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	struct pmc *primary_pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	struct dentry *dir;
@@ -1341,7 +1415,7 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	if (primary_pmc->lpm_req_regs) {
 		debugfs_create_file("substate_requirements", 0444,
 				    pmcdev->dbgfs_dir, pmcdev,
-				    &pmc_core_substate_req_regs_fops);
+				    pmc_dev_info->sub_req_show);
 	}
 
 	if (primary_pmc->map->pson_residency_offset && pmc_core_is_pson_residency_enabled(pmcdev)) {
@@ -1409,8 +1483,7 @@ static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *m
  * +----+---------------------------------------------------------+
  *
  */
-static int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc,
-				    struct telem_endpoint *ep)
+int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep)
 {
 	const u8 *lpm_indices;
 	int num_maps, mode_offset = 0;
@@ -1448,7 +1521,37 @@ static int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc,
 	return ret;
 }
 
-static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
+int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
+				 struct telem_endpoint *ep)
+{
+	u32 num_blocker, sample_id;
+	unsigned int index;
+	u32 *req_offset;
+	int ret;
+
+	num_blocker = pmc->map->num_s0ix_blocker;
+	sample_id = pmc->map->blocker_req_offset;
+
+	pmc->lpm_req_regs = devm_kcalloc(&pmcdev->pdev->dev, num_blocker,
+					 sizeof(u32), GFP_KERNEL);
+	if (!pmc->lpm_req_regs)
+		return -ENOMEM;
+
+	req_offset = pmc->lpm_req_regs;
+	for (index = 0; index < num_blocker; index++) {
+		ret = pmt_telem_read32(ep, sample_id, req_offset, 1);
+		if (ret) {
+			dev_err(&pmcdev->pdev->dev,
+				"couldn't read Low Power Mode requirements: %d\n", ret);
+			return ret;
+		}
+		sample_id++;
+		req_offset++;
+	}
+	return 0;
+}
+
+static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	struct pci_dev *pcidev __free(pci_dev_put) = NULL;
 	struct telem_endpoint *ep;
@@ -1456,11 +1559,12 @@ static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
 	u32 guid;
 	int ret;
 
-	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, func));
+	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, pmc_dev_info->pci_func));
 	if (!pcidev)
 		return -ENODEV;
 
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+		int (*sub_req)(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep);
 		struct pmc *pmc;
 
 		pmc = pmcdev->pmcs[i];
@@ -1477,7 +1581,9 @@ static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
 			return -EPROBE_DEFER;
 		}
 
-		ret = pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
+		sub_req = pmc_dev_info->sub_req;
+		ret = sub_req(pmcdev, pmc, ep);
+
 		pmt_telem_unregister_endpoint(ep);
 		if (ret)
 			return ret;
@@ -1592,7 +1698,7 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
 
 	if (ssram) {
-		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info->pci_func);
+		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info);
 		if (ret)
 			goto unmap_regbase;
 	}
@@ -1766,7 +1872,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(primary_pmc);
 	pmc_core_do_dmi_quirks(primary_pmc);
 
-	pmc_core_dbgfs_register(pmcdev);
+	pmc_core_dbgfs_register(pmcdev, pmc_dev_info);
 	pm_report_max_hw_sleep(FIELD_MAX(SLP_S0_RES_COUNTER_MASK) *
 			       pmc_core_adjust_slp_s0_step(primary_pmc, 1));
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 4a94a4ee031e6..bfe8fba808063 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -344,6 +344,8 @@ struct pmc_bit_map {
  * @pm_read_disable_bit: Bit index to read PMC_READ_DISABLE
  * @slps0_dbg_offset:	PWRMBASE offset to SLP_S0_DEBUG_REG*
  * @s0ix_blocker_offset PWRMBASE offset to S0ix blocker counter
+ * @num_s0ix_blocker:	Number of S0ix blockers
+ * @blocker_req_offset:	Telemetry offset to S0ix blocker low power mode substate requirement table
  *
  * Each PCH has unique set of register offsets and bit indexes. This structure
  * captures them to have a common implementation.
@@ -369,6 +371,8 @@ struct pmc_reg_map {
 	const u32 ltr_ignore_max;
 	const u32 pm_vric1_offset;
 	const u32 s0ix_blocker_offset;
+	const u32 num_s0ix_blocker;
+	const u32 blocker_req_offset;
 	/* Low Power Mode registers */
 	const int lpm_num_maps;
 	const int lpm_num_modes;
@@ -474,18 +478,22 @@ enum pmc_index {
  *			SSRAM support.
  * @map:		Pointer to a pmc_reg_map struct that contains platform
  *			specific attributes of the primary PMC
+ * @sub_req_show:	File operations to show substate requirements
  * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
  * @init:		Function to perform platform specific init action
+ * @sub_req:		Function to achieve low power mode substate requirements
  */
 struct pmc_dev_info {
 	u8 pci_func;
 	u32 dmu_guid;
 	struct pmc_info *regmap_list;
 	const struct pmc_reg_map *map;
+	const struct file_operations *sub_req_show;
 	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
 	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
+	int (*sub_req)(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep);
 };
 
 extern const struct pmc_bit_map msr_map[];
@@ -531,6 +539,12 @@ extern struct pmc_dev_info ptl_pmc_dev;
 
 void cnl_suspend(struct pmc_dev *pmcdev);
 int cnl_resume(struct pmc_dev *pmcdev);
+int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep);
+int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
+				 struct telem_endpoint *ep);
+
+extern const struct file_operations pmc_core_substate_req_regs_fops;
+extern const struct file_operations pmc_core_substate_blk_req_fops;
 
 #define pmc_for_each_mode(mode, pmcdev)						\
 	for (unsigned int __i = 0, __cond;					\
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index e08a77c778c2c..6fa027e7071f4 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -574,7 +574,9 @@ struct pmc_dev_info lnl_pmc_dev = {
 	.pci_func = 2,
 	.regmap_list = lnl_pmc_info_list,
 	.map = &lnl_socm_reg_map,
+	.sub_req_show = &pmc_core_substate_req_regs_fops,
 	.suspend = cnl_suspend,
 	.resume = lnl_resume,
 	.init = lnl_core_init,
+	.sub_req = pmc_core_pmt_get_lpm_req,
 };
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index faa13a7ee688f..0b87e10f864e6 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -997,7 +997,9 @@ struct pmc_dev_info mtl_pmc_dev = {
 	.dmu_guid = MTL_PMT_DMU_GUID,
 	.regmap_list = mtl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
+	.sub_req_show = &pmc_core_substate_req_regs_fops,
 	.suspend = cnl_suspend,
 	.resume = mtl_resume,
 	.init = mtl_core_init,
+	.sub_req = pmc_core_pmt_get_lpm_req,
 };
-- 
2.43.0


