Return-Path: <linux-pm+bounces-33800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A1FB433B9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 09:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FAA2586530
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393D299922;
	Thu,  4 Sep 2025 07:22:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2201929B8FE;
	Thu,  4 Sep 2025 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970544; cv=none; b=MdpirfqrIs8AuMPA1v/VzUbxjPfP8YOossYU3Ozl4UYPsVDs5NTl+6fTeMyPkGW/Sr96rrqc1C9A0xZ7X3LYeY4YjEU+hWm7ufLz9qUjZ8Oftaugy7d/QyylUfORMqzXnAQFyqSiLlEEmS+fffGTo2YM8g8Ji3mfstZ+3kzh2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970544; c=relaxed/simple;
	bh=8xhKGC5h+8ruU65eyfF72QFoZWvuqMYGLgBhcCI8mt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zh304pYEkrtba5uICgBApXLsNMc/+pj1iCy7M3rituQJgF6O+QIracHQGyPxpPf+fHzPNhcoYNHra50/3IaQQBuI2asldJBY0xnaK5EX37NPkAO3tZWFBrG2ZSxWRcML2hdt+uvUJqKSdvr4SLzl3Do0aBamXh3gy/v8OYuRt+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0583C1596;
	Thu,  4 Sep 2025 00:22:14 -0700 (PDT)
Received: from [10.57.60.120] (unknown [10.57.60.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F6D93F694;
	Thu,  4 Sep 2025 00:22:21 -0700 (PDT)
Message-ID: <4f0c03aa-bdb5-4a30-b81c-59e0e68313be@arm.com>
Date: Thu, 4 Sep 2025 08:22:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] thermal: gov_step_wise: Clarify cooling logic
 description comment
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <12745610.O9o76ZdvQC@rafael.j.wysocki>
 <4690596.LvFx2qVVIh@rafael.j.wysocki>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4690596.LvFx2qVVIh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/25 14:28, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The cooling logic description comment next to the get_target_state()
> definition is slightly ambiguous in what it means by "lower cooling
> state", so clarify that by replacing the ambuguous phrase with "the
> minimum applicable cooling state".
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_step_wise.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/thermal/gov_step_wise.c
> +++ b/drivers/thermal/gov_step_wise.c
> @@ -23,8 +23,8 @@
>    *    b. if the trend is THERMAL_TREND_DROPPING, do nothing
>    * If the temperature is lower than a trip point,
>    *    a. if the trend is THERMAL_TREND_RAISING, do nothing
> - *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
> - *       state for this trip point, if the cooling state already
> + *    b. if the trend is THERMAL_TREND_DROPPING, use the minimum applicable
> + *       cooling state for this trip point, or if the cooling state already
>    *       equals lower limit, deactivate the thermal instance
>    */
>   static unsigned long get_target_state(struct thermal_instance *instance,
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

