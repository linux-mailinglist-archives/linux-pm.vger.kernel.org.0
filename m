Return-Path: <linux-pm+bounces-13916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979F5972648
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 02:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521B528553E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 00:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B1C47F5D;
	Tue, 10 Sep 2024 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQtQm5PM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713A45013;
	Tue, 10 Sep 2024 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928990; cv=none; b=R00gKFmnJ0tafdmS7Ik3KuHTda3zIeVHWySCTJL7jovODN9dY9r8ZCpnAZdW2NKNVprSeUao2t/iRs+casVzEvuEcoKMA4vUxLbXDtGqWW9syAqaZGi3zOOtdaiCBaT6arOo2cqyf4tuoPRACuZwSLb06liCl2D6f+VDMW33Ziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928990; c=relaxed/simple;
	bh=47e87rjjwrv3Klk0s/ZjV4Ua4MteTFTnXkPzD8ijqos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvXeGRXtQDjeGnYid2H2bNSF8PDcxpz9vOun+qReYbCCDxJkaH9IhZxN1QS2kFZhEwtsqFI/lezJiqxmuvlfR9DzdoD0pjIdI6RGpu0R2Wqg1nWX9dNBNE6aZV+2h+YqgiOB0cczmwt3fdFjlt7x+6pVpbv8Xu5Pc1Mdw+WAPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQtQm5PM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725928989; x=1757464989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=47e87rjjwrv3Klk0s/ZjV4Ua4MteTFTnXkPzD8ijqos=;
  b=WQtQm5PMnTMM7OeRUEy6MK9B3xLVctwsHfvNKtw9yNSx0va1+jkMYLU0
   f1Hf/f0LSTYu0DWQ9sNsXj19iF49NqWsjmLLFGITYPwUwIK/CcaEq5Inp
   1vTywusjJgHCsYVrJKOElPLJWPQkM6DpdsUMHcnm51eSzkBPeYSqF9KqI
   pVQ9RjLlglElHLfrwjMqFYLGMLDWxPvuncyUAZvfSg8m3KIOwOwn1JK/C
   rSJEsomxyRHCyHV2Uui30694Lhwf/fwDxEAIcsPojC3f8ouZ/5cGz40Ho
   ZnZSj9+v59lyxy6vFU7Yv0Mo6Z4+hQWrFcnT4Nme5DDk2eCHCj8bRPJXE
   g==;
X-CSE-ConnectionGUID: 9BciBPeIQQid2W8/UUGeGA==
X-CSE-MsgGUID: bT9TjOzEQ0G1+jsuIBDVvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28542210"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="28542210"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 17:43:06 -0700
X-CSE-ConnectionGUID: CsHaniE4RjaD+aVroL7SXA==
X-CSE-MsgGUID: RzdD9defTNmjbp2pidQpFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="66796157"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.125.67.115]) ([10.125.67.115])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 17:43:05 -0700
Message-ID: <2d8249a2-22a0-4785-9eea-a2d59c1d9b1a@linux.intel.com>
Date: Mon, 9 Sep 2024 17:43:04 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86:intel/pmc: Ignore all LTRs during suspend
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20240906184016.268153-1-xi.pardee@linux.intel.com>
 <15d08ff3-6787-7042-8afc-3a64f1ebc756@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <15d08ff3-6787-7042-8afc-3a64f1ebc756@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 9/9/2024 1:07 AM, Ilpo Järvinen wrote:
> On Fri, 6 Sep 2024, Xi Pardee wrote:
>
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
>>
>> v2:
>> - Add more details to commit message
>> - Fix format: ltr->LTR, S0IX->S0ix, space between name and email
>>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 53 +++++++++++++++++++++++++++
>>   drivers/platform/x86/intel/pmc/core.h |  2 +
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 01ae71c6df59..0ec703af16a4 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -714,6 +714,49 @@ static int pmc_core_s0ix_blocker_show(struct seq_file *s, void *unused)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(pmc_core_s0ix_blocker);
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
>>   static inline u64 adjust_lpm_residency(struct pmc *pmc, u32 offset,
>>   				       const int lpm_adj_x2)
>>   {
>> @@ -1479,6 +1522,10 @@ static bool warn_on_s0ix_failures;
>>   module_param(warn_on_s0ix_failures, bool, 0644);
>>   MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
>>   
>> +static bool ltr_ignore_all_suspend = true;
>> +module_param(ltr_ignore_all_suspend, bool, 0644);
>> +MODULE_PARM_DESC(ltr_ignore_all_suspend, "Ignore all LTRs during suspend");
>> +
>>   static __maybe_unused int pmc_core_suspend(struct device *dev)
>>   {
>>   	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>> @@ -1488,6 +1535,9 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
>>   	if (pmcdev->suspend)
>>   		pmcdev->suspend(pmcdev);
>>   
>> +	if (ltr_ignore_all_suspend)
>> +		pmc_core_ltr_ignore_all(pmcdev);
>> +
>>   	/* Check if the syspend will actually use S0ix */
>>   	if (pm_suspend_via_firmware())
>>   		return 0;
>> @@ -1594,6 +1644,9 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
>>   {
>>   	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>>   
>> +	if (ltr_ignore_all_suspend)
>> +		pmc_core_ltr_restore_all(pmcdev);
>> +
>>   	if (pmcdev->resume)
>>   		return pmcdev->resume(pmcdev);
>>   
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index ea04de7eb9e8..e862ea88b816 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -372,6 +372,7 @@ struct pmc_info {
>>    * @map:		pointer to pmc_reg_map struct that contains platform
>>    *			specific attributes
>>    * @lpm_req_regs:	List of substate requirements
>> + * @ltr_ign:		Holds LTR ignore data while suspended
>>    *
>>    * pmc contains info about one power management controller device.
>>    */
>> @@ -380,6 +381,7 @@ struct pmc {
>>   	void __iomem *regbase;
>>   	const struct pmc_reg_map *map;
>>   	u32 *lpm_req_regs;
>> +	u32 ltr_ign;
>>   };
>>   
>>   /**
>>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks for the Reviewed-by tag! I wonder if I need to send another 
version with the Reviewed-by tag for this patch to be accepted.

Thanks!

Xi


