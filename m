Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60972B8BC1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 07:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKSGkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 01:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKSGkF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 01:40:05 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD196C0613CF
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 22:40:05 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i13so3326542pgm.9
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 22:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TCQz/KA2hqKOOlA4bPgpxQWY3cHnJO4JZ3EX7aXtvFw=;
        b=KNy4dSWS83T6VD0q14ZlJtRpheQDJqycKKgG0LErsdAYOJoJUlJR8ETl3s/YJ2TfrK
         5VC5poR0aAwEFQxHuJbXN8PYDAJ6MEF26OXZeFu24AnWoZZrxuyQBTTig1inhqi224bq
         /FMWDYOoqE3JmW9DLCR1gbcxfanCGYNg4KFqNPZfwN/oqVjTgIWkprigETIGeftI1D2h
         gB5HlTOdQh4CFqFJQCo/QTnHgMMpK11d0vGmlAtBMOZ7ciqQSUFo6bLvMICU2eOTAQH3
         v4M8n8loqyG7HI5er1sghVu50OuF3HVieCTjhQnDIVxbrrx2N1KiBz8jsHFSnz6KasxP
         cVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TCQz/KA2hqKOOlA4bPgpxQWY3cHnJO4JZ3EX7aXtvFw=;
        b=KEyzBlFoofNNmh95iqQ2WBeSn4gTnVJCAW+IRhAc5G3mm/yqmkMeV/SIzl5+N1WTuL
         K6vJaCbRJrBkoWbNDXmrdm1VJeDWrOiXkrLwqA/3xQi/L5NQkEK1uV45AWu9mh+3OjFR
         w1u9GfwBfRQCM23x8N7aPEIU8cnWL+yhMrJqm04+2H7SwsLS9SY6lGb0xFCp2ws4yIyF
         Z1GA/PgaNtGg0iGTYMaIRKt9ft44IIuMBZoWGrBsirX02wDGvaVI9K/OCoaV6Hlwcr5z
         1EcOU+IFy8m2MaGyZReI4qS7OKem4btypTS59q0mggRMOXbh0RlRdVDm50a+FnUAmNoj
         gICA==
X-Gm-Message-State: AOAM530DAzzYUOcvhwBiZbQCnToIKEbk/hI7dgGxB6EgGIwpTtoLQA0F
        HWMkFVmVplQbq793msQfRQalzA==
X-Google-Smtp-Source: ABdhPJwrMgKHhEo1sifq6kgROK90gyHcKMGZfBb7j74eDKQYs6R7joDCoSh9SD2KOGWzFehj1TkWQA==
X-Received: by 2002:a63:1d55:: with SMTP id d21mr11313790pgm.324.1605768005139;
        Wed, 18 Nov 2020 22:40:05 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id h127sm28398286pfe.16.2020.11.18.22.40.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 22:40:04 -0800 (PST)
Date:   Thu, 19 Nov 2020 12:10:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Subject: Re: [PATCH v3 3/3] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201119064001.45iibj3u6mx3cgu2@vireshk-i7>
References: <20201106105514.bhtdklyhn7goml64@vireshk-i7>
 <7f73bcd6-0f06-4ef0-7f02-0751e6c4d94b@arm.com>
 <20201109065742.22czfgyjhsjmkytf@vireshk-i7>
 <2fa8a5c0-f66d-34bc-7f1c-8462e7532e0a@arm.com>
 <20201117101128.6uapqg56arwqmm5p@vireshk-i7>
 <0858962e-3a30-d177-594b-bb8e3149dd8d@arm.com>
 <20201117105337.vjwtig3qxpc6owmw@vireshk-i7>
 <CAJZ5v0iRs-uxzdV4vikN1VOwGuoorkRt2uqFSvbN2kySG-6duA@mail.gmail.com>
 <20201118044244.gbr4ujz6ilxatkde@vireshk-i7>
 <CAJZ5v0hgmMBHEdPFm7Fhj-eQr+zh5=ZGnm7S2e0aTz3juFmGPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hgmMBHEdPFm7Fhj-eQr+zh5=ZGnm7S2e0aTz3juFmGPQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-11-20, 13:00, Rafael J. Wysocki wrote:
> On Wed, Nov 18, 2020 at 5:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 17-11-20, 14:06, Rafael J. Wysocki wrote:
> > > Is this really a cpufreq thing, though, or is it arch stuff?  I think
> > > the latter, because it is not necessary for anything in cpufreq.
> > >
> > > Yes, acpi-cpufreq happens to know this information, because it uses
> > > processor_perflib, but the latter may as well be used by the arch
> > > enumeration of CPUs and the freqdomain_cpus mask may be populated from
> > > there.
> > >
> > > As far as cpufreq is concerned, if the interface to the hardware is
> > > per-CPU, there is one CPU per policy and cpufreq has no business
> > > knowing anything about the underlying hardware coordination.
> >
> > It won't be used by cpufreq for now at least and yes I understand your
> > concern. I opted for this because we already have a cpufreq
> > implementation for the same thing and it is usually better to reuse
> > this kind of stuff instead of inventing it over.
> 
> Do you mean related_cpus and real_cpus?

Sorry about the confusion, I meant freqdomain_cpus only.

> That's the granularity of the interface to the hardware I'm talking about.
> 
> Strictly speaking, it means "these CPUs share a HW interface for perf
> control" and it need not mean "these CPUs are in the same
> clock/voltage domain".  Specifically, it need not mean "these CPUs are
> the only CPUs in the given clock/voltage domain".  That's what it
> means when the control is exercised by manipulating OPPs directly, but
> not in general.
> 
> In the ACPI case, for example, what the firmware tells you need not
> reflect the HW topology in principle.  It only tells you whether or
> not it wants you to coordinate a given group of CPUs and in what way,
> but this may not be the whole picture from the HW perspective.  If you
> need the latter, you need more information in general (at least you
> need to assume that what the firmware tells you actually does reflect
> the HW topology on the given SoC).
> 
> So yes, in the particular case of OPP-based perf control, cpufreq
> happens to have the same information that is needed by the other
> subsystems, but otherwise it may not and what I'm saying is that it
> generally is a mistake to expect cpufreq to have that information or
> to be able to obtain it without the help of the arch/platform code.
> Hence, it would be a mistake to design an interface based on that
> expectation.
> 
> Or looking at it from a different angle, today a cpufreq driver is
> only required to specify the granularity of the HW interface for perf
> control via related_cpus.  It is not required to obtain extra
> information beyond that.  If a new mask to be populated by it is
> added, the driver may need to do more work which is not necessary from
> the perf control perspective.  That doesn't look particularly clean to
> me.
> 
> Moreover, adding such a mask to cpufreq_policy would make the users of
> it depend on cpufreq sort of artificially, which need not be useful
> even.
> 
> IMO, the information needed by all of the subsystems in question
> should be obtained and made available at the arch/platform level and
> everyone who needs it should be able to access it from there,
> including the cpufreq driver for the given platform if that's what it
> needs to do.
> 
> BTW, cpuidle may need the information in question too, so why should
> it be provided via cpufreq rather than via cpuidle?

Right.

-- 
viresh
