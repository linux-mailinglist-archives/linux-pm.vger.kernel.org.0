Return-Path: <linux-pm+bounces-33263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D82B39F73
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 15:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C84137B572C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3876226C39F;
	Thu, 28 Aug 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bM4iFahC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB91CDFD5;
	Thu, 28 Aug 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389380; cv=none; b=NEUcxjYQAgimdA+nslYYINM1ZWxtsJeIJpfJ82pFd6See5bQIHbIR7GZMY1SXq+2AkUw7QnSfli2F46UWqhdPJGCN0DngzMsHKqbLdfaansDldSoHjTEaS9w2MEpGc3E6urCAR1fJFp8rtOLkIlfsUJjZvU02etPaSCwJzR9ckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389380; c=relaxed/simple;
	bh=NVtfQkj/LLhGbbkjcOyFZJmL6lONFV3/3lzPX+8SPr0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mMw2QgcROKi/TZ/g2MP53ndYUKpw47ADV717oTQag4cXLU8xiPOUMYT1C46v3/kS4cq4MYw9cKvJ4TnOm6//d/040Y5VNOmjAJhNdJLe9JT4LwCsWwnmASGnhrDuVFcKzA5GzqQ/xcrtizMs1BnsISc64S+j1Hj+5YWBPpNsfkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bM4iFahC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756389378; x=1787925378;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NVtfQkj/LLhGbbkjcOyFZJmL6lONFV3/3lzPX+8SPr0=;
  b=bM4iFahCpxR90vVgunjAFpfLxGhf9gfOkJrKOuy3Kx+AMfjaMbSfe9yY
   VX5W9+pafzCjB7yBL+sgGR8+R3+FyLbkgvokdBG5Kitzoe/iE7KzYM9fs
   rRFr+0O03v8pmjfeOUeulfq/I8KDgNOi8/CxO9Avz5zzhuYlhZ2l33ko1
   4CARIPws3oSI5x0blKQNULuRquQICrt3mPb5D7qEzerEihXh3lVxiNKDd
   NOdjtBTP5aPvkIjevHyGe4M1mnIdQQbrsGZmYyb0tMqf2SLevP+KJEYaJ
   6VHp423weKkD6tC6PeVoUyIcAtjcugkOhVl6Rs8bFcdhuvdKzdKObFnHQ
   g==;
X-CSE-ConnectionGUID: 117nSS9MR464gffnpvcS3g==
X-CSE-MsgGUID: DzFuJoCLStmzgHDQlmLThw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69364338"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69364338"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 06:56:18 -0700
X-CSE-ConnectionGUID: kyI6ONA1SQC+ZxrRCvflIQ==
X-CSE-MsgGUID: C9a/RJgqS+KJWNZ9mFAh8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="201035136"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 06:56:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 Aug 2025 16:56:05 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] platform/x86:intel/pmc: Show device and function
 number
In-Reply-To: <20250815224611.2460255-6-xi.pardee@linux.intel.com>
Message-ID: <c9aa04ae-f942-cf73-d046-78d0f90f373d@linux.intel.com>
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com> <20250815224611.2460255-6-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 Aug 2025, Xi Pardee wrote:

