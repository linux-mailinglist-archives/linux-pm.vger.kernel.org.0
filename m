Return-Path: <linux-pm+bounces-20193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE7A08DAF
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 11:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3D918836C5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448012080CB;
	Fri, 10 Jan 2025 10:16:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CFA1C3C04;
	Fri, 10 Jan 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504219; cv=none; b=aBjP0aD38W4Orr1QU9Xfty3aEef6esWwEcnsbdiRu/sNVu6TBlsHknGCZcfUpqrHzU+ELzvWe8wcdrglQn/I8EIUykdEX4jBTTqATfdhnpZbaM2SX+3lL05w/+WJx3cvZJm5whoTdQJEP/kDkSu7saJsRVYUQP1F/REwfldpY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504219; c=relaxed/simple;
	bh=wfjuoK3H2wh3wA5p9SNSv6wi46YJVUcRyKLEDE9hqOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjmnSz4GoHRGFPp0IWLnVI5+c9fRCp8TBShyCIKRCblGimZw7RLwP+Mp2sV7kS2VgyPsO+DlG+S0sDsPcltVidYbYR0Ah5W5eOZHb4jybmUlHKp1B1QTfCJzCGMTqfi0RgFZcupVtr0VBq/KxwgRRwnKzdJYaOtCK5nfNaPP46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E62B13D5;
	Fri, 10 Jan 2025 02:17:24 -0800 (PST)
