Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3608A15351E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2020 17:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgBEQSW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Feb 2020 11:18:22 -0500
Received: from foss.arm.com ([217.140.110.172]:49256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgBEQSW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Feb 2020 11:18:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78E3A31B;
        Wed,  5 Feb 2020 08:18:21 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D65DF3F68E;
        Wed,  5 Feb 2020 08:18:18 -0800 (PST)
Date:   Wed, 5 Feb 2020 16:18:16 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
Message-ID: <20200205161816.GD38466@bogus>
References: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
 <1580736940-6985-6-git-send-email-mkshah@codeaurora.org>
 <20200203170832.GA38466@bogus>
 <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
 <20200204152132.GA44858@bogus>
 <6ff7c82d-4204-a339-4070-0154ab4515f1@codeaurora.org>
 <20200205140603.GB38466@bogus>
 <CAPDyKFoyepN2VX4COMomp1e9dXPozzrgCdcy0paee2jp8Wm3YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoyepN2VX4COMomp1e9dXPozzrgCdcy0paee2jp8Wm3YA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 05, 2020 at 04:55:17PM +0100, Ulf Hansson wrote:
> On Wed, 5 Feb 2020 at 15:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Feb 05, 2020 at 05:53:00PM +0530, Maulik Shah wrote:
> > >
> > > On 2/4/2020 8:51 PM, Sudeep Holla wrote:
> > > > On Tue, Feb 04, 2020 at 10:22:42AM +0530, Maulik Shah wrote:
> > > > > On 2/3/2020 10:38 PM, Sudeep Holla wrote:
> > > > > > On Mon, Feb 03, 2020 at 07:05:38PM +0530, Maulik Shah wrote:
> > > > > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > >
> > > > > > > If the hierarchical CPU topology is used, but the OS initiated mode isn't
> > > > > > > supported, we need to rely solely on the regular cpuidle framework to
> > > > > > > manage the idle state selection, rather than using genpd and its
> > > > > > > governor.
> > > > > > >
> > > > > > > For this reason, introduce a new PSCI DT helper function,
> > > > > > > psci_dt_pm_domains_parse_states(), which parses and converts the
> > > > > > > hierarchically described domain idle states from DT, into regular flattened
> > > > > > > cpuidle states. The converted states are added to the existing cpuidle
> > > > > > > driver's array of idle states, which make them available for cpuidle.
> > > > > > >
> > > > > > And what's the main motivation for this if OSI is not supported in the
> > > > > > firmware ?
> > > > > Hi Sudeep,
> > > > >
> > > > > Main motivation is to do last-man activities before the CPU cluster can
> > > > > enter a deep idle state.
> > > > >
> > > > Details on those last-man activities will help the discussion. Basically
> > > > I am wondering what they are and why they need to done in OSPM ?
> > >
> > > Hi Sudeep,
> > >
> > > there are cases like,
> > >
> > > Last cpu going to deepest idle mode need to lower various resoruce
> > > requirements (for eg DDR freq).
> > >
> >
> > In PC mode, only PSCI implementation knows the last man and there shouldn't
> > be any notion of it in OS. If you need it, you may need OSI. You are still
> > mixing up the things. NACK for any such approach, sorry.
>
> Sudeep, I don't quite agree with your NACK to this. At least not yet. :-)
>

OK, I am not surprised :-)

> I do agree that the best suited solution seems to be OSI, as to
> support this kind of SoC requirements.
>

That's the main point. We need to draw some line as what we want to do
with PC and OSI mode. If we plan to take up all last man responsibility
in the kernel, what's the point in not supporting OSI in the firmware
then ? I can't buy it yet.

> However, if for some reason the PC mode is being used, we could still
> allow Linux to control "last-man activities" as it knows what each CPU
> has voted for when going idle. Yes, the PSCI FW decides in the end,
> but that doesn't really matter. Or is there another technical reason
> to why you object?
>

Precisely, FW decides and let it. Just because we can do in the kernel
doesn't mean we must do it. It's clear in the spec and doing it in the
kernel will be sub-optimal if PSCI f/w aborted entering the deeper
state that required some action in the first place.

> As a matter of fact, if we allow support for PC mode with
> "last-man-activities", it would allow us to make a fair
> performance/energy comparison between the two PSCI CPU suspend modes,
> for the same SoC. I would be thrilled about looking into doing such
> tests, I bet you are as well!?
>

I was, but not anymore, especially if we want such changes in the kernel
to do so.

Just use OSI as that was the point of adding all these after years of
discussion claiming it's more optimal compared to PC. Now telling that
you need more changes to compare it with PC just doesn't make any sense
at all to me.

--
Regards,
Sudeep
