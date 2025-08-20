Return-Path: <linux-pm+bounces-32678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B08B2D3FE
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB5D5871A6
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 06:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43866223311;
	Wed, 20 Aug 2025 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqkDwG4n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0418A93F;
	Wed, 20 Aug 2025 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755670913; cv=none; b=Fh7VpyTw6wCLHd1CZpNaC8zTNtYBuYKG5jV0nW77RI0pqsUuQJVBbd/3KMKr/zCntH7Ul6CLjYeZlx8Fu2VX2SEAa9x7LmcvnYh0tPwdsMGkxRoDdGB774LkIr3Wfz++tTfQn6zHTehBzcCFl/oU3K6IcMBypT6V1wSdE6vPNHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755670913; c=relaxed/simple;
	bh=GNESSZq2Jj5DEmteshZcQo8HkYhjwdDCP0dpRZeBTxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaei+dBEIBTre27866uaryouWf2Cb+7x6XG6ZHHovs/NAvAPVxFi1mwy+bsU0VrZth39zFbD1TrDUYKhy8DJRfvx2nuDf1adnoX/QCCTxlcoOuUQ+lMPaH5HwgZvAjVAFEcC7NkdeqeaZq5Wr5A+DDU8/00jBXK7GH0EKg9UQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqkDwG4n; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755670911; x=1787206911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GNESSZq2Jj5DEmteshZcQo8HkYhjwdDCP0dpRZeBTxo=;
  b=QqkDwG4nqcV1GQuXIyFcXc+ef2AwdfLOeOUORr094qi8TiRTMl9iFJL5
   N/qpump63Z9t9Cx1reSajrRcvRH2Ti4Zvwp7PfCQCcopC9M0Hn9rG7GVz
   Di/ArhlONCYnuboiMUk4zofNIwfPoaKwt3BUmOJUscd1kqP4XoQgqZjhF
   6vXPJnPGbbJpTMYXFOp12LUe3k4U24CDZPZxHM4lPOiUrUk9VUkFF33Zd
   Rk3PXePTN81itHtFQ6VU84g0rxWPmOauey0U/jTfdSBI6D2EEhcsnmb2b
   96OS3fdLKZVVbXom8DAsEPBkcUT1A7EYNALliAJOmwNiFggIpZoKmfjeo
   Q==;
X-CSE-ConnectionGUID: 7fH7w/qqQ1aR3pjvttl7Jg==
X-CSE-MsgGUID: wgyLMmJERpy5EByB6aqbtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57840849"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57840849"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 23:21:50 -0700
X-CSE-ConnectionGUID: eEt6VkODQDyeFCUQUVyyMA==
X-CSE-MsgGUID: 7OxUyJ1/RjG7zMDbSeoP8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172464537"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.165.248]) ([10.246.165.248])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 23:21:49 -0700
Message-ID: <a51dd4b5-d853-4db3-bfef-74ce34b7bca6@linux.intel.com>
Date: Tue, 19 Aug 2025 23:21:48 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86:intel/pmc: Update Arrow Lake telemetry GUID
To: David Box <david.e.box@linux.intel.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: irenic.rajneesh@gmail.com, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250814195156.628714-1-xi.pardee@linux.intel.com>
 <88da5769-1eae-4520-99b0-78a59bdbd867@app.fastmail.com>
 <mxzvvne6qycybtc25vj3mdoait5zz355kza7jcg5wcxz2ciji3@yn7k3jib72x7>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <mxzvvne6qycybtc25vj3mdoait5zz355kza7jcg5wcxz2ciji3@yn7k3jib72x7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 8/19/2025 12:41 PM, David Box wrote:
> Hi Xi,
>
> On Mon, Aug 18, 2025 at 11:40:47AM -0400, Mark Pearson wrote:
>> Thanks Xi
>>
>> On Thu, Aug 14, 2025, at 3:51 PM, Xi Pardee wrote:
>>> Updated ARL_PMT_DMU_GUID value. Arrow Lake PMT DMU GUID has
>>> been updated after it was released. This updates ensures that
>>> the die c6 value is available in the debug filesystem.
>>>
>>> Fixes: 83f168a1a437 ("platform/x86/intel/pmc: Add Arrow Lake S support
>>> to intel_pmc_core driver")
>>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>>> ---
>>>   drivers/platform/x86/intel/pmc/core.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/intel/pmc/core.h
>>> b/drivers/platform/x86/intel/pmc/core.h
>>> index 4a94a4ee031e6..24139617eef61 100644
>>> --- a/drivers/platform/x86/intel/pmc/core.h
>>> +++ b/drivers/platform/x86/intel/pmc/core.h
>>> @@ -282,7 +282,7 @@ enum ppfear_regs {
>>>   /* Die C6 from PUNIT telemetry */
>>>   #define MTL_PMT_DMU_DIE_C6_OFFSET		15
>>>   #define MTL_PMT_DMU_GUID			0x1A067102
>>> -#define ARL_PMT_DMU_GUID			0x1A06A000
>>> +#define ARL_PMT_DMU_GUID			0x1A06A102
>>>
>>>   #define LNL_PMC_MMIO_REG_LEN			0x2708
>>>   #define LNL_PMC_LTR_OSSE			0x1B88
>>> -- 
>>> 2.43.0
>> Tested this on my Lenovo P1 G8 and confirmed that it fixed the error message that was seen previously.
>>
>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> If you send another version, please tag with a link to the bugzilla,
> https://bugzilla.kernel.org/show_bug.cgi?id=220421
>
> Thanks
>
> David

Will add the bugzilla link in next version.

Thanks!

Xi


