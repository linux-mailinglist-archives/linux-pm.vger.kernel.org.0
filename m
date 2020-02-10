Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23581572DF
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 11:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBJKbP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 05:31:15 -0500
Received: from foss.arm.com ([217.140.110.172]:58676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgBJKbP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Feb 2020 05:31:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A2B61FB;
        Mon, 10 Feb 2020 02:31:14 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7566A3F68F;
        Mon, 10 Feb 2020 02:31:12 -0800 (PST)
Date:   Mon, 10 Feb 2020 10:31:10 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, lsrao@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
Message-ID: <20200210103110.GB19089@bogus>
References: <CAPDyKFoyepN2VX4COMomp1e9dXPozzrgCdcy0paee2jp8Wm3YA@mail.gmail.com>
 <20200205161816.GD38466@bogus>
 <CAPDyKFqaA7oN2+oLS=Puw+jQXke_ErGQAWYuTuU-6PS7mo5YbQ@mail.gmail.com>
 <20200206204514.GB8107@codeaurora.org>
 <20200207111955.GA40103@bogus>
 <CAPDyKFp-zvD1iFcpRaTFiuazxYmLEx0Czf3=TZJxjSCDmmPsvA@mail.gmail.com>
 <20200207144850.GA18655@e121166-lin.cambridge.arm.com>
 <CAPDyKFoZ+QQFdG3yQ5wGpg2Z5c9WksUhresGz02o3HVrGt1UhQ@mail.gmail.com>
 <20200207161547.GB8342@bogus>
 <CAPDyKFpzr4MA4XuNqCX1jwAzZataVwbVKvADiy39hq=UgDB4tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpzr4MA4XuNqCX1jwAzZataVwbVKvADiy39hq=UgDB4tg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 08, 2020 at 11:25:18AM +0100, Ulf Hansson wrote:
> On Fri, 7 Feb 2020 at 17:15, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Feb 07, 2020 at 04:52:52PM +0100, Ulf Hansson wrote:
> > > On Fri, 7 Feb 2020 at 15:48, Lorenzo Pieralisi
> > > <lorenzo.pieralisi@arm.com> wrote:
> > > >
> > > > On Fri, Feb 07, 2020 at 01:32:28PM +0100, Ulf Hansson wrote:
> > > > > [...]
> > > > >
> > > > > > > I understand the arguments for using PC vs OSI and agree with it. But
> > > > > > > what in PSCI is against Linux knowing when the last core is powering
> > > > > > > down when the PSCI is configured to do only Platform Cordinated.
> > > > > >
> > > > > > Nothing :D. But knowing the evolution and reasons for adding OSI in the
> > > > > > PSCI specification and having argued about benefits of OSI over PC for
> > > > > > years and finally when we have it in mainline, this argument of using
> > > > > > PC for exact reasons why OSI evolved is something I can't understand
> > > > > > and I am confused.
> > > > > >
> > > > > > > There should not be any objection to drivers knowing when all the cores
> > > > > > > are powered down, be it reference counting CPU PM notifications or using
> > > > > > > a cleaner approach like this where GendPD framwork does everything
> > > > > > > cleanly and gives a nice callback. ARM architecture allows for different
> > > > > > > aspects of CPU access be handled at different levels. I see this as an
> > > > > > > extension of that approach.
> > > > > > >
> > > > > >
> > > > > > One thing that was repeatedly pointed out during OSI patch review was no
> > > > > > extra overhead for PC mode where firmware can make decisions. So, just
> > > > > > use OSI now and let us be done with this discussion of OSI vs PC. If PC
> > > > > > is what you think you need for future, we can revert all OSI changes and
> > > > > > start discussing again :-)
> > > > >
> > > > > Just to make it clear, I fully agree with you in regards to overhead
> > > > > for PC-mode. This is especially critical for ARM SoCs with lots of
> > > > > cores, I assume.
> > > > >
> > > > > However, the overhead you refer to, is *only* going to be present in
> > > > > case when the DTS has the hierarchical CPU topology description with
> > > > > "power-domains". Because, that is *optional* to use, I am expecting
> > > > > only those SoC/platforms that needs to manage last-man activities to
> > > > > use this layout, the others will remain unaffected.
> > > >
> > > > In PC mode not only there is no need but it is wrong to manage
> > > > any last-man activity in the kernel. I wonder why we are still
> > > > talking about this to be honest.
> > >
> > > I guess the discussion is here because there is a use case to consider now.
> > >
> >
> > If this is what Bjorn presented in his email, I have responded to that.
> > If it's any different, please let us know the complete details.
> >
> > > For sure, we agree on what is the best solution. But this is rather
> > > about what can we do to improve the current situation, if we should do
> > > anything.
> > >
> >
> > Sure, and I haven't found a reason to do that in OSPM yet(as part of the
> > discussion in this thread)
> >
> > > >
> > > > Code to handle PSCI platform coordinated mode has been/is in
> > > > the kernel today and that's all is needed according to the PSCI
> > > > specifications.
> > >
> > > PSCI specifies CPU power management, not SoC power management. If
> > > these things were completely decoupled, I would agree with you, but
> > > that's not the case. Maybe SCMI, etc, helps with this in future.
> > >
> >
> > Why does that not work even if they are not decoupled. The IO/device
> > that share with CPU votes from OSPM and the CPU/Cluster from PSCI in
> > PC mode. There is no argument there, but why it needs to be done in OSPM
> > is the objection here.
>
> That implies the votes from I/O devices needs to reach the FW
> immediately when the vote is done. No caching or other optimizations
> can be done at OSPM.
>
> In principle, the FW needs to have an always up to date view of the
> votes, etc. That sounds highly inefficient, both from energy and
> latency point of view, at least in my opinion.
>

Sorry but I need to re-iterate, use OSI if you need all those fancy
caching and other optimizations.

> >
> > > Anyway, my fear is that not many ARM vendors implements OSI support,
> > > but still they have "last-man-activities" to deal with. This is not
> > > only QCOM.
> > >
> >
> > I am interested to hear from them. And the same question to same too as
> > above.
>
> I have been talking to some of them. But, yes, we need to hear more from them.
>
> >
> > > I guess an option would be to add OSI support to the public ARM
> > > Trusted Firmware, then we could more easily point to that - rather
> > > than trying to mitigate the problem on the kernel side.
> > >
> >
> > I would say go for it. But don't mix responsibility of OSPM in PC vs OSI.
> > We have discussed this for years and I hope this discussion ends ASAP.
> > I don't see any point in dragging this any further.
>
> Okay.
>

I keep saying that but still responding to the discussions. I must stop ;-)

--
Regards,
Sudeep
