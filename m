Return-Path: <linux-pm+bounces-3371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB04E8494B5
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 08:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD921F24E9A
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 07:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832FD524;
	Mon,  5 Feb 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsjOlRjw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08410A17
	for <linux-pm@vger.kernel.org>; Mon,  5 Feb 2024 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119118; cv=none; b=LN4Kz4DQA1N4fvX3qteC2/uUFod+e7GLFzyPi7q0pefgDFcIpBGXKJnroDkJpaTKNUyBqH6oZsMT76LxJGtpaYYmyv/LhDlMUBaRMy/k0L4pLMzsrtjJ9WkhIpVvhAbId7+dgau3vBXI/ZbihOnrbyG/Xwdz/X9HZx/3Aw7hyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119118; c=relaxed/simple;
	bh=4ditESpSvXO3CQA9RfFDubZPLUjwNbBXaDxb7YTzR4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3JTB4PcD4KofyoycPpWX1horn/5Cq6CnriCtg+DcO/+766ZGB4wqgtwQf1pvboeFP0GPGKcyeYoq6zdSjLKhQbKdmAtWC6HoASzxgnceUDiResJ8UVOPlpZ/EFxsT+JFTxewe2u1BkiQKhg/FVQwD/FRYc88uqJUTa4elrbOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZsjOlRjw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d72f71f222so32259905ad.1
        for <linux-pm@vger.kernel.org>; Sun, 04 Feb 2024 23:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707119116; x=1707723916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5pZ7raTnr2lgK0OrNyzLvdmrD6RJWaTC7ovP0GMB90=;
        b=ZsjOlRjwlf1JuA1xRQwEtRLNHDBpQWNRWtOQiGn/vwyBT2DtY4JOF9EDEFnpUIqnSy
         /oFi4tr8d04v26s6bwjYGHU34X/2mXkB0XD3iMZw4zqopXYY+2AMKwfTyYLIvhfupxpK
         z01LlcuYRYv/FmoyXu1/sAGiSeiKoqvQxazh7I5bh8TGmbUH+Ss9rMzI1GTI+p1ezmkj
         s1wktAKqJFs4krH5/srzoe9aV2BBqSV8aEtL8aRf9g6rEuw6iGhHvRP1fSotAkRtXFX/
         bkOJDPXW8V8WimTPIxunk6mVTyYUTVtVg9w0VFk0Yx9kHasjJjNQpyOO/k8A30R0zc6l
         x6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707119117; x=1707723917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5pZ7raTnr2lgK0OrNyzLvdmrD6RJWaTC7ovP0GMB90=;
        b=T1ltEVbwfFgKeyroX21/Z9kv8wJ6ZXPe2pmfY1eCWA2bn91phRkTd1gcsP4zxowHfq
         HP951iiC7gmzT1QBwbYO0Z8c7AMj+hNh/9aCpdHMbJUkYnOqyPMU1hFRptXscFrLmx44
         vEapOyPqMInfIIMxZzgvaiwWfnFUZHkSVE7NdJrJ/3q7Xg/YKrg7MMh8WfMJ9P6GrUid
         NfAVrunh2pFI5j+mhbqpumAV+BCut63hjNWP6fyeH1DRI/rfpnRkLwKW5b9A1GaouEOK
         LwWehjfIJ6r4uWoMwuDDy7rZSSrHdLvYjz0QPWeisxpmFOnAS/sWz8wxJ3IB3WAxkmyK
         LBuA==
X-Gm-Message-State: AOJu0YyTBsiMqBBzwkU3x/XioqVI5n9lZ4c3KNwnpklrcZrGwNxbSt62
	4q7o4MEmweMwAdkZUT2k0x9bIpHAwJGRloruZ9WeQbnHGvmRr68jXvxMwRTF68Y=
X-Google-Smtp-Source: AGHT+IH3inHOeV/32gOcYBEpkgRtN/F0pBAJGBbxhm5JASQAUblS2EZclwertIUh/yJtcwkvZsomFg==
X-Received: by 2002:a17:903:487:b0:1d7:7347:d80e with SMTP id jj7-20020a170903048700b001d77347d80emr7652637plb.37.1707119116680;
        Sun, 04 Feb 2024 23:45:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCJciGez7husAYuw+I3m6BQSRCfZzxZsfJxUhVV244QxKzScjFDReEI0Xk016tg1zU/FMYBf06Ny4fGnsQdh7z6pDPynZxOsEbizlASpTM27I7Dzr/YX+cRC9YA0fTgPXFwhBSoqzsXafCv3oTuiL7IL7RE+DjgNz/aHjoR0tyVi2WU7RL/sYP0gnHBmnDoYmgsKcA+iSqSvo6EO5M5JdUhTJXwPZwOKIEdKQ7dUhsX9szpA20Ony5ydzAtpFQhQSs6ud8hEkKrlqTQexsUA4fg129jFJhPsqo5oZJsA==
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id r7-20020a170902be0700b001d947e65ad8sm5610644pls.251.2024.02.04.23.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 23:45:16 -0800 (PST)
Date: Mon, 5 Feb 2024 13:15:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Message-ID: <20240205074514.kiolurpounokalum@vireshk-i7>
References: <20240205022500.2232124-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205022500.2232124-1-qyousef@layalina.io>

On 05-02-24, 02:25, Qais Yousef wrote:
> 10ms is too high for today's hardware, even low end ones. This default
> end up being used a lot on Arm machines at least. Pine64, mac mini and
> pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
> it's too high for all of them.
> 
> Change the default to 2ms which should be 'pessimistic' enough for worst
> case scenario, but not too high for platforms with fast DVFS hardware.
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..8207f7294cb6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>  		 * for platforms where transition_latency is in milliseconds, it
>  		 * ends up giving unrealistic values.
>  		 *
> -		 * Cap the default transition delay to 10 ms, which seems to be
> +		 * Cap the default transition delay to 2 ms, which seems to be
>  		 * a reasonable amount of time after which we should reevaluate
>  		 * the frequency.
>  		 */
> -		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
> +		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));

Please add spaces around '*'.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

