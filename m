Return-Path: <linux-pm+bounces-23308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C35AA4C243
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 14:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737A5170F9B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E64212B07;
	Mon,  3 Mar 2025 13:43:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CAF8634C;
	Mon,  3 Mar 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009420; cv=none; b=IvLMYGxo4k6255crXmoa595c9tN1i3rFrO0ruohVQOOZW8u8/Mm8BbitK6hbqdsBUNGXaEqNjwY/cP+8FFEMNyaFrWWqMNyMa4/OGlZUEcZk9yzz1AMkDdE58SokU6gdRV9TdKh3q4xv0uEbOe+GDb3vANtdTWowkSIKitDGSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009420; c=relaxed/simple;
	bh=EC3LnVqPbgmcXuI5roGeL5xwiC6iDSLY8CiY9mZTp8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyiQeKZNMVBezMyBBq9yneBOrr6ZY8BJ2YTf+813qBVVkdyHVplro3aBjF3skDCczE5MrQv/M6cPBNDxegZCyhbCQ03YLIYqm2WEVvXwjCW63cf4yZz5l1dRj205kDCmogXAPKXd5VTVSq+QbCXnh58S5Wb4yaqfICzOnF+zwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0855F106F;
	Mon,  3 Mar 2025 05:43:51 -0800 (PST)
Received: from [10.57.66.216] (unknown [10.57.66.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D8123F673;
	Mon,  3 Mar 2025 05:43:35 -0800 (PST)
Message-ID: <7778df43-5169-4d1c-9fe6-44bee39edfc1@arm.com>
Date: Mon, 3 Mar 2025 13:43:33 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: fix an API misuse issue in em_create_pd()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Haoxiang Li <haoxiang_li2024@163.com>
Cc: len.brown@intel.com, pavel@kernel.org, dietmar.eggemann@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250303034337.3868497-1-haoxiang_li2024@163.com>
 <CAJZ5v0g5RJaHeYqiP3khp2vPyVHj0W35ab4gtBJ0R14nhSqa_A@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g5RJaHeYqiP3khp2vPyVHj0W35ab4gtBJ0R14nhSqa_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/3/25 12:38, Rafael J. Wysocki wrote:
> On Mon, Mar 3, 2025 at 4:43 AM Haoxiang Li <haoxiang_li2024@163.com> wrote:
>>
>> Replace kfree() with em_table_free() to free
>> the memory allocated by em_table_alloc().
> 
> Ostensibly, this is fixing a problem, but there's no problem described
> above.  Please describe it.

Thank Rafael for adding me on CC.

> 
>> Fixes: 24e9fb635df2 ("PM: EM: Remove old table")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
>> ---
>>   kernel/power/energy_model.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 3874f0e97651..71b60aa20227 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -447,7 +447,7 @@ static int em_create_pd(struct device *dev, int nr_states,
>>          return 0;
>>
>>   free_pd_table:
>> -       kfree(em_table);
>> +       em_table_free(em_table);
>>   free_pd:
>>          kfree(pd);
>>          return -EINVAL;
>> --
>> 2.25.1
>>

IMO there is no need to use RCU freeing mechanism, since
this table is not used yet. We failed in the initialization
steps, so we can simply call kfree() on that memory.

That 'free_pd_table' goto label is triggered before the call to:

rcu_assign_pointer(pd->em_table, em_table);

IMO this is even dangerous in the patch to abuse RCU free for such case.

Regards,
Lukasz

