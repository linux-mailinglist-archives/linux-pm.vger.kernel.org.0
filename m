Return-Path: <linux-pm+bounces-38863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 622C4C90EBF
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 07:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 109A634D788
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 06:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA676289367;
	Fri, 28 Nov 2025 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSXTFQQF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251EC274650
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764310237; cv=none; b=SkrlqRVRpz1/+6gQ/PTgXlSxeXEr8thRlAgO+Jpe4AqTJGtMcqbfj6nctKGivu9AuSUABiA28DXSP/HsRj1+XNx34nO50kU0OnHeoLXOqsYJJ6UMA+ABwR57UGEDFnlUhMH11EZ8Q78dP81YTjdh4lavrc+hyap0bgxsRVpdlkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764310237; c=relaxed/simple;
	bh=xlB7ekvm3fkdq/sJWSuBsDeqyZPaVM/xrQ10yfw2s+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZzBK/iiKybWF9DLqdj5iEdusFy2u1jVJvLcJgPLK9wq7H7t7ZtAU92OpY6umEZADpeiNcQzcwyD/riGapmW5z8HDv3R8CrR1JkjVUYiXnms7MQQmLOyGnk7UlzhVMlzDZ4cwxF2/0mlfec0vsbu9cdmFLt2YXvdQD9dCoDZ4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kSXTFQQF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2980d9b7df5so17935985ad.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 22:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764310235; x=1764915035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZP7Q3HtO7Fe5sFGKP6FjZjTY6GVg1B0G3qavIwvIV0=;
        b=kSXTFQQF5s38CkhVrNgtbgrvYQ+ThYpq1Kgf7u4p5rIecZ9Ul8j9QdtrJZW39fjPZi
         6dViV17nsHoX2FBk79hgTdzNhG4pvKjNN1YP6otsz75GbelKifKD9wVRX0qoEp2MrchY
         5iwOK2tD1fNXfXaIg2q0M23i4yJnYku59vSsCPR4YhnrNXKIpUDnXyKlCqO0RADyYv9P
         Z3pZ/t908YjQWXzenyAzu9REHLeGOMJY3G/47/9rubOK9ynM7Tw1xvEeoI4HrDVEdee9
         S+8SaW0VHnhBOwDUNdqMjC3/5NnDELpyVssIl/LcxX8iJP93DRocppAjvOexSNFWKRsk
         GhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764310235; x=1764915035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZP7Q3HtO7Fe5sFGKP6FjZjTY6GVg1B0G3qavIwvIV0=;
        b=dhJUcDXG/r0vd2juDKtTGhhxHXZ42mvWT0DquZRGuWJwdmD6HNUvRuubSblz0yn7So
         T5z9FNJB3ygWJ9gP+Hfre28KbLiYI4aUUYxriRUwgrOrqKV6lY/L5Qr6Pu4anaRYloKG
         3iZOnc0mSW6/ZKDpU1GzEabB/jFO/HTR3YyGkLhctjA32CM6X1+/S05N8xzSAizp9CxT
         68eATlaXpyqr7YbUs6gncdfLZogX1V4FZ8DC7cEF4cbUq3M7v+0NAF77lK3dTBrNh04w
         SuZa3fTjqBJJ6SeSXESp24O4gZSNtTIvCQCbtTDi1HZHQ/RKzLyy40E8mv8pbJtdKOb0
         wDKA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Uf/ptwWn0gnRsgGA6s87g4JUzdFTVvFSWdgJlhUMieNMokUVC9SgVwS1yACmI6iTWhP6YC+Nnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsz+iezeR1tWN66mhONuSax/cZUTUBydB0NdFB5uWos2Rt21zi
	5A/GyiEGsn3zCoRCgdKRN3cxWRhr0i/H9aOAk4sUe+HZRlpNWx7wtwCj7K7icuLCfRg=
X-Gm-Gg: ASbGncvmpDAG38U3Vk76sUSUYJx4QDj3tOhL6lcWzuMawlKJJowy5Jy6i4IxjD+0poW
	D0wsNriPNf5uPL9PYNGUt762toc/gHAiZM5hB5YS+Pzi56tZ3/Y2/Pm5KwNJvAgu40ncXtwJuX0
	T07rO4Ij1U8p/m8/4qSBuYTu3QSwrXHO4No0dkKPumpyhXZDUsslktwVqeBGVTazsbzTn50lBP6
	9++fDIvHhsy+r0YGTfWFazgte3ZA48uuHKN39s207AADKTMBDjmo/tPcvbvTitLyaeK+CE3sEji
	+iINf5nTwLI1bhXKXUu0FsDMLxzMQgxbe0Lnd4I8PfYbdMyM1PqmqlGkATHjHqANLq0IyigIRP4
	2J5pIkrdi6MBm4smM44kjKj7m0c0Wh8e1wSeBlBJiYJhaICgdQChKrJjjtlV1CyNps09NFxkRbJ
	NwI5l2HGopt8c=
X-Google-Smtp-Source: AGHT+IEuOIrlb2uKfthmjQ/fkqTAeph1dEvbgTG+u55xHJOAWP+FCXmpHzrQSYfzVAUWrE504jmVAw==
X-Received: by 2002:a17:903:903:b0:295:9db1:ff4b with SMTP id d9443c01a7336-29b6be8b66dmr292926505ad.4.1764310235150;
        Thu, 27 Nov 2025 22:10:35 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40a60asm35169095ad.19.2025.11.27.22.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 22:10:34 -0800 (PST)
Date: Fri, 28 Nov 2025 11:40:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH] cpufreq: Return -EINVAL if no policy is boost supported
Message-ID: <4ucp2ovws2u7fowdxbthfclqqoolpt2h7le3w5mzltwpcp64x4@dmevlrjetgh2>
References: <20251126031916.3641176-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126031916.3641176-1-zhenglifeng1@huawei.com>

On 26-11-25, 11:19, Lifeng Zheng wrote:
> In cpufreq_boost_trigger_state(), if all the policies are boost
> unsupported, policy_set_boost() will not be called and this function will
> return 0. But it is better to return an error to indicate that the platform
> doesn't support boost.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e8d7544b77b8..2df714b24074 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2806,7 +2806,9 @@ static int cpufreq_boost_trigger_state(int state)
>  {
>  	struct cpufreq_policy *policy;
>  	unsigned long flags;
> -	int ret = 0;
> +
> +	/* Return -EINVAL if no policy is boost supported. */

Remove the comment and blank line.

> +	int ret = -EINVAL;

EOPNOTSUPP instead ?

-- 
viresh

