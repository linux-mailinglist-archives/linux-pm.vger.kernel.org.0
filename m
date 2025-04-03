Return-Path: <linux-pm+bounces-24757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5618A7A188
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 13:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0142818961F3
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 11:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D264248195;
	Thu,  3 Apr 2025 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvlQjjSc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E41DF975;
	Thu,  3 Apr 2025 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743678191; cv=none; b=sGSbK3n0oYPCqrrtPjtFWLVUQWpmdDE39IAgG9+AfCn49Ikvb+11vLB0kgE+Jpcps4vzwgiEzjVFxYubf3mOtKBqzG9Ixvs/tSnXJj5nDeXxoW4S7Gd9OgfsX++TpRtFXS5O/byd8+RwpHmzM2BPFAUKBQXKtR/6LgcDM9xZoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743678191; c=relaxed/simple;
	bh=q5bh5LsgaugfwqRlbvOXVgseZaVVOjyj0lnP151CgVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0zia+YlpBIYASwLsJPEBP4quPmOtJdf6UUX/AKRa4uwNzRNb2x/hSNB0uM/pd+b4gHyn9q7PUnYo2i/2rR2i2XQrQh7C9GNZ3JePLpMigXYS70w+XETl1wYdF2LQ1kkhPklrR88s1isIvbudN2+sBAEg4pMMDikDlGl7CEx6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvlQjjSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B261C4CEEB;
	Thu,  3 Apr 2025 11:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743678191;
	bh=q5bh5LsgaugfwqRlbvOXVgseZaVVOjyj0lnP151CgVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hvlQjjScYyPIBJiTDhOXnHtTFur9sIjEB854NDKtBy5wPx7ds9sxhK4fHFVy/IIuK
	 wFh9YYsgzWeOCKI+E48VYeOary+Kcs5XKzBsrsq44VAO+m7hU5/Q/SxZPr68suJJaz
	 3Kiu7Y1Zk0euqWQHgfzmug9uAh2V9OS6wpT2S6XD25XfI+5iVryuQ59CIisbyQPn+J
	 ykWW0J4mADgbmfOlTe5wMHxHn7zLWEO7RKKy4PFc6qQhjlMTjmE0r1umBGAGW+Qz7K
	 UbrW0QGwL4a8F9s/9lEjyjV00IjdHXvhTFBuVtBr8a7q6OgwMmd6L5HhPhsymcakfK
	 HqcfqqQc7Hhyw==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72c7336ed99so273111a34.0;
        Thu, 03 Apr 2025 04:03:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPPkNGR11+BUeuUyJrNfmLulMgeuxeK7zamzzPP4TJX3GoOEgj84RaNSSnVueyMAa4/8TgvN/OtrEw0c0=@vger.kernel.org, AJvYcCWHCBVWokaDsPEWrdP/KTHf2hHfwIa4ouiKnA17BLJptyoKtWhAkv3rKpz3hV2tpXa2bbOmI+EicQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoaYJYHHq5j+BzF9KPKqvTCfzQU+M9Iwh65JZ7wj5IuB0cbU0
	tUCMKf/BwYW567mO7v5OpqcRQkbwmuPeoP1mfzJ+JzGk65Hi2VsaVyG2AhOmhLr4CCFohn2joli
	Z072PEWBoefpamE3bstXvVyE//K4=
X-Google-Smtp-Source: AGHT+IFbXUnrtx4yvwJPtJEIbcratnIIi9oeUH4guJ6SiB4gXdA/3KHMDXs4HftPjvjLn0rDDiFtu9F0Prqg0tve9Bc=
X-Received: by 2002:a05:6830:61ca:b0:72b:9d5e:9429 with SMTP id
 46e09a7af769-72e2ee750c1mr1545366a34.12.1743678190389; Thu, 03 Apr 2025
 04:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22640172.EfDdHjke4D@rjwysocki.net> <6ab0531a-d6d8-46ac-9afc-23cf87f37905@arm.com>
