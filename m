Return-Path: <linux-pm+bounces-19106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9C89EDFEF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010702865D5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D4A2063D0;
	Thu, 12 Dec 2024 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySUzYznP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5612063C8
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987237; cv=none; b=Q55CpgCK+c2+vDlTr8RKs5N14DKJX1FMZ0yMxRs+XIGfRrCldmU+6VE3zXO0P/BzKNAENhppKtzSRmDRFIeWstSsZEAwRkqypBnRhtDJWR2p1qxmxi4Zo/o2J42xYI4bNG3On1XffnwMRMeP0IaEHrWjayWkD/e+DQ5ghX0n9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987237; c=relaxed/simple;
	bh=xFmBnyAttvMuOzVsTjQlhULu1cgriZXvVbXqOa49GL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb4KM2P5IXN06Mi7Blfn9r9hDHiriCPMc16apO4bc3/XGXrp63p87cOwDKQfPuklrV/BG78YF6hYKhqx6NoehKj+4N9fvuhSoOjoXC8epx3jPbUA9ILRmhaWWEC6HZxNjtACUehxRBM3K4iOSTaS0x6+Y3Z6LQdatIHT4je4xlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ySUzYznP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728f1525565so327627b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 23:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733987235; x=1734592035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gWUSTVMYq8BWWEAYYe37DF6F5cN3F7NwUno8STAUMA4=;
        b=ySUzYznP30RE94EN/ZXNY0aNU+SKblS60dGgXPZWYhGevHzhrMgSHHZUC7SefVL4xF
         t+H3/SAKBzFYy3zNKE4FCJl3hkwV/2wj/qa/BSymTy1RhESYCoDTGRago07DiV4P9Y29
         tENxUjcDECY8CFqgVsfD7CDSafP86DcMTW0xLmtQbrpYCdqXkN7PGU+5y9kfI89PlgTD
         9ZX1G6uLFcLNHYarXHv0SmCOk51LCjx4C300fF3dsSxdyRHvw3jkFQgJjlEFF+SXpZ68
         2cA2Ojxa1g46l7uO5f0CkxXdt/FwMzsUvetl74NwUTNOdYRb0y0wGx240AfjWovYrPoV
         0lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987235; x=1734592035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWUSTVMYq8BWWEAYYe37DF6F5cN3F7NwUno8STAUMA4=;
        b=j2ODmCGpA5+sY6ypSMvBhI7i5eZj4/AHhVtMtkq8JtIRYelJK74FdNwxfOfuHKdO78
         EB7CziPKHT+zyRj3Pn8XhdioYihtOPxqcdLc9Z5lZfd0zS32it/T+6coKyQzf5a/fpfD
         07GR2/9HAF6a4DKC2SUHF0VxIFNWUzUJFfpkzvUf0c+xtCniZpZ16qS8erC6Z2Mb7xtq
         kndebkqHNGzElOlGqKiDzh2q3hmTi12FvqVWIFn98U38MKcVZqXwttz22mVPsxjVcCMQ
         C0tRpbC23S4sdBWXV236IQLti80h1jwtqY27bfvfNxWRmYcf766Hk9DHA5FItpV1E3yu
         B4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8ak037ak4NkbF5YNbaohIdET0rLrVeSfpMSUTHD6lDFQiOFJp1cC8AqmmIA+a7t1AXdFFQHn6XA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvpk5QxBswaFmOL0YPktmhEkuF5B4VvZBnL267y0Yk73ndVrz5
	HLeQzvpavgwSRiFAqjzAc1XvTtqq3y5mS6rSW7z7ja01QtEcmns9EioGU8bvpYY=
X-Gm-Gg: ASbGncu6e8Ojf58x+ol4SzNeC/UHFV32vSS09S8l3rGsSQr7JMvvkYJQJBELd9NCgot
	hKG8Wrx59yRAQrBdOfq+JHGfUfj5KqsrvpT5OQaezi4bVEHH+Wiw3qoZoExDJLSZdWQl3UTdKf8
	qm3OKkgmkVafNkwMI3yHbj0LVk8YsaVY05MtgjntJIPi316kpcYpGE82/Q/uk5soCjeYRMM/qJp
	+dcSlp3Xg1iiJNaOOjVI9dd2AdZMDEKdmGriruBE4dekpqj1sksUJq6Kdg=
X-Google-Smtp-Source: AGHT+IENxoHonYKam4dKHihrFBZZ3t2m1GlwpQo36E6FIiGVq5NKmR5l1Fyzj203B0EBrt1cbsUdog==
X-Received: by 2002:a05:6a20:7289:b0:1e0:be48:177d with SMTP id adf61e73a8af0-1e1cea52e56mr3771734637.3.1733987234861;
        Wed, 11 Dec 2024 23:07:14 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d3dd4cbasm8926045b3a.142.2024.12.11.23.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:07:14 -0800 (PST)
Date: Thu, 12 Dec 2024 12:37:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: bschnei@gmail.com, Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Benjamin Schneider <ben@bens.haus>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Message-ID: <20241212070712.txkxgmiugzji3doz@vireshk-i7>
References: <20241125211452.14987-1-ben@bens.haus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125211452.14987-1-ben@bens.haus>

Marek,

On 25-11-24, 13:14, bschnei@gmail.com wrote:
> From: Benjamin Schneider <ben@bens.haus>
> 
> This frequency was disabled because of stability problems whose source could
> not be accurately identified[1]. After seven months of testing, the evidence
> points to an incorrectly configured bootloader as the source of the historical
> instability. Testing was performed on two A3720 devices with this frequency
> enabled and the ondemand policy in use. Marvell merged[2] changes to their
> bootloader source needed to address the stability issue. This driver should
> expose this frequency option to users.
> 
> [1] https://github.com/torvalds/linux/commit/484f2b7c61b9ae58cc00c5127bcbcd9177af8dfe
> [2] https://github.com/MarvellEmbeddedProcessors/mv-ddr-marvell/pull/44
> 
> Signed-off-by: Benjamin Schneider <ben@bens.haus>
> Reviewed-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index bea41ccabf1f..f28a4435fba7 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -102,11 +102,7 @@ struct armada_37xx_dvfs {
>  };
>  
>  static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
> -	/*
> -	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
> -	 * unstable because we do not know how to configure it properly.
> -	 */
> -	/* {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} }, */
> +	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
>  	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
>  	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
>  	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} },

Any inputs on this before I apply it ?

-- 
viresh

