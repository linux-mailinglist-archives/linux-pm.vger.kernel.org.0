Return-Path: <linux-pm+bounces-26152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A2FA9B899
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 21:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF921BA2578
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 19:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431EF292912;
	Thu, 24 Apr 2025 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVK/CGCM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717B42918DB;
	Thu, 24 Apr 2025 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524696; cv=none; b=phV5UvR6UHvqS4g+wzlS+YEfPu/yLSf0CUEb7v7B2z5q5CSSDNbvEeg2vFQCsZimEur0uJKmXLqUmK+XVYD4G9dTNa/r/CzXHMiQrX3aCn6o4ZBM0wZOM0jL8mu3CQoe+ElieiWrqnyifYyYIKDgQKcdwNggEJjM4JRIs8beOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524696; c=relaxed/simple;
	bh=jCqnrkO49i/1KDnDy3AYs8SCV2Yp2zZbgIKGirX117w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZP1OFvNPpoQa8V0sugvfKbjTA8xRWdpObrNil5XcwM8Tam2M3EiT8/IjtGRWypjgExQqNcet7xyjN0UK24JiSQ5NubpELSma7H2q4FcQHDJUTTI2PAb0TMRZVrzZfK451tAPlHZeMriWwoNN79ajTaNyxVS5VF2PCIPw6BK+UZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVK/CGCM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745524695; x=1777060695;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jCqnrkO49i/1KDnDy3AYs8SCV2Yp2zZbgIKGirX117w=;
  b=LVK/CGCMEm3oK/EHX81F/+alWcW8zmEfGtMTSsFX7piscwES+Tpp6ahq
   rFFu5KIFky9lLkH5fuWaxgB+wGWYzQFz+o9+/LlQ8QusveE9hbjTOSVd1
   jvW+o+v+sy42RxrytFE3UqWE11/jWd2VSVqZ0LEg9SCbwj4Ugv9irAnMz
   MZyOAaMPEbaHWWGj27ncSceKtKDfzb93SE5NB1wqSbh62dm2LwGcSloWC
   83fiZLupDp5gKi8YieHFQo+jEyicHK3HcbWl0GnTOgKBKY0SQ0zO990py
   SJePxxISnW5yMhebmixv/uKCzbo637DibNayxTDAj+IGD5L7MgxR+zwHD
   A==;
X-CSE-ConnectionGUID: lIZZPLv0S6KMhRZsRfFMmw==
X-CSE-MsgGUID: wed0sED/Ssiy/bziQZKw0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="58167196"
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="58167196"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 12:58:14 -0700
X-CSE-ConnectionGUID: JgFzrgizQpOpB0Mkg8fUZA==
X-CSE-MsgGUID: 234+q1wvQwCY3fUsv8QVqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="133679088"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.124.101.220]) ([10.124.101.220])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 12:58:13 -0700
Message-ID: <a659c122-5a39-451e-8c24-102f4d240bd3@linux.intel.com>
Date: Thu, 24 Apr 2025 12:58:12 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] platform/x86:intel/pmc: Move error handling to
 init function
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20250421211100.687250-1-xi.pardee@linux.intel.com>
 <20250421211100.687250-4-xi.pardee@linux.intel.com>
 <c468af86-4bb8-4a8b-b601-07e29d4907e3@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <c468af86-4bb8-4a8b-b601-07e29d4907e3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/24/2025 7:02 AM, Ilpo Järvinen wrote:
> On Mon, 21 Apr 2025, Xi Pardee wrote:
>
>> Move error handling code to generic_core_init() function. The previous
>> implementation is that init function called for "full cleanup" function
>> when error occurs which is error prone. The init function should handle
>> the error path itself to improve code maintainability.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 23 ++++++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 042b60c1185f..e09a97564398 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1583,10 +1583,26 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>>   	if (pmc_dev_info->dmu_guid)
>>   		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
>>   
>> -	if (ssram)
>> -		return pmc_core_ssram_get_lpm_reqs(pmcdev, pmc_dev_info->pci_func);
>> +	if (ssram) {
>> +		ret = pmc_core_ssram_get_lpm_reqs(pmcdev, pmc_dev_info->pci_func);
>> +		if (ret)
>> +			goto unmap_regbase;
>> +	}
>>   
>>   	return 0;
>> +
>> +unmap_regbase:
>> +	for (unsigned int i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
>> +		struct pmc *pmc = pmcdev->pmcs[i];
>> +
>> +		if (pmc && pmc->regbase)
>> +			iounmap(pmc->regbase);
>> +	}
>> +
>> +	if (pmcdev->punit_ep)
>> +		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
>> +
>> +	return ret;
>>   }
>>   
>>   static const struct x86_cpu_id intel_pmc_core_ids[] = {
>> @@ -1734,7 +1750,8 @@ static int pmc_core_probe(struct platform_device *pdev)
>>   		ret = generic_core_init(pmcdev, pmc_dev_info);
>>   
>>   	if (ret) {
>> -		pmc_core_clean_structure(pdev);
>> +		platform_set_drvdata(pdev, NULL);
>> +		mutex_destroy(&pmcdev->lock);
> Please change also the mutex init to use devm_mutex_init(), don't forget
> to include error handling for it as it devm_mutex_init() can fail.

Will change to devm_mutex_init() in next version.

Thanks!

Xi

>>   		return ret;
>>   	}
>>   
>>

