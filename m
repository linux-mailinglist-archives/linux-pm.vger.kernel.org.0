Return-Path: <linux-pm+bounces-12961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F64960968
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 13:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5691F2436C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB21A08BD;
	Tue, 27 Aug 2024 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szTE5j+u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E219E825;
	Tue, 27 Aug 2024 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759890; cv=none; b=u6/s+ZdNperj/85jcRdfRMvCQ8uia/Vp+YpL6j/45HwGtX6dNavdlRQXg5wtbWK0YobKKhtxpnOlpzrxigYRHo6oIWisWSR/hpNYQMi9yPtL1LAikKBd5H6kxmq9wqLw6KwmHLXR+5GHMotFz4TdGU97Mw5jC1nl7bmYmZWcmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759890; c=relaxed/simple;
	bh=kRxo7VItqj/OMI9oVzZbAhUcxz67WcLgEGg7thISTUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1aj4NBS1QptL155AWJqnYtGWeSPW2ErucliDSINCAnUQHxUjYfx3S8zSmnE9AkOBOxPXmzunwrwHwEPsj2RiqfCgFoFh5sWemVY3J1F227zP7TA7JS/u3BFMh+g5RkTzgpKbNO0iTk5lecoQLPv9ak5Hdu2eCDaq2Dzg/PviEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szTE5j+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397D5C61061;
	Tue, 27 Aug 2024 11:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724759890;
	bh=kRxo7VItqj/OMI9oVzZbAhUcxz67WcLgEGg7thISTUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=szTE5j+uX4+Q6nwZaDU1Rn6fZMnNLkz2cs1g++6I9HivCs03i66cJm/IFGXpx+GX1
	 G26aVqNjRi8lfEzNxxHxOv0uND0Al8wx4T+a7ndY9IMaLF+uCkBDi79PmJ/utCbaky
	 bbYuWRSK4qpwNx4Ai9HYsVElm4GJtBtm82ZK+aTL1OiCwsD4jmHnTG/UQ2Yo2B9RzQ
	 uaYkJUGNpUOyB04PO5SDNzATnL6msep8X+SjT8UrwBQRstmTQfziW83a9VsmeN7wac
	 HmmEpgGFYlRiK4DJ5pQVsYc5CON6l1fxvO2Qijf69RyUkUAr/lH6DMZovtUiDJelBr
	 nTTf8agE4eOCQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70949118d26so5257451a34.0;
        Tue, 27 Aug 2024 04:58:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRVeFljYvV3eMyeWy0ZlcR3FeyYBgOZ5+iyhf7Kvr1LqVG+QWfWvISAdAa5i4VxVfMv3Ebe1u5oMY=@vger.kernel.org, AJvYcCXrDgVl7Aa7HsroJyBbtB6dqKMAEpmMJW71OL+i2mgaqJqAawAQrHEXJvrypK0Iik+e6U2/DOJOxFRlYkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI35zY7gyGK1pYbOk1QmXzN58ozGkFYDIeLBU0bgt8OHKY/uIY
	62JSyRQ2klUa3Ge8AUYy+8HKxNGgcve0gNVaH7YZ686eYGeYTo2ey72j3+vtCtuFUVFqkzI+pS/
	Ba2edNmtmRLFen7K2+nqePm2YLn4=
X-Google-Smtp-Source: AGHT+IF1B6zYfYGmjEdZ/+Lb/H12g2MwdymWWZz9O+mkvpi423imAfOgehcnxdm0DES5zc2o929G13se5hU97F+5I+4=
X-Received: by 2002:a05:6870:a40b:b0:270:1352:6c1f with SMTP id
 586e51a60fabf-2775a037100mr2858957fac.33.1724759889585; Tue, 27 Aug 2024
 04:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4941491.31r3eYUQgx@rjwysocki.net> <13573795.uLZWGnKmhe@rjwysocki.net>
 <20240826220849.GA7696@ranerica-svr.sc.intel.com>
