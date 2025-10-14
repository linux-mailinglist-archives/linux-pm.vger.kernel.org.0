Return-Path: <linux-pm+bounces-36065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A471BBD96C2
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 14:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3511C5016EF
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 12:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBC2313E0A;
	Tue, 14 Oct 2025 12:42:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC46313558
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445772; cv=none; b=TqJgKxIby2PXAYN8anVTzqkNHjNDJAz1FgAUiiIQcHWhiPPlM+msKCjKgs/4BXIXiVgzBTVOxmRboHUkipNRL8pczBK0Uzg6x82TKLCvVClr7llK1v8241SdQrXvN8ke4DqjgWtXpYxLSyWn1W69I7ff7KHGZ8NaCpMV0G5j0yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445772; c=relaxed/simple;
	bh=zOHCqVYL18zP1aPS2ATpbUad8F3D2AMdFerwh4rQ0Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsswxanNSa+M68yKVPdUbyl0IyBhfM3+aiS0bl6btozSt49vCDVuTizIqhF3UoTNVfqco+xm7V5AzEZ789DesMZd7s7tStVSOgr7uBU8Xa5a0SNlxagI4MZZoA1QjfebUEQxs2PogJC4PiYa0Qm7NTX6sQ7ZIMxVoKxd7gIRYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D23E106F;
	Tue, 14 Oct 2025 05:42:41 -0700 (PDT)
Received: from [10.57.5.128] (unknown [10.57.5.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E57E3F6A8;
	Tue, 14 Oct 2025 05:42:48 -0700 (PDT)
Message-ID: <af37f0e5-f67d-40ad-bad2-cb1bcb7b7b8b@arm.com>
Date: Tue, 14 Oct 2025 13:43:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: energy_model: Replace kfree() with em_table_free()
To: Christian Loehle <christian.loehle@arm.com>,
 Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, pavel@kernel.org
References: <20251013091621.1191919-1-kaushlendra.kumar@intel.com>
 <7ee28623-01aa-4615-8f88-aeead4d48747@arm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <7ee28623-01aa-4615-8f88-aeead4d48747@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/25 12:01, Christian Loehle wrote:
> On 10/13/25 10:16, Kaushlendra Kumar wrote:
>> Replace kfree() with em_table_free() for error path of em_create_pd()
>> to ensure proper cleanup of energy model tables. The em_table_free()
>> function provides the correct deallocation mechanism for energy model
>> table structures, ensuring consistent memory management throughout the
>> energy model subsystem.
>>
>> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
>> ---
>>   kernel/power/energy_model.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 5f17d2e8e954..e8ae1f518b8a 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -441,7 +441,7 @@ static int em_create_pd(struct device *dev, int nr_states,
>>   	return 0;
>>   
>>   free_pd_table:
>> -	kfree(em_table);
>> +	em_table_free(em_table);
>>   free_pd:
>>   	kfree(pd);
>>   	return -EINVAL;
> 
> I guess this could carry the fixes tag as well.

It was already discussed with NACK, which still holds.

https://lore.kernel.org/lkml/7778df43-5169-4d1c-9fe6-44bee39edfc1@arm.com/

