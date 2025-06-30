Return-Path: <linux-pm+bounces-29850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4A5AEE658
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57651188481F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB2F28C5BF;
	Mon, 30 Jun 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVZobKJv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA002AD2F;
	Mon, 30 Jun 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306501; cv=none; b=Gx77ccxNFcOahNDpdqIv9w0qjTJvCPSDSox4baNSds0NtGIU7ftOUe0ZM93uF0FJKJQIBr9VaeEOZmSBZ3qvKMJFHrzUWdyN2iUn8uXeTuyfJIOgqSt4Rp4rq4zLokCIC85Bvnzu8D04XKz14n7QewYPY0pzUgW4eICP5Kj+5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306501; c=relaxed/simple;
	bh=AJv/Am3Sy91m/mUdq33pDE7OsOZgcMMzSiCzBd0Eucs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzF9XFwtvLmPT2r/PHy11TKLFG9DEJAV823MEETe2MayJ3FUabETWlEkJkrz8wQQu54SGrjtlKU9cQGTE+ejazabp7lGpM0R+H003S3HPtJmERuLouC4vvFUsr+AZj7IScBF1R72DRDRofnjJ4Dizb7PUZ5bFYOU89tyN7HNn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVZobKJv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751306500; x=1782842500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AJv/Am3Sy91m/mUdq33pDE7OsOZgcMMzSiCzBd0Eucs=;
  b=NVZobKJvF0chYsj1+h9BBXqV4Vd88zwTVnz0BsC+jR8eBw+/k49qDOGu
   WDHPwxvLhT6CNMAy1ZTj4zPIFrJR0ZuVlNv1rIv37HZd0BUBwtsjax1IE
   Mw82LVcGXn1oy5fTwTjmcLbwN1Kw20B50F0YsKCpPmCRyYmDYfESs0m7B
   v0m7OUUyKvfV8iZd+sEc7UePA4ybHYhHvMXTkBaijIjeTrJZz7gwc+iTs
   +EDasmoJ6o4xVRus7OmCjfX8u2HRJA5MuYreSnhRosLi9avojohJFoklN
   6AvTMYyhdgp0j/05pzv4qAQ7DpepYHxSSwaeYsPXPws14sJkPsy5SiZiE
   g==;
X-CSE-ConnectionGUID: AZMWHCwwTbGRUgTKqOZPFg==
X-CSE-MsgGUID: kK5aM0BcRGm/AEOGWLgHyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53418965"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="53418965"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:01:39 -0700
X-CSE-ConnectionGUID: hN7CBTzKRDu5y73RSvlywA==
X-CSE-MsgGUID: F6eOfiwTSvStO9Y2bJ0+QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="153703082"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.154.149]) ([10.246.154.149])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:01:39 -0700
Message-ID: <3ebe1fcd-e72a-4027-9da1-753e52e2fe48@linux.intel.com>
Date: Mon, 30 Jun 2025 11:01:37 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] platform/x86:intel/pmc: Show substate requirement
 for S0ix blockers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20250625063145.624585-1-xi.pardee@linux.intel.com>
 <20250625063145.624585-5-xi.pardee@linux.intel.com>
 <6f43709c-dfcb-059e-758a-be6a56538724@linux.intel.com>
 <4d9c848f-ea87-4b94-b9d3-94362e59a4af@linux.intel.com>
 <67fb2263-003e-71b3-ef6f-9276bded995b@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <67fb2263-003e-71b3-ef6f-9276bded995b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,

Thanks for reviewing the patch. My response is in line.

