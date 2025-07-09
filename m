Return-Path: <linux-pm+bounces-30477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13283AFE886
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 14:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7C73AD556
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A3226B2C8;
	Wed,  9 Jul 2025 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhq84Jhk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12C72613;
	Wed,  9 Jul 2025 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062580; cv=none; b=IUp1nN3DzLe43fgYibVtpL1pEwqoTMIpFgUP4w3sM+5pd5NxaBACG0JmLUFKk5ZWO4fL6lly4NaNRBxtiv3qLiKrWzPQUSW6fjxIJ2W3E0NR1WtyI4ao537j2Q7GXAeSGM4Lo//a+0SL7Lv8GAWAje1C8jbpocF5Fn6OB4sFgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062580; c=relaxed/simple;
	bh=oENznkm65vTj+t+ZHIZEtLsX9J7JGFMk5uqn+AMTNFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swLho4MGZ3/A8HBEkziaE3tQjWrcMcBPVJIqZ0h3KOQiaDc5llIU7alowAZpjtnwRSyX9KblXedm70u9vFL3r8QHqs6vNgVLBBfNf/ZRqxE279XtTQA3mv0F0pvv9C0XPsxK7WiXIWZkeGQs9mQY1Ch7gWAO1HiSfVvmjUuZYxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhq84Jhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB69AC4CEF5;
	Wed,  9 Jul 2025 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752062579;
	bh=oENznkm65vTj+t+ZHIZEtLsX9J7JGFMk5uqn+AMTNFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nhq84JhkVAsZAVEp1kpcJ8hkVhlWrUB0me1KUd48VrMejHXPPqDUFW5rbJ/ANuQxo
	 XZOCYvA+ClpH23EI0UynauDmHb8A66cCd85KqI1N1Hr/CVajUN88ltTDkN1Ck/P7WQ
	 v+skH/F+1ryzeaupWJ9fXVzF6nP7VuPoTBL4x9/o65xhT0ZiGlwJCBWbl8CPDStNeL
	 cwrO6i5xJDsaVu579tM+oCeM5llecsE2YIJ2RPBcnv2aBg8zLwB5tLAEGOBBaAjwMR
	 GnWn/4eMll4UjyqW8dsq9fEjRt/OimYkOY8nLjb5py4Fr+2ZcOVyGP5xZZTbCv+Pnr
	 w6q7LYT2kZyiQ==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-407a6c6a6d4so1542182b6e.1;
        Wed, 09 Jul 2025 05:02:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCM3vM8lJET8MUF5odOKv07W3r3V/np++f9DHAOJHI74hzk2AAegVhziojTgV+FHbG9NrfkSS8Tm55s+s=@vger.kernel.org, AJvYcCXBWKGs6eN57D4U20QhW8ziWfhqJ+f9/wQkE2eD+9f/ix3dzSue1tOKWOPLRBYlkqDxb5H5jcs1IQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzycdiRS/kAkZNhiIBLc8O9BUpiC5/uJK6nR8BbTbn1RjCldDw
	3vgY5VVzwSq8eUEyAlAROgpx6TLXvdhpN+krNroiGeKbF554nKHV/WL1RMy/XyKOXjbRZZjOrwF
	PMKEmDUCa9szE6j4phVbTCz0jzjLw9gM=
X-Google-Smtp-Source: AGHT+IFCE9JQt69nhSM/sz+BuYJL3HdkNRxKQBR8VaBTjYb7SKdXlbpBctfrjE83UQJ2k2hgwtu9sN9Xfk/4HyFpnHA=
X-Received: by 2002:a05:6820:308e:b0:611:7626:b5df with SMTP id
 006d021491bc7-613cce21f05mr1273558eaf.4.1752062579076; Wed, 09 Jul 2025
 05:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4664631.LvFx2qVVIh@rjwysocki.net> <20250709114606.GJ1613200@noisy.programming.kicks-ass.net>
In-Reply-To: <20250709114606.GJ1613200@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 14:02:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hS2+a4HsWQbhg5XCWph+tGMDnPy5DHXJnFCd8WMW5tqQ@mail.gmail.com>
X-Gm-Features: Ac12FXxgL4XvXfSvtJ_CvN_H1m3hgjImJfOA2t0He5PuxoMakCJTO8hKc6KMiH4
Message-ID: <CAJZ5v0hS2+a4HsWQbhg5XCWph+tGMDnPy5DHXJnFCd8WMW5tqQ@mail.gmail.com>
Subject: Re: [PATCH v1] x86/sched: Print debug messages on hybrid asym
 capacity changes
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 1:46=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Jul 09, 2025 at 12:47:17PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH v1] x86/sched: Print debug messages on hybrid asym capa=
city changes
> >
> > Make arch_set_cpu_capacity() print a debug message including the
> > capacity and maximum frequency ratio used in scale-invariant utilizatio=
n
> > computations for a given CPU and in capacity-aware scheduling (CAS) or
> > energy-aware scheduling (EAS).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  arch/x86/kernel/cpu/aperfmperf.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > --- a/arch/x86/kernel/cpu/aperfmperf.c
> > +++ b/arch/x86/kernel/cpu/aperfmperf.c
> > @@ -416,6 +416,10 @@
> >                          div_u64(cap << SCHED_CAPACITY_SHIFT, max_cap))=
;
> >               WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio,
> >                          div_u64(cap_freq << SCHED_CAPACITY_SHIFT, base=
_freq));
> > +
> > +             pr_debug("CPU%d: capacity =3D %lu, freq_ratio =3D %lu\n",=
 cpu,
> > +                      per_cpu_ptr(arch_cpu_scale, cpu)->capacity,
> > +                      per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio);
> >       } else {
> >               WARN_ONCE(1, "Hybrid CPU capacity scaling not enabled");
> >       }
>
> There's already a printk in the calling function
> hybrid_set_cpu_capacity(), so now we get _2_ prints per CPU. That's a
> bit excessive, no?

Yeah, fair enough.

> Also, should this print be conditional on sched_debug_verbose?

It might, but it is dynamic debug anyway.

