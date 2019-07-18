Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1616CEF3
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 15:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfGRNgk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 09:36:40 -0400
Received: from foss.arm.com ([217.140.110.172]:58504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfGRNgk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Jul 2019 09:36:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C67D344;
        Thu, 18 Jul 2019 06:36:39 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 754163F71F;
        Thu, 18 Jul 2019 06:36:36 -0700 (PDT)
Date:   Thu, 18 Jul 2019 14:36:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/18] drivers: firmware: psci: Add hierarchical domain
 idle states converter
Message-ID: <20190718133630.GB27222@e121166-lin.cambridge.arm.com>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-11-ulf.hansson@linaro.org>
 <20190709153138.GA22871@e121166-lin.cambridge.arm.com>
 <CAPDyKFpd5Jip+ZDENXVC115JJgCReJa4G92aKa45Lna6BeV5-g@mail.gmail.com>
 <20190716145121.GA32490@e121166-lin.cambridge.arm.com>
 <CAPDyKFoBm9vWUcX5pjMMseYs7SAYr9v0Uc48YqsgaG9omA2MRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoBm9vWUcX5pjMMseYs7SAYr9v0Uc48YqsgaG9omA2MRQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 18, 2019 at 01:43:44PM +0200, Ulf Hansson wrote:

[...]

> > > Anyway, as a suggestion to address your concern, how about this:
> > >
> > > 1. Move some things out to a PSCI cpuidle driver. We need to decide
> > > more exactly on what to move and find the right level for the
> > > interfaces.
> >
> > I will do it and post patches asap.
> 
> Okay, so I will wait for you to converting the cpuidle-arm driver into
> a cpuidle-psci driver (and all the changes that comes with it) and
> then base my re-base my series on top.
> 
> Then, would you mind sharing (even in an early phase) a
> branch/git-tree so I can start re-basing my series on top?

Sure, I should be able to post at -rc1 and will publish a branch
here [1].

> > > 2. Don't attach the CPU to the PM domain topology in case the PSCI PC
> > > mode is used. I think this makes it easier, at least as a first step,
> > > to understand when runtime PM needs to be used/enabled.
> >
> > In the PSCI CPUidle driver we can have two distinct struct
> > cpuidle_state->enter functions for PC and OSI, no overhead
> > for PC, runtime PM for OSI, decoupling done.
> 
> Good idea!
> 
> >
> > We can choose one or the other depending on whether:
> >
> > OSI iff:
> > - OSI is available
> > - hierarchical idle states are present in DT
> >
> > otherwise PC.
> >
> > That's what this patch does but we will do it in a unified file.
> 
> Sure, it makes sense.
> 
> >
> > > 3. Would it help if I volunteer to help you guys as a maintainer for
> > > PSCI. At least for the part of the new code that becomes introduced?
> >
> > We will do as described above if that makes sense.
> 
> Yep, I am okay with your suggestions, assuming I have understood them correctly.
> 
> BTW, have you considered to host a git tree for PSCI so we can have
> changes pre-integrated and tested in Stephen Rothwell's linux-next
> tree?

I will ask Stephen to pull when needed a branch in the tree below[1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git/
