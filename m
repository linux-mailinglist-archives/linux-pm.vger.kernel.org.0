Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D5E31E8C8
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 11:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhBRKoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 05:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbhBRJds (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 04:33:48 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA21C0613D6
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:33:07 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z68so812897pgz.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y5EFtSLD4pZwQqPui08w/f2nE8Hwd/5PWKGDMrasgPw=;
        b=ub6w3IbLaHAJBI8T1/E7fc+lPKRpfl2lCVPqMHjAO91msiqm4Lgx0xCmnaD3GDJDTt
         TzNiCxHc3exT3ESMIdBvSF1OX+RSV0YxVoSw1bz3BPaBOKFz/USzcqHuKgejPxAuFIbf
         8cv0ZIt+YaGr5pNGksGFPAL0bjfXVRcU26b8Je/4Se95WXnLj2RTRYjFdWYWzw8plKCD
         z5HR+0gTWVmlgDLRZzq2z2D0f9jubn13lunrGNof8p8e5GFM/nM+2lAZpSLhujLzMihI
         cMPJfZKO3GWu31Ctr5b2JJaYD9bDM5p8DzdzLOJLm1ZfLZq5NrfF3R/5H40g7G7Ph1fw
         EpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y5EFtSLD4pZwQqPui08w/f2nE8Hwd/5PWKGDMrasgPw=;
        b=TqzwQ575YRanIvCdPsluVfoydqWOWmLedk7JM/k4FHJos3B9/1kMNbFWe53+bFVf5s
         eUlYg9jB+g/WnTLyHx871pnNPXAjhKVkYP5qJg8+aPSyiZ395oQyX6znVPKUkHeUBCA8
         il/i0HH9BuS5fwWUP/HQ7AAlIbiHF8jsqO4Kt0A5jOMOX8hkwjsY8z7ufrkwTV5Nz7fd
         7kKyFHWD67aLpJeNRjc9Q9xC1Y1Eg8oEctGNqlpgmiqmceXTOUx8yJB8xxKDMKZ8EeKo
         ZW4pMYRI7ZYSzyPaPdsiV5DNrHcCdywQB+l/30Gkk88e+/Zlcgc9EkFHFfZWZvaUnEzZ
         QXSQ==
X-Gm-Message-State: AOAM531hjWH2/vNIAimvaJ9mfyyTlqpXg9OHL7CxhUBBNhkyUUoQPDl9
        fQSIu1uC5BBWw3d1hvLYuiInJg==
X-Google-Smtp-Source: ABdhPJzmWDkUF+XEu/Fd7S8XY6GJ1/Rv+yNGyliwnb2m8eSYg//p5LFdVT71/My0rSPWXYmE0uBSaA==
X-Received: by 2002:a63:2b82:: with SMTP id r124mr3295183pgr.310.1613640787362;
        Thu, 18 Feb 2021 01:33:07 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id s11sm5145642pfu.69.2021.02.18.01.33.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 01:33:06 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:03:04 +0530
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
Message-ID: <20210218093304.3mt3o7kbeymn5ofl@vireshk-i7>
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
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 1e47dfd465f8..47fca7376c93 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -240,7 +240,6 @@ static struct scale_freq_data amu_sfd = {
> >  
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

Another look at it and here goes another reason (hope I don't have
another in-code comment somewhere else to kill this one) :)

We don't need to care for the reason you gave (which is a valid reason
otherwise), as we are talking specifically about amu_fie_setup() here
and it gets called from cpufreq policy-notifier. i.e. we won't support
AMUs without cpufreq being there in the first place and the same goes
for cppc-driver.

Does that sound reasonable ?

-- 
viresh
