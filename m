Return-Path: <linux-pm+bounces-41070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD38D3A1A7
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 09:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8B92300BBBB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497D933D4F6;
	Mon, 19 Jan 2026 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gotyDT1a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B633ADA9
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811306; cv=none; b=qRLTehKocPJyniBOWfqg+04/YGW23OhqrUVlw2Kb0rpLWDHXawp8jlpV484pa9Euu3Dmst1fgEBQmNbnDQS6JGV3UeRzOWveo/waQ8eZtQgYNy9XyWrwM1dF9slrRZHiZ70jieMjsrynOsIiOe/+T+hVsb7OFol45cdfrt9/l0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811306; c=relaxed/simple;
	bh=Ggs4iwVcnqcBfzjBk2TR+6qksjdNDN1zL6YU4EFY5Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpGp9d04pdy/r2YBvHWYbyp7I5/dLZKCCcuO1ZGU4xoKrZzxrXzzZTMnvFNFBh6b0X/vGb5y+xUJY/2zS6a0Tv5TXLjjtlOYt7PFoMPuInA9KG/aF2U+83Xa4eYvCn7Cb7SP6+v4heXAVs7G3GyvSi1UTzcjtbd/GL4lDe1iBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gotyDT1a; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f3fba4a11so3917270b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 00:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768811304; x=1769416104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQQ8Ur8snt/ip9tPTurf/jpz44iqfYla53CTWQG78FI=;
        b=gotyDT1aOPn4/MKliSQCZp4duiFFiPJrR2DpX9kjV4VHg2QGF621PZIQF6N6nxxXFc
         s6SaV/9omxFzYK8mSpeaD5c1ZVmkieF3do7SReZkGlFDpRILOIr9kxEa8iGVtJCYNpUU
         NHDpjtkcbvXvMSoM54CoXEQ3XvPNpSrRDbrCWZHbFl+i5cU5ujbAdgdD4EaoMaryV8SQ
         hx3trJjNDyMNmCNaWSSUZD3cGjb4gpiUQXZdUOhezVuD6rIWJhz1NE1L9ePLDZjdkvds
         jobnGV2fJ6Y/k/wlu7/GNlCmQR4O2rZEpJQw+MBKNQV6olh+eycGTsKSLwuBKNe06awb
         vdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768811304; x=1769416104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQQ8Ur8snt/ip9tPTurf/jpz44iqfYla53CTWQG78FI=;
        b=QwMenyTmi8eNjVgusgWi1vczkr0vqGyopTNrZX4NXvYvVqh4pP9s80s4sQkOdXgrhS
         IZTKTM8rUQC3t3vV9Va2CiNPyNh+eO+w9mT1G2nJ7uQuGZuyRxUmif5BKfDpMWgnSeic
         muVSL9pnEdyUdpHa+mkeqvYfzmDmrQ+E7exsaSw3wEdDbisD+WTF0tResecHpjKoT9EJ
         gyTu2DS30NDuv8krtX97DHl83gM2arGClnbcIcEoF/J/J87q652e5Ngx1dR4Rpt+Cogn
         9hgZN2BEP0hgSY8K8IjOYds+vZxC1YISg/1ulPWi1NhgX7+cQEK/q91xaYrigX7IQg3Z
         2GFA==
X-Forwarded-Encrypted: i=1; AJvYcCW0ums40mLWXbaWUd4iy7hEI2tNXUrjlj2h0WcHQ31799REoGsBrpSvcNjFzOV0wxvJFUYqcqm5Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEak9RA5b6W9XlHgIlpHD22fJjpI6F+p9ip6nDQJ1XF84oU0U
	pPz/qUOCE/tH51XRgZ85TQw4gsPj4TtrxF5p7SWLNCf4J+cpMDBvQi18YAgpL7DZjww=