In-Reply-To: <20240826220849.GA7696@ranerica-svr.sc.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Aug 2024 13:57:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ikE668dXQRP7JTxU44t7TeLHQGNxR5T0AeiiFpPHQDOA@mail.gmail.com>
Message-ID: <CAJZ5v0ikE668dXQRP7JTxU44t7TeLHQGNxR5T0AeiiFpPHQDOA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/sched: Add basic support for CPU capacity scaling
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:02=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Mon, Aug 12, 2024 at 02:42:26PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> [...]
>
> > +bool arch_enable_hybrid_capacity_scale(void)
> > +{
> > +     int cpu;
> > +
> > +     if (static_branch_unlikely(&arch_hybrid_cap_scale_key)) {
> > +             WARN_ONCE(1, "Hybrid CPU capacity scaling already enabled=
");
> > +             return true;
> > +     }
>
> Maybe an empty line here for readability?

Sure, if this helps.

> > +     arch_cpu_scale =3D alloc_percpu(struct arch_hybrid_cpu_scale);
> > +     if (!arch_cpu_scale)
> > +             return false;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             per_cpu_ptr(arch_cpu_scale, cpu)->capacity =3D SCHED_CAPA=
CITY_SCALE;
> > +             per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio =3D arch_max=
_freq_ratio;
> > +     }
> > +
> > +     static_branch_enable(&arch_hybrid_cap_scale_key);
> > +
> > +     pr_info("Hybrid CPU capacity scaling enabled\n");
> > +
> > +     return true;
> > +}
> > +
> > +/**
> > + * arch_set_cpu_capacity - Set scale-invariance parameters for a CPU
> > + * @cpu: Target CPU.
> > + * @cap: Capacity of @cpu, relative to @base_cap, at its maximum frequ=
ency.
> > + * @base_cap: System-wide maximum CPU capacity.
>
> It is confusing to e that @base_cap is the maximum capacity of the system=
.
> Maybe @max_cap?

But the max_cap and max_freq are sort of confusing again.

I guess I can call it max_cap and also rename max_freq to cap_freq.

> > + * @max_freq: Frequency of @cpu corresponding to @cap.
> > + * @base_freq: Frequency of @cpu at which MPERF counts.
> > + *
> > + * The units in which @cap and @base_cap are expressed do not matter, =
so long
> > + * as they are consistent, because the former is effectively divided b=
y the
> > + * latter.  Analogously for @max_freq and @base_freq.
> > + *
> > + * After calling this function for all CPUs, call arch_rebuild_sched_d=
omains()
> > + * to let the scheduler know that capacity-aware scheduling can be use=
d going
> > + * forward.
> > + */
> > +void arch_set_cpu_capacity(int cpu, unsigned long cap, unsigned long b=
ase_cap,
> > +                        unsigned long max_freq, unsigned long base_fre=
q)
> > +{
> > +     if (static_branch_likely(&arch_hybrid_cap_scale_key)) {
> > +             WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->capacity,
> > +                        div_u64(cap << SCHED_CAPACITY_SHIFT, base_cap)=
);
> > +             WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio,
> > +                        div_u64(max_freq << SCHED_CAPACITY_SHIFT, base=
_freq));
> > +     } else {
> > +             WARN_ONCE(1, "Hybrid CPU capacity scaling not enabled");
> > +     }
> > +}
> > +
> > +unsigned long arch_scale_cpu_capacity(int cpu)
> > +{
> > +     if (static_branch_unlikely(&arch_hybrid_cap_scale_key))
> > +             return READ_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->capaci=
ty);
> > +
> > +     return SCHED_CAPACITY_SCALE;
> > +}
> > +EXPORT_SYMBOL_GPL(arch_scale_cpu_capacity);
> > +
> >  static void scale_freq_tick(u64 acnt, u64 mcnt)
> >  {
> >       u64 freq_scale;
> > +     u64 freq_ratio;
>
> Why can't freq_ratio be declared on the same line as freq_scale?

It can.

> >
> >       if (!arch_scale_freq_invariant())
> >               return;
> > @@ -359,7 +439,12 @@ static void scale_freq_tick(u64 acnt, u6
> >       if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> >               goto error;
> >
> > -     if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt=
)
> > +     if (static_branch_unlikely(&arch_hybrid_cap_scale_key))
> > +             freq_ratio =3D READ_ONCE(this_cpu_ptr(arch_cpu_scale)->fr=
eq_ratio);
> > +     else
> > +             freq_ratio =3D arch_max_freq_ratio;
>
> It seems that arch_max_freq_ratio will never be used on hybrid processors
> and computing arch_turbo_freq_ratio will be a waste of cycles.

Well, what if the memory allocation is
arch_enable_hybrid_capacity_scale() fails?

> Unfortunately, intel_set_max_freq_ratio() is called before the
> arch_hybrid_cap_scale_key static key is set.
>
> Maybe some rework is in order?

I'd rather not do it.  This is all initialization and done once.

However, a driver mode change can mess up with it which I have
overlooked.  I'll fix this (and make the above changes) and send a new
version of the series.

