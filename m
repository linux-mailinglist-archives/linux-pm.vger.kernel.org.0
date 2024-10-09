Return-Path: <linux-pm+bounces-15422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B4F99750D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 20:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0F2282AC6
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ACB1A76D5;
	Wed,  9 Oct 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Noyar6L9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282E381C4;
	Wed,  9 Oct 2024 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499428; cv=none; b=RACBSpGT4FUMKK8xDBfe9QDnDOyMwjdZ8MFfvlFtZzCgIMBtfZ8ykDyFs4CQ5lu13PHYg+pQDzQs6wOTZgOX04SF+GOFVbM4arT6AW9btql7sBllGNldDhD9jzuV5hqfOy8sNuPJxt5LX2hwY+N0ZzVz+oYu62UOUtMckmTjKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499428; c=relaxed/simple;
	bh=2d2aztSu/7ODk0dRkAQqv8Y2ut92QG50KHaYipfBW5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHBoPp3H6mSueok/FK5hVEcFvn9x+/McBVt9K07u5kiLHMEsCfgLvjyDruIDciG2v1RDMy9SE4JitFpylG/u3rRmprARj4GL0JPX++10+JwX69p+TtnOjq21Lh1il5D/RIar3cvqTGvgX84HMsVQ+l/zwpXr2ZcVPcDc/B8UlBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Noyar6L9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1B1C4AF0B;
	Wed,  9 Oct 2024 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728499426;
	bh=2d2aztSu/7ODk0dRkAQqv8Y2ut92QG50KHaYipfBW5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Noyar6L9/ZrRO+iU56MtKFcTL6UDsR9X+7u/w5xmif+OeduWMybCZkc26zgqoVcW/
	 ydNrSUQ+hcL+25TQRgv/iV2ztdhYTXdVX4Sjuayo64EeDre5ROg9Bz8rH8c2RQZkph
	 lwAzwPf75N+hnCSaJSOtaygSTafcU7NIPd+fGrLFZxI3ePtBGD/L+qFOVTchkTIL7y
	 bi2j28JzzB8MrqWRAeHuDnwd6SvDR7WucIYWE0JkyKH5cLH6ZBmb93JySKTYFpxw2B
	 VKBAZYLAU8ojfySI2A4k+HpXEMBfGy5U5WtsQfQ408VQ4QA2Tsn4HXyopQGsrN2O48
	 m7eRIjmTWI1UA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5e8038d4931so49812eaf.2;
        Wed, 09 Oct 2024 11:43:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlopWRpFTpLfDmwAgPZxw7hMZHR4RPC1MoRHiQGTPIrn7rd9QvLBpFCFXh8UrCyY+Lvlalue8L@vger.kernel.org, AJvYcCUsb7IIaUWZzBql5/MOJMLJyAuUWuHEzu2ixyiWwX0Amf6288xocLEE5BUgBrYmsJJheVGAmHuT0rM=@vger.kernel.org, AJvYcCWvKCPb2iADghDv32zzJdK9TYw4TLE4HOhVRFsCvZBHivZEg448nCNsbseofcAm8UWjq/2/6ErCEfzWPJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3zHuQhBjjoQHL98E2RjddrYNVB531mxpQGyo2SzT9xCbdUSf
	z6onZczi+f6IJwykW2i6tXnSvdzCa3WLqRfcVXZ8CKzKIOtH7gAzGzTdrpsepNwWqwROOgRkjZD
	Pl68VrSdZ2z8yOUA3Hydh+8TKABM=
X-Google-Smtp-Source: AGHT+IFBcOKTV8fgieDZGxv5RtD+Iv2rO4bccgdHXUJHn0EvgWywc1nSd5L/SYrdQPyTZn55yZjz6VIpQK+QT6srakk=
X-Received: by 2002:a05:6820:80b:b0:5e1:e65d:5148 with SMTP id
 006d021491bc7-5e987ba3164mr2393069eaf.6.1728499425744; Wed, 09 Oct 2024
 11:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009072001.509508-1-rui.zhang@intel.com> <f568dbbc-ac60-4c25-80d1-87e424bd649c@intel.com>
In-Reply-To: <f568dbbc-ac60-4c25-80d1-87e424bd649c@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Oct 2024 20:43:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gHn9iOPZXgBPA7O0zcN=S89NBP4JFsjpdWbwixtRrqqQ@mail.gmail.com>
Message-ID: <CAJZ5v0gHn9iOPZXgBPA7O0zcN=S89NBP4JFsjpdWbwixtRrqqQ@mail.gmail.com>
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

On Wed, Oct 9, 2024 at 7:49=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 10/9/24 00:20, Zhang Rui wrote:
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
>
> One last thing, and this is a super nit.  We presumably have the actual
> APIC_LVTT value (v) sitting in a register already.  Is there any
> difference logically between a X86_FEATURE_TSC_DEADLINE_TIMER check and
> an APIC_LVTT check for APIC_LVT_TIMER_TSCDEADLINE?
>
> I suspect this will generate more compact code:
>
>         if (v & APIC_LVT_TIMER_TSCDEADLINE)
>                 wrmsrl(MSR_IA32_TSC_DEADLINE, 0);
>
> Does it have any downsides?

I don't see any.

> Oh, and how hot is this path?  Is this wrmsr() going to matter?  I
> presume it's pretty cheap because it's one of the special
> architecturally non-serializing WRMSRs.

lapic_timer_shutdown() is called under a raw spin lock in
___tick_broadcast_oneshot_control(), so it better not take too much
time or PREEMPT_RT might be unhappy.  I'm not sure how often that
happens, though.

Also tick_program_event() calls it to stop the tick, but it is assumed
that this may take time AFAICS.

