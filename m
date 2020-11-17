Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE402B6A35
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 17:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgKQQar (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 11:30:47 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:44778 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgKQQap (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 11:30:45 -0500
Received: by mail-oo1-f67.google.com with SMTP id i13so4881860oou.11;
        Tue, 17 Nov 2020 08:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNtDOoMlRwud0/aGwxo+vKx2Davbaj7vGDzBOZreU04=;
        b=pkxWK3GALrCQRiwbA8u+FRbN3RoUmvcjZHSkSz++XFYOeByWdzkBE5dfFl5jyv6tIP
         ty1yFnGAy7pu6WPi5Em7XHfBCe2tvyxCP4VwNIfz3a3gaUJFq9CYd2ZA37fH6Rtmwe0N
         rZCyzuBJ7+CWZxbfU+SgNPabEDXuMigSasCI/Vbyf5NprI43GyRVIacpBKVzkRfYZWUu
         zt6Or7DDO5+Fez7Rw/rK5h0MI9EIsdQWGhOSxVfIkU11S5ubCdhNC99HBSzmugXjigfl
         W4/WxT/LYMtXy4R1ujQoiKgZ9gfy3Q6zW5k/Y046ZHe0U+WkG98ZDcJHSNWHvgrcOfju
         47fw==
X-Gm-Message-State: AOAM532xupq0iXbKVQ1hSK7tUdSzGqhunk87dn4ii18hCZp/5iaW1YBm
        K+gGqjbLII0bEfkHKrloSxc/BxamCWURheD5H0s=
X-Google-Smtp-Source: ABdhPJxY1duGTM+9Nf3pI9bBjViWorCvJZwv8NU776jpL1TprGwFKe+UO1Y7QovxEe/YEr80tZ7kD/s8LGCQGiQzkds=
X-Received: by 2002:a4a:e80b:: with SMTP id b11mr3587232oob.1.1605630644535;
 Tue, 17 Nov 2020 08:30:44 -0800 (PST)
MIME-Version: 1.0
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <CAJZ5v0hucue4fwGgHF5-jXRn8kSt3hORyQ7Q4-azmZ8UBijUkw@mail.gmail.com> <20201117153241.GA730@arm.com>
In-Reply-To: <20201117153241.GA730@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Nov 2020 17:30:33 +0100
Message-ID: <CAJZ5v0hPdEB1wMxT90Tp9eMcseMxdZGbadMaCeYOYf1LqVXq0A@mail.gmail.com>
Subject: Re: [PATCH 0/8] cppc_cpufreq: fix, clarify and improve support
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 17, 2020 at 4:32 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi Rafael,
>
> On Tuesday 17 Nov 2020 at 15:59:24 (+0100), Rafael J. Wysocki wrote:
> > On Thu, Nov 5, 2020 at 1:56 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > >
> > > Hi guys,
> > >
> > > I found myself staring a bit too much at this driver in the past weeks
> > > and that's likely the cause for me coming up with this series of 8
> > > patches that cleans up, clarifies and reworks parts of it, as follows:
> > >
> > >  - patches 1-3/8: trivial clean-up and renaming with the purpose to
> > >                   improve readability
> > >  - patch 4/8: replace previous per-cpu data structures with lists of
> > >               domains and CPUs to get more efficient storage for driver
> > >               data and fix previous issues in case of CPU hotplugging,
> > >               as discussed at [1].
> > >  - patches 5-6/8: a few fixes and clarifications: mostly making sure
> > >                   the behavior described in the comments and debug
> > >                   messages matches the code and there is clear
> > >                   indication of what is supported and how.
> > >  - patch 7/8: use the existing freqdomains_cpus attribute to inform
> > >               the user on frequency domains.
> > >  - patch 8/8: acpi: replace ALL coordination with NONE coordination
> > >                     when errors are find parsing the _PSD domains
> > >               (as described in the comments in the code).
> > >
> > > Hopefully you'll find this useful for ease of maintenance and ease of
> > > future development of the driver.
> > >
> > > This functionality was tested on a Juno platform with modified _PSD
> > > tables to test the functionality for all currently supported
> > > coordination types: ANY, HW, NONE.
> > >
> > > The current code is based on v5.10-rc2.
> > >
> > > Thanks,
> > > Ionela.
> > >
> > > [1] https://lore.kernel.org/linux-pm/20200922162540.GB796@arm.com/
> > >
> > > Ionela Voinescu (8):
> > >   cppc_cpufreq: fix misspelling, code style and readability issues
> > >   cppc_cpufreq: clean up cpu, cpu_num and cpunum variable use
> > >   cppc_cpufreq: simplify use of performance capabilities
> > >   cppc_cpufreq: replace per-cpu structures with lists
> > >   cppc_cpufreq: use policy->cpu as driver of frequency setting
> > >   cppc_cpufreq: clarify support for coordination types
> > >   cppc_cpufreq: expose information on frequency domains
> > >   acpi: fix NONE coordination for domain mapping failure
> > >
> > >  .../ABI/testing/sysfs-devices-system-cpu      |   3 +-
> > >  drivers/acpi/cppc_acpi.c                      | 126 +++---
> > >  drivers/acpi/processor_perflib.c              |   2 +-
> > >  drivers/cpufreq/cppc_cpufreq.c                | 358 +++++++++++-------
> > >  include/acpi/cppc_acpi.h                      |  14 +-
> > >  5 files changed, 277 insertions(+), 226 deletions(-)
> > >
> > > --
> >
> > All patches applied as 5.11 material (with a minor subject edit in the
> > last patch), thanks!
> >
>
> Patch 4/8 was not acked. I was about to push a new version in which I
> fix the scenario that Jeremy mentioned.

Well, it wasn't clear to me what you wanted to do about it.

> Would you like me to push that
> as a separate patch on top of this series,

Yes, please.
