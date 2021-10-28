Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF843DAD4
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 07:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhJ1Fr3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 01:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhJ1Fr2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 01:47:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BD4C061745
        for <linux-pm@vger.kernel.org>; Wed, 27 Oct 2021 22:45:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l203so4949273pfd.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Oct 2021 22:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GG4woYR7NisY/q8Aqftt8VbaoIUjeCAFtan/TYRsjpU=;
        b=GrlMrACUpkv4yRw/bDNI74wjHSJX2ujYSjccxXlMwSqpqwHxbMBmdMvVkv0bO9AjH8
         ic8U5zL/L9NoK4aaLi1aw4q0ZpTdDrdkzCrxPOmAQlBq6v7AxoqEo3ecAb7FVrY4U+01
         yB9/LEjRxgwzYrK+z1kmhEWslqQQBaxUgEthyd6cSKEvhtTrypqWG8bqYIbPvwhjGLuK
         PS3oTkLVzKTq91pmr5BgCC9SRyHeg1dvVQMSMqfh0N5dM9BchT9B4Bhg0enreOm3xcyl
         2CcPf4CeQYiYc7C9LmwNPU+Q2zHLH3VFKvH9P3tobjVq6wjazpM7MpFRkQQ4YpL4ibCp
         Ixog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GG4woYR7NisY/q8Aqftt8VbaoIUjeCAFtan/TYRsjpU=;
        b=zj4FtXcJ4ua2+s7yq467Hn0HfDAkLcFEBAQxFUUs2B37NpRLgziIyMUuKbBAS3xhCx
         RQms88c7oVpvhgWNInfGh3dpohmYgK9KzCTJVTXbN0PvsI1QYKTarsDqVreTFzrtHGOc
         47Mmuglkuj04s/hsW2JSWhqGxmrSt4+w8aD8nfIW0eRRnGjFH6z8A9HKbYd0C224SHJW
         nrYDhlm7ldU/DPWaOeZzS3Gt2BkGXso+yr0MH/y82jy1ougXnpdTrxFVhitUTQI0fRxc
         4cUR2s/yPLxu6xnzpiLP7JCTyKdxZvWmfCGnFCMPOxX3aNR/JAicewwduBFQ9qEAiumP
         ysyw==
X-Gm-Message-State: AOAM531MtSTrgystym/36oa5f4O0MS082XrsYhZJwxloGBBjUPJplhOH
        JZz2ak+rxElcfxbSfnWC4t/bOg==
X-Google-Smtp-Source: ABdhPJykT+5wpjxxfNlbo1iflYwQ32FIIWG5dI2LruihbbOqUdV3QEb5FgCDaxq2gggVjjxyWadZYA==
X-Received: by 2002:a63:3759:: with SMTP id g25mr1671466pgn.231.1635399901817;
        Wed, 27 Oct 2021 22:45:01 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id pj12sm1467465pjb.19.2021.10.27.22.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 22:45:01 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:14:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Subject: Re: [PATCH v2 1/5] arch_topology: Introduce thermal pressure update
 function
Message-ID: <20211028054459.dve6s2my2tq7odem@vireshk-i7>
References: <20211015144550.23719-1-lukasz.luba@arm.com>
 <20211015144550.23719-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015144550.23719-2-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-10-21, 15:45, Lukasz Luba wrote:
> +/**
> + * topology_thermal_pressure_update() - Update thermal pressure for CPUs
> + * @cpus	: The related CPUs for which capacity has been reduced
> + * @capped_freq	: The maximum allowed frequency that CPUs can run at

Maybe replace tabs with spaces here ?

> + *
> + * Update the value of thermal pressure for all @cpus in the mask. The
> + * cpumask should include all (online+offline) affected CPUs, to avoid
> + * operating on stale data when hot-plug is used for some CPUs. The
> + * @capped_freq must be less or equal to the max possible frequency and
> + * reflects the currently allowed max CPUs frequency due to thermal capping.
> + * The @capped_freq must be provided in kHz.
> + */
> +void topology_thermal_pressure_update(const struct cpumask *cpus,
> +				      unsigned long capped_freq)
> +{
> +	unsigned long max_capacity, capacity;
> +	int cpu;
> +
> +	if (!cpus)

I will drop this and let the kernel crash :)

> +		return;
> +
> +	cpu = cpumask_first(cpus);
> +	max_capacity = arch_scale_cpu_capacity(cpu);
> +
> +	/* Convert to MHz scale which is used in 'freq_factor' */
> +	capped_freq /= 1000;

We should make sure capped_freq > freq_factor and WARN if not. This will also
get rid of similar checks at the users.

> +
> +	capacity = mult_frac(capped_freq, max_capacity,
> +			     per_cpu(freq_factor, cpu));
> +
> +	arch_set_thermal_pressure(cpus, max_capacity - capacity);
> +}
> +EXPORT_SYMBOL_GPL(topology_thermal_pressure_update);

-- 
viresh
