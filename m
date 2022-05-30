Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73ED5376EE
	for <lists+linux-pm@lfdr.de>; Mon, 30 May 2022 10:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiE3IUq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 May 2022 04:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiE3IU3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2022 04:20:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27826CF65
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2022 01:20:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g184so9547066pgc.1
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2022 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=O1Fk/5LwWLArBFySVbbGKsK7AfCyTYV5w7H98MZIQnY=;
        b=PKLyl1u1I9N5Mq/8JOGFvo2jDRBexRJRS9CekTWdAsLfGcnxPeN/xCAgkNt1L/4MNP
         Vk8cFvTolTTGWF6IjLCpKw119W9WArREDTxeNq9YCWuFOm1s9nTFAPJwBXNMKY754E31
         cVGiqyXjQmknzw229prdDPdEP2m8WjMhJPiHxnHD1maqX/Dwr0J2UOppQ3RPYdqsmun5
         UDK4MDr52IveBq4snaCyd6PIrVK98MtIrou6QOwnLsikODjrKYdyfrrhpj/p70yFiP62
         dP2YTpMCn4Wn/D82c3wCNGPTUT8qh9cuV+nHaOd0xcBJFAUPv0KPqIJpCYu2cTeSQA8C
         eH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O1Fk/5LwWLArBFySVbbGKsK7AfCyTYV5w7H98MZIQnY=;
        b=XvlF4gQrW15b2ouDxm8zBSnnVZXl7V+YScwegU8RnZtlhtHux5zR2UtJRNunYs8+Fc
         A+vJwhcemw3XjO9p6WylCmEoqAzZavdWeBPdGSgA+SrA6/TcgyEGPfv4qPrHe+qFW2KF
         pNUvWYS9Lj70C515uV7xKkxazWwKFQNPAfTijFmfq1sweFKe7TvcT2wFsjJ6FH+TVelZ
         K+Sfnzw+POwZCeqqWmKpxcTa9pqLR7vdZBqP/sGJ5KevzopjA4AssyxEj56KLNAEcG68
         NC2p/iWczpeTUSuCOVdbgBa7j4o3iPyjwc47Tv3PC36RJUUuVlmk4aBNk/L+/57pH5ME
         MvCQ==
X-Gm-Message-State: AOAM533H1flx52mzWQQHYmxbYZkgwMd4z5ducQIihXASGu9z9L+9fBw7
        XowkaixtP7i/zcc1DOyNoDA4CQ==
X-Google-Smtp-Source: ABdhPJyqc+13Al1EOCcQY9OP1hpOAoXRydQnSFtr4tRxqd1whs1RTQaCFncvQSAIIkGGmG4y1zhgzA==
X-Received: by 2002:a05:6a00:228d:b0:510:7594:a73c with SMTP id f13-20020a056a00228d00b005107594a73cmr56131332pfe.17.1653898827395;
        Mon, 30 May 2022 01:20:27 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id i4-20020a655b84000000b003faf4acac63sm7912962pgr.13.2022.05.30.01.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:20:27 -0700 (PDT)
Date:   Mon, 30 May 2022 13:50:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: CPPC: Fix unused-function warning
Message-ID: <20220530082025.vqzk37dvyzxiq7dv@vireshk-i7>
References: <20220530081236.40728-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530081236.40728-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-05-22, 10:12, Pierre Gondois wrote:
> Building the cppc_cpufreq driver with for arm64 with
> CONFIG_ENERGY_MODEL=n triggers the following warnings:
>  drivers/cpufreq/cppc_cpufreq.c:550:12: error: ‘cppc_get_cpu_cost’ defined but not used
> [-Werror=unused-function]
>    550 | static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
>        |            ^~~~~~~~~~~~~~~~~
>  drivers/cpufreq/cppc_cpufreq.c:481:12: error: ‘cppc_get_cpu_power’ defined but not used
> [-Werror=unused-function]
>    481 | static int cppc_get_cpu_power(struct device *cpu_dev,
>        |            ^~~~~~~~~~~~~~~~~~
> 
> Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
> Reported-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index d092c9bb4ba3..ecd0d3ee48c5 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -478,7 +478,7 @@ static inline unsigned long compute_cost(int cpu, int step)
>  			step * CPPC_EM_COST_STEP;
>  }
>  
> -static int cppc_get_cpu_power(struct device *cpu_dev,
> +static __maybe_unused int cppc_get_cpu_power(struct device *cpu_dev,
>  		unsigned long *power, unsigned long *KHz)
>  {
>  	unsigned long perf_step, perf_prev, perf, perf_check;
> @@ -547,8 +547,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>  	return 0;
>  }
>  
> -static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
> -		unsigned long *cost)
> +static __maybe_unused int cppc_get_cpu_cost(struct device *cpu_dev,
> +		unsigned long KHz, unsigned long *cost)
>  {
>  	unsigned long perf_step, perf_prev;
>  	struct cppc_perf_caps *perf_caps;

Should we actually run cppc_cpufreq_register_em() for
!CONFIG_ENERGY_MODEL ? Why?

-- 
viresh
