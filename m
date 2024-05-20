Return-Path: <linux-pm+bounces-7984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E25A8C9994
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 09:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197A528193E
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD81A1C286;
	Mon, 20 May 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJb2g5eB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9718E1F
	for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716191764; cv=none; b=l8rnSRJwynWuWeXu9masiaSRKEmv+9pTNf/58prvONUpcaQjtUClD7UHcYvE19Be8bDXxTkAGotUrFzsJ9jbZq3Sa2QjvZHglxalgoU1Yh4w2c4q4NwLLYmo5zojcknmUgvbIbDxGr70NC0nsu57RR2VFlgYteOrRDn3KHcl4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716191764; c=relaxed/simple;
	bh=NzbThhFBtnQcvtXqqCfxwQoatoZOjMc4GUjlMRM+wAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGls08FmrRily47zAWLMvC7LabLKawMfEfvORwnW0t92Lf9kqeFClF91QsXMtZI1/Fa8xjzUFOJGM56glJQipKGhlHTglb4g7WOqWaFz0If4KVAqDGihANawaqM8g9xpXueGUqLjNeY7SH/ebMb3s8HPtPTScEUza5FK4de8lA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SJb2g5eB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f0537e39b3so64354205ad.3
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716191761; x=1716796561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb5X/YYmza7mi0laloABn7ifgNcKsYXBPYlhNhqZXcg=;
        b=SJb2g5eBrNpoTNrv+XzbWRJbrKglYIvosQJrmdD4cxEdVvlVQQu7EFSBNtNm6Qlvoh
         fE7xmAsx8NpcOxSApm2fXaMySSxCWCWNyVm8OMluluecOcMy0aDr1tOTS+MpkLEgWUYZ
         0JkH9Dj4j1Km1tprE+yGIjby73Q1smApiLEd+Rjjy4BhI+TsV5iRR0mTwZ4MccwB23uO
         6Wde6ulCrR/TGb/2IlrC3sIdbyR7tAEJop+c5PHnhbMB5cB2y4Dq5i/4lqbRIkNyNcBV
         7qcqeyEGrtFovjOZgb1xXaNl5+3kXQqxuWPs61xL5bj/jxXgP6t86f7dCMQLWwsPKa0s
         tidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716191761; x=1716796561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb5X/YYmza7mi0laloABn7ifgNcKsYXBPYlhNhqZXcg=;
        b=GwEG9sAJqP32vL0Ipnai4EEbfyks7Dmt2YgWDIsfWcAmSjKp8Dmh6yYuzr4FlxMBth
         8yDmfuYgmLywZ42RGzKPf+zaqbc03blBVT/6k82sqPxSZb2GULW7GzXsISuUwuGwJV6r
         KzU5SyF4pOWZxadnSo/I+AxRvfOy1a44F2+Uv4kvcaPO+TFyJh/qMC+tgofiGUDYv9ci
         nTgVmGaieE3jKbQCewdrwkIelamN43ZQ1uG/DlMJFUo3qbFWET9y0RKeJjmwZX1QKa1M
         JTCBTBSD5Risu6LExaTXU0xYdfWpOgFLYKLzHZLHgWNXl+eTYfyOo3ffA7ttILhN5UVk
         y6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM8ehXMis1juCex0fNQ6NxeOx5RVNrwUoKzPJR9nPdnjxf8yv0BueICWRJL5SS/mhPf/wspjjiHxkH8tOhmthFzHb792Ixbqw=
X-Gm-Message-State: AOJu0YyzMXox9kxWGlGZtTOSEjkYRm10TJu7E81aL+ZPdvXNpPtrYS2m
	A0tvVY3TbE5gWyg0KehuWRJJF/PCH7Pe9ey4LsJPp/DwaQIXpMHL5CngV4Qwfgs=
X-Google-Smtp-Source: AGHT+IEj5fXNVm5Sr5l+LzOeMhTgwOtdJ0S4mFL1Q0mrihvqNpsrmaA4uGWDRNmFdeyo7AgBJ9hHSQ==
X-Received: by 2002:a17:902:c94a:b0:1f0:958c:7cfe with SMTP id d9443c01a7336-1f0958c7d91mr152807055ad.67.1716191761568;
        Mon, 20 May 2024 00:56:01 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d164dsm196268075ad.52.2024.05.20.00.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:56:00 -0700 (PDT)
Date: Mon, 20 May 2024 13:25:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: chizhiling@163.com
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] cpufreq: add a check for unsupported CPU frequencies
Message-ID: <20240520075558.ytbeguk7v2mt7p4p@vireshk-i7>
References: <20240515022037.818078-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515022037.818078-1-chizhiling@163.com>

On 15-05-24, 10:20, chizhiling@163.com wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> When user wants to control the CPU frequency on their own,
> if they write an unsupported frequency to the
> scaling_min_freq/scaling_max_freq node, the execution will not report an
> error, which will make the user think that the execution is successful.
> 
> So, this patch add a check to return an error if an unsupported frequency
> is written.
> 
> Testing:
> CPU supported frequency [min, max] = [800000, 4600000]
> 
> before patch:
> root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
> root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
> root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> root:
> 
> after patch:
> root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
> -bash: echo: Invalid argument
> root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
> -bash: echo: Invalid argument
> root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> -bash: echo: Invalid argument
> root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> -bash: echo: Invalid argument
> root:
> 
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>  drivers/cpufreq/freq_table.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 10e80d912b8d..416826d582a4 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -76,6 +76,11 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
>  	pr_debug("request for verification of policy (%u - %u kHz) for cpu %u\n",
>  					policy->min, policy->max, policy->cpu);
>  
> +	if (policy->min > policy->max ||
> +	    policy->max > policy->cpuinfo.max_freq ||
> +	    policy->min < policy->cpuinfo.min_freq)
> +		return -EINVAL;
> +

I think the current behavior (of not reporting errors) is what we
really wanted and that's why it is written that way. The kernel
doesn't want to enforce any min/max that the user can set, the kernel
will just get it in line with the current hardware limits.

For example consider this case for a platform with following frequency
range, 1 ghz, 1.1 ghz, 1.2 ghz, 1.3 ghz (boost only).

Lets say boost is disabled, at this point cpuinfo.max_freq is 1.2 ghz.
The user does this:

root: echo 1300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

With your change this will fail, but we really want to record this
into policy->max. As the user can enable the boost frequency now,
which will make cpuinfo.max_freq to 1.3 ghz and user isn't required to
set scaling_max_freq again.

-- 
viresh

