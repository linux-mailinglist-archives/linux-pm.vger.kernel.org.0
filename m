Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAAF3E9D43
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 06:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhHLEWc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 00:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhHLEWb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 00:22:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67448C061765
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:22:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so8656050pjl.4
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V2OoNgUgDhLYLo0G/A9MxruZCr+/VPFKnTGlfuhSRBg=;
        b=Cp0YBwB3VoJ6c1xlgx8o0IXEBN7VUK7qeorVOgi6mSqV0k8cW0qYQ4PtF/hz4+mCeH
         jfZnSgVzPWfbQQrVeIpbNEhi/mXhg+yTZAHgxHxdLws72JTAIEno2pU3Z22pk1Z3df0W
         RUGEGrmMrxGeWGSG+fti9x2zWGFw+9eQwXxrm6BE2RkRnfE/f6Qwye48KJLKQ7wDb7vC
         elcsOVs+mocn2d8dePThq1JD7OrEMittYEmcqOB8jnB0kNlPUXuFNxJvarKHwZYOmkQX
         s0KaCTJ5VTGyx8QJix6/0NhOGitJntW9+Wqh8rk4mdrEcZdx9aUPrZNSKNviBkSItFJE
         Aegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V2OoNgUgDhLYLo0G/A9MxruZCr+/VPFKnTGlfuhSRBg=;
        b=Siro2JZOkzfgqihlMedcf4J6lPKjHss7a5y3zQbIMtP4Kr+MploHDkK/lWbmpk7A3c
         MRTjbRg5deunVBuOxzIht/gbYOz2b5ps2ULjF+jeo9TnHLSiEwngGeGokYyH2z3x/yBN
         zmBW6JquZXjWuaAVLnEQK6LdU17yXJqZxfCZjrbotdZ7jN+ISLr8ST+OlpV6ASdfcM7U
         ipWSLZdOu7JAfD0VEoAslVZtSmz+n6OJfIPJ1XfnOGYTT4cyKIkHATczvPz1LFr2YTs4
         izH7h98v2aVu3dy1LIi4RfVsHg9IwGUUOqYUuTZF62VjF4VLWu7vTfCLX9bm8+PgHLki
         tw9w==
X-Gm-Message-State: AOAM533pOSEtAeeujv+29RFHXmc0L6h2enRQiXUWRQGD2LXPqdEBzPv4
        mcaqCP78oJ01xzW8Dj3brR3l3g==
X-Google-Smtp-Source: ABdhPJySH0sOcWbvWBwKwwS9V1PFVMc96Xd12LGXhQOasIzv3HTUQxkmrRpQYi6FkNoPzJJILXNdLw==
X-Received: by 2002:a63:7883:: with SMTP id t125mr2028840pgc.243.1628742127011;
        Wed, 11 Aug 2021 21:22:07 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id gz23sm1146608pjb.0.2021.08.11.21.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:22:06 -0700 (PDT)
Date:   Thu, 12 Aug 2021 09:52:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 9/9] cpufreq: scmi: Use .register_em() callback
Message-ID: <20210812042204.lxugyjxa2cyz45ib@vireshk-i7>
References: <cover.1628682874.git.viresh.kumar@linaro.org>
 <6094d891b4cb0cba3357e2894c8a4431c4c65e67.1628682874.git.viresh.kumar@linaro.org>
 <143a03df-d858-b2de-a2cc-983c35d71e53@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <143a03df-d858-b2de-a2cc-983c35d71e53@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-08-21, 17:32, Lukasz Luba wrote:
> 
> 
> On 8/11/21 12:58 PM, Viresh Kumar wrote:
> > Set the newly added .register_em() callback to register with the EM
> > after the cpufreq policy is properly initialized.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >   drivers/cpufreq/scmi-cpufreq.c | 55 ++++++++++++++++++++--------------
> >   1 file changed, 32 insertions(+), 23 deletions(-)
> 
> > +static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
> > +{
> > +	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
> > +	bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
> > +	struct scmi_data *priv = policy->driver_data;
> > +
> > +	em_dev_register_perf_domain(get_cpu_device(policy->cpu), priv->nr_opp,
> > +				    &em_cb, priv->opp_shared_cpus,
> > +				    power_scale_mw);
> 
> I would free the priv->opp_shared_cpus mask here, since we don't
> need it anymore and memory can be reclaimed.

Yes, we don't need it anymore, but this isn't a good place to undo
what init() has done. Moreover, it is possible that register_em() may
not get called at all, if some error has occurred after init() has
successfully returned. It is always better to use exit() for such
things. It won't hurt a lot to keep this around anyway.

> Don't forget this
> setup would be called N CPUs times, on this per-CPU policy platform.

Yes, but EM will just ignore this call. Though I have made a change
here now to check for non-zero nr_opp to avoid the unnecessary call.

> If freed here, then also there wouldn't be a need to free it in
> scmi_cpufreq_exit() so you can remove it from there.

-- 
viresh
