Return-Path: <linux-pm+bounces-13922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A319729CE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 08:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552AB1C23BA1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 06:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF417ADE1;
	Tue, 10 Sep 2024 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Btrtg3mm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0B17A58F;
	Tue, 10 Sep 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951230; cv=none; b=lz2vJuEawWJjyoZw5F/625EkKuqkGLjzSeCRtNYFnDYehTm+zG5CmRZksatlScRHAqrgYaUrbElnmtLmI0BzfL/HthDszOONOGICnOxrfyd2hQwPTrLrx/T/LxSO3upuzQto1iHtK+2jtSKnRhZ6T23jwnPEzi/cujwsBo5SuZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951230; c=relaxed/simple;
	bh=otc5fqPB/UAeEH3Hfj+YM9UzXYTaLatHC+YoHBPD6sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q74k8lBsJVL4bAdIfkletkMeyRuxnW5CksLHhodFm/bdzDf1bcvh+9LekA0p2UZ/mjfZ/KmDrQaEmbiAnHD1K9fR8r1FAoDjxNhLqiZosLKpayAl/0ga4gkL/fTPULTZGzyPoemf+Pc9g9QCChKQ4DMBIB908zWsj6dqFfkyZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Btrtg3mm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725951228; x=1757487228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=otc5fqPB/UAeEH3Hfj+YM9UzXYTaLatHC+YoHBPD6sw=;
  b=Btrtg3mm7LM4CCt+eashnuzyZv/MlUCpX3HSWv4uc02AJmnGCICsY29f
   p0SNMwGtgf3FGYQpzUurjLus1kwQj1WE/B92VIUWrAzRpsjEzfJxBUKNv
   D+HrHmgVRjEVcWVoa8PNhyZ2qMxj/mTkFDjHuYCr1MiA/BaGcxsybHcDi
   NubB6OFDnk/vGtK4BJf1C/TWvcdbuhPYZxrD+FC2IAr0kpmV4vrDH1ggy
   cN/+He3qgkKDGPSA/Wq2d3o0Js0QLsTbih3xyHgtnb2W+ws4lOtpxwvUi
   RAtQUHOIC1wEj96fgR7AEwjT8JH7qFDiq2xtcrdvSdH89HBPgll4/gwm9
   Q==;
X-CSE-ConnectionGUID: GM4mtlaTTX6EnGnUgqzTlA==
X-CSE-MsgGUID: 5lQmyPZwQCK2zHsBhpjNcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="42198299"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="42198299"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:53:48 -0700
X-CSE-ConnectionGUID: YMo1aoNBTWGuJmWShHVdRg==
X-CSE-MsgGUID: VduagctwTleImWtZS0Ccsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="97742795"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.125.67.115]) ([10.125.67.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:53:48 -0700
Message-ID: <21b8777a-827b-4729-a8d3-36024983dc2c@linux.intel.com>
Date: Mon, 9 Sep 2024 23:53:47 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] platform/x86:intel/pmc: Check return value of
 ioremap
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
 <20240828222932.1279508-8-xi.pardee@linux.intel.com>
 <b3665329-dbe9-d78d-a988-b7c346b069de@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <b3665329-dbe9-d78d-a988-b7c346b069de@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/29/2024 4:06 AM, Ilpo Järvinen wrote:
> On Wed, 28 Aug 2024, Xi Pardee wrote:
>
>> Check the return value of ioremap operation and return ENOMEM when
>> the operation fails for better error handling.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/ssram_telemetry.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
>> index 73c727042ca6..f625d39d1aa3 100644
>> --- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
>> +++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
>> @@ -84,6 +84,9 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, unsigned int pmc_idx, u32 offset)
>>   	ssram_base = ssram_pcidev->resource[0].start;
>>   	tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
>>   
>> +	if (!tmp_ssram)
>> +		return -ENOMEM;
>> +
>>   	if (pmc_idx != PMC_IDX_MAIN) {
>>   		/*
>>   		 * The secondary PMC BARS (which are behind hidden PCI devices)
> Is this a fix to the current code? And should have Fixes tag and go
> first because of that?
This is an improvement of the current code. We should check the value of 
ioremap before using it to avoid
failure in the later process. I can add a fixes tag to it. Should this 
patch be its own patch series and not
include in this one? Or should it be moved to be the first patch of this 
series?

Thanks!
Xi
>

