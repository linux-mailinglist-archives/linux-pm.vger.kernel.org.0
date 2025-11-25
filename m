Return-Path: <linux-pm+bounces-38587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43911C8502C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE16A34F3C2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151DF2DEA67;
	Tue, 25 Nov 2025 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdlknH4b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0718DB1E
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074488; cv=none; b=jG7hGEFBIw6U9lGewvQ2KadO683hCCcS8saNXEpoSkoLn+MGAVdIzgdkbeFFs3Tg49urnY7O/tFcu04IbmBKAknLLjLTBgIcwVzAHLrnJRJiids40OTo/sjJ7Upfdbj3EpPFGsbdEfs6zSnawLv2UgS4dj9mum0Qf7cerwaKrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074488; c=relaxed/simple;
	bh=G9DorhQ28wi83eOKGRDlIpZQVHTaiFPZOtl2JSMI8DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xj0LKV8N4Iyd+QbhVA0hdkz6JCytbO1QLMC/cxHLrCsTi1VnZXdTe7OZHFgUEqUZ7fndlXM8zgcO/ulZ2sxsVZ49Ob/qVdwjPipEt+MZC8QxXEULGqZY8tCdykB6yhB62ggdhaow4w5P89FKQQK2ncM21fYNggTcMSuo5BzEvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdlknH4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F15DC19425
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764074487;
	bh=G9DorhQ28wi83eOKGRDlIpZQVHTaiFPZOtl2JSMI8DQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JdlknH4b9/1GAM05G6dstddBHGXLZJeAbNI2n414PjgmwWgG2sXJUxFvFryNWRzT1
	 b/pJaQ4hh3gA5dmyunkBVgqrlwtn4WCZk4N+TOxgSYjxfxpT/+cjeDwz44AfJApUcq
	 ++vYQZ8Zki1zG7EIFQVWFaEqPt4JBwuJ4tpk3gQz3SuZzX5cxSFgvzig5gGxvS5014
	 HGf1LfSMV9oEGBdFhE8lZvwuwaA520a4pJ4GY7+vxWLxvPn2kQ5hRZCFDdMZ64VAOI
	 67PpF7dd+G94u+91+R0LsOI6aTeM+sThDmdfObKqnU4/RVplD1yQzQOtPTb480LDFi
	 OtCn2sbWbQ9jA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-65748e230f9so1788533eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:41:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSRrBZWvdrniXN58Dc5rcqvnffu/OXjkDj+u5yPEuNs/JKnb3tUZGWFzAER+JuBc1sS2MUtd3Mig==@vger.kernel.org
X-Gm-Message-State: AOJu0YydJ+KXOzKn+ecfGxFxPGGl6M502+7RlnbHpfyOqduilwBe3tws
	F3+jUUbdIKiS0n4B9H4vbDnWH9tdH+XQ+i21luou3Zb028ZOAx/8LgdoO4XCD0UIUnBdeDoliw9
	zkmrIUlH4bqrE94e6WysJStjmPcRQqKI=
X-Google-Smtp-Source: AGHT+IEwf//amOIrcOuWVKu4/d8d7XtkKOEZ9K4qxMy/RFn+09EsuWY1/OS+Mz6y/k9l0eZMx4XRF2rrk8sfq8CEouE=
X-Received: by 2002:a05:6820:4008:b0:657:5cd7:f67f with SMTP id
 006d021491bc7-65785844263mr6652648eaf.2.1764074486671; Tue, 25 Nov 2025
 04:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
 <71ea7728-6808-4bdf-9437-3746ff8664fc@arm.com> <LV3PR11MB8768D5F17B1F9575DE2804B6F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
 <CAKfTPtChUavg0TYK_BiA9NnR-9_A1nz49kMASf6g8vCwhpJzcg@mail.gmail.com> <5ce509d3-0e11-444f-a22e-6c01280dd9af@arm.com>
