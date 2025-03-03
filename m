Return-Path: <linux-pm+bounces-23272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEB3A4BB9D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD345188D48C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 10:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA451F1513;
	Mon,  3 Mar 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRszQY0p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D11E570E
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996190; cv=none; b=UDP6Lw9xAyTi6ot1vbDb7MghMHDgO+Vn9JuNRu0wjXmDOzF98go042+/gLilye/ah3LN1te+kTzuCCH7LRrR6q9cfj/O0EFxvsMC296TRuoWnM/ZUcKXl5oSpAr2t/kM14VuoSOsKPEAmMuhWdwsdx/vSJoCh/GIZ/CwG7fyQ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996190; c=relaxed/simple;
	bh=rxcijywZ3cJkNWyQcn7loTIiEZGWFkiZzNbQUTznWBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMA9VQUwy2wlYHaBrVgnti1Oz9JSxLI7atLLe/hMzZwjzsi1fiK0fuBzqTJVRJUkAkZXAH1hvXpQ83wz2QlSYSpUpMqLlpg8eCkdD2RY0u0xXuKc7Qn0dpW3EinrLr3wFbdxego11c9ot/cOTcckn3CIdhLvgiW7qV/1flCzm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eRszQY0p; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2feb96064e4so6210262a91.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Mar 2025 02:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740996188; x=1741600988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11+AHdr6AYKpXcHhMVfNk2znRJeJwmBOEUdkFwvIoso=;
        b=eRszQY0pHS0XN/mruGO1bTKca76khctckWo4KaTe9sj8/pd03H5iJsFCUbjMGUAyAm
         k14Cm2ZUTz1E00YPQP96s4xHXs36dG+pq9zCYsIj00OHD1D9AWkgrr/I0EOZ2LSXEtO/
         4LBglnqGxXqbC/cMKjA8wI2NykCqu3i8R2AJ539LDjHKBWNSVk1n7g7VpZaggH5jEDlz
         JjJpVdLsdc4gPhknVuJftnimR027mDoGAG91U2EEVRnaJ1J8oT4m5A5IlgNPOutEHoUO
         cMjomNLPbhyYPuOi7yJtNxQMzvG4Kd2ElDkJeE8DQbzEm6abj4lGuDNns++CCzeB3Vcd
         XhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996188; x=1741600988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11+AHdr6AYKpXcHhMVfNk2znRJeJwmBOEUdkFwvIoso=;
        b=ZfC0+rK41v6g6ZlHgi9ni4aWUQZxOl7+H4vnW0RrAFEJvwtibWqh1upto1NiU/3c5s
         guALNA2rhWwBTW5WPfsX0sQ6tlvmp9PcN/nkCxxnqPeK7zu5P98zJKY9HcXhpGnK+lKp
         TLZom5LG02fCUr8iRnuSuSx2BCzeZd1WMDAJyeuwqQyhR6sTdUwQvu2QBIWL7tqm4cBR
         MT19FJX8kqMGHzLbH6+6MLTvnvuxlNYybjboLneOifviNptvH41fWMdC+qS7XUFNDHon
         UdNXLW8nFqKqcPFPSRFI6al8TM/9X9daBRHnWF391vhlydvQWza+fJ/GsBaZY1yYSM8k
         pn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbtzVLlww+p81if4IGVxW4HwqjXvDGgQhZm8G65JSpysbqf3x5ZuxAlMz3fRwlVpMW0lBopeCwxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFMGaZvatTNrW4qYDSgEFV5ogYcIK75weVurxmJnU6kuBNNfQU
	yii9Wu+/t2tbwtbdvX+XoCTsKdHUnf9Vu4tKe7BTD/IB8sVxuaPW7x2cWdlTQwo=
X-Gm-Gg: ASbGnctdyHHZpWf//dYCMtM5mZQW7HhDf56yG9LAJrsmbZTjFsoMokooMUc1V0QZKzx
	L54lF2DrxRyn/pF3lVxUmT/XIt1uMYgaPLmxVD8RQAACsKsmH1ytdV4doUCa9ESb4icZwbQwx0X
	FzQ1Aaq/OgNc9MvFit7CGWmcW0FZNnYb8xVRDHj0rh1F8U0ikriHlwwpsE5mi45ktB1tesZMN/X
	xZ/cjB59pePu5IBI8oy4bP8kdbUctp3zFUPVoHOCDzVsQgeLrGhAWTVHttI/Z9LjiF3CjTWVfsu
	z7UVCNiWjsuztfwaQLk7qOF2MBax863v4naTZ6KAsuTggg==
X-Google-Smtp-Source: AGHT+IFJJ6O+Z6xQfN+8w8WzdswNxQSptrdoUx3ci2Ig09T5uOxOLT5TSvhtHvygzyM9QwBXAbOgtQ==
X-Received: by 2002:a17:90b:3c06:b0:2ee:b8ac:73b0 with SMTP id 98e67ed59e1d1-2febab2eaafmr20196910a91.2.1740996188522;
        Mon, 03 Mar 2025 02:03:08 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f15dsm10764987a91.44.2025.03.03.02.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:03:08 -0800 (PST)
Date: Mon, 3 Mar 2025 15:33:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aaron Kling <luceoscutum@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: tegra186: Share policy per cluster
Message-ID: <20250303100306.rwaosbumr7omcqce@vireshk-i7>
References: <20250216160806.391566-1-webgeek1234@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216160806.391566-1-webgeek1234@gmail.com>

On 16-02-25, 10:08, Aaron Kling wrote:
> This functionally brings tegra186 in line with tegra210 and tegra194,
> sharing a cpufreq policy between all cores in a cluster.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
> index c7761eb99f3cc..c832a1270e688 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -73,11 +73,18 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
>  	unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
> +	u32 cpu;
>  
>  	policy->freq_table = data->clusters[cluster].table;
>  	policy->cpuinfo.transition_latency = 300 * 1000;
>  	policy->driver_data = NULL;
>  
> +	/* set same policy for all cpus in a cluster */
> +	for (cpu = 0; cpu < (sizeof(tegra186_cpus)/sizeof(struct tegra186_cpufreq_cpu)); cpu++) {
> +		if (data->cpus[cpu].bpmp_cluster_id == cluster)
> +			cpumask_set_cpu(cpu, policy->cpus);
> +	}
> +
>  	return 0;
>  }

Thierry / Jonathan,

Any inputs on this ?

-- 
viresh

