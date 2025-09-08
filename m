Return-Path: <linux-pm+bounces-34128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5182B484AC
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 09:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1C3189FCC3
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 07:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D81E1F1932;
	Mon,  8 Sep 2025 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2T9GIiZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9E156C40
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314968; cv=none; b=G3UVnHgLlwienggAO/l4zpxwfC4nOoNBiECFiO0L9tkbVGEm6bC8IaClNVrKfmxePUKd9QD2IXIX2Gk3jAMfDReUCD6d8ZjI4OZE6j+owWSbL/D0TDWQTqBXsl1b5j7y4RYEpte2FtQdqtsed8EBjqVxh/80cuj2yYraSZDcthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314968; c=relaxed/simple;
	bh=E0jbUfmV9lr93Z6RZKKJaTm2UNGNxs+fvgBaCyBYcfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuDJhVKPTTE4kEFYao13IinElryRvRdryasPGjQSDC10u6bFHIGF/Pokw+ds1Pex1LDXul20dr7vlvcSqInVh7nVY80wvS9+4ewhsw49BuYsOgexcdlbtPsf2kUMmmIke75tKiGpXBTRTXSKJyq0qhs8OrPFewpPDQkmtVj4gV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2T9GIiZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24456ce0b96so42359845ad.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 00:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757314966; x=1757919766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YIdgsTjHelFGX6SLfq2jF+8fELNmRHVOFCo/yud9m4=;
        b=v2T9GIiZJ8fzsWuWV0WqAMWNuJnoaWui5yCrP74qXtkRKx9f1LNQBr+beCaTQErb/3
         PuunNamPP6tz2Bmcy0zWdS8kxsEMpV63DmtI63Qxuq8UPvrJGYQcgrb0I9EB78+qfiOG
         mrzc12gRns2kWkrQA5TqRb9EmXgZGNCCLvP1Og/Ojn8oa1fPCKsPiq37JAhZOsGT02Uo
         Oz1UeqX/kJexSN/X3pFMDV9rBA0NAY3l3gYdbYDLLi8HnqFJRqJKM41WlOthzGfbKOZy
         jtZa7Lr1mgZiJiFrRPaQp7rNOaxCcxu9hOEDXYP992O/Dqhnq/2teb4RJGQC492vmlo5
         u4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757314966; x=1757919766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YIdgsTjHelFGX6SLfq2jF+8fELNmRHVOFCo/yud9m4=;
        b=TeqXmhlCAT583zeTl7KVQmCEzLg2v3IHd/IDywtcerDJmacwCaLOe296AMK7Gxfmzc
         UFzvb+w8HERWpxfj3bAmInOkhYvfo8HDqXLvbdu/DVvvqpizC10QmAeI9hyIcbUCw4so
         Y4idpBTkYYYfVfJq97L+86nna7rpqFrjz1yRCBAgV1OfQIdrYcr+BL70MN7NzMujRnbF
         1GSLbSRumBOCl+QWhT+GXMpXGvr1tsX32ch/mHwuheqMPZQpOP1YlNoRANbRTR3lQazW
         ARyft2emAbuocpD21RRPZfKeO+H9YV17dVJsG5iwQ3OP9qvkxa/D7eczE2NUOnLxP2rO
         tndg==
X-Forwarded-Encrypted: i=1; AJvYcCUPYzaUBsb1QcUmZ53P6o2HeowruVQjnOzIzSFpG+O3qXinbU+2w/EGmT8HcmLnFugPx+swTIU35A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/DGEoQwNhtGnXYGj2qknadVYom3+RlzXEzji4lO4kyxluad2
	Q5U9ki1TVRsGzSoaGWAfH7+NpylVVWOjr/WvjQuM8PYhb0pMQIoj0wuq+hHsLJLm2yo=
X-Gm-Gg: ASbGnctDYeqG9qRXOitvyOmYO/ktXhQs7hhR6HNhGEIPjaGfT5+WmRQ2jmp/G9Ju1+p
	ettnybSB9niJWl9y2BLectuar+DODNCadDSe/1yXDH3t1SSy7Cb1yPoIvgCCmOvoppGW3I29Eae
	rt+vEqFyS5O+vziRYtt7e+gd4oGba9kuoKFGwo+r+jZLLV7E7j6dGKzcxcNj7V8eO7ZAF2EHeCd
	fwlGunxCZXK0Yb2cYOQ39zVnRnzaxzDJ4+4WXss2CSZ2HHbnBhdEeCFjBr3aFfWgx58mZf9bm0W
	QVD1rm3QVyZlcNaVqYlAzVDACQhX069hj6g8oXK1/9WsVlaI8TCu1XHk04eRS9bYxdIvb1pPl5C
	dOXKbatf2+81NkoM5k9k3gpU/
