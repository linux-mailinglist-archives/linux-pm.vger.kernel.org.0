Return-Path: <linux-pm+bounces-34421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C5B5233D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 23:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC915E376F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 21:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EEE3090E8;
	Wed, 10 Sep 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOOyUbV5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D48305942;
	Wed, 10 Sep 2025 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538398; cv=none; b=BuuvtE41K+JgRYluM62HculZIocAVhiSkzz3LfLdm0eZl4p1eavV/zoT+fcGg12ZtQxaIT8T6R7MnnFQS5g1SmAP2pHx6vtyC8yo1K7GheM2n8ya0ML/Q1/BaGIMg7puJ5vy14WLFydkaubqoLI4UUKAB+psB6uTtzdmd/Ry/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538398; c=relaxed/simple;
	bh=DJyvuZb2q0wl+roO0aJ2is79poL3VyMRrAuv08TmMi8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hp2rMgMXl8tuRZZ5Q7kCBuDIf/4Vlkg9nOOhd9pWu1n+rd3XGR2t+UWB6X3YFYfybfO9AtQuPcfDnU9SFVqqA7M3hoTb383K1WOERP9axFHG2RoYS8ZjjsV1mIi8BFsWiJsEYjW4/HXakFFEqlVqcD1W0Y/+tCb1dl9qYf4Uuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOOyUbV5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757538397; x=1789074397;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=DJyvuZb2q0wl+roO0aJ2is79poL3VyMRrAuv08TmMi8=;
  b=mOOyUbV5Y21GnyW/rha5o9RtMQoaCJ8DmAY/roXD9WzTpE5YlBTEYn80
   x/NU80CBbm45kylepMl7lOm8nQqdZafsF+oefO/lx8kPX5zhZ+kj+VFHU
   xLAFEuHP13pMAHLLdSzTD0Z/r2rmtBBbs2hgFOAjWXHWEyAOglZHN9uwY
   T9i0u1WVvanhJikW/Z8+tbpcMwfGzcfzDuj4xwvbABRB6eP3kjERXSkQj
   2LkxATqN4n3JTuWzs/SEMEqVcVhTOqNahVSYm8GpAc3zSsXFMs2sTOnLU
   IuW9DQy2xdtFnchIq6GhL/rFYOcrp4JDnZOjWVmaEqiFtBlj4C5oH8Cd/
   Q==;
X-CSE-ConnectionGUID: z93+omlpR6eDqnJm+Z1j4A==
X-CSE-MsgGUID: d2IZHP3XRXyOM5iRSeExhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82448488"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82448488"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:36 -0700
X-CSE-ConnectionGUID: D9stFUooS5Or7OiGExRLHQ==
X-CSE-MsgGUID: aOBOq/KmR1GG/z9j+BTMgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="177842754"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:36 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 4/5] platform/x86:intel/pmc: Show substate requirement for S0ix blockers
Date: Wed, 10 Sep 2025 14:06:24 -0700
Message-ID: <20250910210629.11198-5-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910210629.11198-1-xi.pardee@linux.intel.com>
References: <20250910210629.11198-1-xi.pardee@linux.intel.com>
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
 drivers/platform/x86/intel/pmc/core.c | 121 +++++++++++++++++++++++---
 drivers/platform/x86/intel/pmc/core.h |  14 +++
 drivers/platform/x86/intel/pmc/lnl.c  |   2 +
 drivers/platform/x86/intel/pmc/mtl.c  |   2 +
 5 files changed, 133 insertions(+), 10 deletions(-)

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
index b3e9ea31db9c6..3a44644909015 100644
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
+				seq_printf(s, "pmc%u: %34s |", pmc_index, map->name);
+				pmc_for_each_mode(mode, pmcdev) {
+					bool required = *lpm_req_regs & BIT(mode);
+
+					seq_printf(s, " %9s |", required ? "Required" : " ");
+				}
+				seq_printf(s, " %9u |\n", counter);
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
@@ -1448,7 +1521,35 @@ static int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc,
 	return ret;
 }
 
-static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
+int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
+				 struct telem_endpoint *ep)
+{
+	u32 num_blocker, sample_offset;
+	unsigned int index;
+	u32 *req_offset;
+	int ret;
+
+	num_blocker = pmc->map->num_s0ix_blocker;
+	sample_offset = pmc->map->blocker_req_offset;
+
+	pmc->lpm_req_regs = devm_kcalloc(&pmcdev->pdev->dev, num_blocker,
+					 sizeof(u32), GFP_KERNEL);
+	if (!pmc->lpm_req_regs)
+		return -ENOMEM;
+
+	req_offset = pmc->lpm_req_regs;
+	for (index = 0; index < num_blocker; index++, req_offset++) {
+		ret = pmt_telem_read32(ep, index + sample_offset, req_offset, 1);
+		if (ret) {
+			dev_err(&pmcdev->pdev->dev,
+				"couldn't read Low Power Mode requirements: %d\n", ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	struct pci_dev *pcidev __free(pci_dev_put) = NULL;
 	struct telem_endpoint *ep;
@@ -1456,7 +1557,7 @@ static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
 	u32 guid;
 	int ret;
 
-	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, func));
+	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, pmc_dev_info->pci_func));
 	if (!pcidev)
 		return -ENODEV;
 
@@ -1477,7 +1578,7 @@ static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
 			return -EPROBE_DEFER;
 		}
 
-		ret = pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
+		ret = pmc_dev_info->sub_req(pmcdev, pmc, ep);
 		pmt_telem_unregister_endpoint(ep);
 		if (ret)
 			return ret;
@@ -1592,7 +1693,7 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
 
 	if (ssram) {
-		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info->pci_func);
+		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info);
 		if (ret)
 			goto unmap_regbase;
 	}
@@ -1767,7 +1868,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(primary_pmc);
 	pmc_core_do_dmi_quirks(primary_pmc);
 
-	pmc_core_dbgfs_register(pmcdev);
+	pmc_core_dbgfs_register(pmcdev, pmc_dev_info);
 	pm_report_max_hw_sleep(FIELD_MAX(SLP_S0_RES_COUNTER_MASK) *
 			       pmc_core_adjust_slp_s0_step(primary_pmc, 1));
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 47101f0dd09ce..b554805db689d 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -351,6 +351,8 @@ struct pmc_bit_map {
  * @pm_read_disable_bit: Bit index to read PMC_READ_DISABLE
  * @slps0_dbg_offset:	PWRMBASE offset to SLP_S0_DEBUG_REG*
  * @s0ix_blocker_offset PWRMBASE offset to S0ix blocker counter
+ * @num_s0ix_blocker:	Number of S0ix blockers
+ * @blocker_req_offset:	Telemetry offset to S0ix blocker low power mode substate requirement table
  *
  * Each PCH has unique set of register offsets and bit indexes. This structure
  * captures them to have a common implementation.
@@ -376,6 +378,8 @@ struct pmc_reg_map {
 	const u32 ltr_ignore_max;
 	const u32 pm_vric1_offset;
 	const u32 s0ix_blocker_offset;
+	const u32 num_s0ix_blocker;
+	const u32 blocker_req_offset;
 	/* Low Power Mode registers */
 	const int lpm_num_maps;
 	const int lpm_num_modes;
@@ -481,18 +485,22 @@ enum pmc_index {
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
@@ -542,6 +550,12 @@ extern struct pmc_dev_info wcl_pmc_dev;
 
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


