Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB7DE6039
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2019 03:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfJ0CVT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Oct 2019 22:21:19 -0400
Received: from foss.arm.com ([217.140.110.172]:53494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfJ0CVT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 26 Oct 2019 22:21:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A7DE1FB;
        Sat, 26 Oct 2019 19:21:18 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BA263F6C4;
        Sat, 26 Oct 2019 19:21:13 -0700 (PDT)
Date:   Sun, 27 Oct 2019 02:20:56 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] cpuidle: psci: Align psci_power_state count with idle
 state count
Message-ID: <20191027022056.GA18111@e107533-lin.cambridge.arm.com>
References: <20191010113937.15962-2-ulf.hansson@linaro.org>
 <20191024151834.17036-1-sudeep.holla@arm.com>
 <CAPDyKFqOTpwZ_o0Z6hAFDXf9wJM82a_P8fcKkZY-ZfW-d9LFVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqOTpwZ_o0Z6hAFDXf9wJM82a_P8fcKkZY-ZfW-d9LFVQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 24, 2019 at 06:10:09PM +0200, Ulf Hansson wrote:
> On Thu, 24 Oct 2019 at 17:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Instead of allocating 'n-1' states in psci_power_state to manage 'n'
> > idle states which include "ARM WFI" state, it would be simpler to have
> > 1:1 mapping between psci_power_state and cpuidle driver states.
> >
> > ARM WFI state(i.e. idx == 0) is handled specially in the generic macro
> > CPU_PM_CPU_IDLE_ENTER_PARAM and hence state[-1] is not possible. However
> > for sake of code readability, it is better to have 1:1 mapping and not
> > use [idx - 1] to access psci_power_state corresponding to driver cpuidle
> > state for idx.
> >
> > psci_power_state[0] is default initialised to 0 and is never accessed
> > while entering WFI state.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > Hi Ulf, Lorenzo,
> >
> > Just to avoid confusion, I thought I will just write this patch as I was
> > about to make reference to this in my review.
>
> As discussed with Lorenzo, I said I was going to adopt his review
> comments, which means I already have a patch for this locally.
>
> Nevermind this time, but I would appreciate if this kind of
> bikeshedding can been avoided future wise.
>

That's one of the reason I just wrote the patch as I felt describing it
it words was difficult compared to patch :). Sorry if you felt this was
bikeshedding.

--
Regards,
Sudeep