> Add support to show device and function number for S0ix blockers. This
> feature depends on S0ix blocker substate requirement table and BDF
> association table. This feature is available for platforms starting from
> Pather Lake.
> 
> Only a subset of S0ix blockers has device and function number associated
> to it. Get the availability information from the substate requirement
> table. Get the device and function number mapping information for each
> S0ix blocker from the BDF association table.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 182 +++++++++++++++++++++++++-
>  drivers/platform/x86/intel/pmc/core.h |  23 +++-
>  2 files changed, 203 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index a0b948a875a5a..69ee40cbb8b8a 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1017,6 +1017,38 @@ const struct file_operations pmc_core_substate_req_regs_fops = {
>  	.release	= single_release,
>  };
>  
> +static int pmc_core_bdf_show(struct seq_file *s, void *unused)
> +{
> +	struct pmc_dev *pmcdev = s->private;
> +	unsigned int pmcidx;
> +
> +	seq_printf(s, "%36s | %15s | %15s |\n", "Element", "Device Number", "Function Number");
> +	for (pmcidx = 0; pmcidx < ARRAY_SIZE(pmcdev->pmcs); pmcidx++) {

Change this to pmc_idx and lets make it the only form that are added from 
this point on.

The other ones should be converted to it eventually, I once had a cleanup 
patch to rename them but IIRC I dropped it to not conflict with some 
feature worked. Maybe you can fit a rename change into some series so I 
won't end up conflicting your feature work :-).

> +		const char *name = NULL;
> +		struct list_head *cur;
> +		struct bdf_entry *bdf;
> +		struct pmc *pmc;
> +
> +		pmc = pmcdev->pmcs[pmcidx];
> +		if (!pmc)
> +			continue;
> +
> +		list_for_each(cur, pmc->bdf_list) {
> +			bdf = list_entry(cur, struct bdf_entry, node);
> +			if (bdf->name != name) {
> +				seq_printf(s, "pmc%d: %30s | %15x | %15x |\n", pmcidx,

%u

> +					   bdf->name, bdf->dev_num, bdf->fun_num);
> +				name = bdf->name;
> +			} else {
> +				seq_printf(s, "%54x | %15x |\n",
> +					   bdf->dev_num, bdf->fun_num);
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_bdf);
> +
>  static unsigned int pmc_core_get_crystal_freq(void)
>  {
>  	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
> @@ -1418,6 +1450,10 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info
>  				    pmc_dev_info->sub_req_show);
>  	}
>  
> +	if (primary_pmc->bdf_list) {
> +		debugfs_create_file("bdf", 0444, pmcdev->dbgfs_dir, pmcdev, &pmc_core_bdf_fops);
> +	}

Unnecessary braces.

> +
>  	if (primary_pmc->map->pson_residency_offset && pmc_core_is_pson_residency_enabled(pmcdev)) {
>  		debugfs_create_file("pson_residency_usec", 0444,
>  				    pmcdev->dbgfs_dir, primary_pmc, &pmc_core_pson_residency);
> @@ -1521,7 +1557,7 @@ int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct tel
>  	return ret;
>  }
>  
> -int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
> +static int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
>  				 struct telem_endpoint *ep)
>  {
>  	u32 num_blocker, sample_id;
> @@ -1551,6 +1587,150 @@ int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
>  	return 0;
>  }
>  
> +static const char *pmc_core_get_next_bdf_ip_name(struct pmc *pmc, unsigned int *r_idx,
> +						 unsigned int *i_idx, u32 **lpm_req_regs)
> +{
> +	const struct pmc_bit_map **maps;
> +	unsigned int arr_size;
> +	bool reset = FALSE;

FALSE is a define in some obscure header (which you probably didn't 
include intentionally anyway ;-)).

Please use false.

> +
> +	maps = pmc->map->s0ix_blocker_maps;
> +	arr_size = pmc_core_lpm_get_arr_size(maps);
> +
> +	// Iteration reaches the end of the bitmap array

This driver has used exclusively /* */ comments.

> +	if (!maps[*r_idx][*i_idx].name)
> +		(*r_idx)++;
> +
> +	// Iteration reaches the end of the maps
> +	if (*r_idx >= arr_size)
> +		return NULL;
> +
> +	for (; *r_idx < arr_size; (*r_idx)++) {
> +		const char *ip_name;

Can't you put this to the innermost block?

> +		if (reset)

Why you need this?

> +			*i_idx = 0;
> +
> +		for (; maps[*r_idx][*i_idx].name; reset = TRUE, (*i_idx)++) {

true

This is hard enough to understand even without that "for (;". Would 
probably be better to use while () instead.

> +			if (!maps[*r_idx][*i_idx].blk)
> +				continue;
> +
> +			bool exist = **lpm_req_regs & BIT(BDF_EXIST_BIT);
> +			(*lpm_req_regs)++;
> +			if (exist) {
> +				ip_name = maps[*r_idx][*i_idx].name;
> +				(*i_idx)++;
> +				return ip_name;
> +			}
> +		}
> +	}
> +	return NULL;
> +}

