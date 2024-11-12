Return-Path: <linux-pm+bounces-17411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F89C58DB
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 14:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525F71F21628
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 13:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E098913D53E;
	Tue, 12 Nov 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGOcfEtH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C682AF1B;
	Tue, 12 Nov 2024 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417808; cv=none; b=SMmXW3RGZ6GuO7hwgpoOa5ldOVaSoDt92Kk+NmHSY4WzmY3FKpwq0pITNBXGbeoFO7q/SBzs26zAF1iaXyMZpQhExSrDzKEnSHSiv9IQh6iQWuWjTRsSdGuI/7lpzXUpNQH8nLSjKSgojoV55TOu5MdYkFuxPXFcDsix8PCFT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417808; c=relaxed/simple;
	bh=Tsfnwwey/iLuRULuX5KQKMo3zJzRcxsXg+/3QyGvRNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7/KYSRGGxlR+O2ss5F36mJkQgvw0YvDfYaYdPXPW+UknAJXlZmG/EbvS9z/bZDKUGFoQTJXtbZB2THyjn0BaP46g6Hr3UZ+OU708gXbb8mv/bjnCfTKMotSMH1KGTCd0p5HxsVRiFJ55ip69N7EVs7Y8Z46EBat+PJr55FhmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGOcfEtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C87C4CED0;
	Tue, 12 Nov 2024 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731417806;
	bh=Tsfnwwey/iLuRULuX5KQKMo3zJzRcxsXg+/3QyGvRNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QGOcfEtHGH2rafTNYOoe8VDZKUSSMsMFv/ixMDqFAp+hEX6/JtR6UkCiQPcjfxr9v
	 10ugNHuPC5oihT8kZ/pwc9XDhn/rnGk0hd5wdN85EU6sCAnr5ThDPvVcfCZkQCgjL7
	 iMOwrkK5wqJnuJ5EV1pj2lz9EEjsrwVuJ2H26C5AqT2jid+6CjM/9n2nMyQemynUrs
	 OLRgcAocLzQlDmPbeEx39FeZQuPjG7m+IDdDcjavbIJWoRQqAlZA/B2Zg4ZqG83NFA
	 c+liBG1kOLfh4H+KwhuWq0ZDlAigIjvrSgGNEHKJ0Nei69O+7s9cj9nL4wi2uXUF8D
	 SJ0T+rjgYLwdA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ebc9bda8c8so2422954eaf.0;
        Tue, 12 Nov 2024 05:23:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6AsnefEcu7R3M2HcxbbgRO3m7+S/X2hlu43CnfPMqhyyIijjEVYzTkR3F3l1QbxaQf/4keu0T29geeDc=@vger.kernel.org, AJvYcCXFdiL/zJEiGPaAME/urE6N5OM06dX8Yv0DVKT+At6ZVBdCJWAHy4uGpm7aYycQ7AvJUnzaGX6StYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZVLV+gL8NZGUitDWAdBZn7xjEtuXLkMcrmiP0iIOosAmI5xEc
	iGgZXERv+RaDEC0F8xmkFogkGSawTVaz4MvnZYIMPNMK6vI5B9hZ8nkzvgBaG/FWzyMEoF2cBJO
	umtqQcv6cBlRLpsVhrow7abV9YIs=
X-Google-Smtp-Source: AGHT+IEnfBc3PiPg+PugKgWWu+yViJzK5MYMhBZ1Aqr0gTgiU4g3V7UdhXYV47LqJaB/LOQWLhawg7Tp8mVCBIJivUY=
X-Received: by 2002:a05:6820:2018:b0:5e7:caf5:ae03 with SMTP id
 006d021491bc7-5ee57ba7a91mr11430760eaf.2.1731417805420; Tue, 12 Nov 2024
 05:23:25 -0800 (PST)
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
Date: Tue, 12 Nov 2024 14:23:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
Message-ID: <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
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

Having inspected the code once again, I'm not sure what your concern is.

:enter.dead() is set to acpi_idle_play_dead() for all states in ACPI
idle - see acpi_processor_setup_cstates() and the role of the type
check is to filter out bogus table entries (the "type" must be 1, 2,
or 3 as per the spec).

Then cpuidle_play_dead() calls drv->states[i].enter_dead() for the
deepest state where it is set and if this is FFH,
acpi_idle_play_dead() will return an error.  So after the change, the
code above will fall back to mwait_play_dead() then.

Or am I missing anything?