In-Reply-To: <5ce509d3-0e11-444f-a22e-6c01280dd9af@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 13:41:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hj_YB91SUej3gGzQy+i3rjHwi5uxyKg5KGMJT_hpUOkg@mail.gmail.com>
X-Gm-Features: AWmQ_bkb-xiVTPeIoRiD3ggo9flkIVkQeHZYvjzJ1eIrCPg1IoGvoLtRMRCDvmM
Message-ID: <CAJZ5v0hj_YB91SUej3gGzQy+i3rjHwi5uxyKg5KGMJT_hpUOkg@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
To: Christian Loehle <christian.loehle@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, 
	"Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"vschneid@redhat.com" <vschneid@redhat.com>, "mgorman@suse.de" <mgorman@suse.de>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bsegall@google.com" <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 10:46=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/25/25 09:38, Vincent Guittot wrote:
> > On Tue, 25 Nov 2025 at 10:23, Kumar, Kaushlendra
> > <kaushlendra.kumar@intel.com> wrote:
> >>
> >> Hi Lukasz,
> >>
> >> On 11/25/25 XX:XX, Lukasz Luba wrote:
> >>> Hi Kaushlendra,
> >>>
> >>> On 11/25/25 03:24, Kaushlendra Kumar wrote:
> >>>> In sugov_next_freq_shared(), the CPU capacity is retrieved only for
> >>>> the CPU that triggered the update (sg_cpu->cpu) and then incorrectly
> >>>> applied to all CPUs in the shared frequency domain during the loop.O=
n
> >>>> heterogeneous systems with CPUs of different capacities sharing a
> >>>> frequency domain, this causes incorrect frequency selection.
> >>>
> >>> How is this possible?
> >>> Is it old or new Intel SoC (a chip name would be also welcome)?
> >>
> >> This is with respect to intel platforms which has E-cores and P-cores.

So this is all misguided.

P-cores and E-cores don't even share frequency, so why would they be
there in the same domain?

On P-cores, frequency can be controlled independently per-core.

E-cores technically go in modules of 4 and the frequency is shared
within a module, but the interface to control it (HWP or CPPC if you
will) is per-CPU and intel_pstate treans them as independent.

For this reason, sugov_next_freq_shared() should never be used on
Intel hardware.

> >
> > Do you mean that they share the same frequency domains ?
>
> Just to get everybody on the same page:
> Intel has what's called "favored cores", P-cores that allow for slightly
> higher frequencies than the other (same uArch) P-cores.

Yes, but they don't share the frequency level with any other cores.

> Rafael's EAS series decided that it wouldn't be worth the effort make EAS
> always iterate over an extra cluster (overhead on every wakeup hot-path)
> for CPUs where in the bigger picture the difference is negligible.
> https://lore.kernel.org/lkml/1592aa65-9dfb-47d6-9bcf-17afd3184a0a@arm.com=
/
> (capacities are 623, 1009 and 1024 here, 1009 and 1024 are lumped into on=
e
> cluster.)

Frequency control is still per-CPU though and from the schedutil
perspective it is always the single CPU case.

> I think this isn't unreasonable, as long as this technicality lives insid=
e
> of intel_pstate setup code and doesn't escape, like proposed here.
> Obviously EAS heavily relies on "1 cluster =3D> 1 capacity" assumption as
> mentioned before, even just for max-spare-cap in feec().
> Breaking this assumption would require a huge rework, which AFAIU specifi=
cally
> wasn't was Rafael intended, but I'm sure he'll chime in himself.

The EAS considerations are kind of a separate thing and they have
never changed the intel_pstate's assumptions regarding the performance
control granularity.

> So if you really have issues with the different capacities within a clust=
er
> trick that Rafael went with, please just reconsider that instead of tryin=
g
> to patch things up outside of intel_pstate.

Honestly, I think that trying to patch things at all without
sufficient understanding is antisocial and wrong.

