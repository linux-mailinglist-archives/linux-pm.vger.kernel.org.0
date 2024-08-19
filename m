Return-Path: <linux-pm+bounces-12430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC1956C38
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5337B27FB6
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA53F16CD3C;
	Mon, 19 Aug 2024 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv6x9ajr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7A16CD36;
	Mon, 19 Aug 2024 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074464; cv=none; b=OmO+5n5T8UzCnujzf4p8PL0bL0JgC6rl0NyHcUhWl0qcu6PLmECj3b4o7YQsjKNTil9OPc2by+o17EckypUgvIx+46SucfHHOvEHMyobBVvvmovwuaQ555EcOw6mfWJ0tNpWEgyhgoep3I8EfYKpboirgWwfVl/OWoGGmVeAJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074464; c=relaxed/simple;
	bh=8y/P9Aho2Y/6Aze+kcRw469LGcZYm9nqPQL/2mkbaG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lg5exAZSlJQ93KSJGVQsaLA+UCI1GOq1sh6gr1VXv0aiganKd4qRRi84AFvySTEI7Jo+vCYs0ZBH40mKSjOljPqKKCt1raNMVBSY9BviALRNA4d3zsmWxlP94M3KRSoCi0Ckmru7XiL9tli9JraZ792/S7l/mdMWNEjel/xvY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv6x9ajr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E957C4AF18;
	Mon, 19 Aug 2024 13:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724074464;
	bh=8y/P9Aho2Y/6Aze+kcRw469LGcZYm9nqPQL/2mkbaG8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nv6x9ajroLDSXvgCtPgkGUpSt1QodVUdF4D0d0OW86/KzXZ7mgxaHvQGD6OonJtID
	 UbLuAO0yXH4680MhmFj23zCzad8OpZTdnrarWYPkSLBXu6qHS1dEYQnwHpH/knH3N4
	 gaX44t0nn4SkqsweVB0ZjR0CMNrh4sM5uviz92EjvLX5BFHKrGDrQwNmXjIneo3cf2
	 j0P4xczGHWmZ3EPu0s+ltsPjpcs81pnbBBnWCr9iTmSE9pziecBO4EuRoCWFgYNCLV
	 TQ+2OZXqyrf+V9LTUDDlBe5Nrb4TvF1/vAsZ9ofDRPZRLcUTBxldCiKNBJHxMU0VW2
	 hmQd/VwjO70Sw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2610c095ea1so599550fac.3;
        Mon, 19 Aug 2024 06:34:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnYmT1hlbOUL9NolGVo88SaI/vPYykoFgYHgZ1qwUL3sRr5SkClv15hYBhqwsNSM/JMi3cQeEn+34=@vger.kernel.org, AJvYcCVcYTj3yhljsAXhA5S5fokHwAz99Gr/LnJ+WPvwOen3ldoQZx9b4pVnqh2NTEPYMqprpURzRChdD3Yly6o=@vger.kernel.org, AJvYcCXTZTrEtCN/+AEeAszqNliCzlbXg3fb3HfLqVAtmANDjHDR0ukWktTllKBPs9Z18aFSXtsvFDh0Y6q2ffuDaSEAuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HDNqrQ21ioBw/mGczI93zjxpiPMt6IjkMFn/H3yZkqOBe6dS
	LyVoyGD2m1zBYoDTjGeVqNCaZsxCDbsUu504NXz1+qmPWnQeNbgbU/yNvJ7BqFmgaapX3s43eya
	uKm5GZgR68VvibQE6WNqDXJOrP2Y=
X-Google-Smtp-Source: AGHT+IG7lIsUgbZpsN2NeJZVUjHyQudDlOMfBzQWLd8JkIGPZ+m4PgGyIGoOfXZvVfxDJHcAUIxvRT/FY15g5ZUt2UA=
X-Received: by 2002:a05:6870:524f:b0:260:ccfd:b26f with SMTP id
 586e51a60fabf-2701c52f1f6mr6364546fac.6.1724074463647; Mon, 19 Aug 2024
 06:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730044917.4680-1-Dhananjay.Ugwekar@amd.com>
 <20240730044917.4680-3-Dhananjay.Ugwekar@amd.com> <CAJZ5v0h4GAVCpUnbCMHMophsSZ522kkReAbUMdfFgRJfd0vHkw@mail.gmail.com>
 <3c6e2fb3-4b51-4cda-a5ca-71bed94d47b9@amd.com>
