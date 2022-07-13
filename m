Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F737572D0D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 07:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiGMF1S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jul 2022 01:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGMF1R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2022 01:27:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B374DC19C
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 22:27:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso1809688pjh.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 22:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zvW+o5uKBthmVUls/1elyqXM1AaF9zOZaR17pydOr9o=;
        b=SYYCkjjhLhUq1gG5HoagDvTiIsLUbkH6MbXPdcYFxwTa7DvOaT7vSoW7ajw+eK/ChO
         JfahcowXhYw5aLQs3yxTZe3MZzQnyqcgRY5gj5BpT5tHKCZzDveN8agWbpkvEscSFCvD
         Jb/NiGg1dAUq2LkIdGU3KdTcK8LDvo3NymQS+/eJzjhnPTevvsl1bH2j98uzi/QTdi+B
         q9hxxeW6dFNUnGqRxLA1B1UEbSW/grWUGda80BDWqvwAAEu1KD3Gj8SchBt/TpZA4zvB
         gSC6wvboTm55u6PjyiIB2a1CP5O+Vqp+TIMmBy+I1rZZ/Idkx3rwTw9xUPAP/r0lkAxK
         08MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zvW+o5uKBthmVUls/1elyqXM1AaF9zOZaR17pydOr9o=;
        b=HlyYqo/+kKtzSt8faKL9zxYl9B5BZkbjExyQ8m8CGzIw/uWqOSc8PtCzmYoEF1h3Ni
         Kq2TIP3ZYvCFr7UHWdnLFpJHP9u3b3BmIfu8Of2oAf5Oylj+wdUvjw+fhpvZV5/dAbKt
         +IqP/+uOXvMgjWxPFepOpArTvvYga0ZKMCQNcZYji089xOqTQ1uqA5YhXyxGaNaRjVdS
         uLrkwoLNLimSQIsSYurnE1f0FMIngaSGlS5bYAlNPBBrmmZLckX6K269AL7ep4I+JZ2n
         UfOlVWHOowMOEsKFOpNEm1/t9rNAx4/2DBvcwE7AJnKjwso7p515K6RIbIU3112aQp6n
         QccA==
X-Gm-Message-State: AJIora/PUcqimIH5uDzBpDzdx9IPcqznXQg+cf+IZKmw1RWzgSsPxcaR
        dV2To8n6sZ4+oUI3PiyXUgd6tQ==
X-Google-Smtp-Source: AGRyM1vDScV1/LupdvYjMPuAPAFZiWIRwwOXtpuzLfvL9zTRaTkz14x9qLC/jQlmlMV3eY/WX5xIKw==
X-Received: by 2002:a17:902:a716:b0:16c:37fc:660c with SMTP id w22-20020a170902a71600b0016c37fc660cmr1514024plq.17.1657690035569;
        Tue, 12 Jul 2022 22:27:15 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id c6-20020a621c06000000b00528c34f514dsm7760651pfc.121.2022.07.12.22.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:27:12 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:57:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 04/13] cpufreq: amd-pstate: prefetch cppc_req_cached
 value in amd_pstate_cpu_init()
Message-ID: <20220713052708.2paskxzl6s32j4yd@vireshk-i7>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
 <001d002ba93580763421c712247bf8d9faa67756.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d002ba93580763421c712247bf8d9faa67756.1657638462.git.Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-07-22, 11:40, Perry Yuan wrote:
> This cppc_req_cached valued should be prefetched during
> amd_pstate_cpu_init call period, then the amd_pstate_update() will get
> correct cached value before updating the perf to change the cpu perf
> level.

You are doing more than this in the patch, either mention all the
stuff with reasoning or split into two patches.

> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 43e6df9f67f6..e4904da54541 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -547,12 +547,17 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
>  
>  	policy->driver_data = cpudata;
> +	if (!shared_mem) {

This is a new change, which the commit log doesn't talk about.

> +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
>  
> -	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
> -	if (ret)
> -		return ret;
> -	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
> -
> +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +	}
>  	amd_pstate_boost_init(cpudata);
>  
>  	return 0;
> -- 
> 2.25.1

-- 
viresh
