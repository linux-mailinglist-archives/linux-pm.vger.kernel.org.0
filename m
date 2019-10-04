Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74E2CB626
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 10:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfJDIaD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 04:30:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43916 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDIaD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 04:30:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id t84so5044031oih.10;
        Fri, 04 Oct 2019 01:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0lh1A+ZoVRyrerJZUky2BuZ3TgVLKznaFWvWQ8x4rk=;
        b=Tk3Kdt4R2c6rCQzLA5fnTvOFa0w8M2GaSWxgk4NikNuQomCdI1Qz0FtBIkHBfGtZ14
         3m4CvFGC0HEVQdazaVcyRGoCMQ7RcBhRcVfBNOcgpCBWP3vKAGHdnNYR/MamZQtzMZOH
         DDcZgKEdiM/WN6jbH1Y7a70FJhxHV1QB2aoaFtAmYHC+Nh1AsOwzg/H1rUl5diAITuzv
         cuVWlb4aU5tMVU1hQhZvbD+FDuHtTzht+gmTjIrF53rYy1awH1Pg+7RY9WgrqbY8SK/T
         szXCnQbeYdVhIYn8J2hrFpbhJXFUFGH3k6DPRGboeWDRan0oINCIozLGokuqB9qiono7
         qnQQ==
X-Gm-Message-State: APjAAAW+KT1Csd3xwY9GpNTxufvcsDuDy3OxAvFT4pdS+Bu0IqFA9yvL
        vXWr+8pqwDm7ts3HR2S9Zxa6Tj0RaKjyPhL+DmM=
X-Google-Smtp-Source: APXvYqyuckAxWhmAzq3x/bMhAToNURXcUGJImkqB+8HiT3GnE1LomAaWEgdqTF4QOFmtv2kSMA2wQPPJrAdm0mvj95w=
X-Received: by 2002:aca:4890:: with SMTP id v138mr6300646oia.57.1570177802460;
 Fri, 04 Oct 2019 01:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191002122926.385-1-ggherdovich@suse.cz> <20191002122926.385-3-ggherdovich@suse.cz>
 <13106850.QMtCbivBLn@kreacher> <5d6d601d2647644238fc51621407061e1c29320d.camel@linux.intel.com>
 <1570177786.30086.1.camel@suse.cz>
In-Reply-To: <1570177786.30086.1.camel@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Oct 2019 10:29:51 +0200
Message-ID: <CAJZ5v0jK1kMjQ3gu8KhQmp2Paq9Rb74NPjMQ1HsVRCD3Fct5TQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: intel_pstate: Conditional frequency
 invariant accounting
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 4, 2019 at 10:24 AM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> On Thu, 2019-10-03 at 20:31 -0700, Srinivas Pandruvada wrote:
> > On Thu, 2019-10-03 at 20:05 +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, October 2, 2019 2:29:26 PM CEST Giovanni Gherdovich
> > > wrote:
> > > > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > >
> > > > intel_pstate has two operating modes: active and passive. In "active"
> > > > mode, the in-built scaling governor is used and in "passive" mode, the
> > > > driver can be used with any governor like "schedutil". In "active" mode
> > > > the utilization values from schedutil is not used and there is a
> > > > requirement from high performance computing use cases, not to readas
> > > > well any APERF/MPERF MSRs.
> > >
> > > Well, this isn't quite convincing.
> > >
> > > In particular, I don't see why the "don't read APERF/MPERF MSRs" argument
> > > applies *only* to intel_pstate in the "active" mode.  What about
> > > intel_pstate in the "passive" mode combined with the "performance"
> > > governor?  Or any other governor different from "schedutil" for that
> > > matter?
> > >
> > > And what about acpi_cpufreq combined with any governor different from
> > > "schedutil"?
> > >
> > > Scale invariance is not really needed in all of those cases right now
> > > AFAICS, or is it?
> >
> > Correct. This is just part of the patch to disable in active mode
> > (particularly in HWP and performance mode).
> >
> > But this patch is 2 years old. The folks who wanted this, disable
> > intel-pstate and use userspace governor with acpi-cpufreq. So may be
> > better to address those cases too.
>
> I disagree with "scale invariance is needed only by the schedutil governor";
> the two other users are the CPU's estimated utilization in the wakeup path,
> via cpu_util_without(), as well as the load-balance path, via cpu_util() which
> is used by update_sg_lb_stats().

OK, so there are reasons to run the scale invariance code which are
not related to the cpufreq governor in use.

I wonder then why those reasons are not relevant for intel_pstate in
the "active" mode.

> Also remember that scale invariance is applied to both PELT signals util_avg
> and load_avg; schedutil uses the former but not the latter.
>
> I understand Srinivas patch to disable MSR accesses during the tick as a
> band-aid solution to address a specific use case he cares about, but I don't
> think that extending this approach to any non-schedutil governor is a good
> idea -- you'd be killing load balancing in the process.

But that is also the case for intel_pstate in the "active" mode, isn't it?
