Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301FE282FB6
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 06:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJEEqZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 00:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgJEEqZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 00:46:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC4C0613A5
        for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2020 21:46:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id az3so1576007pjb.4
        for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2020 21:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+3QPZMfp1DCKLcnWe5NOGZiFhXH+uUxOKLM/vRWWY1s=;
        b=RXgjeIBy8hkRLrpzOB16SizM5azbR4U+2ps3Y9ljVW2InGToNKdkd68iCB7GySMwNu
         11F4sTDqlyTd4ftH/fA8jXZxl/l8koV58gKPoMbX/QRvxwydit2KymWVm+jds5giGEAF
         +ir7YwlPVMlVUlLMoU0asD6ug/h6kaFMzY7BVICTNxmCChiBkN6Rfe8/6bViGOk1Ipp4
         w7dSebqyiOUTwFFmm0Me6cZplzoGHVve78FUyvnrFDKl08n/H4myo7DC3Pwvmb+QAYZT
         raS3mIArik7cg4PdKaMAaXGUE8F3FKiLoXjw5vRShf5TkCcyl9Zv4+hE9QEooAqPJG11
         qioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+3QPZMfp1DCKLcnWe5NOGZiFhXH+uUxOKLM/vRWWY1s=;
        b=D7gtDOjWxQzo10D/6Jf8JnJxJNtrgZsenxXPE0tZ8/t8iH2f8Q7iqhx3ZwGz9nFA8u
         cxLK4ANWJeyQH2STRXIgRAfXogeWIPDUykyWuC8Npv8UtQ7QqyebpbHGWXAtrPumwrlY
         hIwnVzxgtcTUwyP9D2x2MsJANMv7cP4Av9fEd0pfE8qcdBfOfefRSRWTXjnQP34Yy7d+
         5A7bODzlhvgIhdRQBJCGdLCqPbfQiRs9uRt6KHA5v0TzHEif9OeJx2HnlQbr9hZMJnxU
         TerkykTzG7oFdithsS2mfvxC8wIh3uzBn+cVzf7h6MiWDoMij0eh82Gbj58+M35vf+jX
         +MwA==
X-Gm-Message-State: AOAM530Y1CSoWEFtrWsUHDoCWkcNYjyj1Y0mOJb3gJlFkeIM0qjfBqud
        MAKCjqLlq/3NlOCx5g4VjvzgVA==
X-Google-Smtp-Source: ABdhPJw5MSUuqla5bRzh+iMaf8aQSJKtx6GyLjQ35bYxpqFAZftWUhyFr6ykYrDHc16NrR1DRdnGkw==
X-Received: by 2002:a17:90a:b949:: with SMTP id f9mr13643522pjw.182.1601873184561;
        Sun, 04 Oct 2020 21:46:24 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z1sm9097104pgu.80.2020.10.04.21.46.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2020 21:46:23 -0700 (PDT)
Date:   Mon, 5 Oct 2020 10:16:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ksitaraman@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch 1/2] cpufreq: tegra194: get consistent cpuinfo_cur_freq
Message-ID: <20201005044621.t3stylpbsvzhxtyr@vireshk-i7>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
 <1600276277-7290-2-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600276277-7290-2-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-09-20, 22:41, Sumit Gupta wrote:
> Frequency returned by 'cpuinfo_cur_freq' using counters is not fixed
> and keeps changing slightly. This change returns a consistent value
> from freq_table. If the reconstructed frequency has acceptable delta
> from the last written value, then return the frequency corresponding
> to the last written ndiv value from freq_table. Otherwise, print a
> warning and return the reconstructed freq.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 66 ++++++++++++++++++++++++++++++++------
>  1 file changed, 57 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index e1d931c..d5b608d 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -180,9 +180,65 @@ static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
>  	return (rate_mhz * KHZ); /* in KHz */
>  }
>  
> +static void get_cpu_ndiv(void *ndiv)
> +{
> +	u64 ndiv_val;
> +
> +	asm volatile("mrs %0, s3_0_c15_c0_4" : "=r" (ndiv_val) : );
> +
> +	*(u64 *)ndiv = ndiv_val;
> +}
> +
> +static void set_cpu_ndiv(void *data)
> +{
> +	struct cpufreq_frequency_table *tbl = data;
> +	u64 ndiv_val = (u64)tbl->driver_data;
> +
> +	asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
> +}
> +
>  static unsigned int tegra194_get_speed(u32 cpu)
>  {
> -	return tegra194_get_speed_common(cpu, US_DELAY);
> +	struct cpufreq_frequency_table *table, *pos;
> +	struct cpufreq_policy policy;
> +	unsigned int rate;
> +	u64 ndiv;
> +	int err;
> +
> +	cpufreq_get_policy(&policy, cpu);
> +	table = policy.freq_table;

Maybe getting freq-table from cluster specific data would be better/faster.

> +
> +	/* reconstruct actual cpu freq using counters*/
> +	rate = tegra194_get_speed_common(cpu, US_DELAY);
> +
> +	/* get last written ndiv value*/
> +	err = smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
> +	if (err) {
> +		pr_err("cpufreq: Failed to get ndiv for CPU%d, ret:%d\n",
> +		       cpu, err);
> +		return rate;
> +	}
> +
> +	/* if the reconstructed frequency has acceptable delta from

Both have got the multi-line comments wrong. Format is wrong and every sentence
needs to start with a capital letter.

> +	 * the last written value, then return freq corresponding
> +	 * to the last written ndiv value from freq_table. This is
> +	 * done to return consistent value.
> +	 */
> +	cpufreq_for_each_valid_entry(pos, table) {
> +		if (pos->driver_data != ndiv)
> +			continue;
> +
> +		if (abs(pos->frequency - rate) > 115200) {
> +			pr_warn("cpufreq: high delta (%d) on CPU%d\n",
> +				abs(pos->frequency - rate), cpu);
> +			pr_warn("cpufreq: cur:%u, set:%u, set ndiv:%llu\n",
> +				rate, pos->frequency, ndiv);

Both of these can be merged in a single line I think. There is no need to print
delta as you already print both the frequencies.

> +		} else {
> +			rate = pos->frequency;
> +		}
> +		break;
> +	}
> +	return rate;
>  }
>  
>  static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
> @@ -209,14 +265,6 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static void set_cpu_ndiv(void *data)
> -{
> -	struct cpufreq_frequency_table *tbl = data;
> -	u64 ndiv_val = (u64)tbl->driver_data;
> -
> -	asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
> -}
> -
>  static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>  				       unsigned int index)
>  {
> -- 
> 2.7.4

-- 
viresh
