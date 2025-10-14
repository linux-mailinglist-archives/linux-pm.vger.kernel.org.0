Return-Path: <linux-pm+bounces-36088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF9DBDAC8E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 19:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53143A9303
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 17:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DF225D1E9;
	Tue, 14 Oct 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxKRHTG5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844633A8F7
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760463189; cv=none; b=exiCyfG3Ml4RrhUeNOptsANB8yZPGfl4NIuGRQnZihnt5C1/KkMgfKMchhLAhH/xuDwpHOoiWckIBGZ3eos8U2cDOB0aoUj91nl9lW1wkGsPRVQJpUKHHM9FHnDfLsTC/sdCIuht5G9KP6hq1NTvw1jLEuhnOw2/KH1VDgw81Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760463189; c=relaxed/simple;
	bh=yJ3DupAKeXPcuj2FkBEJ1gpETG5eMX0Imv5KnzPSWM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjSA2to1SVbtFaXMeLeI66nUwjwmr0WSLyQ9NouuYIipjDzUBYXQZqNfihDUtt3DbfdPwKl1ZDeVfp0gjuX5RdOwx79z6AAyRQn2ZoMYHenun1TkXvCIuHT3/JAO+qlcrfsu8hEFG5YOBWJpnv9Ay2htAH9higqHpUgA45O14HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxKRHTG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8C6C19423
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760463189;
	bh=yJ3DupAKeXPcuj2FkBEJ1gpETG5eMX0Imv5KnzPSWM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kxKRHTG5ej32UJM4USpSrZgRYVGxC6ddT55Q+R6CzmVhbuFigPMAAmQpHDIPwPtgx
	 MvAO+HiW3Q+RMt0FfV758Yl19RtAtz7VzcUVxCArNul+sRAcCZbGAI1aJ9svFOdGoJ
	 cVU3MbGId5RriwMaF3DdwbFpYurKkmtLEBlZsDXcOCVn/p5QiEgeqyGRcIy5k3qkDH
	 pDWQZbZh67cmnc6854J39D4Dn3Ckaib4qRsPjeOLcVYc9cG48OHkkh3Y9Mvqkp+QoM
	 Ur6Y6dQeZH/KjFzQtsZE7s0U1abphcZJDKTAQKhyeE+Bkn/YWV4uY2YRPsSRRQu+/Q
	 hJTOACcDUGYOQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-44181f9e5b4so2435549b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 10:33:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUG3gtF2jIWL0VIWJExdcJ7YNhq+L1N7uUUPCX0DEq3ZxOQ5dlTNSbeq8DlownGHJI1e6qHKB8+Iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyaESHZYTiXU5hELbUvjY9UAasHa2dd07O+kjnIrOq06v+QW4N
	MpjNQ0ApEqEn/E9oa7J7aDvj74RL8JPGEr3JCrisJ83U158S2eEGiR0QzaSknzjphMLksSkXK+a
	y6gCwke/yNVeeHAu8hURYJPCOTzAWtIg=
X-Google-Smtp-Source: AGHT+IG3oBdcKjeJtPrnw94Xsg+JIhV4JwEkIp7JEg/9LBfppH9TA0j1KP/Tp1E/2Kz9Wt05VEai0poC1fcnREZlDVQ=
X-Received: by 2002:a05:6808:3bc:b0:441:c604:f417 with SMTP id
 5614622812f47-441c604f61dmr4573831b6e.65.1760463188281; Tue, 14 Oct 2025
 10:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com> <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <e9eb077b-3253-49be-b997-a07dcde86cdc@arm.com>