In-Reply-To: <6ab0531a-d6d8-46ac-9afc-23cf87f37905@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Apr 2025 13:02:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jmpwyFx-5dcvbjMp8TiyCFxGEgCR-y72ib1=Nob2mTcA@mail.gmail.com>
X-Gm-Features: AQ5f1JrOj3acb2-UTwN0ZdksowWce5FdnHR_w9BbXG7wzpHVkqL4WTqxnjhBnQU
Message-ID: <CAJZ5v0jmpwyFx-5dcvbjMp8TiyCFxGEgCR-y72ib1=Nob2mTcA@mail.gmail.com>
Subject: Re: [RFC][PATCH v0.3 0/6] cpufreq: intel_pstate: Enable EAS on hybrid
 platforms without SMT - alternative
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 12:47=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 3/7/25 19:12, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This is a new take on the "EAS for intel_pstate" work:
> >
> > https://lore.kernel.org/linux-pm/5861970.DvuYhMxLoT@rjwysocki.net/
> >
> > with refreshed preparatory patches and a revised energy model design.
> >
> > The following paragraph from the original cover letter still applies:
> >
> > "The underlying observation is that on the platforms targeted by these =
changes,
> > Lunar Lake at the time of this writing, the "small" CPUs (E-cores), whe=
n run at
> > the same performance level, are always more energy-efficient than the "=
big" or
> > "performance" CPUs (P-cores).  This means that, regardless of the scale=
-
> > invariant utilization of a task, as long as there is enough spare capac=
ity on
> > E-cores, the relative cost of running it there is always lower."
> >
> > However, this time perf domains are registered per CPU and in addition =
to the
> > primary cost component, which is related to the CPU type, there is a sm=
all
> > component proportional to performance whose role is to help balance the=
 load
> > between CPUs of the same type.
> >
> > This is done to avoid migrating tasks too much between CPUs of the same=
 type,
> > especially between E-cores, which has been observed in tests of the pre=
vious
> > iteration of this work.
> >
> > The expected effect is still that the CPUs of the "low-cost" type will =
be
> > preferred so long as there is enough spare capacity on any of them.
> >
> > The first two patches in the series rearrange cpufreq checks related to=
 EAS so
> > that sched_is_eas_possible() doesn't have to access cpufreq internals d=
irectly
> > and patch [3/6] changes those checks to also allow EAS to be used with =
cpufreq
> > drivers that implement internal governors (like intel_pstate).
> >
> > Patches [4-5/6] deal with the Energy Model code.  Patch [4/6] simply re=
arranges
> > it so as to allow the next patch to be simpler and patch [5/6] adds a f=
unction
> > that's used in the last patch.
> >
> > Patch [6/6] is the actual intel_pstate modification which now is signif=
icantly
> > simpler than before because it doesn't need to track the type of each C=
PU
> > directly in order to put into the right perf domain.
> >
> > Please refer to the individual patch changelogs for details.
> >
> > For easier access, the series is available on the experimental/intel_ps=
tate/eas-take2
> > branch in linux-pm.git:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > experimental/intel_pstate/eas-take2
> >
> > or
> >
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
/log/?h=3Dexperimental/intel_pstate/eas-take2
> >
> > Thanks!
> >
>
>
> Hi Rafael,
> as promised I did the same tests as with v0.2, the results are better wit=
h v0.3,
> hard to say though if that is because of the cache-affinity on the P-core=
s.
>
> Interestingly our nosmt Raptor Lake 8+8 should be worse off with its 16 P=
Ds now.
> Maybe, if L2 is shared anyway, one PD for e-cores and per-CPU-PD for P-co=
res
> could be experimented with too (so 4+1+1+1+1 for lunar lake).
>
> Anyway these are the results, again 20 iterations of 5 minutes each:
>
> Firefox YouTube 4K video playback:
> EAS:
> 376.229 +-9.566835596650195
> CAS:
> 661.323 +-18.951739322113248
> (-43.1% energy used with EAS)
> (cf -24.2% energy used with EAS v0.2)
>
> Firefox Web Aquarium 500 fish.
> EAS:
> 331.933 +-10.977847441299437
> CAS:
> 515.594 +-16.997636567737562
> (-35.6% energy used with EAS)
> (Wasn't tested on v0.2, just to see if above was a lucky workload hit.)
>
> Both don't show any performance hit with EAS (FPS are very stable for bot=
h).
> v0.2 results:
> https://lore.kernel.org/lkml/3861524b-b266-4e54-b7ab-fdccbb7b4177@arm.com=
/

Thank you!

