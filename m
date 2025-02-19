Return-Path: <linux-pm+bounces-22450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BBFA3C240
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B403AA4F9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3C1DF962;
	Wed, 19 Feb 2025 14:32:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E961DE8B4
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975522; cv=none; b=IZFWoE2i0QyA2sTyEX1VUIjhXYt2TD39egsuUEazUhHEbbcAZlfxSdyM85AW+DIihlUkkoGoMezP7xM7CobPl8mG/FbzjTS0r6v4aWn9ka2v48EXZS2pCsZKbgBiXzyXQx7PBp8bJisd1QoMS5h9GfyBBNewbz+Qta+E9K9ASik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975522; c=relaxed/simple;
	bh=8Z9gs/M99yK77d1yKYTMPQjoXN61AK7KySp0SwfzCZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dbu2lqeLGRYaBsgCxGlVnWDxbPjJOIJVghlgLOcaLDOwEjK/NIFk5ObMaTuSpHlxhvR5X/3NMhW0ymOXxiWjPXS1ZHQE+VRXIiaJsYejOVA4079aNSscXKyplw8BkyYpERhYtsfYMshpj1zFB7MF9wOCb/k7p/wp+Ig/tH3yqTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF48F12FC;
	Wed, 19 Feb 2025 06:32:18 -0800 (PST)
Received: from [10.57.64.32] (unknown [10.57.64.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 435523F59E;
	Wed, 19 Feb 2025 06:31:59 -0800 (PST)
Message-ID: <95135302-9a9f-46c0-a786-8a20ac26801d@arm.com>
Date: Wed, 19 Feb 2025 14:31:58 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: use kfree_rcu to simplify the code
To: "Rafael J. Wysocki" <rafael@kernel.org>, lirongqing <lirongqing@baidu.com>
Cc: pavel@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org
References: <20250218082021.2766-1-lirongqing@baidu.com>
 <CAJZ5v0gHUQzjk9vdSrHOU6tCoN0hx291ALW7tVN-JPxW9cVSiw@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0gHUQzjk9vdSrHOU6tCoN0hx291ALW7tVN-JPxW9cVSiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/18/25 12:49, Rafael J. Wysocki wrote:
> +Lukasz Luba
> 
> On Tue, Feb 18, 2025 at 9:20 AM lirongqing <lirongqing@baidu.com> wrote:
>>
>> From: Li RongQing <lirongqing@baidu.com>
>>
>> The callback function of call_rcu() just calls kfree(), so use
>> kfree_rcu() instead of call_rcu() + callback function.
>>
>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> 
> This looks fine to me.  Lukasz?

Thanks Rafael for letting me know.

> 
>> ---
>>   kernel/power/energy_model.c | 10 +---------
>>   1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 3874f0e..72655ef 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -161,14 +161,6 @@ static void em_debug_create_pd(struct device *dev) {}
>>   static void em_debug_remove_pd(struct device *dev) {}
>>   #endif
>>
>> -static void em_destroy_table_rcu(struct rcu_head *rp)
>> -{
>> -       struct em_perf_table __rcu *table;
>> -
>> -       table = container_of(rp, struct em_perf_table, rcu);
>> -       kfree(table);
>> -}
>> -
>>   static void em_release_table_kref(struct kref *kref)
>>   {
>>          struct em_perf_table __rcu *table;
>> @@ -176,7 +168,7 @@ static void em_release_table_kref(struct kref *kref)
>>          /* It was the last owner of this table so we can free */
>>          table = container_of(kref, struct em_perf_table, kref);
>>
>> -       call_rcu(&table->rcu, em_destroy_table_rcu);
>> +       kfree_rcu(table, rcu);
>>   }
>>
>>   /**
>> --
>> 2.9.4
>>

That should work the same way, nice cleanup.
Thanks Li!
LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>



