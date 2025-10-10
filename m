Return-Path: <linux-pm+bounces-35895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69182BCC237
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 10:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590DB1A62467
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969A3217723;
	Fri, 10 Oct 2025 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s85p5hys"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B2194C86
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085050; cv=none; b=XzjneauT8AiD/23itnKRkD4DM+5pssDS5fgM9wiT+c4jD6+vTZP5saG6TM+rNT1fqOuZG//ccrtAVP+s49+BwE0g7kM0PtS+CCe8CKixz1bI3XGng/xp41uBpHBUs2AMCQFYUk+PqcnSY8lOeJh0tyVIN8S26qhhVLq6vps8Nnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085050; c=relaxed/simple;
	bh=wctb4CCPOsVlg4MBcIeDFfStXaSUm2uLp61kJxrLTi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MR1XP+AdqcPvetpvwBhp3TfXmZAJqAUQyxzXGu9xH2MgZDIYo4+j5eT5GKc87xHLLzSc6/eH/nv+nwBGlqO/LQ96JiRBy95KgaPOH8Bd3nyIKp9ixERZxICdBc8Wq20nNPdVBgmmAX9lICIMVkJc/E/cwD4/QiCrkmDVzEN3+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s85p5hys; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-635355713d9so1757414d50.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760085048; x=1760689848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M7/UvMP8pF2d0Di4W7qdfx/D73nsmwZpf5H8xyBvB+I=;
        b=s85p5hys2GJk4R2j/PSaXILtwxCSyOg9r3/u8A6IxWeo9STlzUQ5D52W8RVN3MbLIv
         lrUjsx30TPlYGhavLa53XBOOhVODHyb77OzdhjLfWqBTSoCTS9ZqFucHpiwrYr7hSin4
         2aUf1CX1QRuDez1k1ic9ArED8oqmZhPgEqmhY2iwZe6Iws9IvCkF1SFYMQmC4JhXGQVC
         fw0EWxXartvzR2LMkEllyw00cAKOVn27Im18yjXJH4Uaoa2CxskdOs4Jvpg5BWulmhcw
         tkk1nqsJYO4V6bDvAkw4mT6QPLwA1/ssxvJTOeqtMNkfTtmCy9pg3BiLi4vyHR1VXC5e
         HBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760085048; x=1760689848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7/UvMP8pF2d0Di4W7qdfx/D73nsmwZpf5H8xyBvB+I=;
        b=DVKFZPZecbyOR2lh5JyldigQpSymk8VCeMTLk7tJGRCtlAe1+ngfaBUUXsGa6Hcmsn
         RkIB+PuHkurgsk2yZrumijOILwvPeeP2Xf0N7/Tgp6o23lXPbYoN2rt3JVh1DWovWUwy
         jZTyumf3S/8ptJVey33kaIt1dyfEQKcE3zAqyMYD7/QDn0qJ25dnsFU+i+3Dwq0NELCN
         jtpiD2vc3Cwrrqf0BxTQqFd6vl2ecvg1pgFVWndbX9v6+RBRKbYIJsCSXYINRt2aeaBO
         55RiCDVJjA4AuY5jg1Y6m8K8pxv79cPWB6EYs+ymBNr5Fn3NubC3En6ecHhrnBoUPE+B
         KWjw==
X-Forwarded-Encrypted: i=1; AJvYcCVPZJm5cKodL9wCSrAO/DfbPnileyG26XAOLPUKHd/NDHKM0YzrccvEaFf2vkf8wseVqwEp3wOxZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lu4PflL3UIlQQ3940RhdSPPkEdyN+ZSfJR5IctadYCn0S2je
	Xz95ecNWVKzv05vhfjY6cCwztZb98X8DmfyeTrCTld6nBZFIqfqsW7aITSJdu55H432+d0SQxTT
	TwXsJLz5l6SQ5qc+5v9gVlHhWxExKTuLtZFsl7rLlbA==
