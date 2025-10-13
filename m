Return-Path: <linux-pm+bounces-35977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22A6BD3DB0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 17:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E4F40422E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBDC2F83BA;
	Mon, 13 Oct 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="d6qqfemU"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B42727F8;
	Mon, 13 Oct 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366629; cv=none; b=u4TOgFZwto3hEUIE3IMKCuOAsdXKQRpWgzfLkZDfUWk/rAR0duxVWHAwMWKne+yKUTpnej/oJutaxwXMRHQ8puXfb6DDWwZ0SZb7bHrkvqoq/Er9pX0GVF4qceIBuCNMIhTdJSjvTqk4IvcrxoJq2bkzV1uZybr84LCu0blsyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366629; c=relaxed/simple;
	bh=fNSlmFkAwMv7DSvSIlrhBoKIM17GelrNPvEpaF69TWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlwzypGIHLAacpnOFfPtArgC9cUEg+Am81tCwuQ7hEEpk/6o8IHiBRl0bCpxWSXsa8yl2Q9AR1HzdwulDdvmKK1xIbCl05E079/mz11oezbkWSVI8cxM3hMDvBs60gLnVX4eAB5njgqeTq6YIMPpJhhjU+M0sdAiFZXn6px6No0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=d6qqfemU; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z77PuP/yQTSrJ7+jwLh0PPjk/nTPqujxkqChcEwXBUs=; b=d6qqfemUqFgGgbZyDg3hcf6Cp4
	nyAgeX0/PsgLzHLU0JI5+Z6lvPDQ7NOS2tdgl4+nCRdFjqIVYmFM2YBXNJGmrEDmKMmTnD5RAyn2A
	SnfKNY9axHLsaXac1UMcX2Cow2EDQqAIQsmO5XZzF7U58Cyr8HwEfSMI0Goc7o66sPye5XGwKX2Bc
	tosNXVjEDGmacYnWUUuJxjv55bmKiO112xn7fZlu7s1RQGfDnpTtlAiZTkpJJEldoWmgKoPFnexVy
	6M1v/+n1DU/bBM/CL93gCiz5nB8jYTrJ8SwadQepooUPnmjGaFhDbeeAVa1u0WtabPKBrAaljQLEe
	/Pp8SC7g==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v8Jlw-008yVA-95; Mon, 13 Oct 2025 16:43:36 +0200
Message-ID: <ed555287-1f31-4831-a11c-799e177a8f2f@igalia.com>
Date: Mon, 13 Oct 2025 23:43:28 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 05/10] PM: EM: Add a skeleton code for netlink
 notification
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-6-changwoo@igalia.com>
 <2be75031-e7a6-44e8-a096-945947d73631@arm.com>
 <ad403e60-ad18-49ca-8557-a81329c9269f@igalia.com>
 <507225c7-5d10-4b92-a448-c44d545c8867@arm.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <507225c7-5d10-4b92-a448-c44d545c8867@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/13/25 22:53, Lukasz Luba wrote:
