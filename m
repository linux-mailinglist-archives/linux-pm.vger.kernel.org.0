Return-Path: <linux-pm+bounces-22750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC4FA40F0C
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 13:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6129F7AAFA6
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE74205AD0;
	Sun, 23 Feb 2025 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7Zy3RJq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240D1C84CA;
	Sun, 23 Feb 2025 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740315382; cv=none; b=le3V3aO3HSi8PO+yPkSaaFRpntit05prCLfzHn9xx2K8rVjGXDzaS35dZAnQVSk4s6pBuYKVRrZ38Qz1qEMaaFQr57rz4aFPqtawN7SCp0Nh9D036ieRkeBfUTtMemcFZb405hf4R7rPfMEPYQjYn8akUFs28g4/EEQ3j5Q9zIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740315382; c=relaxed/simple;
	bh=qS/Vd39854JLBEvTlea6OneA39batnAgvlvcbDkdIdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMWx6tuMVaAYcUvJ08dN0DVz4pG7NBtcvrOsLnoAIFIGau3p1YOi31iFacABH9OYTLjdZ3rvC/nUYkUkoYey5frcqtiHvv+eIh0b65FR5RHi/nEP9MevI4lCqQCSJYQYhY1e46eNLmj23vGo6MjcfWAX/tVQImvbszCeqbxt+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7Zy3RJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8631DC4CEE8;
	Sun, 23 Feb 2025 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740315382;
	bh=qS/Vd39854JLBEvTlea6OneA39batnAgvlvcbDkdIdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m7Zy3RJqtTv/pNml1JQJoJCtAjK4Yi2HhFqNlVpFErsVaLnMkLblm7mb7lfloTqai
	 tBXy62yCNwvjmhXnZSiWjLNFncp0zjcVMzZ8dlXIGTYYNeOntU4fk7b3BVyzVKB2/e
	 XCra/jXLJZb970xhGJPvIzfiUq3IUfke6lZm1HlZcYE7qeM3gt9ZuhQ4zWiwxFQzq0
	 hFKxxCj6ftmBKHVSpI1oCt3DKSlc56FZMc8/mmQbwiJfBqaou2vJgtWLcuAwd6fceu
	 S/8EC+XHsEqeMfm9Yu+unfwYn/ILfC7z6l456V92s8+22oppuCH/jzwEEm5UvMtqyz
	 7/LkHzAOpPn0g==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso4377269fac.2;
        Sun, 23 Feb 2025 04:56:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzAtYmFcILp/wbZ15X7sy4JjT0xI6mlCfnhfJbgVx3S2q0rNpCxAjphYwizjFFB2Kv7z2EENYxbNaercc=@vger.kernel.org, AJvYcCXBXkDQq7VEE/UjTTdrD3RvgrXM/hu2/jOBDT9f2/txV/Y/1AfWsU+B5E/8l92HGDWPOmFNMWdcHec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQLnuF90WJDyIJyUXi6BiAHzsqyGxIH/xbhAg60QwsS0dYE77
	QeO5rbyw9icSTxgwrdTAbReiM75K/tQWwCkoIIe1hSgAYjM8nHVnpw1UmqEWOyZBAJXUJjiWFcv
	9TzufUyCt9DOP8mFGT17HXudSIPw=
X-Google-Smtp-Source: AGHT+IHEull1aPm+G6iHppu21oqZTvMHTvcFe8TEhohV+btO3KnfXfnapdYpzmpRbDN8Dt+EhNP1a7whjDz4n6Aqpxg=
X-Received: by 2002:a05:6808:1925:b0:3f4:be5:16e3 with SMTP id
 5614622812f47-3f4246dd328mr8526299b6e.19.1740315381855; Sun, 23 Feb 2025
 04:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1922654.tdWV9SEqCh@rjwysocki.net> <Z7rPOt0x5hWncjhr@black.fi.intel.com>
In-Reply-To: <Z7rPOt0x5hWncjhr@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 23 Feb 2025 13:56:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jwn0e4HF1SsAG1OXr59tHzh=E2rcGkTdj1FOQdK2Uisw@mail.gmail.com>
X-Gm-Features: AWEUYZkfvz9T-5QyromuZBvt6QoKeXk1-aKCBqD78UMh8kPys53yuLKtTwmoXdg
Message-ID: <CAJZ5v0jwn0e4HF1SsAG1OXr59tHzh=E2rcGkTdj1FOQdK2Uisw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Unify error handling during suspend and resume
To: Raag Jadav <raag.jadav@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Oliver Neukum <oneukum@suse.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, Brian Norris <briannorris@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 8:33=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Thu, Feb 20, 2025 at 09:18:23PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There is a confusing difference in error handling between rpm_suspend()
> > and rpm_resume() related to the special way in which the -EAGAIN and
> > -EBUSY error values are treated by the former.  Also, converting
> > -EACCES coming from the callback to an I/O error, which it quite likely
> > is not, may confuse runtime PM users a bit.
> >
> > To address the above, modify rpm_callback() to convert -EACCES coming
> > from the driver to -EAGAIN and to set power.runtime_error only if the
> > return value is not -EAGAIN or -EBUSY.
> >
> > This will cause the error handling in rpm_resume() and rpm_suspend() to
> > work consistently, so drop the no longer needed -EAGAIN or -EBUSY
> > special case from the latter and make it retry autosuspend if
> > power.runtime_error is unset.
> >
> > Link: https://lore.kernel.org/linux-pm/20220620144231.GA23345@axis.com/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c |   34 ++++++++++++++++++----------------
> >  1 file changed, 18 insertions(+), 16 deletions(-)
> >
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -448,8 +448,13 @@
> >               retval =3D __rpm_callback(cb, dev);
> >       }
> >
> > -     dev->power.runtime_error =3D retval;
> > -     return retval !=3D -EACCES ? retval : -EIO;
> > +     if (retval =3D=3D -EACCES)
> > +             retval =3D -EAGAIN;
>
> While this is one way to address the problem, are we opening the door
> to changing error codes when convenient? This might lead to different
> kind of confusion from user standpoint.

Are you saying that if a mistake was made sufficiently long ago, it
can't be fixed any more because someone may be confused?

In that case, I'd like to know who may be confused and why.

Thanks!

