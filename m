Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8034677D925
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 05:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241641AbjHPDhm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Aug 2023 23:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbjHPDfP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2023 23:35:15 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75BA26A1
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2023 20:35:11 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5656a5b83e4so3145630a12.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2023 20:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692156911; x=1692761711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uKnAk/Xph+ooCjp7neP4jhMS6ti/Kex3/YBYp4EHCY=;
        b=fGJ6p3S0dvVhIl+KBHQ16f4O3/ZQU1PrqRQZbD55XTXN9MODcWeRp3hnb5Gn/e8m2Z
         DqWdk0lS7g4+2yTnw2dsnSLIRJMM3HchCsVAGldH2UVm/h2COSCjfyes9rohCg22F8Hb
         41L1V0+ETIAhI883KcPRQhSpayhvjbifI+D4/na35VNKczpyV2p8Yq3+fGxRJFLY6bz0
         soP0FSGjm/WkrD9r+uwLGnjNlmtiRRYEu1MkdSnbmEvh/Xk2KPXUPXVCTRZzKYiyqi2V
         O27p7ePOZTPUBZCrzleOMqhb6bl1vxK5VenvQCquY1Osys2KPLa0wTzhn4/YTP9iBFbX
         JvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692156911; x=1692761711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uKnAk/Xph+ooCjp7neP4jhMS6ti/Kex3/YBYp4EHCY=;
        b=CgOquiaeXbMDDi1yAvUa46jyfX0hcEFiip8hd1nfigfHcEpkgzHNOHvxCnWg2RQ0pM
         +01s6a0s/CIf8vpm05iC4pVF36ldZ6p48IgzG660yvVtuizQvh5k/IThRJx2f4Mqf3YJ
         ub0A4hYWXyC5MzTyhLX6CBOU9innA/4hr1gDTTZUPOArbryflzAgD3vr/9+nJc/yFDZd
         /eVIGbHjnBqngpTF3rlAeLDc/fkAfwub+1KqHFcvndts21StCjKqC4eBQrq7UjW5ifEv
         8akLynHKPyDzsZH+a1iUpRDBSjgC1zr+XCj4vuJ7EMW99D9kZPgLtwtUlyShgQ8w9fkJ
         ZVWA==
X-Gm-Message-State: AOJu0YyICTmShiJNCEzFKvp3Cy/Cflxiu9lTfAkSthIy3+bJuRT0y4Zg
        hE39KlbvPLt8tKX/1exlmV0vxg==
X-Google-Smtp-Source: AGHT+IEOvK3f9k8pyxCSG9nlads7u+6PbLFE/58CUuzr7ty/JQBh6eLY7rSQNh93iFl9oEl7yNvPcg==
X-Received: by 2002:a05:6a21:9987:b0:12f:90d8:9755 with SMTP id ve7-20020a056a21998700b0012f90d89755mr1021970pzb.15.1692156911332;
        Tue, 15 Aug 2023 20:35:11 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902b60e00b001bd41b70b65sm11851481pls.49.2023.08.15.20.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 20:35:10 -0700 (PDT)
Date:   Wed, 16 Aug 2023 09:05:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: Prefer to print cpuid in MIN/MAX QoS
 register error message
Message-ID: <20230816033508.ldo2snqrwj4tgsb5@vireshk-i7>
References: <20230815014002.4132226-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815014002.4132226-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-08-23, 09:40, Liao Chang wrote:
> When a cpufreq_policy is allocated, the cpus, related_cpus and real_cpus
> of policy are still unset. Therefore, it is preferable to print the
> passed 'cpu' parameter instead of a empty 'cpus' cpumask in error
> message when registering MIN/MAX QoS notifier fails.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50bbc969ffe5..a757f90aa9d6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1234,16 +1234,16 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  	ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MIN,
>  				    &policy->nb_min);
>  	if (ret) {
> -		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
> -			ret, cpumask_pr_args(policy->cpus));
> +		dev_err(dev, "Failed to register MIN QoS notifier: %d (CPU%u)\n",
> +			ret, cpu);
>  		goto err_kobj_remove;
>  	}
>  
>  	ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MAX,
>  				    &policy->nb_max);
>  	if (ret) {
> -		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
> -			ret, cpumask_pr_args(policy->cpus));
> +		dev_err(dev, "Failed to register MAX QoS notifier: %d (CPU%u)\n",
> +			ret, cpu);
>  		goto err_min_qos_notifier;
>  	}
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
