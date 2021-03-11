Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DC8336A40
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 03:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCKCwt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 21:52:49 -0500
Received: from foss.arm.com ([217.140.110.172]:56834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhCKCwa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Mar 2021 21:52:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 985A31FB;
        Wed, 10 Mar 2021 18:52:24 -0800 (PST)
Received: from bogus (unknown [10.163.66.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DC383F793;
        Wed, 10 Mar 2021 18:52:21 -0800 (PST)
Date:   Thu, 11 Mar 2021 02:52:13 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        Sudeep Holla <sudeep.holla@arm.com>, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, ksitaraman@nvidia.com, sanjayc@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/5] dt-bindings: arm: Add cpu-idle-states to Tegra194
 CPU nodes
Message-ID: <20210311025138.o4ub4j2ss725zpv4@bogus>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
 <1614838092-30398-4-git-send-email-skomatineni@nvidia.com>
 <20210308043755.llvdsuz2jwvweovb@bogus>
 <4cebf482-a2f8-5a79-a2f6-4ccd7d31c6ad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cebf482-a2f8-5a79-a2f6-4ccd7d31c6ad@nvidia.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 08, 2021 at 10:32:17AM -0800, Sowjanya Komatineni wrote:
>
> On 3/7/21 8:37 PM, Sudeep Holla wrote:
> > On Wed, Mar 03, 2021 at 10:08:10PM -0800, Sowjanya Komatineni wrote:
> > > This patch adds cpu-idle-states and corresponding state nodes to
> > > Tegra194 CPU in dt-binding document
> > >
> > I see that this platform has PSCI support. Can you care to explain why
> > you need additional DT bindings and driver for PSCI based CPU suspend.
> > Until the reasons are convincing, consider NACK from my side for this
> > driver and DT bindings. You should be really using those bindings and
> > the driver may be with minor changes there.
> >
> MCE firmware is in charge of state transition for Tegra194 carmel CPUs.
>

Sure, but I assume only TF-A talks to MCE and not any OSPM/Linux kernel.

> For run-time state transitions, need to provide state request along with its
> residency time to MCE firmware which is running in the background.
>

Sounds similar to x86 mwait, perhaps we need to extend PSCI if we need
to make this firmware PSCI compliant or just say it is not and implement
completely independent implementation. I am not saying that is acceptable
ATM but I prefer not to mix some implementation to make it look like
PSCI compliant.

> State min residency is updated into power_state value along with state id
> that is passed to psci_cpu_suspend_enter
>

Sounds like a hack/workaround. I would prefer to standardise that. IIUC
the power_state is more static and derived from DT. I don't like to
overload that TBH. Need to check with authors of that binding.

> Also states cross-over idle times need to be provided to MCE firmware.
>

New requirements if this has to be PSCI compliant.

> MCE firmware decides on state transition based on these inputs along with
> its background work load.
>
> So, Tegra specific CPU idle driver is required mainly to provide cross-over
> thresholds from DT and run time idle state information to MCE firmware
> through Tegra MCE communication APIs.
>

I am worried if different vendors will come up with different custom
solution for this. We need to either standardise this is Linux/DT or
in PSCI.

> Allowing cross-over threshold through DT allows users to vary idle time
> thresholds for state transitions based on different use-cases.
>

Sounds like policy and not platform specific to be in DT, but I will leave
that to DT maintainers.

--
Regards,
Sudeep
