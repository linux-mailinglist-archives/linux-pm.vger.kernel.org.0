Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E993912E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 17:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfFGPmR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 11:42:17 -0400
Received: from foss.arm.com ([217.140.110.172]:43020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730460AbfFGPmQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jun 2019 11:42:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 813E6337;
        Fri,  7 Jun 2019 08:42:15 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B64CD3F718;
        Fri,  7 Jun 2019 08:42:12 -0700 (PDT)
Date:   Fri, 7 Jun 2019 16:42:10 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/18] ARM/ARM64: Support hierarchical CPU arrangement
 for PSCI
Message-ID: <20190607154210.GJ15577@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <CAJZ5v0gbK3AFCVC1b9LyXeMOM8fKR1=ECXZwaeSYRSqcK0UgYA@mail.gmail.com>
 <CAPDyKFpU3u248Gi+FnrVdY-EWXJQuu14uNV9d3Xs0W-K-EMEhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpU3u248Gi+FnrVdY-EWXJQuu14uNV9d3Xs0W-K-EMEhg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 14, 2019 at 10:58:04AM +0200, Ulf Hansson wrote:
> On Tue, 14 May 2019 at 10:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, May 13, 2019 at 9:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > This series enables support for hierarchical CPU arrangement, managed by PSCI
> > > for ARM/ARM64. It's based on using the generic PM domain (genpd), which
> > > recently was extended to manage devices belonging to CPUs.
> >
> > ACK for the patches touching cpuidle in this series (from the
> > framework perspective), but I'm assuming it to be taken care of by
> > ARM/ARM64 maintainers.
>
> Thanks for the ack! Yes, this is for PSCI/ARM maintainers.
>
> BTW, apologize for sending this in the merge window, but wanted to
> take the opportunity for people to have a look before OSPM Pisa next
> week.
>

I will start looking at this series. But I would request PSCI/other
maintainers to wait until we see some comparison data before we merge.
If they are fine to merge w/o that, I am fine. As of now we have just
1-2 platforms to test(that too not so simple to get started) and the
long term support for them are questionable. Also with SDM845 supporting
PC, we have excellent opportunity to compare and conclude the results
found.

--
Regards,
Sudeep
