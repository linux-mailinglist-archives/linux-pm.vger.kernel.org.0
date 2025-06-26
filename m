Return-Path: <linux-pm+bounces-29621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CDCAEA8A1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 23:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70CC4E2C12
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 21:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1100121B9DE;
	Thu, 26 Jun 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwqc0HKB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDE325F973;
	Thu, 26 Jun 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972617; cv=none; b=P+M+A9KE+idTrIMYIet/2vAslzT8NL8Fw2lgni8qUtnDfJy3mBtFT7TYaCcJVOtT14AJin6kfTXCVd0buoXCcOUPrMMVJeD+5VBFaI0pV0uVzdRVoapwn+YaP502qFDM0U31Z82uxIksJeJNEFWuEfcBITt3u5VfOwkYA4LElGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972617; c=relaxed/simple;
	bh=8DCuUlrByB18wtBOMY+7jCWj6C3BA/6sZg05U3XRFwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1KS+NJjFDFCqLx018CNcEuugtNRaQZn9pasVPmrcuh6BT5wOCf5KzDmb8Xc+yGg4JDWh3PlAs6ETeooajnVZK2Jh4VO5GcTbzbB52mGvV+/zZBUdZQMdC0BC+l/k+A0EQt9Q2F5Hp0wrt3Ye2L3J4UdqeicyzlSuW0D1Iqj2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwqc0HKB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750972615; x=1782508615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8DCuUlrByB18wtBOMY+7jCWj6C3BA/6sZg05U3XRFwk=;
  b=jwqc0HKBBDM+/aim9iQV/X5UIlJyRvzHxZ7FtcWSqJ2IerRwcz6Qkee8
   tqf2+n0DY2gQV9k2ydfTAXy1R+9kedXaRvRigBRjB4Xg4Vu8VlJ43sTwP
   iDgDw4CENZVXvdr5QKnZGXhmDXN2DDrY3hv0F24eDSkohrik7dyylp02N
   maq7BIC7jfe/Rf1JilVOBi1ikwrkd2RmW5mafuhAQ4355+0kSEr7PIyIb
   AXS6DrYybI7aop82D1W8sSf+fxqLss94FdMW4vGR8Dm6e24zi9qqBZRj2
   urmBuC5P5U6j8zhr3kPYDDI17dr9bmMSHSXvnSPjlp4EJvSDnP3aIcLs6
   g==;
X-CSE-ConnectionGUID: 2ss5eZWdRMCnDHReiWzDIQ==
X-CSE-MsgGUID: j1DlorsPQGiuB068POpuNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53145986"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="53145986"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 14:16:53 -0700
X-CSE-ConnectionGUID: JmXfvJ6JRAyHjOhCdtU4ng==
X-CSE-MsgGUID: oNP8SeXlTA6aQRYDT1q7lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="183657639"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.154.149]) ([10.246.154.149])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 14:16:53 -0700
Message-ID: <4d9c848f-ea87-4b94-b9d3-94362e59a4af@linux.intel.com>
Date: Thu, 26 Jun 2025 14:16:51 -0700
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
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <6f43709c-dfcb-059e-758a-be6a56538724@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,

Thanks for reviewing the patch. My response is inline.

