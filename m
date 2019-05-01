Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746EB10711
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfEAKmO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 06:42:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54725 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfEAKmO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:42:14 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 399cf859464cc529; Wed, 1 May 2019 12:42:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] PM / Domains: Improve support for CPUs in genpd
Date:   Wed, 01 May 2019 12:42:11 +0200
Message-ID: <1669333.3pGjfQS6y6@kreacher>
In-Reply-To: <CAJZ5v0iK03ajPVE2LdkJHKBQzeeS+dkkaYfvUuVYAcZKStU-EQ@mail.gmail.com>
References: <20190425090413.10700-1-ulf.hansson@linaro.org> <CAPDyKFq3QTjX5m9HoNYFTd-e-p_BXsqPH8s+P_yQ5YEJvHBoag@mail.gmail.com> <CAJZ5v0iK03ajPVE2LdkJHKBQzeeS+dkkaYfvUuVYAcZKStU-EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, April 25, 2019 12:32:24 PM CEST Rafael J. Wysocki wrote:
> On Thu, Apr 25, 2019 at 12:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 25 Apr 2019 at 12:14, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Apr 25, 2019 at 12:11 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Thu, 25 Apr 2019 at 11:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Thu, Apr 25, 2019 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > > > > > Recently genpd was extended to cope with devices belonging to CPUs. However,
> > > > > > attaching CPU devices via genpd_dev_pm_attach_by_id|name() doesn't work,
> > > > > > because of the virtual device that genpd allocates in this path.
> > > > > >
> > > > > > In this series, this limitation is addressed, together with a few other related
> > > > > > fixes/cleanups.
> > > > > >
> > > > > > Ulf Hansson (4):
> > > > > >   PM / Domains: Use the base device for
> > > > > >     driver_deferred_probe_check_state()
> > > > > >   PM / Domains: Drop unused in-parameter to some genpd functions
> > > > > >   PM / Domains: Search for the CPU device outside the genpd lock
> > > > > >   PM / Domains: Allow to attach a CPU via
> > > > > >     genpd_dev_pm_attach_by_id|name()
> > > > > >
> > > > > >  drivers/base/power/domain.c | 73 ++++++++++++++++++-------------------
> > > > > >  include/linux/pm_domain.h   |  1 +
> > > > > >  2 files changed, 36 insertions(+), 38 deletions(-)
> > > > >
> > > > > Are there any dependencies between this and the series you've recently posted?
> > > >
> > > > Yep. I should have stated that, sorry. This should be applied on top.
> > >
> > > On top of which series?
> >
> > [PATCH 0/3] PM / Domains: Improve support for multi PM domains
> >
> > and
> >
> > [PATCH v13 0/4] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)
> 
> OK, thanks!
> 

This series has been applied, thanks!




