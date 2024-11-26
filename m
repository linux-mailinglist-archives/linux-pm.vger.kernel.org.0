Return-Path: <linux-pm+bounces-18113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DBD9D9494
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 10:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCA62812E9
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9A01B87DE;
	Tue, 26 Nov 2024 09:34:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB241369B6;
	Tue, 26 Nov 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613687; cv=none; b=JJ8XlRL9RxD/7jztgvUTbGvvxagAvHkQn9mKXbn+rglGm0jVFYKfnLrt1pBY8awk050ug245fyjVqONfr7A/TzrCqrC0aOyFtyKbQ2loD6zB7MaGaLPud+d9E9zG1YTQ9b+Pgv1CDcTCThedMVvtKeqxVZQUEoY1+6bCi7KQcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613687; c=relaxed/simple;
	bh=UahU0DzMS9RcitMW/jlUfz5kwn8zFLVl1/zgoYQR+fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbVEftKibuHcfB5SaH43B29XNNx8H4pKpRqfz3e4zHctCBtWabwienUf3/s0MSihBmWIkR8D514Jj3+Mg+Biicgavpxa6LviZtqQZkN/a/DZFqn1mABYK4X7Osh8B2QK/slSsGqMcRUVbPR3Mstu6sUaKD8uzjSPo3+pQX/gQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADCC01682;
	Tue, 26 Nov 2024 01:35:13 -0800 (PST)
Received: from [10.57.69.222] (unknown [10.57.69.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F9E13F5A1;
	Tue, 26 Nov 2024 01:34:42 -0800 (PST)
Message-ID: <11359a2f-6573-4b07-b333-e20683d690fa@arm.com>
Date: Tue, 26 Nov 2024 09:36:11 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: gov_power_allocator: Add missing NULL pointer
 check
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Sasha Levin <sashal@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>
References: <2761105.mvXUDI8C0e@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2761105.mvXUDI8C0e@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/24 11:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 0dc23567c206 ("thermal: core: Move lists of thermal instances
> to trip descriptors") overlooked the case in which the Power Allocator
> governor attempts to bind to a tripless thermal zone and params->trip_max
> is NULL in check_power_actors().

That corner case sneaked in...

> 
> No power actors can be found in that case, so check_power_actors() needs
> to be made return 0 then to restore its previous behavior.
> 
> Fixes: 0dc23567c206 ("thermal: core: Move lists of thermal instances to trip descriptors")
> Closes: https://lore.kernel.org/linux-pm/Z0NeGF4ryCe_b5rr@sashalap/
> Reported-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_power_allocator.c |    7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/gov_power_allocator.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_power_allocator.c
> +++ linux-pm/drivers/thermal/gov_power_allocator.c
> @@ -588,10 +588,15 @@ static void allow_maximum_power(struct t
>   static int check_power_actors(struct thermal_zone_device *tz,
>   			      struct power_allocator_params *params)
>   {
> -	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
> +	const struct thermal_trip_desc *td;
>   	struct thermal_instance *instance;
>   	int ret = 0;
>   
> +	if (!params->trip_max)
> +		return 0;

Yes, 0 is the right thing to return here, since we might get later some
trip points.

> +
> +	td = trip_to_trip_desc(params->trip_max);
> +
>   	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
>   		if (!cdev_is_power_actor(instance->cdev)) {
>   			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

