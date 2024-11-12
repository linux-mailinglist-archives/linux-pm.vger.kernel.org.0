Return-Path: <linux-pm+bounces-17403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD0D9C5961
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 14:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84399B290CC
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145741CBE8F;
	Tue, 12 Nov 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQI6kudP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7CC23098E;
	Tue, 12 Nov 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413044; cv=none; b=tDdYiFRatS6MvZkGW27i7/M2vSkaMd4HiWhRojz+jtpQk6gfOanbX+L6nizK/rsNlkwk95fM9fe3AqXC6SkfTHNuwqc0chirxkCadGxOIeFlS210zQtrh2lrKoQAyQGaK/lafDikNh/n2ULgEK+FPNAq7QUmcrjPJbO4Wba5FS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413044; c=relaxed/simple;
	bh=jheorv6fJJSb6NBSDHmhexL0d4nOHuMAgKpQkpYjd/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGzr5dVRFZWNzlYD6xWzBnWzE/wZPmBe9zM9gjsNiV2GXKeD4dqZ6Hhhks261FNbFopUIuz8hMVu/IKtkVZ0lkeh0SGfrE7PC63Kpbd3NCBsmpD0HbnsHeRaOEnWeD8k0Wrav3dPS1zNNbIABnv3GmWNterR5NeghdDfhEBOoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQI6kudP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7AEC4CED0;
	Tue, 12 Nov 2024 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731413043;
	bh=jheorv6fJJSb6NBSDHmhexL0d4nOHuMAgKpQkpYjd/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mQI6kudP6zbCuy5x2UmyII8Hb73UAW1KytGo5uzBxB5CmIhYr47+G/Jp+vFf//rQR
	 rqDQGxl1q8nB+34JtalLI1yNQwp0+FwtdzpT/ClXWHbzmrzyBxv9PuNWosq8qC8br7
	 rIMV3tP2fWVPdyo5Y6kCHtAWjObUZE/uW2u4+V5ynmTgIORXa5sA8Hr5J8hPygM6vr
	 Wdbr/d4f4JTCJ4wAyoIgb8ZqpE/NBRK6S+RQsDwKMcXWRK1FePQvnoM7HILM+npeg1
	 GxnCsJgZ8ZE7Zs0B/8bWLLieobYj7dnYDhWdLZlAzbwVRqvkxQf9GZTfxLY/DkihVp
	 o5tKEMMqaJzsA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-295cee3a962so314672fac.3;
        Tue, 12 Nov 2024 04:04:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKLL0Yc1EE0RjAhhXPRGdpYkSPa3QW3ca8ykUuylVvBKEDMOH7FP2KmAMWZijgGsj5NqKQN+tAwVfPoBg=@vger.kernel.org, AJvYcCWA35Sj96lfR8ET2FZtuZDQztGQvuPweJpmORc8/S4cQmHnG9tW5oPULyUE3b8xHcqTrCnzCdmCn7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ6fs53YLFNPmQjctw8tqlSoNAqkJOO4l7icWH89oonTxNAPNI
	MQ5EaovI1d+PPmmV50I+yIb1encuaMIBaRgyIJc4ghCamssW4jQqHmWAPI9zKJfRUwFe6V7/0WB
	06IGh5B76qaHQGDIKXHxdczpzxAI=
X-Google-Smtp-Source: AGHT+IENpXQkMHH23ACo9n/vAgMDWqUhHkWc+RO8r5rbWjlZFELAMv3e355Fa9OtRBC6KoodummyOV3pYMqq2xXMGBs=
X-Received: by 2002:a05:6871:689:b0:288:2906:6882 with SMTP id
 586e51a60fabf-2956026059amr13876658fac.29.1731413042740; Tue, 12 Nov 2024
 04:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com> <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
In-Reply-To: <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 13:03:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
Message-ID: <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:47=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Nov 08, 2024 at 01:29:08PM +0100, Patryk Wlazlyn wrote:
> > The generic implementation, based on cpuid leaf 0x5, for looking up the
> > mwait hint for the deepest cstate, depends on them to be continuous in
> > range [0, NUM_SUBSTATES-1]. While that is correct on most Intel x86
> > platforms, it is not architectural and may not result in reaching the
> > most optimized idle state on some of them.
> >
> > Prefer cpuidle_play_dead() over the generic mwait_play_dead() loop and
> > fallback to the later in case of missing enter_dead() handler.
> >
> > Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> > ---
> >  arch/x86/kernel/smpboot.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 44c40781bad6..721bb931181c 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -1416,9 +1416,9 @@ void native_play_dead(void)
> >       play_dead_common();
> >       tboot_shutdown(TB_SHUTDOWN_WFS);
> >
> > -     mwait_play_dead();
> >       if (cpuidle_play_dead())
> > -             hlt_play_dead();
> > +             mwait_play_dead();
> > +     hlt_play_dead();
> >  }
>
> Yeah, I don't think so. we don't want to accidentally hit
> acpi_idle_play_dead().

Fair enough.

Then we are back to the original approach though:

https://lore.kernel.org/linux-pm/20241029101507.7188-3-patryk.wlazlyn@linux=
.intel.com/

