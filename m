Return-Path: <linux-pm+bounces-30669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7AAB017B0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 11:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E0F1C40E8C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB2527A107;
	Fri, 11 Jul 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmQ+EmKZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881B279DAB;
	Fri, 11 Jul 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226155; cv=none; b=tKngpLHTA3LiYFJt/dofcFj2CvKu/g/GDwbFl5EynQ48f1LegKFCBmqhPV7+ND20x2blPF3Rqfq/kEkZW2acl5IcO9VtOAHyL6j7uOpSwhxFlwLUC+cYvsrqt9NG+FrweVPo00GB51nK/8qRcsxzaunBFRkL5OFyFT9a9B/xlEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226155; c=relaxed/simple;
	bh=iHZmzvg1Z0/oUDVf3XnhzHYjBdXj4X/zANqYMwOOwVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1et6PdPsIboAOsw+8OgApQEYbN4s1TjKJUC7aaYHI6w1KrHMgon54wRYGb/3xQsr01thuJfJ2vbLuXiTWFcMeNf90eFvhzte/xoFkDOjhVz42oYbzmUSz4yPvTNC2zfgSEXTLHJx5svzgmG5Zbap8bJ4oTQUK2Vu/oktoSW7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmQ+EmKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70901C4AF09;
	Fri, 11 Jul 2025 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752226155;
	bh=iHZmzvg1Z0/oUDVf3XnhzHYjBdXj4X/zANqYMwOOwVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AmQ+EmKZ1CODy6GzLrc59sIDMGTEHOQOG/x0L8Nvv5ntyCOJluBRy+it6EBQTyZ17
	 KgXewm3SlJ2afz53g+03Q0APObEz5AkRN8tNJ30S2O5x0FgEg2CC/BXz7rrLU1BvWx
	 +u+yQY6S3Ix16J+mhEV3XlzSzQWfXLI9t2faqtr4kUTwMThkfBEUgnP7jM0VVEoHon
	 15WiUVymJ2T9tADURQCynOYWg7+8LS4MWxh00TCO8tGPQJA2K2YovGEX7N0ihKizx4
	 Xa1nzyrrBf+UVdzJ6xjov1KagVqaRsWT3GrA/oRgWArNwDeXyqLfIxPvZcB4zW0bAu
	 i1dOwELPpOAkA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-611e455116aso1092550eaf.1;
        Fri, 11 Jul 2025 02:29:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTOudG4nzv6OBay36G3kJ6QJUm9BIDCv80AX2uKOGXFKEGAUxGlZXnrFkg9g7giEvSledciqRevpf+Kks=@vger.kernel.org, AJvYcCWHr3N3ky7mbuje/ODNYvD9fiEqzT5Jgrsj/sMnw35BDp5OSR9IsTx1NDmuiLmbYbIQX4rAbQddkQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQG7nsCOkOtdyhhXKL9j+/DU5iZdD17zVLm4PHpNUMgUaA7Kra
	KDl8uXAguyG8MdZLTevCDo+vDtNmfcLg4VU71aEDm6wJKQ/T65CqExkePKXJLnVJbIJn2RCyI7R
	+1QKDbGnGHpmuszvfwtdFoUnNPDZB8hU=
X-Google-Smtp-Source: AGHT+IHah/1nYPPCS226AsETgCQiVMx9hN5wz3RtNvupDeronRgy3EyjIlni8u4klecH0TlVtPdr1MRtZLHO16vIPZQ=
X-Received: by 2002:a05:6820:20c:b0:611:b24d:c27b with SMTP id
 006d021491bc7-613e5ff6f4fmr1516730eaf.7.1752226154677; Fri, 11 Jul 2025
 02:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5046396.31r3eYUQgx@rjwysocki.net> <2396879.ElGaqSPkdT@rjwysocki.net>
 <aHCsUAhqRz5zJH2t@MiWiFi-R3L-srv>
In-Reply-To: <aHCsUAhqRz5zJH2t@MiWiFi-R3L-srv>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Jul 2025 11:29:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gMF_HS3pXDdXSLz9V3iZr6XvAgCZmu43Dx=oJjBJThsg@mail.gmail.com>
X-Gm-Features: Ac12FXyKFz98IUnh2R9pHZzFjoCI8hWGXwPMgzheZQYu2jad9b8REvYXq3idXSg
Message-ID: <CAJZ5v0gMF_HS3pXDdXSLz9V3iZr6XvAgCZmu43Dx=oJjBJThsg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kexec_core: Fix error code path in the KEXEC_JUMP flow
To: Baoquan He <bhe@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, kexec@lists.infradead.org, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 8:16=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 07/10/25 at 03:10pm, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If dpm_suspend_start() fails, dpm_resume_end() must be called to
> > recover devices whose suspend callbacks have been called, but this
> > does not happen in the KEXEC_JUMP flow's error path due to a confused
> > goto target label.
> >
> > Address this by using the correct target label in the goto statement in
> > question.
>
> Sounds very reasonable, thanks for the fix.
>
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks!

I've queued it up for 6.17 along with the [2/2].

> >
> > Fixes: 2965faa5e03d ("kexec: split kexec_load syscall from kexec core c=
ode")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  kernel/kexec_core.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1080,7 +1080,7 @@
> >               console_suspend_all();
> >               error =3D dpm_suspend_start(PMSG_FREEZE);
> >               if (error)
> > -                     goto Resume_console;
> > +                     goto Resume_devices;
> >               /*
> >                * dpm_suspend_end() must be called after dpm_suspend_sta=
rt()
> >                * to complete the transition, like in the hibernation fl=
ows
> >
> >
> >
>

