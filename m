Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9015631D49C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Feb 2021 05:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBQEa1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 23:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhBQE1F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2021 23:27:05 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97958C061788
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 20:26:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r2so6744807plr.10
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 20:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YzQ3Ntnx2eFZZBEtRSvFqcJub5kYZcaEUuwH2LgukfU=;
        b=GF54HJeqkRyhzQ+s1UuFr+w4WNWreO8HkCTv0fjuc8ieF4Vuv1uG68W2aMLLLYVkDL
         27rv7civIAcFkIQZkHqqknj/dKZ2FNRM+hR+6dtEhwLXINCkAG/6BYMDcfvzQSHGYgy6
         nxm4+W7b9nypIGbXtoM0RMQUAAyiUNJNyFlzAXX31eP6kPVkLReHqNsR22vw7f7wr/ti
         9U/Mbq+z/QrGmUUEKZrsjFVM4G4OJv04m9BGogx3DGwPTtrw3C3orl5A0nNx+5jAEdE7
         +MQHhq3fIwc6Ydgyr7ygK0QVnCVkVQU6Rjmpi1ObI1WizR4NuDQ2FmWaDhg2lxXpr+0V
         87ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YzQ3Ntnx2eFZZBEtRSvFqcJub5kYZcaEUuwH2LgukfU=;
        b=LxOccX7ph2clMzkL5YkKJHrUwtkb18VIIxAgUXlFJ8mhTrQFI5oeBIiAXeIcaYNU1b
         cTnRricIjsjTAt7FV9ViHTn2XEZHLIO9QUyAVfFgqkQOEpl+MZzWA/hpqxfEsDqe8+0M
         BrugnK24sp6Q7BYHVMNgtFshXdvpSmkFhy6pLAWQ1pmUTw75NSX58gXDERzYJuEGVT3+
         JLxHBUQgfH8iO49PGBfXMwBkT+VUZ4wu9OF74idPMjycAvbnFwhxAuWvoL31wQmfCNAd
         0R8YdzkmqEYhFw2VwvYFb7Yp+EQ1eRXexacyuDF/vClE5KxBOY3bHBoK6PmxyOQJyaCv
         7DEw==
X-Gm-Message-State: AOAM530gV8uBx87y3TewFvfOOetbRs8Plm4pz3OMX+XPDe1gQaX39cdo
        TYGJ/M2RARmi/NVsVQ3NnkqQ9Ji4mIkD6A==
X-Google-Smtp-Source: ABdhPJwD1MjawYnKf/zWxkffns2EzkYqkyajXQZau0EaYhD/LPRTlppqqZbAVVP4NmCKvXiEjHG10A==
X-Received: by 2002:a17:90b:3781:: with SMTP id mz1mr7396744pjb.178.1613535962017;
        Tue, 16 Feb 2021 20:26:02 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id t17sm695687pgk.25.2021.02.16.20.26.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 20:26:01 -0800 (PST)
Date:   Wed, 17 Feb 2021 09:55:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210217042558.o4anjdkayzgqny55@vireshk-i7>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
 <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
 <20210217002422.GA17422@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217002422.GA17422@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-02-21, 00:24, Ionela Voinescu wrote:
> I think it could be merged in patch 1/2 as it's part of enabling the use
> of multiple sources of information for FIE. Up to you!

Sure.

> >  static void amu_fie_setup(const struct cpumask *cpus)
> >  {
> > -	bool invariant;
> >  	int cpu;
> >  
> >  	/* We are already set since the last insmod of cpufreq driver */
> > @@ -257,25 +256,10 @@ static void amu_fie_setup(const struct cpumask *cpus)
> >  
> >  	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
> >  
> > -	invariant = topology_scale_freq_invariant();
> > -
> > -	/* We aren't fully invariant yet */
> > -	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
> > -		return;
> > -
> 
> You still need these checks, otherwise you could end up with only part
> of the CPUs setting a scale factor, when only part of the CPUs support
> AMUs and there is no cpufreq support for FIE.

Both supports_scale_freq_counters() and topology_scale_freq_invariant() take
care of this now and they will keep reporting the system as invariant until the
time all the CPUs have counters (in absence of cpufreq).

The topology_set_scale_freq_source() API is supposed to be called multiple
times, probably once for each policy and so I don't see a need of these checks
anymore.

> Small(ish) optimisation at the beginning of this function:
> 
>     if (cpumask_empty(&scale_freq_counters_mask))
>         scale_freq_invariant = topology_scale_freq_invariant();
> 
> This will save you a call to rebuild_sched_domains_energy(), which is
> quite expensive, when cpufreq supports FIE and we also have counters.

Good Point.
 
> After comments addressed,
> 
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thanks.

> Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>

Just out of curiosity, what exactly did you test and what was the setup ? :)

-- 
viresh
