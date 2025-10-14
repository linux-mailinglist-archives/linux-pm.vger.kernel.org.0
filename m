Return-Path: <linux-pm+bounces-36089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D87DBDAD72
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 19:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F00424E4D49
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE54296BA7;
	Tue, 14 Oct 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWweratv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2961724DCE6
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464259; cv=none; b=LO9UdCCcgUm2XjxO5w8znZWYW9uovqQmC9ospsVWRSgWyfMdhNrsXTwrL0zHExMC2nkFZ5RQOI9y/ldXaQ0ROsRu7bMoEcA2ABbXrnXV+2i/LLqKkL0QdRKt7TyW1ZQ0RtXzBzfyNDHisnhoEU2HiXBrxJ9rKqYcSa/b+Ec0sxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464259; c=relaxed/simple;
	bh=slG/K1LK3jDPN7bMCe1cdq76p5Q58zNYcL/R64tKB5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOmRkMRBrsJrK9f+0A10TscgwgB6B36jE24AauEMylmw4Gxbj603/V/OQ7D+qdRhiVm4dlhiYQeeZcGB5XV2fppF4kNuJlxHXmpvUdZSMxpzZ9EdKjHKhEoBpdjfqXVajnonGaX5ofksv8GZpWPZB3d00YFcpVicx3bDBFQbhcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWweratv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3722C113D0
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760464259;
	bh=slG/K1LK3jDPN7bMCe1cdq76p5Q58zNYcL/R64tKB5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gWweratvs24MkN8dk/DTKTsF3TYvqt7WKebivyeImKfeJWXuqB2NDsaE5P6g1gFTe
	 3vX0dZ3L2FeiQ53YgqlZk6Aib6ToDPuTHCXkNATAA69sCCIXHV3vWAH8iRJdhUtJJh
	 YFYiem3eRA2lljWPF09Iwop+RoByg0LFQMeqyNyYC4ZeInIsZAUzNC+cIdlVa7hV7z
	 nYdsyFk5fkrHV4km8EEALtI9YSFMAiASybBWFvSGbtNYV2seWy+sIXHF0FEmU15+Ls
	 qKCUkzuRBrL340sZnO+0Kt3ySDSUQjy9rwkT1FNq4DEe6dhLjF6zRMsUE2t9WgS23s
	 fx5SMj5DuUGnw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-43f696ebf8eso1379904b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 10:50:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWp/zaTzgsj/hKkP57FecJtqU287D/X5FjfijNw3ukrM7tAOaf96dORDGTSDHulb/15SzkskKLG7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYroLWGrLmkPPMsBBcr38DgE556IKoGxzVMsZT8jBQF3ISSynr
	eZY3Y0lG9n4LnD73rYV+0NOfhNueewsG4b0GgpUAhw0gXxLndW+3xrilRGxfby2vwLBQXW+z6TL
	o1rm1vYNLUx5Mg1SwLirQrr+shdU4DkY=
X-Google-Smtp-Source: AGHT+IFeHyWlJCpk5OxdGn9F3Y7RBNB9maGg+aRpRVkhQzD2s3/TcUwwfmERHDKgwiJe1ogHsZswgtfzCff3gi6cwDg=
X-Received: by 2002:a05:6808:188e:b0:43f:9c1d:ae76 with SMTP id
 5614622812f47-4417b1ca926mr11089161b6e.0.1760464258227; Tue, 14 Oct 2025
 10:50:58 -0700 (PDT)
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
 <e9eb077b-3253-49be-b997-a07dcde86cdc@arm.com> <CAJZ5v0hD-78Gbq1pJGsoOBwpTsK=NABdR91t4S8NbWk4FEmEJg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hD-78Gbq1pJGsoOBwpTsK=NABdR91t4S8NbWk4FEmEJg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Oct 2025 19:50:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_i9QwSBjLB28+Y_-1QkopK83QYs-QzdBn=5Z+Z-th8A@mail.gmail.com>