X-Gm-Gg: ASbGncu5eeaZhVM1AJ/fF6zjcGyKa/4ZvKI92fekYvTL4CyahRC3B/gX1VM3ZUSrAQa
	PSqHnRNawKN2Grlf2sXqbhR+J9fm4NwwNF4kH8ipQz/nzY71mOIvfbkTh+tQgpAWmdnKsSj5zrC
	RAxAxHdumfo2wj6oSVUpsWPwFf9eeYPtuwfJteC9km2gyQY8Cjv29iTVVQuO2WzxoZTWbCPAC6O
	ljX886iPqg529ffMrOCfhrRqbCH78STKlilobPB0w==
X-Google-Smtp-Source: AGHT+IELcVFwUCUEmhVUGDnSnGJlpWYHNQOXe5296t/FoFUefz+C1OeDjmmVZXYWz/J3fiD3QdzX5PFMMDEjuQIT79o=
X-Received: by 2002:a05:690e:1a99:b0:63b:a4fa:202e with SMTP id
 956f58d0204a3-63ccb8db942mr7870853d50.41.1760085047581; Fri, 10 Oct 2025
 01:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
 <20251003150251.520624-3-ulf.hansson@linaro.org> <865xcsyqgs.wl-maz@kernel.org>
In-Reply-To: <865xcsyqgs.wl-maz@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 10 Oct 2025 10:30:11 +0200
X-Gm-Features: AS18NWBt9HOnP-sXI05iFB0KpurINCBSnZcmko0s_eAswoddpw0G_kSGehKntmY
Message-ID: <CAPDyKFq4RgL0=hPhB0cwTQF-A+mXH8dxsZAYTB1CFuLxxxTujg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
To: Marc Zyngier <maz@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 17:55, Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 03 Oct 2025 16:02:44 +0100,
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > To add support for keeping track of whether there may be a pending IPI
> > scheduled for a CPU or a group of CPUs, let's implement
> > cpus_has_pending_ipi() for arm64.
> >
> > Note, the implementation is intentionally lightweight and doesn't use any
> > additional lock. This is good enough for cpuidle based decisions.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  arch/arm64/kernel/smp.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 68cea3a4a35c..dd1acfa91d44 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -55,6 +55,8 @@
> >
> >  #include <trace/events/ipi.h>
> >
> > +static DEFINE_PER_CPU(bool, pending_ipi);
> > +
> >  /*
> >   * as from 2.5, kernels no longer have an init_tasks structure
> >   * so we need some other way of telling a new secondary core
> > @@ -1012,6 +1014,8 @@ static void do_handle_IPI(int ipinr)
> >
> >       if ((unsigned)ipinr < NR_IPI)
> >               trace_ipi_exit(ipi_types[ipinr]);
> > +
> > +     per_cpu(pending_ipi, cpu) = false;
> >  }
> >
> >  static irqreturn_t ipi_handler(int irq, void *data)
> > @@ -1024,10 +1028,26 @@ static irqreturn_t ipi_handler(int irq, void *data)
> >
> >  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> >  {
> > +     unsigned int cpu;
> > +
> > +     for_each_cpu(cpu, target)
> > +             per_cpu(pending_ipi, cpu) = true;
> > +
>
> Why isn't all of this part of the core IRQ management? We already
> track things like timers, I assume for similar reasons. If IPIs have
> to be singled out, I'd rather this is done in common code, and not on
> a per architecture basis.

The idea was to start simple, avoid running code for architectures
that don't seem to need it, by using this opt-in and lightweight
approach.

I guess we could do this in generic IRQ code too. Perhaps making it
conditional behind a Kconfig, if required.

>
> >       trace_ipi_raise(target, ipi_types[ipinr]);
> >       arm64_send_ipi(target, ipinr);
> >  }
> >
> > +bool cpus_has_pending_ipi(const struct cpumask *mask)
> > +{
> > +     unsigned int cpu;
> > +
> > +     for_each_cpu(cpu, mask) {
> > +             if (per_cpu(pending_ipi, cpu))
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
>
> The lack of memory barriers makes me wonder how reliable this is.
> Maybe this is relying on the IPIs themselves acting as such, but
> that's extremely racy no matter how you look at it.

It's deliberately lightweight. I am worried about introducing
locking/barriers, as those could be costly and introduce latencies in
these paths.

Still this is good enough to significantly improve cpuidle based
decisions in this regard. Please have a look at the commit message of
patch3.

That said, for sure I am open to suggestions on how to improve the
"racyness", while still keeping it lightweight.

Kind regards
Uffe

