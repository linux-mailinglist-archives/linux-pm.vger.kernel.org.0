Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7499277DEE7
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 12:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243521AbjHPKiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 06:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243523AbjHPKhg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 06:37:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF842211E
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:37:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso4444090b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692182254; x=1692787054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh9MryW+9nMV3UutUXv+KgXskXqNar4D6ToRleew26s=;
        b=WIjkxcV2K5Y6Te6saa2B679mp55fJLZgNLUvmAlpFVXSZntHTP1Rzj85ET3dkGqW/u
         37jm/Bn6PwmJi9lWLqt75zM/+SOll47iRKje328MUFGTAkRExwI4fMhzeQ6HwOp/kPy6
         3HgL5AgdFkzRh6pSUfobM0OKRcgSg7bGC/s+15KXO+v7IaLdq9WvOIuN11N+wjzCsWCA
         I7k0leNhwX/bPJBVdvzCgc1E38rEFDxj+1Z/o+DwuXTsXOdEm3WthW5d1eJPUL2JRSO5
         0kbwxQwbmosBsZKyiwYo54xqANHTNwOso4j0gbm9zKQNktnnBrONbOTS74/UikZ83t2V
         xvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692182254; x=1692787054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kh9MryW+9nMV3UutUXv+KgXskXqNar4D6ToRleew26s=;
        b=P+mR39js57dDaHXgIY8kMxhVkZFSWndJNbQB8tmVYRsi2k5X5/MdGbXVoeKqHkgTis
         UY4mb/AABLv9zSx8QM3LI9NJRqqAhCbC8M+KS+qwM8kCCEdy/SV/S/ST0NRzTv6XvZlh
         8IJhr/VthZkjubrN6wyoJf/e39N+0ooaetw1Uw6P2/me6YWS/ArNCUVhVckSR9/W2vX8
         rJvyPgcdnF516bQRMdQDWKeQwYYSfhpCvQ4HdYw4M9szjr1/hdX1YsyMh/EWeZymNZvq
         aUIBUDGrhK4upcz0D6ptsha6se3U6AeYHDEne4kO81NDMGuMB9t4FS5WRrzH/oxabqSG
         puYg==
X-Gm-Message-State: AOJu0YzXN4NWv55gO0aj8gOMoSPVM/ip2QgKM8I0lDbRYs3cZzny5eUw
        1TqUXMBhzLLkwqtJpYCdfU+6VQ==
X-Google-Smtp-Source: AGHT+IEGtW4EWLRbQmAE8cCnZk+ypXNz/M0lPnKI0sSWrOc2eTXw+yErFkzIU0nMzcBNyzd3vWZz/A==
X-Received: by 2002:a05:6a21:33a4:b0:13b:a2c9:922e with SMTP id yy36-20020a056a2133a400b0013ba2c9922emr1665496pzb.27.1692182254086;
        Wed, 16 Aug 2023 03:37:34 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090332c300b001a6d4ea7301sm6506344plr.251.2023.08.16.03.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 03:37:33 -0700 (PDT)
Date:   Wed, 16 Aug 2023 16:07:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: cppc: Set fie_disabled to FIE_DISABLED if
 fails to create kworker_fie
Message-ID: <20230816103731.qwx3j3rmwyszq45j@vireshk-i7>
References: <20230816094938.862186-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816094938.862186-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-08-23, 09:49, Liao Chang wrote:
> The function cppc_freq_invariance_init() may failed to create
> kworker_fie, make it more robust by setting fie_disabled to FIE_DISBALED
> to prevent an invalid pointer dereference in kthread_destroy_worker(),
> which called from cppc_freq_invariance_exit().
> 
> Link: https://lore.kernel.org/all/20230816034630.a4hvsj373q6aslk3@vireshk-i7/
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 022e3555407c..bff4cde06083 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -220,6 +220,15 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>  	}
>  }
>  
> +static void cppc_freq_invariance_exit(void)
> +{
> +	if (fie_disabled)
> +		return;
> +
> +	kthread_destroy_worker(kworker_fie);
> +	kworker_fie = NULL;
> +}
> +
>  static void __init cppc_freq_invariance_init(void)
>  {
>  	struct sched_attr attr = {
> @@ -249,27 +258,22 @@ static void __init cppc_freq_invariance_init(void)
>  		return;
>  
>  	kworker_fie = kthread_create_worker(0, "cppc_fie");
> -	if (IS_ERR(kworker_fie))
> +	if (IS_ERR(kworker_fie)) {
> +		pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
> +			PTR_ERR(kworker_fie));
> +		fie_disabled = FIE_DISABLED;
>  		return;
> +	}
>  
>  	ret = sched_setattr_nocheck(kworker_fie->task, &attr);
>  	if (ret) {
>  		pr_warn("%s: failed to set SCHED_DEADLINE: %d\n", __func__,
>  			ret);
> -		kthread_destroy_worker(kworker_fie);
> -		return;
> +		cppc_freq_invariance_exit();

I don't really like this change, there aren't a lot of things that we
need to do here on cleanup, but just kthread_destroy_worker(). Calling
it directly makes more sense I guess.

> +		fie_disabled = FIE_DISABLED;
>  	}
>  }
>  
> -static void cppc_freq_invariance_exit(void)
> -{
> -	if (fie_disabled)
> -		return;
> -
> -	kthread_destroy_worker(kworker_fie);

> -	kworker_fie = NULL;

I don't see the point of this line. Probably it can be dropped.

> -}
> -
>  #else
>  static inline void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>  {
> -- 
> 2.34.1

-- 
viresh
