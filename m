Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48BF2A8045
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 15:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgKEOCH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 09:02:07 -0500
Received: from foss.arm.com ([217.140.110.172]:33318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730929AbgKEOCH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 09:02:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C43714BF;
        Thu,  5 Nov 2020 06:02:06 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B70DD3F719;
        Thu,  5 Nov 2020 06:02:05 -0800 (PST)
Date:   Thu, 5 Nov 2020 14:02:02 +0000
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
Subject: Re: [PATCH 8/8] acpi: fix NONE coordination for domain mapping
 failure
Message-ID: <20201105140202.GA16751@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <20201105125524.4409-9-ionela.voinescu@arm.com>
 <CAJZ5v0hheK3WrpKFXDUF1A4D9wt8ro3KJ73wqNwxn9DJyrt6zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hheK3WrpKFXDUF1A4D9wt8ro3KJ73wqNwxn9DJyrt6zw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Thursday 05 Nov 2020 at 14:05:55 (+0100), Rafael J. Wysocki wrote:
> On Thu, Nov 5, 2020 at 1:57 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >
> > For errors parsing the _PSD domains, a separate domain is returned for
> > each CPU in the failed _PSD domain with no coordination (as per previous
> > comment). But contrary to the intention, the code was setting
> > CPUFREQ_SHARED_TYPE_ALL as coordination type.
> >
> > Change shared_type to CPUFREQ_SHARED_TYPE_NONE in case of errors parsing
> > the domain information. The function still return the error and the caller
> > is free to bail out the domain initialisation altogether in that case.
> >
> > Given that both functions return domains with a single CPU, this change
> > does not affect the functionality, but clarifies the intention.
> 
> Is this related to any other patches in the series?
> 

It does not depend on any of the other patches. I first noticed this in
acpi_get_psd_map() which is solely used by cppc_cpufreq.c, but looking
some more into it showed processor_perflib.c's
acpi_processor_preregister_performance() had the same inconsistency.

I can submit this separately, if that works better.

Thanks,
Ionela.

> > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/acpi/cppc_acpi.c         | 2 +-
> >  drivers/acpi/processor_perflib.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 75e36b909ae6..e1e46cc66eeb 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -477,7 +477,7 @@ int acpi_get_psd_map(unsigned int cpu, struct psd_data *domain)
> >         /* Assume no coordination on any error parsing domain info */
> >         cpumask_clear(domain->shared_cpu_map);
> >         cpumask_set_cpu(cpu, domain->shared_cpu_map);
> > -       domain->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> > +       domain->shared_type = CPUFREQ_SHARED_TYPE_NONE;
> >
> >         return -EFAULT;
> >  }
> > diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> > index 5909e8fa4013..5ce638537791 100644
> > --- a/drivers/acpi/processor_perflib.c
> > +++ b/drivers/acpi/processor_perflib.c
> > @@ -710,7 +710,7 @@ int acpi_processor_preregister_performance(
> >                 if (retval) {
> >                         cpumask_clear(pr->performance->shared_cpu_map);
> >                         cpumask_set_cpu(i, pr->performance->shared_cpu_map);
> > -                       pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> > +                       pr->performance->shared_type = CPUFREQ_SHARED_TYPE_NONE;
> >                 }
> >                 pr->performance = NULL; /* Will be set for real in register */
> >         }
> > --
> > 2.17.1
> >
