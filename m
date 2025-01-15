Return-Path: <linux-pm+bounces-20482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B54A12257
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 12:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1BD1694B8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C822F1E9909;
	Wed, 15 Jan 2025 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svCAF1/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C611E98F7
	for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939937; cv=none; b=fI4D4aYlt1ud45h3nmbIh0th+kJOp+UbSylnGSm03teevGVU0q7REPP7sWjE4JxoHQkiJuhiF0Qh9VcSG9XU/RKFUjnuwrbPqUEUHGQIE7C2YsMZeTuJTbApLtephtH2GjqGt+SELapzOqfsgGCUMJPOZvFN6SGH/3mOH9s6FiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939937; c=relaxed/simple;
	bh=LMAx3aQ3tr/+4xQlrM1fIVpNQ7/15mRu9KbyMLrR0SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9rfqULMJWDTn9Ql5+l4tx0PwP65cBbSHUvlbkCD8vIZ7imEgEl8uJR91LtUNAQ/z59hXci8OBRZ1amTu8ECxfbQpdXCsIR6Y1alW+euVGg2d4H8/uXWPEVWoIXdR3HiZXhCf3QRQ9cTZZlA7JwevdZCEoc812IMH6JlafJAYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=svCAF1/b; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2167141dfa1so13082565ad.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 03:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736939935; x=1737544735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqfkXRbUJMCh8cBTiV2yE9LjBiqhO1LbtQ4RE9MmtaM=;
        b=svCAF1/bgWKNUO922YSm6kai1y3hdG4WLuqrMXr6WVutPlqbjgjoeSnPAcvaZxhY7q
         x4XZCsvsoL9huuG5vg8rRmSq0pzSa9kPs2umbHOwMEbjZYGfyIjGNY6QKucttL62cRUv
         joQCbMpmxruFcQiA723GilaciZFLDQrCQz2Nao4EGNLwxXImHMMLXFlB6aRG4luJdvOh
         nEC60wioMCh8GC456BmGIgIw++xX9p1U8N4cXKGZucRV0bmMWqvB7Hqw2KytwU3C/gCn
         FrYBxYbxSLnqYi4Tlhzwh6eo/3WfZX7r2KK2tMJgX7ViE+dKHhYZ5NJXV/LRClTB3PAn
         gd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939935; x=1737544735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqfkXRbUJMCh8cBTiV2yE9LjBiqhO1LbtQ4RE9MmtaM=;
        b=ZxKS6Ui8qC37yXItocIZnEzXnCt9WlLJ43k1EDCjRpt+nytn+zfpv/YZuj8VGzJGgG
         E4/y4O6rauxHfpWfl4L8/yg5qHDCobc2i2QLH7iI+O9lUWE70KB0YKl65oLjuaZGM3n0
         muYbC3ZFY1rrzwcaKVGQIzdRR115tmsXP68z1N9kIdmwJ9QPmaoGHcZvMCuoiQBzMSoH
         /MfZh93O5sOx+fFLaW5oE6HLXb3PxjmEonGhNGJFI1UzeIL8EPb7H3v24TepLzhd2Cn+
         vMhOybxLqr2U7yr7vJZmp3fjMA16Pdg9zwMpmWmlapCTuVdYk8j4pRdYvpHMPHywQ6K1
         jA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmdHSHbDxFgb1aXG6vGvhQUFEuW9wgoW06ToMX+SVyEnzqGcoL5oHJjV8MZFXQT2yNZZvuiKu+dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1lSZ2TwPtbou/pVuAGbaCOrKcvkyPK/U2ononwsKypcMd76S
	nLtm9FcSGF/A2/vRvxSrq0mhQDf1XZ3UIzlAEXN5FblO6+6wnq7JBiHQFwhlIEI=
X-Gm-Gg: ASbGnct4eO7fWCLbDRq8fl7U0t+xaMWelwVI8Q82hwsei67tU0KUfC7OyvlyruT8sG4
	iMvJIdt8drtVGwe/oIURolIez75AN1DbO6Sh1GzrZBdIst8ayQZbFgFSZe3E7fBO3LMuuoh53/M
	yNRGYKPWX6gls2DKTjz74hcsC2bPy+6RYq+9wqC+CjWyS2I2iqr+M4Da1qNNmWdGYCU9MbBDkUt
	JlgEGBhpg/8tYEjGHWrQnUU+LRQNiabbZCIyPLRf2rz0M+k2ieOMD4AKek=
X-Google-Smtp-Source: AGHT+IHP48mslcDUkaDMbpAtO1zSP55tzjmEN2NpfWla74Q81rt1Y5Vixf+U0wGkqJoOTchJlUVCqw==
X-Received: by 2002:a17:902:d343:b0:215:8847:4377 with SMTP id d9443c01a7336-21bf0cd9719mr29629395ad.15.1736939935487;
        Wed, 15 Jan 2025 03:18:55 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219b7fsm80849095ad.116.2025.01.15.03.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:18:54 -0800 (PST)
Date: Wed, 15 Jan 2025 16:48:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH 1/2] cpufreq: Fix re-boost issue after hotplugging a cpu
Message-ID: <20250115111852.hluxcprc7cbrxqtc@vireshk-i7>
References: <20250115100123.241110-1-zhenglifeng1@huawei.com>
 <20250115100123.241110-2-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115100123.241110-2-zhenglifeng1@huawei.com>

On 15-01-25, 18:01, Lifeng Zheng wrote:
> It turns out that cpuX will stay on the base frequency after performing
> these operations:
> 
> 1. boost all cpus: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> 2. offline the cpu: echo 0 > /sys/devices/system/cpu/cpuX/online
> 
> 3. deboost all cpus: echo 0 > /sys/devices/system/cpu/cpufreq/boost
> 
> 4. online the cpu: echo 1 > /sys/devices/system/cpu/cpuX/online
> 
> 5. boost all cpus again: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> This is because max_freq_req of the policy is not updated during the
> online process, and the value of max_freq_req before the last offline is
> retained. When the CPU is boosted again, freq_qos_update_request() will
> do nothing because the old value is the same as the new one. This causes
> the CPU stay on the base frequency. Update max_freq_req (and
> min_freq_req of course) in cpufreq_online() will solve this problem.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1a4cae54a01b..03ae879d50b9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1475,6 +1475,13 @@ static int cpufreq_online(unsigned int cpu)
>  
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				CPUFREQ_CREATE_POLICY, policy);
> +	} else {
> +		ret = freq_qos_update_request(policy->min_freq_req, policy->min);

This may not be required, as min-freq-req is never updated.

> +		if (ret < 0)
> +			goto out_destroy_policy;
> +		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> +		if (ret < 0)
> +			goto out_destroy_policy;
>  	}
>  
>  	if (cpufreq_driver->get && has_target()) {
> -- 
> 2.33.0

-- 
viresh

