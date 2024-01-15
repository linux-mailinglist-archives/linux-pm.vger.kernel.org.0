Return-Path: <linux-pm+bounces-2220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A86582DE50
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 18:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C292846CE
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE5C17C73;
	Mon, 15 Jan 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szsKY+HQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3C17C6E
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e586a62f7so66692075e9.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705339024; x=1705943824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0P8zi1O1BsFyc/QcMbP4EfgnKZLLfc/05doi60umnc=;
        b=szsKY+HQBCg/IJtjKeKnS3qa+MQ6MrLYBxDw2ySZiyoaUyRATmMP7cxUlFhunBj5ix
         CMotryP/jo8zTgT5WHXUay9qfhribLxBicMTo7R8jCgJ6A0/eiMCayG3YXB1BX/7wQjc
         N295SSRowssYMff8UlbscVxsIKjBjUrgwMqof5xRBJSiHmyWpie8A6bW1ss7RN9LryQh
         KU8GGtdjtPmI62pd0JHElTe2cGCcvbl8MMVOVL4tWdu2NwdNkWuV8KHQbNeJOEud7P22
         5g4cOZIOQU9sIGR/MLYm4kLFGcUPu7V/zfNPA6ZsnQwM2QFFlt8XNTljTIkmjTstRYFu
         Johg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705339024; x=1705943824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0P8zi1O1BsFyc/QcMbP4EfgnKZLLfc/05doi60umnc=;
        b=DsAHQLRq+dliDnK1pGqmh1vtR3eApbX3r4jYABgSzVjxsWupSXHVku6uvSEJp69POx
         ov9jL2Qa3fWnY6bunFdBNV1dfcHk/s7VysdUQrQ1VAsELSigvjFmftv69da/AULHrAUH
         xFmZMeMuRZ/e5LFLVVfsootCA1ATTz+7z+Ql8b/7pxcDRNeRSeAuXlagnJiStpix+YX6
         Ued+PeMYtWoSG3VY+Jizz7niQTDGRO1KPKJHiMV4m9yz8SOZPAh0QMOWNVwplQ3GbIL4
         oXgeWIiTJogHsje/16ml2DnTdYSJSaoxKWtzNfNxeSFJ4iJsxJVb7z0ytt2ddcIa36AA
         bNdg==
X-Gm-Message-State: AOJu0YzVtIfmWaUFEplfKxCmkwiXhirTs8H5dI5/HfNE43sKPk34NS1a
	E+zBmhTK/d7Q5tJIbFCMMxdl5Ri0ol1yyQ==
X-Google-Smtp-Source: AGHT+IHfy/8kGwKw5ffOHy4HjEPFr4yjVRGg7ZTYNQhomagiR/zhQsqEQNRbNqYL/w5O68RAm+Nq0g==
X-Received: by 2002:a05:600c:4f53:b0:40e:4245:eb6f with SMTP id m19-20020a05600c4f5300b0040e4245eb6fmr3369428wmq.161.1705339023956;
        Mon, 15 Jan 2024 09:17:03 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:439d:3bc0:a764:73dc? ([2a05:6e02:1041:c10:439d:3bc0:a764:73dc])
        by smtp.googlemail.com with ESMTPSA id i17-20020a05600c355100b0040d5f466deesm16425627wmq.38.2024.01.15.09.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 09:17:03 -0800 (PST)
Message-ID: <415ca710-1b28-47e5-bffa-3f9f76c59041@linaro.org>
Date: Mon, 15 Jan 2024 18:17:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/26] thermal/of: Migrate to
 thermal_zone_device_register()
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
 <20231221124825.149141-3-angelogioacchino.delregno@collabora.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231221124825.149141-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/12/2023 13:48, AngeloGioacchino Del Regno wrote:
> The thermal API has a new thermal_zone_device_register() function which
> is deprecating the older thermal_zone_device_register_with_trips() and
> thermal_tripless_zone_device_register().
> 
> Migrate to the new thermal zone device registration function.

Sounds good to me.

May be add "No functional change intended" ?

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com > ---
>   drivers/thermal/thermal_of.c | 37 ++++++++++++++++--------------------
>   1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1e0655b63259..62a903ad649f 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -471,16 +471,12 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>   							    const struct thermal_zone_device_ops *ops)
>   {
>   	struct thermal_zone_device *tz;
> -	struct thermal_trip *trips;
> -	struct thermal_zone_params tzp = {};
> -	struct thermal_zone_device_ops *of_ops;
> +	struct thermal_zone_device_params tzdp;
>   	struct device_node *np;
> -	int delay, pdelay;
> -	int ntrips, mask;
>   	int ret;
>   
> -	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> -	if (!of_ops)
> +	tzdp.ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> +	if (!tzdp.ops)
>   		return ERR_PTR(-ENOMEM);
>   
>   	np = of_thermal_zone_find(sensor, id);
> @@ -490,30 +486,29 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>   		ret = PTR_ERR(np);
>   		goto out_kfree_of_ops;
>   	}
> +	tzdp.type = np->name;
>   
> -	trips = thermal_of_trips_init(np, &ntrips);
> -	if (IS_ERR(trips)) {
> +	tzdp.trips = thermal_of_trips_init(np, &tzdp.num_trips);
> +	if (IS_ERR(tzdp.trips)) {
>   		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
> -		ret = PTR_ERR(trips);
> +		ret = PTR_ERR(tzdp.trips);
>   		goto out_kfree_of_ops;
>   	}
>   
> -	ret = thermal_of_monitor_init(np, &delay, &pdelay);
> +	ret = thermal_of_monitor_init(np, &tzdp.polling_delay, &tzdp.passive_delay);
>   	if (ret) {
>   		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
>   		goto out_kfree_trips;
>   	}
>   
> -	thermal_of_parameters_init(np, &tzp);
> +	thermal_of_parameters_init(np, &tzdp.tzp);
>   
> -	of_ops->bind = thermal_of_bind;
> -	of_ops->unbind = thermal_of_unbind;
> +	tzdp.ops->bind = thermal_of_bind;
> +	tzdp.ops->unbind = thermal_of_unbind;
> +	tzdp.mask = GENMASK_ULL((tzdp.num_trips) - 1, 0);
> +	tzdp.devdata = data;
>   
> -	mask = GENMASK_ULL((ntrips) - 1, 0);
> -
> -	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
> -						     mask, data, of_ops, &tzp,
> -						     pdelay, delay);
> +	tz = thermal_zone_device_register(&tzdp);
>   	if (IS_ERR(tz)) {
>   		ret = PTR_ERR(tz);
>   		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
> @@ -531,9 +526,9 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>   	return tz;
>   
>   out_kfree_trips:
> -	kfree(trips);
> +	kfree(tzdp.trips);
>   out_kfree_of_ops:
> -	kfree(of_ops);
> +	kfree(tzdp.ops);
>   
>   	return ERR_PTR(ret);
>   }

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


