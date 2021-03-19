Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03673420C1
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 16:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhCSPUi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 11:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhCSPUW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 11:20:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AABC06175F
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 08:20:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so6873284pjq.5
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zhhsrz1cFvWdBmZiUFC1gliqB/pFvI0NRKYpsUgQTDw=;
        b=OnU2E3Djk5wzukZK/xCfu7uLGZSO1XYYn9JZFGDsunYFNjRf+0WY5/OVDXulyIeauz
         Vyi6lolIX6jO71ttDURYxsxnIs0OIDbIofb6RVsX2BK+QNDZiWhln20Nas2ACrlfJiy4
         xtBAgpFc0GvECii5CBO1jD/kL3KP4eAs0f9TpNLtTJkq4Av03aegoJIkwBCvc0NDDBOf
         9o+koqusy5uZbs3q8l0OXdQjpK+1dFaOpapgv4TyTnWvdq2T3p79XfiNbrbVinoVZGHg
         p7JZJmcJKaeekCh87TKNqSFGTPoacmKukKGLzYguAS8jEsgdwX4OQokJvOARdQS/aOvh
         5K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zhhsrz1cFvWdBmZiUFC1gliqB/pFvI0NRKYpsUgQTDw=;
        b=g0ZYr3Jyo4WwfcjE7cqN+hRxEstwlBeheLnwNhytJ4l0Vk0a2pg1ryNaINXBnnQyHS
         eBBtG+MrGxiwJyRUurMsjcpoP9yWjtM2q9FisKXCoqCjhtKNswU4xOm0KYCaomBNlSCE
         ZTkElDofiHj/eEfNMIon6RMQeF6EbAQ5eMTn3tUT8Lu+7abS4iokbA52Kkoi9vtJvARK
         Z0pl+hRRjN+6lJHFVYqCo1o+edbH9wDK9dBm+jRP43eEK0LW+Kj0yf6k6MwltY5DwRd7
         bVfF2nV5qxqWB8EsWgvSk2TOW15vruRkNvZVRaVPPwgu5I0SxcQ8lfQLjbsEBE1krVxI
         QbiQ==
X-Gm-Message-State: AOAM531uqWNZ+aGFbUIiPchRvytp8k7KYQpaGrXJu+DRvf0q1YYgxTrw
        /Zrg7U5yZGk5pVzvAIWlIww3kw==
X-Google-Smtp-Source: ABdhPJw5k1BcV9+YpS4NebiQUIkNRIPiVph5vM3+PE9CvcsMWWUFu4zq/q0BKa0wbFFeZFoJ/3e/2Q==
X-Received: by 2002:a17:90b:1213:: with SMTP id gl19mr10097722pjb.55.1616167221596;
        Fri, 19 Mar 2021 08:20:21 -0700 (PDT)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id g21sm6050613pfk.30.2021.03.19.08.20.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 08:20:20 -0700 (PDT)
Date:   Fri, 19 Mar 2021 20:50:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH] sched: Optimize cpufreq_update_util
Message-ID: <20210319152018.yk6rkpoxiqsx54fc@vireshk-i7>
References: <20210318212826.GW4746@worktop.programming.kicks-ass.net>
 <20210319073751.qz2ytpxl2ikrt2b7@vireshk-i7>
 <5452200.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5452200.DvuYhMxLoT@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-03-21, 15:35, Rafael J. Wysocki wrote:
> On Friday, March 19, 2021 8:37:51 AM CET Viresh Kumar wrote:
> > On 18-03-21, 22:28, Peter Zijlstra wrote:
> > > Also, is there a lock order comment in cpufreq somewhere?
> > 
> > I don't think so.
> > 
> > > I tried
> > > following it, but eventually gave up and figured 'asking' lockdep was
> > > far simpler.
> > 
> > This will get called from CPU's online/offline path at worst, nothing more.
> 
> I'm not sure if I understand you correctly, but for completeness the callback
> is also set/unset on driver registration and governor switch.

Right, I believe that those cases don't have any specific locking constraints
and so scheduler code doesn't need to worry about them. cpuslocked stuff needs
to be considered though.

> > > +static void cpufreq_update_optimize(void)
> > > +{
> > > +	struct update_util_data *data;
> > > +	cpu_util_update_f func = NULL, dfunc;
> > > +	int cpu;
> > > +
> > > +	for_each_online_cpu(cpu) {
> > > +		data = per_cpu(cpufreq_update_util_data, cpu);
> > > +		dfunc = data ? READ_ONCE(data->func) : NULL;
> > > +
> > > +		if (dfunc) {
> > > +			if (!func)
> > > +				func = dfunc;
> > > +			else if (func != dfunc)
> > > +				return;
> > > +		} else if (func)
> > > +			return;
> > > +	}
> > 
> > So there is nothing cpufreq specific IIRC that can help make this better, this
> > is basically per policy.
> 
> Well, in some cases the driver knows that there will never be more that 1 CPU
> per policy and so schedutil will never use the "shared" variant.
> 
> For instance, with intel_pstate all CPUs will always use the same callback.

Right, only for single policy cases we can have some optimization (though I
don't feel its worth here) as this isn't going to happen in hotpath.

-- 
viresh
