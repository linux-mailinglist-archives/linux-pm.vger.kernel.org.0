Return-Path: <linux-pm+bounces-25490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31961A8A6D9
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 20:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F873BC691
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 18:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76564222568;
	Tue, 15 Apr 2025 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAeo6kPZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D0204F73;
	Tue, 15 Apr 2025 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742090; cv=none; b=le0Hg0DAm5RbvaqnzGDTtCMv7e95CC0SHNJvNfFHWBsdLNUft+uFTWk6v2zsJVSlOcGJcFIsSgPDFyx04M4pOenRnJORyJGkr/3DE5nzW57AJx9B+NNkEUwQcLGyTKfhlDdtbc1YqlSBSvmE555GtZm3Ct+2r4k40O1KvitI3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742090; c=relaxed/simple;
	bh=phhOH0q2hHPBnUv6NFlJqx2VhoLlKGwu7IiM+a11e9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlHODBgJ+iZijs7lVHVEhzjdI6qX9MksKELoy0NhEo4sEPosb8hk61darW7z/HWlFvqaycOR0GGgdjkhxGD4Jlt8Qj688cUMroh7NxtbktXdtR6Ordemhdns5unZMZh/Qbw+C1c0LkhaVQBWCYIOosfyXKnMaSwk2YeCwR1mnp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAeo6kPZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744742088; x=1776278088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=phhOH0q2hHPBnUv6NFlJqx2VhoLlKGwu7IiM+a11e9g=;
  b=IAeo6kPZy/S8XJw4K4WS/n7hBBRO3xd/LB57RbeYLmXlIv7cq9gPoQv1
   X9gs1NmhEYjYOKRdqrr8h0rCm/q7fvgla4LuetLGEPMwCnJE6/EIWWTG2
   Xwk42nScnqxhE8TDVCiyz+uu1TIQU2b1F7KMpARHgB5Hsgi84Wqnk9NA+
   HcTc9wYrFeh3DUFAJY8z/+LtekJvee8F9YGdY3l4tVCntjI7ddJVa+eqc
   TNgYLjzSGIqQq2n9NG5bOPqQ88yNcXLKxbZX63cMqooUe0XXxCTCBLn1t
   mfXb+KVKlZFRu/naMZywsjRv/LSjZbfnR1HV0MZjavEfYNLHuDqulMJl8
   A==;
X-CSE-ConnectionGUID: e7QqFRyLQVG5tbFVctMcEA==
X-CSE-MsgGUID: zzBUoS3VTtGp75U0+DucIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="71661879"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="71661879"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 11:34:46 -0700
X-CSE-ConnectionGUID: GJuN+CmHR0Gvzqoxs+yVcA==
X-CSE-MsgGUID: 1c42Nr3aRwaqJS/VV2Jo5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="129974800"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.161.122]) ([10.246.161.122])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 11:34:44 -0700
Message-ID: <7a1144b5-f3fa-4c30-afc6-e02f79cc113d@linux.intel.com>
Date: Tue, 15 Apr 2025 11:34:43 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] platform/x86:intel/pmc: Create Intel PMC SSRAM
 Telemetry driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20250409191056.15434-1-xi.pardee@linux.intel.com>
 <20250409191056.15434-8-xi.pardee@linux.intel.com>
 <19b37c3a-7ba7-92c3-caba-f5ceb759d712@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <19b37c3a-7ba7-92c3-caba-f5ceb759d712@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,

Thanks for the comments. My response are inline.

