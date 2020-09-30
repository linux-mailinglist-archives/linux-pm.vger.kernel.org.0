Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC527E665
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 12:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgI3KTH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 06:19:07 -0400
Received: from foss.arm.com ([217.140.110.172]:33384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgI3KTD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Sep 2020 06:19:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4999FD6E;
        Wed, 30 Sep 2020 03:19:02 -0700 (PDT)
Received: from bogus (unknown [10.57.47.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61F983F70D;
        Wed, 30 Sep 2020 03:19:00 -0700 (PDT)
Date:   Wed, 30 Sep 2020 11:18:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Update section for cpuidle-psci
Message-ID: <20200930101858.GB30186@bogus>
References: <20200814123716.61936-1-ulf.hansson@linaro.org>
 <CAJZ5v0g7EZVeF6GL8yqfALq-wgp+9igO3JkzR-as7Ng9ycbFJQ@mail.gmail.com>
 <20200923081106.GA30942@e121166-lin.cambridge.arm.com>
 <CAPDyKFrPRjgqzN2TXCh8A8P3H8g7FFQKRo8WZeLuCnMbMsT3bA@mail.gmail.com>
 <20200930091254.GA16862@e121166-lin.cambridge.arm.com>
 <CAPDyKFq6gaht-x-iKD0wvoD-p7o_2GdR-ac3SpH6c7soU2AvnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq6gaht-x-iKD0wvoD-p7o_2GdR-ac3SpH6c7soU2AvnA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 30, 2020 at 11:46:19AM +0200, Ulf Hansson wrote:
> On Wed, 30 Sep 2020 at 11:13, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Wed, Sep 23, 2020 at 03:44:53PM +0200, Ulf Hansson wrote:
> > > On Wed, 23 Sep 2020 at 10:11, Lorenzo Pieralisi
> > > <lorenzo.pieralisi@arm.com> wrote:
> > > >
> > > > On Mon, Sep 21, 2020 at 05:49:52PM +0200, Rafael J. Wysocki wrote:
> > > > > On Fri, Aug 14, 2020 at 2:37 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > > > > > Extend the file pattern to also include cpuidle-psci.h and
> > > > > > cpuidle-psci-domain.c. Moreover, add myself as a co-maintainer,
> > > > > > particularly to help with the support for PM domains.
> > > > > >
> > > > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > > > Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > >
> > > > > Any objections from the original maintainers?
> > > >
> > > > The PSCI driver providing support for platform coordinated idle states
> > > > (that this patch is targeting AFAICS) does not require more maintainers,
> > > > that support is complete and Sudeep and I will take care of refactoring
> > > > and fixes.
> > > >
> > > > If the OSI bits in it require a specific maintainer I would prefer those
> > > > bits to be moved into a specific file and maintainership added
> > > > _explicitly_ for that file only.
> > >
> > > My main concern is that the OSI support (and some related changes for
> > > genpd) is still being worked upon. The corresponding code deserves to
> > > be looked after by someone. I offer my help with this.
> >
> > All OSI changes can go into cpuidle-psci-domain.c, you can add a
> > maintainer entry for that.
>
> Alright. Most of the things are already in there, but I will try to
> move the rest as well then.
>
> >
> > > I guess we can split up the code as you suggest, but perhaps another
> > > way would be to explicitly state my part of the responsibility in
> > > MAINTAINERS. Along the lines of this:
> > >
> > > M:     Ulf Hansson <ulf.hansson@linaro.org> # OSI support / PM domains
> > >
> > > Would that be okay to you?
> >
> > No because there should be no need, as I have already said. If you need
> > to change cpuidle-psci.c send patches please and we will review them.
>
> I sent a small series "Enable s2idle when using PSCI OSI [1]" a month
> ago, but haven't received any feedback. I guess moving all OSI parts
> to cpuidle-psci-domain.c would help, as we wouldn't need to bother you
> with these OSI specific things then.
>

As I mentioned in one of the thread, I was confused with multiple series
at the same time and I believe there were S2I/S2R related patches from
you and one more person. I was confused and about to go on vacation.
I will take a look at it.

--
Regards,
Sudeep
