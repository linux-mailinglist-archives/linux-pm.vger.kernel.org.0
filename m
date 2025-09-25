Return-Path: <linux-pm+bounces-35404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403E5BA0F32
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 19:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA994A1F03
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B188312804;
	Thu, 25 Sep 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdMlnqs1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449130FC08
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822675; cv=none; b=Yd6yzKnG/aoJ1BjnmXCRX119x33GT97al/93RITvJlbmUeMV3D1Lsvb/76zHSCAVuRYAE+d4600UBmHx43cH1PzPn+uyeTjIP+PBGLbB3jdhtzwoLOcMgHpvGdpDPfIy/FcSzORcoZc0OUkksGjKR6SSgNzSjyaoBs7bJZfZ3zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822675; c=relaxed/simple;
	bh=gRdOscOTHhI+i0F0NbGwOm6Fee4wavwmKfYcYfw8HB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tF1nS6FIZoDI/UUwGPPU/be+9uXQgSNwXJDKy8eaDT37ElxnVvIghBTSDkNkPSW2hX1E8az0wRTd5zU65l2C2FjZT64IFHBKRVzGIQmkZklJFTocdxRNoxwZCIcfgzs+fSKtM2VHX5DvpPMl8ggSt5VDsFm3Y8l1Slhs8YdW+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdMlnqs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D31C16AAE
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 17:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758822674;
	bh=gRdOscOTHhI+i0F0NbGwOm6Fee4wavwmKfYcYfw8HB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bdMlnqs13WtqWOYvSEm7QPcF4lZ7BEqkSJ6sWgaI42hlusLhREvEbyjc1YDlT6C7Z
	 56Cxvfkh9mZl6pmW7H/DC5tUtACHzls2xyPk+0mlyfzx0TEj2ogSUuFXS17Omt9jEC
	 q9laddRJS3xZxCCPA+zhXpyc8ptELnRtShtSdxbRrSeeMfuT8qVNyPY2ZJyfx/wEXX
	 CJDxTtzqnpkkK2BXUMm8vHw28ITH3qcbtAXD90VBnl4DTPPt+aIsmaPzXTUkh2/CFH
	 o1R8xUh1e8EKxmBGbASylTtK81ZKburJTWlzeW9D5tUnuF/Apfp2IN326OjHscc5tj
	 6YiIcaHM3SDiA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-332e66cd8e4so649578fac.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 10:51:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMfEzNHGtwZBU0Fz0j8b4lDOD0q6z2hxmO0vwtmUghtgOetpILBgCi8uU3JmLWuPA0y5Eq/0QYPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdRyivGYV1feSE4b+nVNYvPB9JCvKkOSDcxqGGA8u8viO6YwA
	uNye5vuJSdEUfzJ/b0KsaDZnS1jzl0vWXK9k2SfNN+s0Pj6L4+iCZ3I2cWOnmRy/MG0yeN7Z5YM
	FWKuqjz2ZLq8MTju0tZAcAT2T3ql9raU=
X-Google-Smtp-Source: AGHT+IF+BZnZzFQD0fUzXPwYbYWCPdphHFnalJrklbCIrlGUekVrPspRNbln3iasB+dASXFC5TL7AhzbFjg8JUgNu30=
X-Received: by 2002:a05:6870:2199:b0:30b:cb2f:bae4 with SMTP id
 586e51a60fabf-35ebf3f478bmr2024381fac.12.1758822674050; Thu, 25 Sep 2025
 10:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925155918.2725474-1-superm1@kernel.org> <20250925155918.2725474-2-superm1@kernel.org>
 <CAJZ5v0g1rm3w=93mWBRJaFiX9qMOkDMzEsU=_ScLBHSL-2i15A@mail.gmail.com>
In-Reply-To: <CAJZ5v0g1rm3w=93mWBRJaFiX9qMOkDMzEsU=_ScLBHSL-2i15A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 19:51:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4xMy=y-gXgSnewAYu3uBCWYhhXBP1-MSTBfgCLq80VA@mail.gmail.com>
X-Gm-Features: AS18NWBYxPcokk8u39pxoHMFexm82rrMjsS6VNFjlb5geOK8p8n90_IqPsrwZiE
Message-ID: <CAJZ5v0i4xMy=y-gXgSnewAYu3uBCWYhhXBP1-MSTBfgCLq80VA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: hibernate: Fix hybrid-sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Samuel Zhang <guoqing.zhang@amd.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, Ionut Nechita <ionut_n2001@yahoo.com>, 
	Kenneth Crudup <kenny@panix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 7:47=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Sep 25, 2025 at 5:59=E2=80=AFPM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
> >
> > Hybrid sleep will hibernate the system followed by running through
> > the suspend routine.  Since both the hibernate and the suspend routine
> > will call pm_restrict_gfp_mask(), pm_restore_gfp_mask() must be called
> > before starting the suspend sequence.
> >
> > Add an explicit call to pm_restore_gfp_mask() to power_down() before
> > the suspend sequence starts. Don't call pm_restore_gfp_mask() when
> > exiting suspend sequence it is already called:
> >
> > ```
> > power_down()
> > ->suspend_devices_and_enter()
> > -->dpm_resume_end()
> > ```
> >
> > Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
> > Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
> > Fixes: 12ffc3b1513eb ("PM: Restrict swap use to later in the suspend se=
quence")
> > Tested-by: Kenneth Crudup <kenny@panix.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > ---
> > v2:
> >  * Move under CONFIG_SUSPEND scope (LKP robot)
> >  * Add tags
> > ---
> >  kernel/power/hibernate.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 2f66ab4538231..52c1818749724 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -695,6 +695,7 @@ static void power_down(void)
> >
> >  #ifdef CONFIG_SUSPEND
> >         if (hibernation_mode =3D=3D HIBERNATION_SUSPEND) {
> > +               pm_restore_gfp_mask();
> >                 error =3D suspend_devices_and_enter(mem_sleep_current);
> >                 if (error) {
> >                         hibernation_mode =3D hibernation_ops ?
> > @@ -862,7 +863,15 @@ int hibernate(void)
> >                                 power_down();
> >                 }
> >                 in_suspend =3D 0;
> > -               pm_restore_gfp_mask();
> > +               switch (hibernation_mode) {
> > +#ifdef CONFIG_SUSPEND
> > +               case HIBERNATION_SUSPEND:
> > +                       break;
> > +#endif
> > +               default:
> > +                       pm_restore_gfp_mask();
> > +                       break;
> > +               }
>
> You're breaking HIBERNATION_TEST_RESUME here AFAICS

Well, not really because of the hibernation_mode check.

> and power_down() doesn't return.

But this still is true.

>
> >         } else {
> >                 pm_pr_dbg("Hibernation image restored successfully.\n")=
;
> >         }
> > --

