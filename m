Return-Path: <linux-pm+bounces-1251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A5381617B
	for <lists+linux-pm@lfdr.de>; Sun, 17 Dec 2023 18:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9431F21913
	for <lists+linux-pm@lfdr.de>; Sun, 17 Dec 2023 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E08847A5F;
	Sun, 17 Dec 2023 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="SMnLy4WJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953747A52
	for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2023 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d12b56a38so11307595e9.2
        for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2023 09:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702835926; x=1703440726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn9iuiZ6vU9jCdkiyUMDFu72z+IF5fYHBOrEKgNVbzE=;
        b=SMnLy4WJ6N+wWMzJT2zk4YuLToQjnwpS52nq2dRrJE4AtA8irIgoploZTM5ITu2CKx
         KKhmFYJ38EyiwDFyGwnIMZE3gnFvjLeheYrIhTZf13o6DTjZeKS0GT7SHXlsQFVppy6j
         TKejfp9x9E/GhCFVQIF+hgFkZIKo8VDJLGqyJUjCCVBh72gHHp9yXO9je4DazpQ8zYBS
         chdj9dBKposTDHIjCnF2uTL1E+oDx6ZPHwbrEx8iopFPOHK4dbv9ud4FXUs+NbC0Bb3Q
         oHSb8j/LPDnKdhCI7xMnHIQpuk2K58iVE9Ty1JKPpwXba7xfS4Dj234d7i14CP0cq+i6
         u1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702835926; x=1703440726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qn9iuiZ6vU9jCdkiyUMDFu72z+IF5fYHBOrEKgNVbzE=;
        b=duSX+M5fsqvRP4NwbV58TnwEEAeXMEVPpCnHp3nzFDWuGQ8kADxeriUwNZpioP0lrE
         SQj1oJdndPe9Mf69ez4BQE9D5MAs63YKwk4wLSVca5ThG6Igp+cDRSoUrQenX6aSGhdC
         XQ6P9JWIUF2fKFqF4dGADrjmxKEqMt3H7Qmr76YdB69Pxg+sCePQvg1G06FyMvy84SF5
         bWNTcFqyUjrqLjQh7QwGSdqnr6pb/qMYZODPJnKwZyDnhp/L71xYMGUsJxCI1O/zMzef
         vQd3EbngEfg1gJ7CuDc/bQbaAbF4fQ29urm4kqBuHHwNJC496yc6gOXotSxUCSYDRYUM
         Li8Q==
X-Gm-Message-State: AOJu0Yxk0sASNlBIxN/zKF+ru5Z9o/sEHwogeiLlYp0cvPyqdvtFNgOx
	7qaqtaqRMwgvwM+4FgNFTgqzsw==
X-Google-Smtp-Source: AGHT+IHld5P7YRQYeasVcehUxKT7VC7nXGir9Sylqjaa+iq22qVR2qJPfZRzVeijzSlxJCNbGcDljA==
X-Received: by 2002:a05:600c:248:b0:40c:22c7:3dc with SMTP id 8-20020a05600c024800b0040c22c703dcmr4172156wmj.329.1702835926697;
        Sun, 17 Dec 2023 09:58:46 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b003fee6e170f9sm38158455wmq.45.2023.12.17.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 09:58:46 -0800 (PST)
Date: Sun, 17 Dec 2023 17:58:45 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 05/23] PM: EM: Refactor a new function
 em_compute_costs()
Message-ID: <20231217175845.2jdeqaz62mmcjuwu@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-6-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129110853.94344-6-lukasz.luba@arm.com>

On 11/29/23 11:08, Lukasz Luba wrote:
> Refactor a dedicated function which will be easier to maintain and re-use
> in future. The upcoming changes for the modifiable EM perf_state table
> will use it (instead of duplicating the code).

nit: What is being refactored? Looks like you took em_compute_cost() out of
em_create_perf_table().


Cheers

--
Qais Yousef

> 
> This change is not expected to alter the general functionality.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 72 ++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index aa7c89f9e115..3bea930410c6 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -103,14 +103,52 @@ static void em_debug_create_pd(struct device *dev) {}
>  static void em_debug_remove_pd(struct device *dev) {}
>  #endif
>  
> +static int em_compute_costs(struct device *dev, struct em_perf_state *table,
> +			    struct em_data_callback *cb, int nr_states,
> +			    unsigned long flags)
> +{
> +	unsigned long prev_cost = ULONG_MAX;
> +	u64 fmax;
> +	int i, ret;
> +
> +	/* Compute the cost of each performance state. */
> +	fmax = (u64) table[nr_states - 1].frequency;
> +	for (i = nr_states - 1; i >= 0; i--) {
> +		unsigned long power_res, cost;
> +
> +		if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
> +			ret = cb->get_cost(dev, table[i].frequency, &cost);
> +			if (ret || !cost || cost > EM_MAX_POWER) {
> +				dev_err(dev, "EM: invalid cost %lu %d\n",
> +					cost, ret);
> +				return -EINVAL;
> +			}
> +		} else {
> +			power_res = table[i].power;
> +			cost = div64_u64(fmax * power_res, table[i].frequency);
> +		}
> +
> +		table[i].cost = cost;
> +
> +		if (table[i].cost >= prev_cost) {
> +			table[i].flags = EM_PERF_STATE_INEFFICIENT;
> +			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
> +				table[i].frequency);
> +		} else {
> +			prev_cost = table[i].cost;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  				int nr_states, struct em_data_callback *cb,
>  				unsigned long flags)
>  {
> -	unsigned long power, freq, prev_freq = 0, prev_cost = ULONG_MAX;
> +	unsigned long power, freq, prev_freq = 0;
>  	struct em_perf_state *table;
>  	int i, ret;
> -	u64 fmax;
>  
>  	table = kcalloc(nr_states, sizeof(*table), GFP_KERNEL);
>  	if (!table)
> @@ -154,33 +192,9 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  		table[i].frequency = prev_freq = freq;
>  	}
>  
> -	/* Compute the cost of each performance state. */
> -	fmax = (u64) table[nr_states - 1].frequency;
> -	for (i = nr_states - 1; i >= 0; i--) {
> -		unsigned long power_res, cost;
> -
> -		if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
> -			ret = cb->get_cost(dev, table[i].frequency, &cost);
> -			if (ret || !cost || cost > EM_MAX_POWER) {
> -				dev_err(dev, "EM: invalid cost %lu %d\n",
> -					cost, ret);
> -				goto free_ps_table;
> -			}
> -		} else {
> -			power_res = table[i].power;
> -			cost = div64_u64(fmax * power_res, table[i].frequency);
> -		}
> -
> -		table[i].cost = cost;
> -
> -		if (table[i].cost >= prev_cost) {
> -			table[i].flags = EM_PERF_STATE_INEFFICIENT;
> -			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
> -				table[i].frequency);
> -		} else {
> -			prev_cost = table[i].cost;
> -		}
> -	}
> +	ret = em_compute_costs(dev, table, cb, nr_states, flags);
> +	if (ret)
> +		goto free_ps_table;
>  
>  	pd->table = table;
>  	pd->nr_perf_states = nr_states;
> -- 
> 2.25.1
> 