On 6/26/2025 9:38 AM, Ilpo Järvinen wrote:
> On Tue, 24 Jun 2025, Xi Pardee wrote:
>
>> Add support to read and show S0ix blocker substate requirements.
>> Starting from Panther Lake, substate requirement data is provided
>> based on S0ix blockers instead of all low power mode requirements.
>> For platforms that support this new feature, add support to display
>> substate requirements based on S0ix blockers.
> Empty line.
Will fix in next version.
>
>> Change the "substate_requirements" attribute of Intel PMC Core
>> driver to show the substate requirements for each S0ix blocker
>> and the corresponding S0ix blocker value.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/arl.c  |   2 +
>>   drivers/platform/x86/intel/pmc/core.c | 111 ++++++++++++++++++++++++--
>>   drivers/platform/x86/intel/pmc/core.h |  12 +++
>>   drivers/platform/x86/intel/pmc/lnl.c  |   1 +
>>   drivers/platform/x86/intel/pmc/mtl.c  |   1 +
>>   5 files changed, 121 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
>> index 9d66d65e75779..1852876be234f 100644
>> --- a/drivers/platform/x86/intel/pmc/arl.c
>> +++ b/drivers/platform/x86/intel/pmc/arl.c
>> @@ -722,6 +722,7 @@ static int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_
>>   
>>   struct pmc_dev_info arl_pmc_dev = {
>>   	.pci_func = 0,
>> +	.telem_info = SUB_REQ_LPM,
>>   	.dmu_guid = ARL_PMT_DMU_GUID,
>>   	.regmap_list = arl_pmc_info_list,
>>   	.map = &arl_socs_reg_map,
>> @@ -732,6 +733,7 @@ struct pmc_dev_info arl_pmc_dev = {
>>   
>>   struct pmc_dev_info arl_h_pmc_dev = {
>>   	.pci_func = 2,
>> +	.telem_info = SUB_REQ_LPM,
>>   	.dmu_guid = ARL_PMT_DMU_GUID,
>>   	.regmap_list = arl_pmc_info_list,
>>   	.map = &mtl_socm_reg_map,
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 47cc5120e7dd6..e9d281b064462 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -844,6 +844,56 @@ static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index,
>>   		seq_printf(s, " %9s |\n", name);
>>   }
>>   
>> +static int pmc_core_substate_blk_req_show(struct seq_file *s, void *unused)
>> +{
>> +	struct pmc_dev *pmcdev = s->private;
>> +	unsigned int pmc_index;
>> +	u32 *blk_sub_req_regs;
> Why is this here and the other variable in the inner block?
Will move the blk_sub_req_regs declaration to the inner block.
>
>> +
>> +	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs); pmc_index++) {
>> +		const struct pmc_bit_map **maps;
>> +		unsigned int arr_size, r_idx;
>> +		u32 offset, counter;
>> +		struct pmc *pmc;
>> +
>> +		pmc = pmcdev->pmcs[pmc_index];
>> +		if (!pmc || !pmc->blk_sub_req_regs)
>> +			continue;
>> +
>> +		blk_sub_req_regs = pmc->blk_sub_req_regs;
>> +		maps = pmc->map->s0ix_blocker_maps;
>> +		offset = pmc->map->s0ix_blocker_offset;
>> +		arr_size = pmc_core_lpm_get_arr_size(maps);
>> +
>> +		/* Display the header */
>> +		pmc_core_substate_req_header_show(s, pmc_index, "Value");
>> +
>> +		for (r_idx = 0; r_idx < arr_size; r_idx++) {
>> +			const struct pmc_bit_map *map;
>> +
>> +			for (map = maps[r_idx]; map->name; map++) {
>> +				int mode;
>> +
>> +				if (!map->blk)
>> +					continue;
>> +
>> +				counter = pmc_core_reg_read(pmc, offset);
>> +				seq_printf(s, "pmc%d: %34s |", pmc_index, map->name);
>> +				pmc_for_each_mode(mode, pmcdev) {
>> +					bool required = *blk_sub_req_regs & BIT(mode);
>> +
>> +					seq_printf(s, " %9s |", required ? "Required" : " ");
>> +				}
>> +				seq_printf(s, " %9d |\n", counter);
>> +				offset += map->blk * S0IX_BLK_SIZE;
>> +				blk_sub_req_regs++;
>> +			}
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_blk_req);
>> +
>>   static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>>   {
>>   	struct pmc_dev *pmcdev = s->private;
>> @@ -1335,7 +1385,10 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>>   		debugfs_create_file("substate_requirements", 0444,
>>   				    pmcdev->dbgfs_dir, pmcdev,
>>   				    &pmc_core_substate_req_regs_fops);
>> -	}
>> +	} else if (primary_pmc->blk_sub_req_regs)
>> +		debugfs_create_file("substate_requirements", 0444,
>> +				    pmcdev->dbgfs_dir, pmcdev,
>> +				    &pmc_core_substate_blk_req_fops);
>>
>>   	if (primary_pmc->map->pson_residency_offset && pmc_core_is_pson_residency_enabled(pmcdev)) {
>>   		debugfs_create_file("pson_residency_usec", 0444,
>> @@ -1441,7 +1494,38 @@ static int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc,
>>   	return ret;
>>   }
>>   
>> -static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
>> +static int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
>> +					struct telem_endpoint *ep)
>> +{
>> +	u32 num_blocker, sample_id;
>> +	unsigned int index;
>> +	u32 *req_offset;
>> +	int ret;
>> +
>> +	num_blocker = pmc->map->num_s0ix_blocker;
>> +	sample_id = pmc->map->blocker_req_offset;
>> +
>> +	pmc->blk_sub_req_regs = devm_kcalloc(&pmcdev->pdev->dev,
>> +					 num_blocker, sizeof(u32),
>> +					 GFP_KERNEL);
> Correct alignment.
>
> I guess you want to keep those two args on the same line as this would fit
> on 2 lines.
Will change the alignment and move two args to be on one line.
>
>> +	if (!pmc->blk_sub_req_regs)
>> +		return -ENOMEM;
>> +
>> +	req_offset = pmc->blk_sub_req_regs;
>> +	for (index = 0; index < num_blocker; index++) {
>> +		ret = pmt_telem_read32(ep, sample_id, req_offset, 1);
>> +		if (ret) {
>> +			dev_err(&pmcdev->pdev->dev,
>> +				"couldn't read Low Power Mode requirements: %d\n", ret);
>> +			return ret;
>> +		}
>> +		sample_id++;
>> +		req_offset++;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func, unsigned int telem_info)
>>   {
>>   	struct pci_dev *pcidev __free(pci_dev_put) = NULL;
>>   	struct telem_endpoint *ep;
>> @@ -1470,13 +1554,26 @@ static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
>>   			return -EPROBE_DEFER;
>>   		}
>>   
>> -		ret = pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
>> +		if (telem_info & SUB_REQ_LPM) {
>> +			ret = pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
>> +			if (ret)
>> +				goto unregister_ep;
>> +		}
>> +
>> +		if (telem_info & SUB_REQ_BLK) {
> These two are mutually exclusive? I'm really wondering cuold pointers be
> used instead to avoid these ifs here and in debugfs fops selection.
The SUB_REQ_BLK and SUB_REQ_LPM are mutually exclusive. We will also 
introduce more
types of data from the telemetry endpoint but not mutually exclusive in 
the next series, therefore
using bit to identify the type of data sounds appropriate to me. I am 
not sure how to use pointer to
select data type in this scenario, Could you please give an example?

Thanks!

Xi

>
>> +			ret = pmc_core_pmt_get_blk_sub_req(pmcdev, pmc, ep);
>> +			if (ret)
>> +				goto unregister_ep;
>> +		}
>> +
>>   		pmt_telem_unregister_endpoint(ep);
>> -		if (ret)
>> -			return ret;
>>   	}
>>   
>>   	return 0;
>> +
>> +unregister_ep:
>> +	pmt_telem_unregister_endpoint(ep);
>> +	return ret;
>>   }
>>   
>>   static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
>> @@ -1585,7 +1682,9 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>>   		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
>>   
>>   	if (ssram) {
>> -		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info->pci_func);
>> +		ret = pmc_core_get_telem_info(pmcdev,
>> +					      pmc_dev_info->pci_func,
>> +					      pmc_dev_info->telem_info);
>>   		if (ret)
>>   			goto unmap_regbase;
>>   	}
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index 4a94a4ee031e6..d8c7b28493055 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -29,6 +29,10 @@ struct telem_endpoint;
>>   #define LPM_REG_COUNT		28
>>   #define LPM_MODE_OFFSET		1
>>   
>> +/* Telemetry Endpoint Info bits */
>> +#define SUB_REQ_LPM		0x01	/* Substate requirement for low power mode requirements */
>> +#define SUB_REQ_BLK		0x02	/* Substate requirement for S0ix blockers */
>> +
>>   /* Sunrise Point Power Management Controller PCI Device ID */
>>   #define SPT_PMC_PCI_DEVICE_ID			0x9d21
>>   #define SPT_PMC_BASE_ADDR_OFFSET		0x48
>> @@ -344,6 +348,8 @@ struct pmc_bit_map {
>>    * @pm_read_disable_bit: Bit index to read PMC_READ_DISABLE
>>    * @slps0_dbg_offset:	PWRMBASE offset to SLP_S0_DEBUG_REG*
>>    * @s0ix_blocker_offset PWRMBASE offset to S0ix blocker counter
>> + * @num_s0ix_blocker:	Number of S0ix blockers
>> + * @blocker_req_offset:	Telemetry offset to S0ix blocker low power mode substate requirement table
>>    *
>>    * Each PCH has unique set of register offsets and bit indexes. This structure
>>    * captures them to have a common implementation.
>> @@ -369,6 +375,8 @@ struct pmc_reg_map {
>>   	const u32 ltr_ignore_max;
>>   	const u32 pm_vric1_offset;
>>   	const u32 s0ix_blocker_offset;
>> +	const u32 num_s0ix_blocker;
>> +	const u32 blocker_req_offset;
>>   	/* Low Power Mode registers */
>>   	const int lpm_num_maps;
>>   	const int lpm_num_modes;
>> @@ -404,6 +412,7 @@ struct pmc_info {
>>    * @map:		pointer to pmc_reg_map struct that contains platform
>>    *			specific attributes
>>    * @lpm_req_regs:	List of substate requirements
>> + * @blk_sub_req_reqs:	List of registers showing substate requirements for S0ix blockers
>>    * @ltr_ign:		Holds LTR ignore data while suspended
>>    *
>>    * pmc contains info about one power management controller device.
>> @@ -413,6 +422,7 @@ struct pmc {
>>   	void __iomem *regbase;
>>   	const struct pmc_reg_map *map;
>>   	u32 *lpm_req_regs;
>> +	u32 *blk_sub_req_regs;
>>   	u32 ltr_ign;
>>   };
>>   
>> @@ -468,6 +478,7 @@ enum pmc_index {
>>   /**
>>    * struct pmc_dev_info - Structure to keep PMC device info
>>    * @pci_func:		Function number of the primary PMC
>> + * @telem_info:		Bitmask to indicate which telemetry info is available
>>    * @dmu_guid:		Die Management Unit GUID
>>    * @regmap_list:	Pointer to a list of pmc_info structure that could be
>>    *			available for the platform. When set, this field implies
>> @@ -480,6 +491,7 @@ enum pmc_index {
>>    */
>>   struct pmc_dev_info {
>>   	u8 pci_func;
>> +	u8 telem_info;
>>   	u32 dmu_guid;
>>   	struct pmc_info *regmap_list;
>>   	const struct pmc_reg_map *map;
>> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
>> index e08a77c778c2c..ec9e79f6cd913 100644
>> --- a/drivers/platform/x86/intel/pmc/lnl.c
>> +++ b/drivers/platform/x86/intel/pmc/lnl.c
>> @@ -572,6 +572,7 @@ static int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>>   
>>   struct pmc_dev_info lnl_pmc_dev = {
>>   	.pci_func = 2,
>> +	.telem_info = SUB_REQ_LPM,
>>   	.regmap_list = lnl_pmc_info_list,
>>   	.map = &lnl_socm_reg_map,
>>   	.suspend = cnl_suspend,
>> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
>> index faa13a7ee688f..c58a871e2e0df 100644
>> --- a/drivers/platform/x86/intel/pmc/mtl.c
>> +++ b/drivers/platform/x86/intel/pmc/mtl.c
>> @@ -994,6 +994,7 @@ static int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>>   
>>   struct pmc_dev_info mtl_pmc_dev = {
>>   	.pci_func = 2,
>> +	.telem_info = SUB_REQ_LPM,
>>   	.dmu_guid = MTL_PMT_DMU_GUID,
>>   	.regmap_list = mtl_pmc_info_list,
>>   	.map = &mtl_socm_reg_map,
>>

