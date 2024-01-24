Return-Path: <linux-pm+bounces-2643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0434583A19A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 06:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982351F23FFC
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 05:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF403D308;
	Wed, 24 Jan 2024 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQUPI0Gy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45878FBEE
	for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075784; cv=none; b=mb1c3cmuwB1TY8/5zWSTCIf/t0ir9LhhiIiKYpsGWN/1JW0o9nE8ol6UI0mVKNmPDn6Pi0SGuntPOkXQI+iRyEk+NuygzOJDsHBHGPBmRwPAawrHFCNysknVWSBRIo+HnTkE71yk/PyWuqGmRKsMJgnMmERGJNJVsPg8KE449ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075784; c=relaxed/simple;
	bh=3n6qbepBC/quy189WMpUt5s0sJ7FlfcHVamtdO7egM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIRqxsizWD53iyFtGtqVW6fDNzikhhbERWwNhNKpTbJrTw0vA8JQRj0MfYI8rzJ4nGokPZW9Uphju3vOI+Wi2xj1yC+Rfn8cGCO7bgABQPlPQ4DB3YzaVsVXuxgEcBxVNZ7YkNN2chyT3XziXeKL8fvnqzC3sBZxwUIjnSnlSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CQUPI0Gy; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd7c5b2439so2970920b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 21:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706075782; x=1706680582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7SahGLtspE/3Wi9Cd+JOw7KlfpX4OF2RIxiyIP7SV0=;
        b=CQUPI0Gyf7iMVcA10t0J6r04j6YDF4Q6PiMRKcRAEg+WVj6KxdR5iSjMSH9izVJw1I
         eWEctJIUL9aPKNRO8yJ0lyN7bSV/jDY1WG9r8EcyShbbGJe/c5xN79ViXN+JORHMajDY
         3lVFKRVel0lAAFxssdot+ARQPurXeBX6M9tre1yECT9ZrE3S4aN4izbkIobsxqrD+gB2
         PqqDggyVIjCgWAll2xtReuBmYA/XAr4VvzisMbLenDYR0AcUbxsn+W6KD51fBPCjDLml
         IzviHy1wIPcxQkBILW8Wy4+qLFo6TwfpiR4yy3p0elIznif5BQuoB2TOGUB6aIO6pp1h
         gYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706075782; x=1706680582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7SahGLtspE/3Wi9Cd+JOw7KlfpX4OF2RIxiyIP7SV0=;
        b=V+YewejaEM+0g2PBNOhXhYwsgQmFWmIWhAB+SlYUn8z0IDPt6nNSmdH7eSzppF5rML
         85mT/zqitpwRjj0JYNN9ayRdnn9WL7IUaflBoVpsusDh932qDUTWAyCa9uq/j21e26ZE
         wsaSXoym89NwNkEKJAuaO37CUxrRjBX0bd96uuGUz7ABBIjSkySSZbDmjuwzh/sqWiUJ
         gKIWwrScS1ZcxYSSE19ullM0UaSaU1xAFJxK0zaNiDBYGrYjuJ+aoBQP5aonO+uxPoAW
         Cf8rzb5GlfQBaEc7yoyPHO3Gvpu+f+cztI5xZsnkZqlKDQ8gdZU9hBhSvxQhD4Vi6UyH
         J0eA==
X-Gm-Message-State: AOJu0YyH7giJPLfsWcseajqOUqYDYeM60hAQvp8vzN1+J2BBgEKHnA7T
	hXv/iWaivMg7/jFNgKEiN71S3S7N1YAdPTpCjACCnM4G/i99gHgpoVSp4An0+1c=
X-Google-Smtp-Source: AGHT+IGiCI/sj/mAtB23fTMLULvqgI87+dSZUJXZCXN7hV/stz02CWQa7d9iE2R5I1NHRIlUItj1Gw==
X-Received: by 2002:a05:6808:10c2:b0:3bd:a6ea:1c6c with SMTP id s2-20020a05680810c200b003bda6ea1c6cmr1180274ois.116.1706075782222;
        Tue, 23 Jan 2024 21:56:22 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id ko18-20020a056a00461200b006dab0d72cd0sm12721062pfb.214.2024.01.23.21.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 21:56:20 -0800 (PST)
Date: Wed, 24 Jan 2024 11:26:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/6] cpufreq: do not open-code of_phandle_args_equal()
Message-ID: <20240124055618.5xppexdpvwnv6zng@vireshk-i7>
References: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
 <20240123141311.220505-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123141311.220505-3-krzysztof.kozlowski@linaro.org>

On 23-01-24, 15:13, Krzysztof Kozlowski wrote:
> Use newly added of_phandle_args_equal() helper to compare two
> of_phandle_args.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on previous of change.
> ---
>  include/linux/cpufreq.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index afda5f24d3dd..3cd06dafb04b 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1149,8 +1149,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
>  		if (ret < 0)
>  			continue;
>  
> -		if (pargs->np == args.np && pargs->args_count == args.args_count &&
> -		    !memcmp(pargs->args, args.args, sizeof(args.args[0]) * args.args_count))
> +		if (of_phandle_args_equal(pargs, &args))
>  			cpumask_set_cpu(cpu, cpumask);
>  
>  		of_node_put(args.np);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

