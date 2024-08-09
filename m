Return-Path: <linux-pm+bounces-12034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A294CB25
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 09:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B8B24B28
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC71741D5;
	Fri,  9 Aug 2024 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOAEgNht"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F117BA2
	for <linux-pm@vger.kernel.org>; Fri,  9 Aug 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188075; cv=none; b=QMBgMyGiOJVl3qqXHiVz9vWfastUOUWeFROhfCT1tQCqO1AUZx1hx8ns2XFWbzuZyr3TQ0F4gVU6bIFulQ9Ed8O2hI8cUW5nTJL3f78OJqoBiTJSfq1zDtkuKqtWWojPrUIyoo5s0dbqQxyVxr6KpVaF7VLEHzhFbzy3lInVeME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188075; c=relaxed/simple;
	bh=QxkBQzipU159PB2wyHzE5iFYHTjRi7kwQk+67LpGaiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eh+pqJ4F6P8/BWG2OZTUxfVCRxJxhAWwNH+h+zCyzAQfaNkKkWjb2Hue1qcWlxWGi1zR2fLq8TFUu3HefrYI6C74LsZevyOJiY+HPVYfA0RXQ1xb3M1PH1GaHbpgD2G4VLLryJvq+oo1N0WaXhBewUes9vjlIxY8yWhfvcOaKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gOAEgNht; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc66fc35f2so20495125ad.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2024 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723188072; x=1723792872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ7sJqSF1TkQHDuuGssihp9fwsv9r97LCZqEA521fL0=;
        b=gOAEgNhtwTVxYsJFxY/7FDOdzam588mYqPSsCDUrEX4Y/Bp+G6FAgo7EilcuLasT6L
         HXm6R//DkU59CK2pFivyXtxUvBjeRbsoUoLitnGJdTIkW1aTNz133Nu/pEIYxSdoT4J0
         Ys1kheZZsQ7mrj89iYldu4qqMFkFKs2m4YLp7l4u1viHtyOinuhpE/ArMyY4lG8V8B2N
         NFRJFDhrlOTYm2Co5T1v/Hk4NLMRh4GYyOviwIWqiw/c4+c7FhQBv3eiXIB3SWZT9CPQ
         gPGNV+sf4xgF/fA/VuvUGrjkSiwTeOcscEgx9vozS8FnBvmh7Mw4HfDeQAwmX5aAhAoW
         xy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723188072; x=1723792872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ7sJqSF1TkQHDuuGssihp9fwsv9r97LCZqEA521fL0=;
        b=R872k0PPXgLGRuxnTJT6zC/O92SkaGNeX/pI3XjSjf4zum6GinfK56qw9iWfxrhxYE
         Ac//Qayx1LgPqUm6cpUPomls0SueA2YqKeJMGZyCoqYopFIzTg1TkEM0RHtTR7auYymz
         xK748FO05hLjstkqlZ+btf7xc54mSRZCblJi7cDgFbSl52gDMyPJ24toXkPzOtLkUF5o
         ZYKLZbjSCw5pQjHz9rTujNUrbqm18ccw80+JpRvTUtumeLNpz4rHuxC0Fq2HabSo1RxP
         4HjsMfSUTakW+VjvXoCWo4hsHYBIEOuCD03nF3/Ln+5PasFu+LttVCm59vY6oQ9Kju/D
         SZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQl/XY4QLBZjurMJ4QIepQq9D20u/o0lJWb6kvcTozHRaAqbAxw0lgdwsvK6FyifLIrZLFgd/u75sxOeAILK00KmQQk5BFf/w=
X-Gm-Message-State: AOJu0YxcCfh8gQ57M5yTzF4y8LpPl5850H8ORKyL/lqB6V9qVxLcXAL3
	CjtV5G3DxvDtwmGP8/YI8Ne+XYIYkmbTAVhskxYGYFMPyKMPjW/mbG9mBKmkrQY=
X-Google-Smtp-Source: AGHT+IF1i8beM8uAfXZssupMAVGlCAp1gZOrRbekA77KTQLwPssMRWulWeZsjxYUnURP0YkIw6Sxaw==
X-Received: by 2002:a17:902:f68c:b0:1fb:9cbf:b4e3 with SMTP id d9443c01a7336-200ae5d85d1mr12384395ad.22.1723188072489;
        Fri, 09 Aug 2024 00:21:12 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59058d20sm136717635ad.175.2024.08.09.00.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:21:11 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:51:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
	perry.yuan@amd.com, rafael@kernel.org, li.meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
Message-ID: <20240809072109.ygel62d4333shkrw@vireshk-i7>
References: <20240809060815.21518-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809060815.21518-1-Dhananjay.Ugwekar@amd.com>

On 09-08-24, 06:08, Dhananjay Ugwekar wrote:
> Fix the reference counting of cpufreq_policy object in amd_pstate_update()
> function by adding the missing cpufreq_cpu_put().
> 
> Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 68c616b572f2..eff039ba49ee 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -554,12 +554,15 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	}
>  
>  	if (value == prev)
> -		return;
> +		goto cpufreq_policy_put;
>  
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  
>  	amd_pstate_update_perf(cpudata, min_perf, des_perf,
>  			       max_perf, fast_switch);
> +
> +cpufreq_policy_put:
> +	cpufreq_cpu_put(policy);
>  }
>  
>  static int amd_pstate_verify(struct cpufreq_policy_data *policy)

Applied. Thanks.

-- 
viresh

