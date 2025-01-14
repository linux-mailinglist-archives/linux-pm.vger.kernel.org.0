Return-Path: <linux-pm+bounces-20450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B388A11528
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 00:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B13163CC7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 23:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D52C224895;
	Tue, 14 Jan 2025 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PxmqBfkX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDC218ADB;
	Tue, 14 Jan 2025 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896438; cv=none; b=ARFQIbjObj+4Wiijfqo9nOf5ba1wnCpqY5pToav6cO8Q03L3/YNVa2CnHuId59GKfoEPXmC/ilpJ6lvp8dsd++3BtZOE2DrAW0h/S3V/fcj9Kf5j44KVfjXJtZIY/G7e8N/a7VFuEzhd9dKSUuix+cKDscQ8NDIQZcCFKbvrpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896438; c=relaxed/simple;
	bh=L5INBYz5mg+C1Dz31aWOVjryAr9j5rgCxuW3Laf0p0s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qAvIlJPAq1bNdj+ig6XX+p0HFUKJcPtsGcOoGPbN2jofJ7G108We26UjPpSTrVkp8mimufB97b0+zcJ6ayB5w7xZ5oqZ4EzCg+9h06LCLOzP6t2vi0gptK0JsY7oBFsNaLkachFO17WSQxk1bitvavslNm4e+tHOvORk0NcuyDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PxmqBfkX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736896437; x=1768432437;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=L5INBYz5mg+C1Dz31aWOVjryAr9j5rgCxuW3Laf0p0s=;
  b=PxmqBfkX0jtZjPhbWtIesQQRpitPzc0f/5p+Itb0FVL/Hlg4Q7AY4O8Z
   E0DgPtfKVrrfHNSU4Wvty7ZhUPOCfu/84d9slcdV0mATBuChxOt+AmtYa
   kxBfpDo4/PvAwSr3EUh1hqRJqdTbAw3EeMM6zansvXU8TyZzhHjB4+luU
   M0zQblQogHvaH3cNnbl/9XjFTUc3ocNIC+rxL3TQxjSDA6kEY9WhPYRc/
   ZT+3XorIpj8qMIteajlrVrWkLgeZtr7DOCDOyRbICFEtMMoHtVNdjGfHP
   xLA2UdM0en8mei+pIc6CBEWuu8dgVETdoN/5DUeSMQCjN1x3ikr9EB7fh
   Q==;
X-CSE-ConnectionGUID: AuXJhICOT5CAPze7BUDXyg==
X-CSE-MsgGUID: YT5qRM8KTZeOJRmRcJ4+HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36910164"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="36910164"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:13:46 -0800
X-CSE-ConnectionGUID: LcGAxyvXSzi5KQ7uEIJoLw==
X-CSE-MsgGUID: U3nS5pxPQ+SMYgXeE/jMNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105442514"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.165.3]) ([10.246.165.3])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:13:45 -0800
Message-ID: <7370c697-6c71-47ff-843c-e6c20cebbb5e@linux.intel.com>
Date: Tue, 14 Jan 2025 15:13:43 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] platform/x86/intel/pmc: Create architecture
 specific callback
From: Xi Pardee <xi.pardee@linux.intel.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com,
 david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
References: <20250110002612.244782-1-xi.pardee@linux.intel.com>
 <20250110002612.244782-5-xi.pardee@linux.intel.com>
 <63e0fb3a-e1ab-e756-fea7-1f317eaad009@linux.intel.com>
 <a6239ca1-8eae-48e3-ba49-0bab81438b68@linux.intel.com>
Content-Language: en-US
In-Reply-To: <a6239ca1-8eae-48e3-ba49-0bab81438b68@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the feedback. I will send out a new version on rc1 of 6.14 cycle.

Xi

On 1/14/2025 8:39 AM, Xi Pardee wrote:
>
> On 1/10/2025 3:50 AM, Ilpo Järvinen wrote:
>> On Thu, 9 Jan 2025, Xi Pardee wrote:
>>
>>> Add architecture specific callback field in pmc_dev_info structure.
>>> Architecture specific action could be handled in this callback instead
>>> of per architecture init functions. Convert Arrow Lake, Lunar Lake,
>>> Meteor Lake and Tiger Lake platforms to use this field.
>>>
>>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>>> ---
>>>   drivers/platform/x86/intel/pmc/arl.c  | 15 +++++++--------
>>>   drivers/platform/x86/intel/pmc/core.c |  3 +++
>>>   drivers/platform/x86/intel/pmc/core.h |  7 +++++++
>>>   drivers/platform/x86/intel/pmc/lnl.c  | 15 +++++++--------
>>>   drivers/platform/x86/intel/pmc/mtl.c  | 15 +++++++--------
>>>   drivers/platform/x86/intel/pmc/tgl.c  | 15 +++++----------
>>>   6 files changed, 36 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/intel/pmc/arl.c 
>>> b/drivers/platform/x86/intel/pmc/arl.c
>>> index dedf752237ca0..9ff90d32a635f 100644
>>> --- a/drivers/platform/x86/intel/pmc/arl.c
>>> +++ b/drivers/platform/x86/intel/pmc/arl.c
>>> @@ -698,16 +698,15 @@ static struct pmc_dev_info arl_pmc_dev = {
>>>       .map = &arl_socs_reg_map,
>>>       .suspend = cnl_suspend,
>>>       .resume = arl_resume,
>>> +    .arch_specific = arl_specific_init,
>>>   };
>>>   -int arl_core_init(struct pmc_dev *pmcdev)
>>> +void arl_specific_init(struct pmc_dev *pmcdev)
>>>   {
>>> -    int ret;
>>> -
>>> -    ret = generic_core_init(pmcdev, &arl_pmc_dev);
>>> -    if (ret)
>>> -        return ret;
>>> -
>>>       arl_d3_fixup();
>>> -    return 0;
>>> +}
>> As I tried to explain already earlier I think the older form is better
>> here because it would allow arch specific things in any order:
>>
>> void xx_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>> {
>>     int ret;
>>
>>     xx_pre_fixup();
>>
>>     ret = generic_core_init(pmcdev, pmc_dev_info);
>>     if (ret)
>>         return ret;
>>
>>     xx_post_fixup();
>>
>>     return 0;
>> }
>>
>> If you make it a callback, you have pick either pre or post but 
>> cannot do
>> both with a single callback. My suggestion would also allow replacing
>> generic_core_init() completely if needed in future.
>>
>> Note how I pass the info parameter above to xx_init() so it can call 
>> into
>> generic_core_init(). In the core, you'd do this to pick which init
>> function to use:
>>
>>     if (pmc_dev_info->init)
>>         ret = pmc_dev_info->init(pmcdev, pmc_dev_info);
>>     else
>>         ret = generic_core_init(pmcdev, pmc_dev_info);
>
>
> Thanks for the feedback. I will change back to init function per 
> architect in next version.
>
> Xi
>
>

