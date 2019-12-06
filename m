Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8216E115404
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 16:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfLFPOc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 10:14:32 -0500
Received: from foss.arm.com ([217.140.110.172]:47556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfLFPOb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Dec 2019 10:14:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C86C831B;
        Fri,  6 Dec 2019 07:14:28 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9F2C3F718;
        Fri,  6 Dec 2019 07:14:26 -0800 (PST)
Date:   Fri, 6 Dec 2019 15:14:21 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v3 10/13] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
Message-ID: <20191206151421.GA5288@e121166-lin.cambridge.arm.com>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
 <20191127102914.18729-11-ulf.hansson@linaro.org>
 <20191205183544.GB1516@e121166-lin.cambridge.arm.com>
 <CAPDyKFra-C_EKrcec6Yys2P10bB+KBtVAKNtVFgqDvV=tzbDRQ@mail.gmail.com>
 <20191206112549.GA22964@e121166-lin.cambridge.arm.com>
 <CAPDyKFq0gS2fasU3Yyh+wPC7Pjnucv6_+vDN234ks+yuiURKCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq0gS2fasU3Yyh+wPC7Pjnucv6_+vDN234ks+yuiURKCw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 06, 2019 at 03:26:16PM +0100, Ulf Hansson wrote:

[...]

> > You can merge it as it is but that's how things stand and adding
> > a comment to the *code* would help understand its logic.
> 
> Okay, how about adding a comment along the lines of this:
> 
> "Using the deepest state for the CPU to trigger a potential selection
> of a shared state for the domain, assumes the domain states are all
> deeper states".

Just this it should be fine (I trimmed it a bit).

> > > So, unless I am missing your point, I think the above code does
> > > exactly what you want, no?
> > >
> > > In regards to the "arbitrary choice" of what cpuidle state to use,
> > > there are more details about why that is, in the changelog.
> > >
> > > >
> > > > This inizialization though does not belong in here, it is done at driver
> > > > level, it should not be done in this per-cpu path. IIUC the logic the
> > > > enter pointer should only be overridden if and only if all cpus managed
> > > > by the driver have a corresponding device associated.
> > >
> > > I think you have overlooked the fact that there are one cpuidle driver
> > > registered per CPU. The above doesn't make sense to me, sorry.
> >
> > You are calling psci_dt_cpu_init_idle() for every possibile cpu.
> >
> > Every time psci_dt_attach_cpu() is called, we check dev and override
> > the idle driver enter method. There is one driver, what I am saying
> > is that it is not correct to check dev and override the enter pointer
> > for *every* cpu that we try to attach to a power domain. This must
> > be done once for all by checking that *all* devices could be attached
> > to a power domain.
> 
> Ah, now I think get your point.
> 
> You want me to re-iterate through all the registered cpuidle drivers,
> which means one per CPU - and then override the enter callback for
> each of them, but only if all devices was successfully attached to a
> PM domain. Is that correct?
> 
> My only worries with this, is that we have already registered the
> cpuidle drivers and I don't think it's a good idea to update the enter
> callbacks, beyond that point.
> 
> Perhaps another option is to track whether the first CPU gets attached
> (and then update the enter callback), but after that require all the
> remaining CPUs to be attached as well - else bail out with an error
> code, failing to register all the driver instances.
> 
> What do you think about that?

I was confused - now we have one cpuidle driver per cpu so this
comment was bogus from this perspective (I was still reasoning
wit a *single* cpuidle driver across cpus. Apologies).

Sudeep will follow up on this but please forget this specific
comment - I was wrong.

Thanks,
Lorenzo
