Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B12752F9
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 10:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIWILO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 04:11:14 -0400
Received: from foss.arm.com ([217.140.110.172]:39322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWILO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Sep 2020 04:11:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9B85113E;
        Wed, 23 Sep 2020 01:11:13 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18C583F718;
        Wed, 23 Sep 2020 01:11:11 -0700 (PDT)
Date:   Wed, 23 Sep 2020 09:11:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Update section for cpuidle-psci
Message-ID: <20200923081106.GA30942@e121166-lin.cambridge.arm.com>
References: <20200814123716.61936-1-ulf.hansson@linaro.org>
 <CAJZ5v0g7EZVeF6GL8yqfALq-wgp+9igO3JkzR-as7Ng9ycbFJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g7EZVeF6GL8yqfALq-wgp+9igO3JkzR-as7Ng9ycbFJQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 21, 2020 at 05:49:52PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 14, 2020 at 2:37 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Extend the file pattern to also include cpuidle-psci.h and
> > cpuidle-psci-domain.c. Moreover, add myself as a co-maintainer,
> > particularly to help with the support for PM domains.
> >
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Any objections from the original maintainers?

The PSCI driver providing support for platform coordinated idle states
(that this patch is targeting AFAICS) does not require more maintainers,
that support is complete and Sudeep and I will take care of refactoring
and fixes.

If the OSI bits in it require a specific maintainer I would prefer those
bits to be moved into a specific file and maintainership added
_explicitly_ for that file only.

Thanks,
Lorenzo

> >  MAINTAINERS | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f9ae8ea54e27..66821197175e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4556,10 +4556,11 @@ F:      drivers/cpuidle/cpuidle-exynos.c
> >  CPUIDLE DRIVER - ARM PSCI
> >  M:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >  M:     Sudeep Holla <sudeep.holla@arm.com>
> > +M:     Ulf Hansson <ulf.hansson@linaro.org>
> >  L:     linux-pm@vger.kernel.org
> >  L:     linux-arm-kernel@lists.infradead.org
> >  S:     Supported
> > -F:     drivers/cpuidle/cpuidle-psci.c
> > +F:     drivers/cpuidle/cpuidle-psci*
> >
> >  CRAMFS FILESYSTEM
> >  M:     Nicolas Pitre <nico@fluxnic.net>
> > --
> > 2.25.1
> >
