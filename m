Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CDC15569E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 12:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBGLZO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 06:25:14 -0500
Received: from foss.arm.com ([217.140.110.172]:39180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGLZO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Feb 2020 06:25:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CC09328;
        Fri,  7 Feb 2020 03:25:13 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1627D3F68E;
        Fri,  7 Feb 2020 03:25:10 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:25:09 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>, swboyd@chromium.org,
        agross@kernel.org, david.brown@linaro.org,
        Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org, rjw@rjwysocki.net
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
Message-ID: <20200207112508.GB40103@bogus>
References: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
 <1580736940-6985-6-git-send-email-mkshah@codeaurora.org>
 <20200203170832.GA38466@bogus>
 <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
 <20200204152132.GA44858@bogus>
 <6ff7c82d-4204-a339-4070-0154ab4515f1@codeaurora.org>
 <20200205140603.GB38466@bogus>
 <20200206211133.GR2514@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206211133.GR2514@yoga>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 06, 2020 at 01:11:33PM -0800, Bjorn Andersson wrote:
> On Wed 05 Feb 06:06 PST 2020, Sudeep Holla wrote:
>
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
> >
>
> Forgive me if I'm misunderstanding PSCI's role here, but doesn't it deal
> with the power management of the "processor subsystem" in the SoC?
>

Yes.

> In the Qualcomm platforms most resources (voltage rails, clocks, etc)
> are controlled through a power controller that provides controls for a
> state when the CPU subsystem is running and when it's asleep. This
> allows non-CPU-related device to control if resources that are shared
> with the CPU subsystem should be kept on when the last CPU/cluster goes
> down.
>

I understand that.

> An example of this would be the display controller voting to keep a
> voltage rail on after the CPU subsystem collapses, because the display
> is still on.
>

OK

> But as long as the CPU subsystem is running it will keep these resources
> available and there's no need to change these votes (e.g. if the display
> is turned on and off while the CPU is active the sleep-requests cancels
> out), so they are simply cached/batched up in the RPMh driver and what
> Maulik's series is attempting to do is to flush the cached values when
> Linux believes that the firmware might decide to enter a lower power
> state.
>

I understand all these. What I am arguing is that in PC mode, PSCI
firmware is the one who needs to vote and not OSPM because it is
responsible for pulling the plugs off the CPU/Cluster. So lets us not
bring that to OSPM. OSI was invented to do all such crazy things in OSPM,
please feel free to play with that ;-)

--
Regards,
Sudeep
