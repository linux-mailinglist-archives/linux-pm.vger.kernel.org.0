Return-Path: <linux-pm+bounces-35974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F65BD3465
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 15:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA4884E835C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108461E8332;
	Mon, 13 Oct 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cfpQpM7A"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFA1B4138;
	Mon, 13 Oct 2025 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363225; cv=none; b=fyTooDom25uF8t2Yo40i9txgXLnqGh3mckdPDauq2QSwT6naiaT85d8rmNRGHRss/3FNpWuYCT26XBY7i0bfi4o3CKac3eViJf2l+xRPzBhotRB9BR6nz6Yxi1bUP/1fWEYUzYLZ/w0NZgV0v85i/xrMSuSzsgzJPhy3zbPWKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363225; c=relaxed/simple;
	bh=qO2epxqHfXdG512GF1BRxxFLk6n3uaj2tv1BBzm2NW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTPkQmAcytx4HV26OrKv8QrXmrqtGjNmbhGD9Lf2bJBsgJkMkVW3OX9JfLJad0g9Y/toqqSOi0CtjE3bAzfKnb/c34QHpnnrxscldiYRYmIvR0ECFDXLFRSXTmYnhoKU0r05G0cIntZ35oetM0L3Y89t5m6bcWKWMGZJ/gy8CfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cfpQpM7A; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S5kmzjR/ENdWSxTrizZ0sUD2Q6tlgxZKZF9j1gkuAFs=; b=cfpQpM7AwIxY+XpT4hcU5uVpw/
	xsfbZ1VkE3SUVtTzKQdqwRVr5dKUWjpMoYBuDWTG6HWMynreBgmitBHzdeeq3ct6eG2sLGN6M0OCj
	9Y7AyLbdNfQw2RjhGKmVIuFJCfcfcRm42ofOzzh+6wYnsJBWC2BiPCwaNHNIL/RMW42NgnYp/bjOU
	no5AyRbjRpuS/VBAsdeKIbpYNs4rLz6xI53WLfKRe0HbZDdstJ6LSrxlCxCU0Ws0+at4wPbxmHw28
	oG1c04WDB+8ympXC8wLO1zqmfxp+i7NVXWw6xJZ9+kAe1Dey1Xvqv1/ie3+ququ32wpj/mhMO/qK9
	U0w+IXKQ==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v8It6-008xD1-4B; Mon, 13 Oct 2025 15:46:56 +0200
Message-ID: <ad403e60-ad18-49ca-8557-a81329c9269f@igalia.com>
Date: Mon, 13 Oct 2025 22:46:49 +0900
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
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <2be75031-e7a6-44e8-a096-945947d73631@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/7/25 00:44, Lukasz Luba wrote:
> 
> 
> On 9/21/25 04:19, Changwoo Min wrote:
>> Add a boilerplate code for netlink notification to register the new
>> protocol family. Also, initialize and register the netlink during 
>> booting.
>> The initialization is called at the postcore level, which is late enough
>> after the generic netlink is initialized.
>>
>> Finally, update MAINTAINERS to include new files.
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>> ---
>>   MAINTAINERS               |  2 +-
>>   kernel/power/Makefile     |  5 ++++-
>>   kernel/power/em_netlink.c | 35 +++++++++++++++++++++++++++++++++++
>>   kernel/power/em_netlink.h | 16 ++++++++++++++++
>>   4 files changed, 56 insertions(+), 2 deletions(-)
>>   create mode 100644 kernel/power/em_netlink.c
>>   create mode 100644 kernel/power/em_netlink.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0992029d271d..ba528836eac1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9034,7 +9034,7 @@ F:    include/linux/energy_model.h
>>   F:    Documentation/power/energy-model.rst
>>   F:    Documentation/netlink/specs/em.yaml
>>   F:    include/uapi/linux/energy_model.h
>> -F:    kernel/power/em_netlink_autogen.*
>> +F:    kernel/power/em_netlink*.*
>>   EPAPR HYPERVISOR BYTE CHANNEL DEVICE DRIVER
>>   M:    Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
>> index 874ad834dc8d..284a760aade7 100644
>> --- a/kernel/power/Makefile
>> +++ b/kernel/power/Makefile
>> @@ -21,4 +21,7 @@ obj-$(CONFIG_PM_WAKELOCKS)    += wakelock.o
>>   obj-$(CONFIG_MAGIC_SYSRQ)    += poweroff.o
>> -obj-$(CONFIG_ENERGY_MODEL)    += energy_model.o
>> +obj-$(CONFIG_ENERGY_MODEL)    += em.o
>> +em-y                := energy_model.o
>> +em-$(CONFIG_NET)        += em_netlink_autogen.o em_netlink.o
>> +
>> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
>> new file mode 100644
>> index 000000000000..f3fbfeff29a4
>> --- /dev/null
>> +++ b/kernel/power/em_netlink.c
>> @@ -0,0 +1,35 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *
>> + * Generic netlink for energy model.
>> + *
>> + * Copyright (c) 2025 Valve Corporation.
>> + * Author: Changwoo Min <changwoo@igalia.com>
>> + */
>> +
>> +#define pr_fmt(fmt) "energy_model: " fmt
>> +
>> +#include <linux/energy_model.h>
>> +#include <net/sock.h>
>> +#include <net/genetlink.h>
>> +#include <uapi/linux/energy_model.h>
>> +
>> +#include "em_netlink.h"
>> +#include "em_netlink_autogen.h"
>> +
>> +int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int __init em_netlink_init(void)
>> +{
>> +    return genl_register_family(&em_nl_family);
>> +}
>> +postcore_initcall(em_netlink_init);
>> +
>> diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
>> new file mode 100644
>> index 000000000000..acd186c92d6b
>> --- /dev/null
>> +++ b/kernel/power/em_netlink.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + *
>> + * Generic netlink for energy model.
>> + *
>> + * Copyright (c) 2025 Valve Corporation.
>> + * Author: Changwoo Min <changwoo@igalia.com>
>> + */
>> +#ifndef _EM_NETLINK_H
>> +#define _EM_NETLINK_H
>> +
>> +#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
>> +#else
>> +#endif
>> +
>> +#endif /* _EM_NETLINK_H */
> 
> Actually, those declarations of functions from patch 3/10 can
> live in this header. We would avoid creating more local headers
> in such case.

  That makes sense to me.

> 
> Then the patch 3/10 would have to go after this patch when
> this header is introduced.
> 
> Please ignore the comment in the patch 3/10 and try to
> use this header. It is also logically linked to the
> notifications, so belongs to such header IMHO.
>

Sure, after moving 3/10 after this, I will move the changes made in 3/10
to em_netlink.h. I will keep the implementation of
for_each_em_perf_domain() and em_perf_domain_get_by_id() in
energy_model.c since it it not ideal to expose em_pd_list_mutex, etc.
outside of energy_mode.c. And, this requires to include "em_netlink.h"
from energy_model.c.

Regards,
Changwoo Min


