Return-Path: <linux-pm+bounces-35406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99100BA0F62
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 19:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584372A34D9
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8021B2DCBF3;
	Thu, 25 Sep 2025 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBtkzLMA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7321DE3DC
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822947; cv=none; b=I45KbpS7+FRKFBLBh+GIsiPBE/rz6Euow7eiYyQvQZwoLnad7KquQ1EkZrcp5XY4ejreskOu5UlCfkEs0FNdVgi5IxvmqQwOsvlpaAmKZxYyx7PToQ7XLL6ptrr1v3sytNpgsLiWe9lE9p7z53C729z9viFCtHAYW+w4V6ic1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822947; c=relaxed/simple;
	bh=SOX3LuioJhf5z9bEgu8+xkPZn2U5lQnB8s5KD7WDdtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcjniVDKhev3CdLjfC5Y9zFFzRxYiYkyAmFBY3W9rrPUZn1nQtLKweY3QC5Ja6nGfYc9ZLlN2UHITfMk10V9nE8hf1RXmDw/mxeivmp9fxkbE1xJnQCSCPyVyB+fSaPcRVP+Nsr+pEXY0kxAFDHymZaXhgr3zelCWF7l2j6u7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBtkzLMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F5EC113D0
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758822946;
	bh=SOX3LuioJhf5z9bEgu8+xkPZn2U5lQnB8s5KD7WDdtk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NBtkzLMAUtlRKsuGk2OnBVigtIxuKKCiEIw74tDaf66AnpamtkvviitdqBx03j+CD
	 aRdY5P2fPccd68BCXpXjN/PlbmgVXpdfWYor+Rl8qLCSFdr04zA6uZ2n9KipAq5X0x
	 5faaHzjiG0FQT50Y/+h+Tn5CHH6X7Gv6P7NlRTSNbXsB4nHk2Tr3xWXpVxBgt+nZX9
	 SOt2qU676cvYK44FxGJ5UCDLPqv5a/BSa+uvu2Mj+IAMtmrqfV3Oxj+39+uyHwUIB/
	 x1GUS3RjQMkAPhtJ8X+3exwIXmC1rDlDMg+om2Vibh2O/2w2uKdSqLunTXAbqzPUnJ
	 gOK8YscDuih5Q==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-35b7f8e07d5so978500fac.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 10:55:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjsoucWkkbmTyDkC0tObrCqawbYdXa0ixrTVYkAqOvGUy3srcoH9fECFmUwx9D5R+3b70fc2py9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQc7sm4B0mZOKYHYniFsiRa82oyXz4yVygSzA3Etvm7JTFGGsb
	RByL/mxe/yQI4Rl+ljJE6KHQQm1Bu8VzyljlCeGeVyBTjOU1IFrQxZCoC7XDdI2gGyrKoFiFkGa
	L71ALEmQdogX3cIUSS7vVPbDOS8yoTFg=
X-Google-Smtp-Source: AGHT+IGG8FX7px7uMGlED2/O1sgQ6fpg0RvmRNrTUyS6FAsizclLEwVO3sbNSmDEcURRAP9GXskXU+qQYKMmOAiJJ6Y=
X-Received: by 2002:a05:6870:d38a:b0:34a:7993:23c1 with SMTP id
 586e51a60fabf-35eea66da59mr2145468fac.36.1758822946174; Thu, 25 Sep 2025
 10:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925155918.2725474-1-superm1@kernel.org> <20250925155918.2725474-2-superm1@kernel.org>
 <CAJZ5v0g1rm3w=93mWBRJaFiX9qMOkDMzEsU=_ScLBHSL-2i15A@mail.gmail.com> <CAJZ5v0i4xMy=y-gXgSnewAYu3uBCWYhhXBP1-MSTBfgCLq80VA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i4xMy=y-gXgSnewAYu3uBCWYhhXBP1-MSTBfgCLq80VA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 19:55:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irbKvO-tFaQWa8E0dLikN6d=y6yOxJfzQvpDVPe-TaTw@mail.gmail.com>
X-Gm-Features: AS18NWD0ZuSYH2-4dsLZ41SysFJ4itstUGzPImpphTh8Dz2mqPfS4s_3sanqDyc
Message-ID: <CAJZ5v0irbKvO-tFaQWa8E0dLikN6d=y6yOxJfzQvpDVPe-TaTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: hibernate: Fix hybrid-sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Samuel Zhang <guoqing.zhang@amd.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, Ionut Nechita <ionut_n2001@yahoo.com>, 
	Kenneth Crudup <kenny@panix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 7:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Sep 25, 2025 at 7:47=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Sep 25, 2025 at 5:59=E2=80=AFPM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> > >
> > > Hybrid sleep will hibernate the system followed by running through
> > > the suspend routine.  Since both the hibernate and the suspend routin=
e
> > > will call pm_restrict_gfp_mask(), pm_restore_gfp_mask() must be calle=
d
> > > before starting the suspend sequence.
> > >
> > > Add an explicit call to pm_restore_gfp_mask() to power_down() before
> > > the suspend sequence starts. Don't call pm_restore_gfp_mask() when
> > > exiting suspend sequence it is already called:
> > >
> > > ```
> > > power_down()
> > > ->suspend_devices_and_enter()
> > > -->dpm_resume_end()
> > > ```
> > >
> > > Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
> > > Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
> > > Fixes: 12ffc3b1513eb ("PM: Restrict swap use to later in the suspend =
sequence")
> > > Tested-by: Kenneth Crudup <kenny@panix.com>
> > > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > ---
> > > v2:
> > >  * Move under CONFIG_SUSPEND scope (LKP robot)
> > >  * Add tags
> > > ---
> > >  kernel/power/hibernate.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > index 2f66ab4538231..52c1818749724 100644
> > > --- a/kernel/power/hibernate.c
> > > +++ b/kernel/power/hibernate.c
> > > @@ -695,6 +695,7 @@ static void power_down(void)
> > >
> > >  #ifdef CONFIG_SUSPEND
> > >         if (hibernation_mode =3D=3D HIBERNATION_SUSPEND) {
> > > +               pm_restore_gfp_mask();
> > >                 error =3D suspend_devices_and_enter(mem_sleep_current=
);
> > >                 if (error) {
> > >                         hibernation_mode =3D hibernation_ops ?
> > > @@ -862,7 +863,15 @@ int hibernate(void)
> > >                                 power_down();
> > >                 }
> > >                 in_suspend =3D 0;
> > > -               pm_restore_gfp_mask();
> > > +               switch (hibernation_mode) {
> > > +#ifdef CONFIG_SUSPEND
> > > +               case HIBERNATION_SUSPEND:
> > > +                       break;
> > > +#endif
> > > +               default:
> > > +                       pm_restore_gfp_mask();
> > > +                       break;
> > > +               }
> >
> > You're breaking HIBERNATION_TEST_RESUME here AFAICS
>
> Well, not really because of the hibernation_mode check.
>
> > and power_down() doesn't return.
>
> But this still is true.

Well, except when it does HIBERNATION_SUSPEND.

But can you just make power_down() call pm_restrict_gfp_mask() before
returning and leave the code in hibernate() as is?

