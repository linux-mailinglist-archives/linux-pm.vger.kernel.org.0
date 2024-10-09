Return-Path: <linux-pm+bounces-15417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD039972E6
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 19:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD581281FF5
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175AE1A2547;
	Wed,  9 Oct 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2l1752W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099C14A611;
	Wed,  9 Oct 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494372; cv=none; b=AQ0e2+DlsHQoURa48QkqobFAvV7lKMceiVh1V2XLCSC+BlDBqQz0GhODdK0HrAi5j/eO5T+1o7bkMRLwiPpoD2yN0cvCu+Xdx9x8L5qYrT7KUIbZx6pQ7PtxJ60N+tDHo5LIJYkgPLiqcGNGHYS+s5bQDnVC3TBtMhn+0bz+Ft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494372; c=relaxed/simple;
	bh=dLU+OotWH2g1URFNbEZm760Q10w0xqUIIYYKcTJq9ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXX1tQrloVJ4sW09p/EhhiHzswTPyT/noBMC+5R/5oP369hdKU1iUNrf7ul72IbmqdGOaEb/8/hbmk0/MfhsBTnAPddmQAgLyCF1z4RwnoqE9b0MeocbUWU4H0k6xHeDjIi2Z9MEEV9siEtdJDcG/mgWYZmmK0XkipZNV1MtsgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2l1752W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7069CC4AF0C;
	Wed,  9 Oct 2024 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728494371;
	bh=dLU+OotWH2g1URFNbEZm760Q10w0xqUIIYYKcTJq9ms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h2l1752WTtUWm8r92SqXhiYZ7msC9LxNWZ4p+bV+d/U0Cv+eXyrWlvZrO6iT8Nfds
	 eNq1ksTd/K4a5Q0VsRU1W+a7bydnRqNBWwmKZX6/lDRtXGOYeKGlhKCCcYV0Efe/2G
	 IdoP/OCKhbZgVG6uWvo0BHkoMG7XrKlqWHnA6MoH+J8hq6cnPxp12XpM/+GV3uDGc7
	 AH0yjME0ZTfDI3j/kTYglxkmCzngkgSPLUgTGV3hHYHE8uaaEqYafRVsAkqimw0txk
	 kDox60qfHvaKXWb2/zAzz7/Od/JFD2Kyz9fhWAzfc81TPVfbpTmYQxwNrS+xl6zHnY
	 X/QY1vt6z/uQg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-715716974baso28581a34.1;
        Wed, 09 Oct 2024 10:19:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWn9VVOrA11DLXcxQJAyEJN2uj4JE5Ad35X1wcuHW3c3mrpJEkHRDnOAou+zHQ9qoipr3VNJRsQJtQ=@vger.kernel.org, AJvYcCX49qM65Ni/GHa+8E5v3/Gq7IjhT/3LRSlZfrTXeg5759AmT5wysbu62WJENYw5jLBr7Js8Ffyv@vger.kernel.org, AJvYcCXRF1iWdw8Zk3/Vt2c4Q6WLkoMrGCC1GrFXuNmTfHK49fIonKnI+r+3oImVoYmN+dv+i7Z7c1b6BfZixJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDpZGTdjduXLJJbo11l2M1nfTRnve1EtuqM7Zh2qjLTNQeSTp
	mItkAKZqK/0FbrPdQknyPdqXMSd4K4QHKpcQhHnMszSpVk+b3y2+UUXWi6DUrUwKnFgfAxjmRL4
	Ze/wK82jjh/DV1IgOoYrLxNzeyl4=
X-Google-Smtp-Source: AGHT+IHEhmLfawQX/AP19Kac6yO6GUDyycB+mNOc10EnBHndFcJFvPcW8d67CS75m2vIrJKvbGgHWDJ2TIzwANNpwG4=
X-Received: by 2002:a05:6830:2d86:b0:716:a9bf:59c8 with SMTP id
 46e09a7af769-716a9bf5ddfmr1261902a34.7.1728494370838; Wed, 09 Oct 2024
 10:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009072001.509508-1-rui.zhang@intel.com> <ed43f0b5-0625-4a6b-b986-42583673d857@intel.com>
