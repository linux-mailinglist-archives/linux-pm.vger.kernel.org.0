Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081AC51F32C
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 06:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiEIEKy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 00:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiEIEEi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 00:04:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70692186D6
        for <linux-pm@vger.kernel.org>; Sun,  8 May 2022 21:00:43 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v11so11192887pff.6
        for <linux-pm@vger.kernel.org>; Sun, 08 May 2022 21:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pRKtNYkV+zVVcEny5GFigKXBXVhGiI45ZKz8fARUjYs=;
        b=nSfwZGGvtAuI92G14fZQ2q6VmMRcGJradNvR6Nw7uKaujSggxwWOMVNkPwhO3VJZrD
         5LwrWjXwcJlkFelFhdlD0rnz8p5TsnLh7aiFIi1PME3S3MvSBBwnVEtTB3r/AUYpj1eU
         dBj8H6G9wcFIT29xzR4CikJ9I/fbhsEF3cYrsKdwmgwW05zBQ3RPp/p8mqi++gTaUK1N
         z+PNlx5UiMt6pPGjM6RTFxltxvMauOr436umFtO15ylPEXfOheUd6SyOxdiCXdSjprjA
         A/PDIJPqhR0tK4/9aHqKdN8/pc2B5jEZ377RpVXSQIt/pZSbRz4oPoqSYCSytWrqYoY8
         8oOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pRKtNYkV+zVVcEny5GFigKXBXVhGiI45ZKz8fARUjYs=;
        b=EPKDGeJuHxWL1vVuq93Kyhmn8jlNQ0/dpeVGZ/51K4b14o/PR4gN08n9gf2d5K+iX+
         YFva2biz3Ce2xaMHsorE/RthOdkPpC9SkLIgGlbwXVe3AdfIJ/3Uepq800QhDnFkhDth
         gBi+us0Ugy812h2OhbSx7qwG0UT3ZXY70lj2YgaujWrZwFTwV6w1EFJK80e3jP3y4v0/
         LH/XMyezgWpKx/qiOgX7VDdpXOhx+IO5ac7lFVGdUvxyMhR1Qwq4Q5hjEEQc9XKQQiKQ
         rm2cpVgprErMsjd5i5ZAIgm6UJ58qKbwX/U12sDrhU1q1T0sXkuSIs4KUkM4sDs1QYY+
         bSEQ==
X-Gm-Message-State: AOAM531TWp4RYw2NyClqfIDsgxibkZEojgYamjY7M1GerP+42TNpzdEe
        TusdQd1b8CN2NUFroHaWmR6YCA==
X-Google-Smtp-Source: ABdhPJyS9+ynC+sx3VQgot/5hHm80AwLRlWhwBEN5I7a+muBhd4ldl5JuHgKGEOS8QCQmjuFxzOl1Q==
X-Received: by 2002:a63:7c4e:0:b0:380:8ae9:c975 with SMTP id l14-20020a637c4e000000b003808ae9c975mr11848323pgn.25.1652068830079;
        Sun, 08 May 2022 21:00:30 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902820700b0015e8d4eb2casm5821969pln.276.2022.05.08.21.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 21:00:29 -0700 (PDT)
Date:   Mon, 9 May 2022 09:30:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, dan.carpenter@oracle.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix double unlock when cpufreq online
Message-ID: <20220509040027.udrkjuelqqaadgx7@vireshk-i7>
References: <20220506072146.GD4031@kadam>
 <20220506170035.32115-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506170035.32115-1-schspa@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-05-22, 01:00, Schspa Shi wrote:
> The patch f346e96267cd: ("cpufreq: Fix possible race in cpufreq online
> error path") expand the critical region. But policy->rwsem is not held when
> calling cpufreq_driver->online and cpufreq_driver->init calls, which lead to bad
> unlock.
> 
> And it's well to hold this lock when calling cpufreq_driver->online, which
> provide more protects without bad influence.
> 
> Fixes: f346e96267cd: ("cpufreq: Fix possible race in cpufreq online error path")
> Link: https://lore.kernel.org/all/YnKZCGaig+EXSowf@kili/
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0d58b0f8f3af..43dfaa8124e2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1337,12 +1337,12 @@ static int cpufreq_online(unsigned int cpu)
>  		down_write(&policy->rwsem);
>  		policy->cpu = cpu;
>  		policy->governor = NULL;
> -		up_write(&policy->rwsem);
>  	} else {
>  		new_policy = true;
>  		policy = cpufreq_policy_alloc(cpu);
>  		if (!policy)
>  			return -ENOMEM;
> +		down_write(&policy->rwsem);
>  	}
>  
>  	if (!new_policy && cpufreq_driver->online) {
> @@ -1382,7 +1382,6 @@ static int cpufreq_online(unsigned int cpu)
>  		cpumask_copy(policy->related_cpus, policy->cpus);
>  	}
>  
> -	down_write(&policy->rwsem);
>  	/*
>  	 * affected cpus must always be the one, which are online. We aren't
>  	 * managing offline cpus here.
> @@ -1542,9 +1541,9 @@ static int cpufreq_online(unsigned int cpu)
>  		cpufreq_driver->exit(policy);
>  
>  	cpumask_clear(policy->cpus);
> -	up_write(&policy->rwsem);
>  
>  out_free_policy:
> +	up_write(&policy->rwsem);
>  	cpufreq_policy_free(policy);
>  	return ret;
>  }

Since this is a tricky piece of code, I suggest sending a fresh patch
to fix the original issue over the revert I have sent. I am not yet
sure both patches combined will fix it correctly.

-- 
viresh
