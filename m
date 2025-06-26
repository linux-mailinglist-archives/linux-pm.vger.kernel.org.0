Return-Path: <linux-pm+bounces-29595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CE9AEA39B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 18:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA55173C8D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF8211A19;
	Thu, 26 Jun 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMV0l/1z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB12CCC0;
	Thu, 26 Jun 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955911; cv=none; b=bk+wRh5R/wtXb3qxpAMht4H4GIYHrIGOiWgQbyJoNvyEszea44efvmUAmbeQx3ZwX1KQrjys3uiYwku7yEBTB+7Kf1HWt2lec4nIydQtWbV5+jjoAKtbSwdk8P13ojHfZS16j8XmACw443uQ0J82lDXneHDU4iRaQ6Cv48QPvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955911; c=relaxed/simple;
	bh=fbq5l2uaTOLxUk/YzB+CLQA+z/dACanNWFulxm/rV6s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BQl8pF6iABJkveTc8nc3vd3hUUSyJUU668cJb6p6iLq4AAOnBtVRaCVG4sPmVMsCjKrgRixErJNkiNCOTFAYb9ZzWnBkUc9OgFcHqpjy/DQMkaJFr7RPyOWhEtdIGZ3ehxWjM/R/ffxYS3b1FiX4iMpiTpZXcIP780JvE9eZJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMV0l/1z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750955910; x=1782491910;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fbq5l2uaTOLxUk/YzB+CLQA+z/dACanNWFulxm/rV6s=;
  b=dMV0l/1z5tn98U0AftJe9fQElMt4LCIirVaxsiPdd2aPnV5BvrHokRuF
   MPzWxI04364KKrqC1Lcf4eIvIsIaofmu1qk4z7atuKVOD6vdqE2rpqJnf
   ISYcXCrAuDhXu5R6sccq5cTA0biA28RcEHLWAUjWr2bjW7CY9qPYLGgjd
   3kQEudV33Yyp7I+AdjW1lyNdaSZDkaYtSLxNzhj3mMCW254XYt3CCt1pR
   DOPcU5Xpd6+84X5mt6C/IR32e4+EDgzzZAlE4MlMEz5psIH6iW6J5cbsC
   OV4tSxP3BZdsKInPKTJPEYhuPpn2W6W/iFrJqaUOH+HjxAxXexq7M9Wyk
   A==;
X-CSE-ConnectionGUID: lAphZBrNQHieScwLsva0og==
X-CSE-MsgGUID: wOu9cCf1TsOcfKPdAv01ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="64615174"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="64615174"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:38:29 -0700
X-CSE-ConnectionGUID: sWMr28zQRnGSHe/S+AS7cA==
X-CSE-MsgGUID: qoy8WyjdTuuMYgvhC6bAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="152740197"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:38:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 26 Jun 2025 19:38:22 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/5] platform/x86:intel/pmc: Show substate requirement
 for S0ix blockers
In-Reply-To: <20250625063145.624585-5-xi.pardee@linux.intel.com>
Message-ID: <6f43709c-dfcb-059e-758a-be6a56538724@linux.intel.com>
References: <20250625063145.624585-1-xi.pardee@linux.intel.com> <20250625063145.624585-5-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Jun 2025, Xi Pardee wrote:

> Add support to read and show S0ix blocker substate requirements.
> Starting from Panther Lake, substate requirement data is provided
> based on S0ix blockers instead of all low power mode requirements.
> For platforms that support this new feature, add support to display
> substate requirements based on S0ix blockers.

Empty line.

