Return-Path: <linux-pm+bounces-40413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81390D010AC
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 06:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 917373007C42
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 05:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067CD2D063E;
	Thu,  8 Jan 2026 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjGM/IEF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109721B9D2
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 05:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767849061; cv=none; b=n4rd01LPl66tNwmScLxm9iGQflEIet1tC+0PYrbeVv4su8Hwm2jJ7DOMBaK82ye/h8C0eaU2BnRetB80w3XfsJEbDus9132oZylUDOCUb5Id44zMxAXBkY5pY4LvhNcOmMvQ5Ko3a/KhT7M5AC+1Yd0zWu1ZQbmA01tHWOt+y7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767849061; c=relaxed/simple;
	bh=VXxnah1x2d9GGzY41dM2JoMc0maLlQyRzfgRvBuSoL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv561qNIinm7l7PtbYCrIgiOkCIuHBOT46xJyAmkFzpTIGqjMHgSSVvnD+iBx5LNFHCDMYpe8fs3rk9LMNcfXEyabIP0vgvYUziGNIf7Dj/RN7KgAwgyX+Gu7C0b16fzy8rcKd2vCQLeCrU1yLE6fyR8gOXOSL9b/qbJIxWNdU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjGM/IEF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so778137b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 21:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767849060; x=1768453860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=40EnuJ3ef2LESW3TSa5O0feN8luAtK8Za0oTH4nJoSc=;
        b=jjGM/IEFETbf2XEH+kak/mx7MprnEq6nVdYsYzRC9ze0PxLB9Xvti/PBfxJoToSaF7
         F8jA2xzvCWt8hwU6xXS3FiZc95B/xEhtQ8cqLFpFutaZUF98F+ItUKjM2sTSnUGSPDa/
         bo1ERV/Smo6sY3vDO+DLPWTqNsuUivERyhULnozOhO8wW+MVDZ8BRGfSekSDupoUj7kO
         rGdbKbEfJg3KYmWTqtLJ02cNDln7piTA0NC+u2pHOtAjOPn1b4mF2WtkVbHSaan/Uri6
         a2XQChaxHJiMzwsGBi/f2l0BfH+RsWaFuc5w/8mlQrCzv+ZkeZ/fXojxtgYh2t4mdX+a
         rsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767849060; x=1768453860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40EnuJ3ef2LESW3TSa5O0feN8luAtK8Za0oTH4nJoSc=;
        b=AUWRwon/9kaxie7m2iHoVZvJg85YkKAQAXoVH8j0fcWI+fOGAImDjt1Uxes1Mcwy+N
         ygvjZlPIC5VWGwe4wQ17K7CHo+t6F/FvLakey3/fcNT3biYuOIZ6qnyfFIzGLvFMhlqc
         0JWr22e5qAksi9G58NI/R/J6xP3gh4vGcPCDyqUeiALUq8q5ZLcCi3MtlO3Zq/Lmt64y
         D5S9n3XI86VjlpRRE5UhuS6e75FdVuk3FkQvuOKEz5apLic/zSPc9kUjvjsOx64JRGFT
         gbhc9HFDYUOHP9q1dX7wF3H0j0YAQQ4NWUBh4zog+Y4SwihFaLP6cooEj0QnqpVdhocx
         1GRg==
X-Forwarded-Encrypted: i=1; AJvYcCXpdiViYBQLiMqwSo7k2yQUKEQnchkQY9pJ5ooobyMFnft2Lp5pM1B3KqqVLxAZllh4TlnTRHbvdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41/Kn6UhCZI8TYGtAIX9vqZKv8eEG2WEQGECJcyfIm8klQHni
	gQJmSLXf1EcETHXZlIpJfoXJ6R65vY2Ng/Ea/FDaWHj2ZtFCVgs4czrafyOl4BjZ/h4=
X-Gm-Gg: AY/fxX5CIKpSp2/Do92GaSef8KsgjPduHEs3t2v0Y9hKyGMkDm0P1CZt7n4qjZt2rax
	dPO7/OzY6NLHb/k/Q/+KMwKbiusJ6I91Dw15vfsUVdarHon4YuZNz0oyzfoOM3jJl84N578HRWR
	RZhR8RDTJFiN1GZvLAUMnBEf6ub4aV8yqzfDgXUKQjR0lGHemoh88pjDegdeETS20yUtLTyxLgH
	MeeFdhIbFnWzp0KzmlsGwWN+TTWrH/AMXUVdlo9hrwl+Hu6jLObfKJoISjVQMUSA8Oe+DVOLV7p
	cjAL+1HLnIJvGsDvpXCbU7vq5o+2wNDNuy7ZM6vT+qOu6/PmmzAx1Ryc3Z24lIksfvSRM2nfEBe
	rm36miVdo/5nyu9VFFGdwQZH310v9+YFd+aGVTu7YJBYO/YPE5cuRyS7loYi/7OXjNAcBT2VLdP
	1XUgnEE50hn1E=
X-Google-Smtp-Source: AGHT+IGFOyWI6bkncB9KsV9cTjw5eg9G3Qc1DthQ6nwYVFopnLtcKiu3ezjjos9lRk6tr2fjzTF5Ow==
X-Received: by 2002:a05:6a00:35ce:b0:7e8:3fcb:bc4b with SMTP id d2e1a72fcca58-81b789aa830mr4485815b3a.32.1767849059531;
        Wed, 07 Jan 2026 21:10:59 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5edcd90sm6281206b3a.66.2026.01.07.21.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 21:10:58 -0800 (PST)
Date: Thu, 8 Jan 2026 10:40:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, 
	Christian Loehle <christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	zhenglifeng1@huawei.com, Jie Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] cpufreq: Centralize boost freq QoS requests
Message-ID: <p4t3tvjiew7hmeibwz36h6htt3kkpv5c44b3thcdygltatubsa@jxjwycjzbnyt>
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-3-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208105933.1369125-3-pierre.gondois@arm.com>

On 08-12-25, 11:59, Pierre Gondois wrote:
> policy_set_boost() calls the cpufreq set_boost callback.
> Update the newly added boost_freq_req request from there:
> - whenever boost is toggled
> - to cover all possible paths
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 942416f2741b0..65ef0fa70c388 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -603,10 +603,18 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>  	policy->boost_enabled = enable;
>  
>  	ret = cpufreq_driver->set_boost(policy, enable);
> -	if (ret)
> +	if (ret) {
>  		policy->boost_enabled = !policy->boost_enabled;
> +		return ret;
> +	}
>  
> -	return ret;
> +	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
> +	if (ret < 0) {
> +		policy->boost_enabled = !policy->boost_enabled;

what about calling set_boost() as well on failure to reverse prev change ?

> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static ssize_t store_local_boost(struct cpufreq_policy *policy,
> -- 
> 2.43.0

-- 
viresh

