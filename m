Return-Path: <linux-pm+bounces-14021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3679751C1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF7A2825A2
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 12:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E17189BA4;
	Wed, 11 Sep 2024 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaLiCOHn"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005391885B8
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057043; cv=none; b=QlTr1ZMtYvkDJx810OyB2X4yhlp3dUDSPDAXzN2I7i/d1F9DNKC4BIad3t3zph5vLXdmQhaEB48B681fGqh7DJNUeQ5D1Y2wt/OvBjdzSbf5Aeb06ScluxdmnL8QlmGwQ3K0Y//Sa0lxidz7QR7dvKolXgRqRqYntdlyTPPdnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057043; c=relaxed/simple;
	bh=wjU+rmKp2M1N1NC7Id4TIxq89xBQ0uuoCqQg/ZHvbXA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=FIG/93tA4KZIxd07SqxZDxVbXofGeoqqp4ocWV6QTWIFICUT/dOjtJ/4uTY/KxNHXj41nEb6Qk39VcXy+kNzOusfsArIGkL254zQw4usQX+qKzA07iKCIBydIwcgJenG9X/jzX/1zkAA5SOUysEPM2VwJHH7ntnfcBIowtmxwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaLiCOHn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726057041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDo1uue8JPrsEbo8PbiUqkTFduxdYVvuW9Rjo0hNMws=;
	b=WaLiCOHnfmLV6jC5/YOeslV9DL0N4YWq13kAzm5sV/hL7MuDY3GdoWR8J7PtNcYCuW7VPb
	EAS+vqxrDl+F+aCn/HpgOhA6wDP8yx9lYM5bBk1A/hyDqfjKVcj4CsKZmgYfqoEN12FAhN
	y8K9z3IAtSXOq+Ge9W/i+LycSBHsgas=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-rtAHfC6KP8a3j7qei8vB6g-1; Wed, 11 Sep 2024 08:17:19 -0400
X-MC-Unique: rtAHfC6KP8a3j7qei8vB6g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a92ab4dd0so101762366b.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 05:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726057037; x=1726661837;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDo1uue8JPrsEbo8PbiUqkTFduxdYVvuW9Rjo0hNMws=;
        b=Qp31KfPA9yHzg+hogySjpRIkWJP5Xi9YYTxvna5csxaKceCPvaEzdKLgxODFiKQcMS
         bszu8R8W/lwXmmJst39kDfpkOZljdXfWlkvy9bg7kvLM4HUujODiCzzD5H4luE9hXms0
         16fKw2iRHj8XjDr9Pn7hNTFMS88gmuMtLadfP1bIpIBjDXXfs7X1ve+KK4xkMM7VHv3/
         d9Hoxh22FhKGni6iJEDOBtfgnbklcfU1qeDxno471+jyQB7T7uezj97YzlnweE1kz53E
         +LgdTwIPJw2NR6pBrtAIDwIfvisch96YMyLWEfdS+Nqi+5dNDyPElhUcISoryCsVVnce
         GYEg==
X-Forwarded-Encrypted: i=1; AJvYcCVXX8VEDIJENg5A0fVKKxaqNkQ4SHfa01ECGGzC4qHWfYJvoSLs+8HZOlbd2xy4Bz3Am5pGQ3HTiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbRlFuU0kP1fDsYoy1arI0VPTSXll5tMxZpFQex+Slr1/UwHHW
	Gm1iHnLHRvqps4G0rPX6sOodslQF0J99/mJDTxUB6FeJ+mrONxs2XSAauoET4UUSkk5+X1ANkjG
	YSL1gO0Ba0ckpTPPNUZ8S7neToIysavLCQqDfF3bx3Sfmco/hONoWwbhY
X-Received: by 2002:a17:907:94c5:b0:a8a:1ffe:70f1 with SMTP id a640c23a62f3a-a9004a46f0amr252139866b.50.1726057037382;
        Wed, 11 Sep 2024 05:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsUtVDdbe/XHayfY1Ke7fJLV102Ni/6+J/8LqNVZdNS0CkfryWrUaemleAXVb7gGOHyJIslw==
X-Received: by 2002:a17:907:94c5:b0:a8a:1ffe:70f1 with SMTP id a640c23a62f3a-a9004a46f0amr252136366b.50.1726057036795;
        Wed, 11 Sep 2024 05:17:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72e49sm607020366b.127.2024.09.11.05.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 05:17:16 -0700 (PDT)
Message-ID: <dcdce7f3-dc51-445f-855c-6b46110d1c2b@redhat.com>
Date: Wed, 11 Sep 2024 14:17:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86:intel/pmc: Ignore all LTRs during suspend
From: Hans de Goede <hdegoede@redhat.com>
To: Xi Pardee <xi.pardee@linux.intel.com>, irenic.rajneesh@gmail.com,
 david.e.box@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240906184016.268153-1-xi.pardee@linux.intel.com>
 <edaa23e8-4b15-479c-a4bb-0f8276c8b862@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <edaa23e8-4b15-479c-a4bb-0f8276c8b862@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/11/24 2:16 PM, Hans de Goede wrote:
