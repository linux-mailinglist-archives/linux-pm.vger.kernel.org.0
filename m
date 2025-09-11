Return-Path: <linux-pm+bounces-34510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F7AB53B71
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 20:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF2E17FB37
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A234735A2AF;
	Thu, 11 Sep 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9ybLtRd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD5248891;
	Thu, 11 Sep 2025 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615588; cv=none; b=XconWTBflbn9S1ZIEd+FaH6Gz03JMEhiQIEQsLJE5qvu/+wU46m0Gi+NLwHnl+zSGE3vgOeMkSGj0WGFJLGjRNQWYuFagjI1um0DwGmqa/0e18hGdbBNM5R79PIICwqqeCLtjMz4UNcWnLfQgFZs1q44WLQ+nhdda58nkX1apE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615588; c=relaxed/simple;
	bh=0dEZRZcWJvIpfDc1GJ4yBAEBn08Nx7B8lnOW/NH+O0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hH5RuSnalCn22pPOlp56H3OIVkLg6X6dT13WaMNZ+Zng4KbdIkhvqWBV5hTIZlQ7YfFB2XfbZZpcTgs/Ucv0SBfIUz8lOhOc68t0C7TggrZHofNIaDshPmFFHBeKDiK+kFXOI3B0ElYLR2q+aKlRWjcDf8aNqjweV/YHfDBYaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9ybLtRd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757615586; x=1789151586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0dEZRZcWJvIpfDc1GJ4yBAEBn08Nx7B8lnOW/NH+O0w=;
  b=M9ybLtRdLi2AY18LrK3a3ghXeF48IHO/clUJh7K/Iz2ZA05oDem9P38R
   GH4Wf4Cbw4ySOM2SFk0ffpc6P8kBRepOhLOv+MiO3t+SsbrGdLuYR65+a
   RlVDsM4l9aAwVeqmUXU1/ftJrD2QzXYOYGMNUqnOfIIz3GFErcVh/qqwj
   c7Rrt2rFs6kixXi656JOztIBJs0Qks6+KVxVJkcCA8+qYgcOefklsmB4i
   IiSKiFC+/gWXRe+QRJ3wViXL3BK0xoZR1X0d3/XNZMOiviwA2vxbulT1q
   AyE9iK97JrtG28+pVueZGrrn5lRfDRTO9M3WzF2Qqh1gLcp1D13EPpZGc
   w==;
X-CSE-ConnectionGUID: o6c1F8clQAiAyF+dZuaeCg==
X-CSE-MsgGUID: YdL0ZuSCTwS+3fveXOef4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59190797"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="59190797"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 11:33:05 -0700
X-CSE-ConnectionGUID: 4ggz1poUQQGEewY8kMpBoA==
X-CSE-MsgGUID: mLcmMhLLQ8mlyT8lrwpYQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="204530602"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.154.149]) ([10.246.154.149])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 11:33:05 -0700
Message-ID: <dfa61f8c-c49b-4c29-9999-cdff97fbb43f@linux.intel.com>
Date: Thu, 11 Sep 2025 11:32:57 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] platform/x86:intel/pmc: Show device and function
 number
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
 <20250815224611.2460255-6-xi.pardee@linux.intel.com>
 <c9aa04ae-f942-cf73-d046-78d0f90f373d@linux.intel.com>
 <7fae6fc8-6df5-4d1f-90ec-b6bf159e62da@linux.intel.com>
 <ed041865-c5aa-1312-e401-8cf333ac0820@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <ed041865-c5aa-1312-e401-8cf333ac0820@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,

Thanks for the review. I will fix the patch based on your comments and 
send another version separately.

