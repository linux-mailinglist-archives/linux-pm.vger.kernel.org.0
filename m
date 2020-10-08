Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C612879AC
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgJHQHK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 12:07:10 -0400
Received: from foss.arm.com ([217.140.110.172]:37012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgJHQHJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 12:07:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F4F031B;
        Thu,  8 Oct 2020 09:07:09 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B46953F70D;
        Thu,  8 Oct 2020 09:07:08 -0700 (PDT)
Date:   Thu, 8 Oct 2020 17:07:07 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2]cpufreq,topology,arm: disable FI for BL_SWITCHER
Message-ID: <20201008160707.GA29728@arm.com>
References: <20200924123016.13427-1-ionela.voinescu@arm.com>
 <CAJZ5v0hr+MZzokObNq5L0q1Fd0M5EXc6QmLXDv9b85P5b4yp4g@mail.gmail.com>
 <20201008140558.ovytcc34div3ih6m@bogus>
 <CAJZ5v0hYu_86LB=nycAEDQQ3TsMMpcBV=Ue4WuOqH3YhxAehVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hYu_86LB=nycAEDQQ3TsMMpcBV=Ue4WuOqH3YhxAehVQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 08 Oct 2020 at 17:18:25 (+0200), Rafael J. Wysocki wrote:
> On Thu, Oct 8, 2020 at 4:06 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Oct 07, 2020 at 04:34:44PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Sep 24, 2020 at 2:30 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > > >
> > > > This series is the result of the discussions ([1], [2]) around the
> > > > complications that the BL_SWITCHER poses when it comes to Frequency
> > > > Invariance (FI) and it aims to restart the discussions.
> > > >
> > > > To properly scale its per-entity load-tracking signals, the task
> > > > scheduler needs to be given a frequency scale factor, i.e. some image of
> > > > the current frequency the CPU is running at, relative to its maximum
> > > > frequency.
> > > >
> > > > But (reiterating the message in the changelog of patch 2/2), big.LITTLE
> > > > switching complicates the setting of a correct cpufreq-based frequency
> > > > invariance scale factor due to (as observed in
> > > > drivers/cpufreq/vexpress-spc-cpufreq.c):
> > > >  - Incorrect current and maximum frequencies as a result of the
> > > >    exposure of a virtual frequency table to the cpufreq core,
> > > >  - Missed updates as a result of asynchronous frequency adjustments
> > > >    caused by frequency changes in other CPU pairs.
> > > > More information on this feature can be found at [3].
> > > >
> > > > Given that its functionality is atypical in regards to FI and that this
> > > > is an old technology, patch 2/2 disable FI for when big.LITTLE switching
> > > > is configured in to prevent incorrect scale setting.
> > > >
> > > > For this purpose patch 1/2 changes the way arch_set_freq_scale() is
> > > > defined in architecture code which brings it in line with the logic of
> > > > other architectural function definitions while allowing for less invasive
> > > > filtering of FI support.
> > > >
> > > > In the discussions at [2], three possible solutions were suggested:
> > > >  - (1) conditioning FI by !CONFIG_BL_SWITCHER
> > > >  - (2) leave as is with note in driver specifying this FI broken
> > > >    functionality
> > > >  - (3) removing full BL_SWITCHER support
> > > >
> > > > This series restructures the solution at (1). The reason for it is that
> > > > the new patch limits the ifdef filtering to the arm topology include file,
> > > > a location where frequency invariance functions are defined. Therefore,
> > > > this seems more appropriate given that the b.L switcher is an arm
> > > > technology and that the new FI filtering location seems more natural for
> > > > conditioned FI disabling.
> > > >
> > > > Solutions (2) and (3) were not implemented given that there might be some
> > > > remaining users of this technology (Samsung Chromebook 2 - Samsung Exynos
> > > > 5 Octa 5420, Samsung Exynos 5 Octa 5800) and therefore leaving this
> > > > broken (2) seems equally bad to removing support for it (3).
> > > >
> > > > [1] https://lore.kernel.org/lkml/20200701090751.7543-5-ionela.voinescu@arm.com/
> > > > [2] https://lore.kernel.org/lkml/20200722093732.14297-4-ionela.voinescu@arm.com/
> > > > [3] https://lwn.net/Articles/481055/
> > >
> > > I can take this set with the ACKs from Viresh if that's fine by
> > > everyone.  Catalin?  Sudeep?
> >
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com> (BL_SWITCHER and topology parts)
> 
> OK, the series has been applied as 5.10 material, thanks!

Many thanks, guys!
Ionela.

