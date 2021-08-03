Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCD3DE56C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 06:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhHCEfA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 00:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhHCEe6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 00:34:58 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05722C06175F
        for <linux-pm@vger.kernel.org>; Mon,  2 Aug 2021 21:34:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d1so22228408pll.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Aug 2021 21:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2S1RHICTPvCBoDexjUcvrU4GD6pFJPXLIcRegSCBHdk=;
        b=mjbQfGcylJTRFPAW9GXK36eRTClW08a5/wkDQvK2alnHWb4D2eS+vERUS7qNyAzm+1
         GPOqu/S8lHa8m5uo+ZyYYoFofGuGAygfi64cyXODwSXc07e5OMNaRAQrd2hisxEL9WId
         8bJHo0J+ftMIfuvK1XFEeVM1khMmT/tH3QmTZCcifXYlcI05AohG3h1Ul64VhY49a3VU
         sJR0NFRefikOz4/+mAOB02LWyEiRPZOQVD0hCxW7rBFywNBFaiw97Hd6hgVC2FqMOyqq
         5bNiAkd6L7ByxvhlsNPVvpGXgJBmVqCDWIfow0jPRB2y2v0pudlSFcPMy41VuDU8J9Gn
         ToWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2S1RHICTPvCBoDexjUcvrU4GD6pFJPXLIcRegSCBHdk=;
        b=XhkGqA6zLGB0M1DvJc3zZ1i/XRWtPblCEfzHbbU8a22UbYbKzZOMxODwbOYUkkRIdA
         xk8ASeWUcdi7tircgPJN0DYgJMLpBxMxBhW7dTE+PilRsh3gBDgOCwYer7U7r9BOcK6w
         y057F2cwqvU06s35gE7LDyj1aRckOKJ8tmNrggNj+p4BgbdUdderkQ/BJuN+lG/IUz95
         wmopJlecfDXBJyFSxS8WgFJ84mrQrd/D0DQrVTBMKJrhBg+1D6TLnebjy/2NKC30whj1
         p9+792DRfJ1EcKCdgVFGztAPV5NEvWaDVU93fVEVa+VqV0JIq3i+t9FG5BMu5sAstjSF
         AN4w==
X-Gm-Message-State: AOAM533jx1yIOkVFhzltyMnHCwFJxv/RmSZdyixoGqaaIwfarj/7cFOC
        4HwRxjaRs+eUyTBxHogKbRLY1Q==
X-Google-Smtp-Source: ABdhPJyVmHXqHdDoagUFheP2VyeQD9jdDbE1g7DzOLalHOMX9IWKd2ylNNQgDlVH6IcTo3GbFFiHaQ==
X-Received: by 2002:a65:6813:: with SMTP id l19mr1158826pgt.118.1627965287503;
        Mon, 02 Aug 2021 21:34:47 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id l6sm13452830pff.74.2021.08.02.21.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 21:34:47 -0700 (PDT)
Date:   Tue, 3 Aug 2021 10:04:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        cristian.marussi@arm.com, rjw@rjwysocki.net,
        nicola.mazzucato@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: arm_scmi: Fix error path when allocation failed
Message-ID: <20210803043445.7sm4mnl4f5f7co7h@vireshk-i7>
References: <20210802204550.12647-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802204550.12647-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-08-21, 21:45, Lukasz Luba wrote:
> Print warning and return an error which would stop the initialization
> when cpumask allocation failed.
> 
> Fixes: 80a064dbd556 ("scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM")
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index ec9a87ca2dbb..b159123e68fd 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -133,8 +133,10 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  		return -ENODEV;
>  	}
>  
> -	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
> -		ret = -ENOMEM;
> +	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL)) {
> +		dev_warn(cpu_dev, "failed to allocate cpumask\n");

We shouldn't be printing here anything I believe as the allocation
core does it for us. That's why you won't see a print message anywhere
for failed allocations.

> +		return -ENOMEM;
> +	}
>  
>  	/* Obtain CPUs that share SCMI performance controls */
>  	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
> -- 
> 2.17.1
> 

-- 
viresh
