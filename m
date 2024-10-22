Return-Path: <linux-pm+bounces-16255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567659AB74E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4B1B21934
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F64813E41A;
	Tue, 22 Oct 2024 20:00:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501C31E515
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627228; cv=none; b=YYj055hUuxyNShZGHwTneA0ppXlmT0eFWhSjEy1lGX1jq5LtNjGYuJ6b9nJcOU4FP8ijth/A/uEC7SHyDlPqvWDEU3ahXZy3b7pkt8nbLi+VrVvhJRPNd2JCduFm515Xrumw5fzYSwGqHSV04KLmTl+8qh0XFiUqNI8NFJJSJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627228; c=relaxed/simple;
	bh=aSQDncSf4szYz7zBvOBdh8dncJT/7WWyEhGGKcEyXEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHUUbpmV6xZL3NwMxcExJ4O8wYpQCEE2kOhOCt1r3cHgKqnsXe4McfYSm2XbNDL56UePPmyIH5760Ynl8H4CUaUBAczT+WvQnLqJbwfT7TASROVffXM4651NV8ZSgbFtVVtJfe08DEzJoHEk+1f0APSTo3+QwkjwZ9zKtb/Eha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5FB4497;
	Tue, 22 Oct 2024 13:00:54 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F85D3F73B;
	Tue, 22 Oct 2024 13:00:24 -0700 (PDT)
Message-ID: <18911cdb-82b6-4f33-bd54-7167b13d77e9@arm.com>
Date: Tue, 22 Oct 2024 21:01:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] tools/lib/thermal: Add the threshold netlink ABI
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241022155147.463475-1-daniel.lezcano@linaro.org>
 <20241022155147.463475-5-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241022155147.463475-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/22/24 16:51, Daniel Lezcano wrote:
> The thermal framework supports the thresholds and allows the userspace
> to create, delete, flush, get the list of the thresholds as well as
> getting the list of the thresholds set for a specific thermal zone.
> 
> Add the netlink abstraction in the thermal library to take full
> advantage of thresholds for the userspace program.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   tools/lib/thermal/commands.c        | 138 +++++++++++++++++++++++++++-
>   tools/lib/thermal/events.c          |  55 ++++++++---
>   tools/lib/thermal/include/thermal.h |  40 ++++++++
>   tools/lib/thermal/libthermal.map    |   5 +
>   tools/lib/thermal/thermal.c         |  17 ++++
>   tools/thermal/lib/Makefile          |   2 +-
>   6 files changed, 242 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
> index a9223df91dcf..bcf0f14d035a 100644
> --- a/tools/lib/thermal/commands.c
> +++ b/tools/lib/thermal/commands.c
> @@ -5,6 +5,7 @@
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
> +#include <limits.h>
>   
>   #include <thermal.h>
>   #include "thermal_nl.h"
> @@ -33,6 +34,11 @@ static struct nla_policy thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] = {
>   	[THERMAL_GENL_ATTR_CDEV_CUR_STATE]      = { .type = NLA_U32 },
>   	[THERMAL_GENL_ATTR_CDEV_MAX_STATE]      = { .type = NLA_U32 },
>   	[THERMAL_GENL_ATTR_CDEV_NAME]           = { .type = NLA_STRING },
> +
> +        /* Thresholds */
> +        [THERMAL_GENL_ATTR_THRESHOLD]      	= { .type = NLA_NESTED },
> +        [THERMAL_GENL_ATTR_THRESHOLD_TEMP]      = { .type = NLA_U32 },
> +        [THERMAL_GENL_ATTR_THRESHOLD_DIRECTION] = { .type = NLA_U32 },
>   };
>   
>   static int parse_tz_get(struct genl_info *info, struct thermal_zone **tz)
> @@ -182,6 +188,48 @@ static int parse_tz_get_gov(struct genl_info *info, struct thermal_zone *tz)
>   	return THERMAL_SUCCESS;
>   }
>   
> +static int parse_threshold_get(struct genl_info *info, struct thermal_zone *tz)
> +{
> +	struct nlattr *attr;
> +	struct thermal_threshold *__tt = NULL;
> +	size_t size = 0;
> +	int rem;
> +
> +	/*
> +	 * The size contains the size of the array and we want to
> +	 * access the last element, size - 1.
> +	 *
> +	 * The variable size is initialized to zero but it will be
> +	 * then incremented by the first if() statement. The message
> +	 * attributes are ordered, so the first if() statement will be
> +	 * always called before the second one. If it happens that is
> +	 * not the case, then it is a kernel bug.
> +	 */

That sounds good, thank you.

> +	nla_for_each_nested(attr, info->attrs[THERMAL_GENL_ATTR_THRESHOLD], rem) {
> +
> +		if (nla_type(attr) == THERMAL_GENL_ATTR_THRESHOLD_TEMP) {
> +
> +			size++;
> +
> +			__tt = realloc(__tt, sizeof(*__tt) * (size + 2));
> +			if (!__tt)
> +				return THERMAL_ERROR;
> +
> +			__tt[size - 1].temperature = nla_get_u32(attr);
> +		}
> +
> +		if (nla_type(attr) == THERMAL_GENL_ATTR_THRESHOLD_DIRECTION)
> +			__tt[size - 1].direction = nla_get_u32(attr);
> +	}
> +
> +	if (__tt)
> +		__tt[size].temperature = INT_MAX;
> +
> +	tz->thresholds = __tt;
> +
> +	return THERMAL_SUCCESS;
> +}
> +
>

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

