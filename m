Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF576253D7D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 08:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgH0GKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 02:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgH0GKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 02:10:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9EDC061251
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 23:10:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so1571914pgl.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 23:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kvUmPPEUXRUMMdd71p7IlSZliwOvsu9WLjoTLyHc+GE=;
        b=f72xNZaz8DpYkB5MJNVJu0AzbPGIOy4RnTLZtogP9xbbhQ3XFFiaM9QuhnVSXWHvgB
         dSUo6tuIW9rTvXljZSKzbA33k2/y7pUWaE0Qh0AerIErSeTJZ4yrb91HzAtErFUN63r7
         wHpBiVuQR6YLn/pjD3GY4RZ07Oz/2Fd6rZLcjY/8xEwdAkvHnVU8z7QwUn39KZ9pbMJe
         Pt08mGBbUVsqXyPuRPDl+tqtkawYpIAq/RBPTIQKKEIYiTaTOlkMA9e0BGwuC8KfqGvC
         /GlXwAkUoApLcqRhmp8phKv6Z6CH2OY3iVHdkuZoDbt6bBVeJjW4hiuUpqZ50K4xoA2w
         PhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kvUmPPEUXRUMMdd71p7IlSZliwOvsu9WLjoTLyHc+GE=;
        b=RyoPVLZWOm6lJICEz/6hxQ51Sf5iQ16pjg5MmDpun5EwE304cP9LHJPfQIbC0xLcJ0
         sVdvX8ytOAlxRHJhm1qw5upPX14uLbllBocM972MZZkpg3WOLf0PMPDNvvokXlW0ZxFl
         qPz7MhX7OvYTdYoPMP5Qnd7R8+JQs2JvJICEZzgU3/WVoW8kg5WMNcVktK6NY7BDvr54
         X+EVFYENECAtfY8/j0YiEW9DU0cgHpUA3XlfCNoaIGD7qgAlWG6aGh9EyEofmjgzNIWx
         +nLfeaRKeXJyxPgQqTiH7akUJFJX11+Su6F8gWDpsb2gUvpPV97PsgP49uBakrTfXnNR
         LYAw==
X-Gm-Message-State: AOAM532HmQ+iyqvkBXYKLuwlwN9WSTwil5uzgNcPL7NJAWhkVl3svIWM
        BIrzskOriWWR/5ZuVbl1M/GBdw==
X-Google-Smtp-Source: ABdhPJz9EcfAFlLK5x87WyF1Q/fc1QZ+/EIqezZ1IWw70vQsIRnTvx6EZEy81qENub+O/Yf5DKp5bQ==
X-Received: by 2002:a17:902:7788:: with SMTP id o8mr87243pll.43.1598508624806;
        Wed, 26 Aug 2020 23:10:24 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id 37sm989677pjo.8.2020.08.26.23.10.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 23:10:24 -0700 (PDT)
Date:   Thu, 27 Aug 2020 11:40:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] arch_topology: validate input frequencies to
 arch_set_freq_scale()
Message-ID: <20200827061022.aocb2wunyxjl2lc6@vireshk-i7>
References: <20200824210252.27486-1-ionela.voinescu@arm.com>
 <20200824210252.27486-2-ionela.voinescu@arm.com>
 <20200825055618.ybght3enlpuwo3va@vireshk-i7>
 <20200825113131.GB12506@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825113131.GB12506@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-08-20, 12:31, Ionela Voinescu wrote:
> On Tuesday 25 Aug 2020 at 11:26:18 (+0530), Viresh Kumar wrote:
> > On 24-08-20, 22:02, Ionela Voinescu wrote:
> > > The current frequency passed to arch_set_freq_scale() could end up
> > > being 0, signaling an error in setting a new frequency. Also, if the
> > > maximum frequency in 0, this will result in a division by 0 error.
> > > 
> > > Therefore, validate these input values before using them for the
> > > setting of the frequency scale factor.
> > > 
> > > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > ---
> > >  drivers/base/arch_topology.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > > index 75f72d684294..1aca82fcceb8 100644
> > > --- a/drivers/base/arch_topology.c
> > > +++ b/drivers/base/arch_topology.c
> > > @@ -33,6 +33,9 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> > >  	unsigned long scale;
> > >  	int i;
> > >  
> > > +	if (!cur_freq || !max_freq)
> > 
> > We should probably use unlikely() here.
> > 
> > Rafael: Shouldn't this have a WARN_ON_ONCE() as well ?
> > 
> 
> I'll add the unlikely() as it's definitely useful.
> 
> I'm somewhat on the fence about WARN_ON_ONCE() here. Wouldn't it work
> better in cpufreq_driver_fast_switch()? It would cover scenarios where
> the default arch_set_freq_scale() is used and flag potential hardware
> issues with setting frequency that are currently just ignored both here
> and in sugov_fast_switch().

I think validation and the WARN (if required) must all happen at the
same place. Considering that there can be many callers of a routine,
like this one, it is better to put all that in the end function only.

Maybe we can add the same in the dummy arch_set_freq_scale() if
required.

-- 
viresh
