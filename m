Return-Path: <linux-pm+bounces-12379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584419554F0
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 04:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D559D1F22B92
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 02:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DBBDF78;
	Sat, 17 Aug 2024 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VAWgS1nM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5953BE;
	Sat, 17 Aug 2024 02:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723862852; cv=none; b=PrycBfo9hIdemgSHxi9FuB5kv84gVTGHzX/r1UsV9v/ickEaGYZP9Z7UmXT2hiu0/vOKiCGJY9i/16LIif0KRjgOgbSwMk7tcZ02nZvFrD9u9cric485OsBpBUmzwik8FeiIFuv/wYVKO18czJR6qwBOvhlMOTR/BfsZrquEhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723862852; c=relaxed/simple;
	bh=y6B3Lnxh/IuPH+YcM3DrsXZ2JLrE/sXhz47kiJAK1Zc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qhwKSD26F833PVLMn3wbXI6b+i3CjjT43T4eGEEJGGqqvNS+VipKtoTJB7VICiC9OWZVesEsVClyQ+31u6otmlWV/bvpuMZK6nzxCavwBZ2qU8OpRYpaZJgEXO7N19+RzJ/s9GVZpaPYkM4wVBmb4q858NxcNYclxcyhZGB+Bl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=VAWgS1nM; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723862846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ILl21Jnwm7TqOlWHYJvqsxpr68uShoqtkHN6ha+OfM=;
	b=VAWgS1nMBcf21iEqxxExT1YTixCG2/ArjIOyp2y2QE2zUicqnQh0VsJfOppfvF8lqOADIm
	e3UbyLZj1wybuvvotbX/4Syao80zW8hnQb1aT+4QjXu2A9/p/APV5T/8/RyZtLB7U4abpw
	xyvY/0vKNgEytQPXNdKD+XCulTved/lkLd/VfmOBr2JWutEPQY+U0Bq1YmCJ+6i1jzULmA
	6tTHv2Q+lLlSv/o0sX5sxYTYpcNPib3oYngWWp3TAXdeYkS4i3zZAJfpRVVfFPIuMHPzes
	+EL7EEppmXcGUYqZXNPZL0vne2c6MHbrbawHROS5IPosff1lYKwIYcsUp1OJdQ==
Date: Sat, 17 Aug 2024 04:47:25 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit
 Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/7] thermal: of: Use scoped device node handling to
 simplify thermal_of_trips_init()
In-Reply-To: <20240815071538.GB350960@google.com>
References: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
 <20240814-b4-cleanup-h-of-node-put-thermal-v1-2-7a1381e1627e@linaro.org>
 <20240815071538.GB350960@google.com>
Message-ID: <c8f2e2b74bc46cf6870909add3f1ccd6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-15 09:15, Chen-Yu Tsai wrote:
> On Wed, Aug 14, 2024 at 10:17:48PM +0200, Krzysztof Kozlowski wrote:
>> Obtain the device node reference with scoped/cleanup.h to reduce error
>> handling and make the code a bit simpler.
>> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/thermal/thermal_of.c | 14 ++++----------
>>  1 file changed, 4 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/thermal/thermal_of.c 
>> b/drivers/thermal/thermal_of.c
>> index a2278d4ad886..c8ded4462bb8 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -117,10 +117,9 @@ static int thermal_of_populate_trip(struct 
>> device_node *np,
>>  static struct thermal_trip *thermal_of_trips_init(struct device_node 
>> *np, int *ntrips)
>>  {
>>  	struct thermal_trip *tt;
>> -	struct device_node *trips;
>>  	int ret, count;
>> 
>> -	trips = of_get_child_by_name(np, "trips");
>> +	struct device_node *trips __free(device_node) = 
>> of_get_child_by_name(np, "trips");
>>  	if (!trips) {
>>  		pr_err("Failed to find 'trips' node\n");
>>  		return ERR_PTR(-EINVAL);
>> @@ -129,15 +128,12 @@ static struct thermal_trip 
>> *thermal_of_trips_init(struct device_node *np, int *n
>>  	count = of_get_child_count(trips);
>>  	if (!count) {
>>  		pr_err("No trip point defined\n");
>> -		ret = -EINVAL;
>> -		goto out_of_node_put;
>> +		return ERR_PTR(-EINVAL);
>>  	}
>> 
>>  	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
>> -	if (!tt) {
>> -		ret = -ENOMEM;
>> -		goto out_of_node_put;
>> -	}
>> +	if (!tt)
>> +		return ERR_PTR(-ENOMEM);
>> 
>>  	*ntrips = count;
> 
> Also drop the "of_node_put(trips);" in the successful path?
> 
> Once fixed,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> And I plan to send a patch on top of this making "tt" auto released,
> thereby eliminating the error path.

Ah, with that additional patch in place, I totally agree with
moving "*ntrips = 0" to the top.

>> @@ -155,8 +151,6 @@ static struct thermal_trip 
>> *thermal_of_trips_init(struct device_node *np, int *n
>>  out_kfree:
>>  	kfree(tt);
>>  	*ntrips = 0;
>> -out_of_node_put:
>> -	of_node_put(trips);
>> 
>>  	return ERR_PTR(ret);
>>  }
>> 
>> --
>> 2.43.0
>> 

