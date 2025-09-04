Return-Path: <linux-pm+bounces-33799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72110B433AD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 09:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72449165540
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D289429BD81;
	Thu,  4 Sep 2025 07:21:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD80C29BD88;
	Thu,  4 Sep 2025 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970469; cv=none; b=u8kBQM81yKmNsGG3z9ZrQ9sLVABM3Wtp8ihZN/eG4EQUn+GiZgGiKyy6fmzU/68jQNp1o/7zFhsXaeHH9Rgh6wWR77GDyqdAlOvZQs/3zDcxJG0G1Dnbq/plhoQuqgxrczMHPaezaSnEmXIF/IPMipOrZOiqxo4m3mioWzkca2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970469; c=relaxed/simple;
	bh=9ZC7Xd3nz2v4rUbjg3NOTrXOuzuI5X8DMkeaozKDNoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=heiXNXrQ1y1ilu07mb9yWtq2knjAIRkSfi/Q+VrLc1Ha1zNnRppVybc8a+MM38bv+W8megWC83P+5K+btFQxOqtLLPyMxrlCCIV3abFWHtu+ox4CTj3/bCMMX2cHgwfq3aS8TNCk++JLcKy3yn3KYcavoexzkUqDPeaI1MhIuBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92B981596;
	Thu,  4 Sep 2025 00:20:58 -0700 (PDT)
Received: from [10.57.60.120] (unknown [10.57.60.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33D403F694;
	Thu,  4 Sep 2025 00:21:06 -0700 (PDT)
Message-ID: <a1a302e7-5544-407e-9a9d-1a59fdc53dfe@arm.com>
Date: Thu, 4 Sep 2025 08:21:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] thermal: gov_step_wise: Clean up local variable
 initialization
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <12745610.O9o76ZdvQC@rafael.j.wysocki>
 <6203592.lOV4Wx5bFT@rafael.j.wysocki>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <6203592.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/25 14:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the initialization of local variable throttle in
> thermal_zone_trip_update() more straightforward.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_step_wise.c |    6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> --- a/drivers/thermal/gov_step_wise.c
> +++ b/drivers/thermal/gov_step_wise.c
> @@ -69,16 +69,14 @@
>   				     const struct thermal_trip_desc *td,
>   				     int trip_threshold)
>   {
> +	bool throttle = tz->temperature >= trip_threshold;
>   	const struct thermal_trip *trip = &td->trip;
>   	enum thermal_trend trend = get_tz_trend(tz, trip);
>   	int trip_id = thermal_zone_trip_id(tz, trip);
>   	struct thermal_instance *instance;
> -	bool throttle = false;
>   
> -	if (tz->temperature >= trip_threshold) {
> -		throttle = true;
> +	if (throttle)
>   		trace_thermal_zone_trip(tz, trip_id, trip->type);
> -	}
>   
>   	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
>   		trip_id, trip->type, trip_threshold, trend, throttle);
> 
> 
> 


LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


