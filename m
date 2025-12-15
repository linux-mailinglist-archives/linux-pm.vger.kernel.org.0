Return-Path: <linux-pm+bounces-39535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABD7CBC8E5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 06:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35770300956A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 05:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB14324712;
	Mon, 15 Dec 2025 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="seppDYHU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BF2E6CDF
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776259; cv=none; b=Knk4t3IchSv0e7hSvJ9X8MfQllsjxIKCsbBiCDy+VFLv80na0vo399t9cZcu8ihnHT180twATOReye9tUvl2zIBq70gBMaB6+o1UGq4tINlAxhrPLVOlgtUAIJtlqYFX3+NEM5sU63uKfre64x0ql6lNBmOoIlEaSBTchV0VPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776259; c=relaxed/simple;
	bh=POFd9M9zUC0KxFxoe4gSkNmeH8eJscdCkjl5X59utZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VldfU14n1ZxhjHYlkudKBi/5f5Kx2ENNjDFBWA1F2A7S7Mre8hrsNycJWjRXG00i8TP8uFHgDVpm62gUBav3UazqyvAi25OYd7idzVT31/mlS7JddmFy9a1rJjbSF3en7W6s5eiF9GZDgtd8aRuTosgPmJA0oOP8/i6inTccXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=seppDYHU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a09757004cso17080225ad.3
        for <linux-pm@vger.kernel.org>; Sun, 14 Dec 2025 21:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765776257; x=1766381057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmmxZTmEMkdYAdK/pJCpdNbxZ/BTXU9Mug79unJZ37w=;
        b=seppDYHUO2besGd5geqSsRIEntntN26vOhIHAlWjNXkjgWWxzcMMaAXLbD/NKeFOF0
         1ToiTNDgCZK79gjGuv4o1oUzkHAwLYss4e6yAq+R8LJwexn3CjqYJKIUI4Gkpb5lPZq2
         q4i8/Ta4uKyzA+4ZH/byfI2odZkVMQ+K5kOkR56ka/83rfVWExkOocFGZs/UQWJBHe8k
         1jCPw3ls2BT55pseGhihv/tEIprOeNFuJs647WGXI8Rwcw7PM/NdRJwHMqkgYbmjVYZd
         alsx2u9Hjw0FrzM7PDR1UwOgL4cwJNgfXLziRSozX06YIGW2WTNb5VWJ6t/XME9e7i+y
         CvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765776257; x=1766381057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmmxZTmEMkdYAdK/pJCpdNbxZ/BTXU9Mug79unJZ37w=;
        b=tQ/ekfibWI5pU7CQw0Hk1VltWjFGZedfafuPeDxjJBbfb0QdknYHwK6n4R0Nuvptur
         +3leUlbLwRglgkdfLDksc9L5uOLoPIMOraz7TjKLAjQDhxufBYBHo2YpQqEubnQ4x5yn
         9eZLSO7JH9elLeGh8KM9ms4KHz7F5BAS2vc1Wr4oMlQoO9v6k4TnrHG4Mg8lzMxqmSaI
         cpDkH2Fv5zWxy8m2RMmu+sTn6DjfJm1dv97GW16cC4xt4FYMIwqyJ1oFUFX8tYsgCVo+
         7jb4UdmVn7ovmWFhEmzlZIvE09dZuOub8k+xm0ueesxZfcXDDlGdjRtJCBV+WIW8xyod
         KByA==
X-Forwarded-Encrypted: i=1; AJvYcCX751+HoXY1BtxkHf5VFSdSLNqT9zfRPy3IzmkeisFSSif477DmRhOPR0c7T+ACXKqn9GeCLKRebg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1OQ5Ffx2IbFmc8N0/N5EuyOnCJ3PhT9ZF8rh747j7eNTKeP1L
	W+cOQIMEjrw+GzbfOJMuN6qg6Ozra44rLtYAGWoHLsI+wRByJmr/98+dkKS0moQz6Rs=
