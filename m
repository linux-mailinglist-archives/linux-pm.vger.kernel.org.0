Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD902B68C3
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 16:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgKQPco (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 10:32:44 -0500
Received: from foss.arm.com ([217.140.110.172]:60010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgKQPco (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 10:32:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AC8AD6E;
        Tue, 17 Nov 2020 07:32:43 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 055833F718;
        Tue, 17 Nov 2020 07:32:42 -0800 (PST)
Date:   Tue, 17 Nov 2020 15:32:41 +0000
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
Message-ID: <20201117153241.GA730@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <CAJZ5v0hucue4fwGgHF5-jXRn8kSt3hORyQ7Q4-azmZ8UBijUkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hucue4fwGgHF5-jXRn8kSt3hORyQ7Q4-azmZ8UBijUkw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Tuesday 17 Nov 2020 at 15:59:24 (+0100), Rafael J. Wysocki wrote:
> On Thu, Nov 5, 2020 at 1:56 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >
> > Hi guys,
> >
> > I found myself staring a bit too much at this driver in the past weeks
> > and that's likely the cause for me coming up with this series of 8
> > patches that cleans up, clarifies and reworks parts of it, as follows:
> >
> >  - patches 1-3/8: trivial clean-up and renaming with the purpose to
> >                   improve readability
> >  - patch 4/8: replace previous per-cpu data structures with lists of
> >               domains and CPUs to get more efficient storage for driver
> >               data and fix previous issues in case of CPU hotplugging,
> >               as discussed at [1].
> >  - patches 5-6/8: a few fixes and clarifications: mostly making sure
> >                   the behavior described in the comments and debug
> >                   messages matches the code and there is clear
> >                   indication of what is supported and how.
> >  - patch 7/8: use the existing freqdomains_cpus attribute to inform
> >               the user on frequency domains.
> >  - patch 8/8: acpi: replace ALL coordination with NONE coordination
> >                     when errors are find parsing the _PSD domains
> >               (as described in the comments in the code).
> >
> > Hopefully you'll find this useful for ease of maintenance and ease of
> > future development of the driver.
> >
> > This functionality was tested on a Juno platform with modified _PSD
> > tables to test the functionality for all currently supported
> > coordination types: ANY, HW, NONE.
> >
> > The current code is based on v5.10-rc2.
> >
> > Thanks,
> > Ionela.
> >
> > [1] https://lore.kernel.org/linux-pm/20200922162540.GB796@arm.com/
> >
> > Ionela Voinescu (8):
> >   cppc_cpufreq: fix misspelling, code style and readability issues
> >   cppc_cpufreq: clean up cpu, cpu_num and cpunum variable use
> >   cppc_cpufreq: simplify use of performance capabilities
> >   cppc_cpufreq: replace per-cpu structures with lists
> >   cppc_cpufreq: use policy->cpu as driver of frequency setting
> >   cppc_cpufreq: clarify support for coordination types
> >   cppc_cpufreq: expose information on frequency domains
> >   acpi: fix NONE coordination for domain mapping failure
> >
> >  .../ABI/testing/sysfs-devices-system-cpu      |   3 +-
> >  drivers/acpi/cppc_acpi.c                      | 126 +++---
> >  drivers/acpi/processor_perflib.c              |   2 +-
> >  drivers/cpufreq/cppc_cpufreq.c                | 358 +++++++++++-------
> >  include/acpi/cppc_acpi.h                      |  14 +-
> >  5 files changed, 277 insertions(+), 226 deletions(-)
> >
> > --
> 
> All patches applied as 5.11 material (with a minor subject edit in the
> last patch), thanks!
> 

Patch 4/8 was not acked. I was about to push a new version in which I
fix the scenario that Jeremy mentioned. Would you like me to push that
as a separate patch on top of this series, or should I push a new
version of this series?

All the other patches will be the same.

> In the future, though, please CC all/any ACPI-related changes to the
> linux-acpi mailing list.

Will do!

Thank you,
Ionela.
