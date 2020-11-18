Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14AD2B7D38
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 13:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgKRMBA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 07:01:00 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:36586 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgKRMA7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 07:00:59 -0500
Received: by mail-oo1-f67.google.com with SMTP id l20so352111oot.3;
        Wed, 18 Nov 2020 04:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPOb9W48eGZgD6sBZPbh2k72VGzxirYWT/ISdNxD5mE=;
        b=NKsGVrarOypAbKrGnmtGnVzARJ78cIyk+4PuxbhYcdag/ueykYlcqdhShYpRKS7x3C
         cD/GMJnb9tnyVrkUguZW6z4Pa1m72l3yMvZVSDZR2NLfKK4R6jVtCEVOzWA6mPxUx1UU
         3J2TbZ4iA4Fe/Sw5qRAymbIf3zmCUxXMsEd7BZbdG0oSvkHuA6jm8SWRpr4XN9PtHBLH
         K/JRBYxT8Kn5BxKUL0ogccL2SppYXmn4xQbC3ZIPv2XZitUiUnfLHV0dw7OHhe3WP5D2
         x36YGxYmZqsk7i3kWAJM9rMX9gB/GHKmcwXYIxrYe6CeuximwNHdBB+b+HgUFEGw3W5I
         qRTw==
X-Gm-Message-State: AOAM532RMExOQ7Rtb/TpC75jJx1IPUTXJQbmPap8rzlX2UGIPToEt5Qx
        /gdjNsnW77f60w1GXDdvd0TtLZjcyNQO47+jvfg=
X-Google-Smtp-Source: ABdhPJzaKV8b8ERYo4ioHvH77gn02CpThIh3eKZy4HSzX/NUss4UZyKpykwXlOxZkw/cOhJCxVSrYRqfdey6Vx/VJBs=
X-Received: by 2002:a4a:e80b:: with SMTP id b11mr6297200oob.1.1605700857134;
 Wed, 18 Nov 2020 04:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20201106092020.za3oxg7gutzc3y2b@vireshk-i7> <0a334a73-45ef-58ff-7dfd-9df6f4ff290a@arm.com>
 <20201106105514.bhtdklyhn7goml64@vireshk-i7> <7f73bcd6-0f06-4ef0-7f02-0751e6c4d94b@arm.com>
 <20201109065742.22czfgyjhsjmkytf@vireshk-i7> <2fa8a5c0-f66d-34bc-7f1c-8462e7532e0a@arm.com>
 <20201117101128.6uapqg56arwqmm5p@vireshk-i7> <0858962e-3a30-d177-594b-bb8e3149dd8d@arm.com>
 <20201117105337.vjwtig3qxpc6owmw@vireshk-i7> <CAJZ5v0iRs-uxzdV4vikN1VOwGuoorkRt2uqFSvbN2kySG-6duA@mail.gmail.com>
 <20201118044244.gbr4ujz6ilxatkde@vireshk-i7>
In-Reply-To: <20201118044244.gbr4ujz6ilxatkde@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Nov 2020 13:00:46 +0100
Message-ID: <CAJZ5v0hgmMBHEdPFm7Fhj-eQr+zh5=ZGnm7S2e0aTz3juFmGPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] [RFC] CPUFreq: Add support for cpu-perf-dependencies
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 18, 2020 at 5:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-11-20, 14:06, Rafael J. Wysocki wrote:
> > Is this really a cpufreq thing, though, or is it arch stuff?  I think
> > the latter, because it is not necessary for anything in cpufreq.
> >
> > Yes, acpi-cpufreq happens to know this information, because it uses
> > processor_perflib, but the latter may as well be used by the arch
> > enumeration of CPUs and the freqdomain_cpus mask may be populated from
> > there.
> >
> > As far as cpufreq is concerned, if the interface to the hardware is
> > per-CPU, there is one CPU per policy and cpufreq has no business
> > knowing anything about the underlying hardware coordination.
>
> It won't be used by cpufreq for now at least and yes I understand your
> concern. I opted for this because we already have a cpufreq
> implementation for the same thing and it is usually better to reuse
> this kind of stuff instead of inventing it over.

Do you mean related_cpus and real_cpus?

That's the granularity of the interface to the hardware I'm talking about.

Strictly speaking, it means "these CPUs share a HW interface for perf
control" and it need not mean "these CPUs are in the same
clock/voltage domain".  Specifically, it need not mean "these CPUs are
the only CPUs in the given clock/voltage domain".  That's what it
means when the control is exercised by manipulating OPPs directly, but
not in general.

In the ACPI case, for example, what the firmware tells you need not
reflect the HW topology in principle.  It only tells you whether or
not it wants you to coordinate a given group of CPUs and in what way,
but this may not be the whole picture from the HW perspective.  If you
need the latter, you need more information in general (at least you
need to assume that what the firmware tells you actually does reflect
the HW topology on the given SoC).

So yes, in the particular case of OPP-based perf control, cpufreq
happens to have the same information that is needed by the other
subsystems, but otherwise it may not and what I'm saying is that it
generally is a mistake to expect cpufreq to have that information or
to be able to obtain it without the help of the arch/platform code.
Hence, it would be a mistake to design an interface based on that
expectation.

Or looking at it from a different angle, today a cpufreq driver is
only required to specify the granularity of the HW interface for perf
control via related_cpus.  It is not required to obtain extra
information beyond that.  If a new mask to be populated by it is
added, the driver may need to do more work which is not necessary from
the perf control perspective.  That doesn't look particularly clean to
me.

Moreover, adding such a mask to cpufreq_policy would make the users of
it depend on cpufreq sort of artificially, which need not be useful
even.

IMO, the information needed by all of the subsystems in question
should be obtained and made available at the arch/platform level and
everyone who needs it should be able to access it from there,
including the cpufreq driver for the given platform if that's what it
needs to do.

BTW, cpuidle may need the information in question too, so why should
it be provided via cpufreq rather than via cpuidle?
