Return-Path: <linux-pm+bounces-34115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F66B4807E
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 23:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B383C1B14
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 21:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F7E221271;
	Sun,  7 Sep 2025 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLOTAgvd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94D15C158;
	Sun,  7 Sep 2025 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757282267; cv=none; b=Fvip7YGGiSDD8pde8S6JUUm1xa1JFF0ceKACxgZkyVf2ZzXZ4Miv0TPzuMOC8IxkYxaRLGU0xpXyfY3uc7yXhWhOvOMnOjEDYw5Oz7MbCEqbpiR8Q9lL2MJstUAQozHrwoZt0Or/viFihrtLaCvgSGbOgwOwJHsjr8XcSV1H3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757282267; c=relaxed/simple;
	bh=6zYMH1MVEsgh10pOGjfHOiDIdOOCUVBlEhSYwL149ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScWsmiGK6h9wxdvrUNvCadbm3qsfNxd/dk10P4uduma6dO5N5GiJ6pU7UJ57jkEVwGQ+1EneuR2qrPe8zNLGTVhwYVdPLSnoAUNvxaOrY38Yfu8EYatADe0JNvzBBI3k1w5/g0y1ghABi0DMQALsGcZ8h1dwqWG+FlQJ1CeroCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLOTAgvd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757282265; x=1788818265;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6zYMH1MVEsgh10pOGjfHOiDIdOOCUVBlEhSYwL149ls=;
  b=JLOTAgvd26gSDNon1vPG0LenFf0twoEtswL8rCzkiKF2fswZG1K2RHii
   czEMTBab6o8OUtFgvzYYm26ClUEo8fnbnnQ5VJsLkKXQcnZK7XtHGhu6M
   L+oj/fVOhbSrL8ELkdSImErFf75yZz3SJmub0+xtXlNGZZ932lZSEQQ4L
   3wlGtoKbkLjsZm4lhIiILBJWw8MepsZ6sjETifs51Y7B8AQQytRoHHGMA
   uw2OJr4cSg+5g4IHwvE3L6MaQFKvBUY/g5dGO1W3WvH42VQiT55Ob3oC0
   izrufiZ/loqj/UxUBW29QayfvDqA2E3lT2Tr6nVdvtWah4sa/+Y/CPAF+
   g==;
X-CSE-ConnectionGUID: zRjJ1f43RL+rHX0w0XMR2g==
X-CSE-MsgGUID: BxHUrfaYSQmUs7BoUmYg5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77157636"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="77157636"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 14:57:44 -0700
X-CSE-ConnectionGUID: 3vdC14feQY+U0x+beM3OMQ==
X-CSE-MsgGUID: YTyHKPHDSRm5A5pOJRI2+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="176700792"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.166.73]) ([10.246.166.73])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 14:57:43 -0700
Message-ID: <7fae6fc8-6df5-4d1f-90ec-b6bf159e62da@linux.intel.com>
Date: Sun, 7 Sep 2025 14:57:43 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] platform/x86:intel/pmc: Show device and function
 number
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
 <20250815224611.2460255-6-xi.pardee@linux.intel.com>
 <c9aa04ae-f942-cf73-d046-78d0f90f373d@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <c9aa04ae-f942-cf73-d046-78d0f90f373d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,

Thanks for the review.