X-Google-Smtp-Source: AGHT+IF4FQs9VR/5BZfKTvvvdshm7dUWsHOQvfnPiT1hXF1mEaomD9uH0j3AA0I+4iRmu9bTteyvRg==
X-Received: by 2002:a17:902:f68c:b0:24c:e3c0:936b with SMTP id d9443c01a7336-25179688478mr89732965ad.22.1757314965966;
        Mon, 08 Sep 2025 00:02:45 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced7ea5e8sm87533535ad.104.2025.09.08.00.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:02:45 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:32:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: conservative: Replace sscanf() with kstrtouint()
Message-ID: <20250908070243.jfz3glf4qy4eohm5@vireshk-i7>
References: <20250906115316.3010384-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906115316.3010384-1-kaushlendra.kumar@intel.com>

On 06-09-25, 17:23, Kaushlendra Kumar wrote:
> Replace sscanf() with kstrtouint() in all sysfs store functions to improve
> input validation and security. The kstrtouint() function provides better
> error detection, overflow protection, and consistent error handling
> compared to sscanf().
> 
> The kstrtouint() function provides:
> - Robust error detection for invalid input strings
> - Built-in overflow protection and boundary checking
> - Consistent error reporting (0 for success, negative for failure)
> 
> This maintains existing functionality while improving input validation
> robustness and following kernel coding best practices for string parsing.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 56500b25d77c..cce6a8d113e1 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -152,9 +152,9 @@ static ssize_t sampling_down_factor_store(struct gov_attr_set *attr_set,
>  	struct dbs_data *dbs_data = to_dbs_data(attr_set);
>  	unsigned int input;
>  	int ret;
> -	ret = sscanf(buf, "%u", &input);
> +	ret = kstrtouint(buf, 0, &input);
>  
> -	if (ret != 1 || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
> +	if (ret || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
>  		return -EINVAL;
>  
>  	dbs_data->sampling_down_factor = input;
> @@ -168,9 +168,9 @@ static ssize_t up_threshold_store(struct gov_attr_set *attr_set,
>  	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>  	unsigned int input;
>  	int ret;
> -	ret = sscanf(buf, "%u", &input);
> +	ret = kstrtouint(buf, 0, &input);
>  
> -	if (ret != 1 || input > 100 || input <= cs_tuners->down_threshold)
> +	if (ret || input > 100 || input <= cs_tuners->down_threshold)
>  		return -EINVAL;
>  
>  	dbs_data->up_threshold = input;
> @@ -184,10 +184,10 @@ static ssize_t down_threshold_store(struct gov_attr_set *attr_set,
>  	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>  	unsigned int input;
>  	int ret;
> -	ret = sscanf(buf, "%u", &input);
> +	ret = kstrtouint(buf, 0, &input);
>  
>  	/* cannot be lower than 1 otherwise freq will not fall */
> -	if (ret != 1 || input < 1 || input >= dbs_data->up_threshold)
> +	if (ret || input < 1 || input >= dbs_data->up_threshold)
>  		return -EINVAL;
>  
>  	cs_tuners->down_threshold = input;
> @@ -201,9 +201,9 @@ static ssize_t ignore_nice_load_store(struct gov_attr_set *attr_set,
>  	unsigned int input;
>  	int ret;
>  
> -	ret = sscanf(buf, "%u", &input);
> -	if (ret != 1)
> -		return -EINVAL;
> +	ret = kstrtouint(buf, 0, &input);
> +	if (ret)
> +		return ret;
>  
>  	if (input > 1)
>  		input = 1;
> @@ -226,10 +226,10 @@ static ssize_t freq_step_store(struct gov_attr_set *attr_set, const char *buf,
>  	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>  	unsigned int input;
>  	int ret;
> -	ret = sscanf(buf, "%u", &input);
> +	ret = kstrtouint(buf, 0, &input);
>  
> -	if (ret != 1)
> -		return -EINVAL;
> +	if (ret)
> +		return ret;
>  
>  	if (input > 100)
>  		input = 100;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

