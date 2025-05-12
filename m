Return-Path: <linux-pm+bounces-27058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3865AB3FF7
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 19:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9A319E7095
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 17:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21942550C7;
	Mon, 12 May 2025 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6K52Vcn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786A254B10;
	Mon, 12 May 2025 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072064; cv=none; b=EToSbLoUpoNSq63YmSxkqECzooZL6r69omHUoFflqzY4AaiX3qenj0flMKMQnsMEJ+4OQQOo+elq1DxZB6MpniUDEHHDOP8mJlU9z1JAxFimoRi29EBOD7k8vLvq0l20j3/eTX7OfisLZFTOtvL7Am15Cc8FYo5I8FqApDfPOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072064; c=relaxed/simple;
	bh=KMHJCxeZo/UXx8HRY9BqAs3Dv3M39g0GQgVDS7auMq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUuBvy4/UozUtwEYORo7G7cQlh/B6NMaRRpd27Kev3GtMgZerhCWnurf1UaaReOG+fOEfu2qClNkiy6ZzxMmcvGUlwBogc+E85yX1yLlw6DshYKpe2btE93Oh3NhZXNcXTTemjUaPOcJN2kjfXKqeVgPcJZy1niHv/FCY34aK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6K52Vcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384D4C4CEE7;
	Mon, 12 May 2025 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747072064;
	bh=KMHJCxeZo/UXx8HRY9BqAs3Dv3M39g0GQgVDS7auMq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j6K52Vcni4oQTjA4JXqqw7JdtQ+dEKJXMNTKwNnrzcMF8Jjy3AQNJrgf+FiYBJ+Wa
	 GX6sTkizWY4Ls932RHWiU4TKArsMMdM9M5vG8WBKPmY4X4gO1h3QA/R7PZNXgPvwV5
	 0CPZUJUJT1B9ZH2GTJflWtyASZtx+WIHAxr9llv1y7qA5XPo1XkaUIEaIALQYY+nB2
	 ngGLTBpOCeZFeI7Bd3VJGHWkVsZpwAz1srLJ9JV0skwEqM6lyuXS0ITDWV7o564vO0
	 No0RDwvgv677f1qLYOVlx+oanV42Fln0xv8kjjBTat1Yic4i+6408iIaNsIDsD1j4R
	 tlQ3rCWiuAwUg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c12b7af278so3582371fac.0;
        Mon, 12 May 2025 10:47:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUX6INz+hvCZ8ExWPb8P6mnFTLv5yu6M2IVEsNMPb6F43bUQY/5CORR73p2JnauwNtDjgN64zt4XBJ64f8=@vger.kernel.org, AJvYcCVlihiPKqcS+9vvkb6gNqHrIWbDXcyYz5qkWz25LyNqSjQ3/1KOsL+zxMSMd4sn9kzOSiIw8JHwcr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMuayPDHmyCABBrIoMxMR3ja1fEaoYqvo7aNZkImtK4sdxd8dj
	RlGcviAzOKNi7NTOP36q4daTKtuwpGM3sm3nckdOZoyddvcHxgXpQ7mQnoX5yHLYyKf3EVRaIe6
	B6qydz2EMBs9QNKu5tzDJ3xSP2AM=
X-Google-Smtp-Source: AGHT+IH/V8Gnkd79fem7lYHyybQagokw5bFc4Y4Gj8H2odDzmVBXsAQJFocZpH8EypVZhnlEKz6XxV0Nlnau49/chdQ=
X-Received: by 2002:a05:6871:d302:b0:2d4:e8ce:7bcc with SMTP id
 586e51a60fabf-2e005590c2dmr259051fac.8.1747072063547; Mon, 12 May 2025
 10:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2999205.e9J7NaK4W3@rjwysocki.net> <CGME20250509234915eucas1p2846ecef88f268d78ab2e96d4a67002b0@eucas1p2.samsung.com>
 <2317800.iZASKD2KPV@rjwysocki.net> <1bf3df62-0641-459f-99fc-fd511e564b84@samsung.com>
 <CAJZ5v0j_fFk=EX0Z9_w1twQH-FpntHJvr4d0WSMBM6PevfEqNg@mail.gmail.com>
 <c00ec721-1193-4cfb-87ec-fd98f215720e@samsung.com> <CAJZ5v0iLr3JZ49gX9XbkjPNr_wRDMyAtMZDZ6Aoxz1KgQZ_moA@mail.gmail.com>
 <70cadfd8-8d5c-4685-b3d0-23cde6edc522@arm.com>
In-Reply-To: <70cadfd8-8d5c-4685-b3d0-23cde6edc522@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 May 2025 19:47:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jVy1DeiRgDdUG0q--7NTi26yYjuezL3it641pQcjyN9g@mail.gmail.com>
X-Gm-Features: AX0GCFtfIQeIlS7QjUSp-aqudBgZpWlJjMa9bgMEXUSgjAefwJiVcbkdLEN-VlI
Message-ID: <CAJZ5v0jVy1DeiRgDdUG0q--7NTi26yYjuezL3it641pQcjyN9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] cpufreq/sched: Move cpufreq-specific EAS checks to cpufreq
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 7:24=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 12/05/2025 14:53, Rafael J. Wysocki wrote:
> > On Mon, May 12, 2025 at 8:48=E2=80=AFAM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >>
> >> On 10.05.2025 13:31, Rafael J. Wysocki wrote:
> >>> On Sat, May 10, 2025 at 1:49=E2=80=AFAM Marek Szyprowski
> >>> <m.szyprowski@samsung.com> wrote:
> >>>> On 06.05.2025 22:37, Rafael J. Wysocki wrote:
> >>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> [...]
>
> >>>>    *** DEADLOCK ***
> >>> Well, it turns out that trying to acquire policy->rwsem under
> >>> sched_domains_mutex is a bad idea.  It was added to
> >>> cpufreq_policy_is_good_for_eas() to address a theoretical race, so it
> >>> can be dropped safely.  A theoretical race is better than a real
> >>> deadlock.
> >>>
> >>> Please test the attached patch.
> >>
> >> This fixed the observed issue. Thanks!
> >>
> >> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> > Thanks for the confirmation!
>
> See this on my Hikey 960 as well. I was wondering why Christian L. and I
> didn't catch this with RFT v1.0 (*) on i7-13700K.
>
> But it looks like that
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/l=
og/?h=3Dexperimental/intel_pstate/eas-take2-extended
>
> mentioned in the patch-header of (*) didn't have this line in its
>
> commit 9ad047cade6b ("cpufreq/sched: Move cpufreq-specific EAS checks to
> cpufreq")

Yeah, I made this change later.  My bad.