On 8/28/2025 6:56 AM, Ilpo Järvinen wrote:
> On Fri, 15 Aug 2025, Xi Pardee wrote:
>
>> Add support to show device and function number for S0ix blockers. This
>> feature depends on S0ix blocker substate requirement table and BDF
>> association table. This feature is available for platforms starting from
>> Pather Lake.
>>
>> Only a subset of S0ix blockers has device and function number associated
>> to it. Get the availability information from the substate requirement
>> table. Get the device and function number mapping information for each
>> S0ix blocker from the BDF association table.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 182 +++++++++++++++++++++++++-
>>   drivers/platform/x86/intel/pmc/core.h |  23 +++-
>>   2 files changed, 203 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index a0b948a875a5a..69ee40cbb8b8a 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1017,6 +1017,38 @@ const struct file_operations pmc_core_substate_req_regs_fops = {
>>   	.release	= single_release,
>>   };
>>   
>> +static int pmc_core_bdf_show(struct seq_file *s, void *unused)
>> +{
>> +	struct pmc_dev *pmcdev = s->private;
>> +	unsigned int pmcidx;
>> +
>> +	seq_printf(s, "%36s | %15s | %15s |\n", "Element", "Device Number", "Function Number");
>> +	for (pmcidx = 0; pmcidx < ARRAY_SIZE(pmcdev->pmcs); pmcidx++) {
> Change this to pmc_idx and lets make it the only form that are added from
> this point on.
>
> The other ones should be converted to it eventually, I once had a cleanup
> patch to rename them but IIRC I dropped it to not conflict with some
> feature worked. Maybe you can fit a rename change into some series so I
> won't end up conflicting your feature work :-).
I will remove this patch from this patch series and send this one 
separately later and include a cleanup patch to rename all pmc index to 
pmc_idx.
>
>> +		const char *name = NULL;
>> +		struct list_head *cur;
>> +		struct bdf_entry *bdf;
>> +		struct pmc *pmc;
>> +
>> +		pmc = pmcdev->pmcs[pmcidx];
>> +		if (!pmc)
>> +			continue;
>> +
>> +		list_for_each(cur, pmc->bdf_list) {
>> +			bdf = list_entry(cur, struct bdf_entry, node);
>> +			if (bdf->name != name) {
>> +				seq_printf(s, "pmc%d: %30s | %15x | %15x |\n", pmcidx,
> %u
Will change it in next version.
>
>> +					   bdf->name, bdf->dev_num, bdf->fun_num);
>> +				name = bdf->name;
>> +			} else {
>> +				seq_printf(s, "%54x | %15x |\n",
>> +					   bdf->dev_num, bdf->fun_num);
>> +			}
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(pmc_core_bdf);
>> +
>>   static unsigned int pmc_core_get_crystal_freq(void)
>>   {
>>   	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
>> @@ -1418,6 +1450,10 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info
>>   				    pmc_dev_info->sub_req_show);
>>   	}
>>   
>> +	if (primary_pmc->bdf_list) {
>> +		debugfs_create_file("bdf", 0444, pmcdev->dbgfs_dir, pmcdev, &pmc_core_bdf_fops);
>> +	}
> Unnecessary braces.
Will change it in next version.
>
>> +
>>   	if (primary_pmc->map->pson_residency_offset && pmc_core_is_pson_residency_enabled(pmcdev)) {
>>   		debugfs_create_file("pson_residency_usec", 0444,
>>   				    pmcdev->dbgfs_dir, primary_pmc, &pmc_core_pson_residency);
>> @@ -1521,7 +1557,7 @@ int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct tel
>>   	return ret;
>>   }
>>   
>> -int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
>> +static int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
>>   				 struct telem_endpoint *ep)
>>   {
>>   	u32 num_blocker, sample_id;
>> @@ -1551,6 +1587,150 @@ int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
>>   	return 0;
>>   }
>>   
>> +static const char *pmc_core_get_next_bdf_ip_name(struct pmc *pmc, unsigned int *r_idx,
>> +						 unsigned int *i_idx, u32 **lpm_req_regs)
>> +{
>> +	const struct pmc_bit_map **maps;
>> +	unsigned int arr_size;
>> +	bool reset = FALSE;
> FALSE is a define in some obscure header (which you probably didn't
> include intentionally anyway ;-)).
>
> Please use false.
Will change it to false in next version.
>
>> +
>> +	maps = pmc->map->s0ix_blocker_maps;
>> +	arr_size = pmc_core_lpm_get_arr_size(maps);
>> +
>> +	// Iteration reaches the end of the bitmap array
> This driver has used exclusively /* */ comments.
Will change it in next version.
>
>> +	if (!maps[*r_idx][*i_idx].name)
>> +		(*r_idx)++;
>> +
>> +	// Iteration reaches the end of the maps
>> +	if (*r_idx >= arr_size)
>> +		return NULL;
>> +
>> +	for (; *r_idx < arr_size; (*r_idx)++) {
>> +		const char *ip_name;
> Can't you put this to the innermost block?
Will move it in next version.
>
>> +		if (reset)
> Why you need this?

The purpose of this function is to return the name of the NEXT s0ix 
blocker with BDF information.

r_idx and i_idx are used to keep track of the current position of the 
iteration, therefore i_idx could not be reset to 0 at the first run of 
the inner for loop. After the first run of inner for loop reset should 
be set to true so in next run of the outer for loop i_idx could be reset 
to 0 (which mean the iteration reaches the next s0ix blocker map).

>
>> +			*i_idx = 0;
>> +
>> +		for (; maps[*r_idx][*i_idx].name; reset = TRUE, (*i_idx)++) {
> true
>
> This is hard enough to understand even without that "for (;". Would
> probably be better to use while () instead.
Will change to while loop in next version.
>> +			if (!maps[*r_idx][*i_idx].blk)
>> +				continue;
>> +
>> +			bool exist = **lpm_req_regs & BIT(BDF_EXIST_BIT);
>> +			(*lpm_req_regs)++;
>> +			if (exist) {
>> +				ip_name = maps[*r_idx][*i_idx].name;
>> +				(*i_idx)++;
>> +				return ip_name;
>> +			}
>> +		}
>> +	}
>> +	return NULL;
>> +}
> TBH, this entire function is horrible mess, two nested iterators as
> pointers, etc.
>
> I'm very far from following all what going on here.
>
> I suppose I've not seen this patch previously?

