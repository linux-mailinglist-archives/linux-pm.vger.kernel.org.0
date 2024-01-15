Return-Path: <linux-pm+bounces-2200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E2282D8C5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 13:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D338B20628
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952942C69B;
	Mon, 15 Jan 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="eam8ckEP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2E52C699
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e779f0253so7583205e9.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 04:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705320902; x=1705925702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkeryFFN0E92YDHA0WedWGdu+Xyn60HCyzZMxQkNh84=;
        b=eam8ckEPCJ8Qh+2gsGq5er5E04dbNpCPKNb86HDmRRbPT1OTZAEUGb6NR65ywqaKR5
         5DC3j3PFll9yfRCe8aB1OqxS/V0g0fE/a466qMd9N4wGZnwp1BG9aiOsFqaPsz/Eq4qA
         eyWou/TsVKudKFKHyrvjz3ln/AIasZFQIIYPm/3EJUi+rz2fyPPPUtRacW+XGx1YO+50
         19LT3lcXtgWH7rqkuIlNhGy1P8olsrBo9uZBWS6vPPsFvb+UqmbGdv+BDcR6144M80Gf
         Abo9aaY9v9Tv02zXXANcE0R2K3AHIanlfl9CbrOdchFTAL/qTkSEokGvA64KsAOsXfOV
         bNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705320902; x=1705925702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkeryFFN0E92YDHA0WedWGdu+Xyn60HCyzZMxQkNh84=;
        b=CZ78CuxAUKMpY0vVa9x/emGA/TjGwx80eDgxm8/Qy1myadSKoQRgtNskUxNjNfUQVg
         N/j1MH8XuCXWORe7zjer0zYdf37UYs+nnouxHAVuLQ6VbeKb29koVkrLJ2+u3zt/lkpa
         /2+w8aNAMhaCj91fmeMrGG+W9Ys/6PBwQYgvhy+EVSFuZ++D/DY3mS1dxoN9NzsTePtv
         u3sJmjl98P5F2o2l6T8HYBhk4OM7dTt4ACGtxp2AeNMi5MzMcyOgiR8dXrtP+9gax3wo
         JPK4DCLWopu8IOfupZUYKK5GrL0oyBoiUJlZjpr+j/xD8o+V//W0tqgjPrNp36MiRY0n
         w6Zw==
X-Gm-Message-State: AOJu0YzpRMa6TeNAVPwEI//HrR+47kLP+hPDcvl6g8hJU5WQ43I6AzuR
	PWg3y30R5pHRKEQTMduHj0cRuj5Sn43ikw==
X-Google-Smtp-Source: AGHT+IEALLdnsrORNMdFLLuROqcnj2o/cebTrJzddFAZLFZp2enudI1Pmqbyb1PcqQLEs26I4izu0Q==
X-Received: by 2002:a05:600c:4c19:b0:40e:70c0:5054 with SMTP id d25-20020a05600c4c1900b0040e70c05054mr1871959wmp.2.1705320902176;
        Mon, 15 Jan 2024 04:15:02 -0800 (PST)
Received: from airbuntu (host109-154-205-127.range109-154.btcentralplus.com. [109.154.205.127])
        by smtp.gmail.com with ESMTPSA id d29-20020adfa35d000000b003375009accesm11804676wrb.50.2024.01.15.04.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 04:15:01 -0800 (PST)
Date: Mon, 15 Jan 2024 12:15:00 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	wkarny@gmail.com, torvalds@linux-foundation.org, tglx@linutronix.de,
	rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant
 case
Message-ID: <20240115121500.poin6byksmajlnuq@airbuntu>
References: <20240114183600.135316-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240114183600.135316-1-vincent.guittot@linaro.org>

On 01/14/24 19:36, Vincent Guittot wrote:
> When frequency invariance is not enabled, get_capacity_ref_freq(policy)
> returns the current frequency and the performance margin applied by
> map_util_perf(), enabled the utilization to go above the maximum compute
> capacity and to select a higher frequency than the current one.
> 
> The performance margin is now applied earlier in the path to take into
> account some utilization clampings and we can't get an utilization higher
> than the maximum compute capacity.
> 
> We must use a frequency above the current frequency to get a chance to
> select a higher OPP when the current one becomes fully used. Apply
> the same margin and returns a frequency 25% higher than the current one in
> order to switch to the next OPP before we fully use the cpu at the current
> one.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/lkml/CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com/
> Reported-by: Wyes Karny <wkarny@gmail.com>
> Closes: https://lore.kernel.org/lkml/20240114091240.xzdvqk75ifgfj5yx@wyes-pc/
> Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Wyes Karny <wkarny@gmail.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 95c3c097083e..d12e95d30e2e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -133,7 +133,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
>  	if (arch_scale_freq_invariant())
>  		return policy->cpuinfo.max_freq;
>  
> -	return policy->cur;
> +	/*
> +	 * Apply a 25% margin so that we select a higher frequency than
> +	 * the current one before the CPU is full busy
> +	 */
> +	return policy->cur + (policy->cur >> 2);

I think we can do better, but this does re-instate the previous behavior at
least for this merge window. So FWIW

Reviewed-and-tested-by: Qais Yousef <qyousef@layalina.io>

>  }
>  
>  /**
> -- 
> 2.34.1
> 

