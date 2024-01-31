Return-Path: <linux-pm+bounces-3112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A88446FC
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 19:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597A6B28135
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66512FF73;
	Wed, 31 Jan 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D02yC2rh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007582893
	for <linux-pm@vger.kernel.org>; Wed, 31 Jan 2024 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725088; cv=none; b=b6rzxaTpPzDJl5zdG190EfkX+Pgw7jgZrzQFa34yMPOd3MtXwvKeFVaydIuPPisEnTqhChCMsqfMnwEGToYs3vlSpbQxZ+gHHo0n/uPGRYEZsZdi2LMVgiZsxeuJ3A9w6Ox8XsVR0kNDW7PpdsHMm2Sm3cbHDGFbwDdm3lKvQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725088; c=relaxed/simple;
	bh=kaOLPk5dCmKD9ZnSThmr1vOGiBwi5DSYGf4W5AFjRLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t15jVZdAHzIK8nosswB62qSGmFACG2mF+fesen1EFjNpng61nSDg6Htk0NlmMbUtHR3BF4ArBFjHnbzskcpPWU19S7g2Iq1x1c/Cg0FuX1dCu5ISiF0lTGzT26A5NvCkyaT/wKncjrlvW8Uc11+qcwRNbqdUeRMZWrX+FQRl4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D02yC2rh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so33398f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 31 Jan 2024 10:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706725085; x=1707329885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=up0hQI6RfyrehwFRWOV2KxREAmMAS+dnGD6ejeu2TbU=;
        b=D02yC2rh5jHrSXisGLZPIUiP/We1S4qBy46feGLFlshrKtbRgnbc30CtMF+MCtyGYt
         xkXdGf9Jn1BlCnrqR+YY6+EmGTHK+UB3/9kpQ1AlN5LgB471toUTV5DK5IDfKHzf8yA8
         NdoHGjGMRKLDe4MGyiKMXHVKOoLpooIDSWzmlA+Ebz6VE4qp0T6yRuvey9APbNK4DlDW
         PfLVlGLx/2E9QH9DeHyWmaqwf1xSttOTUaGLiWFZz3bWkIudhP37jp3Kl9OJfpJX54tz
         X+bq5AaGodR+3Q8QLzT1JKVeIXxDDZzEMTuucaEnT2HsEgxZMioYZSKxUphwMaxo19Xp
         xQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706725085; x=1707329885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=up0hQI6RfyrehwFRWOV2KxREAmMAS+dnGD6ejeu2TbU=;
        b=M7LK1WU5fYUN79Ym8bk3+Rt6HSLdEdTqFV1XNgC0GBHjPb6y7vZdkIJKprGObxgmnM
         b0BFqdNLrpwdCCBgR+rd8WEdQPBP/dF6A79pePyv3swCKovy0Mu59xQPstmWtLzU7j7o
         QqAmSZmsMlsCMtnvF9d/N31B0Ay0XVhEYAz6/mAACGB/89WwjAdRuhoNjepE6an8AhEq
         otllUCaCyte9kstR8GOYbvzG7pimdK2jhSixCGLVSab2YDg2h+zA+bui3F/fDn/xnFqH
         gX9Vr17ewFse63ZlM5GfDUg/7W/IHfFSVr0aOGDJ54yP4bsZWrtlBOkrXqb4MQXN2kxH
         plOA==
X-Gm-Message-State: AOJu0YxDTYCGKX4c5BuyaemDFbKV0+M4O89PzZfWMEFldkyUifRIvM2b
	CovEr7YYmQRdwwHcIZwtJZrQqsm2VmYrfhRKLjUfAyMyYzb0z6hTAJQAasEpGV8=
X-Google-Smtp-Source: AGHT+IEDTi71sT8xrY3tit5It/BiVtNnZlohlOBQOGscWYlyrl2TQeApeBUNchCsfLGvMibJrqnsXA==
X-Received: by 2002:adf:e9c6:0:b0:33a:f661:3d1a with SMTP id l6-20020adfe9c6000000b0033af6613d1amr1880289wrn.10.1706725085043;
        Wed, 31 Jan 2024 10:18:05 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m12-20020a056000008c00b0033af85fdf81sm5401894wrx.99.2024.01.31.10.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 10:18:04 -0800 (PST)
