Return-Path: <linux-pm+bounces-41066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A527ED39E02
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 06:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE5EF300ACCA
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 05:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2753A1AAE28;
	Mon, 19 Jan 2026 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwo6cmBW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1DD500960
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768801734; cv=none; b=G7w6Sx7Tn0IxE9U4m5128VVb6c43qzVtyOk+O+YfArxjxsYGYkZvJ2TFF1T/jVSKLM5UmpnYjlLEhj7NIGCviI/mcA0afimEiEMNBmd1n5Q9MZwjYRVv6C576REgUkMi5cPj1n9XdMcfbZYb9c5AwPkg+I1RWwcCQ/3V63JiemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768801734; c=relaxed/simple;
	bh=ysB7SxTOh5ZyKA5DysZWLp3MiKHbwJvwwstm/AQkBjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/Hsz+VvNpvFBvNPCq2mZehclRd3YBhgnVQbGIMVxR4/D19S9L7Yr/PxANezW/PCsnPStj/kTHFpUTicvH7J37X6fcios1BD3M2xup7XE7sXNfAS89zmcs7s5q6NxCxEge4cHNudy5THwdCGU4toN/XHyhEw+vWg8D90NccsMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dwo6cmBW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so1525202a12.3
        for <linux-pm@vger.kernel.org>; Sun, 18 Jan 2026 21:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768801732; x=1769406532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+/S68usaW+kTcKvw3RLnxGJfu2TKIUUxfyXIfkHcDk=;
        b=dwo6cmBWPz7Cc+gE6lzHvllgGDRMhjyLxiIuJKgR9WuMS2+8pBgTKmIbNLts3fWHyQ
         wW0i/jvsXDYdh8PE8R2rGuo+hQo+fZCG7Pg+Ik6zyW9jkxbY6ASMQ5/RFg9ITINtPEAY
         BZff37hzQu10k/qZgnUKb/sJqzwzb5AvWyixh33Q8VrzsJMMt3YgTs0E86qbZeIdA2SG
         PbqTtSejCsYWNSdneEB2OVNyafn/7O+QFkWM0EoyMAA9V1z++qYUTWZqnOb7ouEKiyAX
         dEXABAMXiLsDZF2lUyPRrAvBAJlVQ9/n/uFy1UVogOcmRTMSnchy+3m13dHO8hv2q+gL
         tYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768801732; x=1769406532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+/S68usaW+kTcKvw3RLnxGJfu2TKIUUxfyXIfkHcDk=;
        b=c6H86t0r9o2j5rR9ri2xAicxEHnNZyKU9nLbwvaiyW5dbQFebSoRP86RUuvoWGxMvn
         lRc8wwv9QV/N3LU84AUwk1CR/mA1mp8adZvyDGpPu2C10vhsihDuHweKwlVMB8e6Y788
         s6ifSv07JFJ3XqDXWAl8OUIzdWxPtYETODJZgpm3M0OESWuFzkd4RfnCOMWRGGmWSCck
         yexGpLCyxlruWauBUxcgjHRf+r2CvuRRiVPi41g45QjXOMfh8GYZyghHDX/hkobdL152
         b6ThaBDfsmmoSkeOn5DhexFlyyC7yH0HFR+4k620Rno2jZyZ7LinMJi+2td0fg2FXW65
         17aw==
X-Forwarded-Encrypted: i=1; AJvYcCUKyQEg9LQ9b5D51WRnnnMm07NC47qb4VvQHLEgRqUjRAR9TAjG2681vzGXGAtr63jCz/hd1WcU9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZLAqVFnYpB0LmCQ0cFGDYxL9Md8SGdN6F73W+Wm5H9tGUw4iR
	mjWlGO2FWmtgNcta0l7ON1T071ZyWhdpFRDJBlo4TUNeo9YoAKj4eU5PhZghNf83Me1GuxpLDvg
	cUjLk
X-Gm-Gg: AY/fxX7DfdTnnuA8Er2d6k4HHNVrLER3ceRmKJ1jnmiVcwjh2NLqpw+0GSsVsZ8fhjI
	/PalhjYebnUip/HcSBsTLUKsGXBgW08xH1kJkKoT9NsJ2UlHBN77tiAWFOT+n30+z6DHqUnIfNC
	t3vfG3MRCCSeMsPPWmBtWarByrlqhysa0aPFfyArWvLGqcGtdM5BcgVAdQWBElSp/1yOI4lfOKp
	t6NMI40wbO4kqdn3Z7UUPTnu9g0QuRxLN4pf4zbYkm3tjynr706pKiLyWIhPp9VwF4G5mdTLJEL
	PMhJiSMnlJR+2kOS4bkpJSN6Xi/ZvaANZg1wodezEYPmeaBN3lTA60tN991ZoFhV5MBzXhR/otT
	1M+wrlVrflFBAac8fSMewkewO4IaSbYiKqOWIAq5oX+nVr/e1TeZ/y4aY5GZ83sMgWez4/WUDHL
	qBcn8xPc5Jc6XkjWoNm1KqSA==
X-Received: by 2002:a05:6a21:9d48:b0:371:53a7:a48a with SMTP id adf61e73a8af0-38dfe572a0cmr10318092637.1.1768801732018;
        Sun, 18 Jan 2026 21:48:52 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf251a6csm7921857a12.13.2026.01.18.21.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 21:48:51 -0800 (PST)
Date: Mon, 19 Jan 2026 11:18:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Juan Martinez <juan.martinez@amd.com>
Cc: Ray.Huang@amd.com, gautham.shenoy@amd.com, Mario.Limonciello@amd.com, 
	rafael@kernel.org, Perry.Yuan@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Kaushik.ReddyS@amd.com
Subject: Re: [PATCH] cpufreq/amd-pstate: Add comment explaining nominal_perf
 usage for performance policy
Message-ID: <rdym4zzkiokzvmlj6qmxzomgyazggzfbj4euwlbp2nq7yhop6u@3qg4yo6zamkl>
References: <20260116214539.8139-1-juan.martinez@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116214539.8139-1-juan.martinez@amd.com>

On 16-01-26, 15:45, Juan Martinez wrote:
> Add comment explaining why nominal_perf is used for MinPerf when the
> CPU frequency policy is set to CPUFREQ_POLICY_PERFORMANCE, rather than
> using highest_perf or lowest_nonlinear_perf.
> 
> Signed-off-by: Juan Martinez <juan.martinez@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c45bc98721d2..88b26f36937b5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -636,6 +636,19 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
>  
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		/*
> +		 * For performance policy, set MinPerf to nominal_perf rather than
> +		 * highest_perf or lowest_nonlinear_perf.
> +		 *
> +		 * Per commit 0c411b39e4f4c, using highest_perf was observed
> +		 * to cause frequency throttling on power-limited platforms, leading to
> +		 * performance regressions. Using lowest_nonlinear_perf would limit
> +		 * performance too much for HPC workloads requiring high frequency
> +		 * operation and minimal wakeup latency from idle states.
> +		 *
> +		 * nominal_perf therefore provides a balance by avoiding throttling
> +		 * while still maintaining enough performance for HPC workloads.
> +		 */
>  		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
>  		WRITE_ONCE(cpudata->min_limit_freq, min(cpudata->nominal_freq, cpudata->max_limit_freq));
>  	} else {

Applied. Thanks.

-- 
viresh

