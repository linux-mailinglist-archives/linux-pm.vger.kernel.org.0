Return-Path: <linux-pm+bounces-23725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3966CA58B44
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 05:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78C9188A99C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 04:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D8A1B422A;
	Mon, 10 Mar 2025 04:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQdw9+J4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963629A0
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 04:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741581958; cv=none; b=D4arp96zhanWTnvRD/e0U7TsPZA2YjGk0hAfpDZSDWQkQ7Gyv4mFBmHO9s+hbp7/yQMmhie3vKcvEfX8hsxoyzU1Mh+XgK4qM12UoCE/lnqPhlJvgG+r8ogXAqdW656h2TEfp75FlVsvBu/Ign928BHoj8LyxsYRGJkIXAiJ8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741581958; c=relaxed/simple;
	bh=JRAD8UOU585xke1ahIH/tODZNm8+Se7tMxj/ziVkiW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLAT1STt5L9dgCtH00zMy043Vh815XPJu0TIVjxVBF3qcgGG6jthDjabRo+IT100bWrX7mL8ym4H9SBz8Gn4JG1WPus36AHKbN+VFTqx4TdeKgScydDPascdoNzZCoUlND/cR1/UX/nIHDYItAYlgzH4di2PHGSafmBtWOgsXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQdw9+J4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22580c9ee0aso2477225ad.2
        for <linux-pm@vger.kernel.org>; Sun, 09 Mar 2025 21:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741581956; x=1742186756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw2OaaNPvchcmlFrqMHD8BuSkIwCc2oB92xYk20lkhY=;
        b=eQdw9+J4SVp0bTmEc7A/xFr694PsUYJ0T27nxhXZUz1hR07pKkUkNCTChl1OYDo61y
         jT+8x5/62CBQw/bVMeq49hlRflKH55IzEcKOkEMmiRxMslpRBol9wd/heQKQf31sBtdd
         Vcd0M5GsZi8MW9OTTqP+iVrodUAwQOGiATGGalyLFcM/bERc80dACIehiZW/7xtJaPb0
         4gp1d5Uo33oP1VC1WUpB74A7emjUuYIB6hjPpTacElOTc27jvU5eV/hTd554N5CEs1+l
         OTlrXrczYlcPZJ5/yR1yct+1Qzmi//YzMVCQg+2frHJBJxQQJa1zeskllTnO0obh2sJT
         pFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741581956; x=1742186756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw2OaaNPvchcmlFrqMHD8BuSkIwCc2oB92xYk20lkhY=;
        b=OoW/V4p/ZjV753pojkTZ3XdKlWqkP5gZTg3T/2ntbbNlcnl2JXRvElG42q9bjd/Phl
         u+6JKhUbclvWy3MryB66RxV7yXvSGXM+Yqaj83iB1vIPpGsg3L6jFvKgT6LSWygjy3uv
         jndos5Y48QfObrilMurCRte5XKcXD1lAl4Pn7Jhm03fkBwL0W5nx/Bn+bNJC+k+gkEIt
         T03nzEyL0R/wAfCwNddrTyQmGIlYQxrzri58xNNXRdqyTPTDnAp7vhIEoJCKPiry3sdX
         PBZ59rBiMFf0dyz84W+zPB9qYG1x9HY5m7Y2M85jAiwf/SH9LxFEHgKSOGd3YFWhHhml
         ZDtw==
X-Forwarded-Encrypted: i=1; AJvYcCXOo43TH8j3lCxMDAf4iMNJrkMl4mZoFVxUy411movSTMFEpUBu9sRjaFJsd6cHWx914vukCYwFug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwttV904W2/F2pqxNF7S032Pdae7dx93Dz+ElByo9MKTPBrVebk
	ZZ3C0y6o6ehQsg34XiJkedqB831N9yrpB7ysEUuQ61hW48gl6zkH+7+m/Ryqyms=
X-Gm-Gg: ASbGncvjimHHoVefaEMPxpd4e7j2na6r+JfHB5dbACeoSkK2zhG1nN6UF9Pnn+clfE9
	2L0VDiJW3wpOlE+0nuCvlbwFVPJzPLqnE0TXJkCePr5GR7dS3Prl34vVMbQawRhvtCbWgz6jg3/
	b0kWXDjzZIWZ2ce/g/jSHaM9Lh3q2LA9DphslioI9Jrqx6VicLW7oXBxNotANWOF/dooGeACdKx
	td4XlGez2L4CV8CnkrekKHXGYI2Jy+L6gBFKnussB1PbNL1///OPh1n6ohkwBZDxjIStIG9/cHV
	VqRtOlvuuCNn+ZmQ2wqNvwWUi14440IVB0JglxG8lcF9HQ==
X-Google-Smtp-Source: AGHT+IF5bDU1rFa9VtZpFUs6HfI8CB9JfBOo6glmNRgP0U7OmG53UWM6H0zHVAdiu6JBpq+CGnoHTg==
X-Received: by 2002:a17:903:46c6:b0:220:d257:cdbd with SMTP id d9443c01a7336-22428bf16b4mr222163445ad.48.1741581956321;
        Sun, 09 Mar 2025 21:45:56 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e944csm67848155ad.74.2025.03.09.21.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 21:45:55 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:15:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aaron Kling <luceoscutum@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: tegra186: Share policy per cluster
Message-ID: <20250310044553.zupmsoi4d3errjvs@vireshk-i7>
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

Can't you use ARRAY_SIZE here ?

> +		if (data->cpus[cpu].bpmp_cluster_id == cluster)
> +			cpumask_set_cpu(cpu, policy->cpus);
> +	}
> +
>  	return 0;

-- 
viresh

