Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8993B337
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 12:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbfFJKcf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 06:32:35 -0400
Received: from foss.arm.com ([217.140.110.172]:40174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389354AbfFJKce (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jun 2019 06:32:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E092D346;
        Mon, 10 Jun 2019 03:32:33 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F383E3F557;
        Mon, 10 Jun 2019 03:34:12 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:32:25 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
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
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/18] ARM/ARM64: Support hierarchical CPU arrangement
 for PSCI
Message-ID: <20190610103225.GA26602@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <CAJZ5v0gbK3AFCVC1b9LyXeMOM8fKR1=ECXZwaeSYRSqcK0UgYA@mail.gmail.com>
 <CAPDyKFpU3u248Gi+FnrVdY-EWXJQuu14uNV9d3Xs0W-K-EMEhg@mail.gmail.com>
 <20190607154210.GJ15577@e107155-lin>
 <20190607193407.GB24059@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607193407.GB24059@builder>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 07, 2019 at 12:34:07PM -0700, Bjorn Andersson wrote:
> On Fri 07 Jun 08:42 PDT 2019, Sudeep Holla wrote:
>
> > On Tue, May 14, 2019 at 10:58:04AM +0200, Ulf Hansson wrote:
> > > On Tue, 14 May 2019 at 10:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Mon, May 13, 2019 at 9:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > This series enables support for hierarchical CPU arrangement, managed by PSCI
> > > > > for ARM/ARM64. It's based on using the generic PM domain (genpd), which
> > > > > recently was extended to manage devices belonging to CPUs.
> > > >
> > > > ACK for the patches touching cpuidle in this series (from the
> > > > framework perspective), but I'm assuming it to be taken care of by
> > > > ARM/ARM64 maintainers.
> > >
> > > Thanks for the ack! Yes, this is for PSCI/ARM maintainers.
> > >
> > > BTW, apologize for sending this in the merge window, but wanted to
> > > take the opportunity for people to have a look before OSPM Pisa next
> > > week.
> > >
> >
> > I will start looking at this series. But I would request PSCI/other
> > maintainers to wait until we see some comparison data before we merge.
>
> What comparison are you asking for here? Do you want to see the
> improvement this series gives or are you hoping to compare it with some
> other mechanism?
>

OK, I have mentioned this many times already, let me repeat it again.
This series adds an alternative to the existing PC mode of CPU idle
management. And it's clear that the main reason for the same is the
improvement OSI mode offers vs the PC mode. I am asking the comparison
for the same. And yes we need to compare apples with apples and not
oranges here.

> > If they are fine to merge w/o that, I am fine. As of now we have just
> > 1-2 platforms to test(that too not so simple to get started) and the
> > long term support for them are questionable.
>
> Why is the support for these platforms questionable? People are actively
> working on these platforms and the feature set constantly improving.
>

Qualcomm will never fix any firmware issues and we need to quirk
any bugs found. I would prefer the first platform to minimize those
as it would be reference. But I am sure QC won't care about firmware
on SDM845 anymore, so not an ideal fit.

We need to add support in TF-A to build complete reference story around
OSI mode.

> > Also with SDM845 supporting PC, we have excellent opportunity to
> > compare and conclude the results found.
>
> That's correct, ATF exists for SDM845. But with the standard choice of
> firmware you will get OSI and I don't know of a board out there where
> you can switch between them and do a apple to apple comparison.
>

One that's not PSCI compliant, system must boot in PC. If QC was any
serious about this, they would have attempted to fix them in firmware.
We have given this comment at-least 4 years back and if that's not
still in the current gen products, it says something. Sorry I don't
trust the firmware story from QC.

> Devices such as RB3 (96boards SDM845), Pixel3 and the Windows laptops
> are all OSI only.
>

Again not fully PSCI compliant.

>
> So landing this support is not a question of PC or OSI being the better
> choice, it's a question of do we want to be able to enter these lower
> power states - with the upstream kernel - on any past, present or future
> Qualcomm devices.
>

Nope, I disagree. Better they fix future products. This is a new feature
in the kernel with the claim that it's better and since last 2-3 years
no efforts are made to prove the claim. So I am not really worried
about running low power modes on their past/present devices, but more
worried about the precedence this might set with unproven claim and other
vendors moving to this without considering all the implications.

--
Regards,
Sudeep