Received: from [10.34.125.29] (e126645.nice.arm.com [10.34.125.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 004DD3F673;
	Fri, 10 Jan 2025 02:16:52 -0800 (PST)
Message-ID: <365e18b5-e01b-4444-aa7a-b36779ce8932@arm.com>
Date: Fri, 10 Jan 2025 11:16:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] ACPI: CPPC: Add cppc_get_reg_val and
 cppc_set_reg_val function
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
 lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 ionela.voinescu@arm.com, jonathan.cameron@huawei.com,
 zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com,
 fanghao11@huawei.com
References: <20241216091603.1247644-1-zhenglifeng1@huawei.com>
 <20241216091603.1247644-2-zhenglifeng1@huawei.com>
 <8e9c1ede-3277-458b-bd44-ca0c7615a4ab@arm.com>
 <74be38cf-8e18-44fc-995c-a5b734d9df29@huawei.com>
 <a9574bab-3b85-4a33-b465-204687dabc98@arm.com>
 <49bd9db5-b05d-4bed-8f9d-10ec087323b5@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <49bd9db5-b05d-4bed-8f9d-10ec087323b5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Lifeng,

On 1/10/25 03:23, zhenglifeng (A) wrote:
> Hello Pierre,
> 
> On 2025/1/8 0:54, Pierre Gondois wrote:
>> Hello Lifeng,
>>
>> On 12/20/24 09:30, zhenglifeng (A) wrote:
>>> On 2024/12/17 21:48, Pierre Gondois wrote:
>>>> Hello Lifeng,
>>>>
>>>> On 12/16/24 10:16, Lifeng Zheng wrote:
>>>>> Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to read
>>>>> cppc registers, with four changes:
>>>>>
>>>>> 1. Change the error kind to "no such device" when pcc_ss_id < 0, which
>>>>> means that this cpu cannot get a valid pcc_ss_id.
>>>>>
>>>>> 2. Add a check to verify if the register is a cpc supported one before
>>>>> using it.
>>>>>
>>>>> 3. Extract the operations if register is in pcc out as
>>>>> cppc_get_reg_val_in_pcc().
>>>>>
>>>>> 4. Return the result of cpc_read() instead of 0.
>>>>>
>>>>> Add cppc_set_reg_val_in_pcc() and cppc_set_reg_val() as generic functions
>>>>> for setting cppc registers value. Unlike other set reg ABIs,
>>>>> cppc_set_reg_val() checks CPC_SUPPORTED right after getting the register,
>>>>> because the rest of the operations are meaningless if this register is not
>>>>> a cpc supported one.
>>>>>
>>>>> These functions can be used to reduce some existing code duplication.
>>>>>
>>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>>> ---
>>>>>     drivers/acpi/cppc_acpi.c | 111 +++++++++++++++++++++++++++++----------
>>>>>     1 file changed, 84 insertions(+), 27 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>> index c1f3568d0c50..bb5333a503a2 100644
>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>> @@ -1179,43 +1179,100 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>>>>         return ret_val;
>>>>>     }
>>>>>     -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>>>>> +static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
>>>>>     {
>>>>> -    struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>>>>> +    int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>>>> +    struct cppc_pcc_data *pcc_ss_data = NULL;
>>>>> +    int ret;
>>>>> +
>>>>> +    if (pcc_ss_id < 0) {
>>>>> +        pr_debug("Invalid pcc_ss_id\n");
>>>>> +        return -ENODEV;
>>>>> +    }
>>>>> +
>>>>> +    pcc_ss_data = pcc_data[pcc_ss_id];
>>>>> +
>>>>> +    down_write(&pcc_ss_data->pcc_lock);
>>>>> +
>>>>> +    if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
>>>>> +        ret = cpc_read(cpu, reg, val);
>>>>> +    else
>>>>> +        ret = -EIO;
>>>>> +
>>>>> +    up_write(&pcc_ss_data->pcc_lock);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
>>>>> +{
>>>>> +    struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>>>>         struct cpc_register_resource *reg;
>>>>>           if (!cpc_desc) {
>>>>> -        pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>>>>> +        pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>>>>>             return -ENODEV;
>>>>>         }
>>>>>           reg = &cpc_desc->cpc_regs[reg_idx];
>>>>>     -    if (CPC_IN_PCC(reg)) {
>>>>> -        int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>>>>> -        struct cppc_pcc_data *pcc_ss_data = NULL;
>>>>> -        int ret = 0;
>>>>> -
>>>>> -        if (pcc_ss_id < 0)
>>>>> -            return -EIO;
>>>>> +    if (!CPC_SUPPORTED(reg)) {
>>>>> +        pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
>>>>> +        return -EOPNOTSUPP;
>>>>> +    }
>>>>
>>>> I think this is only valid for optional fields. Meaning that:
>>>> - if the function is used one day for the mandatory 'Lowest Performance'
>>>> field, an integer value of 0 would be valid.
>>>> - if the function is used for a mandatory field containing a NULL Buffer,
>>>> it seems we would return -EFAULT currently, through cpc_read(). -EOPNOTSUPP
>>>> doesn't seem appropriate as the field would be mandatory.
>>>>
>>>> Maybe the function needs an additional 'bool optional' input parameter
>>>> to do these check conditionally.
>>>
>>> Indeed, I should have judged the type before doing this check. But adding a
>>> input parameter is not a really nice way to me. How about adding a bool
>>> list of length MAX_CPC_REG_ENT in cppc_acpi.h to indicate wheter it is
>>> optional?
>>
>> Actually all these functions:
>> - cppc_get_desired_perf
>> - cppc_get_highest_perf
>> - cppc_get_epp_perf
>> - cppc_set_epp
>> - cppc_get_auto_act_window
>> - cppc_set_auto_act_window
> 
> As you suggest in another patch, the logic should be placed in
> cppc_get_auto_act_window() and some other functions. I'm afraid these
> functions couldn't be implemented with the macros you suggest.

If you're referring to the [get|set]_auto_act_window() functions, I guess
it should be ok to have the getter/setter functions implemented as a macros,
and then have a wrapper to do the conversion of the value.

> 
>> - cppc_get_auto_sel
>> - cppc_get_nominal_perf
>>
>> and in general all the functions getting / setting one value at a time could
>> be implemented by macros similars to show_cppc_data(). From what I see the
>> input parameters required are:
>> - name of the field
>> - if the field is mandatory to have or not
> 
> If with this parameter, we should put all the cppc_get_reg_val() and
> cppc_set_reg_val() in the macro. This wouldn't look really nice. I
> prefer to use a macro to judge mandatory / optional. I'll show you in
> v4.
> 

If you prefer to have specific macro names to distinguish optional/mandatory
fields, it also seems a good solution.

>> - if the field is writeable
> 
> I think we can define a READ macro, a WRITE macro and a RW macro. For
> the registers which are not writeable, only use the READ macro to
> implement getting function.

Yes right, same comment as above.

> 
>> - if the field is implemented as an integer, register, or can be both
> 
> I don't think this parameter is necessary. The field type can be got
> from cpc_desc->cpc_regs[reg_idx].type.

Yes indeed.

> 
>>
>> This would avoid having numerous function definitions doing approximately the
>> same thing.
> 
> So from what I see the input parameters required are name of the field
> and reg_idx. Thanks for your advice!
> 

