Return-Path: <linux-pm+bounces-16608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F31E9B3794
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 18:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA19B25DE9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9A1DF24C;
	Mon, 28 Oct 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxdbG03T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4131DD533
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136191; cv=none; b=gvZvuKD/Bp3aWHctagMO95FN/pboZm1RJF07I5Sc2HJT5NXxA5iU52tvkolMqqsdfwxlZFyFRcFFP7B+56UuvaG4Z99Mmy2h+AQj03YnSxpxlb0lnt8+Lanv+qN5oZdpLmdLOrphLiPWkHeEe1Zisz62rCEWgTiav1nb4GPmbjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136191; c=relaxed/simple;
	bh=G2mTSswFEWYkILldBcg5OYa+c6e0QamYdkHkX6bphrc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GGLsSB9Rjo0zRi9Wcn16fxBjtTp9wf4LGAUWBwguALKwQmvTKoH088XV1dvtsTzDu2jxp3E1Hr3bbaF6zOQQlk3VK0B7gH3tKh8iPNpvwwRSfooVIJcYXHZWk/zi0ThaVseD2t6+ZBP42mzHcLsaFjKL2Mod/cwWQN4TBOQX4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LxdbG03T; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539983beb19so5461611e87.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730136187; x=1730740987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lZu8xvjHxZba+3eh7yj1gxmmXMRVMkdDPiFN2ynDSGo=;
        b=LxdbG03T/eo6ZzFIqV97VakJapvzI5ZYWY0d/oaANSA13SuCeyQL2hwMoCgoSxH+Ja
         yjjJkTE9/i9KJ1RwHqkgpiwYg9LlpilqLAEE5zA7jeD+8t2uLXAjri3D+YfZOkIOIjVc
         6sy0qiG6EKs9zkFloTau/vPoSHv0ob/SQwHzHu4F8t4MoKDM4KK/4SV/5TAH2Kr3eP0v
         zUsg9C0HlCSJcApqh0dcNVo/59N2r0/OUFRKV5ZVyXSV3cSUyfJIRTAPHc0SIxhC8VYT
         fNtYrV/9joe2n2TudCRnknI+oS9NLa7aKn7egJMVB93+xSXoKRvGBGZhUwNVRwm0Kkzl
         MFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730136187; x=1730740987;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZu8xvjHxZba+3eh7yj1gxmmXMRVMkdDPiFN2ynDSGo=;
        b=JHCEdtyTVhrNPbAvvGWm1iuuE6beP3JKAH1pXQNs221wY9hXQD/jrxcIq8PuvTfqCY
         DKV/rtZXV/HGV+/ahfzIhhH+eb7tOxcooIFJLh3u5XQU36QIMFNCJtz3PITnZRb1NzI/
         jkUDOo4aNBWiZq9aOX5abqoLqy1tqY0DYNePAnl0a5XF5UtQTazi/OvdGhdecWOm7GwC
         tZsA7e7hT8yvlrv2AP7/AedsOj4396ssBoGQsVb0EJScYr/PATlmSHiKFCXocwhg3CGb
         CszIlBpnsSTtnuNJW+zeeicNEG6ChuaUts4zA8l7tdx7RDKWdvF/WQPXsKJfrJqQIiWk
         uQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/o1CFtR7yUSMSnFkoAakGKAFuIEMxoA/9ty42uTL4lL85zU3Qt3T5iUqb/1YI3fL31+e08IMx8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5vIYm0Z2w2d31C90rz7KTpBr6I606YqqUFU0KYs84vG0EAav
	MoYSxcC/F0C9LPX15yASGnnmeGIBn6nBO3wnbaC0U5yM6l0EV+NPhgfagfYgh9w=
X-Google-Smtp-Source: AGHT+IHgK/eV4on9k8mtCyUHrPvuiJUh7pQDUSq/q4wEJPNA22QGtkqRpLmwAMr6fW897v1uNQTfNg==
X-Received: by 2002:a05:6512:3087:b0:539:dc87:fd3a with SMTP id 2adb3069b0e04-53b348b508cmr3989900e87.6.1730136187288;
        Mon, 28 Oct 2024 10:23:07 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43193573cedsm120692905e9.4.2024.10.28.10.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 10:23:06 -0700 (PDT)
Message-ID: <be7ad677-f7e3-4eab-8b7e-1c375eed3ef7@linaro.org>
Date: Mon, 28 Oct 2024 18:23:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/of: support thermal zones w/o trips subnode
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wenst@chromium.org, rafael@kernel.org
Cc: Icenowy Zheng <uwu@icenowy.me>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>
References: <20241018073139.1268995-1-wenst@chromium.org>
 <20241028171901.2484882-1-daniel.lezcano@linaro.org>
Content-Language: en-US
In-Reply-To: <20241028171901.2484882-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/10/2024 18:19, Daniel Lezcano wrote:
> From: Icenowy Zheng <uwu@icenowy.me>
> 
> Although the current device tree binding of thermal zones require the
> trips subnode, the binding in kernel v5.15 does not require it, and many
> device trees shipped with the kernel, for example,
> allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64, still
> comply to the old binding and contain no trips subnode.
> 
> Allow the code to successfully register thermal zones w/o trips subnode
> for DT binding compatibility now.
> 
> Furtherly, the inconsistency between DTs and bindings should be resolved
> by either adding empty trips subnode or dropping the trips subnode
> requirement.
> 
> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> [wenst@chromium.org: Reworked logic and kernel log messages]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> Link: https://lore.kernel.org/r/20241018073139.1268995-1-wenst@chromium.org
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

In order to fix a conflict when merging this patch I did the following 
changes. Let me know if you [dis]agree with the changes

This change will go through the 'fixes' branch, so for v6.12

Thanks

> ---
>   drivers/thermal/thermal_of.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index a4caf7899f8e..07e09897165f 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -99,18 +99,15 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
>   	struct device_node *trips;
>   	int ret, count;
>   
> +	*ntrips = 0;
> +	
>   	trips = of_get_child_by_name(np, "trips");
> -	if (!trips) {
> -		pr_err("Failed to find 'trips' node\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> +	if (!trips)
> +		return NULL;
>   
>   	count = of_get_child_count(trips);
> -	if (!count) {
> -		pr_err("No trip point defined\n");
> -		ret = -EINVAL;
> -		goto out_of_node_put;
> -	}
> +	if (!count)
> +		return NULL;
>   
>   	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
>   	if (!tt) {
> @@ -133,7 +130,6 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
>   
>   out_kfree:
>   	kfree(tt);
> -	*ntrips = 0;
>   out_of_node_put:
>   	of_node_put(trips);
>   
> @@ -401,11 +397,14 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>   
>   	trips = thermal_of_trips_init(np, &ntrips);
>   	if (IS_ERR(trips)) {
> -		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
> +		pr_err("Failed to parse trip points for %pOFn id=%d\n", sensor, id);
>   		ret = PTR_ERR(trips);
>   		goto out_of_node_put;
>   	}
>   
> +	if (!trips)
> +		pr_info("No trip points found for %pOFn id=%d\n", sensor, id);
> +
>   	ret = thermal_of_monitor_init(np, &delay, &pdelay);
>   	if (ret) {
>   		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