In-Reply-To: <3c6e2fb3-4b51-4cda-a5ca-71bed94d47b9@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Aug 2024 15:34:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gxD_nUabYLKoO2NoQ-TTYd5-4mocyri6M4g0xZ+4sd2A@mail.gmail.com>
Message-ID: <CAJZ5v0gxD_nUabYLKoO2NoQ-TTYd5-4mocyri6M4g0xZ+4sd2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powercap/intel_rapl: Fix the energy-pkg event for
 AMD CPUs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	rui.zhang@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	ananth.narayan@amd.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com, 
	ravi.bangoria@amd.com, Michael Larabel <michael@michaellarabel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:18=E2=80=AFPM Dhananjay Ugwekar
<Dhananjay.Ugwekar@amd.com> wrote:
>
> Hello Rafael,
>
> On 8/2/2024 6:05 PM, Rafael J. Wysocki wrote:
> > On Tue, Jul 30, 2024 at 6:53=E2=80=AFAM Dhananjay Ugwekar
> > <Dhananjay.Ugwekar@amd.com> wrote:
> >>
> >> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 le=
af"),
> >> on AMD processors that support extended CPUID leaf 0x80000026, the
> >> topology_logical_die_id() macros, no longer returns package id, instea=
d it
> >> returns the CCD (Core Complex Die) id. This leads to the energy-pkg
> >> event scope to be modified to CCD instead of package.
> >>
> >> For more historical context, please refer to commit 32fb480e0a2c
> >> ("powercap/intel_rapl: Support multi-die/package"), which initially ch=
anged
> >> the RAPL scope from package to die for all systems, as Intel systems
> >> with Die enumeration have RAPL scope as die, and those without die
> >> enumeration are not affected. So, all systems(Intel, AMD, Hygon), work=
ed
> >> correctly with topology_logical_die_id() until recently, but this chan=
ged
> >> after the "0x80000026 leaf" commit mentioned above.
> >>
> >> Future multi-die Intel systems will have package scope RAPL counters,
> >> but they will be using TPMI RAPL interface, which is not affected by
> >> this change.
> >>
> >> Replacing topology_logical_die_id() with topology_physical_package_id(=
)
> >> conditionally only for AMD and Hygon fixes the energy-pkg event.
> >>
> >> On an AMD 2 socket 8 CCD Zen4 server:
> >>
> >> Before:
> >>
> >> linux$ ls /sys/class/powercap/
> >> intel-rapl      intel-rapl:4    intel-rapl:8:0  intel-rapl:d
> >> intel-rapl:0    intel-rapl:4:0  intel-rapl:9    intel-rapl:d:0
> >> intel-rapl:0:0  intel-rapl:5    intel-rapl:9:0  intel-rapl:e
> >> intel-rapl:1    intel-rapl:5:0  intel-rapl:a    intel-rapl:e:0
> >> intel-rapl:1:0  intel-rapl:6    intel-rapl:a:0  intel-rapl:f
> >> intel-rapl:2    intel-rapl:6:0  intel-rapl:b    intel-rapl:f:0
> >> intel-rapl:2:0  intel-rapl:7    intel-rapl:b:0
> >> intel-rapl:3    intel-rapl:7:0  intel-rapl:c
> >> intel-rapl:3:0  intel-rapl:8    intel-rapl:c:0
> >>
> >> After:
> >>
> >> linux$ ls /sys/class/powercap/
> >> intel-rapl  intel-rapl:0  intel-rapl:0:0  intel-rapl:1  intel-rapl:1:0
> >>
> >> Only one sysfs entry per-event per-package is created after this chang=
e.
> >>
> >> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x8000=
0026 leaf")
> >> Reported-by: Michael Larabel <michael@michaellarabel.com>
> >> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> >> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> >> ---
> >> Changes in v2:
> >> * Updated scope description comment, commit log
> >> * Rename rapl_pmu_is_pkg_scope() to rapl_msrs_are_pkg_scope()
> >> * Check topology_logical_(die/package)_id return value
> >
> > This patch does not depend on the first one in the series if I'm not
> > mistaken, in which case I can pick it up separately if you want me to
> > do that, so please let me know.
>
> Sorry for the late reply, was out sick,
>
> Yes, please pick this patch separately, it is independent from the first =
one.

OK, applied as 6.12 material.

Thanks!