On 4/11/2025 6:00 AM, Ilpo Järvinen wrote:
> On Wed, 9 Apr 2025, Xi Pardee wrote:
>
>> Convert ssram device related functionalities to a new driver named Intel
>> PMC SSRAM Telemetry driver. Modify PMC Core driver to use API exported by
>> the driver to discover and achieve devid and PWRMBASE address information
>> for each available PMC. PMC Core driver needs to get PCI device when
>> reading from telemetry regions.
>>
>> The new SSRAM driver binds to the SSRAM device and provides the following
>> functionalities:
>> 1. Look for and register telemetry regions available in SSRAM device.
>> 2. Provide devid and PWRMBASE address information for the corresponding
>>     PMCs.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> I took patches 1-6 into review-ilpo-next now, but please consider the
> making the changes I suggested to 1/8 as separate patches.
>
> This one has a few things that should be addressed before inclusion.

The changes in 1/8 will be included in the next version.

>
>> ---
>>   drivers/platform/x86/intel/pmc/Kconfig        |  14 ++
>>   drivers/platform/x86/intel/pmc/Makefile       |   8 +-
>>   drivers/platform/x86/intel/pmc/core.c         |  80 +++++++----
>>   drivers/platform/x86/intel/pmc/core.h         |   7 -
>>   .../platform/x86/intel/pmc/ssram_telemetry.c  | 132 ++++++++++++------
>>   .../platform/x86/intel/pmc/ssram_telemetry.h  |  35 +++++
>>   6 files changed, 198 insertions(+), 78 deletions(-)
>>   create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.h
>>
>> diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
>> index d2f651fbec2c..f5fb1bdc266e 100644
>> --- a/drivers/platform/x86/intel/pmc/Kconfig
>> +++ b/drivers/platform/x86/intel/pmc/Kconfig
>> @@ -8,6 +8,7 @@ config INTEL_PMC_CORE
>>   	depends on PCI
>>   	depends on ACPI
>>   	depends on INTEL_PMT_TELEMETRY
>> +	select INTEL_PMC_SSRAM_TELEMETRY
>>   	help
>>   	  The Intel Platform Controller Hub for Intel Core SoCs provides access
>>   	  to Power Management Controller registers via various interfaces. This
>> @@ -24,3 +25,16 @@ config INTEL_PMC_CORE
>>   		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
>>   		- Low Power Mode registers (Tigerlake and beyond)
>>   		- PMC quirks as needed to enable SLPS0/S0ix
>> +
>> +config INTEL_PMC_SSRAM_TELEMETRY
>> +	tristate
>> +	help
>> +	  The PMC SSRAM device contains counters structured in Intel Platform
>> +	  Monitoring Techology (PMT) telemetry regions. The driver  provides
>> +	  API to expose information of PMCs available in the platform. This
>> +	  driver also looks for and register telemetry regions so they would
>> +	  be available for read through sysfs and Intel PMT API.
>> +
>> +	  The driver needs INTEL_VSEC driver to register for telemetry regions.
>> +	  This requirement has been fulfilled by INTEL_PMC_CORE driver which
>> +	  selects INTEL_PMC_SSRAM_TELEMETRY driver.
> ???
>
> INTEL_PMC_CORE does not select/depend on INTEL_VSEC. I know it "works"
> indirectly through INTEL_PMT_TELEMETRY but a) this Kconfig help text
> is wrong/misleading, b) the way the dependencies are arranged seems
> fragile to me.
>
> What prevents user from enabling INTEL_PMC_SSRAM_TELEMETRY without
> INTEL_PMC_CORE? This will likely blow up a randconfig build at some
> point when stars happen to align right.
>
> Should the help text just be removed? I mean, shouldn't this be selected
> by INTEL_PMC_CORE and never should be chosen on its own by the user?

INTEL_PMC_SSRAM_TELEMETRY driver uses intel_vsec_register() provided by 
the INTEL_VSEC driver to register telem endpoints. INTEL_VSEC driver 
does provide an inline version of the API to use when INTEL_VSEC config 
is not set.

#if IS_ENABLED(CONFIG_INTEL_VSEC)
void intel_vsec_register(struct pci_dev *pdev,
              struct intel_vsec_platform_info *info);
#else
static inline void intel_vsec_register(struct pci_dev *pdev,
                        struct intel_vsec_platform_info *info)
{
}
#endif
#endif