On 6/27/2025 1:08 AM, Ilpo Järvinen wrote:
> On Thu, 26 Jun 2025, Xi Pardee wrote:
>
>> Hi Ilpo,
>>
>> Thanks for reviewing the patch. My response is inline.
>>
>> On 6/26/2025 9:38 AM, Ilpo Järvinen wrote:
>>> On Tue, 24 Jun 2025, Xi Pardee wrote:
>>>
>>>> Add support to read and show S0ix blocker substate requirements.
>>>> Starting from Panther Lake, substate requirement data is provided
>>>> based on S0ix blockers instead of all low power mode requirements.
>>>> For platforms that support this new feature, add support to display
>>>> substate requirements based on S0ix blockers.
>>> Empty line.
>> Will fix in next version.
>>>> Change the "substate_requirements" attribute of Intel PMC Core
>>>> driver to show the substate requirements for each S0ix blocker
>>>> and the corresponding S0ix blocker value.
>>>>
>>>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>>>> ---
>>>>    drivers/platform/x86/intel/pmc/arl.c  |   2 +
>>>>    drivers/platform/x86/intel/pmc/core.c | 111 ++++++++++++++++++++++++--
>>>>    drivers/platform/x86/intel/pmc/core.h |  12 +++
>>>>    drivers/platform/x86/intel/pmc/lnl.c  |   1 +
>>>>    drivers/platform/x86/intel/pmc/mtl.c  |   1 +
>>>>    5 files changed, 121 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/intel/pmc/arl.c
>>>> b/drivers/platform/x86/intel/pmc/arl.c
>>>> index 9d66d65e75779..1852876be234f 100644
>>>> --- a/drivers/platform/x86/intel/pmc/arl.c
>>>> +++ b/drivers/platform/x86/intel/pmc/arl.c
>>>> @@ -722,6 +722,7 @@ static int arl_h_core_init(struct pmc_dev *pmcdev,
>>>> struct pmc_dev_info *pmc_dev_
>>>>      struct pmc_dev_info arl_pmc_dev = {
>>>>    	.pci_func = 0,
>>>> +	.telem_info = SUB_REQ_LPM,
>>>>    	.dmu_guid = ARL_PMT_DMU_GUID,
>>>>    	.regmap_list = arl_pmc_info_list,
>>>>    	.map = &arl_socs_reg_map,
>>>> @@ -732,6 +733,7 @@ struct pmc_dev_info arl_pmc_dev = {
>>>>      struct pmc_dev_info arl_h_pmc_dev = {
>>>>    	.pci_func = 2,
>>>> +	.telem_info = SUB_REQ_LPM,
>>>>    	.dmu_guid = ARL_PMT_DMU_GUID,
>>>>    	.regmap_list = arl_pmc_info_list,
>>>>    	.map = &mtl_socm_reg_map,
>>>> diff --git a/drivers/platform/x86/intel/pmc/core.c
>>>> b/drivers/platform/x86/intel/pmc/core.c
>>>> index 47cc5120e7dd6..e9d281b064462 100644
>>>> --- a/drivers/platform/x86/intel/pmc/core.c
>>>> +++ b/drivers/platform/x86/intel/pmc/core.c
>>>> @@ -844,6 +844,56 @@ static void pmc_core_substate_req_header_show(struct
>>>> seq_file *s, int pmc_index,
>>>>    		seq_printf(s, " %9s |\n", name);
>>>>    }
>>>>    +static int pmc_core_substate_blk_req_show(struct seq_file *s, void
>>>> *unused)
>>>> +{
>>>> +	struct pmc_dev *pmcdev = s->private;
>>>> +	unsigned int pmc_index;
>>>> +	u32 *blk_sub_req_regs;
>>> Why is this here and the other variable in the inner block?
>> Will move the blk_sub_req_regs declaration to the inner block.
>>>> +
>>>> +	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs); pmc_index++)
>>>> {
>>>> +		const struct pmc_bit_map **maps;
>>>> +		unsigned int arr_size, r_idx;
>>>> +		u32 offset, counter;
>>>> +		struct pmc *pmc;
>>>> +
>>>> +		pmc = pmcdev->pmcs[pmc_index];
>>>> +		if (!pmc || !pmc->blk_sub_req_regs)
>>>> +			continue;
>>>> +
>>>> +		blk_sub_req_regs = pmc->blk_sub_req_regs;
>>>> +		maps = pmc->map->s0ix_blocker_maps;
>>>> +		offset = pmc->map->s0ix_blocker_offset;
>>>> +		arr_size = pmc_core_lpm_get_arr_size(maps);
>>>> +
>>>> +		/* Display the header */
>>>> +		pmc_core_substate_req_header_show(s, pmc_index, "Value");
>>>> +
>>>> +		for (r_idx = 0; r_idx < arr_size; r_idx++) {
>>>> +			const struct pmc_bit_map *map;
>>>> +
>>>> +			for (map = maps[r_idx]; map->name; map++) {
>>>> +				int mode;
>>>> +
>>>> +				if (!map->blk)
>>>> +					continue;
>>>> +
>>>> +				counter = pmc_core_reg_read(pmc, offset);
>>>> +				seq_printf(s, "pmc%d: %34s |", pmc_index,
>>>> map->name);
>>>> +				pmc_for_each_mode(mode, pmcdev) {
>>>> +					bool required = *blk_sub_req_regs &
>>>> BIT(mode);
>>>> +
>>>> +					seq_printf(s, " %9s |", required ?
>>>> "Required" : " ");
>>>> +				}
>>>> +				seq_printf(s, " %9d |\n", counter);
>>>> +				offset += map->blk * S0IX_BLK_SIZE;
>>>> +				blk_sub_req_regs++;
>>>> +			}
>>>> +		}
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>> +DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_blk_req);
>>>> +
>>>>    static int pmc_core_substate_req_regs_show(struct seq_file *s, void
>>>> *unused)
>>>>    {
>>>>    	struct pmc_dev *pmcdev = s->private;
>>>> @@ -1335,7 +1385,10 @@ static void pmc_core_dbgfs_register(struct pmc_dev
>>>> *pmcdev)
>>>>    		debugfs_create_file("substate_requirements", 0444,
>>>>    				    pmcdev->dbgfs_dir, pmcdev,
>>>>    				    &pmc_core_substate_req_regs_fops);
>>>> -	}
>>>> +	} else if (primary_pmc->blk_sub_req_regs)
>>>> +		debugfs_create_file("substate_requirements", 0444,
>>>> +				    pmcdev->dbgfs_dir, pmcdev,
>>>> +				    &pmc_core_substate_blk_req_fops);
>>>>
>>>>    	if (primary_pmc->map->pson_residency_offset &&
>>>> pmc_core_is_pson_residency_enabled(pmcdev)) {
>>>>    		debugfs_create_file("pson_residency_usec", 0444,
>>>> @@ -1441,7 +1494,38 @@ static int pmc_core_pmt_get_lpm_req(struct pmc_dev
>>>> *pmcdev, struct pmc *pmc,
>>>>    	return ret;
>>>>    }
>>>>    -static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
>>>> +static int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct
>>>> pmc *pmc,
>>>> +					struct telem_endpoint *ep)
>>>> +{
>>>> +	u32 num_blocker, sample_id;
>>>> +	unsigned int index;
>>>> +	u32 *req_offset;
>>>> +	int ret;
>>>> +
>>>> +	num_blocker = pmc->map->num_s0ix_blocker;
>>>> +	sample_id = pmc->map->blocker_req_offset;
>>>> +
>>>> +	pmc->blk_sub_req_regs = devm_kcalloc(&pmcdev->pdev->dev,
>>>> +					 num_blocker, sizeof(u32),
>>>> +					 GFP_KERNEL);
>>> Correct alignment.
>>>
>>> I guess you want to keep those two args on the same line as this would fit
>>> on 2 lines.
>> Will change the alignment and move two args to be on one line.
>>>> +	if (!pmc->blk_sub_req_regs)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	req_offset = pmc->blk_sub_req_regs;
>>>> +	for (index = 0; index < num_blocker; index++) {
>>>> +		ret = pmt_telem_read32(ep, sample_id, req_offset, 1);
>>>> +		if (ret) {
>>>> +			dev_err(&pmcdev->pdev->dev,
>>>> +				"couldn't read Low Power Mode requirements:
>>>> %d\n", ret);
>>>> +			return ret;
>>>> +		}
>>>> +		sample_id++;
>>>> +		req_offset++;
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func,
>>>> unsigned int telem_info)
>>>>    {
>>>>    	struct pci_dev *pcidev __free(pci_dev_put) = NULL;
>>>>    	struct telem_endpoint *ep;
>>>> @@ -1470,13 +1554,26 @@ static int pmc_core_get_telem_info(struct pmc_dev
>>>> *pmcdev, int func)
>>>>    			return -EPROBE_DEFER;
>>>>    		}
>>>>    -		ret = pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
>>>> +		if (telem_info & SUB_REQ_LPM) {
>>>> +			ret = pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
>>>> +			if (ret)
>>>> +				goto unregister_ep;
>>>> +		}
>>>> +
>>>> +		if (telem_info & SUB_REQ_BLK) {
>>> These two are mutually exclusive? I'm really wondering cuold pointers be
>>> used instead to avoid these ifs here and in debugfs fops selection.
>> The SUB_REQ_BLK and SUB_REQ_LPM are mutually exclusive. We will also introduce
>> more
>> types of data from the telemetry endpoint but not mutually exclusive in the
>> next series, therefore
>> using bit to identify the type of data sounds appropriate to me. I am not sure
>> how to use pointer to
>> select data type in this scenario, Could you please give an example?
> Perhaps there isn't, I didn't have a crystal ball what's coming after this
> series at hand. :-)
>
> I just noted there are these mutually exclusive pointers:
>
> debugfs_create_file("substate_requirements", ..., &pmc_core_substate_req_regs_fops);
> vs
> debugfs_create_file("substate_requirements", ..., &pmc_core_substate_blk_req_fops);
>
> and
>
> ret = pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
> vs
> ret = pmc_core_pmt_get_blk_sub_req(pmcdev, pmc, ep);
>
> As both look like they're decided based on what platform we're running on,
> it looks similar to what pmc_dev_info already contains, having these as
> pointers in pmc_dev_info would avoid having to create those two branches
> just to use a different pointer.
>
> (BTW, those two places also use a different way to decide which one to
> use, which feels slightly inconsistent).
>
>
> Whether using pointers in pmc_dev_info makes sense given the extra info
> you provided now, I'm not any more entirely sure.
I understand that function pointer is a good solution here to avoid 
using the if branches as these two data types
are mutual exclusive. But this is a special case, we will be introducing 
new data types, which are not mutual exclusive.
In that case, it will be better to use a bit position to represent each 
data type available for the specific platforms.

For example, the next data type is bdf and we will add bdf to core.h and 
core.c:

#define BDF_INFO        0x04    /* Get BDF information */

if (telem_info & BDF_INFO) {
             ret = pmc_core_pmt_get_bdf(pmcdev, pmc, ep);
             if (ret)
                     goto unregister_ep;

}

We use register pointers to differentiate these two cases instead of 
telem_info when creating debugfs file. This is to
keep it consistent with other file creations in 
pmc_core_dbgfs_register(). I could change it to use telem_info in next
version.

Thanks!

Xi

>>>> +			ret = pmc_core_pmt_get_blk_sub_req(pmcdev, pmc, ep);
>>>> +			if (ret)
>>>> +				goto unregister_ep;
>>>> +		}
>>>> +
>>>>    		pmt_telem_unregister_endpoint(ep);
>>>> -		if (ret)
>>>> -			return ret;
>>>>    	}
>>>>      	return 0;
>>>> +
>>>> +unregister_ep:
>>>> +	pmt_telem_unregister_endpoint(ep);
>>>> +	return ret;
>>>>    }
>>>>      static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info
>>>> *list, u16 devid)
>>>> @@ -1585,7 +1682,9 @@ int generic_core_init(struct pmc_dev *pmcdev, struct
>>>> pmc_dev_info *pmc_dev_info)
>>>>    		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
>>>>      	if (ssram) {
>>>> -		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info->pci_func);
>>>> +		ret = pmc_core_get_telem_info(pmcdev,
>>>> +					      pmc_dev_info->pci_func,
>>>> +					      pmc_dev_info->telem_info);
>>>>    		if (ret)
>>>>    			goto unmap_regbase;
>>>>    	}
>>>> diff --git a/drivers/platform/x86/intel/pmc/core.h
>>>> b/drivers/platform/x86/intel/pmc/core.h
>>>> index 4a94a4ee031e6..d8c7b28493055 100644
>>>> --- a/drivers/platform/x86/intel/pmc/core.h
>>>> +++ b/drivers/platform/x86/intel/pmc/core.h
>>>> @@ -29,6 +29,10 @@ struct telem_endpoint;
>>>>    #define LPM_REG_COUNT		28
>>>>    #define LPM_MODE_OFFSET		1
>>>>    +/* Telemetry Endpoint Info bits */
>>>> +#define SUB_REQ_LPM		0x01	/* Substate requirement for
>>>> low power mode requirements */
>>>> +#define SUB_REQ_BLK		0x02	/* Substate requirement for
>>>> S0ix blockers */
>>>> +
>>>>    /* Sunrise Point Power Management Controller PCI Device ID */
>>>>    #define SPT_PMC_PCI_DEVICE_ID			0x9d21
>>>>    #define SPT_PMC_BASE_ADDR_OFFSET		0x48
>>>> @@ -344,6 +348,8 @@ struct pmc_bit_map {
>>>>     * @pm_read_disable_bit: Bit index to read PMC_READ_DISABLE
>>>>     * @slps0_dbg_offset:	PWRMBASE offset to SLP_S0_DEBUG_REG*
>>>>     * @s0ix_blocker_offset PWRMBASE offset to S0ix blocker counter
>>>> + * @num_s0ix_blocker:	Number of S0ix blockers
>>>> + * @blocker_req_offset:	Telemetry offset to S0ix blocker low power
>>>> mode substate requirement table
>>>>     *
>>>>     * Each PCH has unique set of register offsets and bit indexes. This
>>>> structure
>>>>     * captures them to have a common implementation.
>>>> @@ -369,6 +375,8 @@ struct pmc_reg_map {
>>>>    	const u32 ltr_ignore_max;
>>>>    	const u32 pm_vric1_offset;
>>>>    	const u32 s0ix_blocker_offset;
>>>> +	const u32 num_s0ix_blocker;
>>>> +	const u32 blocker_req_offset;
>>>>    	/* Low Power Mode registers */
>>>>    	const int lpm_num_maps;
>>>>    	const int lpm_num_modes;
>>>> @@ -404,6 +412,7 @@ struct pmc_info {
>>>>     * @map:		pointer to pmc_reg_map struct that contains platform
>>>>     *			specific attributes
>>>>     * @lpm_req_regs:	List of substate requirements
>>>> + * @blk_sub_req_reqs:	List of registers showing substate
>>>> requirements for S0ix blockers
>>>>     * @ltr_ign:		Holds LTR ignore data while suspended
>>>>     *
>>>>     * pmc contains info about one power management controller device.
>>>> @@ -413,6 +422,7 @@ struct pmc {
>>>>    	void __iomem *regbase;
>>>>    	const struct pmc_reg_map *map;
>>>>    	u32 *lpm_req_regs;
>>>> +	u32 *blk_sub_req_regs;
>>>>    	u32 ltr_ign;
>>>>    };
>>>>    @@ -468,6 +478,7 @@ enum pmc_index {
>>>>    /**
>>>>     * struct pmc_dev_info - Structure to keep PMC device info
>>>>     * @pci_func:		Function number of the primary PMC
>>>> + * @telem_info:		Bitmask to indicate which telemetry info is
>>>> available
>>>>     * @dmu_guid:		Die Management Unit GUID
>>>>     * @regmap_list:	Pointer to a list of pmc_info structure that could be
>>>>     *			available for the platform. When set, this
>>>> field implies
>>>> @@ -480,6 +491,7 @@ enum pmc_index {
>>>>     */
>>>>    struct pmc_dev_info {
>>>>    	u8 pci_func;
>>>> +	u8 telem_info;
>>>>    	u32 dmu_guid;
>>>>    	struct pmc_info *regmap_list;
>>>>    	const struct pmc_reg_map *map;
>>>> diff --git a/drivers/platform/x86/intel/pmc/lnl.c
>>>> b/drivers/platform/x86/intel/pmc/lnl.c
>>>> index e08a77c778c2c..ec9e79f6cd913 100644
>>>> --- a/drivers/platform/x86/intel/pmc/lnl.c
>>>> +++ b/drivers/platform/x86/intel/pmc/lnl.c
>>>> @@ -572,6 +572,7 @@ static int lnl_core_init(struct pmc_dev *pmcdev,
>>>> struct pmc_dev_info *pmc_dev_in
>>>>      struct pmc_dev_info lnl_pmc_dev = {
>>>>    	.pci_func = 2,
>>>> +	.telem_info = SUB_REQ_LPM,
>>>>    	.regmap_list = lnl_pmc_info_list,
>>>>    	.map = &lnl_socm_reg_map,
>>>>    	.suspend = cnl_suspend,
>>>> diff --git a/drivers/platform/x86/intel/pmc/mtl.c
>>>> b/drivers/platform/x86/intel/pmc/mtl.c
>>>> index faa13a7ee688f..c58a871e2e0df 100644
>>>> --- a/drivers/platform/x86/intel/pmc/mtl.c
>>>> +++ b/drivers/platform/x86/intel/pmc/mtl.c
>>>> @@ -994,6 +994,7 @@ static int mtl_core_init(struct pmc_dev *pmcdev,
>>>> struct pmc_dev_info *pmc_dev_in
>>>>      struct pmc_dev_info mtl_pmc_dev = {
>>>>    	.pci_func = 2,
>>>> +	.telem_info = SUB_REQ_LPM,
>>>>    	.dmu_guid = MTL_PMT_DMU_GUID,
>>>>    	.regmap_list = mtl_pmc_info_list,
>>>>    	.map = &mtl_socm_reg_map,
>>>>