Message-ID: <7caf2f4d-d0d5-4622-b290-bb0396547f3c@linaro.org>
Date: Wed, 31 Jan 2024 19:18:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: sysfs: Make trip hysteresis writable along
 with trip temperature
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <4565526.LvFx2qVVIh@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4565526.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/01/2024 21:40, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Trip point temperature can be modified via sysfs if
> CONFIG_THERMAL_WRITABLE_TRIPS is enabled and the thermal
> zone creator requested that the given trip be writable
> in the writable trips mask passed to the registration
> function.
> 
> However, trip point hysteresis is treated differently - it is only
> writable if the thermal zone has a .set_trip_hyst() operation defined
> and neither CONFIG_THERMAL_WRITABLE_TRIPS, nor the writable trips mask
> supplied by the zone creator has any bearing on this.  That is
> inconsistent and confusing, and it generally does not meet user
> expectations.
> 
> For this reason, modify create_trip_attrs() to handle trip point
> hysteresis in the same way as trip point temperature, so they both
> are writable at the same time regardless of what trip point operations
> are defined for the thermal zone.
> 
> Link: https://lore.kernel.org/linux-pm/20240106191502.29126-1-quic_manafm@quicinc.com
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Notes:
> 
>   * I don't think that CONFIG_THERMAL_WRITABLE_TRIPS is very useful.
>     The only thing controlled by it is whether or not the writable trip
>     mask used during registration will have any effect and this is quite
>     confusing.  Some drivers select it for this reason which seems a bit
>     odd to me.
> 
>     Maybe it can be dropped after the patch below?

Actually it is used from an userspace daemon to get threshold crossing 
temperature which is then changed on the fly.

Instead of using multiple trip points, they use one where they change 
the temperature after it crossed the threshold.

Usually the userspace tracks slow sensor temperature in order to set a 
specific set of limitations given a scenario. We are talking here about 
Android and thermal engines which are platform specific. For example, 
lower the battery charging speed if there is a game profile.

 From my POV, the thermal framework has been hacked via 
CONFIG_THERMAL_WRITABLE_TRIPS from userspace to get these threshold 
notification and to be honest I find that not sane. This should fall in 
a thermal debug section defaulting to 'no'.

So in some ways in agree with you. We should drop it or make it more 
debug oriented in order to prevent it to go in production.

But before doing that, we should provide a mechanism to userspace to 
specify an 'userspace' trip point. However, it is more complex than what 
it looks because the userspace should be able to specify a group of 
temperature (and hysteresis) in order to be notified when the boundaries 
are crossed and those can be dynamic.

I will provide a proposal in a separate thread in order to not pollute 
the discussion of this one.

>   * IMO the writable trips mask itself is quite cumbersome and it would be
>     better to mark individual trips as writable in the trips table passed
>     during registration.  This would be less prone to mistakes and it
>     would allow the code to check whether or not the given trip should
>     be writable (root can change sysfs file modes after all).  If I'm not
>     mistaken, this change should not be very hard to make, although it may
>     take some time to switch over all of the relevant drivers from using
>     the mask.

+1 +1 +1

I don't think they are so many drivers using this mask. All the drivers 
tied with a OF initialization are not impacted as the change will be in 
one site.

> ---
>   drivers/thermal/thermal_sysfs.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -474,7 +474,8 @@ static int create_trip_attrs(struct ther
>   					tz->trip_hyst_attrs[indx].name;
>   		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
>   		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
> -		if (tz->ops->set_trip_hyst) {
> +		if (IS_ENABLED(v) &&

                              ^^^

s/v/CONFIG_THERMAL_WRITABLE_TRIPS/ ?

> +		    mask & (1 << indx)) {
>   			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
>   			tz->trip_hyst_attrs[indx].attr.store =
>   					trip_point_hyst_store;
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