This inline version is not returning error currently and it can be 
changed to return -ENODEV. INTEL_PMC_SSRAM_TELEMETRY can fail the probe 
function when intel_vsec_register() returns error. In this way, 
INTEL_PMC_SSRAM_TELEMETRY does not depends on INTEL_VSEC and randconfig 
build will pass.

The help text for INTEL_PMC_SSRAM_TELEMETRY will be removed in next 
version.

>> diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
>> index e842647d3ced..5f68c8503a56 100644
>> --- a/drivers/platform/x86/intel/pmc/Makefile
>> +++ b/drivers/platform/x86/intel/pmc/Makefile
>> @@ -3,8 +3,12 @@
>>   # Intel x86 Platform-Specific Drivers
>>   #
>>   
>> -intel_pmc_core-y			:= core.o ssram_telemetry.o spt.o cnp.o \
>> -					   icl.o tgl.o adl.o mtl.o arl.o lnl.o ptl.o
>> +intel_pmc_core-y			:= core.o spt.o cnp.o icl.o \
>> +					   tgl.o adl.o mtl.o arl.o lnl.o ptl.o
>>   obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
>>   intel_pmc_core_pltdrv-y			:= pltdrv.o
>>   obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
>> +
>> +# Intel PMC SSRAM driver
>> +intel_pmc_ssram_telemetry-y		+= ssram_telemetry.o
>> +obj-$(CONFIG_INTEL_PMC_SSRAM_TELEMETRY)	+= intel_pmc_ssram_telemetry.o
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index a53a7677122c..26c1c75b709a 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -29,6 +29,7 @@
>>   #include <asm/tsc.h>
>>   
>>   #include "core.h"
>> +#include "ssram_telemetry.h"
>>   #include "../pmt/telemetry.h"
>>   
>>   /* Maximum number of modes supported by platfoms that has low power mode capability */
>> @@ -1354,7 +1355,7 @@ static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *m
>>   	return 0;
>>   }
>>   
>> -static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
>> +static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct pci_dev *pcidev)
>>   {
>>   	struct telem_endpoint *ep;
>>   	const u8 *lpm_indices;
>> @@ -1371,7 +1372,7 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
>>   	if (!guid)
>>   		return -ENXIO;
>>   
>> -	ep = pmt_telem_find_and_register_endpoint(pmcdev->ssram_pcidev, guid, 0);
>> +	ep = pmt_telem_find_and_register_endpoint(pcidev, guid, 0);
>>   	if (IS_ERR(ep)) {
>>   		dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %ld",
>>   			PTR_ERR(ep));
>> @@ -1455,27 +1456,30 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
>>   	return ret;
>>   }
>>   
>> -static int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
>> +static int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev, int func)
>>   {
>> +	struct pci_dev *pcidev;
>>   	unsigned int i;
>> -	int ret;
>> +	int ret = 0;
>>   
>> -	if (!pmcdev->ssram_pcidev)
>> +	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, func));
>> +	if (!pcidev)
>>   		return -ENODEV;
>>   
>>   	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
>>   		if (!pmcdev->pmcs[i])
>>   			continue;
>>   
>> -		ret = pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i]);
>> +		ret = pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i], pcidev);
>>   		if (ret)
>> -			return ret;
>> +			break;
> DEFINE_FREE for pci_dev_put exists so you can do __free(pci_dev_put), so
> you can use cleanup.h to handle the cleanup and keep returning directly
> from here.

Will change to use _free from cleanup.h in next version.

