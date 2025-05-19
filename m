Return-Path: <linux-pm+bounces-27332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34862ABBA8D
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 12:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F95164724
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D326AAAE;
	Mon, 19 May 2025 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvZNcLbX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04833086
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649061; cv=none; b=Kv9CA3hXxnkvhU4yqsOXrFRaoPXqLQK3eIJ+IHi0SAbOObJsjgvswAZd0eK9DysPcEbmZCRAPGfwoXStbCiKMgp2jGticnIGQT71CO5vkROd5bluaLgpL9KY0qR+b4IniuEmLcW84eMASzllgM89eWiExkbpha/W4k/ig8RQyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649061; c=relaxed/simple;
	bh=A2dpHN2sEArEhvFdNCYfmCtLjsUgITLXWvLvTrLuVBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMb+n37rKNKzcgGXGXYRHp24/TACLBRfyy6Fpbjz74tirCjCrn2wwHrbDeypRZkPZGFPibtLjUD/hmlrriP9QPNU6KmjW2JP0NFCnUkVNEGrcmlH3Wx2/4ls38e2lRHcfrfY8cP+3nRRe7e2+9BA09px6Ozf2BkLW6hvtUrNroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WvZNcLbX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c035f2afso789804b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747649059; x=1748253859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YtPqJD96+AiahoiLJUfGwNDiBMARBZnTBQnE7bF3oI=;
        b=WvZNcLbXhzvZMpHu2RQSADGOOFz2wJsI1vwDb/Eeqo1Th0ZuvMr64BU/PtzN+7khSc
         feWXkTwtELhjB10GcJueP4le41gB+eLzQIazeVhEYTSAATAHPN1B5CmgqaaMfj3cO+/g
         W/B+JdaslYpdQ72Ci8zvrbNLVjbpBWeWlsXnxqWQTp9Tyx/ewTrZSYGh39cvQup3b9gx
         xTm15MTrodAzsq6cekciQ0pb74Dbjw7A3pkvjm7HGBVFrQFGY8Nd0RxjuxidSLoDsKKa
         iFYWXB6KQbrRN+7/+VLBFJo4bhqje6j/PHCvHkrih14EOoziGyBYpFlHlNXESzNu0If8
         YHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649059; x=1748253859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YtPqJD96+AiahoiLJUfGwNDiBMARBZnTBQnE7bF3oI=;
        b=t73yi9Zd91l4bIy3/ww7ZTfOFIuIRzMBzmSAd7LUMubmJc/xi8s5gdFmyw2GinMfMS
         MuFvUQZ3sx4Q+mLjhx1oYM5atvSBhSo5M5aXLo4tnK98DE5mh8TIDmHFSNdfil/yvVSU
         gDUKxLhPQp4qjpr2mhfz2caLYxRRQtgf7WHS4p/aQZ+GhvzhconRnkcc0HYSrah/j4EX
         12VKdvVGqlhUQneyWbiQ2X1pi1oxuDP/0Y1SzM4onqe0tcNBiFioid50bjf5XL+JMhpL
         CAlj6LVJUDQMonk/0zZ54/OB88esAqkZXwys8PNPy7caDqgUIqibQRUfmBkVgH/KdY8l
         2Uhg==
X-Forwarded-Encrypted: i=1; AJvYcCUA2pQulaL3TRCkl+kyIIw/vaKpO9pGORa4A1jISLUqnpki9m2g60aPFxM7Fg5Rz4ahSpZxpdPEyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvKU0wxQrqNgmhfYVntkxoGRXMZotZBYg7SciL5rnHAqhnzg8U
	ywLWNjo/hsXD9XVH9rHspNgCktjVId7/EdFyk4EMLEfAnjBFZ+VSPOi9w2faJ+aoONc=
X-Gm-Gg: ASbGncsbUyrtfcuQN9CucGodgzZq22yySSo71ynSOp4MKlSgphtdnvR3DNAFAvwijJW
	YclEt7I80be/fpEGReKfFgWK/aN7BGDg9irYaFskuhA757PCHW5swHI3CK8BPD7eILE31fl9Dax
	34T4aLHD67z+IY2hu8mZH7sY2IfeFhCZWJLO1VVKQv1/3sSpeOHcTg9lnqxcIRc+0eTu+pav1BZ
	yUwJMzCfQ3ul7LNrAzfglaqwjhhY160s+TC9zaUlgOpsYiPBQ6bXcr/nCFpkJIWmPHR4Dol/Szl
	RNKoUzXXINbaqYlv9c5ZQKHKznoy/FKuHk+/0Ry537UA5hhGahz20ORxlmYBSoM=
X-Google-Smtp-Source: AGHT+IGEnvVwZRiTsCwUsGjKmnNCAfKCTA6Ra5Mk20OfWP5M786bdcXDJyaBb9y/Cv6azGJ88xUN1w==
X-Received: by 2002:a05:6a00:91d3:b0:73e:2d7a:8fc0 with SMTP id d2e1a72fcca58-742a9786a79mr15783828b3a.1.1747649059593;
        Mon, 19 May 2025 03:04:19 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9877030sm6014959b3a.148.2025.05.19.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:04:19 -0700 (PDT)
Date: Mon, 19 May 2025 15:34:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bowen Yu <yubowen8@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	zhanjie9@hisilicon.com, jonathan.cameron@huawei.com,
	lihuisong@huawei.com, zhenglifeng1@huawei.com,
	cenxinghai@h-partners.com
Subject: Re: [PATCH] cpufreq: Update sscanf() to kstrtouint()
Message-ID: <20250519100416.fjixyqgbgk44pgps@vireshk-i7>
References: <20250519070938.931396-1-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519070938.931396-1-yubowen8@huawei.com>

On 19-05-25, 15:09, Bowen Yu wrote:
> In store_scaling_setspeed(), sscanf is still used to read to sysfs.
> Newer kstrtox provide more features including overflow protection,
> better errorhandling and allows for other systems of numeration. It
> is therefore better to update sscanf() to kstrtouint().
> 
> Signed-off-by: Bowen Yu <yubowen8@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index be727da0be4d..0c842edd1a76 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -920,9 +920,9 @@ static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
>  	if (!policy->governor || !policy->governor->store_setspeed)
>  		return -EINVAL;
>  
> -	ret = sscanf(buf, "%u", &freq);
> -	if (ret != 1)
> -		return -EINVAL;
> +	ret = kstrtouint(buf, 0, &freq);
> +	if (ret)
> +		return ret;
>  
>  	policy->governor->store_setspeed(policy, freq);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

