Return-Path: <linux-pm+bounces-35976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD8BD34AB
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 15:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD95E189D2FA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2E522332E;
	Mon, 13 Oct 2025 13:52:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0091145B3F;
	Mon, 13 Oct 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363564; cv=none; b=q3NtuSTPsX+N1fxyULH5JtjrpNAeI4NO2+WapSGft7k/42JqpWduxPUuGD+lLJKAtf3kYC7TFmLtK18JtxoOvQQAxabFthYlTZXbv6kaTnuycxzB7mk2+lRcQgoKROtuvy7U9Y+VEEkA8CNw+cZROYXm3KrTw+osX23iPka6ghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363564; c=relaxed/simple;
	bh=1CzgZorPYTrcd+yHNzSzHuwWLiL9Qyg4O9tQOxehr4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtaIPFawq4KHcBNLwYp60mANUWwWs+n43rC57ht/KEpGBsg865Ze7tqQ1Ew1QR2oLto23dptUQFIzNolKmyOH89Ni4aoAMQbGf47vMcu5uT17RORjAzBqHEum9tbNGor3yyrvWQmi9S+kYLizmTFNdR15fJx2bzLjgix5VyU7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13310113E;
	Mon, 13 Oct 2025 06:52:33 -0700 (PDT)
Received: from [10.57.36.143] (unknown [10.57.36.143])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71DE43F738;
	Mon, 13 Oct 2025 06:52:39 -0700 (PDT)
Message-ID: <507225c7-5d10-4b92-a448-c44d545c8867@arm.com>
Date: Mon, 13 Oct 2025 14:53:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 05/10] PM: EM: Add a skeleton code for netlink
 notification
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-6-changwoo@igalia.com>
 <2be75031-e7a6-44e8-a096-945947d73631@arm.com>
 <ad403e60-ad18-49ca-8557-a81329c9269f@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ad403e60-ad18-49ca-8557-a81329c9269f@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/13/25 14:46, Changwoo Min wrote:
> 
> 
> On 10/7/25 00:44, Lukasz Luba wrote:
>>
>>
>> On 9/21/25 04:19, Changwoo Min wrote:
>>> Add a boilerplate code for netlink notification to register the new
>>> protocol family. Also, initialize and register the netlink during 
>>> booting.
>>> The initialization is called at the postcore level, which is late enough
>>> after the generic netlink is initialized.
>>>
>>> Finally, update MAINTAINERS to include new files.
>>>
>>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>>> ---
>>>   MAINTAINERS               |  2 +-
>>>   kernel/power/Makefile     |  5 ++++-
>>>   kernel/power/em_netlink.c | 35 +++++++++++++++++++++++++++++++++++
>>>   kernel/power/em_netlink.h | 16 ++++++++++++++++
>>>   4 files changed, 56 insertions(+), 2 deletions(-)
>>>   create mode 100644 kernel/power/em_netlink.c
>>>   create mode 100644 kernel/power/em_netlink.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 0992029d271d..ba528836eac1 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -9034,7 +9034,7 @@ F:    include/linux/energy_model.h
>>>   F:    Documentation/power/energy-model.rst
>>>   F:    Documentation/netlink/specs/em.yaml
>>>   F:    include/uapi/linux/energy_model.h
>>> -F:    kernel/power/em_netlink_autogen.*
>>> +F:    kernel/power/em_netlink*.*
>>>   EPAPR HYPERVISOR BYTE CHANNEL DEVICE DRIVER
>>>   M:    Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
>>> index 874ad834dc8d..284a760aade7 100644
>>> --- a/kernel/power/Makefile
>>> +++ b/kernel/power/Makefile
>>> @@ -21,4 +21,7 @@ obj-$(CONFIG_PM_WAKELOCKS)    += wakelock.o
>>>   obj-$(CONFIG_MAGIC_SYSRQ)    += poweroff.o
>>> -obj-$(CONFIG_ENERGY_MODEL)    += energy_model.o
>>> +obj-$(CONFIG_ENERGY_MODEL)    += em.o
>>> +em-y                := energy_model.o
>>> +em-$(CONFIG_NET)        += em_netlink_autogen.o em_netlink.o
>>> +
>>> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
>>> new file mode 100644
>>> index 000000000000..f3fbfeff29a4
>>> --- /dev/null
>>> +++ b/kernel/power/em_netlink.c
>>> @@ -0,0 +1,35 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + *
>>> + * Generic netlink for energy model.
>>> + *
>>> + * Copyright (c) 2025 Valve Corporation.
>>> + * Author: Changwoo Min <changwoo@igalia.com>
>>> + */
>>> +
>>> +#define pr_fmt(fmt) "energy_model: " fmt
>>> +
>>> +#include <linux/energy_model.h>
>>> +#include <net/sock.h>
>>> +#include <net/genetlink.h>
>>> +#include <uapi/linux/energy_model.h>
>>> +
>>> +#include "em_netlink.h"
>>> +#include "em_netlink_autogen.h"
>>> +
>>> +int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>> +int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info 
>>> *info)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static int __init em_netlink_init(void)
>>> +{
>>> +    return genl_register_family(&em_nl_family);
>>> +}
>>> +postcore_initcall(em_netlink_init);
>>> +
>>> diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
>>> new file mode 100644
>>> index 000000000000..acd186c92d6b
>>> --- /dev/null
>>> +++ b/kernel/power/em_netlink.h
>>> @@ -0,0 +1,16 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + *
>>> + * Generic netlink for energy model.
>>> + *
>>> + * Copyright (c) 2025 Valve Corporation.
>>> + * Author: Changwoo Min <changwoo@igalia.com>
>>> + */
>>> +#ifndef _EM_NETLINK_H
>>> +#define _EM_NETLINK_H
>>> +
>>> +#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
>>> +#else
>>> +#endif
>>> +
>>> +#endif /* _EM_NETLINK_H */
>>
>> Actually, those declarations of functions from patch 3/10 can
>> live in this header. We would avoid creating more local headers
>> in such case.
> 
>   That makes sense to me.
> 
>>
>> Then the patch 3/10 would have to go after this patch when
>> this header is introduced.
>>
>> Please ignore the comment in the patch 3/10 and try to
>> use this header. It is also logically linked to the
>> notifications, so belongs to such header IMHO.
>>
> 
> Sure, after moving 3/10 after this, I will move the changes made in 3/10
> to em_netlink.h. I will keep the implementation of
> for_each_em_perf_domain() and em_perf_domain_get_by_id() in
> energy_model.c since it it not ideal to expose em_pd_list_mutex, etc.
> outside of energy_mode.c. And, this requires to include "em_netlink.h"
> from energy_model.c.
> 

Sounds good. These are only minor changes because it has nice shape
already.

I was able to test it last weekend and it works on my setup now.
I can see the messages coming in the user-space, so it should
work as designed.

Thank you Changwoo! Looking forward for your v5.

Regards,
Lukasz

