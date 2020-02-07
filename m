Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7527155686
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 12:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgBGLUW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 06:20:22 -0500
Received: from foss.arm.com ([217.140.110.172]:39116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGLUW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Feb 2020 06:20:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0771D328;
        Fri,  7 Feb 2020 03:20:22 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA4093F68E;
        Fri,  7 Feb 2020 03:20:19 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:20:14 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
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
        Rajendra Nayak <rnayak@codeaurora.org>, lsrao@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
Message-ID: <20200207111955.GA40103@bogus>
References: <1580736940-6985-6-git-send-email-mkshah@codeaurora.org>
 <20200203170832.GA38466@bogus>
 <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
 <20200204152132.GA44858@bogus>
 <6ff7c82d-4204-a339-4070-0154ab4515f1@codeaurora.org>
 <20200205140603.GB38466@bogus>
 <CAPDyKFoyepN2VX4COMomp1e9dXPozzrgCdcy0paee2jp8Wm3YA@mail.gmail.com>
 <20200205161816.GD38466@bogus>
 <CAPDyKFqaA7oN2+oLS=Puw+jQXke_ErGQAWYuTuU-6PS7mo5YbQ@mail.gmail.com>
 <20200206204514.GB8107@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206204514.GB8107@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 06, 2020 at 01:45:14PM -0700, Lina Iyer wrote:
> On Thu, Feb 06 2020 at 01:46 -0700, Ulf Hansson wrote:
> > On Wed, 5 Feb 2020 at 17:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > 
> > > On Wed, Feb 05, 2020 at 04:55:17PM +0100, Ulf Hansson wrote:
> > > > On Wed, 5 Feb 2020 at 15:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > >
> > > > > On Wed, Feb 05, 2020 at 05:53:00PM +0530, Maulik Shah wrote:
> > > > > >
> > > > > > On 2/4/2020 8:51 PM, Sudeep Holla wrote:
> > > > > > > On Tue, Feb 04, 2020 at 10:22:42AM +0530, Maulik Shah wrote:
> > > > > > > > On 2/3/2020 10:38 PM, Sudeep Holla wrote:
> > > > > > > > > On Mon, Feb 03, 2020 at 07:05:38PM +0530, Maulik Shah wrote:
> > > > > > > > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > > > >
> > > I was, but not anymore, especially if we want such changes in the kernel
> > > to do so.
> > > 
> > > Just use OSI as that was the point of adding all these after years of
> > > discussion claiming it's more optimal compared to PC. Now telling that
> > > you need more changes to compare it with PC just doesn't make any sense
> > > at all to me.
> > 
> > Fair enough.
> > 
> > I was just pondering over if there are other reasons to why we may want this.
> > 
> > One other thing that could be problematic to support, is when are
> > other resources, I/O controllers for example, sharing the same power
> > rail as a cluster. When such controller is in use, idle states of the
> > cluster must be prevented. Without using genpd to model the CPU
> > topology, it may be difficult to deal with this.
> > 
> > Of course, using PC mode when trying to deal with this
> > platform/board-requirement would also be suboptimal. In other words,
> > your argument about when using OSI vs PC mode, still stands.
> > 
> I understand the arguments for using PC vs OSI and agree with it. But
> what in PSCI is against Linux knowing when the last core is powering
> down when the PSCI is configured to do only Platform Cordinated.

Nothing :D. But knowing the evolution and reasons for adding OSI in the
PSCI specification and having argued about benefits of OSI over PC for
years and finally when we have it in mainline, this argument of using
PC for exact reasons why OSI evolved is something I can't understand
and I am confused.

> There should not be any objection to drivers knowing when all the cores
> are powered down, be it reference counting CPU PM notifications or using
> a cleaner approach like this where GendPD framwork does everything
> cleanly and gives a nice callback. ARM architecture allows for different
> aspects of CPU access be handled at different levels. I see this as an
> extension of that approach.
>

One thing that was repeatedly pointed out during OSI patch review was no
extra overhead for PC mode where firmware can make decisions. So, just
use OSI now and let us be done with this discussion of OSI vs PC. If PC
is what you think you need for future, we can revert all OSI changes and
start discussing again :-)

--
Regards,
Sudeep
