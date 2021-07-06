Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74E83BDA2F
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhGFPbZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 11:31:25 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39903 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhGFPbY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 11:31:24 -0400
Received: by mail-oi1-f170.google.com with SMTP id b2so24979106oiy.6;
        Tue, 06 Jul 2021 08:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djILV2ZTCAiQFmxRl7gNQdjv1pea/PEm/sUtUv5E55c=;
        b=OTtZtRBkJhhvirZXUynUZxJDyiQlwjl5wxo0mtAO+4JO2g3k8/8CCd2anUnq1AKl/5
         mW7vVpVUrbv6gDiAjAOjtvVaSsUUBQYZ8fBxKYdIgcpfWLIZd9TG8+WZh5Iej53cBHyS
         T2Z6m3vetX06dGXrfkzl4/lLNNiKklf3UlPR1h9VftIOI8vtf5iJ52vqlDylW2y/rwcf
         UZwh5MRQsi1FyYBp9FEzovsQgYuv3vdEUQ5NEPLKZyJCjUYta4+VeXSUUOfdlav5MNjg
         KXBurk7lHf4Z3bxhoCkP+hswSFlewzdzgE0U5s1Rj60WQsEwjAOx2jfddrWw6gxxjNWP
         tedg==
X-Gm-Message-State: AOAM530d3V1pNWvYid3WTcNQPMMs6EJRba9CDdLcoNoq5aByl20Yemlz
        wIb3is6+QA9Qmafbkl50nCzO2ffA8WpSKC90TpE=
X-Google-Smtp-Source: ABdhPJyKKRg/nmhU3LnNi8n7HVcwiy5Yv15l8jBQtjaBy8mf8K7onM340jjQZuWRa+e311tjvirZ8148VDkeAgqL4gw=
X-Received: by 2002:aca:c457:: with SMTP id u84mr5393364oif.69.1625585325117;
 Tue, 06 Jul 2021 08:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210706131828.22309-1-lukasz.luba@arm.com>
In-Reply-To: <20210706131828.22309-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Jul 2021 17:28:34 +0200
Message-ID: <CAJZ5v0ga1O9Y9Lam=BoXofE7sjTNpYVSTjAWvSGZ+j__aCeXJw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] Introduce Active Stats framework with CPU
 performance statistics
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>, Beata.Michalska@arm.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kachhap <amit.kachhap@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 6, 2021 at 3:18 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi all,
>
> This patch set introduces a new mechanism: Active Stats framework (ASF), which
> gathers and maintains statistics of CPU performance - time residency at each
> performance state.
>
> The ASF tracks all the frequency transitions as well as CPU
> idle entry/exit events for all CPUs. Based on that it accounts the active
> (non-idle) residency time for each CPU at each frequency. This information can
> be used by some other subsystems (like thermal governor) to enhance their
> estimations about CPU usage at a given period.

This seems to mean that what is needed is something like the cpufreq
stats but only collected during the time when CPUs are not in idle
states.

> Does it fix something in mainline?
> Yes, there is thermal governor Intelligent Power Allocation (IPA), which
> estimates the CPUs power used in the past. IPA is sampling the CPU utilization
> and frequency and relies on the info available at the time of sampling
> and this imposes the estimation errors.
> The use of ASF solve the issue and enables IPA to make better estimates.

Obviously the IPA is not used on all platforms where cpufreq and
cpuidle are used.  What platforms are going to benefit from this
change?

> Why it couldn't be done using existing frameworks?
> The CPUFreq and CPUIdle statistics are not combined, so it is not possible
> to derive the information on how long exactly the CPU was running with a given
> frequency.

But it doesn't mean that the statistics could not be combined.

For instance, the frequency of the CPU cannot change via cpufreq when
active_stats_cpu_idle_enter() is running, so instead of using an
entirely new framework for collecting statistics it might update the
existing cpufreq stats to register that event.

And analogously for the wakeup.

> This new framework combines that information and provides
> it in a handy way.

I'm not convinced about the last piece.

> IMHO it has to be implemented as a new framework, next to
> CPUFreq and CPUIdle, due to a clean design and not just hooks from thermal
> governor into the frequency change and idle code paths.

As far as the design is concerned, I'm not sure if I agree with it.

From my perspective it's all a 1000-line patch that I have to read and
understand to figure out what the design is.

> Tha patch 4/6 introduces a new API for cooling devices, which allows to
> stop tracking the freq and idle statistics.
>
> The patch set contains also a patches 5/6 6/6 which adds the new power model
> based on ASF into the cpufreq cooling (used by thermal governor IPA).
> It is added as ifdef option, since Active Stats might be not compiled in.
> The ASF is a compile time option, but that might be changed and IPA could
> select it, which would allow to remove some redundant code from
> cpufreq_cooling.c.
>
> Comments and suggestions are very welcome.

I'm totally not convinced that it is necessary to put the extra 1000
lines of code into the kernel to address the problem at hand.