> Change the "substate_requirements" attribute of Intel PMC Core
> driver to show the substate requirements for each S0ix blocker
> and the corresponding S0ix blocker value.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c  |   2 +
>  drivers/platform/x86/intel/pmc/core.c | 111 ++++++++++++++++++++++++--
>  drivers/platform/x86/intel/pmc/core.h |  12 +++
>  drivers/platform/x86/intel/pmc/lnl.c  |   1 +
>  drivers/platform/x86/intel/pmc/mtl.c  |   1 +
>  5 files changed, 121 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index 9d66d65e75779..1852876be234f 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -722,6 +722,7 @@ static int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_
>  
>  struct pmc_dev_info arl_pmc_dev = {
>  	.pci_func = 0,
> +	.telem_info = SUB_REQ_LPM,
>  	.dmu_guid = ARL_PMT_DMU_GUID,
>  	.regmap_list = arl_pmc_info_list,
>  	.map = &arl_socs_reg_map,
> @@ -732,6 +733,7 @@ struct pmc_dev_info arl_pmc_dev = {
>  
>  struct pmc_dev_info arl_h_pmc_dev = {
>  	.pci_func = 2,
> +	.telem_info = SUB_REQ_LPM,
>  	.dmu_guid = ARL_PMT_DMU_GUID,
>  	.regmap_list = arl_pmc_info_list,
>  	.map = &mtl_socm_reg_map,
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 47cc5120e7dd6..e9d281b064462 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -844,6 +844,56 @@ static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index,
>  		seq_printf(s, " %9s |\n", name);
>  }
>  
> +static int pmc_core_substate_blk_req_show(struct seq_file *s, void *unused)
> +{
> +	struct pmc_dev *pmcdev = s->private;
> +	unsigned int pmc_index;
> +	u32 *blk_sub_req_regs;

Why is this here and the other variable in the inner block?

> +
> +	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs); pmc_index++) {
> +		const struct pmc_bit_map **maps;
> +		unsigned int arr_size, r_idx;
> +		u32 offset, counter;
> +		struct pmc *pmc;
> +
> +		pmc = pmcdev->pmcs[pmc_index];
> +		if (!pmc || !pmc->blk_sub_req_regs)
> +			continue;
> +
> +		blk_sub_req_regs = pmc->blk_sub_req_regs;
> +		maps = pmc->map->s0ix_blocker_maps;
> +		offset = pmc->map->s0ix_blocker_offset;
> +		arr_size = pmc_core_lpm_get_arr_size(maps);
> +
> +		/* Display the header */
> +		pmc_core_substate_req_header_show(s, pmc_index, "Value");
> +
> +		for (r_idx = 0; r_idx < arr_size; r_idx++) {
> +			const struct pmc_bit_map *map;
> +
> +			for (map = maps[r_idx]; map->name; map++) {
> +				int mode;
> +
> +				if (!map->blk)
> +					continue;
> +
> +				counter = pmc_core_reg_read(pmc, offset);
> +				seq_printf(s, "pmc%d: %34s |", pmc_index, map->name);
> +				pmc_for_each_mode(mode, pmcdev) {
> +					bool required = *blk_sub_req_regs & BIT(mode);
> +
> +					seq_printf(s, " %9s |", required ? "Required" : " ");
> +				}
> +				seq_printf(s, " %9d |\n", counter);
> +				offset += map->blk * S0IX_BLK_SIZE;
> +				blk_sub_req_regs++;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_blk_req);
> +
>  static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  {
>  	struct pmc_dev *pmcdev = s->private;
> @@ -1335,7 +1385,10 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>  		debugfs_create_file("substate_requirements", 0444,
>  				    pmcdev->dbgfs_dir, pmcdev,
>  				    &pmc_core_substate_req_regs_fops);
> -	}
> +	} else if (primary_pmc->blk_sub_req_regs)
> +		debugfs_create_file("substate_requirements", 0444,
> +				    pmcdev->dbgfs_dir, pmcdev,
> +				    &pmc_core_substate_blk_req_fops);
>
>  	if (primary_pmc->map->pson_residency_offset && pmc_core_is_pson_residency_enabled(pmcdev)) {
>  		debugfs_create_file("pson_residency_usec", 0444,
> @@ -1441,7 +1494,38 @@ static int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc,
>  	return ret;
>  }
>  
> -static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
> +static int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
> +					struct telem_endpoint *ep)
> +{
> +	u32 num_blocker, sample_id;
> +	unsigned int index;
> +	u32 *req_offset;
> +	int ret;
> +
> +	num_blocker = pmc->map->num_s0ix_blocker;
> +	sample_id = pmc->map->blocker_req_offset;
> +
> +	pmc->blk_sub_req_regs = devm_kcalloc(&pmcdev->pdev->dev,
> +					 num_blocker, sizeof(u32),
> +					 GFP_KERNEL);

Correct alignment.

I guess you want to keep those two args on the same line as this would fit 
on 2 lines.

> +	if (!pmc->blk_sub_req_regs)
> +		return -ENOMEM;
> +
> +	req_offset = pmc->blk_sub_req_regs;
> +	for (index = 0; index < num_blocker; index++) {
> +		ret = pmt_telem_read32(ep, sample_id, req_offset, 1);
> +		if (ret) {
> +			dev_err(&pmcdev->pdev->dev,
> +				"couldn't read Low Power Mode requirements: %d\n", ret);
> +			return ret;
> +		}
> +		sample_id++;
> +		req_offset++;
> +	}
> +	return 0;
> +}
> +
> +static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func, unsigned int telem_info)
>  {
>  	struct pci_dev *pcidev __free(pci_dev_put) = NULL;
>  	struct telem_endpoint *ep;
> @@ -1470,13 +1554,26 @@ static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
>  			return -EPROBE_DEFER;
>  		}
>  
> -		ret = pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
> +		if (telem_info & SUB_REQ_LPM) {
> +			ret = pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
> +			if (ret)
> +				goto unregister_ep;
> +		}
> +
> +		if (telem_info & SUB_REQ_BLK) {

These two are mutually exclusive? I'm really wondering cuold pointers be 
used instead to avoid these ifs here and in debugfs fops selection.

> +			ret = pmc_core_pmt_get_blk_sub_req(pmcdev, pmc, ep);
> +			if (ret)
> +				goto unregister_ep;
> +		}
> +
>  		pmt_telem_unregister_endpoint(ep);
> -		if (ret)
> -			return ret;
>  	}
>  
>  	return 0;
> +
> +unregister_ep:
> +	pmt_telem_unregister_endpoint(ep);
> +	return ret;
>  }
>  
>  static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
> @@ -1585,7 +1682,9 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>  		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
>  
>  	if (ssram) {
> -		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info->pci_func);
> +		ret = pmc_core_get_telem_info(pmcdev,
> +					      pmc_dev_info->pci_func,
> +					      pmc_dev_info->telem_info);
>  		if (ret)
>  			goto unmap_regbase;
>  	}
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 4a94a4ee031e6..d8c7b28493055 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -29,6 +29,10 @@ struct telem_endpoint;
>  #define LPM_REG_COUNT		28
>  #define LPM_MODE_OFFSET		1
>  
> +/* Telemetry Endpoint Info bits */
> +#define SUB_REQ_LPM		0x01	/* Substate requirement for low power mode requirements */
> +#define SUB_REQ_BLK		0x02	/* Substate requirement for S0ix blockers */
> +
>  /* Sunrise Point Power Management Controller PCI Device ID */
>  #define SPT_PMC_PCI_DEVICE_ID			0x9d21
>  #define SPT_PMC_BASE_ADDR_OFFSET		0x48
> @@ -344,6 +348,8 @@ struct pmc_bit_map {
>   * @pm_read_disable_bit: Bit index to read PMC_READ_DISABLE
>   * @slps0_dbg_offset:	PWRMBASE offset to SLP_S0_DEBUG_REG*
>   * @s0ix_blocker_offset PWRMBASE offset to S0ix blocker counter
> + * @num_s0ix_blocker:	Number of S0ix blockers
> + * @blocker_req_offset:	Telemetry offset to S0ix blocker low power mode substate requirement table
>   *
>   * Each PCH has unique set of register offsets and bit indexes. This structure
>   * captures them to have a common implementation.
> @@ -369,6 +375,8 @@ struct pmc_reg_map {
>  	const u32 ltr_ignore_max;
>  	const u32 pm_vric1_offset;
>  	const u32 s0ix_blocker_offset;
> +	const u32 num_s0ix_blocker;
> +	const u32 blocker_req_offset;
>  	/* Low Power Mode registers */
>  	const int lpm_num_maps;
>  	const int lpm_num_modes;
> @@ -404,6 +412,7 @@ struct pmc_info {
>   * @map:		pointer to pmc_reg_map struct that contains platform
>   *			specific attributes
>   * @lpm_req_regs:	List of substate requirements
> + * @blk_sub_req_reqs:	List of registers showing substate requirements for S0ix blockers
>   * @ltr_ign:		Holds LTR ignore data while suspended
>   *
>   * pmc contains info about one power management controller device.
> @@ -413,6 +422,7 @@ struct pmc {
>  	void __iomem *regbase;
>  	const struct pmc_reg_map *map;
>  	u32 *lpm_req_regs;
> +	u32 *blk_sub_req_regs;
>  	u32 ltr_ign;
>  };
>  
> @@ -468,6 +478,7 @@ enum pmc_index {
>  /**
>   * struct pmc_dev_info - Structure to keep PMC device info
>   * @pci_func:		Function number of the primary PMC
> + * @telem_info:		Bitmask to indicate which telemetry info is available
>   * @dmu_guid:		Die Management Unit GUID
>   * @regmap_list:	Pointer to a list of pmc_info structure that could be
>   *			available for the platform. When set, this field implies
> @@ -480,6 +491,7 @@ enum pmc_index {
>   */
>  struct pmc_dev_info {
>  	u8 pci_func;
> +	u8 telem_info;
>  	u32 dmu_guid;
>  	struct pmc_info *regmap_list;
>  	const struct pmc_reg_map *map;
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
> index e08a77c778c2c..ec9e79f6cd913 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -572,6 +572,7 @@ static int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>  
>  struct pmc_dev_info lnl_pmc_dev = {
>  	.pci_func = 2,
> +	.telem_info = SUB_REQ_LPM,
>  	.regmap_list = lnl_pmc_info_list,
>  	.map = &lnl_socm_reg_map,
>  	.suspend = cnl_suspend,
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index faa13a7ee688f..c58a871e2e0df 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -994,6 +994,7 @@ static int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>  
>  struct pmc_dev_info mtl_pmc_dev = {
>  	.pci_func = 2,
> +	.telem_info = SUB_REQ_LPM,
>  	.dmu_guid = MTL_PMT_DMU_GUID,
>  	.regmap_list = mtl_pmc_info_list,
>  	.map = &mtl_socm_reg_map,
> 

-- 
 i.


