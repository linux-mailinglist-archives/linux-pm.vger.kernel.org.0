Return-Path: <linux-pm+bounces-6293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851288A25ED
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 07:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A611F22432
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 05:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705E1B977;
	Fri, 12 Apr 2024 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvQieRG0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D21BC4C
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900999; cv=none; b=LsAx7kKY826Gwtv1Krs0V+OfQZhrCGKFKnfFFhWENj7SQ/nK7NgBBuDN7ueJ5niEvEHNuenQPKAQRfI8WfUta6PUidH8PGHKEKHu1ZaXPcw0sHKxdGa2+J8P0N1x3GhbDGLg8iwc0ieyrr4qrz6AQnJsY9SsjLmScBwSPjAL3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900999; c=relaxed/simple;
	bh=kUizxTcZ6cyvhnTtmGHd1w+aCsbtemQaV35WRg9+mU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/OoE/sdTJEX66ICE0rByPBHZwFValBN1fx292eAVa711zNq3FQGGjVSka2VoXWSEHGEsVnGGk1QEZmN3CHsO0p0ax88CxT+0ACGBxdvCquKwQ9dhM1wnYWtUP1fXfSe8a1pwhQQkGmijpiv8+XtUU2n570w/9SnxuraoGHxNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wvQieRG0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6eaf1005fcaso405768b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 22:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712900997; x=1713505797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qg+zYhclHNe/YKT6SbP0FsfwObVCJx628HY4IDmLFjg=;
        b=wvQieRG0ZqaN2k5ez6Zn6LJPoUjLDViMT5ThrzEQgq+jPAqcuLGqPik/cK7aWv/MfN
         6wCzCR6hlKVJ+RiOmbzVRQDjhG+tmtk4SR3VEMmeG8BOCiUc5iaerOaXL2tdcddK3dtO
         kly6QqrAIYSwS9GS+wwf6sRkiVLUDUugrWsVW1DFpZgDfAT9pA5Ste2mULGDo/fnwyPM
         E12bhYfik2B/O/mSwH6EPPpvP+F8IYlSWpf7HJtDNGVw5uiBvT7QddGxR+vnkWhcix9C
         DLeQm1bMidbASwZ1tx+T+Y5Eh0qqJOIaP/jpwfl7WKMs2VSahs6tvLpYSjdjIP9/Fq7Q
         xc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712900997; x=1713505797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qg+zYhclHNe/YKT6SbP0FsfwObVCJx628HY4IDmLFjg=;
        b=kUCJZJuMsU4/n/sSspESAakvuWOiAz2HHKY27fW/skhHDYG7nm/QdEXjeQo9082TKc
         rtlM/ON7cvcQzbrX3Kc5QZDtapTq9nQeeYEtS3y9lwgxXUhzZjCGWzFDjmf9Vpthux6E
         sgIcGVbbywNQPDyVYlioClPQYrVjT26IdUlqggaq26vL2+lNUoUTFfwX20IayPp2V8nx
         2123jVdqmQKJAykDxjSrazEY9F7b9UkTUjtU3KFhnz08MDrb9MzPfRCVZJEH5Cv63m3K
         58QkMCiOLDllyrjHJa/ws/p1o88ThKb79q7rm+Kh90AOMxrobcp5Z4gizPkEcwucfrV/
         rbxA==
X-Forwarded-Encrypted: i=1; AJvYcCVJhy5nw5Y3IqVAm/pXM4bfWCmPRsVgbxL9nQGTwVmswfvA0dLWdhhpxboHJrlBCivwABwSphBRW6ey1AAxp0ADqhdBN8zh/4A=
X-Gm-Message-State: AOJu0Yy+6DH5M8DVyEQGZxmG4eK7LiynJNb+Ce3CyDCpIVthLFoobsg2
	vsdTO5BkR4xQbvSGzbndbrtbigiIu9IQAy/DhADaYys528w7tqpM/VmueXoyajA=
X-Google-Smtp-Source: AGHT+IGMDZPI5BsxBcCdel4W8GtZW3J2Q5F+iJzZ+I41SYsvNTsHvnhRIcMu4OUZzIbalGfu/4TPZA==
X-Received: by 2002:a05:6a20:2d08:b0:1a9:ab88:f938 with SMTP id g8-20020a056a202d0800b001a9ab88f938mr674107pzl.19.1712900996885;
        Thu, 11 Apr 2024 22:49:56 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id ft15-20020a17090b0f8f00b0029c19285192sm3767408pjb.44.2024.04.11.22.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:49:56 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:19:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lizhe <sensor1010@163.com>
Cc: rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pcc-cpufreq: Remove redundant exit() functions
Message-ID: <20240412054954.qve7udfq56dz7qiq@vireshk-i7>
References: <20240409125003.3444-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409125003.3444-1-sensor1010@163.com>

On 09-04-24, 05:50, Lizhe wrote:
> The return value of exit() is 0 and it performs no action.
> This function can be omitted. Please refer to the end condition
> check in the __cpufreq_offline() function.
> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/cpufreq/pcc-cpufreq.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index 6f8b5ea7aeae..771efbf51a48 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -562,18 +562,12 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	return result;
>  }
>  
> -static int pcc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> -{
> -	return 0;
> -}
> -
>  static struct cpufreq_driver pcc_cpufreq_driver = {
>  	.flags = CPUFREQ_CONST_LOOPS,
>  	.get = pcc_get_freq,
>  	.verify = pcc_cpufreq_verify,
>  	.target = pcc_cpufreq_target,
>  	.init = pcc_cpufreq_cpu_init,
> -	.exit = pcc_cpufreq_cpu_exit,
>  	.name = "pcc-cpufreq",
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

