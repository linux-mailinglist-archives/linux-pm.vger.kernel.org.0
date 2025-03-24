Return-Path: <linux-pm+bounces-24482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3AEA6E4BF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 21:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AF5188D4AE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 20:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A691DE3D9;
	Mon, 24 Mar 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAEuEXtJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAC1C8613;
	Mon, 24 Mar 2025 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849696; cv=none; b=Ho7vVGCr/dxIdGMHgUFZZwxE/69by0iOZLL8jXl6ipY7bRWtMdQEzU8AsXFPvNZhbGzy7ycxdHIUU7DB1mqN9AQzV6ocLsc345mTYsV2OafrSu7odIFk21RR01ac8QVX0mZaN+gcV3ef2bvNn/fG8V6MbxoJGa6ydOVWDq3Az8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849696; c=relaxed/simple;
	bh=Ih3dm7Ri0bjLLtlXwUEcgqHbaGBSlGEP0HDK6EZifIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fymaCqjZm5sZHeuXZHr/gNq11phCZs35JfciXU2D4vQW7pF5H/oCb7GRnYdG6wonxO1R+IzWZ8Xu9YGAdtefxqsbUWsiyFv9gGU7BjS9fbVdqwN4ZGy65SKrh/LTMOJgklIlsrDnIlGhMHG4nUGrTCYIjBEeK4Xpp7hafLdWyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAEuEXtJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742849694; x=1774385694;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ih3dm7Ri0bjLLtlXwUEcgqHbaGBSlGEP0HDK6EZifIc=;
  b=SAEuEXtJ+PP4rnaToDDQ5xCzUyy7sK4I1atJCPkxzU4eeYIM75kZD+I5
   Q3pbW79lWQMFtTuIyzRzb7NxflmLKtNve3rH7fOYzcghdrKSQtIr6MM34
   gu5zKo74+dmQCJeHo12pluf30PLTGzLDHBGPdDgeK02/joVbQlLy7ag/u
   PKzQVp6H3tOwS0HMLD/3ZoZZZRrS1iUcA9lEjFxocWM+u0Kp3/Tw69Wbm
   0reOHhHLzARpu+jySUH90lVH3PIVecFsgn77ljfmZS9Xc/XICD+Qx/5Jc
   OgMEhd9DShPu1hvh2CCITiXTZTcFJOBV/QgpZfeXaBeFCtdFhmpIyv2SE
   w==;
X-CSE-ConnectionGUID: yS8gWklDQgWgKzlxZUFOAw==
X-CSE-MsgGUID: JY/TDvcXR2yKYBVEyLLRCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43234423"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="43234423"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 13:54:52 -0700
X-CSE-ConnectionGUID: Zmeu89P2QuSLb8C/HFnKng==
X-CSE-MsgGUID: UofD0F5QTGu80NmV8o/snw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124186393"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.124.17.122]) ([10.124.17.122])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 13:54:52 -0700
Message-ID: <1405ee5c-de05-4f67-a747-98412e4b0017@linux.intel.com>
Date: Mon, 24 Mar 2025 13:54:38 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: intel/pmc: Fix iounmap call for valid
 addresses
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20250319224410.788273-1-xi.pardee@linux.intel.com>
 <66c1a0f1-7d7a-da07-e80f-027964c503b8@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <66c1a0f1-7d7a-da07-e80f-027964c503b8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/21/2025 7:49 AM, Ilpo Järvinen wrote:
> On Wed, 19 Mar 2025, Xi Pardee wrote:
>
>> pmc_core_clean_structure() is called when generic_core_init() fails.
>> generic_core_init() could fail before ioremap() is called to get
>> a valid regbase for pmc structure. The current code does not check
>> regbase before calling iounmap(). Add a check to fix it.
> Hi,
>
> The approach that calls the same "full cleanup" function as deinit uses
> when init function fails midway is very error prone as once again is
> demonstrated. Is this the only error handling problem? Are you 100% sure?
>
> Think about it, init is x% (<100%) done when it fails, then it calls a
> function that tries to undo 100%. One needs to add lots of special logic
> to handle 0-100% rollback into that cleanup function. The init function,
> on the other hand, knows exactly where it was so it can rollback just what
> is needed and not even try to rollback for more.
>
> It's also very inconsistent to rollback ssram_pcidev in this file as ssram
> code was moved into core_ssram so I think the ssram deinit should be moved
> there too.
>
> I think these init functions should be converted to do proper rollback
> within the init function(s) to avoid very hard to track error handling.
> I tried to check the error handling now in the pmc driver and after I
> would have needed to jump between the files, I gave up.

Hi,

Thanks for the comments! Will move the error handing code for init 
function to init function in next cycle.

I will send out a new version to separate SSRAM device handling code to 
a new PCI driver and remove ssram_pcidev field from pmcdev in next cycle.


Thanks!

Xi

>> Fixes: 1b8c7b843c00 ("platform/x86:intel/pmc: Discover PMC devices")
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 7a1d11f2914f..de5fc06232e5 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1471,7 +1471,7 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
>>   	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
>>   		struct pmc *pmc = pmcdev->pmcs[i];
>>   
>> -		if (pmc)
>> +		if (pmc && pmc->regbase)
>>   			iounmap(pmc->regbase);

