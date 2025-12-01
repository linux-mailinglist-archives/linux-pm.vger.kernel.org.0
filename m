Return-Path: <linux-pm+bounces-38946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA32BC95A98
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 04:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5075D3420EE
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 03:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A6419E97F;
	Mon,  1 Dec 2025 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ho+M+1j1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0C13FEE
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764560564; cv=none; b=RKojUzfZEwuOBZKbMG+tN8z3NNY6qkDe6t+i0HwfQOPF9m+k8bA8w+ujXtlCCN+9TKbDwAl6raekkSKsnpMdcfPjrKh/Az32u3UfQTxoRXAimpWwVfiXGVzXGe7Q94f+1DSmnxV6HoeF6AFdL5YF2EFCpjOWUZ9Wo6CWp+PYwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764560564; c=relaxed/simple;
	bh=zJy4lX254HGlA7b2+TfHzCFfQZXzsi0/8hlJs/UAVEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NX7wUXJulEA1gb0jjmZ22r6U5yGe5X5ksxXDnV4vlTl5dkzLSAgN4C6PtqQoUYr8ju3hPtTCqrQpdKsj2LtFMQ5IF47IMmDZODucb+RX0077px0i0pfGja5N4MQyLG5iTIx3G2cgx4dHjJLkVbDQdjgEouN65jFr9JAr6ECmXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ho+M+1j1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2958db8ae4fso36204035ad.2
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 19:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764560562; x=1765165362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYxISHR5qdK/0G8jzk0V8tf5itaDFqQvQ3I97psPY+8=;
        b=Ho+M+1j1x70TNKPJMtUTyiAI8W0CRb+bn/OPkyUkgXS5cQwsxgBkUAR5RW6/v9Uy3l
         BhQz9FxzmeOkRwbecl8JQT9t8w9kFveC3vLj7pk8nofz7eTWbZ2GrZezIHCL5FXT8Zne
         f9GUlrIGyL0paOPU+9ckgzzkqqN+/rSWA4qDo6y+Ijau3fNYySYyA9hebm6Bn/D0/f4P
         LduFelsUwRNukHfknAncKmOaDsZFRDmKepYzdUJxiGkn/T+P//65CXqLRfbrsNF+c9L7
         t8NqduaBB6YAOukV0q8TEc1aQquUR+0STHDOa/3T16FkL/jhoV1LcmoO3fVJLzXm5cA1
         dHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764560562; x=1765165362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYxISHR5qdK/0G8jzk0V8tf5itaDFqQvQ3I97psPY+8=;
        b=Q+a0hKvVWhDU9N6I8Ww2ALyNJrGkSo0sHjK37K6+Ze5zrZAqllut2yfmwV7hLuZXHF
         VMzrBDlHozkZ9eNAHAxavA3H4v7Tb48xZsGlfLFWuN1WXtuYwvzudc743w4d6Ixq/W0H
         iTI3YL24YCr4zbVzwSzWeki6wbDh3a98j4IqvSpNzq5+6dcLgtkLHI3Gipq5ylLzwZQQ
         0rCYCTMhF3TjruPjWPFfaSn5Giyd6R5GzgajvuLMFgicFU1YmLHpQ/4Oc/ZnjDb2wn0i
         zHQlaGrwYoQ2JbwlZ4iyBhHGmL33QdcwjIjjj41K2FsLyI4F+CRKgUgGFaBbgoa8kA+l
         IDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtVYAlErI8oPEPX+OLz94kO7uuD+A6514my/x2qi25JoIhl7qmP+ko/wRRyWZPz2uW9HYCIdYe2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrL4rvQCLBXJprF/taySBzzOz/iuD8RRkZCwpItRiQ2paYVADl
	5iQtQM3P+QhN1dnc0KzI8Zbonf3nf5/3w75sSsZBnBrGQPBWzdlq0hZ7c2pSMiIhPyQ=
X-Gm-Gg: ASbGncuHx6E+BTWxyR/0dlOxvRAaCheOS8cf8NiClcbSavycrs9AlmHij7T0qSf+4Fw
	2T1fVJwuDjB+mPDuzJ41IeK6cG5JXc0kk/Yphxtuc8MrMuySETr/ZZCNf79mN3OrkgMkpZRXnA8
	GTQWbF1Hca8a2LAqDPekUPkp/el4tW9BCIFhIULvRjOKCD4s8g4EEGv6rRnLW41usFlF8zjiI7C
	m/fuFJnlAyXrmivrHSFdo1vj826pCDo++eGTTtx6pHbghR9btHyFzSVFNlcI6la+S5D0sNpSIkQ
	Rb+duG5jVgQVGVg49qt23se2NwAVl1CZHxFmJUl6M88Whgg8eLK78qkDDZSjeKXqVAyDp2zT7hr
	eSlbXMyuqIbiowMSlKTjKhCKDdVDo6a16qDSnoBKY6TgwwHPWUESo14PBFSmUBdOFU5ubaY2kjW
	6oNUeHfDYX+BI=
X-Google-Smtp-Source: AGHT+IH7L/RC/EGkcM2CMz9J0BN/xblMHKgkEXrXrV6/rdF+0DuIiABB1MEVvppcBXT5gu2Qdgh9hQ==
X-Received: by 2002:a17:903:2c9:b0:298:cb9:6ff2 with SMTP id d9443c01a7336-29b6c3e3f1bmr365856565ad.15.1764560562317;
        Sun, 30 Nov 2025 19:42:42 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40ab81sm106778145ad.3.2025.11.30.19.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 19:42:41 -0800 (PST)
Date: Mon, 1 Dec 2025 09:12:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH v2 2/2] cpufreq: cpufreq_boost_trigger_state()
 optimization
Message-ID: <3t6quaz6j5mbzewgrszuzmjmv74bzqrskx5k4ewgsfbaijmoli@y7goctaq35mj>
References: <20251128091352.1969333-1-zhenglifeng1@huawei.com>
 <20251128091352.1969333-3-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128091352.1969333-3-zhenglifeng1@huawei.com>

On 28-11-25, 17:13, Lifeng Zheng wrote:
> Simplify the error handling branch code in cpufreq_boost_trigger_state().
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a4399e5490da..a725747572c9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2824,18 +2824,13 @@ static int cpufreq_boost_trigger_state(int state)
>  
>  		ret = policy_set_boost(policy, state);
>  		if (ret)
> -			goto err_reset_state;
> +			break;
>  	}
>  
> -	if (ret)
> -		goto err_reset_state;
> -
>  	cpus_read_unlock();
>  
> -	return 0;
> -
> -err_reset_state:
> -	cpus_read_unlock();
> +	if (!ret)

Maybe we can make this `if (likely(!ret))`

> +		return 0;
>  
>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
>  	cpufreq_driver->boost_enabled = !state;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

