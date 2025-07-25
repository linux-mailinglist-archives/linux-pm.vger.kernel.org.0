Return-Path: <linux-pm+bounces-31415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8662B1180F
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 07:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA7F188FD69
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 05:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA596231C8D;
	Fri, 25 Jul 2025 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFxUG9Br"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351F3A1DB
	for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2025 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422554; cv=none; b=rv6l/SbUP/Ge/CmEk5W603T6vytwdWWXM/vaQ1V2eaOzjwD/a7JDNsPmZsLioZq1gyecPmhLGpBhnPSZCbxRtkS1ZieKtQkPr9KeptFynp1MXYbrPxJpOgN4sxhQokraBHyaS73nGxXnsCsNN6Tw2bzMYcX8OCy83wlkWQMOUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422554; c=relaxed/simple;
	bh=kt81b78tGqE2fXMs1hgKSZPNjtRJ+zYxTvIAg+AkKBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbT3FjDJiNz4XNZ9c64OAxc/kfw5vxtd2phUjViPeWawSSRu/NYKCgyyQv1VFkHwBkGGiA9G4sYNWvKOFRz0/c7Oej6O4Fb/Bjq2AkNFdV/cDQ2Y4vYTCUkgRSaRho5HWWw6YqkHS5p9UGPCKBD5/ts7CGQyub57HpvF4Tmxz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sFxUG9Br; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2352400344aso15370555ad.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753422552; x=1754027352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hskrk8phHu4wT3pcdJrDYqFkEsU4W/M9XPNUZYaY9go=;
        b=sFxUG9BrBmSyUk8Z4eclTrW5qOPSE2xPjEW9Zjug/PP2fDxw++MaP9VS7qx6lMEx4v
         FkG7/yVwom5NQUKjlRE2zDlDK3Mh4avEgGs0WW9fPiZVmkkbGDV1OpS4lpvuLFGmkGS0
         IbrZyBVdWrxCbWegkQs67EmZbwWeLQwd1f8D7Vgm7RSvEus9DRlA2xkYMGNUZXj3/PfF
         bFK3qiPUPmsrXqcnQNFQU9k2GgH4EG014BhROPh8cY0ier5EnaR2HstW3lvWPLsk+iiw
         676XSRv18A/M5q5Gz0ZHgOtQDG8VUMFrSUtdDSoZvf67JAiUU3ib98RdSEskj/iUf6Px
         b8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753422552; x=1754027352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hskrk8phHu4wT3pcdJrDYqFkEsU4W/M9XPNUZYaY9go=;
        b=IF0wVN6UvrscZhFgUUWT9QzOaRK84HZOGBdXZAItQUpNjg92zWOsA1wP4KtJX2rfzi
         ja9K7a8eEQweElfWwFcTOtmbhHiOLYBdEDO0/wpAyO/cTl+4WzKag/9qb8kLN4R6W7TJ
         KAbOQDudwIjmCG2oWLyAdxAHrQtUaYZim8GpB0MRAlRJFLd4/T17/tHDgYY8lV42MH1/
         f91vPO6Bp5EX9V34fLAR09fEzhSKAoEE/vRirSNbxx3o3H8B4QuDngboS7p/IrkgsbSX
         lj6hotuDEsOsdOjV6GcROEsTdwLMCsHMuIri4Mn1nEuEOuD1NRD6M/11pwQ6TSJMqEug
         T1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVL+oBwf4grTteGsnglGbeHTKG28H4tJknV0NGf8C2/0JnDPK4A4H2HUZF+c1YWIOh+RyEBDdO8JA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDDduGVr4x91TzAWLv++LQYI9WgLQr/YTmYMv72r6dBX0qCds
	Mra1ITuS/rVV4m4BPUs7b8H0MUtbrTc2nbtNz8RmWHKRPgmBC5088kF6CU99tQmP2Nc=
X-Gm-Gg: ASbGncuh8lY260o01P7TNZWi3zkwwnAjLlLka5qmRanHAGxHu14Wi1rQTWXY0x63e+M
	jJS/Vy4UUm4LV3s8+u4jkhDgLC5B04IFl3xGDj0mvs0HVt+/puZunJP8OqwtqOZmfwvwEGbQ5kp
	LcAfVdLMnn5F8OK307B/r+o9ydSL4ZdJPWo69mFisvo3Hrx6P6b26tDC0AFCGh4cZbRg4JowLbM
	VAEyT6ZKBs58rl+fW1HQxNoxF3IgGwF99GZQxgL6V0CcTBn7zlASQjmSbu3hgmjXCuDTKqi6/F3
	gMJPt0FuGO5KwqGmah48Y3yEIYuCj8Afb3UIRCe0nM7uCSx4XAGQ7Ym4kA65mKR1LGdvB8yDinP
	T656EelvEBSMweZrKNxYTblU=
X-Google-Smtp-Source: AGHT+IEFuvuyjcT7lJtRzHLQ3JJkqLEhR4KgQjICzcTCzi4yg8xUN1GJ2tFV3c36Z7EcNgPK0alcHA==
X-Received: by 2002:a17:902:e78e:b0:234:9375:e07c with SMTP id d9443c01a7336-23fb3171f12mr9502175ad.46.1753422552072;
        Thu, 24 Jul 2025 22:49:12 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c07f942sm2626823a12.7.2025.07.24.22.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 22:49:11 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:19:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Avoid get_governor() for first policy
Message-ID: <20250725054909.gplhe37mstwvkuv6@vireshk-i7>
References: <20250725041450.68754-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725041450.68754-1-zhangzihuan@kylinos.cn>

On 25-07-25, 12:14, Zihuan Zhang wrote:
> When a cpufreq driver registers the first policy, it may attempt to
> initialize the policy governor from `last_governor`. However, this is
> meaningless for the first policy instance, because `last_governor` is
> only updated when policies are removed (e.g. during CPU offline).
> 
> The `last_governor` mechanism is intended to restore the previously
> used governor across CPU hotplug events. For the very first policy,
> there is no "previous governor" to restore, so calling
> get_governor(last_governor) is unnecessary and potentially confusing.
> 
> This patch skips looking up `last_governor` when registering the first
> policy. Instead, it directly uses the default governor after all
> governors have been registered and are available.
> 
> This avoids meaningless lookups, reduces unnecessary module reference
> handling, and simplifies the initial policy path.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> 
> ---
> Changes in v2:
>  - Fix the case where the governor is NULL.
> ---
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d7426e1d8bdd..1aa559f53479 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1122,7 +1122,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  
>  	if (has_target()) {
>  		/* Update policy governor to the one used before hotplug. */
> -		gov = get_governor(policy->last_governor);
> +		if (policy->last_governor[0] != '\0')
> +			gov = get_governor(policy->last_governor);
>  		if (gov) {
>  			pr_debug("Restoring governor %s for cpu %d\n",
>  				 gov->name, policy->cpu);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