> Hi,
> 
> On 9/6/24 8:40 PM, Xi Pardee wrote:
>> From: Xi Pardee <xi.pardee@intel.com>
>>
>> Add support to ignore all LTRs before suspend and restore the previous
>> LTR values after suspend. This feature could be turned off with module
>> parameter ltr_ignore_all_suspend.
>>
>> LTR value is a mechanism for a device to indicate tolerance to access
>> the corresponding resource. When system suspends, the resource is not
>> available and therefore the LTR value could be ignored. Ignoring all
>> LTR values prevents problematic device from blocking the system to get
>> to the deepest package state during suspend.
>>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Xi Pardee <xi.pardee@intel.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Oops, wrong auto-reply, what I meant is:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




>> v2:
>> - Add more details to commit message
>> - Fix format: ltr->LTR, S0IX->S0ix, space between name and email
>>
>> ---
>>  drivers/platform/x86/intel/pmc/core.c | 53 +++++++++++++++++++++++++++
>>  drivers/platform/x86/intel/pmc/core.h |  2 +
>>  2 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 01ae71c6df59..0ec703af16a4 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -714,6 +714,49 @@ static int pmc_core_s0ix_blocker_show(struct seq_file *s, void *unused)
>>  }
>>  DEFINE_SHOW_ATTRIBUTE(pmc_core_s0ix_blocker);
>>  
>> +static void pmc_core_ltr_ignore_all(struct pmc_dev *pmcdev)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
>> +		struct pmc *pmc;
>> +		u32 ltr_ign;
>> +
>> +		pmc = pmcdev->pmcs[i];
>> +		if (!pmc)
>> +			continue;
>> +
>> +		guard(mutex)(&pmcdev->lock);
>> +		pmc->ltr_ign = pmc_core_reg_read(pmc, pmc->map->ltr_ignore_offset);
>> +
>> +		/* ltr_ignore_max is the max index value for LTR ignore register */
>> +		ltr_ign = pmc->ltr_ign | GENMASK(pmc->map->ltr_ignore_max, 0);
>> +		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, ltr_ign);
>> +	}
>> +
>> +	/*
>> +	 * Ignoring ME during suspend is blocking platforms with ADL PCH to get to
>> +	 * deeper S0ix substate.
>> +	 */
>> +	pmc_core_send_ltr_ignore(pmcdev, 6, 0);
>> +}
>> +
>> +static void pmc_core_ltr_restore_all(struct pmc_dev *pmcdev)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
>> +		struct pmc *pmc;
>> +
>> +		pmc = pmcdev->pmcs[i];
>> +		if (!pmc)
>> +			continue;
>> +
>> +		guard(mutex)(&pmcdev->lock);
>> +		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, pmc->ltr_ign);
>> +	}
>> +}
>> +
>>  static inline u64 adjust_lpm_residency(struct pmc *pmc, u32 offset,
>>  				       const int lpm_adj_x2)
>>  {
>> @@ -1479,6 +1522,10 @@ static bool warn_on_s0ix_failures;
>>  module_param(warn_on_s0ix_failures, bool, 0644);
>>  MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
>>  
>> +static bool ltr_ignore_all_suspend = true;
>> +module_param(ltr_ignore_all_suspend, bool, 0644);
>> +MODULE_PARM_DESC(ltr_ignore_all_suspend, "Ignore all LTRs during suspend");
>> +
>>  static __maybe_unused int pmc_core_suspend(struct device *dev)
>>  {
>>  	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>> @@ -1488,6 +1535,9 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
>>  	if (pmcdev->suspend)
>>  		pmcdev->suspend(pmcdev);
>>  
>> +	if (ltr_ignore_all_suspend)
>> +		pmc_core_ltr_ignore_all(pmcdev);
>> +
>>  	/* Check if the syspend will actually use S0ix */
>>  	if (pm_suspend_via_firmware())
>>  		return 0;
>> @@ -1594,6 +1644,9 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
>>  {
>>  	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>>  
>> +	if (ltr_ignore_all_suspend)
>> +		pmc_core_ltr_restore_all(pmcdev);
>> +
>>  	if (pmcdev->resume)
>>  		return pmcdev->resume(pmcdev);
>>  
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index ea04de7eb9e8..e862ea88b816 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -372,6 +372,7 @@ struct pmc_info {
>>   * @map:		pointer to pmc_reg_map struct that contains platform
>>   *			specific attributes
>>   * @lpm_req_regs:	List of substate requirements
>> + * @ltr_ign:		Holds LTR ignore data while suspended
>>   *
>>   * pmc contains info about one power management controller device.
>>   */
>> @@ -380,6 +381,7 @@ struct pmc {
>>  	void __iomem *regbase;
>>  	const struct pmc_reg_map *map;
>>  	u32 *lpm_req_regs;
>> +	u32 ltr_ign;
>>  };
>>  
>>  /**
> 


