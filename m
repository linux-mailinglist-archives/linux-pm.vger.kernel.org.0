Return-Path: <linux-pm+bounces-7758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DF8C3BBA
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 09:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFDE1F214A1
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AEC146A67;
	Mon, 13 May 2024 07:11:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0631FA1;
	Mon, 13 May 2024 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715584280; cv=none; b=fREOTropJUkaB3MCac7+LcL/P1J3Z1RxhphHRbchhBUjLAMnE94wlrC9ELxOrfgbm0SuRZ7pvcbl854vi6oE6DN0dk2Xby8ZJrrQjmvtgSD1sLMxIeziTUjmodv1WZMOoxA3YzvHRglaECHrYP29WyjyxIP1+O4P5OTWWc3ZHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715584280; c=relaxed/simple;
	bh=glRC5TjXjhhrxkAHmlNZMWpW9427EGBuCtEjLQxCZ34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFc739zrgyQW1pOZa27x/PtWdmL5wolRHTOtifdQNl3dCa6pLC0h2WznKgHSo8C6HjoCuT3KoYWSW0mU8BcUP1VD8Cjv/pbcHvhyaOLux+rTib+hs+FVrO6BzJbkvGz1XFR0qrARBp7pVFjOtxfbQT77qHGFDXdvsbwockmOePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C3511007;
	Mon, 13 May 2024 00:11:43 -0700 (PDT)
Received: from [10.57.65.102] (unknown [10.57.65.102])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F03F3F7A6;
	Mon, 13 May 2024 00:11:16 -0700 (PDT)
Message-ID: <39e15eef-f7fd-4e16-bc74-7f1c6820fe6a@arm.com>
Date: Mon, 13 May 2024 08:11:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] thermal: sysfs: Trigger zone temperature updates
 on sysfs reads
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <13518388.uLZWGnKmhe@kreacher> <3304112.44csPzL39Z@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3304112.44csPzL39Z@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 5/10/24 15:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reading the zone temperature via sysfs causes the driver callback to
> be invoked, but it does not cause the thermal zone object to be updated.
> 
> This is problematic if the zone temperature read via sysfs differs from
> the temperature value stored in the thermal zone object as it may cause
> the kernel and user space to act against each other in some cases.
> 
> For this reason, make temp_show() trigger a zone temperature update if
> the temperature returned by thermal_zone_get_temp() is different from
> the temperature value stored in the thermal zone object.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c  |    2 +-
>   drivers/thermal/thermal_sysfs.c |    3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -42,6 +42,9 @@ temp_show(struct device *dev, struct dev
>   	if (ret)
>   		return ret;
>   
> +	if (temperature != READ_ONCE(tz->temperature))
> +		thermal_zone_device_update(tz, THERMAL_EVENT_TEMP_SAMPLE);

That's a bit problematic because it will trigger
governor->manage()

In case of IPA governor we relay on constant polling
period. We estimate the past power usage and current
thermal budget, to derive the next period power budget
for devices. I don't know if the internal PID algorithm
will be resilient enough to compensate this asynchronous
trigger caused from user-space.

We choose the period to be at least 1 frame (e.g. ~16ms)
to have good avg usage of CPUs and GPU. TBH I don't know
what would happen if someone reads the temp after e.g. 1ms
of last IPA trigger, but some devices (e.g. GPU) wasn't
loaded in that last 1ms delta...
I'm a bit more relaxed about CPUs because we use utilization
signal from runqueues (like the TEO util gov). That's a moving
avg signal which should keep some history, like low-pass
filter, so information is more resilient in that case.

Could we think about that IPA constant period usage?
I think I understand the proposal of your patch.
We might add a filter inside IPA to ignore such async
triggers in the .manage() callback.
What do you think?

Regards,
Lukasz

