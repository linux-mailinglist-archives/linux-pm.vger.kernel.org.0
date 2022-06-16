Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C4D54DA62
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jun 2022 08:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359057AbiFPGR2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jun 2022 02:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359043AbiFPGR1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2022 02:17:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A5B38192
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 23:17:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y6so527633plg.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sRbNJbc+ahYktLmDyoH4yo1fpASvuRbFucDO6Muj9cg=;
        b=frv+lCaLqDCtRc1lutAiLWWqQAjy20E2s0IY5gDRdHDdkGVOQG4qvWpbdZxvRyf9RA
         FI0NCliBh8cSdpfwff8nuZwVTXhTof8MTp0dzDqIzTb7Zyo8YqxgZxBlW7OkCQ7uyvt3
         TXgmPys4n/YExtF6bmTeTQGqvNmoDMQEn1v8FxSEEGq99TZ2t0R8lVCxdkw5LAy5JOkA
         5oIzaFO33Z9f4iod6X2daM/+58jqEYZaFyQqC70ABUhVtPe12mpj7F+Y2KPPthzVrcxJ
         jfh2OmpaHU4aKH+AH74ZZbgHt5DnE8eu8q7hp1kAv0iXjk2BTjKUK7O9PBld3TJqp244
         N6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sRbNJbc+ahYktLmDyoH4yo1fpASvuRbFucDO6Muj9cg=;
        b=B10+GQhS4RfxdjPy+HhKNiaooDUmnmv/baj5j908Duyur/BCEnPnX7Q8ecfeV2jtkS
         51VzuTSeacSP9y/FyTCEVQzKrumpRROabs9ZV/LEB3sU4TTENpH3NaYuaZ2Ul3qGhnZY
         x6mYdgjypYV7xPtUYiAt4E9Ex4LL5efzNk4p1DDHRX17ppZEVELUGpGT8lZUL+iHA7NV
         L3ODs7JAy2XcJyOg+3Wo4jZvxbwhC/YzCZ1XHq/msepwf5G8MoXAvXwjCfGO5pJyW6LC
         8Yam3fZFhO3GeMlr9JnQ4kiodZoJKMzGL+dyYPk96jvA+1TuWQve+rFGkF4Y5sX8C5LK
         A8eQ==
X-Gm-Message-State: AJIora+uULnCLkEwVnulsbW4qhw6aEtOES7mPezb6gUJfdUqtUdkxj4T
        LzCeceZKXaC9z/ApHt2MgtAvYQ==
X-Google-Smtp-Source: AGRyM1scPuVidbbJvlKHJZg5ot8FJQuMvDvq36SYo9aLhk8nKm9ZY+MPCW2Rl+lSsHNv9txN09mksQ==
X-Received: by 2002:a17:902:e951:b0:168:b530:135b with SMTP id b17-20020a170902e95100b00168b530135bmr2983153pll.93.1655360244841;
        Wed, 15 Jun 2022 23:17:24 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id n6-20020aa78a46000000b0051bd3d55773sm760331pfa.63.2022.06.15.23.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 23:17:24 -0700 (PDT)
Date:   Thu, 16 Jun 2022 11:47:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Dietmar.Eggemann@arm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/4] cpufreq: Change order of online() CB and
 policy->cpus modification
Message-ID: <20220616061722.tfsr3svljcupkcvz@vireshk-i7>
References: <20220615144321.262773-1-pierre.gondois@arm.com>
 <20220615144321.262773-5-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615144321.262773-5-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-06-22, 16:43, Pierre Gondois wrote:
> >From a state where all policy->related_cpus are offline, putting one
> of the policy's CPU back online re-activates the policy by:
>  1. Calling cpufreq_driver->online()
>  2. Setting the CPU in policy->cpus
> 
> qcom_cpufreq_hw_cpu_online() makes use of policy->cpus. Thus 1. and 2.
> should be inverted to avoid having a policy->cpus empty. The
> qcom-cpufreq-hw is the only driver affected by this.
> 
> Fixes: a1eb080a0447 ("cpufreq: qcom-hw: provide online/offline operations")
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2cad42774164..36043be16d8e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1350,15 +1350,15 @@ static int cpufreq_online(unsigned int cpu)
>  	}
>  
>  	if (!new_policy && cpufreq_driver->online) {
> +		/* Recover policy->cpus using related_cpus */
> +		cpumask_copy(policy->cpus, policy->related_cpus);
> +
>  		ret = cpufreq_driver->online(policy);
>  		if (ret) {
>  			pr_debug("%s: %d: initialization failed\n", __func__,
>  				 __LINE__);
>  			goto out_exit_policy;
>  		}
> -
> -		/* Recover policy->cpus using related_cpus */
> -		cpumask_copy(policy->cpus, policy->related_cpus);
>  	} else {
>  		cpumask_copy(policy->cpus, cpumask_of(cpu));

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
