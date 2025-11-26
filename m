Return-Path: <linux-pm+bounces-38675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F66C88461
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 07:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F28B54E5A87
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 06:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD163168EB;
	Wed, 26 Nov 2025 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKYG8qG/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763D31194C
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138605; cv=none; b=V+2XzU9FIdeR2U6tqrFRAH/YtqI+UXniotgKJofUYnWQlOil/hQ5FWE9uO86OvLRfLzu0hmlnATG5/yVsZcU0igCQQiEtisMjoCVVt7taPBSXqS3z4r0qj2KUHJTe/LKvbE7rhOaN4BZgRaVe/8oy7rr/1t5RF2qMptA8s2HzcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138605; c=relaxed/simple;
	bh=/wjd1QQADD+VvXx2m8WSsx+iI5UDPDwTVdNw842v5D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acSdqm92hi/yPnu1YMdTY9jqMfboa2GnWr8rwvN7f9LklmUc6frgkWCDRtM8SYiX6MvdfKPgzM5y6UtnJ/k/P6n4rH1ldjWCr/QkGBBzI4yHTbhdKqH7G5RUo36piizb6Xa3v7BnbvHVuJPgw0xBFQe09JFha8goAnP/r239sk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zKYG8qG/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2953e415b27so75068995ad.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 22:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764138601; x=1764743401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zD6+XFAp9sqFYvJyvjSJCF0H2Fb6cirTRustZ2Fegs=;
        b=zKYG8qG/u9RH1rzGDcuCzq+hvnXjeqailBmNAtOMCj6fgavDO/Wcs2HL+oXeSERVgv
         jywGQATyY7IkugVInJ75gj6rZ7IfssfC236OSlnvQvdcvfwzdgEoUHqVmM1DGzukHH2V
         bEexOonugTJwukC/xcKUVPMOvJmEtBw1hSA425jX7Deh6YSRAhW6gywFUdr6++BvZyys
         Hf4XCCgL2geaNOvkZQJqlVuKs8X+DY9/M8tnXMsi1vO2I4nmOvpIKE7i5iTabWI2qwA/
         jnvRvibwNWvK4nbprKLHNCTR8S89haKn59YqdDSrhawAp9Cxfq8iko5uSxakGLDUi5uK
         1big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138601; x=1764743401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zD6+XFAp9sqFYvJyvjSJCF0H2Fb6cirTRustZ2Fegs=;
        b=J2b4yyQvCzu0kro3zkxAErUyfwqqxenmU0XQ59V3B9QPZG0j9m3zxJMRyX6kWNJeJj
         h5pbjsavXqVUHVfKAoy5n/ZHxUw2iaNDIRtvRk1bs4s3wEBHVEQB6FUsMJeasTibm5RY
         5pUlNtdPkOd+n3pCpTxtkZzuiJIDQBLa7r6CMKog9MJipjKXY+CbGKto8EPjRr/cRIFZ
         b/SmyNxkULh2KnvCe1oWFi+xtJiEGhahe0UGJ6x61G28UKbBWhB0x51kbYceK9FWDokm
         CcUzJNfH7wAZpl+gUXyJI3Hg4PwwEQ3StmPnO63m7sergGyWj+jUVSr/397EJstbNACv
         qzbg==
X-Forwarded-Encrypted: i=1; AJvYcCXj6G3c8U/p1+uem+S9HTeZJVP+olNxWzPhFja5H1tRDaOWYyRmJv8K90CmN2ZNbbqSU6//FrAxAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2rgeZqcmRa8oyIA21zrFKdaYbaF3xbspPKtvydJ+j7/blaSM
	Mgtx/52MB5jMgUOKgQaMYIKNLX/lGgzhVNdT5vVrhfr2Imkoqcf6dhksM0rOOEIzqHo=
X-Gm-Gg: ASbGncsV7E6z0D9H1Oaf/ak8d8hgfZKQHRMNDku9y2bfJYnA5vJuZ5mhiZRJ59OXt2a
	1uFV+2oKkjRQgx6+jeZWrZuLxr9aFKS25LGMgYEMRW5wDoLceuLW9YDtbdcswcpWUeBDtuQw4wO
	FGXEK2xjtKFgcQKLXpJUE5wm5ccMxVrAz/4Rm8sfEoKHn6itlD74LW5TmbS0ugUCCDxtrqZzY1U
	3yjKJFUxmI0rQ/pXkaJ+Pxr25ZBIDGat0ePbTpNO2CqLxwrk//4xIygQOS8373H7MTX9kc2gKQf
	ckir0qsEbeY0uQF3D4SR9PcNHS0kvDKDRVjjYEhT8oD395T2AS3pkdyukWqzBWx2AAHtgK+5qaY
	qe2s5rxdVgDbU2hO84j7cq2WAMvvEBtomVP+Wz79U5x+TLtwmpX4+0SN2BV1iLCOqGlQhXPytzp
	oN1CmDEaVOcVQ=
X-Google-Smtp-Source: AGHT+IHRPS2NROuo8IW1ZQUxs3UIsXPHF798aFl7UOMtC/ucWIkp9H9tKm2ZVKqwWeu6z9IkjceJ5A==
X-Received: by 2002:a17:903:15c3:b0:297:fc22:3a9f with SMTP id d9443c01a7336-29bab148c65mr62677015ad.38.1764138601333;
        Tue, 25 Nov 2025 22:30:01 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b12f988sm183053465ad.27.2025.11.25.22.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 22:30:00 -0800 (PST)
Date: Wed, 26 Nov 2025 11:59:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH] cpufreq: Return -EINVAL if no policy is boost supported
Message-ID: <wnnfdvp3r3bg5wztazoijei2uji5xypl4b4wlvlxuwxaizu6g7@2xxyrk7kdxhf>
References: <20251126031916.3641176-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126031916.3641176-1-zhenglifeng1@huawei.com>

On 26-11-25, 11:19, Lifeng Zheng wrote:
> In cpufreq_boost_trigger_state(), if all the policies are boost
> unsupported, policy_set_boost() will not be called and this function will
> return 0. But it is better to return an error to indicate that the platform
> doesn't support boost.

I am not sure if it is a good idea. If boost isn't supported by any policy then
the driver shouldn't enable it at all. Also, cpufreq_table_validate_and_sort()
sets boost supported only if at least one policy supports it.

We can still have this case where the policy that supports boost is offline, but
we shouldn't be returning error there and confuse userspace.

Having said that, there are a few things I would like to point.

> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e8d7544b77b8..2df714b24074 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2806,7 +2806,9 @@ static int cpufreq_boost_trigger_state(int state)
>  {
>  	struct cpufreq_policy *policy;
>  	unsigned long flags;
> -	int ret = 0;

In the current code, `ret` isn't required to be initialized to 0.

> +
> +	/* Return -EINVAL if no policy is boost supported. */
> +	int ret = -EINVAL;
>  
>  	/*
>  	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
> @@ -2824,14 +2826,12 @@ static int cpufreq_boost_trigger_state(int state)
>  
>  		ret = policy_set_boost(policy, state);
>  		if (ret)
> -			goto err_reset_state;
> +			break;
>  	}
>  	cpus_read_unlock();
>  
> -	return 0;
> -
> -err_reset_state:
> -	cpus_read_unlock();

It was a bad idea to mix two things in a single patch. You should have avoided
optimizing the use of cpus_read_unlock() in this patch.

> +	if (!ret)
> +		return 0;
>  
>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
>  	cpufreq_driver->boost_enabled = !state;
> -- 
> 2.33.0

-- 
viresh