TBH, this entire function is horrible mess, two nested iterators as 
pointers, etc.

I'm very far from following all what going on here.

I suppose I've not seen this patch previously?

> +static int pmc_core_process_bdf(struct pmc_dev *pmcdev,  struct pmc *pmc, u32 data,
> +				unsigned int *r_idx, unsigned int *i_idx, u32 **lpm_req_regs,
> +				const char **name)
> +{
> +	unsigned int i;
> +
> +	if (!data)
> +		return 0;
> +
> +	if (!*name)
> +		return -EINVAL;
> +
> +	for (i = BDF_FUN_LOW_BIT; i <= BDF_FUN_HIGH_BIT; i++) {

I think you can iterate 0 ... __fls(FIELD_MAX()).

> +		struct bdf_entry *b_entry;
> +		u32 function_data;
> +
> +		function_data = (data & BIT(i));
> +		if (function_data) {

Why the extra variable???

> +			b_entry = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*b_entry), GFP_KERNEL);
> +			if (!b_entry)
> +				return -ENOMEM;
> +			b_entry->dev_num = data & GENMASK(BDF_DEV_HIGH_BIT, BDF_DEV_LOW_BIT);
> +			b_entry->fun_num = i - BDF_FUN_LOW_BIT;

What "fun" stands for? Should it be "func" as is the typical short for 
"function" in BDF?

> +			b_entry->name = *name;
> +			list_add_tail(&b_entry->node, pmc->bdf_list);
> +		}
> +	}
> +
> +	if (!(data & BIT(BDF_REQ_BIT)))
> +		*name = pmc_core_get_next_bdf_ip_name(pmc, r_idx, i_idx, lpm_req_regs);
> +
> +	return 0;
> +}
> +
> +static int pmc_core_pmt_get_bdf(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep)
> +{
> +	unsigned int sample_id, max_sample_id, header_id, size, r_idx, i_idx;
> +	struct bdf_entry *entry;
> +	u32 *lpm_reg_regs;
> +	const char *name;
> +	int ret;
> +
> +	header_id = pmc->map->bdf_offset;
> +	sample_id = header_id;
> +	max_sample_id = sample_id + pmc->map->bdf_table_size;
> +	lpm_reg_regs = pmc->lpm_req_regs;
> +	r_idx = 0;
> +	i_idx = 0;
> +
> +	name = pmc_core_get_next_bdf_ip_name(pmc, &r_idx, &i_idx, &lpm_reg_regs);
> +	if (!name)
> +		return -EINVAL;
> +
> +	pmc->bdf_list = devm_kzalloc(&pmcdev->pdev->dev, sizeof(struct list_head), GFP_KERNEL);

Should use sizeof(*xx).

But why you need to allocate the list head and not have it in place 
within the pmc's struct?

> +	if (!pmc->bdf_list)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(pmc->bdf_list);
> +
> +	for (; sample_id < max_sample_id; sample_id++) {
> +		u32 data;
> +
> +		ret = pmt_telem_read32(ep, sample_id, &data, 1);
> +		if (ret) {
> +			dev_err(&pmcdev->pdev->dev,
> +				"couldn't read bdf: %d\n", ret);

One line.

> +			return ret;
> +		}
> +
> +		if (sample_id == header_id) {
> +			size = (data & GENMASK(BDF_SIZE_HIGH_BIT, BDF_SIZE_LOW_BIT))
> +			       >> BDF_SIZE_LOW_BIT;

Define the field and use FIELD_GET().

> +			header_id += size + 1;

No, I just cannot understand what's going on here, it's hopeless. Always 
when I think I've finally understood what its all about you throw a curve 
ball like this.

In case this series is in any kind of hurry. I suggest you send the series 
without this patch and we work out this patch separately on top of the 
applied patches (I expect the patch 1-5 to be fine on next iteration).

> +			continue;
> +		}
> +
> +		ret = pmc_core_process_bdf(pmcdev, pmc, data, &r_idx, &i_idx, &lpm_reg_regs, &name);
> +		if (ret)
> +			return ret;
> +		data = data >> BDF_SIZE;
> +		ret = pmc_core_process_bdf(pmcdev, pmc, data, &r_idx, &i_idx, &lpm_reg_regs, &name);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	list_for_each_entry(entry, pmc->bdf_list, node) {
> +		dev_dbg(&pmcdev->pdev->dev, "bdf info: name %s, dev_num %x, fun_num %x",
> +			entry->name, entry->dev_num, entry->fun_num);
> +	}
> +	return 0;
> +}
> +
> +int pmc_core_pmt_get_sub_req_bdf(struct pmc_dev *pmcdev, struct pmc *pmc,
> +				 struct telem_endpoint *ep)
> +{
> +	int ret;
> +
> +	ret = pmc_core_pmt_get_blk_sub_req(pmcdev, pmc, ep);
> +	if (ret)
> +		return ret;
> +
> +	return pmc_core_pmt_get_bdf(pmcdev, pmc, ep);
> +}
> +
>  static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>  {
>  	struct pci_dev *pcidev __free(pci_dev_put) = NULL;
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index bfe8fba808063..6ff2d171dc2ba 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -317,6 +317,24 @@ enum ppfear_regs {
>  #define PMC_DEVID_MTL_IOEP	0x7ecf
>  #define PMC_DEVID_MTL_IOEM	0x7ebf
>  
> +/* BDF offset */
> +#define BDF_EXIST_BIT		3
> +#define BDF_SIZE_HIGH_BIT	23
> +#define BDF_SIZE_LOW_BIT	16
> +#define BDF_DEV_HIGH_BIT	4
> +#define BDF_DEV_LOW_BIT		0
> +#define BDF_FUN_HIGH_BIT	12
> +#define BDF_FUN_LOW_BIT		5
> +#define BDF_REQ_BIT		15
> +#define BDF_SIZE		16

Use BIT(), GENMASK() for most right here. All?

> +
> +struct bdf_entry {
> +	struct list_head node;
> +	const char *name;
> +	u32 dev_num;
> +	u32 fun_num;
> +};
> +
>  extern const char *pmc_lpm_modes[];
>  
>  struct pmc_bit_map {
> @@ -373,6 +391,8 @@ struct pmc_reg_map {
>  	const u32 s0ix_blocker_offset;
>  	const u32 num_s0ix_blocker;
>  	const u32 blocker_req_offset;
> +	const u32 bdf_offset;
> +	const u32 bdf_table_size;
>  	/* Low Power Mode registers */
>  	const int lpm_num_maps;
>  	const int lpm_num_modes;
> @@ -418,6 +438,7 @@ struct pmc {
>  	const struct pmc_reg_map *map;
>  	u32 *lpm_req_regs;
>  	u32 ltr_ign;
> +	struct list_head *bdf_list;
>  };
>  
>  /**
> @@ -540,7 +561,7 @@ extern struct pmc_dev_info ptl_pmc_dev;
>  void cnl_suspend(struct pmc_dev *pmcdev);
>  int cnl_resume(struct pmc_dev *pmcdev);
>  int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep);
> -int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
> +int pmc_core_pmt_get_sub_req_bdf(struct pmc_dev *pmcdev, struct pmc *pmc,
>  				 struct telem_endpoint *ep);
>  
>  extern const struct file_operations pmc_core_substate_req_regs_fops;
> 

-- 
 i.


