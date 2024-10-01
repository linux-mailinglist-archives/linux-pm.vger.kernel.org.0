Return-Path: <linux-pm+bounces-14986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE998B3BE
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 07:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29EA1F232DF
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 05:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D42B1BBBD3;
	Tue,  1 Oct 2024 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0bH1mhA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB7E74E09
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761152; cv=none; b=VHWnJNK4ujnbyhKbBH1K5yx37gUp0saexvwPxdvgh6PYJsAW3H/O8y0p1HzkE7YMdkSWJOpapyazhT5k6x2BzVHmLlDEd+yXM+tcULFXW43Uvu2EEisuY2lFE+NlL/m0ONTzPXTEBh6kGb7Lg47aziJVU6FE7NM+/2U3fJhw/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761152; c=relaxed/simple;
	bh=PSWndesvJ7yJyGk/yJtHyhnoG+WNuz5qX9vmAMwK3B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpXOgJqhO0dTrVlfkAerFhHXezltQb0zDAGnFu8JgROEJTFWEogvd08d9mVwgPveYw1/+ce21+t3BDhgM1UvCNZ4fWpHMy2WR/nsDdlWXuv2/tT3aUufPPo+EvrcQFkHv8nkDooSrr40eqzDYFJU33gVFua0cnsy+HAuIQ3OLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0bH1mhA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20696938f86so44178175ad.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727761149; x=1728365949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKD6JCL1iwudh6MLQ1Gdb0k45/waP7oTn9UitGRpXvQ=;
        b=d0bH1mhAv5LTa/Tqe/DsYcQJVkoQ8ekrE8iHn6Vsq9rwEtfRWpxOpicPoOyWBF062S
         LfBqPBm7XC0gC8OOxMuGTuhVO6IXPADbQCdtK91BzIJtJiJV+IaczRINNY3zwBZmgWta
         dmc5UZGp0vy7LCLXUolpgJtOvJYac4ik2u8HX79umdlZTknJl/iwE6UVnezNYKBgLhjK
         5Og7B6jx4UkTSMzlmv5NxOCXNjKNSthhjgDkr7+XB/okHopzRD85ZSUcbfAXZLlDyoRU
         FdQmFEzMceWu3tUjvOJ8fLYvj12QQXaPULfAcwiG7u8yLryBK8F5d88WCqmHQGBza9zX
         e1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727761149; x=1728365949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKD6JCL1iwudh6MLQ1Gdb0k45/waP7oTn9UitGRpXvQ=;
        b=cKGy2kspmQjzZnPUTFZ/3KFCPHK8DpQz2VSgwW1HtJYEbok5WCabYfhx7uJXrckeZ/
         LS8netSkWSvEkFIY9qhCoZIbuBqyQNcyk1+Qwp1R8EHSf/aR/Gn7+kpXig50tzMa8V7R
         RujGEV5ab9YOyrmkV2gahqjBZjkDMKFKjexKqz0nMTcRRXBIQFzKbG3zyQeC5/Ju/+5d
         M5qIhayIVmNr/i2o7lGWplGpVatWm6a33qWEXDo64X2SpMccF7y+Uv9VLEwoWXhQL1OR
         /2bLRCYvfwVD/pxgWx7MnZH6h6oUYR3WutG6H8SZrM+knIrRlTt+WrXkY4JQ2UJHi5ZQ
         iOlg==
X-Forwarded-Encrypted: i=1; AJvYcCUEvHBTsWF8/OKQXazEJ206gka0zXPoDjth+QjewSPK551q3zibTjmKdtNROxutaknlqBBxtUxayA==@vger.kernel.org
X-Gm-Message-State: AOJu0YypCINEzIWIlEtkatsX98ukt80q1WgXUJJdFW/b3tynKdi+BWcj
	MAHS9s7ppm1SRaCyzRN2Zh4oYWOFE74y1ptQMoF2lAbh9xQMaypE9PGAm4u3ffM=
X-Google-Smtp-Source: AGHT+IGuQTnEiNq6WG05WnssIERz/H9PyuSRBd8Z8h9yhGxjZnJ0UnrgjRzAUznsvXKsr/PxKZBNzw==
X-Received: by 2002:a17:903:904:b0:20b:9088:6545 with SMTP id d9443c01a7336-20b908868f3mr75454105ad.46.1727761148784;
        Mon, 30 Sep 2024 22:39:08 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d61d5esm62709075ad.27.2024.09.30.22.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 22:39:08 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:09:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: mediatek: Fix resource leaks on
 mtk_cpu_create_freq_table() failure
Message-ID: <20241001053906.mkhld5ufrmpdhfud@vireshk-i7>
References: <20240907163630.55704-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907163630.55704-1-riyandhiman14@gmail.com>

On 07-09-24, 22:06, Riyan Dhiman wrote:
> If mtk_cpu_create_freq_table() fails then there is a potential resource leak because 
> memory region is not released and IO memory is not unmapped. 
> Added error handling to ensure proper cleanup of all resources on failure, preventing potential leaks.
> 
> Fixes: d776790a5536 (cpufreq: mediatek-hw: Fix double devm_remap in hotplug case)
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
> It is more of a extension of the above commit as this error handling was missing in that commit.
> 
> v2: Fix commit message.
> v1: Added error handling.
> 
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index 8925e096d5b9..3b1303f350ec 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -207,13 +207,15 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
>  	ret = mtk_cpu_create_freq_table(pdev, data);
>  	if (ret) {
>  		dev_info(dev, "Domain-%d failed to create freq table\n", index);
> -		return ret;
> +		goto unmap_region;
>  	}
>  
>  	policy->freq_table = data->table;
>  	policy->driver_data = data;
>  
>  	return 0;
> +unmap_region:
> +	iounmap(base);

Since this driver already uses devm_* APIs, what about using them
instead ?

-- 
viresh

