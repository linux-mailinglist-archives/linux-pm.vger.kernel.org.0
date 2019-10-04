Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE2CB63F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 10:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfJDIeJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 04:34:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37537 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfJDIeJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 04:34:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id k32so4651925otc.4;
        Fri, 04 Oct 2019 01:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ld1X7lbISkCrGFf+99YQWnlVcdBMNf7XxUB1bfdwTh0=;
        b=saz7H5ZziAdFQkJCa6xbnhPbE3ktONZ7Plf7S1nOvkCukHuKamTryNl9Ccmm73M4xQ
         6zL1yJQJeQHEKZefSPwpPyk0g1yXq/dFu55nbLxlcELDIRXHSQBpxV2EJiWhRex6EEYc
         Xbwx94l3mNmECMF2nXcwwHAwp16q4UZn0OzYOjlYqly/x0KSSMxb2HHtCYea5b4H4g0v
         FR97AuzNc2uXyAZqFHq3nLMZtncbg/l2bHn3XGkRScDIkiUD+/bIQiI/Jm1yoUdMFizx
         awjTI+Wk7kblvig3Ul4K8O4i6lzFqfnTVDPhjoRo8N8DKMOj/wF4qoNzqkHwl2f1moFR
         Ru2g==
X-Gm-Message-State: APjAAAWS5AvL8fMZTegsuvsbAnPBcUSoUSLLxJgmC9+LV2EKS9jlhzZx
        vkuVRR9GzZPSmutCuvCk3gqKmqB+SH2s9kxcEsc=
X-Google-Smtp-Source: APXvYqx8NklrAu+r2XhFr/T01+KnxBdUz77nlWB2/6gBhVtJ9QTxszp6uYmvoWNp3lsGyZvLOncbmBs6BQxJuN9ZMzY=
X-Received: by 2002:a9d:6a16:: with SMTP id g22mr9317222otn.118.1570178046805;
 Fri, 04 Oct 2019 01:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191002122926.385-1-ggherdovich@suse.cz> <20191002122926.385-3-ggherdovich@suse.cz>
 <13106850.QMtCbivBLn@kreacher> <5d6d601d2647644238fc51621407061e1c29320d.camel@linux.intel.com>
 <1570177786.30086.1.camel@suse.cz> <CAKfTPtDo_wpGvc+rzJaTYOZc2wVbzMojaSSq0pC_M4ySSaicBw@mail.gmail.com>
In-Reply-To: <CAKfTPtDo_wpGvc+rzJaTYOZc2wVbzMojaSSq0pC_M4ySSaicBw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Oct 2019 10:33:55 +0200
Message-ID: <CAJZ5v0gQAxzZeiz2xsBk6bpQFV3dpASa=ZSR3aW0veorbo_5Hw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: intel_pstate: Conditional frequency
 invariant accounting
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 4, 2019 at 10:28 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 4 Oct 2019 at 10:24, Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> >
> > On Thu, 2019-10-03 at 20:31 -0700, Srinivas Pandruvada wrote:
> > > On Thu, 2019-10-03 at 20:05 +0200, Rafael J. Wysocki wrote:
> > > > On Wednesday, October 2, 2019 2:29:26 PM CEST Giovanni Gherdovich
> > > > wrote:
> > > > > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > >
> > > > > intel_pstate has two operating modes: active and passive. In "active"
> > > > > mode, the in-built scaling governor is used and in "passive" mode, the
> > > > > driver can be used with any governor like "schedutil". In "active" mode
> > > > > the utilization values from schedutil is not used and there is a
> > > > > requirement from high performance computing use cases, not to readas
> > > > > well any APERF/MPERF MSRs.
> > > >
> > > > Well, this isn't quite convincing.
> > > >
> > > > In particular, I don't see why the "don't read APERF/MPERF MSRs" argument
> > > > applies *only* to intel_pstate in the "active" mode.  What about
> > > > intel_pstate in the "passive" mode combined with the "performance"
> > > > governor?  Or any other governor different from "schedutil" for that
> > > > matter?
> > > >
> > > > And what about acpi_cpufreq combined with any governor different from
> > > > "schedutil"?
> > > >
> > > > Scale invariance is not really needed in all of those cases right now
> > > > AFAICS, or is it?
> > >
> > > Correct. This is just part of the patch to disable in active mode
> > > (particularly in HWP and performance mode).
> > >
> > > But this patch is 2 years old. The folks who wanted this, disable
> > > intel-pstate and use userspace governor with acpi-cpufreq. So may be
> > > better to address those cases too.
> >
> > I disagree with "scale invariance is needed only by the schedutil governor";
> > the two other users are the CPU's estimated utilization in the wakeup path,
> > via cpu_util_without(), as well as the load-balance path, via cpu_util() which
> > is used by update_sg_lb_stats().
> >
> > Also remember that scale invariance is applied to both PELT signals util_avg
> > and load_avg; schedutil uses the former but not the latter.
>
> You have been quicker than me to reply. I was about to say the exact
> same things.
> scale invariance also helps the scheduler in task placement by
> stabilizing the metrics whatever the running frequency so a task will
> not be seen as a big task just because of a CPU running at lower
> frequency

So avoiding it just in one specific driver/governor configuration
would be inconsistent at best.

I guess that leaves us with the impact reduction option, realistically.