X-Gm-Features: AS18NWBniOBF5qlmqzsohVDMVKSnLcDqZ6FUdicLzX5ndFEZoxKww6hkNDwTD_g
Message-ID: <CAJZ5v0h_i9QwSBjLB28+Y_-1QkopK83QYs-QzdBn=5Z+Z-th8A@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:32=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Oct 14, 2025 at 7:20=E2=80=AFPM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 10/14/25 16:54, Rafael J. Wysocki wrote:
> > > On Tue, Oct 14, 2025 at 5:11=E2=80=AFPM Christian Loehle
> > > <christian.loehle@arm.com> wrote:
> > >>
> > >> On 10/14/25 12:55, Sergey Senozhatsky wrote:
> > >>> On (25/10/14 11:25), Christian Loehle wrote:
> > >>>> On 10/14/25 11:23, Sergey Senozhatsky wrote:
> > >>>>> On (25/10/14 10:50), Christian Loehle wrote:
> > >>>>>>> Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid us=
ing
> > >>>>>>> invalid recent intervals data") doesn't address the problems we=
 are
> > >>>>>>> observing.  Revert seems to be bringing performance metrics bac=
k to
> > >>>>>>> pre-regression levels.
> > >>>>>>
> > >>>>>> Any details would be much appreciated.
> > >>>>>> How do the idle state usages differ with and without
> > >>>>>> "cpuidle: menu: Avoid discarding useful information"?
> > >>>>>> What do the idle states look like in your platform?
> > >>>>>
> > >>>>> Sure, I can run tests.  How do I get the numbers/stats
> > >>>>> that you are asking for?
> > >>>>
> > >>>> Ideally just dump
> > >>>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
> > >>>> before and after the test.
> > >>>
> > >>> OK, got some data for you.  The terminology being used here is as f=
ollows:
> > >>>
> > >>> - 6.1-base
> > >>>   is 6.1 stable with a9edb700846 "cpuidle: menu: Avoid discarding u=
seful information"
> > >>>
> > >>> - 6.1-base-fixup
> > >>>   is 6.1 stable with a9edb700846 and fa3fa55de0d6 "cpuidle: governo=
rs:
> > >>>   menu: Avoid using invalid recent intervals data" cherry-pick
> > >>>
> > >>> - 6.1-revert
> > >>>   is 6.1 stable with a9edb700846 reverted (and no fixup commit, obv=
iously)
> > >>>
> > >>> Just to show the scale of regression, results of some of the benchm=
arks:
> > >>>
> > >>>   6.1-base:           84.5
> > >>>   6.1-base-fixup:     76.5
> > >>>   6.1-revert:         59.5
> > >>>
> > >>>   (lower is better, 6.1-revert has the same results as previous sta=
ble
> > >>>   kernels).
> > >> This immediately threw me off.
> > >> The fixup was written for a specific system which had completely bro=
ken
> > >> cpuidle. It shouldn't affect any sane system significantly.
> > >> I double checked the numbers and your system looks fine, in fact non=
e of
> > >> the tests had any rejected cpuidle occurrences. So functionally base=
 and
