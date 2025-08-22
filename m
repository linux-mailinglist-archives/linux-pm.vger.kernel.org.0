Return-Path: <linux-pm+bounces-32892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370EDB31012
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 09:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA11B5C76FD
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616D72E62B7;
	Fri, 22 Aug 2025 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKnvPTdr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376119539F
	for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846999; cv=none; b=kf93pljjjwAJA7UNDydPEblsBOnHwEziujrsze5khT/mtWWqWHIglrANK/+FPfWinfDe108xUCuCpiHKsWpj7XP1umYjUb6ZYp3btOLIgvMhPatPVLiW4Qf0BlS9wgrvT5czjaSWjOAGa6en/6FcIsJ1bahYemd2irfUkU88XtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846999; c=relaxed/simple;
	bh=cDIzX2IA4iCvUt9uoFiM/dYZHQNcGBqjkXSrXhdyemw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTv52A/LKj691PF38w8JPzgeOx871k2cYmEdoWCpkp+rwtj4ppD0aeyaRyRqTvvds6+M+mkYCognXZxkXCfY+c1Xmp7Fq49rYAn4wfa2NraMDabDM2fjkvf8A4yaBYsOLC+gkDn78jC+nY6BedIgf2KxvOL6mIuBNmJq/URthRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FKnvPTdr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so1678021b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 00:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755846997; x=1756451797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ja7wvVZV81xXr8Zz3s/sGO5DAQWfSLxex83XaeAoBcA=;
        b=FKnvPTdrQ/HP7l/t98sdn0Rk7QbBzW1emUYpqs4k5fs+aMv82jWE/YCoGX/SPRwzGl
         fy4I5QKx48QOdDw5zYoJqudfIldbwu3c6nfvNW9FkzMdsBR7qoAdDcqgt410JRnQR+mi
         l5N7s6HPja/fgcT6GQzOU/lNrxDvGsBIB3Zi2jqkSdY3OJVH3wKgS0WqAaDMKJ/Wx0+f
         4IUWVdmKW84b24zMzAClVBWTtxji4nzvW61xnFoM0Ot6SYg+CWWbED5QB8kRSkGjtM5L
         Jw5rOd2ooWM2Z7suxG5xqH/WY9zJr3KPBWIygDZ6ii9lkU/H+0Tm5CEMu6iVYkqcbYUA
         Ftkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755846997; x=1756451797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ja7wvVZV81xXr8Zz3s/sGO5DAQWfSLxex83XaeAoBcA=;
        b=T3G5zkGvs99/y1cRK4aYPKcq1HbnwaceZjc9Q1bWVMGIQittKQtIM1WRpiSO5huepa
         L0ktfViUOPhT3Xrq8BE/lQp5VkD0wHN1kcwp/v3lfupf9OzXoZUjHSydFY68ugPYxNBf
         lWCcJRwtpQx89WZSyMwt5D0K7WjnOsyNDHwsyMz2QxLCf9k7KpvhT/1j7sRYvp69TkV7
         /KndOb/mFBlHPeaTH93l+8g4IDLAkoCrqpkPfcwAVxreXBzjLHOi/D9pFKLGzzD7E1jH
         wtNQ4+2+pl+LqT8P7m/6frwtVXpEykmDgERG4G9xIMSDBBfX+vuk5wh93dSsdwOsDiOx
         D9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdWQgLRs9p3/Uc0WdQ2jUB1en3ek040sWVXcRKjCtt6z6vhlz3Q0XZTsciikQiNRyGr59dyeTmwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya8Dz9DJMaUzd2S21Nw+TclPxJvsX8F0sHy6e5xmazzfbdYGbE
	OtzgVi6j2JzbNKhOmWRITFLdSYdlRch6L22lxZsakHZncw/EtEn9sFli1jtP+XiTPRA=
X-Gm-Gg: ASbGncuU58OniKHSJSZp2LskQkdZuEAqmvSa4f1tucP0axVJK9Wzrk+fyl8d6syEm/l
	ybdXvUyBngRbukFvQElykO9HugFWonyZldi7au4yE2oPumt6LI0ty1eck1wE4Iz28HzHtjTjqLy
	VBu7DowvJ8GoyTKVodhsORDot8bnUnmHOTF+Z26vy3H+HPZ/mRwowYypjWNK+ZYaBk7RXbz3RHX
	yrDaLE+3ZPSq4pQeR9L+a2W0A7wo+pHR40fnXmCDgur6OnEhyGlHsweo8pmoBfwFm4L75uXaNHL
	HzS54k+Oq65HuvWIFOSbEzKdqoPprSKdh6emMPxGjX5ZSyNBXx9NXFMlMtC+1UN/xdBY1heCkr+
	wxvDIA0hLf/sZMHtzdB0SPjUUuYVgOXiT4aw=
X-Google-Smtp-Source: AGHT+IGS7GxI+46a344dMZve29EjbWYSjTDmdGR6AlyUm74ISA0tlK6mXmcup9whsfYIjr+Qux5ILw==
X-Received: by 2002:a05:6a20:9188:b0:23f:f712:4103 with SMTP id adf61e73a8af0-2433028c04cmr8907124637.18.1755846996745;
        Fri, 22 Aug 2025 00:16:36 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640908e4sm6331466a12.26.2025.08.22.00.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:16:36 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:46:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cpufreq: simplify setpolicy/target check in
 driver verification
Message-ID: <20250822071634.r4hxnfy7ofgi33az@vireshk-i7>
References: <20250822070424.166795-1-zhangzihuan@kylinos.cn>
 <20250822070424.166795-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822070424.166795-3-zhangzihuan@kylinos.cn>

On 22-08-25, 15:04, Zihuan Zhang wrote:
> Cpufreq drivers are supposed to use either ->setpolicy or
> ->target/->target_index. This patch simplifies the existing check by
> collapsing it into a single boolean expression:
> 
>     (!!driver->setpolicy == (driver->target_index || driver->target))
> 
> This is a readability/maintainability cleanup and keeps the semantics
> unchanged.
> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a067b5447fe8..633be16297d6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2921,10 +2921,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  		return -EPROBE_DEFER;
>  
>  	if (!driver_data || !driver_data->verify || !driver_data->init ||
> -	    !(driver_data->setpolicy || driver_data->target_index ||
> -		    driver_data->target) ||
> -	     (driver_data->setpolicy && (driver_data->target_index ||
> -		    driver_data->target)) ||
> +	     (!!driver_data->setpolicy == (driver_data->target_index || driver_data->target)) ||
>  	     (!driver_data->get_intermediate != !driver_data->target_intermediate) ||
>  	     (!driver_data->online != !driver_data->offline) ||
>  		 (driver_data->adjust_perf && !driver_data->fast_switch))

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