X-Gm-Gg: AY/fxX7/YwpANDOVI1ppf+ZTMjip1Y1uVqA50Pez9MPbHcrFoUd0LvdUbWe7ChIbFKg
	cSP/HZhNVlB9lW+Ae26UdULSr+o1x6GWFZCrcq4eUuD8meCJtI7Qz8WNJbxl1btQXXSC2VPjXnR
	L/cXbxBj1h3iaKCcglahtq93odFaCL4tutwryaH+13BraboSPMUHlQF3Ec9notRaS5CWDob9glS
	3btHSeC6E4JAFjgzl6Qk0uvxzpIFjUG07TpwJuEYTGypwY0QzJlOkgOx5wSi2t3TF1swnWw+DOw
	aeWCgzRtCQxBbLBwWASFr0jsb7b4Ozbw2ZZzd+GN48K9WDozAlaeHvMqr11wFW0WfLk7cTdufrH
	qkGKeozWYiMc9tJOZNAqheglOnn4iNsAgPMO9ITohqQLbUbUdjto98PSj9IlkM/tH4mqa453QrY
	ngeabLWteuvdw=
X-Received: by 2002:a05:6a00:1803:b0:81f:4ce8:d642 with SMTP id d2e1a72fcca58-81fa032cc4fmr9022715b3a.64.1768811303901;
        Mon, 19 Jan 2026 00:28:23 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12b3165sm8476508b3a.60.2026.01.19.00.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 00:28:23 -0800 (PST)
Date: Mon, 19 Jan 2026 13:58:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, linhongye@h-partners.com, 
	linuxarm@huawei.com, jonathan.cameron@huawei.com, wangzhi12@huawei.com
Subject: Re: [RFC PATCH] cpufreq: userspace: make scaling_setspeed return the
 actual requested frequency
Message-ID: <ny7npyivbpk3zaf3dm6h3ves4azp75hzmrqmpiex3nauuzrzmt@zf3rto3vrjbq>
References: <20260116094623.2980031-1-zhangpengjie2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116094623.2980031-1-zhangpengjie2@huawei.com>

On 16-01-26, 17:46, Pengjie Zhang wrote:
> According to the Linux kernel ABI documentation for 'scaling_setspeed':
>   "It returns the last frequency requested by the governor (in kHz) or
>    can be written to in order to set a new frequency for the policy."
> 
> However, the current implementation of show_speed() returns 'policy->cur'.
> 'policy->cur' represents the frequency after the driver has
> resolved the request against the hardware frequency table and applied
> policy limits (min/max).
> 
> This creates a discrepancy between the documentation/user expectation and
> the actual code behavior. For instance:
> 
> 1. User writes a value to 'scaling_setspeed' that is not in the OPP table
>    (e.g., user asks for A, driver rounds it to B).
> 2. User reads 'scaling_setspeed'.
> 3. Code returns B ('policy->cur').
> 4. User expects A (the "frequency requested"), but gets B.
> 
> This patch changes show_speed() to return 'userspace->setspeed', which
> stores the actual value last requested by the user. This restores the
> read/write symmetry of the attribute and aligns the code with the ABI
> description.
> 
> The effective frequency can still be observed via 'scaling_cur_freq' or
> 'cpuinfo_cur_freq', preserving the distinction between "what was
> requested" (setspeed) and "what is effective" (cur_freq).
> 
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_userspace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
> index 77d62152cd38..4bd62e6c5c51 100644
> --- a/drivers/cpufreq/cpufreq_userspace.c
> +++ b/drivers/cpufreq/cpufreq_userspace.c
> @@ -49,7 +49,9 @@ static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
>  
>  static ssize_t show_speed(struct cpufreq_policy *policy, char *buf)
>  {
> -	return sprintf(buf, "%u\n", policy->cur);
> +	struct userspace_policy *userspace = policy->governor_data;
> +
> +	return sprintf(buf, "%u\n", userspace->setspeed);
>  }
>  
>  static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy)

Looks okay to me.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

