Return-Path: <linux-pm+bounces-36047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E04BD83FB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B69654FE14F
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 08:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5F630F940;
	Tue, 14 Oct 2025 08:43:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC230FF24;
	Tue, 14 Oct 2025 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431393; cv=none; b=kdo1QkycfjCtsSkRuaECXFHb05MqovEKWKAt2RKq3B1dnEzdJ68OoAp0LYJS/RbLmAU0OOLTn6s+2syrf6WovLvRLHEfKOIpQ4Dcjou6bWz97x+zIFsOIXiOe4QoAMFqJqZLTxSO9aGg1cmN24wfnm6dpwhp0ZaqXQ/LM+sD5zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431393; c=relaxed/simple;
	bh=WiNBOqoDn+y2loO08eEfkvYUFqjF0gha9fBQrELlhqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMeGu02P2YHVJ6F4v3UOzfcRRBG8/OgQAHVQKQt5jojXfz48k8AptuYaj+0Xr3VaFcjTca8FiloGPbt/0JEw9O+k2y8oUvNNNsUuwPdIK99ZJom7FpKelkC6EEPoeq4V1xD5+13ucTlDd4+FrtTpT/VUvvf+wvqYd3IuBjVP4nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 635C31A9A;
	Tue, 14 Oct 2025 01:43:01 -0700 (PDT)
Received: from [10.57.5.128] (unknown [10.57.5.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77B253F6A8;
	Tue, 14 Oct 2025 01:43:07 -0700 (PDT)
Message-ID: <36bb0e0b-bcff-40f7-b9a6-07b9dd18eb6c@arm.com>
Date: Tue, 14 Oct 2025 09:43:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] PM: EM: Add a skeleton code for netlink
 notification
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251014001055.772422-1-changwoo@igalia.com>
 <20251014001055.772422-5-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251014001055.772422-5-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/25 01:10, Changwoo Min wrote:
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
> index babd7088fc1c..bc2c08e6f0ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9182,7 +9182,7 @@ F:	include/linux/energy_model.h
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


LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

