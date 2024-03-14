Return-Path: <linux-pm+bounces-4931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600D987BC65
	for <lists+linux-pm@lfdr.de>; Thu, 14 Mar 2024 12:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146201F21F6B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Mar 2024 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE5F6F06C;
	Thu, 14 Mar 2024 11:57:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812F6CDB5;
	Thu, 14 Mar 2024 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417474; cv=none; b=isL4bTB5893L6FFQKca5c+4LlPTSZMkvJDTwspwG4mNnGHZBj9xoQPM8Pd7+AMoeBnJHDuKrRswrBKFbE7CHlO+KE/iZrsQRXNsTsVFRu6hGFz9hGAOgPieinW051NfhSFcn7eV1J0biU89Jbm3HEkuIlW3k2vzTXRqgDejuU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417474; c=relaxed/simple;
	bh=uVbNBR9AVHWckYq4Saa5wfB0njDgPv2cq2V2E6uxF0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GybsoLuN0aYMCjV//dYdzezHoJy12xe52eTXzewsDL7A5imkNlWu1REHSck9v8enraqy9wsiVpA30dcPhyxAUa7Nub4EeogtTGQ/kcTOwU5tbTetknsNz636yZcj3/x+iUME5T71N59sxXu2V84XPIRIuwogdA8HiBruYbNKARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A23111007;
	Thu, 14 Mar 2024 04:58:27 -0700 (PDT)
Received: from [10.57.13.158] (unknown [10.57.13.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98D843F73F;
	Thu, 14 Mar 2024 04:57:50 -0700 (PDT)
Message-ID: <1135db48-6430-4a36-b75a-2f0ededd4612@arm.com>
Date: Thu, 14 Mar 2024 11:57:48 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: Force device drivers to provide power in uW
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 poshao.chen@mediatek.com
References: <20240308123203.196644-1-lukasz.luba@arm.com>
 <CAJZ5v0g_UcJzRy2-16kjOZpOyB=-FsdgH63LJBzmHRhsARYjVA@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g_UcJzRy2-16kjOZpOyB=-FsdgH63LJBzmHRhsARYjVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/13/24 19:49, Rafael J. Wysocki wrote:
> On Fri, Mar 8, 2024 at 1:31 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The EM only supports power in uW. Make sure that it is not possible to
>> register some downstream driver which doesn't provide power in uW.
>> The only exception is artificial EM, but that EM is ignored by the rest of
>> kernel frameworks (thermal, powercap, etc).
>>
>> Reported-by: PoShao Chen <poshao.chen@mediatek.com>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>
>> Hi all,
>>
>> The was an issue reported recently that the EM could be used with
>> not aligned drivers which provide milli-Watts. This patch prevents such
>> drivers to register EM (although there are no such in upstream).
>>
>> Regards,
>> Lukasz
>>
>>   kernel/power/energy_model.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index b686ac0345bd9..9e1c9aa399ea9 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -612,6 +612,17 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>>          else if (cb->get_cost)
>>                  flags |= EM_PERF_DOMAIN_ARTIFICIAL;
>>
>> +       /*
>> +        * EM only supports uW (exception is artificial EM).
>> +        * Therefore, check and force the drivers to provide
>> +        * power in uW.
>> +        */
>> +       if (!microwatts && !(flags & EM_PERF_DOMAIN_ARTIFICIAL)) {
>> +               dev_err(dev, "EM: only supports uW power values\n");
>> +               ret = -EINVAL;
>> +               goto unlock;
>> +       }
>> +
>>          ret = em_create_pd(dev, nr_states, cb, cpus, flags);
>>          if (ret)
>>                  goto unlock;
>> --
> 
> Applied as 6.9-rc material, thanks!

Thank you Rafael!

