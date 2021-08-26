Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7403F3F84C6
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 11:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbhHZJsu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbhHZJsu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 05:48:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C0CC061757
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 02:48:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j187so2301237pfg.4
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dSMkkkRm2j1QXfEMl4It2DbUIHMbSc3bg5BhkvXbhnk=;
        b=uNWHN3tEfZA7cc07PVEA2qiWnnmYXXq1f9+cBWcG7LnZm3GXQcz163LYUZ4y0+m77+
         cR8GXGWfLER1C4IwTXtktSIDcYGrtuE1UkptWripjlwCzTDCgJy18t7E5Q8tntjH69Gf
         KYZ2fSkxqpjEZTlxiLQQNFgM8EF27tEVOnVsQIOsBuAhRzTOiz+gwtMTZwAouzwnQ3F3
         ++0F+ORsMMXuY+6+h32kDPlV5e00mrfpZFmfx0qg0GMFTzRc/Q9d15y8lsSB2Yadd7oM
         il3b7wKPl4143JIBPScI8WGXSBwuqTBoUre4FUAn0p5hHoasZWGowX6WVAeBOI62GiDA
         k7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dSMkkkRm2j1QXfEMl4It2DbUIHMbSc3bg5BhkvXbhnk=;
        b=GZL9fHmbAF6kEakQVALXXbpdSgdxzrEoI+MRG1iTNqyoPWBlYhG2hVD1PoW8xLPCrc
         Gag4I9d8zadGEwa7lAzTnvtMNOlVeFLJ7reG7lw/yUeTpNzGdL1DDCi0/Uv5lo9E9BRt
         YDQrkX+EqWeGQlFlkplM68iSi3mQnbzfFUOYMcFaf14BAHO9Xu4+/eNimxeqg5T12R5r
         l4VAqcPto2mVbHZx9DOlRT/BsB+z1e6MHzftCY+kxFtPyM1IswqZMxTKMLawym9/iV8h
         i3bHjY+pzdAklKlNIvNDp/quPOTS9QPWXA/jE//xICHMWfghT++Nak2RoPkKtiZgtjD1
         mHgQ==
X-Gm-Message-State: AOAM530PW4r4PlzyXFB7Pj07B8btMLUkl9y7YZ/0Qd3FV+ic58G2YYIB
        mLrbud+D/GWLQizF1diCBrLdMA==
X-Google-Smtp-Source: ABdhPJwng1fppcdZqGAyyLARhhsLJI4Qx4yV66FTe6BQVrTtsQ6HF3kFb2HYGbcji6RdSuzhqHJ1lg==
X-Received: by 2002:aa7:88c3:0:b029:3e0:82e5:1f0b with SMTP id k3-20020aa788c30000b02903e082e51f0bmr2899385pff.15.1629971282905;
        Thu, 26 Aug 2021 02:48:02 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id w18sm2400541pjg.50.2021.08.26.02.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 02:48:02 -0700 (PDT)
Date:   Thu, 26 Aug 2021 15:18:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH v5 8/8] cpufreq: scmi: Read inefficiencies from EM
Message-ID: <20210826094800.k2dqzncyr6bskaqw@vireshk-i7>
References: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
 <1629966944-439570-9-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629966944-439570-9-git-send-email-vincent.donnefort@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-08-21, 09:35, Vincent Donnefort wrote:
> The Energy Model has a 1:1 mapping between OPPs and performance states
> (em_perf_state). If a CPUFreq driver registers an Energy Model,
> inefficiencies found by the latter can be applied to CPUFreq.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 1e0cd4d165f0..f4fd634d2ecd 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -250,6 +250,7 @@ static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
>  {
>  	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
>  	bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
>  	struct scmi_data *priv = policy->driver_data;
>  
>  	/*
> @@ -262,9 +263,9 @@ static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
>  	if (!priv->nr_opp)
>  		return;
>  
> -	em_dev_register_perf_domain(get_cpu_device(policy->cpu), priv->nr_opp,
> -				    &em_cb, priv->opp_shared_cpus,
> -				    power_scale_mw);
> +	em_dev_register_perf_domain(cpu_dev, priv->nr_opp, &em_cb,
> +				    priv->opp_shared_cpus, power_scale_mw);
> +	cpufreq_read_inefficiencies_from_em(policy, em_pd_get(cpu_dev));
>  }
>  
>  static struct cpufreq_driver scmi_cpufreq_driver = {

Same here.

-- 
viresh
