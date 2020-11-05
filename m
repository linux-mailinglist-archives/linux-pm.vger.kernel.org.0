Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9882A80CF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 15:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgKEO0I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 09:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbgKEO0I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 09:26:08 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC33C0613D2
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 06:26:06 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id k25so1755442lji.9
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 06:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQ7ga1nkChbgCNcp4Ysi78tNBZumkjAPVt4V0by2Rm8=;
        b=pptPNx+rPKH+x8ujYpmcYsyk+OSaKWXu77RvkAt9PkUW9Em/bfITai0EeR5btFlbga
         H9I7ln/IHvqioPTlV6w9QmZAdFToDVYMsCVCLxVkS8HdWZaKNUxU7DRjvJvNRztT7CnC
         G7aySamX2FtDLHidKTRgYHvzlr9Hmp1s+GDA33Um8IxwSlWeUc0pv1aP1BxKAPo6ox+H
         MlCp2OTmbeeaCfB5QfrJ3j/ST6o75MEjSUZxYHfb7CiXNN8ZfLyNHII0RFnZ3ksB9Wst
         sGuyuVtlmXbjQ4XAh0MbwV1ZlccZ7DTvP2EFCrpuxlaO6BXe4AQQ7DUQDk8SlphH8C5+
         GeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQ7ga1nkChbgCNcp4Ysi78tNBZumkjAPVt4V0by2Rm8=;
        b=GqnNjeDBTXvHPQNoHeILInsdjQx+c/HmIr477fwIDo4hcuCR70qRE1028HbInpPozg
         6eBTG6jcMu3CPDVjRkkfUgOxnZFIqMlOvX/Kthyk7K8a8nyLXZdMhyx0na/teSLb2wjO
         t3ZtQZEvwwMC+Tk7Ll6iB3lC4j0NiOjGWJgW8QkF/zT2j5QglXVklYga0knCdjU+Dl6i
         r0zDPsOCrzIV4WY31bTTlp34Z4HoIAp2sFlQBEbqmgPIFKLF/TKe7jZHZ53NnWPC89eA
         FGP6AH0spFcS9RXp01uGqAQc5YnCVQggNox1fWu9NnBXdKcrmggiC4OdlVnj3wu2hYlk
         l8gg==
X-Gm-Message-State: AOAM533x/smElYrnNutX83SUVDw3y4rPvDg4MOXyeBRjf3UP82e+/a0R
        n3GNax8FDe2Adw62IIKSTxHAJCOgzi0suBK93+MTvg==
X-Google-Smtp-Source: ABdhPJxojzyjuq7Nj7ikSubvMrtczulnP1sYUG9Acvch7VPEunsyTvFdj2dDMWpVKYNODrC4v0vcXiLI77RWHXj2jNE=
X-Received: by 2002:a2e:9583:: with SMTP id w3mr1042305ljh.25.1604586365033;
 Thu, 05 Nov 2020 06:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201103101840.yrgwmcjrnjn7n5q6@vireshk-i7> <87558fa9-a4c6-38c9-bcc5-f736c0229f56@arm.com>
In-Reply-To: <87558fa9-a4c6-38c9-bcc5-f736c0229f56@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 Nov 2020 15:25:53 +0100
Message-ID: <CAKfTPtDvDqHjSFCmjc_D_8Tx0kosBneDxmDZRpG6XkgAnWE3nw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] CPUFreq: Add support for cpu performance dependencies
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 4 Nov 2020 at 19:02, Nicola Mazzucato <nicola.mazzucato@arm.com> wrote:
>
> Hi Viresh, thanks for looking into this.
>
> On 11/3/20 10:18 AM, Viresh Kumar wrote:
> > On 02-11-20, 12:01, Nicola Mazzucato wrote:
> >> Hi All,
> >>
> >> In this V3 posting I have replaced the new dt-binding with minor changes/
> >> improvements for opp (since we are now using opp tables instead).
> >> The RFC still stands on how to make this info available to sw consumers.
> >>
> >> In the RFC, I am proposing a simple addition of a performance dependencies
> >> cpumask in CPUFreq core and an example of how drivers and consumers would
> >> make use of it.
> >> I also propose an alternative approach, which does not require changes in
> >> CPUFreq core, but - possibly - in all the consumers.
> >>
> >> This is to support systems where exposed cpu performance controls are more
> >> fine-grained that the platform's ability to scale cpus independently.
> >
> > I was talking to Vincent about what you are doing here and we got a
> > bit confused and so here are few questions that we had:
> >
> > - Based on my previous understanding, you don't want software
> >   coordination of frequencies (which is done by cpufreq today), but
> >   want the hardware to do that and so you want per-cpu cpufreq
> >   policies.
>
> Correct. And this has been done for quite some time in some platforms.
>
> >
> > - What's the real benefit of hardware coordination ? Want to make sure
> >   I fully understand that.
>
> The hardware coordination that is coming out by having per-cpu cpufreq policies
> is not new, and works just fine in most of the systems.
>
> The benefit of having per-cpu controls is that the firmware will take care of
> the performance of the entire system. It is purely a delegation to firmware for
> the performance optimizations.
>
> >
> > - Because of hardware co-ordination of otherwise co-ordinated CPUs,
> >   few things break. Thermal and EAS are some of the examples and so
> >   you are trying to fix them here by proving them the missing
> >   information again.
>
> Correct. And for this I have proposed two ways.
>
> >
> > - One other thing that breaks with this is freq-invariance in the
> >   scheduler, as the scheduler won't see the real frequencies the
> >   various CPUs are running at. Most of the hardware we have today
> >   doesn't have counters, like AMUs, not sure if all future ones based
> >   on SCMI will have that too, so how are they gong to be fixed ?
> >
>
> Correct. freq-invariance without counters is trying to do its best based on the
> information it has available. It definitely relies on the knowledge of the v/f
> domains to work at its best so I think in the case of per-cpu it will follow the
> same approach as others being affected (EAS, thermal).

As frequency invariance has same problem as EAS and Thermal it would
be good to see the solution as part of this proposal like EAS and
Thermal

>
> >   And if we even have to fix this (freq invariance), what's hardware
> >   coordination giving us that makes all this worth it ?
>
> I suppose this is more a generic question for all the platforms running with h/w
> coordination, but for our case is that the f/w will take care of the performance
> optimizations for us :)
>
> >
> > Sorry about the long list :)
>
> No problem at all. Thank you for your time on this and I hope I have made bits
> clearer.
>
> Nicola
>
> >
