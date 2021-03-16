Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42B933CD64
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 06:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhCPFjS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 01:39:18 -0400
Received: from foss.arm.com ([217.140.110.172]:45128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232611AbhCPFit (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Mar 2021 01:38:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38DF3D6E;
        Mon, 15 Mar 2021 22:38:48 -0700 (PDT)
Received: from bogus (unknown [10.163.66.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F9E03F792;
        Mon, 15 Mar 2021 22:38:44 -0700 (PDT)
Date:   Tue, 16 Mar 2021 05:38:37 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, ksitaraman@nvidia.com,
        sanjayc@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/5] dt-bindings: arm: Add cpu-idle-states to Tegra194
 CPU nodes
Message-ID: <20210316053837.apw3g7sbyqrpu7xn@bogus>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
 <1614838092-30398-4-git-send-email-skomatineni@nvidia.com>
 <20210308043755.llvdsuz2jwvweovb@bogus>
 <4cebf482-a2f8-5a79-a2f6-4ccd7d31c6ad@nvidia.com>
 <20210311025138.o4ub4j2ss725zpv4@bogus>
 <b31d14ef-81d8-0480-805b-a3cb64404b12@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b31d14ef-81d8-0480-805b-a3cb64404b12@nvidia.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Lorenzo

Hi Sowjanya,

Sorry for the delayed response. I am still in vacation 😉

On Thu, Mar 11, 2021 at 01:11:37PM -0800, Sowjanya Komatineni wrote:
>
> On 3/10/21 6:52 PM, Sudeep Holla wrote:
> > On Mon, Mar 08, 2021 at 10:32:17AM -0800, Sowjanya Komatineni wrote:
> > > On 3/7/21 8:37 PM, Sudeep Holla wrote:
> > > > On Wed, Mar 03, 2021 at 10:08:10PM -0800, Sowjanya Komatineni wrote:
> > > > > This patch adds cpu-idle-states and corresponding state nodes to
> > > > > Tegra194 CPU in dt-binding document
> > > > >
> > > > I see that this platform has PSCI support. Can you care to explain why
> > > > you need additional DT bindings and driver for PSCI based CPU suspend.
> > > > Until the reasons are convincing, consider NACK from my side for this
> > > > driver and DT bindings. You should be really using those bindings and
> > > > the driver may be with minor changes there.
> > > >
> > > MCE firmware is in charge of state transition for Tegra194 carmel CPUs.
> > >
> > Sure, but I assume only TF-A talks to MCE and not any OSPM/Linux kernel.
>
> No. Tegra194 CPU idle driver works with MCE firmware running in background
> so cpuidle kernel driver also talks to MCE firmware directly on state
> information.

If that is the case I wouldn't term this as PSCI compliant firmware and
wouldn't attempt to use PSCI CPU idle driver. Now if we would what to allow
non-PSCI idle driver for Arm64 is entirely different question that deserves
a separate discussion IMO.

> >
> > > For run-time state transitions, need to provide state request along with its
> > > residency time to MCE firmware which is running in the background.
> > >
> > Sounds similar to x86 mwait, perhaps we need to extend PSCI if we need
> > to make this firmware PSCI compliant or just say it is not and implement
> > completely independent implementation. I am not saying that is acceptable
> > ATM but I prefer not to mix some implementation to make it look like
> > PSCI compliant.
> >
> > > State min residency is updated into power_state value along with state id
> > > that is passed to psci_cpu_suspend_enter
> > >
> > Sounds like a hack/workaround. I would prefer to standardise that. IIUC
> > the power_state is more static and derived from DT. I don't like to
> > overload that TBH. Need to check with authors of that binding.
>
> Passing state idle time to ATF along with state to enter is Tegra specific
> as ATF firmware updates idle time to Tegra MCE firmware which will be used
> for deciding on state transition along with other information and background
> load.
>

So far we don't have any platform specific PSCI in OSPM and I prefer to keep
it that way.

> Not sure if this need to be standardized but will try to find alternate way
> to update idle time without misusing power-state value.
>

Sure, we can always review and see if any alternatives are acceptable, but
I am bit nervous to tie this as PSCI if it is not strictly spec compliant.

> Will discuss on this internally and get back.
>

Thanks.

> >
> > > Also states cross-over idle times need to be provided to MCE firmware.
> > >
> > New requirements if this has to be PSCI compliant.
>
> Updating cross-over idle times from DT to MCE firmware directly from cpuidle
> kernel driver with corresponding MCE ARI commands is again Tegra specific.
>

So all there are platform specific but static information you need from DT ?
If so, what can't it be made part of TF-A and OSPM can avoid interfering
with that info completely. My understanding was that OSPM provides runtime
hints like x86 mwait. If that's not the case, I am failing to understand
the need for OSPM to pass such static information from DT to the firmware.
Why can't that be just part of the firmware to begin with ?

> >
> > > MCE firmware decides on state transition based on these inputs along with
> > > its background work load.
> > >

What do you mean by this *"background work load"* ?

--
Regards,
Sudeep
