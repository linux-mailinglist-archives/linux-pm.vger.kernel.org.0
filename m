Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4583E8910
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 06:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhHKEC1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 00:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhHKEC1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 00:02:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAA9C061765
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 21:02:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e19so945169pla.10
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 21:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jRwfuGmvF8xbiPUIJCPloUI3wsZDXM/h0JGCw+MPHd0=;
        b=l7iO+YU8dcuI5Hc29W3yz451VLZwJ3dYgtNNUS+RBLqxW3FQQWbtqDjL4tcbD7kK0s
         eo7kbChJibj3n3JX5STWMNxCmIpARAYm9wBkLzj48iyIh7PCUm5Loy46dYpbJhKk0LV/
         P7CepF7En1BhHjaZD/kH787tGYhRVgccgk1Y3Se/2U1hflRdTXz9PM8HNvU7un1UQFZC
         VTLNnZKzjIQFK7w0jlyM2M9caqhhxCe31EEsgUhkZMs+fx6ODQCqa7cYLz3aaN7e4vwD
         3SwagOiDpdiEoHU3SkWJqUWxNCCwcTX7EaVCzNkEiuhRiUv82zIuCcuLM4R8F/ij9o/s
         4dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jRwfuGmvF8xbiPUIJCPloUI3wsZDXM/h0JGCw+MPHd0=;
        b=Yjs+ImZRuphCKqRc3wqjWd/CHjKU2nu4xA6rqlx8Q1Zxd+mcVeXNlLjMvNoMOjEZUI
         TVHj/6FOOwq2fPq//OGkTaFhCnBp++wq7B6v7oIt2NptwSqRk9E2in4YW8oYzEfoj0Ob
         t03qiyT6EIn7/I0rPjTkYdpNOA1Y+sX50qX1AuxLh4uFK7iWtLrtOaRDZRYJtLEE+Aef
         VGmiki75+UDwLbOndbwD5oc9zqvS11hWvNiTdyAta8RQIA6dia2ZXVzf80pOcK1C9ghg
         /WqQj7re4p8BlN8sF9G1AAbzF7BuFtD5znX6UkLZ0bqN6ThchR16swZD4Tdd1Hu1pkL6
         uukQ==
X-Gm-Message-State: AOAM533Zn2LIiNKOLt9fA8a8QZsrAguAUxuvyg1jUSCK3UJQNT7DUMGQ
        tr90eJXl+/Qt8hJuwHH7sdEVsNotCMDmqQ==
X-Google-Smtp-Source: ABdhPJwFLFMwpYrnuPmtpdpOFSeI+0vU/VaYZvSu2FG7aUSb2Fzi9mhS0LY1gh1ymqEtCRFXCdT3fw==
X-Received: by 2002:a17:902:d918:b029:12d:22d5:869a with SMTP id c24-20020a170902d918b029012d22d5869amr12757592plz.82.1628654523671;
        Tue, 10 Aug 2021 21:02:03 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id a8sm30644175pgd.50.2021.08.10.21.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 21:02:03 -0700 (PDT)
Date:   Wed, 11 Aug 2021 09:31:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
Message-ID: <20210811040158.pp22htkw4nhnudwr@vireshk-i7>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
 <78bc08fe-71c2-398c-9a10-caa54b8bd866@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78bc08fe-71c2-398c-9a10-caa54b8bd866@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-08-21, 13:28, Lukasz Luba wrote:
> On 8/10/21 7:13 AM, Viresh Kumar wrote:
> > A cpufreq table is provided by the driver, which can have some
> > inefficient frequencies. The inefficient frequencies can be caught by
> > many parts of the kernel, the current way (in this series) is via EM.
> > But this can totally be anything else as well, like a devfreq driver.
> 
> Currently devfreq drivers and governors don't support 'inefficient'
> OPPs idea. They are not even 'utilization' driven yet. I'm not sure
> if that would make sense for their workloads. For now, they are far
> behind the CPUFreq/scheduler development in this field.

That's not my point.

> It needs more research and experiments, to even estimate if this brings
> benefits. So, I would just skip devfreq use case...

I don't care about devfreq case at all, just like you. What I am
saying is that this API can be called from anywhere and hard-coding
this for just EM is a plain Hack. A framework should never allow it.

> > I understand that the current problem is where do we make that call
> > from and I suggested dev_pm_opp_of_register_em() for the same earlier.
> > But that doesn't work as the policy isn't properly initialized by that
> > point.
> 
> True, the policy is not initialized yet when cpufreq_driver::init()
> callback is called, which the current place for scmi-cpufreq.
> 
> What about the other callback cpufreq_driver::ready() ?
> This might solve the two issues I mentioned below.

Yeah, lets see if we can solve that problem here.

> > Now that I see the current implementation, I think we can make it work
> > in a different way.
> > 
> > - Copy what's done for thermal-cooling in cpufreq core, i.e.
> >    CPUFREQ_IS_COOLING_DEV flag, for the EM core as well. So the cpufreq
> >    drivers can set a flag, CPUFREQ_REGISTER_EM, and the cpufreq core
> >    can call dev_pm_opp_of_register_em() on their behalf. This call will
> >    be made from cpufreq_online(), just before/after
> >    cpufreq_thermal_control_enabled() stuff. By this point the policy is
> >    properly initialized and is also updated in
> >    per_cpu(cpufreq_cpu_data).
> > 
> > - Now the cpufreq core can provide an API like
> >    cpufreq_set_freq_invariant(int cpu, unsigned long freq), which can
> >    be called from EM core's implementation of
> >    em_dev_register_perf_domain().
> > 
> 
> I have to point out that there are two issues (which we
> might solve):
> 1. Advanced setup, due to per-CPU performance requests,
> which are not limited to real DVFS domain.
> The scmi-cpufreq (and possibly some other soon) uses more
> tricky EM setup. As you might recall, the construction of temporary
> cpumask is a bit complex, since we want per-CPU policy, but the
> cpumask pass to EM has not a single bit but is 'spanned' with a few
> CPUs.
> 
> 2. The scmi-cpufreq (and IIRC MTK cpufreq driver soon) requires
> custom struct em_data_callback, since the power data is coming from FW.
> 
> If there is a need for complex EM registration, maybe we could
> do it in the cpufreq_driver::ready(). The policy would be ready
> during that call, so it might fly.

-- 
viresh
