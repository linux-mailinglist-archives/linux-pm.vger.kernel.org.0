Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89098259DC5
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 19:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgIAR7s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 13:59:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46716 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbgIAR7s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 13:59:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id u126so1920626oif.13
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 10:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sujYt6371DvOb0s7i1+78EW9f+rIkLXLI0G2kq9t9d0=;
        b=bEWN3TIACxkw4NpJMBGzTIrsszI94GcgQhK+qWsXPxRdjXLZD5eDnqVDfZHWePzufW
         Q/4MN/kRQdttfoDxSPOI5ldnGdMjy59/zH4FQ3sgbqU1aPcmXokDFWAjYMCzBwFeBPXO
         E0YOMvSesKkL64QuwC9S+pm3wGC4fbDAFH9lkRwk2hCL+HuP1bEBdhv+eV/xzSQ/Kpe/
         43KcV5numPzBXMh02XcR+wGSagk/bBtmDuqAgV10hNhmOG91f6kkdRuzvnStlWVT4zxL
         S43RzN/5VmCEeAagbvPWL4wYz/XYHiCtFFC8GQ9RLt7vjP3Eo9xB1ZM6LT83HcGOHT9o
         M8QQ==
X-Gm-Message-State: AOAM530I+IvLKipCR/AwbXnnxPAebup7l21O2QVuatFiwZPpYrSovT6L
        RVh4Ppceb9PdiwKhQAnD1wZDQERMSleJvhC2TBM=
X-Google-Smtp-Source: ABdhPJxbDvOsdcV2qAQseNhACAMxLsfdFDpZ22mi+4zbTUPkL1PexutwxAQF2pFHwz0EsuoZ4aE8t3p/dWHN0SzDFrc=
X-Received: by 2002:aca:3e8b:: with SMTP id l133mr1957037oia.110.1598983187655;
 Tue, 01 Sep 2020 10:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200901030250.495928-1-currojerez@riseup.net> <81b98c58eab0bf075d9ded2154a7a88020628c80.camel@linux.intel.com>
In-Reply-To: <81b98c58eab0bf075d9ded2154a7a88020628c80.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Sep 2020 19:59:36 +0200
Message-ID: <CAJZ5v0hQadTdCoz08OusMukJ0xNz-5HKNg1YGFsYXmn9JfH7QA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max() for
 turbo disabled cases.
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Francisco Jerez <currojerez@riseup.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Caleb Callaway <caleb.callaway@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 1, 2020 at 5:48 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2020-08-31 at 20:02 -0700, Francisco Jerez wrote:
> > This fixes the behavior of the scaling_max_freq and scaling_min_freq
> > sysfs files in systems which had turbo disabled by the BIOS.
> >
> > Caleb noticed that the HWP is programmed to operate in the wrong
> > P-state range on his system when the CPUFREQ policy min/max frequency
> > is set via sysfs.  This seems to be because in his system
> > intel_pstate_get_hwp_max() is returning the maximum turbo P-state
> > even
> > though turbo was disabled by the BIOS, which causes intel_pstate to
> > scale kHz frequencies incorrectly e.g. setting the maximum turbo
> > frequency whenever the maximum guaranteed frequency is requested via
> > sysfs.
>
> When  turbo is disabled via MSR_IA32_MISC_ENABLE_TURBO_DISABLE (From
> BIOS), then no matter what we write to HWP. max, the hardware will clip
> to HWP_GUARANTEED_PERF.
>
> But it looks like this is some issue on properly disabling turbo from
> BIOS, since you observe turbo frequencies (via aperf, mperf) not just
> sysfs display issue.
>
>
>
> >
> > Tested-by: Caleb Callaway <caleb.callaway@intel.com>
> > Signed-off-by: Francisco Jerez <currojerez@riseup.net>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 5.9-rc material with minor edits in the subject.

Thanks!

> > ---
> >  drivers/cpufreq/intel_pstate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index e0220a6fbc69..7eb7b62bd5c4 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -825,7 +825,7 @@ static void intel_pstate_get_hwp_max(unsigned int
> > cpu, int *phy_max,
> >
> >       rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
> >       WRITE_ONCE(all_cpu_data[cpu]->hwp_cap_cached, cap);
> > -     if (global.no_turbo)
> > +     if (global.no_turbo || global.turbo_disabled)
> >               *current_max = HWP_GUARANTEED_PERF(cap);
> >       else
> >               *current_max = HWP_HIGHEST_PERF(cap);
>
