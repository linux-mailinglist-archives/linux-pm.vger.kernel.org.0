Return-Path: <linux-pm+bounces-38947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B57C95A9E
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 04:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E7D23422D2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 03:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723FA1E2858;
	Mon,  1 Dec 2025 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDnSe10W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B36FC5
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764560645; cv=none; b=jHYlj55Bm5HIJIkYLnAbldEc9qjKRmwUhriUZm3UsF+RXgcNFzHVGOUaFSfjksuU+W/ynTRQ4Vvzlak679vY0bvoddfOP52TXcxVTsTTQlSxouPGsWiwaBDboYxd0C+Ck61DTSVk4gMA37YiuHiNwH/nKX3SQNIYtIp3h77s65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764560645; c=relaxed/simple;
	bh=iw52ljfzNQWvS2B3DrSYcwhuV89aNQLjnlerLYxCmDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqaKDvLeF7rDHSAD1R/vAOovr2ONIek7ydEUEkocQduk49YjJOZS5i7PIkAaVmBrSlo/V2tml2zIKLpUxQbCDvK7jRZUVOGGgSc7jHodE26DsAbPesa26dHAG2S1DPFubvR6UoqJMGHA0cEbz6G2Am7bcgZ6E5nwkTfiBA64j+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NDnSe10W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297e982506fso48663545ad.2
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 19:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764560643; x=1765165443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1T8MyEFdva62pBv/9stu1+NVtTkVWobiurHEZ/QceqQ=;
        b=NDnSe10W8HtKlDbA615lh59DWkYnn+PJMQf4+ZPQIr86R+9NkslnxffKFLPqFORyag
         bRBCtHVq+BIWniv71d4srFsATF/HVGp1VQ8WfuW9fbFI5qoRaBKjGhTXc51jkwlCg5H7
         x/HhNUiUwA70POOZxfk2HvJqAUW6P42/GoYx9RgdiN0flFXvvCppTMYVlXfFzgaPWDnZ
         4LxY0zodsdJm3UVf05y/z71dQctC34fbHVcWvrB9mo9bmER/8s7hjLzJ59FrN6Q6zXAb
         74C5y3PSdMpCwwb6vlkbUZGOPOk3C93KrXuzcAhiOAK6CuNwP1NZVAMeXa0o/BBZFgxP
         NHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764560643; x=1765165443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1T8MyEFdva62pBv/9stu1+NVtTkVWobiurHEZ/QceqQ=;
        b=iLCUTn53aa/NL4ycoQRsmvYUUKSiDSLNvT4xMsjQnIC00HELPr+CcEGJdq8QaVkQOh
         SWDVHGTeY7OV1a7efXXuH/qhf1BXaV5hLa707IOWK9V1yWgqc8UbH40z07NIQTZAh2EH
         vn88pxcEKA65ESXtO89Ym8lNjMbfyHTMYJPYaSwCh2hWj173q55VudaqxzwxRIEW0j0a
         s/s/x3ehqojWzzMjqMTW9mkBrbm+doaC1GFZyMN8+urQ/jp4wAg/DVJeFM7CP3gL9J8F
         lMlnc9mck0Qi24s7p0yrLF2FY3x6Mi0gPb15vFLKesVhj10DOIijc181x60SMExe4mNs
         F6yw==
X-Forwarded-Encrypted: i=1; AJvYcCXiaeaGN4YkavszK0Ye7IyNxTw/rzx7JZzBYzT+tuk8OicYKPtq7A7WLpEFOvK/ev8WSmRHzincxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4NSrAH4fEcA9mgUlaG4oIPYaIQyGrg3HY6Sgn3RU7aRt0oDko
	KZzfFuN7P3HFXYMSAb695mkGfMttDEA6wSgE+Oa2QS/xxKn5dQJhaT5QHrQeDgToTKQ=
X-Gm-Gg: ASbGncs1lpToQR0yN2n3lSf4NkhE1+zWn3myqCDXXWkQXOjnQqaJ2csvvctgRg7+kGv
	m4QIZaogTaT1pXugjrHMXf0Y0M2mc2zot0Bhs4TbnrAJVl+juL6QJtXf/QcxUB+OYmQp71AOwvm
	L3fA1Iq41irWSOoTzXwf++Ml+/EHMCkWnWZOu3kPgBn/AA7Li2mFdY5BBHeiikSxmX4f3wRi/Zz
	E8VvZyCLJXSlKKwU3p4ThC+k7qmN0a/W2ANk0U6sIJHOq/xLt48PBQ4Fq+1xiyQjFj2TA6jZeP+
	uet2xjC9xRfDKEY7g101D6J0znUH+xq+uwiDZLP4jdeEpqbBPLNoo1y2K19iDHV4zzhS0cwNiX9
	B5RJGB/ZqL/u8XVYXk2MUKbXhDaHfN5m1FgwBburoKHHVJd1i0Kz+9TCMM9f09zjQJJswN3rOwX
	nCWE43jDgPbvI=
X-Google-Smtp-Source: AGHT+IGqwlpXp71c5O6fj+iEV5fFff0OQ4TGF3FQB6oei4+SJNlWmVqA0rGeh3RhxzFeVRFhdoLvuA==
X-Received: by 2002:a17:903:2ac5:b0:295:9871:81dd with SMTP id d9443c01a7336-29b6bedb625mr394811905ad.25.1764560642817;
        Sun, 30 Nov 2025 19:44:02 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be509d59f9dsm10750344a12.32.2025.11.30.19.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 19:44:02 -0800 (PST)
Date: Mon, 1 Dec 2025 09:13:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH v2 1/2] cpufreq: Return -EOPNOTSUPP if no policy is boost
 supported
Message-ID: <bgxodgc7glo2hwbam5lmj6fo3x7ngoymncxydm2bduf3aoz22q@uri54qj4q6ju>
References: <20251128091352.1969333-1-zhenglifeng1@huawei.com>
 <20251128091352.1969333-2-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128091352.1969333-2-zhenglifeng1@huawei.com>

On 28-11-25, 17:13, Lifeng Zheng wrote:
> In cpufreq_boost_trigger_state(), if all the policies are boost
> unsupported, policy_set_boost() will not be called and this function will
> return 0. But it is better to return an error to indicate that the platform
> doesn't support boost.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e8d7544b77b8..a4399e5490da 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2806,7 +2806,7 @@ static int cpufreq_boost_trigger_state(int state)
>  {
>  	struct cpufreq_policy *policy;
>  	unsigned long flags;
> -	int ret = 0;
> +	int ret = -EOPNOTSUPP;
>  
>  	/*
>  	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
> @@ -2826,6 +2826,10 @@ static int cpufreq_boost_trigger_state(int state)
>  		if (ret)
>  			goto err_reset_state;
>  	}
> +
> +	if (ret)
> +		goto err_reset_state;
> +
>  	cpus_read_unlock();
>  
>  	return 0;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

