Return-Path: <linux-pm+bounces-21721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C25A2F682
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 19:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A2B3A2DA0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043132253B0;
	Mon, 10 Feb 2025 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjsOHtvG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0A22258C;
	Mon, 10 Feb 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211095; cv=none; b=cVdx7bYush0Zj79Sgvfog7usMRxw2zNaFXA2SBUBFYNvWbaxmPlw3S4/L0wiZBoCN6DLHqSXIbV8qM+0rfSGFFysp9GgrJ6/PGn0prJHDHYsr6JaR9TUoj/A5PGpZNVJiLgqtawHXSAcyd1Tt9BKIMBUbnMLffGaZKYqqr7J01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211095; c=relaxed/simple;
	bh=TiwNFmrau+blS58gEo8VQ35n8oWuHMrryKJ6O8GxiTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JztBpgppdA8M/NYHHxrt6A5IAHxMhxh8G79EVO0ixC6SJLoTHGb+imz5SvrGsNp/XNJcwBKwVYq9nj+REGkL+i76dbneqANoqLYHVnXer3QQk37JSQXubm3n/UE82udv90OGNGZiNA6R0DkJD0z/CpLriRaeBdchblsFQ4LEHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjsOHtvG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739211095; x=1770747095;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TiwNFmrau+blS58gEo8VQ35n8oWuHMrryKJ6O8GxiTc=;
  b=FjsOHtvGgU9QXgJ1Oh/2lCfkZCg+MDJSQeniczmrrpt7GqWx9It73LqF
   JWwwJ7XU9c4r5mtB3sJtN4X2FmwwKgyHelXAtXckxXw/n9NLGX2meIs5+
   hP+QgMd5hdWeh9UZ5PMg0WCdn1kGlBxmkYFNXb22rZsuYpaf22wQHFJSy
   5uersQHJEtXqxt8a4oA4vf7hMTXt1/Lt+6D4RBM6iMSf9s7nfjkTZKWiy
   n37ns7Wbj7jh+EJxSwoXWQQYoyE2sS13IizsZBztW0FF8mshGYCTUUkqU
   5p4b0DQnnhkxOsukHlw6hX5BsIfs6SUEvuGcvm1a92ZfAtFGEVlPo+hzd
   w==;
X-CSE-ConnectionGUID: Sj0VqO/0TkSfQDAYShRujg==
X-CSE-MsgGUID: Rf7hrAV6QYKk1htujVjiDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50036399"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="50036399"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 10:11:34 -0800
X-CSE-ConnectionGUID: gdyjt1ghROawv8LDB2oSKA==
X-CSE-MsgGUID: 5U7N7k1sQHytulrx69CPEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112120129"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.158.142]) ([10.246.158.142])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 10:11:33 -0800
Message-ID: <ff3c976e-2e2f-4a95-b53e-e3199f332e23@linux.intel.com>
Date: Mon, 10 Feb 2025 10:11:29 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] platform/x86:intel/pmc: Move arch specific action
 to init function
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com,
 david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
References: <20250207225615.401235-1-xi.pardee@linux.intel.com>
 <20250207225615.401235-6-xi.pardee@linux.intel.com>
 <69b2b41b-5fcd-a7f2-576a-b00f2d390d8e@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <69b2b41b-5fcd-a7f2-576a-b00f2d390d8e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/10/2025 3:58 AM, Ilpo Järvinen wrote:
> On Fri, 7 Feb 2025, Xi Pardee wrote:
>
>> Move arch specific action from core.c to the init() function of spt.c.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 13 -------------
>>   drivers/platform/x86/intel/pmc/spt.c  | 21 +++++++++++++++++++++
>>   2 files changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 628cb22221fbc..06821c41fbeb9 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1416,11 +1416,6 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>>   
>>   MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_ids);
>>   
>> -static const struct pci_device_id pmc_pci_ids[] = {
>> -	{ PCI_VDEVICE(INTEL, SPT_PMC_PCI_DEVICE_ID) },
>> -	{ }
>> -};
>> -
>>   /*
>>    * This quirk can be used on those platforms where
>>    * the platform BIOS enforces 24Mhz crystal to shutdown
>> @@ -1531,14 +1526,6 @@ static int pmc_core_probe(struct platform_device *pdev)
>>   	if (!pmcdev->pkgc_res_cnt)
>>   		return -ENOMEM;
>>   
>> -	/*
>> -	 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
>> -	 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
>> -	 * in this case.
>> -	 */
>> -	if (pmc_dev_info == &spt_pmc_dev && !pci_dev_present(pmc_pci_ids))
>> -		pmc_dev_info = &cnp_pmc_dev;
>> -
>>   	mutex_init(&pmcdev->lock);
>>   
>>   	if (pmc_dev_info->init)
>> diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
>> index 956b2ec1c7510..9289cd76b0145 100644
>> --- a/drivers/platform/x86/intel/pmc/spt.c
>> +++ b/drivers/platform/x86/intel/pmc/spt.c
>> @@ -8,6 +8,8 @@
>>    *
>>    */
>>   
>> +#include <linux/pci.h>
>> +
>>   #include "core.h"
>>   
>>   const struct pmc_bit_map spt_pll_map[] = {
>> @@ -134,6 +136,25 @@ const struct pmc_reg_map spt_reg_map = {
>>   	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
>>   };
>>   
>> +static const struct pci_device_id pmc_pci_ids[] = {
>> +	{ PCI_VDEVICE(INTEL, SPT_PMC_PCI_DEVICE_ID) },
>> +	{ }
>> +};
>> +
>> +static int spt_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>> +{
>> +	/*
>> +	 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
>> +	 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
>> +	 * in this case.
>> +	 */
>> +	if (!pci_dev_present(pmc_pci_ids))
>> +		return generic_core_init(pmcdev, &cnp_pmc_dev);
>> +
>> +	return generic_core_init(pmcdev, pmc_dev_info);
>> +}
>> +
>>   struct pmc_dev_info spt_pmc_dev = {
>>   	.map = &spt_reg_map,
>> +	.init = spt_core_init,
>>   };
>>
> Hi,
>
> I've applied all but this patch into the review-ilpo-next branch.
>
> This change is good otherwise but I'd prefer the pmc_pci_ids be named
> better such that it actually relates to why it exists :-). So please
> respin this patch.


Hi,

Thanks! I will change the name in next version.

Xi


