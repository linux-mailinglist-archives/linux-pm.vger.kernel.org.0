Return-Path: <linux-pm+bounces-26151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B46AA9B893
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 21:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B354A3B1E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 19:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A50292913;
	Thu, 24 Apr 2025 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NE5L+IPK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB628F533;
	Thu, 24 Apr 2025 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524649; cv=none; b=p5OSgJmlD62xv80l8566LSLBHg6aZA9VDeFMSXmm6bBDY3Pxw8GTO5MaCHJ5NEVhqmXWe9162kSEoV20eihgybKsrDcOdM1tUjS/n6syaINb9Y2nt+xRbjIoL2nW6LZuamA+FleHjNkfvtRtkvRVEvYwtZvudOvAKUbIFctMpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524649; c=relaxed/simple;
	bh=xk2HklSHaRXg+4pEXe91GYQsP7hQP6/uCKZKADlTiRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJAMW0FJjS+0Po9qncEgZt/W2tbI4sXB7e4o+V0Evg01S96dyW/np4/oBbNMdt9nneqX2Yfflt6SHiOQmYxNySvcCWjwy3rfEc3weqWteDCX4AAIR/L25smJ5EPsYAawM8kNpR9+3xXWXGtpPRQd+YtZYDmOoLWeSGt3K2Wj5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NE5L+IPK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745524648; x=1777060648;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xk2HklSHaRXg+4pEXe91GYQsP7hQP6/uCKZKADlTiRU=;
  b=NE5L+IPKZsXsZG45/t0zLR0RHBPMwGIbP5Tzvp4KCysWcpyIFsThOykh
   zX21IsnZtY+xjaBo0novkfajew6lFMlhJxsTVD2I33B9cwdz8NZ2tv2+P
   d6U1XYnyFNo8QN6/KRNo+KFravjwBipQ5oZwyre8y4CTCdsEgeYAS4NAm
   +0H3HXOc8uze1tz+EvgbVio1sZK4Xk2a3dI/cn4QbpXMaRDZPsHzdh+DD
   8iPuo4bxqd5ozyqpHODKLYDeXAxks44IL0triv9R1nN35SAYTeuR0faVH
   ZBgW/tKU4aL6/0najnVDriPa0ygu/SvymmaQBGYD8uyGcURFcyYVpUTUq
   g==;
X-CSE-ConnectionGUID: ffMkXzubQFK/uS0CxrmXRw==
X-CSE-MsgGUID: J6+zQdrASmugE6eE9cDHoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="58167166"
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="58167166"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 12:57:27 -0700
X-CSE-ConnectionGUID: L0vFnly6RyaTRP1ad4ITdg==
X-CSE-MsgGUID: rZt5qw5fSgWxXEUsPFPMuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="133678995"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.124.101.220]) ([10.124.101.220])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 12:57:26 -0700
Message-ID: <726cab7e-f15b-4319-ac62-1aeeddc9012d@linux.intel.com>
Date: Thu, 24 Apr 2025 12:57:25 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] platform/x86:intel/pmc: Create Intel PMC SSRAM
 Telemetry driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20250421211100.687250-1-xi.pardee@linux.intel.com>
 <20250421211100.687250-3-xi.pardee@linux.intel.com>
 <53a4bf94-ee4f-778d-c0f8-c2e309c440fe@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <53a4bf94-ee4f-778d-c0f8-c2e309c440fe@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/24/2025 7:01 AM, Ilpo Järvinen wrote:
> On Mon, 21 Apr 2025, Xi Pardee wrote:
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
>> ---
>>   drivers/platform/x86/intel/pmc/Kconfig        |   4 +
>>   drivers/platform/x86/intel/pmc/Makefile       |   8 +-
>>   drivers/platform/x86/intel/pmc/core.c         |  79 +++++++---
>>   drivers/platform/x86/intel/pmc/core.h         |   7 -
>>   .../platform/x86/intel/pmc/ssram_telemetry.c  | 147 ++++++++++++------
>>   .../platform/x86/intel/pmc/ssram_telemetry.h  |  24 +++
>>   6 files changed, 188 insertions(+), 81 deletions(-)
>>   create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.h
>>
>> diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
>> index d2f651fbec2c..c6ef0bcf76af 100644
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
>> @@ -24,3 +25,6 @@ config INTEL_PMC_CORE
>>   		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
>>   		- Low Power Mode registers (Tigerlake and beyond)
>>   		- PMC quirks as needed to enable SLPS0/S0ix
>> +
>> +config INTEL_PMC_SSRAM_TELEMETRY
>> +	tristate
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
>> index a53a7677122c..042b60c1185f 100644
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
>> @@ -1455,27 +1456,29 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
>>   	return ret;
>>   }
>>   
>> -static int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
>> +static int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev, int func)
>>   {
>> +	struct pci_dev *pcidev __free(pci_dev_put) = NULL;
>>   	unsigned int i;
>> -	int ret;
>> +	int ret = 0;
> After you remove the return changes below, this change is not needed
> either.
>
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
> These two return changes are unnecessary.

Thanks for the comments.

Will remove these return changes in next version.

Xi

>>   	}
>>   
>> -	return 0;
>> +	return ret;