> 
> 
> On 10/13/25 14:46, Changwoo Min wrote:
>>
>>
>> On 10/7/25 00:44, Lukasz Luba wrote:
>>>
>>>
>>> On 9/21/25 04:19, Changwoo Min wrote:
>>>> Add a boilerplate code for netlink notification to register the new
>>>> protocol family. Also, initialize and register the netlink during 
>>>> booting.
>>>> The initialization is called at the postcore level, which is late 
>>>> enough
>>>> after the generic netlink is initialized.
>>>>
>>>> Finally, update MAINTAINERS to include new files.
>>>>
>>>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>>>> ---
>>>>   MAINTAINERS               |  2 +-
>>>>   kernel/power/Makefile     |  5 ++++-
>>>>   kernel/power/em_netlink.c | 35 +++++++++++++++++++++++++++++++++++
>>>>   kernel/power/em_netlink.h | 16 ++++++++++++++++
>>>>   4 files changed, 56 insertions(+), 2 deletions(-)
>>>>   create mode 100644 kernel/power/em_netlink.c
>>>>   create mode 100644 kernel/power/em_netlink.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 0992029d271d..ba528836eac1 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -9034,7 +9034,7 @@ F:    include/linux/energy_model.h
>>>>   F:    Documentation/power/energy-model.rst
>>>>   F:    Documentation/netlink/specs/em.yaml
>>>>   F:    include/uapi/linux/energy_model.h
>>>> -F:    kernel/power/em_netlink_autogen.*
>>>> +F:    kernel/power/em_netlink*.*
>>>>   EPAPR HYPERVISOR BYTE CHANNEL DEVICE DRIVER
>>>>   M:    Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
>>>> index 874ad834dc8d..284a760aade7 100644
>>>> --- a/kernel/power/Makefile
>>>> +++ b/kernel/power/Makefile
>>>> @@ -21,4 +21,7 @@ obj-$(CONFIG_PM_WAKELOCKS)    += wakelock.o
>>>>   obj-$(CONFIG_MAGIC_SYSRQ)    += poweroff.o
>>>> -obj-$(CONFIG_ENERGY_MODEL)    += energy_model.o
>>>> +obj-$(CONFIG_ENERGY_MODEL)    += em.o
>>>> +em-y                := energy_model.o
>>>> +em-$(CONFIG_NET)        += em_netlink_autogen.o em_netlink.o
>>>> +
>>>> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
>>>> new file mode 100644
>>>> index 000000000000..f3fbfeff29a4
>>>> --- /dev/null
>>>> +++ b/kernel/power/em_netlink.c
>>>> @@ -0,0 +1,35 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + *
>>>> + * Generic netlink for energy model.
>>>> + *
>>>> + * Copyright (c) 2025 Valve Corporation.
>>>> + * Author: Changwoo Min <changwoo@igalia.com>
>>>> + */
>>>> +
>>>> +#define pr_fmt(fmt) "energy_model: " fmt
>>>> +
>>>> +#include <linux/energy_model.h>
>>>> +#include <net/sock.h>
>>>> +#include <net/genetlink.h>
>>>> +#include <uapi/linux/energy_model.h>
>>>> +
>>>> +#include "em_netlink.h"
>>>> +#include "em_netlink_autogen.h"
>>>> +
>>>> +int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info)
>>>> +{
>>>> +    return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info 
>>>> *info)
>>>> +{
>>>> +    return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +static int __init em_netlink_init(void)
>>>> +{
>>>> +    return genl_register_family(&em_nl_family);
>>>> +}
>>>> +postcore_initcall(em_netlink_init);
>>>> +
>>>> diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
>>>> new file mode 100644
>>>> index 000000000000..acd186c92d6b
>>>> --- /dev/null
>>>> +++ b/kernel/power/em_netlink.h
>>>> @@ -0,0 +1,16 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + *
>>>> + * Generic netlink for energy model.
>>>> + *
>>>> + * Copyright (c) 2025 Valve Corporation.
>>>> + * Author: Changwoo Min <changwoo@igalia.com>
>>>> + */
>>>> +#ifndef _EM_NETLINK_H
>>>> +#define _EM_NETLINK_H
>>>> +
>>>> +#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
>>>> +#else
>>>> +#endif
>>>> +
>>>> +#endif /* _EM_NETLINK_H */
>>>
>>> Actually, those declarations of functions from patch 3/10 can
>>> live in this header. We would avoid creating more local headers
>>> in such case.
>>
>>   That makes sense to me.
>>
>>>
>>> Then the patch 3/10 would have to go after this patch when
>>> this header is introduced.
>>>
>>> Please ignore the comment in the patch 3/10 and try to
>>> use this header. It is also logically linked to the
>>> notifications, so belongs to such header IMHO.
>>>
>>
>> Sure, after moving 3/10 after this, I will move the changes made in 3/10
>> to em_netlink.h. I will keep the implementation of
>> for_each_em_perf_domain() and em_perf_domain_get_by_id() in
>> energy_model.c since it it not ideal to expose em_pd_list_mutex, etc.
>> outside of energy_mode.c. And, this requires to include "em_netlink.h"
>> from energy_model.c.
>>
> 
> Sounds good. These are only minor changes because it has nice shape
> already.
> 
> I was able to test it last weekend and it works on my setup now.
> I can see the messages coming in the user-space, so it should
> work as designed.
> 
> Thank you Changwoo! Looking forward for your v5.

Thank you Lukasz for testing. I will send v5 soon after final testing.

Regards,
Changwoo Min


