Return-Path: <linux-pm+bounces-20417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D6A10990
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 15:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145BA166917
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4808A153BF7;
	Tue, 14 Jan 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcmWxYKA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23B15380A;
	Tue, 14 Jan 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865480; cv=none; b=r+ldbBk4qTIeUQuI4eApkzMHRBG0DbI6GZoIUwIy0LGMMuXDcnQAMNIpsBv9ZNlgKPni9cWAb5YY3bWINsp9HeZuCxl8R1+SeeU1iDVGoFul0QcUeMSQwCBfnkwC6yhCf2ySjGWf0GoKq8HjGczwlujxlIoy8UaENEPChWPYNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865480; c=relaxed/simple;
	bh=DKZinTH1pFfZBqYIta0YLNX8YXR7AhUaiiukp3YPnZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdVDUpM7e/hvaOwqJvFt5T6XqBDtAAXPxqM8pci8qWLwn2O0HcGUqgj7f6b5hMLLTutsTv1W8HYdEYLKk1biQA2cdY0mWcng8PFlA2ixEN7t+kUfqgkg78d9Zp6VTc40aCS6tbpygkbxkx9gnVGUSxXj/Y9yviCKm8t8X9+QObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcmWxYKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F2FC4CEE6;
	Tue, 14 Jan 2025 14:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736865479;
	bh=DKZinTH1pFfZBqYIta0YLNX8YXR7AhUaiiukp3YPnZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pcmWxYKA9cP6koOsmC4bpK6ULZoAQ9GjDNoZj0t5R689i32UFzNHOIVK7ghU5caeB
	 yLZU5338jdRUn0HH9FbBFS5S0oMkH8PkYkzBGRFIDliSPvRM1n6xHYjBNwGg9EbuNJ
	 7u+AMgWaPHFTGR6b18uwmiw/xWHcSXHpnOGuECyWk70vd44fSffSoergPOiany3Zyx
	 DPbSnHK6DEXJBSTiQMVvlNbitSdxhv6wvVZ+9Kofxac6drOnPqoGWltWHoe2bp0bXK
	 M2RjyY0W+kJ8bLXcF3g1Ew33BEK3hNobvBs90pYxZltvBAYg7kYUtExG7rq57GV/vb
	 MSNGDO7AdGzrA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f2d5b3c094so1137354eaf.1;
        Tue, 14 Jan 2025 06:37:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCgCKi9hcjk56fkiJkbpWNAF8yEQ8bhfHlwDkIrPn03Fu7VH8Kzgbuohnm5joTZk1PAgKfhgTraQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcye2O4WyWw5RjByhoVZHSyeAtS4DD8xNYSAYjVjFep+QFvVu5
	vNcJP+y8DjPj9xN4HZ8jcdGf793gByPQytlVwdROHGsjAEjbSlxsd39+XGJHpB/4rTHQeaxXgS6
	PmLhoWuFNCS4nuSuwy8AgBiD3CWg=
X-Google-Smtp-Source: AGHT+IGwwfE/iBfhV9OrJBiWQjHQ6Xi9WGjsBKVoxoHyAoadbFMq/Ismt9ixcuiaSfZH/A7/pOVwekxZrAH5fyDMdt8=
X-Received: by 2002:a05:6870:2f18:b0:296:beb3:aa40 with SMTP id
 586e51a60fabf-2aa0699904emr14995757fac.36.1736865478979; Tue, 14 Jan 2025
 06:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102150201.21639-1-frederic@kernel.org> <20250102150201.21639-3-frederic@kernel.org>
 <CAJZ5v0gEhGJCkfMn6jhF2D_4BYKJZev_Eyq5AhkTeT02_cHcXQ@mail.gmail.com> <Z4Z2DHENCad2hEFC@bogus>
In-Reply-To: <Z4Z2DHENCad2hEFC@bogus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 15:37:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gH+oFmz5+xbW+X1dSXjgt0z-+2b9X-4Oq6FR1EZunvdA@mail.gmail.com>
X-Gm-Features: AbW1kvb39JkhuQkZ4dMmAr7jd_mVAxt6vpekwRsD1AwyJKp9LfdfDtUprrlXz2Y
Message-ID: <CAJZ5v0gH+oFmz5+xbW+X1dSXjgt0z-+2b9X-4Oq6FR1EZunvdA@mail.gmail.com>
Subject: Re: [PATCH 2/6] cpuidle: Introduce CPUIDLE_FLAG_MWAIT
To: Sudeep Holla <sudeep.holla@arm.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 3:34=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Tue, Jan 14, 2025 at 03:01:26PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 2, 2025 at 4:02=E2=80=AFPM Frederic Weisbecker <frederic@ke=
rnel.org> wrote:
> > >
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > Provide a way to tell the cpuidle core about states monitoring
> > > TIF_NEED_RESCHED on the hardware level, monitor/mwait users being the
> > > only examples in use.
> > >
> > > This will allow cpuidle core to manage TIF_NR_POLLING on behalf of al=
l
> > > kinds of TIF_NEED_RESCHED watching states while keeping a necessary
> > > distinction for the governors between software loops polling on
> > > TIF_NEED_RESCHED and hardware monitored writes to thread flags.
> > >
> > > [fweisbec: _ Initialize flag from acpi_processor_setup_cstates() inst=
ead
> > >              of acpi_processor_setup_lpi_states(), as the latter seem=
 to
> > >              be about arm64...
> > >            _ Rename CPUIDLE_FLAG_NO_IPI to CPUIDLE_FLAG_MWAIT]
> > >
> > > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >  drivers/acpi/processor_idle.c | 3 +++
> > >  drivers/idle/intel_idle.c     | 5 ++++-
> > >  include/linux/cpuidle.h       | 1 +
> > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_i=
dle.c
> > > index 698897b29de2..66cb5536d91e 100644
> > > --- a/drivers/acpi/processor_idle.c
> > > +++ b/drivers/acpi/processor_idle.c
> > > @@ -806,6 +806,9 @@ static int acpi_processor_setup_cstates(struct ac=
pi_processor *pr)
> > >                 if (cx->type =3D=3D ACPI_STATE_C1 || cx->type =3D=3D =
ACPI_STATE_C2)
> > >                         drv->safe_state_index =3D count;
> > >
> > > +               if (cx->entry_method =3D=3D ACPI_CSTATE_FFH)
> > > +                       state->flags |=3D CPUIDLE_FLAG_MWAIT;
> >
> > FFH need not mean MWAIT in principle.
> >
> > FFH in _CST means MWAIT in practice because _CST is used on x86 which
> > implements FFH through MWAIT, but it would be good at least to put a
> > comment here to explain that this code is only expected to run on x86.
> >
> > Or better still, add something like acpi_arch_idle_state_flags(u8
> > entry_method) that will return CPUIDLE_FLAG_MWAIT for ACPI_CSTATE_FFH
> > and 0 otherwise and then do
> >
> >     state->flags |=3D acpi_arch_idle_state_flags(cx->entry_method);
> >
>
> +1, was about to suggest the same. Though I am not aware of any Arm platf=
orms
> using C-States(LPI was added to suit Arm requirements), it is better to k=
eep
> the FFH definition arch specific.

Which will be consistent with this patch among other things:

https://lore.kernel.org/linux-pm/20250110115953.6058-3-patryk.wlazlyn@linux=
.intel.com/