In-Reply-To: <e9eb077b-3253-49be-b997-a07dcde86cdc@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Oct 2025 19:32:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hD-78Gbq1pJGsoOBwpTsK=NABdR91t4S8NbWk4FEmEJg@mail.gmail.com>
X-Gm-Features: AS18NWCSwjPs1NML2gstSijE6v5_fcgrDQzRV2IewjSSHBkvsFGcBNOnFXRE25Y
Message-ID: <CAJZ5v0hD-78Gbq1pJGsoOBwpTsK=NABdR91t4S8NbWk4FEmEJg@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:20=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/14/25 16:54, Rafael J. Wysocki wrote:
> > On Tue, Oct 14, 2025 at 5:11=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 10/14/25 12:55, Sergey Senozhatsky wrote:
> >>> On (25/10/14 11:25), Christian Loehle wrote:
> >>>> On 10/14/25 11:23, Sergey Senozhatsky wrote:
> >>>>> On (25/10/14 10:50), Christian Loehle wrote:
> >>>>>>> Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid usin=
g
> >>>>>>> invalid recent intervals data") doesn't address the problems we a=
re
> >>>>>>> observing.  Revert seems to be bringing performance metrics back =
to
> >>>>>>> pre-regression levels.
> >>>>>>
> >>>>>> Any details would be much appreciated.
> >>>>>> How do the idle state usages differ with and without
> >>>>>> "cpuidle: menu: Avoid discarding useful information"?
> >>>>>> What do the idle states look like in your platform?
> >>>>>
> >>>>> Sure, I can run tests.  How do I get the numbers/stats
> >>>>> that you are asking for?
> >>>>
> >>>> Ideally just dump
> >>>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
> >>>> before and after the test.
> >>>
> >>> OK, got some data for you.  The terminology being used here is as fol=
lows:
> >>>
> >>> - 6.1-base
> >>>   is 6.1 stable with a9edb700846 "cpuidle: menu: Avoid discarding use=
ful information"
> >>>
> >>> - 6.1-base-fixup
> >>>   is 6.1 stable with a9edb700846 and fa3fa55de0d6 "cpuidle: governors=
:
> >>>   menu: Avoid using invalid recent intervals data" cherry-pick
> >>>
> >>> - 6.1-revert
> >>>   is 6.1 stable with a9edb700846 reverted (and no fixup commit, obvio=
usly)
> >>>
> >>> Just to show the scale of regression, results of some of the benchmar=
ks:
> >>>
> >>>   6.1-base:           84.5
> >>>   6.1-base-fixup:     76.5
> >>>   6.1-revert:         59.5
> >>>
> >>>   (lower is better, 6.1-revert has the same results as previous stabl=
e
> >>>   kernels).
> >> This immediately threw me off.
> >> The fixup was written for a specific system which had completely broke=
n
> >> cpuidle. It shouldn't affect any sane system significantly.
> >> I double checked the numbers and your system looks fine, in fact none =
of
> >> the tests had any rejected cpuidle occurrences. So functionally base a=
nd
> >> base-fixup are identical for you. The cpuidle numbers are also reasona=
bly
> >> 'in the noise', so just for the future some stats would be helpful on =
those
> >> scores.
> >>
> >> I can see a huge difference between base and revert in terms of cpuidl=
e,
> >> so that's enough for me to take a look, I'll do that now.
> >> (6.1-revert has more C3_ACPI in favor of C1_ACPI.)
> >>
> >> (Also I can't send this email without at least recommending teo instea=
d of menu
> >> for your platform / use-cases, if you deemed it unfit I'd love to know=
 what
> >> didn't work for you!)
> >
> > Well, yeah.
> >
> > So I've already done some analysis.
> >
> > There are 4 C-states, POLL, C1, C6 and C10 (at least that's what the
> > MWAIT hints tell me).
> >
> > This is how many times each of them was requested during the workload
> > run on base 6.1.y:
> >
> > POLL: 21445
> > C1: 2993722
> > C6: 767029
> > C10: 736854
> >
> > and in percentage of the total idle state requests:
> >
> > POLL: 0,47%
> > C1: 66,25%
> > C6: 16,97%
> > C10: 16,31%
> >
> > With the problematic commit reverted, this became
> >
> > POLL: 16092
> > C1: 2452591
> > C6: 750933
> > C10: 1150259
> >
> > and (again) in percentage of the total:
> >
> > POLL: 0,37%
> > C1: 56,12%
> > C6: 17,18%
> > C10: 26,32%
> >
> > Overall, POLL is negligible and the revet had no effect on the number
> > of times C6 was requested.  The difference is for C1 and C10 and it's
> > 10% in both cases, but going in opposite directions so to speak: C1
> > was requested 10% less and C10 was requested 10% more after the
> > revert.
> >
> > Let's see how this corresponds to the residency numbers.
> >
> > For base 6.1.y there was
> >
> > POLL: 599883
> > C1: 732303748
> > C6: 576785253
> > C10: 2020491489
> >
> > and in percentage of the total
> >
> > POLL: 0,02%
> > C1: 21,99%
> > C6: 17,32%
> > C10: 60,67%
> >
> > After the revert it became
> >
> > POLL: 469451
> > C1: 517623465
> > C6: 508945687
> > C10: 2567701673
> >
> > and in percentage of the total
> >
> > POLL: 0,01%
> > C1: 14,40%
> > C6: 14,16%
> > C10: 71,43%
> >
> > so with the revert the CPUs spend around 7% more time in deep idle
> > states (C6 and C10 combined).
> >
> > I have to say that this is consistent with the intent of the
> > problematic commit, which is to reduce the number of times the deepest
> > idle state is requested although it is likely to be too deep.
> >
> > However, on the system in question this somehow causes performance to
> > drop significantly (even though shallow idle states are used more
> > often which should result in lower average idle state exit latency and
> > better performance).
> >
> > One possible explanation is that this somehow affects turbo
> > frequencies.  That is, requesting shallower idle states on idle CPUs
> > prevents the other CPUs from getting sufficiently high turbo.
> >
> > Sergey, can you please run the workload under turbostat on the base
> > 6.1.y and on 6.1.y with the problematic commit reverted and send the
> > turbostat output from both runs (note: turbostat needs to be run as
> > root)?
>
> That's the most plausible explanation and would also be my guess.
> FWIW most of the C3_ACPI (=3D=3D C10) with revert are objectively wrong
> with 78% idle misses (they were already pretty high with base around 72.5=
%).

Yeah, so the commit in question works as intended and from a purely
cpuidle standpoint it is an improvement.

However, for the system/workload combination in question, cpuidle
really is used as a means to crank up single-thread CPU performance.

Honestly, I'm not really sure what to do about this.  It looks like
this workload might benefit from selecting C6 more often, but I'm not
quite sure how to make that happen in a generic way.  Also, it may
regress other workloads.

> I'll leave this here for easier following:

Thanks!

> =3D=3D=3D=3D=3D 6.1-base: after minus before deltas (aggregated across CP=
Us) =3D=3D=3D=3D=3D
> +---------+-------------+------------+--------------+---------------+----=
--------+------------+---------+
> |   state | time_diff_s | usage_diff | avg_resid_us | rejected_diff | abo=
ve_diff | below_diff | share_% |
> +---------+-------------+------------+--------------+---------------+----=
--------+------------+---------+
> |    POLL |       0.600 |     21,445 |         28.0 |             0 |    =
      0 |     19,846 |    0.02 |
> | C1_ACPI |     732.304 |  2,993,722 |        244.6 |             0 |    =
  3,816 |    280,613 |   21.99 |
> | C2_ACPI |     576.785 |    767,029 |        752.0 |             0 |    =
272,105 |        453 |   17.32 |
> | C3_ACPI |   2,020.491 |    736,854 |      2,742.1 |             0 |    =
534,424 |          0 |   60.67 |
> |   TOTAL |   3,330.180 |  4,519,050 |              |             0 |    =
810,345 |    300,912 |  100.00 |
> +---------+-------------+------------+--------------+---------------+----=
--------+------------+---------+
>
> =3D=3D=3D=3D=3D 6.1-revert: after minus before deltas (aggregated across =
CPUs) =3D=3D=3D=3D=3D
> +---------+-------------+------------+--------------+---------------+----=
--------+------------+---------+
> |   state | time_diff_s | usage_diff | avg_resid_us | rejected_diff | abo=
ve_diff | below_diff | share_% |
> +---------+-------------+------------+--------------+---------------+----=
--------+------------+---------+
> |    POLL |       0.469 |     16,092 |         29.2 |             0 |    =
      0 |     14,855 |    0.01 |
> | C1_ACPI |     517.623 |  2,452,591 |        211.1 |             0 |    =
  4,109 |    150,500 |   14.40 |
> | C2_ACPI |     508.946 |    750,933 |        677.8 |             0 |    =
327,457 |        427 |   14.16 |
> | C3_ACPI |   2,567.702 |  1,150,259 |      2,232.3 |             0 |    =
895,311 |          0 |   71.43 |
> |   TOTAL |   3,594.740 |  4,369,875 |              |             0 |  1,=
226,877 |    165,782 |  100.00 |
> +---------+-------------+------------+--------------+---------------+----=
--------+------------+---------+
>
> =3D=3D=3D=3D=3D 6.1-revert minus 6.1-base (state-by-state deltas of the d=
eltas) =3D=3D=3D=3D=3D
> +---------+-----------+----------+----------+---------------+----------+-=
---------+
> |   state | =CE=94share_pp |   =CE=94usage |  =CE=94time_s | =CE=94avg_re=
sid_us |   =CE=94above |   =CE=94below |
> +---------+-----------+----------+----------+---------------+----------+-=
---------+
> |    POLL |     -0.00 |   -5,353 |   -0.130 |           1.2 |       +0 | =
  -4,991 |
> | C1_ACPI |     -7.59 | -541,131 | -214.680 |         -33.6 |     +293 | =
-130,113 |
> | C2_ACPI |     -3.16 |  -16,096 |  -67.840 |         -74.2 |  +55,352 | =
     -26 |
> | C3_ACPI |    +10.76 | +413,405 |  547.210 |        -509.8 | +360,887 | =
      +0 |
> |   TOTAL |     +0.00 | -149,175 |  264.560 |               | +416,532 | =
-135,130 |
> +---------+-----------+----------+----------+---------------+----------+-=
---------+
>

