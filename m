Return-Path: <linux-pm+bounces-25096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C206DA84051
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 12:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8741A1892FB8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E127C159;
	Thu, 10 Apr 2025 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox7oqhCM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8B26FA47;
	Thu, 10 Apr 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279801; cv=none; b=nBxjWI2YXQ+4NOlE6XF4bx/12szP6TwrDS4ULOTqIpyZ+C8RL8j8kB6QOn2ZYxgjuxMM/uOjOV/rMEv21Hd+5BLr1UO13P4sTEiFZxLb6OkPa1Mm9QWlW1sAlBjbPkS1zRe9VAbgk409fhLkZgcVYYMlRNuYLvjL6DQxkFYluMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279801; c=relaxed/simple;
	bh=XDQeRqG/Sg0GO0RaDjkE9S9Qin1U+WlJ4Nq3KG/SysM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLg67xY9dSrvpmMNU6jCppnURhoypTC+FhCp8VgrcXK4c+8oqEYTdKjIjM9njC6F6ATwA/WmPHcoC8yWNBSYx8BwuhMqs6t90SW0Zm58rhdDUh0982UK0c/JLtXEgtPj6YEIy0YKRpi4WXfSROsElSVUFdUTF+SEvMxMw9ZtD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox7oqhCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F3FC4CEEA;
	Thu, 10 Apr 2025 10:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744279800;
	bh=XDQeRqG/Sg0GO0RaDjkE9S9Qin1U+WlJ4Nq3KG/SysM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ox7oqhCMkQ2AA5X7vYcL+xRkpgpXY0WACWsHR1gttu4snpyJS4RsuxHMgwSywblTV
	 8MxjaN46ZCU26pMOLAWXsCX/M7x6RtC2hVQCJ5G/erHxvhI4Hg5h87xiVITKgEWXTw
	 2zt59dNmfYusyaKtHrKyYlNIyS8PRVnWss0OUIjbpAOOlvQYbyoFneGSksMQIOgUYq
	 vceFQkA1okItC+VIb+t4qpu0GMJYBQQKESzM19yAwN6DolQnpkz3jjLG6cJ4k6ub+f
	 wAb6tk/iOjy5nun1ZzFO8zY0f31cay97eq+blPCdxxXY7UGBEv3Jkvw32za19ZC/ig
	 4KkOzn+KoesDw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c873231e7bso347914fac.3;
        Thu, 10 Apr 2025 03:10:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVf13MG6E5QtRFDWgE3gTld/OnROgmzcESJaPo+zOoUrDvu2mAYmm6sI4OrwY3hYbzrQsRtO/PRO1ylkw=@vger.kernel.org, AJvYcCWWU2dV0oYogXurSEYn7+4K4It4Q6ANVsjxW227pGAN31ziNxIlU6RAn3f0IvNWY0BigQezEB1gt/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdP/uGfSIvXMoozWufVrF2nQC96rTY/zMH0jLF5gC3nHodL17o
	yX1K31kjj5Sw/kfsF5j6kqoTDhp/DDk2Gui1U+bZRc5MZXWPNTuLdOUvtI827KobL4IvlnnflP9
	Kj/PjVfD2IX5+OEULfsvT/Wh6PH8=
X-Google-Smtp-Source: AGHT+IHxU+syN1q8QkU/SJehkCbTunQxsgnNrQ0pZEt4x6P+/WFl5kvm+JfdhnZ5dgUrZCFBPBIZUjVkJLlf4uPlvMc=
X-Received: by 2002:a05:6870:7e8c:b0:29e:8485:197b with SMTP id
 586e51a60fabf-2d0b35743c4mr1096642fac.2.1744279800000; Thu, 10 Apr 2025
 03:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-temp-v1-1-9a391d8c60fd@chromium.org> <CAJZ5v0ixiiSiGvc_8D8YxK22yKOAzkdrNaMNjydOHD7gQVc9tQ@mail.gmail.com>
 <CAHc4DNJs-tq+KbukyovABkp8-GEbia3KfgEURcNqqRiJ2vvwyA@mail.gmail.com>
In-Reply-To: <CAHc4DNJs-tq+KbukyovABkp8-GEbia3KfgEURcNqqRiJ2vvwyA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 12:09:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9TAcr0=vpjTqBSFtpTKAttoOnaDOncL6y=VUgyiJHkA@mail.gmail.com>
X-Gm-Features: ATxdqUHAGPwpv8z4t-b2iSlBK5zFzL7-KQ2GjdvWhtaoLOJgAnADq0FrKiR30-w
Message-ID: <CAJZ5v0j9TAcr0=vpjTqBSFtpTKAttoOnaDOncL6y=VUgyiJHkA@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Return ENODATA instead of EAGAIN for reads
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 11:59=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromium.=
org> wrote:
>
> On Thu, Apr 10, 2025 at 1:31=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Wed, Apr 9, 2025 at 11:13=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromi=
um.org> wrote:
> > >
> > > When userspace nonblocking reads temperature via sysfs, EAGAIN error
> > > returned by thermal driver will confuse user from the usual meaning o=
f
> > > EAGAIN, the read would block.
> >
> > Why would it block?
>
> I mean EAGAIN returned by nonblocking read implies the read would
> block (source: manpage of read)
> >
> > > Change to throw ENODATA instead of EAGAIN to userspace.
> >
> > Casting error codes tends to be confusing.
> >
> > > Also, ENODATA more accurately reflects that data is not currently ava=
ilable.
> >
> > It means something else, "try again" vs "no data available (possibly at=
 all)".
> >
> > The error code comes from the thermal driver and if it wants to say
> > "try again" then this is what it wants to say.
>
> Yes, but EAGAIN has special meaning when returned by nonblocking read.
> Hence, we need to avoid returning EAGAIN to userspace and ENODATA is
> the most suitable alternative in my opinion.

So any sysfs interface returning an error code would be affected by
this, wouldn't it?

Why do you want to change this particular one?

> >
> > > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > > ---
> > >  drivers/thermal/thermal_sysfs.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/therma=
l_sysfs.c
> > > index 24b9055a0b6c515b865e0d7e2db1d0de176ff767..3d1713e053dfb867933d9=
5131f1f2491d2ecd07e 100644
> > > --- a/drivers/thermal/thermal_sysfs.c
> > > +++ b/drivers/thermal/thermal_sysfs.c
> > > @@ -40,8 +40,11 @@ temp_show(struct device *dev, struct device_attrib=
ute *attr, char *buf)
> > >
> > >         ret =3D thermal_zone_get_temp(tz, &temperature);
> > >
> > > -       if (ret)
> > > +       if (ret) {
> > > +               if (ret =3D=3D -EAGAIN)
> > > +                       return -ENODATA;
> > >                 return ret;
> > > +       }
> > >
> > >         return sprintf(buf, "%d\n", temperature);
> > >  }
> > >
> > > ---
> > > base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
> > > change-id: 20250409-temp-6ebd13ad0dbd
> > >
> > > Best regards,
> > > --
> > > Hsin-Te Yuan <yuanhsinte@chromium.org>
> > >
> > >

