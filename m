Return-Path: <linux-pm+bounces-4436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DA3868CC1
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 10:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23140B220EA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E5137C20;
	Tue, 27 Feb 2024 09:58:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1D13699A;
	Tue, 27 Feb 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027886; cv=none; b=jE/KFdYjY/OcnipLgV87H+NViCZEXicRVVVhJduFgpr1a8EFMo2CBAG1wKeSwKNGinw87FhVeMYHKz4liEbrSltgASY6peqPfYTqj/gQCsFeJYSks/2FF49lBlTupv2J4hrEYtOabxAOtkqHLmZTBj4VT+KwI4PWodHTaaaRzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027886; c=relaxed/simple;
	bh=S024RKU4/uf+ZQYZb/1K/aCmcUdsqW1xY1/WsWufW5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2i0Id+s1UOsknc6G9mB13vWiuETNGXE3B+zprJlaRmTXBqnaabSyY6qEX/L2Sdf6HsqpyqWTPeJlB036SgJn4qv6WCLji9c4eernnZba10zpfBrbHBU9X0H5WxhUxXsmO926rbQvd3uQ2dfhhB/X19HsBK//YYah+4XlwCrjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1BF4DA7;
	Tue, 27 Feb 2024 01:58:42 -0800 (PST)
Received: from [10.57.10.173] (unknown [10.57.10.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C6AC3F762;
	Tue, 27 Feb 2024 01:58:02 -0800 (PST)
Message-ID: <260488a3-2e4b-43bd-a818-c15558e71077@arm.com>
Date: Tue, 27 Feb 2024 09:58:19 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>
Cc: rui.zhang@intel.com, keescook@chromium.org, gustavoars@kernel.org,
 morbo@google.com, justinstitt@google.com, stanislaw.gruszka@linux.intel.com,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, rafael@kernel.org,
 daniel.lezcano@linaro.org
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nathan,

On 2/27/24 00:54, Nathan Chancellor wrote:
> When booting a CONFIG_FORTIFY_SOURCE=y kernel compiled with a toolchain
> that supports __counted_by() (such as clang-18 and newer), there is a
> panic on boot:
> 
>    [    2.913770] memcpy: detected buffer overflow: 72 byte write of buffer size 0
>    [    2.920834] WARNING: CPU: 2 PID: 1 at lib/string_helpers.c:1027 __fortify_report+0x5c/0x74
>    ...
>    [    3.039208] Call trace:
>    [    3.041643]  __fortify_report+0x5c/0x74
>    [    3.045469]  __fortify_panic+0x18/0x20
>    [    3.049209]  thermal_zone_device_register_with_trips+0x4c8/0x4f8
> 
> This panic occurs because trips is counted by num_trips but num_trips is
> assigned after the call to memcpy(), so the fortify checks think the
> buffer size is zero because tz was allocated with kzalloc().

I don't know this tool (yet), but this description doesn't help to
understand it better.

In the memcpy() the 'num_trips' is used not 'tz->num_trips' and
'num_trips' is set in the function argument.

> 
> Move the num_trips assignment before the memcpy() to resolve the panic
> and ensure that the fortify checks work properly.

I don't see how this change can impact the code not this tool.

> 
> Fixes: 9b0a62758665 ("thermal: core: Store zone trips table in struct thermal_zone_device")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/thermal/thermal_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index bb21f78b4bfa..1eabc8ebe27d 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1354,8 +1354,8 @@ thermal_zone_device_register_with_trips(const char *type,
>   
>   	tz->device.class = thermal_class;
>   	tz->devdata = devdata;
> -	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>   	tz->num_trips = num_trips;
> +	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>   
>   	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>   	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> 
> ---
> base-commit: a85739c8c6894c3b9ff860e79e91db44cb59bd63
> change-id: 20240226-thermal-fix-fortify-panic-num_trips-5f94094fb963
> 
> Best regards,

Maybe it reports different issue. There is some corner case when the
num_trips is 0. It's called from
thermal_tripless_zone_device_register().
Does your code is triggered from that function?
(you've cut the call stack so I cannot see this there)

Regards,
Lukasz

