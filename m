Return-Path: <linux-pm+bounces-25103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671E6A84170
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 13:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25741B686F3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7F6280CCA;
	Thu, 10 Apr 2025 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTUb6zJw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31F28153B
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283123; cv=none; b=hS8pgjNoN03yal+haef6/AXiH8hBPsRH5JFYHBvYMhGfe+vVEyQg2TMiInCZhqKjEJQq0pdlPd/vowO5SP1N0QwkyvJBTZyOmhQ9bc55keLUTvhLZLQUBIgrVIG0+pcL2qixw8Ieo7uAoZh9Pxv/00vyErfh9VuTNmhKT1dLfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283123; c=relaxed/simple;
	bh=wg7FUQheY1V6LHVrnBH6vF7AmRgRoD+z9k4SJ/+hrhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxgOK04UgE7KEvGLaKVejquItR0el4/yNOemuUxU4LUq0lX1Wji8rRcrsJP9UyHW7pk44l9mglEDaWh/ICJTGhTqt8XKT/rL+2kmc+LgHudsxGxMARFCnQCIeleZCzw0RWNyonv7AI7bU5AZ0JiKQPBPe/R5KBNgT3nrn5aRa3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bTUb6zJw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso123189166b.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744283120; x=1744887920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2bSpGtjwX4CGykGdpyzxbN5QEjzPWX6x76bISxkkL4=;
        b=bTUb6zJwB6rH0bgq/R6AG5AY0GAPvDlY4t7o/k94BwEi+Jsfbu5jCkrNAZPu2dFabz
         Q9Nu5bQm4kcU5xu9FF4+1BoGMaNh3CSkPe+re63d2xiTsRV/bKsEIrdftvyoa+qMSqII
         U3B9TIi1NiXT99okqcCDkJajiwEtdzftbJDq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744283120; x=1744887920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2bSpGtjwX4CGykGdpyzxbN5QEjzPWX6x76bISxkkL4=;
        b=aqUjK40LNy50GWhZmJxvvN3ZqY4DNJIN1c9iRBF1F09aIWt9ZLLX7+H13w/TedW34F
         LqvJuIz8xUIK0nu+9rLnlorz1Z/S0qIdW4MQomZhCxWAx0MmONWKhNkKTMs3+66lLqqO
         wO1XCkQr93FaHAtxQIUCbwYW39gmMIErmKmyGpgs3ghdaTyePsyEgHPK6IhoBGEhqMd2
         4jHSKm7kLTl8MM4I+dOcqQZ6QPoXamfxlVdhZIyYCv5FvtZIfx05tdEIuAipvgZISS78
         RyiyRvcTaYyh6+uETCJVYur1NjFSJ+Pr3AWv2S1oxUnKLWyHMZsfQ7miJQ/htXh0BIxi
         c+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXco0DYh+b2dtNmjMNyOQzvAggNIuwISdknKnEoiJoUPHo/CUH53506IoGfnt9CenZsFmDkK8Ukbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/XFV0KadvGMjGAsqw2FIwie8WYCODUQhivhMSbXbIPz/jZeD
	7llYZUvbrs8wS1MI6qtcKBlD5rC+xj/AwCw2J0i7t5nqkeVRWMvF3MvHJpcNICxzbEB5gVM26J8
	=
X-Gm-Gg: ASbGnctG1k5XDfEc9aAgFuH9ZCbm94mgbjZYrwwjSIPSYkc8CRu7zK3QE/ScEv4bfeg
	qKa2oCu/nBIE63wu/58OHpIcuiolnDnj3GlN3T+oZ1PIsG18qX8uxE6GrkBiNGwViBK/tswSe8v
	MQWqczbs/gof7XZXoVLD1JeOCkJEPBwrOj1aCDPrSEk61vSJLJ5y5V+KWj52YQQYApQ2qFo3+ib
	/3Md9vzaRgfwH1+irwEtG0m6+hTwX/hPuXPL+9S6cJfjlTqZokT7n+0sBWqXtKBIlX5EZ8wYIwY
	T1QkOyjo85e/uSgAX0L21R8z6Gjb7s6X3EJPQRxCAA2zbGXuRuo3IHN//7XumBlqRdm0IbmRjOE
	gufaTKTc=
