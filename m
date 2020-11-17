Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E611E2B6E03
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 20:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgKQTEp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 14:04:45 -0500
Received: from foss.arm.com ([217.140.110.172]:35138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKQTEo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 14:04:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E95101E;
        Tue, 17 Nov 2020 11:04:44 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 976FC3F718;
        Tue, 17 Nov 2020 11:04:43 -0800 (PST)
Date:   Tue, 17 Nov 2020 19:04:42 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] cppc_cpufreq: fix, clarify and improve support
Message-ID: <20201117190442.GA25835@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <CAJZ5v0hucue4fwGgHF5-jXRn8kSt3hORyQ7Q4-azmZ8UBijUkw@mail.gmail.com>
 <20201117153241.GA730@arm.com>
 <CAJZ5v0hPdEB1wMxT90Tp9eMcseMxdZGbadMaCeYOYf1LqVXq0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hPdEB1wMxT90Tp9eMcseMxdZGbadMaCeYOYf1LqVXq0A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 17 Nov 2020 at 17:30:33 (+0100), Rafael J. Wysocki wrote:
[..]
> > > > Ionela Voinescu (8):
> > > >   cppc_cpufreq: fix misspelling, code style and readability issues
> > > >   cppc_cpufreq: clean up cpu, cpu_num and cpunum variable use
> > > >   cppc_cpufreq: simplify use of performance capabilities
> > > >   cppc_cpufreq: replace per-cpu structures with lists
> > > >   cppc_cpufreq: use policy->cpu as driver of frequency setting
> > > >   cppc_cpufreq: clarify support for coordination types
> > > >   cppc_cpufreq: expose information on frequency domains
> > > >   acpi: fix NONE coordination for domain mapping failure
> > > >
> > > >  .../ABI/testing/sysfs-devices-system-cpu      |   3 +-
> > > >  drivers/acpi/cppc_acpi.c                      | 126 +++---
> > > >  drivers/acpi/processor_perflib.c              |   2 +-
> > > >  drivers/cpufreq/cppc_cpufreq.c                | 358 +++++++++++-------
> > > >  include/acpi/cppc_acpi.h                      |  14 +-
> > > >  5 files changed, 277 insertions(+), 226 deletions(-)
> > > >
> > > > --
> > >
> > > All patches applied as 5.11 material (with a minor subject edit in the
> > > last patch), thanks!
> > >
> >
> > Patch 4/8 was not acked. I was about to push a new version in which I
> > fix the scenario that Jeremy mentioned.
> 
> Well, it wasn't clear to me what you wanted to do about it.
> 

Sorry about the confusion.

> > Would you like me to push that
> > as a separate patch on top of this series,
> 
> Yes, please.

Sent at:
https://lore.kernel.org/linux-pm/20201117184920.17036-1-ionela.voinescu@arm.com/

Thank you,
Ionela.