In-Reply-To: <ed43f0b5-0625-4a6b-b986-42583673d857@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Oct 2024 19:19:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLajUAjhCYvqBs5bAcQoM1hQz_53van5dvQws0WHW9fA@mail.gmail.com>
Message-ID: <CAJZ5v0iLajUAjhCYvqBs5bAcQoM1hQz_53van5dvQws0WHW9fA@mail.gmail.com>
Subject: Re: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
To: Dave Hansen <dave.hansen@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com, x86@kernel.org, 
	linux-pm@vger.kernel.org, hpa@zytor.com, peterz@infradead.org, 
	thorsten.blum@toblux.com, yuntao.wang@linux.dev, tony.luck@intel.com, 
	len.brown@intel.com, srinivas.pandruvada@intel.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:49=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 10/9/24 00:20, Zhang Rui wrote:
> > This 12-year-old bug prevents some modern processors from achieving
> > maximum power savings during suspend. For example, Lunar Lake systems
> > gets 0% package C-states during suspend to idle and this causes energy
> > star compliance tests to fail.
>
> Why haven't we noticed or cared for the last 12 years?

Because on the previous platforms the apic_write(APIC_TMICT, 0) in
lapic_timer_shutdown() was sufficient even in the TSC deadline mode,
or at least no problems with it have ever been reported.

> Also, plain language really matters.  Is this as simple as: "you close
> the lid on the laptop and the CPU doesn't power down at all"?

It will power down somewhat, but not as much as to justify suspending
the system.  It will just drain the battery at a relatively high rate
which will also cause the machine to heat up.

Not a good idea to put it into a bag in this state, for instance.

> > According to Intel SDM, for the local APIC timer,
> > 1. "The initial-count register is a read-write register. A write of 0 t=
o
> >    the initial-count register effectively stops the local APIC timer, i=
n
> >    both one-shot and periodic mode."
> > 2. "In TSC deadline mode, writes to the initial-count register are
> >    ignored; and current-count register always reads 0. Instead, timer
> >    behavior is controlled using the IA32_TSC_DEADLINE MSR."
> >    "In TSC-deadline mode, writing 0 to the IA32_TSC_DEADLINE MSR disarm=
s
> >    the local-APIC timer."
>
> Is "stopping" and "disarming" the same thing?

That is my understanding.  If you disarm it and it is not armed again,
it will be stopped effectively.

> Second, while quoting the SDM is great, it would be even better to
> including the Linux naming for these things.  The Linux naming for the
> APIC registers is completely missing from this changelog.  You could say:
>
>         "In TSC deadline mode, writes to the initial-count register
>         (APIC_TMICT) are ignored"
>
> which makes it much easier to relate this code:
>
>         apic_write(APIC_TMICT, 0);
>
> back to the SDM language.  This is especially true because:
>
> #define APIC_TMICT      0x380
>
> doesn't make it obvious that "ICT" is the "Initial-Count Register".  I
> had to go back to the SDM table to make 100% sure.
>
> This also doesn't ever say which mode the kernel is running in.
>
> > Stop the TSC Deadline timer in lapic_timer_shutdown() by writing 0 to
> > MSR_IA32_TSC_DEADLINE.
>
> This dances around the problem but never comes out and says it:
>
>         The CPU package does not go into lower power modes (higher
>         package C-states) unless all local-APIC timers are disabled.
>
> Plus something to connect the old to the new:
>
>         On older CPUs, setting APIC_TMICT=3D0 was sufficient for disablin=
g
>         the local-APIC timer, no matter the timer mode (deadline, one-
>         shot or periodic).  But newer CPUs adhere to the strict letter
>         of the law in the SDM and more fully ignore APIC_TMICT when in
>         deadline mode.  Those CPUs also don't fully "disable" the timer
>         when IA32_TSC_DEADLINE has passed.  They _require_ writing a 0.
>
> Or am I missing something?

No, you are right.

We need a new version of the patch with a better changelog.

> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > index 6513c53c9459..d1006531729a 100644
> > --- a/arch/x86/kernel/apic/apic.c
> > +++ b/arch/x86/kernel/apic/apic.c
> > @@ -441,6 +441,10 @@ static int lapic_timer_shutdown(struct clock_event=
_device *evt)
> >       v |=3D (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
> >       apic_write(APIC_LVTT, v);
> >       apic_write(APIC_TMICT, 0);
> > +
> > +     if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
> > +             wrmsrl(MSR_IA32_TSC_DEADLINE, 0);
> > +
> >       return 0;
> >  }
> >
>
>

