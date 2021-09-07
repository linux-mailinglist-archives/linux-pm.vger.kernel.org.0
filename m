Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AE54029F2
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 15:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbhIGNmm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 09:42:42 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43739 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344760AbhIGNmm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 09:42:42 -0400
Received: by mail-ot1-f47.google.com with SMTP id x10-20020a056830408a00b004f26cead745so12773560ott.10;
        Tue, 07 Sep 2021 06:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtwlrY+3E/w0K10z05i9TDnzVL9Tq5TYd9aqQbks3tY=;
        b=aREyV3FAqdslzbRNvOH3LLxMqyLQ6ytYScKw0Hwmxlig/32+AFFRLD65ndtbsNYHyE
         QUSdO96YGEu5CxQloIh0upUQKKn4eZWQ3DmSUI5jFFwiWmyuh2NvJNNtg3Tu7bwXq7qm
         GxI5OJMQByNvYeU7UXFbzYYFgY/diql1jkjoj74+LqqZFxD5p0FCz66j3YMMYL9IYhH9
         Gs6g0/1EgpH9KxqtwFwN5hT8Eq4TwQ7jyHdyoSdUyrrc0zg80VXhA/dWCKIv5rnhg07G
         ecKmbQGWGsYztuXE2jIlADma68xp/Zk4TMAfn58oKyeWLTCkkBQ4+euMcdTAeC/e/WvE
         GAfg==
X-Gm-Message-State: AOAM533k5t+Bne/8YPILR2hG7rFb3E9Ds0LKx0fElNQ/TszyfWZ1tnPR
        lPPXvs+jMK2osw5VIOjPSqmGgQzUkmcXPlpJ6+k=
X-Google-Smtp-Source: ABdhPJwLHmRO9sE3kzyHDxsYhh2rZ81ElftO2O+91bzWQPqS0QWZopNz16BSnJXxXwhoYnY+5Xtsn+RJ8rITwtPx+ho=
X-Received: by 2002:a9d:6945:: with SMTP id p5mr15455234oto.301.1631022094445;
 Tue, 07 Sep 2021 06:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210904053703.581297-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0hQp8Hxf__tL22s0oOcTym5mx9tND34ijufTDE3_NSW6A@mail.gmail.com>
 <926ac4b9-1bb5-e96e-ded3-6461f7a215b7@kernel.dk> <b1d5b6daacef349eb6fcc23ce7264e4786d1d9f4.camel@linux.intel.com>
 <CAJZ5v0jaXnw0zjpnsb81Hauy4-ApuULfQaaLG10qqL67H-YTNA@mail.gmail.com>
 <8dc57921f157b154e4af2dba26ce697dc4d4fcc2.camel@linux.intel.com>
 <CAJZ5v0jLmziZZEqEk-D+b6jD7UUPmeb7MQW1ZptdHTk-2c9nMg@mail.gmail.com>
 <584a4fad09048e3ea0dbc3515b2e909b745177dd.camel@linux.intel.com>
 <CAJZ5v0iH3TacxX3gzBS5cah7SnmDWbmHz=WCujQJpmEggGhLhg@mail.gmail.com> <980bc41a8bedbd81c199a78ce9f2ab2ef7b9341f.camel@linux.intel.com>
In-Reply-To: <980bc41a8bedbd81c199a78ce9f2ab2ef7b9341f.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Sep 2021 15:41:23 +0200
Message-ID: <CAJZ5v0hLXuF8HXcW61TqiBxYnskkb-nkah=XzX2SH8EKGJB-RA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix for HWP interrupt before
 driver is ready
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 6, 2021 at 9:57 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2021-09-06 at 20:25 +0200, Rafael J. Wysocki wrote:
> > On Mon, Sep 6, 2021 at 8:14 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Mon, 2021-09-06 at 19:54 +0200, Rafael J. Wysocki wrote:
> > > >
> [...]
>
> > > >
> > > We are handling offline for other thermal interrupt sources from
> > > same
> > > interrupt in therm-throt.c, where we do similar in offline path (by
> > > TGLX). If cpufreq offline can cause such issue of changing CPU,
> >
> > This is not cpufreq offline, but intel_pstate_update_status() which
> > may be triggered via sysfs.  And again, the theoretically problematic
> > thing is dereferencing cpudata (which may be cleared by a remote CPU)
> > from the interrupt handler without protection.
>
> This will be a problem.
>
> >
> > > I can call intel_pstate_disable_hwp_interrupt() via override from
> > > https://elixir.bootlin.com/linux/latest/C/ident/thermal_throttle_offline
> > > after masking APIC interrupt.
> >
> > But why would using RCU be harder than this?
> I think, this will require all_cpu_data and cpu_data to be rcu
> protected. This needs to be well tested.
>
> I think better to revert the patch for the next release.

Done, thanks!
