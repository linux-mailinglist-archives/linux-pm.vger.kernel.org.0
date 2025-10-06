Return-Path: <linux-pm+bounces-35739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF61BBBE867
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 17:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E2824EE630
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00E52D8DD6;
	Mon,  6 Oct 2025 15:43:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5EE2D879B;
	Mon,  6 Oct 2025 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765433; cv=none; b=SZgbfyEHe0NIRyO0JOHpVJy7kcEEg9fyBCz3okETt5ITfduy774MLLksYMoXy5MLZhu/N+pC2ryiMnC0yl7Vnouy+/BOwsVv2G7nOdL+3OGtKEjOXeJah4wUkIrkDmIaOWGS68A3yIgXTvVJe2TaSm2pC26PImTaiqlwD4odUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765433; c=relaxed/simple;
	bh=9TS8mvHfI1X9G76iPlEBCH6KiBzdkL1LBmUhaIltqjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DY0Smf1PmIJApMbOS6xDMKURAxWXD9zelL6Si08kN76VrNEg5laNKNEYpyP4px6bZWKqexZKBWO/NW6VhHEVKnC8RpWLTgfOQboxnQwKE3gt5QESsHr2ka5Ik+2+hFcYwbpiwaKNUhWVZ2MPZYIVn5ebJZhXleoPyQBryAabCT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B54221515;
	Mon,  6 Oct 2025 08:43:42 -0700 (PDT)
Received: from [10.57.81.187] (unknown [10.57.81.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE4953F66E;
	Mon,  6 Oct 2025 08:43:48 -0700 (PDT)
Message-ID: <2be75031-e7a6-44e8-a096-945947d73631@arm.com>
Date: Mon, 6 Oct 2025 16:44:10 +0100
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
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250921031928.205869-6-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/25 04:19, Changwoo Min wrote:
> Add a boilerplate code for netlink notification to register the new
> protocol family. Also, initialize and register the netlink during booting.
> The initialization is called at the postcore level, which is late enough
> after the generic netlink is initialized.
> 
> Finally, update MAINTAINERS to include new files.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   MAINTAINERS               |  2 +-
>   kernel/power/Makefile     |  5 ++++-
>   kernel/power/em_netlink.c | 35 +++++++++++++++++++++++++++++++++++
>   kernel/power/em_netlink.h | 16 ++++++++++++++++
>   4 files changed, 56 insertions(+), 2 deletions(-)
>   create mode 100644 kernel/power/em_netlink.c
>   create mode 100644 kernel/power/em_netlink.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0992029d271d..ba528836eac1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9034,7 +9034,7 @@ F:	include/linux/energy_model.h
>   F:	Documentation/power/energy-model.rst
>   F:	Documentation/netlink/specs/em.yaml
>   F:	include/uapi/linux/energy_model.h
> -F:	kernel/power/em_netlink_autogen.*
> +F:	kernel/power/em_netlink*.*
>   
>   EPAPR HYPERVISOR BYTE CHANNEL DEVICE DRIVER
>   M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> index 874ad834dc8d..284a760aade7 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -21,4 +21,7 @@ obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
>   
>   obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
>   
> -obj-$(CONFIG_ENERGY_MODEL)	+= energy_model.o
> +obj-$(CONFIG_ENERGY_MODEL)	+= em.o
> +em-y				:= energy_model.o
> +em-$(CONFIG_NET)		+= em_netlink_autogen.o em_netlink.o
> +
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> new file mode 100644
> index 000000000000..f3fbfeff29a4
> --- /dev/null
> +++ b/kernel/power/em_netlink.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *
> + * Generic netlink for energy model.
> + *
> + * Copyright (c) 2025 Valve Corporation.
> + * Author: Changwoo Min <changwoo@igalia.com>
> + */
> +
> +#define pr_fmt(fmt) "energy_model: " fmt
> +
> +#include <linux/energy_model.h>
> +#include <net/sock.h>
> +#include <net/genetlink.h>
> +#include <uapi/linux/energy_model.h>
> +
> +#include "em_netlink.h"
> +#include "em_netlink_autogen.h"
> +
> +int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int __init em_netlink_init(void)
> +{
> +	return genl_register_family(&em_nl_family);
> +}
> +postcore_initcall(em_netlink_init);
> +
> diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
> new file mode 100644
> index 000000000000..acd186c92d6b
> --- /dev/null
> +++ b/kernel/power/em_netlink.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *
> + * Generic netlink for energy model.
> + *
> + * Copyright (c) 2025 Valve Corporation.
> + * Author: Changwoo Min <changwoo@igalia.com>
> + */
> +#ifndef _EM_NETLINK_H
> +#define _EM_NETLINK_H
> +
> +#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
> +#else
> +#endif
> +
> +#endif /* _EM_NETLINK_H */

Actually, those declarations of functions from patch 3/10 can
live in this header. We would avoid creating more local headers
in such case.

Then the patch 3/10 would have to go after this patch when
this header is introduced.

Please ignore the comment in the patch 3/10 and try to
use this header. It is also logically linked to the
notifications, so belongs to such header IMHO.

