Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22277AFF09
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 10:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjI0IzY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 04:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjI0IzW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 04:55:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A17FE5
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 01:55:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27747002244so5491412a91.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695804920; x=1696409720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2otPEB/xF2y2gWB3F3HzuUrVDzeh6ktV3K7Sy+EklX0=;
        b=EbmpA7qT9M07ebVuaPitNjzgcOedRb9DydqODUjph9L9OPUcAwRfTGDOcewdYuszZT
         TbBmw0tdaA/anFCxTZnHd2j2mOkpxzKXE5/lUqcNeOzOr15iXYpNxTx1ziHSmwBccRCO
         ZUItyftG46X8ffNRQfy3OcB85aEXXMWXbPWv2YwISp61vO0gaG8M6GZtvSYMThlqRVVK
         J4tJP3Te8pOFWXISLDXSFHgZIJFctPONCdEZHjJ2pw2mFxuChBBR/IqT2yTYFvDqNB78
         Lto0LYTHYL6ivRQzepkILBW9y2gZYVUCmBGfqWNxmrLgiVtRqDhKQ9Iaj2qCaP3Tip/6
         6fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695804920; x=1696409720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2otPEB/xF2y2gWB3F3HzuUrVDzeh6ktV3K7Sy+EklX0=;
        b=jLE4//jHtEmPWPtOGr5x7p4gPLugBCaG0cma/oIIJGv/COUY8oepvmrCuDcPop+tBD
         6O354ofPVAlK1ty1gp9vFz2zzpNue7ra+seQksCEEkGaTwRqZL8ZW2Wt9G8pj4Gguo/X
         pr90mgQEojmh7SalwwxAOz04VZeTlMlrKWUqgDKOtV+QPIr4WoSXdr1cGPBGFH264Jk0
         TLWxLEnCeFFsdmn2yqKohkAAhxyMN7UOBPSBIyEE0aYT00eexRySDm4MkjMNjAyxw5Ig
         qhxPycMrSgxXLfdc/i6Tp2/9+G0alyesjiyczBOxU2qnL9kXeGM4N5TjDDJfqh6PgOD+
         Uwgw==
X-Gm-Message-State: AOJu0YwIeVhjvQe0dbGxWoNOD1O+gxfG3S1p0keZhUMd7q3PgNpBOm0S
        nZVkL2Z+vIjxhJn2vYb8QO+OFQ==
X-Google-Smtp-Source: AGHT+IG/oCqceFX/Qd4NKpfRUZDTTCa9LfZsFCLlueXp5y0ROoFg+gfO1s0WqoKsLZQKLcS8odhwMQ==
X-Received: by 2002:a17:90b:4d89:b0:274:bf7a:60cd with SMTP id oj9-20020a17090b4d8900b00274bf7a60cdmr1143971pjb.34.1695804919803;
        Wed, 27 Sep 2023 01:55:19 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id lj8-20020a17090b344800b0026b4decfe59sm11424070pjb.31.2023.09.27.01.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:55:19 -0700 (PDT)
Date:   Wed, 27 Sep 2023 14:25:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: Merge initialization code of sg_cpu
 in single loop
Message-ID: <20230927085517.udfg3udsqkmrugj2@vireshk-i7>
References: <20230908031604.2262422-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908031604.2262422-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-09-23, 03:16, Liao Chang wrote:
> The initialization code of the per-cpu sg_cpu struct is currently split
> into two for-loop blocks. This can be simplified by merging the two
> blocks into a single loop. This will make the code more maintainable.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 4492608b7d7f..f3a95def49cc 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -767,14 +767,6 @@ static int sugov_start(struct cpufreq_policy *policy)
>  
>  	sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
>  
> -	for_each_cpu(cpu, policy->cpus) {
> -		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> -
> -		memset(sg_cpu, 0, sizeof(*sg_cpu));
> -		sg_cpu->cpu			= cpu;
> -		sg_cpu->sg_policy		= sg_policy;
> -	}
> -
>  	if (policy_is_shared(policy))
>  		uu = sugov_update_shared;
>  	else if (policy->fast_switch_enabled && cpufreq_driver_has_adjust_perf())
> @@ -785,6 +777,9 @@ static int sugov_start(struct cpufreq_policy *policy)
>  	for_each_cpu(cpu, policy->cpus) {
>  		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
>  
> +		memset(sg_cpu, 0, sizeof(*sg_cpu));
> +		sg_cpu->cpu = cpu;
> +		sg_cpu->sg_policy = sg_policy;
>  		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
>  	}
>  	return 0;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
