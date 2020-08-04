Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CDF23B501
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 08:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgHDGau (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 02:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgHDGau (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 02:30:50 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E59FC061756
        for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2020 23:30:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o5so3556830pgb.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2020 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BS92Sq6q7n94/aHq6JQ3yd1cYmx3gIjRwBJOL6Tqt7s=;
        b=Sg+mW7y8iDCWNlMIqjCofkFAn8mmYpoI5p05fB1k9dPbzPV3dP967l+i1WPVmM9iJj
         L4HItDLcwRP7gn3rhzhNEfUeZAFCKCJg0tyMOKEUOeceu0BBKs/7ZalGZOFe7FuNeHeo
         DLN6Epa2z6pXgYW/HyLtUOpKfLxC1w6PdQ453O7Z70PAkSqKGlxIAjb+b7Bj0Wbuy71k
         yV5X1a6KGtx2qtB0Og0sbYmbDVFaJVJI+07q7OPCelzrT4OmKwo3TKCdLhJO9EjadUB2
         mPmBWTbyLkkuGPlzOhVFNfvDRo6ofK4soaj0bjHN5KFcdPDG4L6Rd2dF/9P3hlWb7kga
         hr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BS92Sq6q7n94/aHq6JQ3yd1cYmx3gIjRwBJOL6Tqt7s=;
        b=NHbIlHCMwM0o7ihbqfYXw1xCTLQ6PVYYv5I1KMn+cQ7+iV9E357SZGAfXyMppKEb+/
         aXWilZS5jp8LulbCZQjLmfdiZmIklEbROcGen3SbULq679Odzu9TdrSE6LKvRZnAUKUV
         9Kt9jP58SJkq3NRw+sihwD3ijS5QyozMlbl2cCKWfYa294vIPp08is/gl3Ams4WlLXjI
         HYE2LIfSccGSF1xXwuLuNnb6pm/BVAU9PTDHRzlUGA60PlI1MJ2+1DFyNqgyGelLLng3
         80bz0GmpvjHYcrCifQeKuGSlIEybP288dmcplW6FIezr2JjEjWrfbPBmFZ0DM/9DgLKj
         +fAw==
X-Gm-Message-State: AOAM531VxQk1oVn29mBvmfLR7Ckp1+Jw7h8zgLorv5XtviQCgL7gr1ki
        TErkwgOpc/c+4MkLg6SF24G/yA==
X-Google-Smtp-Source: ABdhPJyGa9ah22zuDQgf0Ditcuq0XQOapNoNRHgrXa/42Bm+te+ZwAEHhvV26wUUZTLHQtWR54mL+Q==
X-Received: by 2002:a62:647:: with SMTP id 68mr20097776pfg.45.1596522649293;
        Mon, 03 Aug 2020 23:30:49 -0700 (PDT)
Received: from localhost ([122.162.244.227])
        by smtp.gmail.com with ESMTPSA id k21sm17731086pgl.0.2020.08.03.23.30.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 23:30:48 -0700 (PDT)
Date:   Tue, 4 Aug 2020 12:00:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] arch_topology: disable frequency invariance for
 CONFIG_BL_SWITCHER
Message-ID: <20200804063046.a2hw5cxwiewhb3aw@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-4-ionela.voinescu@arm.com>
 <20200730042423.4j22udejluis7blw@vireshk-mac-ubuntu>
 <1db4317a-0018-1590-f0ae-ed5e235b174f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db4317a-0018-1590-f0ae-ed5e235b174f@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-07-20, 12:29, Dietmar Eggemann wrote:
> On 30/07/2020 06:24, Viresh Kumar wrote:
> > On 22-07-20, 10:37, Ionela Voinescu wrote:
> >> +++ b/drivers/base/arch_topology.c
> >> @@ -27,6 +27,7 @@ __weak bool arch_freq_counters_available(struct cpumask *cpus)
> >>  }
> >>  DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
> >>  
> >> +#ifndef CONFIG_BL_SWITCHER
> >>  void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> >>  			 unsigned long max_freq)
> >>  {
> >> @@ -46,6 +47,7 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> >>  	for_each_cpu(i, cpus)
> >>  		per_cpu(freq_scale, i) = scale;
> >>  }
> >> +#endif
> > 
> > I don't really like this change, the ifdef hackery is disgusting and
> > then we are putting that in a completely different part of the kernel.
> > 
> > There are at least these two ways of solving this, maybe more:
> > 
> > - Fix the bl switcher driver and add the complexity in it (which you
> >   tried to do earlier).
> > 
> > - Add a cpufreq flag to skip arch-set-freq-scale call.
> 
> I agree it's not nice but IMHO the cpufreq flag is worse since we would
> introduce new infrastructure only for a deprecated feature. I'm assuming
> that BL SWITCHER is the only feature needing this CPUfreq flag extension.
> 
> #ifdef CONFIG_BL_SWITCHER is already in drivers/irqchip/irq-gic.c so
> it's ugly already.
> 
> Runtime detecting (via bL_switching_enabled) of BL SWITCHER is right now
> also only handled inside vexpress-spc-cpufreq.c via a
> bL_switcher_notifier. A mechanism which also sits behind a #ifdef
> CONFIG_BL_SWITCHER.

Vexpress one is a driver and so ugliness could be ignored here :)

So here is option number 3 (in continuation of the earlier two
options):
- Don't do anything for bL switcher, just add a TODO/NOTE in the
  driver that FIE is broken for switcher. And I don't think anyone
  will care about FIE for the switcher anyway :)

-- 
viresh
