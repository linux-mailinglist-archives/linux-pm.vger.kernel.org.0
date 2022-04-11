Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507584FB22F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 05:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbiDKDOw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Apr 2022 23:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbiDKDOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2022 23:14:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501522F3A9
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 20:12:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p25so6680609pfn.13
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 20:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4FweITrSlHFF8T41iquggp7nE6Dquo+9YQPpdFHzPKU=;
        b=GypPvonW5HGwxDqfRdhsoR1pu48eFklX/yZx/MWagF00T97pzhDJFsYlGg5f+KTFgh
         WOfXaeIsWYi7uatvo49iSW4In4/Pfq8IRvB5tbHHsYynEFiHsRUtC+u4tGyICoCVYICo
         VTSkgS3tIqAuuQFQGBYBoYKbdFGVeIvVfnfMGfCLNZDEPCt/FZi/fBJpEyLy1/gysQGr
         rDS+p2nGWZnOmqj0i8MQvCh3wFZ9du22HrXFl0rg7LMubWskvX9nFQU9anCx2HasXbWe
         mKhYebrkQ9d3tadepeR347AY/xF39yXmgyfjll5DsXS0L8ACKF6KPR5pA3PTeulyLsg0
         eF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4FweITrSlHFF8T41iquggp7nE6Dquo+9YQPpdFHzPKU=;
        b=FPgv2EhZVy774Z6LySos7GapPSZ4DYLCW0z0+LpaU/A/QkEi1S+AKA0b/4TFC7cO4Z
         qJ9K+q4a9aejTJ05NLe0/HIvp64nmAF6/REDamrleOyhhzjlRvo4LVO5XJxLt1nQuJ5k
         yRUW1vOL+Jqsur9uvPCdgBGd4OMhYKjwtAVWM0A70hH8RR25IEZ9fdDUg9zRHzYk5i1B
         zrcww+z63zPpvvD/Kd/QmJTnGyjCPaopWwOoE9NER1eEo6rEKFaJTGExOP60AinygVj+
         GfZHxqECROJaccBsNMrJhTAypQrpoNftw7BgqRWs5BiLoul7ak5eJsHm03sfOofV/9tF
         Dk5Q==
X-Gm-Message-State: AOAM533xOl/uiocbXMyfx9AsyYgNiJHaDgXA71cOsy2lMfeAUHMISL5b
        0qL1CTQ2bTuYLt6oKYCmejaoCA==
X-Google-Smtp-Source: ABdhPJxsiF8kac/tEGtYUkxNeBvi1f3kf2zTQbgI7Om4gzBJmOXMynu40++VGaL6JdsziqdX0aE4Ng==
X-Received: by 2002:a05:6a00:174a:b0:4fd:ac35:6731 with SMTP id j10-20020a056a00174a00b004fdac356731mr30705575pfc.71.1649646753375;
        Sun, 10 Apr 2022 20:12:33 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id t69-20020a638148000000b0039822f39a40sm26348013pgd.25.2022.04.10.20.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:12:32 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:42:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, maz@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cpufreq: CPPC: Register EM based on efficiency
 class information
Message-ID: <20220411031231.noq5yprp5oui3lsx@vireshk-i7>
References: <20220407081620.1662192-1-pierre.gondois@arm.com>
 <20220407081620.1662192-4-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407081620.1662192-4-pierre.gondois@arm.com>
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

On 07-04-22, 10:16, Pierre Gondois wrote:
> +static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data;
> +	struct em_data_callback em_cb =
> +		EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
> +
> +	if (!efficiency_class_populated)

Instead of a new variable for this, what about setting
cppc_cpufreq_driver.register_em = cppc_cpufreq_register_em, only if
you were able to populate the efficiency class in the first place ?

> +		return;
> +
> +	cpu_data = cppc_cpufreq_search_cpu_data(policy->cpu);
> +	em_dev_register_perf_domain(get_cpu_device(policy->cpu),
> +			get_perf_level_count(policy), &em_cb,
> +			cpu_data->shared_cpu_map, 0);
> +}
> +
>  #else
>  
>  static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
> @@ -471,6 +609,9 @@ static int populate_efficiency_class(void)
>  {
>  	return 0;
>  }
> +static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
> +{
> +}
>  #endif
>  
>  
> @@ -742,6 +883,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.init = cppc_cpufreq_cpu_init,
>  	.exit = cppc_cpufreq_cpu_exit,
>  	.set_boost = cppc_cpufreq_set_boost,
> +	.register_em = cppc_cpufreq_register_em,
>  	.attr = cppc_cpufreq_attr,
>  	.name = "cppc_cpufreq",
>  };
> -- 
> 2.25.1

-- 
viresh