X-Gm-Gg: AY/fxX5z/f/NPbACu/m3/Svh8oeZk2wsztSFT+air2P2uPswHm2+W0aoI0dFYp2Pok6
	iA8R1UXhY9E545f9mR0ii217IjIHpHtmTBru4pdCNJuqwlHNpVC51UhwC/+k1XPAUP81aIC44fI
	jGAYV3HF7OvM5wo/6KYWimOqsSiiSeD0aWMeplXRHscUIwXbQYOhQKhGSbwYy5pYKI+mIgOpkke
	qd1fsa6/5akErimZaHP3V0Lkpk/0BshAI5zNHlDw/Rr0Ix6nOzrpDNLkV3kQEA9tvqUcqWUcYrb
	K0GJq7+s5I1yzN8DT1MZKilpts/qD4WYA52Pso4lVPZBeAK66saSX/rryAAk0MUxCc22BQa0jf9
	YDf4fviKbsKVRL64MEoVvFPup9fg80qC+8bEsadowtrTlyim8/VGigRN/PfYKPjKc31GTZtfJav
	k/EnlM4ya6OLI=
X-Google-Smtp-Source: AGHT+IEd41nLow/C/F1F8kEt0tXjl1QE6vzy70JC5wiTjrDdUwnfg8mZsdGVruncG42i4nuvAMIN5g==
X-Received: by 2002:a17:903:1250:b0:295:6122:5c42 with SMTP id d9443c01a7336-29f23b6f3fbmr83337755ad.24.1765776256905;
        Sun, 14 Dec 2025 21:24:16 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f177ff327sm88774495ad.101.2025.12.14.21.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 21:24:16 -0800 (PST)
Date: Mon, 15 Dec 2025 10:54:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pmac64-cpufreq: Fix refcount leak on error paths
Message-ID: <oitkhsra7pax76dnz7r2b6wrpcljck5mwjubrjqclrerpp2kif@alms5oodo5h4>
References: <20251212092910.2454034-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212092910.2454034-1-linmq006@gmail.com>

On 12-12-25, 13:29, Miaoqian Lin wrote:
> of_cpu_device_node_get obtain a reference to the device node which
> must be released with of_node_put().
> 
> Add missing of_node_put() on error paths to fix.
> 
> Found via static analysis and code review.
> 
> Fixes: 760287ab90a3 ("cpufreq: pmac64-cpufreq: remove device tree parsing for cpu nodes")
> Fixes: 4350147a816b ("[PATCH] ppc64: SMU based macs cpufreq support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> index 80897ec8f00e..0e0205b888ba 100644
> --- a/drivers/cpufreq/pmac64-cpufreq.c
> +++ b/drivers/cpufreq/pmac64-cpufreq.c
> @@ -356,8 +356,10 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
>  		use_volts_smu = 1;
>  	else if (of_machine_is_compatible("PowerMac11,2"))
>  		use_volts_vdnap = 1;
> -	else
> -		return -ENODEV;
> +	else {
> +		rc = -ENODEV;
> +		goto bail_noprops;
> +	}
>  
>  	/* Check 970FX for now */
>  	valp = of_get_property(cpunode, "cpu-version", NULL);
> @@ -430,8 +432,11 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
>  	 * supporting anything else.
>  	 */
>  	valp = of_get_property(cpunode, "clock-frequency", NULL);
> -	if (!valp)
> -		return -ENODEV;
> +	if (!valp) {
> +		rc = -ENODEV;
> +		goto bail_noprops;
> +	}
> +
>  	max_freq = (*valp)/1000;
>  	g5_cpu_freqs[0].frequency = max_freq;
>  	g5_cpu_freqs[1].frequency = max_freq/2;

I would rather handle this in the function that gets the reference of the node
in the first place: g5_cpufreq_init().

-- 
viresh

