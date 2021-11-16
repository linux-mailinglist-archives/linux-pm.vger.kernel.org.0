Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534D84538DF
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbhKPR41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 12:56:27 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:43655 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhKPR40 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 12:56:26 -0500
Received: by mail-oi1-f175.google.com with SMTP id o4so171249oia.10;
        Tue, 16 Nov 2021 09:53:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AOLI+W/JpDfVVShrdJeTQ9AA6emXlOltLGyHRFz9ZM=;
        b=AQVV2HTIwbM+Be8CNl2ToBPlSFQb5UK2ccvHVx/8QJEuxNU8LggPmHFzc2hFYazoGS
         hLsBqGoRliTCURpN2XwzMQyKqQGNR/csQY9+jmILy4kc1wGYWSB97yB1Sv2DHhOquiIO
         ikAsa9YxW87qjocITbWKXikyI5/v6d4psCLiHhvabkVIrjqACh2bjZFMDv7chRkUtVFC
         KROEfREU4YGZHA4yFcG9CCbBdVe628xwo4/prv6EGPlWg1KX/isRObl3Cvv3T9xnz183
         JzV0Wd8wUw7LQAglSWD2He8xeel+eO9MWfbn5X2n3tyw9pQnnJdxecr5nBQdwprsPmB4
         Q3yg==
X-Gm-Message-State: AOAM532SeeNxJuCNXHxxt9GIqlnsTHmpeIvvA3uccpO1uYVNN3diRpnB
        iFzWW/IMObyyrrRUP6Ljw5ARfWBeEVaWSLkoc5w=
X-Google-Smtp-Source: ABdhPJwoSwKbzjrWGSgNjMKh+u+JdJh4YXIcT9cLRq41Zo8vSQSHIRfVdJgImUbetg86JitSmEkqnYyIo424GQcI/3w=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr8068053oiw.154.1637085209025;
 Tue, 16 Nov 2021 09:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20211022075057.10759-1-Pierre.Gondois@arm.com>
 <CAJZ5v0g4RrpnRfTsBm_Qi2-JM8SQCAH9_7gTM9cB3Rmc0DG4Hg@mail.gmail.com> <fe34da7f-7090-bc11-ae1a-5ab228d0cb05@arm.com>
In-Reply-To: <fe34da7f-7090-bc11-ae1a-5ab228d0cb05@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Nov 2021 18:53:18 +0100
Message-ID: <CAJZ5v0g6W_BuQz99YzVe=8kU4PkaaF4FUfDd65WpjMpQvwL8qA@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: CPPC: Fix performance/frequency conversion
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 15, 2021 at 11:19 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Rafael,
>
> On 11/5/21 15:40, Rafael J. Wysocki wrote:
> > On Fri, Oct 22, 2021 at 9:51 AM Pierre Gondois <Pierre.Gondois@arm.com> wrote:
> >> CPUfreq governors request CPU frequencies using information
> >> on current CPU usage. The CPPC driver converts them to
> >> performance requests. Frequency targets are computed as:
> >>   target_freq = (util / cpu_capacity) * max_freq
> >> target_freq is then clamped between [policy->min, policy->max].
> >>
> >> The CPPC driver converts performance values to frequencies
> >> (and vice-versa) using cppc_cpufreq_perf_to_khz() and
> >> cppc_cpufreq_khz_to_perf(). These functions both use two different
> >> factors depending on the range of the input value. For
> >> cppc_cpufreq_khz_to_perf():
> >> - (NOMINAL_PERF / NOMINAL_FREQ) or
> >> - (LOWEST_PERF / LOWEST_FREQ)
> >> and for cppc_cpufreq_perf_to_khz():
> >> - (NOMINAL_FREQ / NOMINAL_PERF) or
> >> - ((NOMINAL_PERF - LOWEST_FREQ) / (NOMINAL_PERF - LOWEST_PERF))
> >>
> >> This means the functions are not inverse for some values:
> >> (perf_to_khz(khz_to_perf(x)) != x)
> >>
> >> This patch makes use of one single conversion factor, being
> >> (MAX_PERF / MAX_FREQ).
> >>
> >> As LOWEST_FREQ is not used during conversion, the LOWEST_FREQ
> >> advertised through policy->cpuinfo.min_freq might be different
> >> from the LOWEST_FREQ value available in the CPPC object,
> >> but the conversion will be correct.
> > Well, this assumes that there is a linear perf <-> freq mapping which
> > is a change in behavior.
> The perf <-> freq relation is currently linear on 2 distinct segments.
>
> The patch is also intending handle the case of CPUs whose frequency and
> performance values are not proportional.
>
> Example for the current code:
>   MAX_FREQ = 1.000.000
>   MIN_FREQ = 300.000
>   MAX_PERF = 100 ("nominal_perf" in the code)
>   MIN_PERF = 40  ("lowest_perf" in the code)
> With these values, frequencies and performances are not proportional as
> (MAX_FREQ / MAX_PERF) != (MIN_FREQ / MIN_PERF).
>
> A util of 40% gives:
>   target_freq = 40% * MAX_FREQ.
> cppc_cpufreq_khz_to_perf() then requests:
>   target_perf = target_freq * (MIN_PERF / MIN_FREQ)
>   target_perf = 40% * 1.000.000 * (40 / 300.000)
>   target_perf = 53.3
> A performance request of 40 would have been sufficient.
>
> The error comes from the utilization of 2 different factors.
> policy->max (frequency) is computed with this factor:
> - (MAX_FREQ / MAX_PERF)
> and frequency requests are mostly converted to performance
> values with this factor:
> - (MIN_PERF / MIN_FREQ)
>
> Using one single factor per conversion function, being
> (MAX_PERF / MAX_FREQ) for cppc_cpufreq_khz_to_perf():
>   target_perf = target_freq * (MAX_PERF / MAX_FREQ)
>   target_perf = 40% * 1.000.000 * (100 / 1.000.000)
>   target_perf = 40
> > While I agree that consistency is a good thing in general, won't this
> > cause the values visible via sysfs to change?  And if it does, won't
> > it confuse anyone or break anything in user space?
> Yes it changes the minimum frequency advertised on sysfs. It might
> effectively be confusing. It should be possible to still advertise the
> minimum frequency in the ACPI _CPC object while using one conversion
> factor, but this will require more changes.

So why don't we make them?
