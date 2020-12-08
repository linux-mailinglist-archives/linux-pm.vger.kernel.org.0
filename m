Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330222D30A6
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 18:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgLHRLt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 12:11:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37479 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbgLHRLs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 12:11:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id o11so13770782ote.4;
        Tue, 08 Dec 2020 09:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15rE3KQn7PPdV/CEBIk2C/9+UTIHgOULjoqUJOxHrlQ=;
        b=X1wk76bxqTUV2BLLjUvV9tUfykg7FbhrgWZt3BICCV79iCAGg0dmEFQuzDTebZ88eL
         YDPBtm7BPwCcteGvmQf9LbkDZ9MNFw+Z2TIv9d8SZTqBgY/CWAXDxLgzF6HD51SCDJuI
         vC9ANwmNPq/KISJ2zXPidHsIV3jVJDnWBaKGboW3yuj/MMU/bZb0IXqhuYqyiDvI7TVJ
         sEkFA7s71IWEKljTOi1IaAW3J7aokcgnHTIzYNsmB1oO529h5tw3t8Pic6lv3aiX3OVP
         J6mC44LXOFa6/opFCFriM5qqvDZA8vlXQxzewGePqhl95HKN23zvQKtGzHoUlJ55CbB6
         d3yA==
X-Gm-Message-State: AOAM5313nvoRhOoXo3PRwCwj1fXTxE3CFUc2rolWFrkaW14qqcnIBK/l
        fTjKZ5vwC2he8uyX/zM4ZwdZBLkDgRsw8+N8Lm4=
X-Google-Smtp-Source: ABdhPJywVCQJbmk0JZqU3Un6QBKoG5cUq12Sk5D5OA4/mnXR2jZNR0zxLCAD+h9uXD3o/pNRUHtEgMWRKqFreNJGwtM=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr10608959otn.321.1607447467987;
 Tue, 08 Dec 2020 09:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20360841.iInq7taT2Z@kreacher> <3342398.tGQZsKHvNY@kreacher> <20201208124344.GX2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201208124344.GX2414@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Dec 2020 18:10:56 +0100
Message-ID: <CAJZ5v0h6KM1V2_JoN+WFxAq8pKvOfsOcCVXYchUzb4xyfdzsGw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] cpufreq: intel_pstate: Implement the
 ->adjust_perf() callback
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 8, 2020 at 1:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 07, 2020 at 05:38:58PM +0100, Rafael J. Wysocki wrote:
>
> > +static void intel_cpufreq_adjust_perf(unsigned int cpunum,
> > +                                   unsigned long min_perf,
> > +                                   unsigned long target_perf,
> > +                                   unsigned long capacity)
> > +{
> > +     struct cpudata *cpu = all_cpu_data[cpunum];
> > +     int old_pstate = cpu->pstate.current_pstate;
> > +     int cap_pstate, min_pstate, max_pstate, target_pstate;
> > +
> > +     update_turbo_state();
> > +     cap_pstate = global.turbo_disabled ? cpu->pstate.max_pstate :
> > +                                          cpu->pstate.turbo_pstate;
> > +
> > +     /* Optimization: Avoid unnecessary divisions. */
> > +
> > +     target_pstate = cap_pstate;
> > +     if (target_perf < capacity)
> > +             target_pstate = DIV_ROUND_UP(cap_pstate * target_perf, capacity);
> > +
> > +     min_pstate = cap_pstate;
> > +     if (min_perf < capacity)
> > +             min_pstate = DIV_ROUND_UP(cap_pstate * min_perf, capacity);
> > +
> > +     if (min_pstate < cpu->pstate.min_pstate)
> > +             min_pstate = cpu->pstate.min_pstate;
> > +
> > +     if (min_pstate < cpu->min_perf_ratio)
> > +             min_pstate = cpu->min_perf_ratio;
> > +
> > +     max_pstate = min(cap_pstate, cpu->max_perf_ratio);
> > +     if (max_pstate < min_pstate)
> > +             max_pstate = min_pstate;
> > +
> > +     target_pstate = clamp_t(int, target_pstate, min_pstate, max_pstate);
> > +
> > +     intel_cpufreq_adjust_hwp(cpu, min_pstate, max_pstate, target_pstate, true);
>
> I'm confused... HWP doesn't do pstate, yet everything here is now called
> pstate, help?

HWP.REQ.MIN, HWP.REQ.MAX and HWP.REQ.DESIRED all are in the same space
of values as the original PERF_CTL MSR, which is P-states, at least
effectively.

> > +
> > +     cpu->pstate.current_pstate = target_pstate;
> > +     intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate);
> > +}