X-Google-Smtp-Source: AGHT+IHJD7cN88MAQL4gm9cLFFuRO8VShPFyrla5Xmv613alAo7RVolK3qBdix1Hmj0MWLyUVcfiIQ==
X-Received: by 2002:a17:907:3dab:b0:ac7:ecb9:e2ca with SMTP id a640c23a62f3a-acabd1ddc5amr218771666b.17.1744283120190;
        Thu, 10 Apr 2025 04:05:20 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce705bsm255991766b.170.2025.04.10.04.05.19
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 04:05:19 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so9220a12.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 04:05:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMLkr+VppACT0BPIjNab1BTH9XpW/6tHZNhe//yS0YALvpIOETPn7B0/fjyE41T+wJOOk/qWzhYA==@vger.kernel.org
X-Received: by 2002:a50:bb42:0:b0:5de:c832:89ad with SMTP id
 4fb4d7f45d1cf-5f32901142amr72339a12.6.1744283118895; Thu, 10 Apr 2025
 04:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-temp-v1-1-9a391d8c60fd@chromium.org> <CAJZ5v0ixiiSiGvc_8D8YxK22yKOAzkdrNaMNjydOHD7gQVc9tQ@mail.gmail.com>
 <CAHc4DNJs-tq+KbukyovABkp8-GEbia3KfgEURcNqqRiJ2vvwyA@mail.gmail.com> <CAJZ5v0j9TAcr0=vpjTqBSFtpTKAttoOnaDOncL6y=VUgyiJHkA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j9TAcr0=vpjTqBSFtpTKAttoOnaDOncL6y=VUgyiJHkA@mail.gmail.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Thu, 10 Apr 2025 19:04:42 +0800
X-Gmail-Original-Message-ID: <CAHc4DNKhwC5d_49Wjt=-iH+bckWDC_Hxww-1iq0rKYfvgkr16g@mail.gmail.com>
X-Gm-Features: ATxdqUFDTzwSBvEKCyT_QhLT0rMjj_eIRZS5XWEaYX9nmTvFGLJUNR-6Nxbcuwg
Message-ID: <CAHc4DNKhwC5d_49Wjt=-iH+bckWDC_Hxww-1iq0rKYfvgkr16g@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Return ENODATA instead of EAGAIN for reads
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 6:10=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Apr 10, 2025 at 11:59=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromiu=
m.org> wrote:
> >
> > On Thu, Apr 10, 2025 at 1:31=E2=80=AFAM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Wed, Apr 9, 2025 at 11:13=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chro=
mium.org> wrote:
> > > >
> > > > When userspace nonblocking reads temperature via sysfs, EAGAIN erro=
r
> > > > returned by thermal driver will confuse user from the usual meaning=
 of
> > > > EAGAIN, the read would block.
> > >
> > > Why would it block?
> >
> > I mean EAGAIN returned by nonblocking read implies the read would
> > block (source: manpage of read)
> > >
> > > > Change to throw ENODATA instead of EAGAIN to userspace.
> > >
> > > Casting error codes tends to be confusing.
> > >
> > > > Also, ENODATA more accurately reflects that data is not currently a=
vailable.
> > >
> > > It means something else, "try again" vs "no data available (possibly =
at all)".
> > >
> > > The error code comes from the thermal driver and if it wants to say
> > > "try again" then this is what it wants to say.
> >
> > Yes, but EAGAIN has special meaning when returned by nonblocking read.
> > Hence, we need to avoid returning EAGAIN to userspace and ENODATA is
> > the most suitable alternative in my opinion.
>
> So any sysfs interface returning an error code would be affected by
> this, wouldn't it?
>
> Why do you want to change this particular one?

The background is that the implementation of read in golang tries to
nonblocking read a file and poll it when that read returns EAGAIN.
That implementation is following POSIX spec. However, the sysfs node
of the thermal zone can't be polled since the thermal sensor doesn't
inform kernel when data is ready.
Hence, the poll in golang implementation never returns and makes read
never return when the thermal driver returns EAGAIN.

I'm not sure whether other sysfs interfaces have this issue or not.
Simultaneously satisfying both returning EAGAIN when reading and not
supporting being polled might not be that common.

>
> > >
> > > > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > > > ---
> > > >  drivers/thermal/thermal_sysfs.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/ther=
mal_sysfs.c
> > > > index 24b9055a0b6c515b865e0d7e2db1d0de176ff767..3d1713e053dfb867933=
d95131f1f2491d2ecd07e 100644
> > > > --- a/drivers/thermal/thermal_sysfs.c
> > > > +++ b/drivers/thermal/thermal_sysfs.c
> > > > @@ -40,8 +40,11 @@ temp_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
> > > >
> > > >         ret =3D thermal_zone_get_temp(tz, &temperature);
> > > >
> > > > -       if (ret)
> > > > +       if (ret) {
> > > > +               if (ret =3D=3D -EAGAIN)
> > > > +                       return -ENODATA;
> > > >                 return ret;
> > > > +       }
> > > >
> > > >         return sprintf(buf, "%d\n", temperature);
> > > >  }
> > > >
> > > > ---
> > > > base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
> > > > change-id: 20250409-temp-6ebd13ad0dbd
> > > >
> > > > Best regards,
> > > > --
> > > > Hsin-Te Yuan <yuanhsinte@chromium.org>
> > > >
> > > >

