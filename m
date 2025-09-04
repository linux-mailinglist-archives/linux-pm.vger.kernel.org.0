Return-Path: <linux-pm+bounces-33788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E18B43160
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDA1E4E53A5
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 04:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C63233722;
	Thu,  4 Sep 2025 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vc0qXbbq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C60226CEB
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961298; cv=none; b=d/EwvRwpkEfgJ6z7G8cgJCNIaJtygq1Cbqmus4clU9QdQFeFh8a2jUOu5Ia70xgXWCjKRFdLPXaotaj8qIcNmbtbKogFsi9vIuO+Gp3a54qH0N+5yjcNYyMIIaUxy08bplt7k9wPIy+KngAQTaQOo3APU/++yJmncjjfCc0UBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961298; c=relaxed/simple;
	bh=5gGSzTrvBBYF22J+UUhj6V0Z7NBjpjQbuN932TPUw/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QysS133bDzGq0gk12HelFSu3HjutdNbxjfNT03jyAfsHGqnQXTH9Ot+aWYUYgFjuUbHGaWbbnP83qiCSenxo9k8zl4CDKNDA6RSGSTN5DEYCOXdl3yaSWLqh2LjSDc/9CFqpx0hYIvLPLexL1K1mSaeX1eKcnZfrdfTPTWUh6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vc0qXbbq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77287fb79d3so604228b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 21:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756961296; x=1757566096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F0p1lwqdDVIJVajGYr/mU8WzHwecynjQcLCSTh1yP2k=;
        b=Vc0qXbbqg4iG4etZL+d2nLUyI/JMQTR2wHfnmHPMYK1Yu07ywvR2LUjgyNJ2yVQhVH
         YYKpymhfzY/1WiW3iWlbOBkM3I1kQLCwuikqyubfHfb98AoLnTwwD4N1d4qz3QhuxJcT
         RuaJfp8dvymvCHI6ikMZjC7yZLcNPp6lRJUky6XnDt+M7AgUaRweoohjMqboLU8YTbDD
         u+C3bMvo7fZqSLjJH+IPrETS3Gd5++Optu7ni1zUjU5VYvvectwlHqk9iFSJ/KLxt5u3
         ixZx/KxkcyePdPYOQvOlJZ9ikQWI6pO/dDW+Jaf9Kqmt4+WLdMzcG9xnQVeFBSHLwV3n
         cDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961296; x=1757566096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0p1lwqdDVIJVajGYr/mU8WzHwecynjQcLCSTh1yP2k=;
        b=kZ3En8DmSulQcGJGuoeM0lW5D/pIWW2zlBo1BsPb5no4TjW8yJnH6/XdwaII+YRvPv
         V34cHeIScZf4KcXRq2CVM9MkxTh0wwGKCP9JxaLSjIWeGoJz/bvUGhGfIKDMIoI7E8RC
         omfDlbwa75OjPVHpMqvVz0X3jJojZ3G4zM18Si4OXrwYcttF/4JVisMRETr5GV63vy1s
         u5rUsHZCGuGgQdRyuOBRRITCVF8BDM2bf4k8jdRS/e70J3nilysOIUSLka3dOBUbxg41
         Ms7n5z8wasXu2j4OzXitGtLp3hXUaNFYgmNhscjqhag2WhGr6/ERYeE4qJnct5YD1hoB
         PVNw==
X-Forwarded-Encrypted: i=1; AJvYcCUVcIXGRfVGsP8dOjxfay9zPKLO1cfBZDvvMs9UYRG4Qme5XzFnidhxXGqFdMw1g2rYQ8Z9MmzA5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLQKS3UGKAy2dCc4jgqeRlwLtb92hs6v5nZgHnCshbnJyRXRy
	f+I/9WLguBJJpK6C1zd0Pn2o35hsRewaLCho7QeKIxd/zg7ar9tN4Gb7MTvAeN7d6pGuG4RUhNn
	Czbrn
X-Gm-Gg: ASbGnctlUVzGMS4rrsgNrrOQJZXxG+wHDtTWbsvBRLUqMq0YEX5p88IufmwGI8960Nc
	dHjoo9zDxw2Z4syU+38r6+7UuFBytObZXenBtZfxYz4NqANkQD/sDOVhGsTYDr9dZzUv5EzJsNK
	b8u2QOj52i0ryvfgzffYQBGCdcYdl2lhqr0Zkk4fHGkqpxC41LoZpIR4uYcVKtR46GDSs2oN98e
	hy74jAoo5+5NgtZYnMJqDfbfYMMMY+HX2VNWDZlNoNIfQSRO36LACRbIjMus4G/ediXXcZrCj3y
	NkI2L1Y7Qix2uo1SjcQg3tB639ZYI/pgefrmJ14xYH5UlGBZcoGjaDXAQRu1lu2C3/R/pcpArtB
	c2U227LupI2lclQrcES8yQl+I3ctS/wqKnFA=
X-Google-Smtp-Source: AGHT+IFBkCuheM4gA9HcZq48WmM/cf+Qe1YyWVvICeZp8J+0dhqzifPOHeuJCWtafRAvrmuY9BL5ow==
X-Received: by 2002:a05:6a21:33a9:b0:247:76e4:d8e0 with SMTP id adf61e73a8af0-24776e4d9dfmr6750375637.31.1756961295905;
        Wed, 03 Sep 2025 21:48:15 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd48cesm24273848a91.19.2025.09.03.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:48:15 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:18:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even
 without frequency table
Message-ID: <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904032210.92978-3-zhangzihuan@kylinos.cn>

On 04-09-25, 11:22, Zihuan Zhang wrote:
> Currently, cpufreq_frequency_table_verify() simply returns when the driver’s
> frequency table is missing (policy->freq_table == NULL).
> This means that cpufreq_verify_within_cpu_limits() is not invoked in such
> cases, leaving policy->min and policy->max unchecked.
> 
> Some cpufreq drivers handle this manually by calling
> cpufreq_verify_within_cpu_limits() even when no frequency table is present,
> in order to ensure the policy stays within CPU limits.
> 
> To avoid this inconsistency and potential misuse, make
> cpufreq_generic_frequency_table_verify() always call
> cpufreq_verify_within_cpu_limits(), regardless of whether policy->freq_table
> is available. This unifies the behavior across all drivers and makes the helper
> safe to use universally.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/freq_table.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index d5111ee56e38..f4b05dcc479b 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -105,6 +105,7 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
>   */
>  int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy)
>  {
> +	cpufreq_verify_within_cpu_limits(policy);

So if we have a freq-table, we will call this twice now. Why make it
bad for the existing users ?

And then the name of this function, it is all about freq-table. If it
isn't there, not sure we should call it at all.

>  	if (!policy->freq_table)
>  		return -ENODEV;
>  
> -- 
> 2.25.1

-- 
viresh