To achieve the NEXT name of the s0ix blocker with BDF information we 
need to iterate through two (set of) maps in parallel. The 
s0ix_blocker_maps provide names of all s0ix blockers and the 
lpm_req_regs map shows that which s0ix blocker has associated BDF 
information.

if maps[*r_idx][*i_idx].blk is set, that means it is a s0ix blocker. For 
each s0ix blocker, if **lpm_req_regs & BIT(BDF_EXIST_BIT) is set, that 
means this blocker has associated BDF information. Pointers are used to 
keep track of the current position of the two (set of) maps so the 
function provides the NEXT name of the s0ix blocker with associated BDF 
info.

I will probably switch to use a temporary data structure, such as list, 
to store all s0ix blockers with BDF info and then iterate through this 
list in pmc_core_process_bdf() call instead. That will make the logic 
easier to follow and maintain. I will also add more comments to next 
version of this patch.

>
>> +static int pmc_core_process_bdf(struct pmc_dev *pmcdev,  struct pmc *pmc, u32 data,
>> +				unsigned int *r_idx, unsigned int *i_idx, u32 **lpm_req_regs,
>> +				const char **name)
>> +{
>> +	unsigned int i;
>> +
>> +	if (!data)
>> +		return 0;
>> +
>> +	if (!*name)
>> +		return -EINVAL;
>> +
>> +	for (i = BDF_FUN_LOW_BIT; i <= BDF_FUN_HIGH_BIT; i++) {
> I think you can iterate 0 ... __fls(FIELD_MAX()).

Each 16 bit represents one device and the associated function numbers 
for one s0ix blocker.

Bit 4-0 indicates the device number.

Bit 12-5 indicates function numbers.

Bit 15 indicates if the next 16 bit is associated to the same s0ix 
blocker as the current word.

Between bit 12 and bit 5, each bit position represents one function 
number. Bit 5 represents function 0 and bit 12 represents function 7. I 
will add more comments in the next version.

Will change to use __fls(FIELD_MAX()) in next version.

>
>> +		struct bdf_entry *b_entry;
>> +		u32 function_data;
>> +
>> +		function_data = (data & BIT(i));
>> +		if (function_data) {
> Why the extra variable???
Will remove the function_data variable in next version.
>
>> +			b_entry = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*b_entry), GFP_KERNEL);
>> +			if (!b_entry)
>> +				return -ENOMEM;
>> +			b_entry->dev_num = data & GENMASK(BDF_DEV_HIGH_BIT, BDF_DEV_LOW_BIT);
>> +			b_entry->fun_num = i - BDF_FUN_LOW_BIT;
> What "fun" stands for? Should it be "func" as is the typical short for
> "function" in BDF?
Will change to func_num in next version.
>
>> +			b_entry->name = *name;
>> +			list_add_tail(&b_entry->node, pmc->bdf_list);
>> +		}
>> +	}
>> +
>> +	if (!(data & BIT(BDF_REQ_BIT)))
>> +		*name = pmc_core_get_next_bdf_ip_name(pmc, r_idx, i_idx, lpm_req_regs);
>> +
>> +	return 0;
>> +}
>> +
>> +static int pmc_core_pmt_get_bdf(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep)
>> +{
>> +	unsigned int sample_id, max_sample_id, header_id, size, r_idx, i_idx;
>> +	struct bdf_entry *entry;
>> +	u32 *lpm_reg_regs;
>> +	const char *name;
>> +	int ret;
>> +
>> +	header_id = pmc->map->bdf_offset;
>> +	sample_id = header_id;
>> +	max_sample_id = sample_id + pmc->map->bdf_table_size;
>> +	lpm_reg_regs = pmc->lpm_req_regs;
>> +	r_idx = 0;
>> +	i_idx = 0;
>> +
>> +	name = pmc_core_get_next_bdf_ip_name(pmc, &r_idx, &i_idx, &lpm_reg_regs);
>> +	if (!name)
>> +		return -EINVAL;
>> +
>> +	pmc->bdf_list = devm_kzalloc(&pmcdev->pdev->dev, sizeof(struct list_head), GFP_KERNEL);
> Should use sizeof(*xx).
>
> But why you need to allocate the list head and not have it in place
> within the pmc's struct?

The memory for bdf_list is only allocated when the bdf information is 
available to achieve.

intel_pmc_core driver can check if the memory is allocated to decide 
whether to create a file in debugfs for bdf in pmc_core_dbgfs_register().

>
>> +	if (!pmc->bdf_list)
>> +		return -ENOMEM;
>> +
>> +	INIT_LIST_HEAD(pmc->bdf_list);
>> +
>> +	for (; sample_id < max_sample_id; sample_id++) {
>> +		u32 data;
>> +
>> +		ret = pmt_telem_read32(ep, sample_id, &data, 1);
>> +		if (ret) {
>> +			dev_err(&pmcdev->pdev->dev,
>> +				"couldn't read bdf: %d\n", ret);
> One line.
Will change it in next version.
>
>> +			return ret;
>> +		}
>> +
>> +		if (sample_id == header_id) {
>> +			size = (data & GENMASK(BDF_SIZE_HIGH_BIT, BDF_SIZE_LOW_BIT))
>> +			       >> BDF_SIZE_LOW_BIT;
> Define the field and use FIELD_GET().
Will change it in next version.
>
>> +			header_id += size + 1;
> No, I just cannot understand what's going on here, it's hopeless. Always
> when I think I've finally understood what its all about you throw a curve
> ball like this.

There is one header line (32 bit) between each type of s0ix blocker in 
the bdf association table. The bit 23-26 in header line indicates the 
size of each section of one specific type of s0ix blocker in this table.

header_id is used  to keep track of the id of each header so we will 
process the header line differently from the other lines.

I will add more detailed comment in next version.

>
> In case this series is in any kind of hurry. I suggest you send the series
> without this patch and we work out this patch separately on top of the
> applied patches (I expect the patch 1-5 to be fine on next iteration).

I will send this patch separately from the other patches in this series.

>
>> +			continue;
>> +		}
>> +
>> +		ret = pmc_core_process_bdf(pmcdev, pmc, data, &r_idx, &i_idx, &lpm_reg_regs, &name);
>> +		if (ret)
>> +			return ret;
>> +		data = data >> BDF_SIZE;
>> +		ret = pmc_core_process_bdf(pmcdev, pmc, data, &r_idx, &i_idx, &lpm_reg_regs, &name);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	list_for_each_entry(entry, pmc->bdf_list, node) {
>> +		dev_dbg(&pmcdev->pdev->dev, "bdf info: name %s, dev_num %x, fun_num %x",
>> +			entry->name, entry->dev_num, entry->fun_num);
>> +	}
>> +	return 0;
>> +}
>> +
>> +int pmc_core_pmt_get_sub_req_bdf(struct pmc_dev *pmcdev, struct pmc *pmc,
>> +				 struct telem_endpoint *ep)
>> +{
>> +	int ret;
>> +
>> +	ret = pmc_core_pmt_get_blk_sub_req(pmcdev, pmc, ep);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return pmc_core_pmt_get_bdf(pmcdev, pmc, ep);
>> +}
>> +
>>   static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>>   {
>>   	struct pci_dev *pcidev __free(pci_dev_put) = NULL;
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index bfe8fba808063..6ff2d171dc2ba 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -317,6 +317,24 @@ enum ppfear_regs {
>>   #define PMC_DEVID_MTL_IOEP	0x7ecf
>>   #define PMC_DEVID_MTL_IOEM	0x7ebf
>>   
>> +/* BDF offset */
>> +#define BDF_EXIST_BIT		3
>> +#define BDF_SIZE_HIGH_BIT	23
>> +#define BDF_SIZE_LOW_BIT	16
>> +#define BDF_DEV_HIGH_BIT	4
>> +#define BDF_DEV_LOW_BIT		0
>> +#define BDF_FUN_HIGH_BIT	12
>> +#define BDF_FUN_LOW_BIT		5
>> +#define BDF_REQ_BIT		15
>> +#define BDF_SIZE		16
> Use BIT(), GENMASK() for most right here. All?

Will change to use BIT() and GENMASK() in next version.

Thanks for reviewing the patch.

Xi

>
>> +
>> +struct bdf_entry {
>> +	struct list_head node;
>> +	const char *name;
>> +	u32 dev_num;
>> +	u32 fun_num;
>> +};
>> +
>>   extern const char *pmc_lpm_modes[];
>>   
>>   struct pmc_bit_map {
>> @@ -373,6 +391,8 @@ struct pmc_reg_map {
>>   	const u32 s0ix_blocker_offset;
>>   	const u32 num_s0ix_blocker;
>>   	const u32 blocker_req_offset;
>> +	const u32 bdf_offset;
>> +	const u32 bdf_table_size;
>>   	/* Low Power Mode registers */
>>   	const int lpm_num_maps;
>>   	const int lpm_num_modes;
>> @@ -418,6 +438,7 @@ struct pmc {
>>   	const struct pmc_reg_map *map;
>>   	u32 *lpm_req_regs;
>>   	u32 ltr_ign;
>> +	struct list_head *bdf_list;
>>   };
>>   
>>   /**
>> @@ -540,7 +561,7 @@ extern struct pmc_dev_info ptl_pmc_dev;
>>   void cnl_suspend(struct pmc_dev *pmcdev);
>>   int cnl_resume(struct pmc_dev *pmcdev);
>>   int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep);
>> -int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
>> +int pmc_core_pmt_get_sub_req_bdf(struct pmc_dev *pmcdev, struct pmc *pmc,
>>   				 struct telem_endpoint *ep);
>>   
>>   extern const struct file_operations pmc_core_substate_req_regs_fops;
>>

