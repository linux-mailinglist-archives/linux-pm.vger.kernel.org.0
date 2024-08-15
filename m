Return-Path: <linux-pm+bounces-12247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE689528AC
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 06:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66C91F22125
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 04:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B4E38FB0;
	Thu, 15 Aug 2024 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kfn70V6a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4B1D52B
	for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2024 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697504; cv=none; b=hPfqbyOths16VriMxHe/Kdf8bt/VLI0zVlMkDymV8KwoYYmMOcUZUp15nSQ5JVrWIYJ5KnYFdZNdxRJtXbMOCcYOmSjCOfUeeR5nBzqeXP/xjm/0LstrL9PlwXYDJSbTh/C42HxeqPjnS4p+dQKP9ZCFC5v4eCMvS7oZoJYJnyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697504; c=relaxed/simple;
	bh=V9J1hqSeAM1u4VzGrzJXK3XEgn8eyuz0Z/63I3EL9qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdAmCCbBh0Z60qnY6kiSwM2m2Dxd426fmZcdV+QzjzmVSCFAig2nTR6N+mJyXdEE2zaH7DLC0k0b9zbIE/tZG+PJfV9hH5+rSRYSt0Wg50SseBpESxCorqvBhIbkIcAqakaKLP37zZCN8UqIbz0b2eNBeF8Ezl+H7ZkS1L/TNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kfn70V6a; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d2ae44790so419019b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723697502; x=1724302302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=esFrtuAz8x9I8JvdWdXAWlvXnn5gUAd11tQoYzNfoFY=;
        b=Kfn70V6aCVSyYcxyg1netF8LdN5WNUTd53LoXxuy5vkXWw2ri/628HEq7fxdIF1etm
         GxaYv0Jf22mMNBFzU3i3fP2ecpu99r5n/7eISKctDwKODLqUlQfhCFC4FnQFpnZcflGA
         o/XN4eC8cEu28aKaa+5m5/yFzUBO66QmgZX4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723697502; x=1724302302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esFrtuAz8x9I8JvdWdXAWlvXnn5gUAd11tQoYzNfoFY=;
        b=AkQ158ieEsmV8bCin+RMxvK3M4ogqmgrXMKbtI8UJaGvRvqmF0I7W+ZSL57ef90Z96
         2G0yusLw7yia42I33odSoczZTEnwmlj8XLl4KoC3tLKgnAJp7I4VbB8IyD7b+F4ouWUo
         7X16exDlCjhSp0YEE817dRzX+lbNZU6vRRFA1myRi5ox8zX1Eu7sjVCRS3hJu2w8rTSk
         iFvFLsIaPEKvAJHehJr+uzRlUCVHjC6kE00dpXRxLMrVO8SvxcE5HPpwKrMNFGpqTt2S
         4QxzBPQ9tdSvpFUfmCJfd5wsHjuI6+fJ9U5326zXIC31FMzVRogfjfI8ABxWhRsHQCb9
         1OKA==
X-Forwarded-Encrypted: i=1; AJvYcCU+y/U4LXaguHrKCCZ+kvFjvv92cAlIWb5zzpibJOXjjzA8wx4ZmZuX2euFWqTGozjkhjfeUsVSD23QGXozvCXoPHxSskrf2fg=
X-Gm-Message-State: AOJu0YynrwVr4YjDz3i3/h9EUlkqtkqEgxBvtl+jzABA/S/FwDi7R6Ac
	AHw2farlfs0Rh1oWCDbB+97ggrSRGdv97JykqcOOhpwaWbo3rLDOszUZZ0/tsiJF3mIP7gzVgDs
	=
X-Google-Smtp-Source: AGHT+IFhn1T59lc7dVMy6t5Owv7QMmyjQEuoPEHy63kv9un5RYdvTZ4WmVcLves/I6IXbjYbMSRXIg==
X-Received: by 2002:a05:6a20:d527:b0:1c6:91e1:f0fc with SMTP id adf61e73a8af0-1c8eafa9afbmr5818320637.48.1723697502257;
        Wed, 14 Aug 2024 21:51:42 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:745d:58f7:b3cd:901f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3c863a671sm523893a91.2.2024.08.14.21.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 21:51:41 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:51:38 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/3] thermal: of: Fix OF node leak in
 thermal_of_zone_register()
Message-ID: <20240815045138.GB255011@google.com>
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <20240814195823.437597-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814195823.437597-2-krzysztof.kozlowski@linaro.org>

On Wed, Aug 14, 2024 at 09:58:22PM +0200, Krzysztof Kozlowski wrote:
> thermal_of_zone_register() calls of_thermal_zone_find() which will
> iterate over OF nodes with for_each_available_child_of_node() to find
> matching thermal zone node.  When it finds such, it exits the loop and
> returns the node.  Prematurely ending for_each_available_child_of_node()
> loops requires dropping OF node reference, thus success of
> of_thermal_zone_find() means that caller must drop the reference.
> 
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/thermal/thermal_of.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 30f8d6e70484..b08a9b64718d 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -491,7 +491,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>  	trips = thermal_of_trips_init(np, &ntrips);
>  	if (IS_ERR(trips)) {
>  		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
> -		return ERR_CAST(trips);
> +		ret = PTR_ERR(trips);
> +		goto out_of_node_put;
>  	}
>  
>  	ret = thermal_of_monitor_init(np, &delay, &pdelay);
> @@ -519,6 +520,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>  		goto out_kfree_trips;
>  	}
>  
> +	of_node_put(np);
>  	kfree(trips);
>  
>  	ret = thermal_zone_device_enable(tz);
> @@ -533,6 +535,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>  
>  out_kfree_trips:
>  	kfree(trips);
> +out_of_node_put:
> +	of_node_put(np);
>  
>  	return ERR_PTR(ret);
>  }
> -- 
> 2.43.0
> 