On 9/8/2025 4:03 AM, Ilpo Järvinen wrote:
> On Sun, 7 Sep 2025, Xi Pardee wrote:
>
>> Hi Ilpo,
>>
>> Thanks for the review.
>>
>> On 8/28/2025 6:56 AM, Ilpo Järvinen wrote:
>>> On Fri, 15 Aug 2025, Xi Pardee wrote:
>>>
>>>> Add support to show device and function number for S0ix blockers. This
>>>> feature depends on S0ix blocker substate requirement table and BDF
>>>> association table. This feature is available for platforms starting from
>>>> Pather Lake.
>>>>
>>>> Only a subset of S0ix blockers has device and function number associated
>>>> to it. Get the availability information from the substate requirement
>>>> table. Get the device and function number mapping information for each
>>>> S0ix blocker from the BDF association table.
>>>>
>>>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>>>> ---
>>>>    drivers/platform/x86/intel/pmc/core.c | 182 +++++++++++++++++++++++++-
>>>>    drivers/platform/x86/intel/pmc/core.h |  23 +++-
>>>>    2 files changed, 203 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/intel/pmc/core.c
>>>> b/drivers/platform/x86/intel/pmc/core.c
>>>> index a0b948a875a5a..69ee40cbb8b8a 100644
>>>> --- a/drivers/platform/x86/intel/pmc/core.c
>>>> +++ b/drivers/platform/x86/intel/pmc/core.c
>
>>>> +		const char *name = NULL;
>>>> +		struct list_head *cur;
>>>> +		struct bdf_entry *bdf;
>>>> +		struct pmc *pmc;
>>>> +
>>>> +		pmc = pmcdev->pmcs[pmcidx];
>>>> +		if (!pmc)
>>>> +			continue;
>>>> +
>>>> +		list_for_each(cur, pmc->bdf_list) {
>>>> +			bdf = list_entry(cur, struct bdf_entry, node);
>>>> +			if (bdf->name != name) {
>>>> +				seq_printf(s, "pmc%d: %30s | %15x | %15x |\n",
>>>> pmcidx,
>>> %u
>> Will change it in next version.
> I don't remember if I mentioned it earlier but if you're going to address
> the review comment fully. There's no need to "ack" them like this. I
> trust you make the changes you don't contest.
>
> By doing so, we can both save time by only focusing on the points which
> are contested or need further discussion. :-)
>
>
>>>> +	if (!maps[*r_idx][*i_idx].name)
>>>> +		(*r_idx)++;
>>>> +
>>>> +	// Iteration reaches the end of the maps
>>>> +	if (*r_idx >= arr_size)
>>>> +		return NULL;
>>>> +
>>>> +	for (; *r_idx < arr_size; (*r_idx)++) {
>>>> +		const char *ip_name;
>>> Can't you put this to the innermost block?
>> Will move it in next version.
>>>> +		if (reset)
>>> Why you need this?
>> The purpose of this function is to return the name of the NEXT s0ix blocker
>> with BDF information.
>>
>> r_idx and i_idx are used to keep track of the current position of the
>> iteration, therefore i_idx could not be reset to 0 at the first run of the
>> inner for loop. After the first run of inner for loop reset should be set to
>> true so in next run of the outer for loop i_idx could be reset to 0 (which
>> mean the iteration reaches the next s0ix blocker map).
> But why you cannot reset i_idx after the inner for () loop and drop
> this reset variable entirely?
Yes, I will do that in next version.
>
>>>> +			*i_idx = 0;
>>>> +
>>>> +		for (; maps[*r_idx][*i_idx].name; reset = TRUE, (*i_idx)++) {
>>> true
>>>
>>> This is hard enough to understand even without that "for (;". Would
>>> probably be better to use while () instead.
>> Will change to while loop in next version.
>>>> +			if (!maps[*r_idx][*i_idx].blk)
>>>> +				continue;
>>>> +
>>>> +			bool exist = **lpm_req_regs & BIT(BDF_EXIST_BIT);
>>>> +			(*lpm_req_regs)++;
>>>> +			if (exist) {
>>>> +				ip_name = maps[*r_idx][*i_idx].name;
>>>> +				(*i_idx)++;
>>>> +				return ip_name;
>>>> +			}
>>>> +		}
>>>> +	}
>>>> +	return NULL;
>>>> +}
>>> TBH, this entire function is horrible mess, two nested iterators as
>>> pointers, etc.
>>>
>>> I'm very far from following all what going on here.
>>>
>>> I suppose I've not seen this patch previously?
>> To achieve the NEXT name of the s0ix blocker with BDF information we need to
>> iterate through two (set of) maps in parallel. The s0ix_blocker_maps provide
>> names of all s0ix blockers and the lpm_req_regs map shows that which s0ix
>> blocker has associated BDF information.
>>
>> if maps[*r_idx][*i_idx].blk is set, that means it is a s0ix blocker. For each
>> s0ix blocker, if **lpm_req_regs & BIT(BDF_EXIST_BIT) is set, that means this
>> blocker has associated BDF information. Pointers are used to keep track of the
>> current position of the two (set of) maps so the function provides the NEXT
>> name of the s0ix blocker with associated BDF info.
>>
>> I will probably switch to use a temporary data structure, such as list, to
>> store all s0ix blockers with BDF info and then iterate through this list in
>> pmc_core_process_bdf() call instead. That will make the logic easier to follow
>> and maintain. I will also add more comments to next version of this patch.
> My out-of-band suggestion was to convert i_idx into a correctly typed
> pointer  as it's the last-level array, you only need to do two things for
> the pointer:
>
> - set it to start of the next array when r_idx increases.
> - increment the pointer with ++.
>>>> +static int pmc_core_process_bdf(struct pmc_dev *pmcdev,  struct pmc *pmc,
>>>> u32 data,
>>>> +				unsigned int *r_idx, unsigned int *i_idx, u32
>>>> **lpm_req_regs,
>>>> +				const char **name)
>>>> +{
>>>> +	unsigned int i;
>>>> +
>>>> +	if (!data)
>>>> +		return 0;
>>>> +
>>>> +	if (!*name)
>>>> +		return -EINVAL;
>>>> +
>>>> +	for (i = BDF_FUN_LOW_BIT; i <= BDF_FUN_HIGH_BIT; i++) {
>>> I think you can iterate 0 ... __fls(FIELD_MAX()).
>> Each 16 bit represents one device and the associated function numbers for one
>> s0ix blocker.
>>
>> Bit 4-0 indicates the device number.
>>
>> Bit 12-5 indicates function numbers.
>>
>> Bit 15 indicates if the next 16 bit is associated to the same s0ix blocker as
>> the current word.
>>
>> Between bit 12 and bit 5, each bit position represents one function number.
>> Bit 5 represents function 0 and bit 12 represents function 7. I will add more
>> comments in the next version.
>>
>> Will change to use __fls(FIELD_MAX()) in next version.
> Yes, these are fields which are to be defined with GENMASK()/BIT(). Then
> this code just has to figure out how to deal with that change and my
> suggestion was to use fls construct. If you find better approach, those
> can be used as well but my point is that this iteration should be sourced
> from the GENMASK_U16(12, 5).
>
>>>> +	name = pmc_core_get_next_bdf_ip_name(pmc, &r_idx, &i_idx,
>>>> &lpm_reg_regs);
>>>> +	if (!name)
>>>> +		return -EINVAL;
>>>> +
>>>> +	pmc->bdf_list = devm_kzalloc(&pmcdev->pdev->dev, sizeof(struct
>>>> list_head), GFP_KERNEL);
>>> Should use sizeof(*xx).
>>>
>>> But why you need to allocate the list head and not have it in place
>>> within the pmc's struct?
>> The memory for bdf_list is only allocated when the bdf information is
>> available to achieve.
>>
>> intel_pmc_core driver can check if the memory is allocated to decide whether
>> to create a file in debugfs for bdf in pmc_core_dbgfs_register().
> But can't you use empty list check for that?
I can use the empty list check in pmc_core_dbgfs_register() instead.
>
>>>> +	if (!pmc->bdf_list)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	INIT_LIST_HEAD(pmc->bdf_list);
>>>> +
>>>> +	for (; sample_id < max_sample_id; sample_id++) {
>>>> +		u32 data;
>>>> +
>>>> +		ret = pmt_telem_read32(ep, sample_id, &data, 1);
>>>> +		if (ret) {
>>>> +			dev_err(&pmcdev->pdev->dev,
>>>> +				"couldn't read bdf: %d\n", ret);
>>> One line.
>> Will change it in next version.
>>>> +			return ret;
>>>> +		}
>>>> +
>>>> +		if (sample_id == header_id) {
>>>> +			size = (data & GENMASK(BDF_SIZE_HIGH_BIT,
>>>> BDF_SIZE_LOW_BIT))
>>>> +			       >> BDF_SIZE_LOW_BIT;
>>> Define the field and use FIELD_GET().
>> Will change it in next version.
>>>> +			header_id += size + 1;
>>> No, I just cannot understand what's going on here, it's hopeless. Always
>>> when I think I've finally understood what its all about you throw a curve
>>> ball like this.
>> There is one header line (32 bit) between each type of s0ix blocker in the bdf
>> association table. The bit 23-26 in header line indicates the size of each
>> section of one specific type of s0ix blocker in this table.
>>
>> header_id is used  to keep track of the id of each header so we will process
>> the header line differently from the other lines.
>>
>> I will add more detailed comment in next version.
> I suspect naming the fields with defines and using FIELD_GET() will
> already get you far.
>
> Perhaps BDF_SIZE (=what remains when you take those custom coded bit field
> postfix out of the current naming) should be renamed into something like
> BDF_SECTION_SIZE for better clarity.

Will use FIELD_GET() to get the information in next version.

Thanks for reviewing the patch.

Xi

>