> > >> base-fixup are identical for you. The cpuidle numbers are also reaso=
nably
> > >> 'in the noise', so just for the future some stats would be helpful o=
n those
> > >> scores.
> > >>
> > >> I can see a huge difference between base and revert in terms of cpui=
dle,
> > >> so that's enough for me to take a look, I'll do that now.
> > >> (6.1-revert has more C3_ACPI in favor of C1_ACPI.)
> > >>
> > >> (Also I can't send this email without at least recommending teo inst=
ead of menu
> > >> for your platform / use-cases, if you deemed it unfit I'd love to kn=
ow what
> > >> didn't work for you!)
> > >
> > > Well, yeah.
> > >
> > > So I've already done some analysis.
> > >
> > > There are 4 C-states, POLL, C1, C6 and C10 (at least that's what the
> > > MWAIT hints tell me).
> > >
> > > This is how many times each of them was requested during the workload
> > > run on base 6.1.y:
> > >
> > > POLL: 21445
> > > C1: 2993722
> > > C6: 767029
> > > C10: 736854
> > >
> > > and in percentage of the total idle state requests:
> > >
> > > POLL: 0,47%
> > > C1: 66,25%
> > > C6: 16,97%
> > > C10: 16,31%
> > >
> > > With the problematic commit reverted, this became
> > >
> > > POLL: 16092
> > > C1: 2452591
> > > C6: 750933
> > > C10: 1150259
> > >
> > > and (again) in percentage of the total:
> > >
> > > POLL: 0,37%
> > > C1: 56,12%
> > > C6: 17,18%
> > > C10: 26,32%
> > >
> > > Overall, POLL is negligible and the revet had no effect on the number
> > > of times C6 was requested.  The difference is for C1 and C10 and it's
> > > 10% in both cases, but going in opposite directions so to speak: C1
> > > was requested 10% less and C10 was requested 10% more after the
> > > revert.
> > >
> > > Let's see how this corresponds to the residency numbers.
> > >
> > > For base 6.1.y there was
> > >
> > > POLL: 599883
> > > C1: 732303748
> > > C6: 576785253
> > > C10: 2020491489
> > >
> > > and in percentage of the total
> > >
> > > POLL: 0,02%
> > > C1: 21,99%
> > > C6: 17,32%
> > > C10: 60,67%
> > >
> > > After the revert it became
> > >
> > > POLL: 469451
> > > C1: 517623465
> > > C6: 508945687
> > > C10: 2567701673
> > >
> > > and in percentage of the total
> > >
> > > POLL: 0,01%
> > > C1: 14,40%
> > > C6: 14,16%
> > > C10: 71,43%
> > >
> > > so with the revert the CPUs spend around 7% more time in deep idle
> > > states (C6 and C10 combined).
> > >
> > > I have to say that this is consistent with the intent of the
> > > problematic commit, which is to reduce the number of times the deepes=
t
> > > idle state is requested although it is likely to be too deep.
> > >
> > > However, on the system in question this somehow causes performance to
> > > drop significantly (even though shallow idle states are used more
> > > often which should result in lower average idle state exit latency an=
d
> > > better performance).
> > >
> > > One possible explanation is that this somehow affects turbo
> > > frequencies.  That is, requesting shallower idle states on idle CPUs
> > > prevents the other CPUs from getting sufficiently high turbo.
> > >
> > > Sergey, can you please run the workload under turbostat on the base
> > > 6.1.y and on 6.1.y with the problematic commit reverted and send the
> > > turbostat output from both runs (note: turbostat needs to be run as
> > > root)?
> >
> > That's the most plausible explanation and would also be my guess.
> > FWIW most of the C3_ACPI (=3D=3D C10) with revert are objectively wrong
> > with 78% idle misses (they were already pretty high with base around 72=
.5%).
>
> Yeah, so the commit in question works as intended and from a purely
> cpuidle standpoint it is an improvement.
>
> However, for the system/workload combination in question, cpuidle
> really is used as a means to crank up single-thread CPU performance.
>
> Honestly, I'm not really sure what to do about this.  It looks like
> this workload might benefit from selecting C6 more often, but I'm not
> quite sure how to make that happen in a generic way.  Also, it may
> regress other workloads.

Well, maybe the only thing that needs to be done is backporting

8de7606f0fe2 cpuidle: menu: Eliminate outliers on both ends of the sample s=
et

(along with the dependencies) because if the workload tends to produce
outliers on the low end of the idle duration data, it will effectively
cause C1 to be selected more often after commit 85975daeaa4d
("cpuidle: menu: Avoid discarding useful information").

