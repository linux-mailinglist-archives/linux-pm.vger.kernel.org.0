Return-Path: <linux-pm+bounces-15437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACC3997F83
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 10:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD431B2510C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAABE1EC00F;
	Thu, 10 Oct 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysohzAvh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5961EC009
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545746; cv=none; b=NdGpKpR1Y7Wqw1cT0lfEqOEJ12hUm1X2e+Jus7u3F6kjQ0rP7TtOCqgZoJEzjpiJLsnrmDFIlg8JO/8zNYsvF+D8EEXf5VSqgUNzYvYOKLwexs1v+KvMkEiMIEMD+XSsNuG532Zv3Ua0+WHlgptqsxxm+4jAHqDg3QRADjPp+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545746; c=relaxed/simple;
	bh=WHca4nLvasoZXyUDE91E9SdwkYbs9yTcrw7N22ZbYzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fzxy0NS1/8slVvzNqNAAdyiukaqn8XsRqI9rZN4RDWzBbZ4FiMZpWihQN5L+YA74yeTSegKL30GCUJOM9ZSkQ95zmDb6/K8IEsvi+Na/w9yJtpMsnLW6d66isyDl5nl40jY2PVi+MiVNp/+miGoQeG093NrdIgczyfjJmj47h48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ysohzAvh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e02249621so506680b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728545744; x=1729150544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWdKMxd+214aud7r2B8Ug203fvdDzYTHSUGUottLFgw=;
        b=ysohzAvhleUbsAnTeRtag0FfuuBq6m/O2O1XeXrATFx87Wi5oBnYo0rKbWZx5YJ7ks
         v7LHDuMsJl/Im5kVYiDFK8d2m6KZQBqkE6eqrCDqWJ1FKfLyMXWeMRI7zrEJYBqFb7H/
         NuUr+nCRMBd5DeMs6OffjESP/gDb5QSU4wZj+FJ3eqC5c+CY+kfKpgWNUihkoR19qhQG
         bi0eSBwxFp/z4xwSxIuyf5sPtQH1O5rrcu+5U3qk43y2d7YJsAquSELyzPjLdhVZvA7K
         /YDwlwfErWoZ36cv3EbbcHHNE+npQBuFQzdWX+XSEt8fqiwzBAU2vWVWDaIdrYOcru/o
         X2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728545744; x=1729150544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWdKMxd+214aud7r2B8Ug203fvdDzYTHSUGUottLFgw=;
        b=ejiyAqxYUttDDRGxpPGSSgge+KI2fJENbeyKZjzAMh9tj8zvmO/M0E95LC7pQxjqYv
         xm4+6q3vIlfjDRKQgk3JsoHgqRdjdjp1p2rv1pHWf+fK1haFFYtir6o7hqwXRQ7aGfcU
         aqiSJzI1K07saWO8ioL9GHy+e1S3UrtGPtTo0/GgH5jABZPD8EszlqZ+cW1k8NnT7wKJ
         zMwq7YfzfdLKA1z7b6NUAYYKp8uRoiSGvbMX1bFz3b7IhPZhulZ+7Ldzh1EmKNKBkj/+
         7VHxiFph86zcisp7OBBIKDKTFC4wLVoD+RWBaRpOu96pkgkSmtKvniK9EYkRis6GuM1Z
         89yA==
X-Forwarded-Encrypted: i=1; AJvYcCWwFrrMEsHmvLLievJ43pyvjjQU8YNfGbt7ML3F2MkCTSwSuzwGt0xnCEsdy57xFbqA2uzsoDoQ7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XhtJzJZUAR6hRxkU4XP2X0UXVOe17Xqxa2wintrt9BIMj2iY
	cLatpBqK1vtUcHYOlwbY2qdlTsI2MIZCF9EZg8Fm5/9f+t1r4oly1oA2PeOHVio=
X-Google-Smtp-Source: AGHT+IGSVLXJCgqTeLzS7fIrZCUsnzwhd+i2I1D/kl/bZZmIc6cfKJeyHEVsD9Hw6XPVRgOfD+0kYw==
X-Received: by 2002:a05:6a21:4581:b0:1cf:3ced:bba3 with SMTP id adf61e73a8af0-1d8a3c4b7dcmr8689059637.36.1728545744636;
        Thu, 10 Oct 2024 00:35:44 -0700 (PDT)
Received: from localhost ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e9624sm505582b3a.41.2024.10.10.00.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:35:44 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:05:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
	ray.huang@amd.com, rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
Message-ID: <20241010073541.nxsftik6g3tche7n@vireshk-i7>
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>

On 03-10-24, 08:39, Dhananjay Ugwekar wrote:
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index e0e19d9c1323..b20488b55f6c 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -414,6 +414,12 @@ struct cpufreq_driver {
>  	 * policy is properly initialized, but before the governor is started.
>  	 */
>  	void		(*register_em)(struct cpufreq_policy *policy);
> +
> +	/*
> +	 * Set by drivers that want to initialize the policy->min_freq_req with
> +	 * a value different from the default value (0) in cpufreq core.
> +	 */
> +	int		(*get_init_min_freq)(struct cpufreq_policy *policy);
>  };

Apart from Rafael's concern, I don't see why you need to define a callback for
something this basic. If we are going to make this change, why can't we just add
another u64 field in policy's structure which gives you the freq directly ?

-- 
viresh

