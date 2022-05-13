Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194F0525A91
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 06:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiEMESk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 May 2022 00:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiEMESj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2022 00:18:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2A96B02E
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 21:18:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fv2so7014534pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 21:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ShkuLlj2MWtYfi36X9IC2PJMOwaNcZXxSPZHs052k94=;
        b=AmigbuhERDx1zWAKHpiTWOBZnRdcfvQ2BEE6qZ1/K+q+DkrE6GvTZ5C0gPU2D8ugPJ
         JBJYbC28tiKb/IHNL0gA2qSaNs7E0aaEoQGgQZF10bbkcYP/UcoKkfthXHhEESUkpdzb
         sXxGF46yKB+8WdTX1hZd40aGQHE0O8fpbw/2HBRNYkQKDeix6+H2y+XgycF2+/zzAjkz
         82y094Wpc/8l+GKXYwPSE/sFSwCmftvi4oKknTHdI99RPwQh4uJHEppWCf0ZLN8h3hMQ
         WNSx+5UZTFj8x5EsQHUerMmFOyvcyj6OuyOMAzj6F3mZHEgqyv7rXoltH+LgwIg608do
         NiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ShkuLlj2MWtYfi36X9IC2PJMOwaNcZXxSPZHs052k94=;
        b=rTCkqZqN0q9+bZfpkJq11U8cmghTWrLgFHq7xTbkEcQ+ZMfaABdmSO0v1Tu/wFoWHR
         9xPv4li57iE9bvjM9icLlHT2NJ2l3cmOzI8N6k1k2CiE+SciKfkKWnbFFON6sjW9w0Zr
         /z3H5wq1rpYu/y/xR4Su5EVLhiQZtrgshY5SN+huh16d2axZqS17+TPtU7Ej+3TKdGWU
         CMuDOS5zhHgi6eZvdm+RSf8xzQ6XYxmJv8V+LHO1bjtGFCDzRNzAY21FDyHDJ1Hx7UbE
         vCFjF3dLhfhI9BpGUZip1DvCAa25dH8Te9N/tqjU1TPsnHq4gHlooWDjx7GVChuLMkK4
         MC8A==
X-Gm-Message-State: AOAM530IWIgOxTzi9LT0bM7qLy+PQZ+RGf+xAe3mjdYagDI6r7vCDCaV
        jVWAXtdfikSQtweWCVpCYK0wKg==
X-Google-Smtp-Source: ABdhPJzkGLezRyPr1wQ8PJ2bGpBv/cYuBOB8b9Laovv7LFWkYnmZ0FULUOQMpRS+JQ09qAgmHca/JQ==
X-Received: by 2002:a17:902:ab04:b0:156:1517:411a with SMTP id ik4-20020a170902ab0400b001561517411amr3025246plb.128.1652415516514;
        Thu, 12 May 2022 21:18:36 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b0015e8d4eb286sm681293pli.208.2022.05.12.21.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 21:18:35 -0700 (PDT)
Date:   Fri, 13 May 2022 09:48:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cpufreq: fix race on cpufreq online
Message-ID: <20220513041833.mcubozfhl2qd2rps@vireshk-i7>
References: <20220512135231.10076-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512135231.10076-1-schspa@gmail.com>
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

On 12-05-22, 21:52, Schspa Shi wrote:
> When cpufreq online failed, policy->cpus are not empty while
> cpufreq sysfs file available, we may access some data freed.
> 
> Take policy->clk as an example:
> 
> static int cpufreq_online(unsigned int cpu)
> {
>   ...
>   // policy->cpus != 0 at this time
>   down_write(&policy->rwsem);
>   ret = cpufreq_add_dev_interface(policy);
>   up_write(&policy->rwsem);
> 
>   down_write(&policy->rwsem);
>   ...
>   /* cpufreq nitialization fails in some cases */
>   if (cpufreq_driver->get && has_target()) {
>     policy->cur = cpufreq_driver->get(policy->cpu);
>     if (!policy->cur) {
>       ret = -EIO;
>       pr_err("%s: ->get() failed\n", __func__);
>       goto out_destroy_policy;
>     }
>   }
>   ...
>   up_write(&policy->rwsem);
>   ...
> 
>   return 0;
> 
> out_destroy_policy:
> 	for_each_cpu(j, policy->real_cpus)
> 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
>     up_write(&policy->rwsem);
> ...
> out_exit_policy:
>   if (cpufreq_driver->exit)
>     cpufreq_driver->exit(policy);
>       clk_put(policy->clk);
>       // policy->clk is a wild pointer
> ...
>                                     ^
>                                     |
>                             Another process access
>                             __cpufreq_get
>                               cpufreq_verify_current_freq
>                                 cpufreq_generic_get
>                                   // acces wild pointer of policy->clk;
>                                     |
>                                     |
> out_offline_policy:                 |
>   cpufreq_policy_free(policy);      |
>     // deleted here, and will wait for no body reference
>     cpufreq_policy_put_kobj(policy);
> }
> We can fix it by clear the policy->cpus mask.
> Both show_scaling_cur_freq and show_cpuinfo_cur_freq will return an
> error by checking this mask, thus avoiding UAF.

Instead of all above, what about this.

Subject: Abort show/store for half initialized policy

If policy initialization fails after the sysfs files are created,
there is a possibility that we may end up running show()/store()
callbacks for half initialized policies, which may have unpredictable
outcomes.

Abort show/store in such a case by making sure the policy is active.
Also inactivate the policy on such failures.

> Signed-off-by: Schspa Shi <schspa@gmail.com>
> 
> ---
> 
> Changelog:
> v1 -> v2:
>         - Fix bad critical region enlarge which causes uninitialized
>           unlock.
>         - Move cpumask_clear(policy->cpus); before out_offline_policy
> v2 -> v3:
>         - Remove the missed down_write() before
>           cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
> v3 -> v4:
>         - Seprate to two patchs.
>         - Add policy_is_inactive check before sysfs access
> ---
>  drivers/cpufreq/cpufreq.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 80f535cc8a75..35dffd738580 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -953,7 +953,10 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
>  		return -EIO;
>  
>  	down_read(&policy->rwsem);
> -	ret = fattr->show(policy, buf);
> +	if (unlikely(policy_is_inactive(policy)))
> +		ret = -EBUSY;
> +	else
> +		ret = fattr->show(policy, buf);

I like it the way I have done earlier, initialize ret to -EBUSY and
get rid of the else part and call show/store in if itself. Same for
below.

>  	up_read(&policy->rwsem);
>  
>  	return ret;
> @@ -978,7 +981,10 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  
>  	if (cpu_online(policy->cpu)) {
>  		down_write(&policy->rwsem);
> -		ret = fattr->store(policy, buf, count);
> +		if (unlikely(policy_is_inactive(policy)))
> +			ret = -EBUSY;
> +		else
> +			ret = fattr->store(policy, buf, count);
>  		up_write(&policy->rwsem);
>  	}
>  
> @@ -1533,6 +1539,7 @@ static int cpufreq_online(unsigned int cpu)
>  	for_each_cpu(j, policy->real_cpus)
>  		remove_cpu_dev_symlink(policy, get_cpu_device(j));
>  
> +	cpumask_clear(policy->cpus);
>  	up_write(&policy->rwsem);
>  
>  out_offline_policy:
> -- 
> 2.29.0

-- 
viresh