>
>>   	}
>>   
>> -	return 0;
>> +	pci_dev_put(pcidev);
>> +	return ret;
>>   }
>>   
>> -const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
>> +static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
>>   {
>>   	for (; list->map; ++list)
>>   		if (devid == list->devid)
>> @@ -1484,23 +1488,32 @@ const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
>>   	return NULL;
>>   }
>>   
>> -int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
>> -		     const struct pmc_reg_map *reg_map, unsigned int pmc_index)
>> +static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_index)
>> +
>>   {
>> -	struct pmc *pmc = pmcdev->pmcs[pmc_index];
>> +	struct pmc_ssram_telemetry pmc_ssram_telemetry;
>> +	const struct pmc_reg_map *map;
>> +	struct pmc *pmc;
>> +	int ret;
>> +
>> +	ret = pmc_ssram_telemetry_get_pmc_info(pmc_index, &pmc_ssram_telemetry);
>> +	if (ret)
>> +		return ret;
>>   
>> -	if (!pwrm_base)
>> +	map = pmc_core_find_regmap(pmcdev->regmap_list, pmc_ssram_telemetry.devid);
>> +	if (!map)
>>   		return -ENODEV;
>>   
>> -	/* Memory for primary PMC has been allocated in core.c */
>> +	pmc = pmcdev->pmcs[pmc_index];
>> +	/* Memory for primary PMC has been allocated */
>>   	if (!pmc) {
>>   		pmc = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL);
>>   		if (!pmc)
>>   			return -ENOMEM;
>>   	}
>>   
>> -	pmc->map = reg_map;
>> -	pmc->base_addr = pwrm_base;
>> +	pmc->map = map;
>> +	pmc->base_addr = pmc_ssram_telemetry.base_addr;
>>   	pmc->regbase = ioremap(pmc->base_addr, pmc->map->regmap_length);
>>   
>>   	if (!pmc->regbase) {
>> @@ -1513,6 +1526,20 @@ int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
>>   	return 0;
>>   }
>>   
>> +static int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev)
>> +{
>> +	int ret;
>> +
>> +	ret = pmc_core_pmc_add(pmcdev, PMC_IDX_MAIN);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pmc_core_pmc_add(pmcdev, PMC_IDX_IOE);
>> +	pmc_core_pmc_add(pmcdev, PMC_IDX_PCH);
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * When supported, ssram init is used to achieve all available PMCs.
>>    * If ssram init fails, this function uses legacy method to at least get the
>> @@ -1530,10 +1557,18 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>>   	ssram = pmc_dev_info->regmap_list != NULL;
>>   	if (ssram) {
>>   		pmcdev->regmap_list = pmc_dev_info->regmap_list;
>> -		ret = pmc_core_ssram_init(pmcdev, pmc_dev_info->pci_func);
>> +		ret = pmc_core_ssram_get_reg_base(pmcdev);
>> +		/*
>> +		 * EAGAIN error code indicates Intel PMC SSRAM Telemetry driver
>> +		 * has not finished probe and PMC info is not available yet. Try
>> +		 * again later.
>> +		 */
>> +		if (ret == -EAGAIN)
>> +			return -EPROBE_DEFER;
>> +
>>   		if (ret) {
>>   			dev_warn(&pmcdev->pdev->dev,
>> -				 "ssram init failed, %d, using legacy init\n", ret);
>> +				 "Failed to get PMC info from SSRAM, %d, using legacy init\n", ret);
>>   			ssram = false;
>>   		}
>>   	}
>> @@ -1550,7 +1585,7 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>>   		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
>>   
>>   	if (ssram)
>> -		return pmc_core_ssram_get_lpm_reqs(pmcdev);
>> +		return pmc_core_ssram_get_lpm_reqs(pmcdev, pmc_dev_info->pci_func);
>>   
>>   	return 0;
>>   }
>> @@ -1639,15 +1674,10 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
>>   	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
>>   		struct pmc *pmc = pmcdev->pmcs[i];
>>   
>> -		if (pmc)
>> +		if (pmc && pmc->regbase)
>>   			iounmap(pmc->regbase);
>>   	}
>>   
>> -	if (pmcdev->ssram_pcidev) {
>> -		pci_dev_put(pmcdev->ssram_pcidev);
>> -		pci_disable_device(pmcdev->ssram_pcidev);
>> -	}
>> -
>>   	if (pmcdev->punit_ep)
>>   		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
>>   
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index c3b07075d017..e136d18b1d38 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -413,7 +413,6 @@ struct pmc {
>>    * struct pmc_dev - pmc device structure
>>    * @devs:		pointer to an array of pmc pointers
>>    * @pdev:		pointer to platform_device struct
>> - * @ssram_pcidev:	pointer to pci device struct for the PMC SSRAM
>>    * @crystal_freq:	crystal frequency from cpuid
>>    * @dbgfs_dir:		path to debugfs interface
>>    * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
>> @@ -433,7 +432,6 @@ struct pmc_dev {
>>   	struct pmc *pmcs[MAX_NUM_PMC];
>>   	struct dentry *dbgfs_dir;
>>   	struct platform_device *pdev;
>> -	struct pci_dev *ssram_pcidev;
>>   	unsigned int crystal_freq;
>>   	int pmc_xram_read_bit;
>>   	struct mutex lock; /* generic mutex lock for PMC Core */
>> @@ -510,12 +508,7 @@ void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
>>   void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid);
>>   void pmc_core_set_device_d3(unsigned int device);
>>   
>> -int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
>> -
>>   int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
>> -const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid);
>> -int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
>> -		     const struct pmc_reg_map *reg_map, unsigned int pmc_index);
>>   
>>   extern struct pmc_dev_info spt_pmc_dev;
>>   extern struct pmc_dev_info cnp_pmc_dev;
>> diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
>> index 7b8443092b20..232263008030 100644
>> --- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
>> +++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
>> @@ -1,19 +1,18 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>> - * This file contains functions to handle discovery of PMC metrics located
>> - * in the PMC SSRAM PCI device.
>> + * Intel PMC SSRAM TELEMETRY PCI Driver
>>    *
>>    * Copyright (c) 2023, Intel Corporation.
>> - * All Rights Reserved.
>> - *
>>    */
>>   
>>   #include <linux/cleanup.h>
>>   #include <linux/intel_vsec.h>
>>   #include <linux/pci.h>
>> +#include <linux/types.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   
>>   #include "core.h"
>> +#include "ssram_telemetry.h"
>>   
>>   #define SSRAM_HDR_SIZE		0x100
>>   #define SSRAM_PWRM_OFFSET	0x14
>> @@ -23,12 +22,14 @@
>>   #define SSRAM_IOE_OFFSET	0x68
>>   #define SSRAM_DEVID_OFFSET	0x70
>>   
>> -DEFINE_FREE(pmc_core_iounmap, void __iomem *, if (_T) iounmap(_T))
>> +DEFINE_FREE(pmc_ssram_telemetry_iounmap, void __iomem *, if (_T) iounmap(_T))
>> +
>> +static struct pmc_ssram_telemetry *pmc_ssram_telems;
>> +static bool device_probed;
>>   
>>   static void
>> -pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
>> +pmc_ssram_telemetry_add_pmt(struct pci_dev *pcidev, u64 ssram_base, void __iomem *ssram)
>>   {
>> -	struct pci_dev *pcidev = pmcdev->ssram_pcidev;
>>   	struct intel_vsec_platform_info info = {};
>>   	struct intel_vsec_header *headers[2] = {};
>>   	struct intel_vsec_header header;
>> @@ -57,7 +58,7 @@ pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
>>   	info.caps = VSEC_CAP_TELEMETRY;
>>   	info.headers = headers;
>>   	info.base_addr = ssram_base;
>> -	info.parent = &pmcdev->pdev->dev;
>> +	info.parent = &pcidev->dev;
>>   
>>   	intel_vsec_register(pcidev, &info);
>>   }
>> @@ -68,19 +69,14 @@ static inline u64 get_base(void __iomem *addr, u32 offset)
>>   }
>>   
>>   static int
>> -pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, unsigned int pmc_idx, u32 offset)
>> +pmc_ssram_telemetry_get_pmc(struct pci_dev *pcidev, unsigned int pmc_idx, u32 offset)
>>   {
>> -	struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
>> -	void __iomem __free(pmc_core_iounmap) *tmp_ssram = NULL;
>> -	void __iomem __free(pmc_core_iounmap) *ssram = NULL;
>> -	const struct pmc_reg_map *map;
>> +	void __iomem __free(pmc_ssram_telemetry_iounmap) * tmp_ssram = NULL;
>> +	void __iomem __free(pmc_ssram_telemetry_iounmap) * ssram = NULL;
>>   	u64 ssram_base, pwrm_base;
>>   	u16 devid;
>>   
>> -	if (!pmcdev->regmap_list)
>> -		return -ENOENT;
>> -
>> -	ssram_base = ssram_pcidev->resource[0].start;
>> +	ssram_base = pcidev->resource[0].start;
> pci_resource_start()
Will change in next version.
>
>>   	tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
>>   	if (!tmp_ssram)
>>   		return -ENOMEM;
>> @@ -107,45 +103,93 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, unsigned int pmc_idx, u32 offset)
>>   	devid = readw(ssram + SSRAM_DEVID_OFFSET);
>>   
>>   	/* Find and register and PMC telemetry entries */
>> -	pmc_add_pmt(pmcdev, ssram_base, ssram);
>> +	pmc_ssram_telemetry_add_pmt(pcidev, ssram_base, ssram);
>>   
>> -	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
>> -	if (!map)
>> +	pmc_ssram_telems[pmc_idx].devid = devid;
>> +	pmc_ssram_telems[pmc_idx].base_addr = pwrm_base;
>> +
>> +	return 0;
>> +}
>> +
>> +int pmc_ssram_telemetry_get_pmc_info(unsigned int pmc_idx,
>> +				     struct pmc_ssram_telemetry *pmc_ssram_telemetry)
>> +{
>> +	/*
>> +	 * PMCs are discovered in probe function. If this function is called before
>> +	 * probe function complete, the result would be invalid. Use device_probed
>> +	 * variable to avoid this case. Return -EAGAIN to inform the consumer to call
>> +	 * again later.
>> +	 */
>> +	if (!device_probed)
>> +		return -EAGAIN;
>> +
>> +	/*
>> +	 * Memory barrier is used to ensure the correct read order between
>> +	 * device_probed variable and PMC info.
>> +	 */
>> +	smp_rmb();
>> +	if (pmc_idx >= MAX_NUM_PMC)
>> +		return -EINVAL;
>> +
>> +	if (!pmc_ssram_telems || !pmc_ssram_telems[pmc_idx].devid)
>>   		return -ENODEV;
>>   
>> -	return pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
>> +	pmc_ssram_telemetry->devid = pmc_ssram_telems[pmc_idx].devid;
>> +	pmc_ssram_telemetry->base_addr = pmc_ssram_telems[pmc_idx].base_addr;
>> +	return 0;
>>   }
>> +EXPORT_SYMBOL_GPL(pmc_ssram_telemetry_get_pmc_info);
>>   
>> -int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func)
>> +static int intel_pmc_ssram_telemetry_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
>>   {
>> -	struct pci_dev *pcidev;
>>   	int ret;
>>   
>> -	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, func));
>> -	if (!pcidev)
>> -		return -ENODEV;
>> +	pmc_ssram_telems = devm_kzalloc(&pcidev->dev, sizeof(*pmc_ssram_telems) * MAX_NUM_PMC,
>> +					GFP_KERNEL);
>> +	if (!pmc_ssram_telems) {
>> +		ret = -ENOMEM;
>> +		goto probe_finish;
>> +	}
>>   
>>   	ret = pcim_enable_device(pcidev);
>> -	if (ret)
>> -		goto release_dev;
>> -
>> -	pmcdev->ssram_pcidev = pcidev;
>> +	if (ret) {
>> +		dev_dbg(&pcidev->dev, "failed to enable PMC SSRAM device\n");
>> +		goto probe_finish;
>> +	}
>>   
>> -	ret = pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_MAIN, 0);
>> +	ret = pmc_ssram_telemetry_get_pmc(pcidev, PMC_IDX_MAIN, 0);
>>   	if (ret)
>> -		goto disable_dev;
>> -
>> -	pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
>> -	pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
>> -
>> -	return 0;
>> -
>> -disable_dev:
>> -	pmcdev->ssram_pcidev = NULL;
>> -	pci_disable_device(pcidev);
>> -release_dev:
>> -	pci_dev_put(pcidev);
>> -
>> +		goto probe_finish;
>> +
>> +	pmc_ssram_telemetry_get_pmc(pcidev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
>> +	pmc_ssram_telemetry_get_pmc(pcidev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
>> +
>> +probe_finish:
>> +	/*
>> +	 * Memory barrier is used to ensure the correct write order between PMC info
>> +	 * and device_probed variable.
>> +	 */
>> +	smp_wmb();
>> +	device_probed = true;
>>   	return ret;
>>   }
>> +
>> +static const struct pci_device_id intel_pmc_ssram_telemetry_pci_ids[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_MTL_SOCM) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCS) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCM) },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(pci, intel_pmc_ssram_telemetry_pci_ids);
>> +
>> +static struct pci_driver intel_pmc_ssram_telemetry_driver = {
>> +	.name = "intel_pmc_ssram_telemetry",
>> +	.id_table = intel_pmc_ssram_telemetry_pci_ids,
>> +	.probe = intel_pmc_ssram_telemetry_probe,
>> +};
>> +module_pci_driver(intel_pmc_ssram_telemetry_driver);
>> +
>>   MODULE_IMPORT_NS("INTEL_VSEC");
>> +MODULE_AUTHOR("Xi Pardee <xi.pardee@intel.com>");
>> +MODULE_DESCRIPTION("Intel PMC SSRAM Telemetry driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.h b/drivers/platform/x86/intel/pmc/ssram_telemetry.h
>> new file mode 100644
>> index 000000000000..459a29efebea
>> --- /dev/null
>> +++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Intel PMC SSRAM Telemetry PCI Driver Header File
>> + *
>> + * Copyright (c) 2024, Intel Corporation.
>> + */
>> +
>> +#ifndef PMC_SSRAM_H
>> +#define PMC_SSRAM_H
>> +
>> +/**
>> + * struct pmc_ssram_telemetry - Structure to keep pmc info in ssram device
>> + * @devid:		device id of the pmc device
>> + * @base_addr:		contains PWRM base address
>> + */
>> +struct pmc_ssram_telemetry {
>> +	u16 devid;
>> +	u64 base_addr;
>> +};
>> +
>> +/**
>> + * pmc_ssram_telemetry_get_pmc_info() - Get a PMC devid and base_addr information
>> + * @pmc_idx:               Index of the PMC
>> + * @pmc_ssram_telemetry:   pmc_ssram_telemetry structure to store the PMC information
>> + *
>> + * Return:
>> + * * 0           - Success
>> + * * -EAGAIN     - Probe function has not finished yet. Try again.
>> + * * -EINVAL     - Invalid pmc_idx
>> + * * -ENODEV     - PMC device is not available
>> + */
> Usually, the function kernel doc is where the code is. This is not an end
> of the world but it's even less likely the kerneldoc and code will keep in
> synch if they reside in different files so preferrably put it into the .c
> file.

Will move it in ssram_telemetry.c in next version.

Thanks!

Xi

>
>> +int pmc_ssram_telemetry_get_pmc_info(unsigned int pmc_idx,
>> +				     struct pmc_ssram_telemetry *pmc_ssram_telemetry);
>> +
>> +#endif /* PMC_SSRAM_H */
>>

