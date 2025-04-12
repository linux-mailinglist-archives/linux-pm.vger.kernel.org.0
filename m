Return-Path: <linux-pm+bounces-25308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC348A86BB4
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 10:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8271B64015
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 08:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9B198E77;
	Sat, 12 Apr 2025 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="efhzUGG3"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C299149C6F;
	Sat, 12 Apr 2025 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744444795; cv=none; b=io5FgZl+u1rbm96a4Cm7ISWkHWbRRqWR7ZqxZF3vuAQ5sSZ87Q1frzlBH71AiyjKucxIwOrn0jOoBGVUpGSWBBiUiZLhruYbaaV+kEh1BWWw8YdFLHKYwObvUaZFlECudkhGnpe6asgGP6XleNozHTRriAijHoDOlVyOv2aes/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744444795; c=relaxed/simple;
	bh=EiuPKkmqCFZXP4N/edZwnI3nbjMbmbyJsvypHGLqJ5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDbBr4Kgcn7dEQJJvpeqvCnSQI7yO4ysylhjLwCyNcHj8Rzb8gQRvYEUGZzWqylNq+3jV4bYj6INcNAgUUvZiKN7D1Dg6OYxfLotduCWKpuX9ahGVbYju/AlDO40gwFmjtoDLP6fEIH/XLQxIe+Ca6ujFXA1VfXBMK7YISEjxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=efhzUGG3; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 2AC8F2E08F06;
	Sat, 12 Apr 2025 10:59:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1744444781;
	bh=REeIeHESt0YMj2YCBhUUTwnaTdQeKuRlTFEDz5IF1yY=;
	h=Received:From:Subject:To;
	b=efhzUGG3Bz3sJr4JWM4L3NoG7oat+W/iKT9+8c8X4skeL9F4tLrn1kd2ml4VvBP3o
	 apJH0ZOWDaUQYNsUANhst3kuXfawgo+V6IlqKMNbNNq584NYRZOK6VQR2p63dBO14e
	 gl64GoEu7D7FTZ7JDm0DAwgVozS1oHcMltwu0j3M=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-30bf3f3539dso30012921fa.1;
        Sat, 12 Apr 2025 00:59:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUUskxXEzWV/+3u3osXLiBRNY18iZ8Hq4RIbmbNyRN7ChPU1X2L4jPjVW7UTYOm3pGhHqAj0oVrEWs=@vger.kernel.org,
 AJvYcCVJm3PFoOQ/RHqCHMHwGwXVy0YP6p631g2wxp+TpiEqdJlNo43N1QvyatZ/F5IdOyQMWw4ijE2jc3tUVpQ=@vger.kernel.org,
 AJvYcCW0xxte6tVrzIFwXtcxgLp3/CobEGPStmyBG/BD1E7xQ/otbadB0lK0Nv9h/T0NUlyQN02GFJOLyRg=@vger.kernel.org,
 AJvYcCWW+PFKwaYejflbhuBYe/nG7NKBx1L/MYbiyVY91jUu+uN3h1urcmoj8GPFfIAf9dX4/k9ciHs/oIF8IygS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yAVAWNBkrNj8y54GMm2X+ycHEXdiO0dgmi0rws5RvJz/6oTD
	z/bxWLooi8o9byclEEFK5H9v55pRy+gtqGLU343EqW8rDtQFRCoW52xjmDE8FfCuYLeN+WBQncv
	PZrLl2zdzR8Wo1RYSdyifUEIAVc8=
X-Google-Smtp-Source: 
 AGHT+IGVjsis0wnIIdzXhAkrlGIyN9teUJRgNyaJsyRzIeqkI6ouzeeODqZf/BwuubgIncEFB0FdZxqjnTVfVHLkR8s=
X-Received: by 2002:a05:651c:908:b0:30c:12b8:fb97 with SMTP id
 38308e7fff4ca-310489a03b8mr16804031fa.11.1744444780124; Sat, 12 Apr 2025
 00:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322103606.680401-1-lkml@antheas.dev>
 <20250322103606.680401-12-lkml@antheas.dev>
 <4049e2db-fcea-a441-466d-84267d423c2c@linux.intel.com>
In-Reply-To: <4049e2db-fcea-a441-466d-84267d423c2c@linux.intel.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 12 Apr 2025 09:59:28 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEGLB+duOD=GyAZ25fFm0RmoEdawAxvLJ+_nJBTNmcEqg@mail.gmail.com>
X-Gm-Features: ATxdqUHnjRjKm0yhYmqShP5-yp_wPweL0YrKdTdcLw4vbge4osaykUoFzBpbdsQ
Message-ID: 
 <CAGwozwEGLB+duOD=GyAZ25fFm0RmoEdawAxvLJ+_nJBTNmcEqg@mail.gmail.com>
Subject: Re: [PATCH v8 11/14] platform/x86: oxpec: Adhere to sysfs-class-hwmon
 and enable pwm on 2
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>,
	LKML <linux-kernel@vger.kernel.org>, sre@kernel.org, linux@weissschuh.net,
	Hans de Goede <hdegoede@redhat.com>, mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174444478157.30741.9183234111640429283@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Fri, 11 Apr 2025 at 17:13, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:
>
> > Currently, the driver does not adhere to the sysfs-class-hwmon
> > specification: 0 is used for auto fan control and 1 is used for manual
> > control. However, it is expected that 0 sets the fan to full speed,
> > 1 sets the fan to manual, and then 2 is used for automatic control.
> >
> > Therefore, change the sysfs API to reflect this and enable pwm on 2.
> >
> > As we are breaking the ABI for this driver, rename oxpec to oxp_ec,
> > reflecting the naming convention used by other drivers, to allow for
> > a smooth migration in current userspace programs.
>
> So there's no gracious deprecation of the previous interface? It doesn't
> sound "smooth" by any means from userspace perspective.

The previous interface was not compliant with the hwmon ABI, so any
software that used it without being cognisant of that would misbehave.

This driver got really fleshed out with 6.12, before that there was
one userspace software that relied on this. We made sure to update all
software that binds to oxpec specifically so it is not a problem now.

By adding a dash at the name at the same time as the change is done it
is possible to handle both the previous interface and this one at the
same time.

It is not ideal by any means, but if we don't change it now we will
not be able to again.

> > Closes: https://lore.kernel.org/linux-hwmon/20241027174836.8588-1-derek=
john.clark@gmail.com/
> > Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/platform/x86/oxpec.c | 37 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.=
c
> > index 5b84647569931..3bf2c597e9b00 100644
> > --- a/drivers/platform/x86/oxpec.c
> > +++ b/drivers/platform/x86/oxpec.c
> > @@ -731,7 +731,27 @@ static int oxp_platform_read(struct device *dev, e=
num hwmon_sensor_types type,
> >               case hwmon_pwm_input:
> >                       return oxp_pwm_input_read(val);
> >               case hwmon_pwm_enable:
> > -                     return oxp_pwm_read(val);
> > +                     ret =3D oxp_pwm_read(val);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     /* Check for auto and return 2 */
> > +                     if (!*val) {
> > +                             *val =3D 2;
> > +                             return 0;
> > +                     }
> > +
> > +                     /* Return 0 if at full fan speed, 1 otherwise */
> > +                     ret =3D oxp_pwm_fan_speed(val);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     if (*val =3D=3D 255)
> > +                             *val =3D 0;
> > +                     else
> > +                             *val =3D 1;
>
> Why all these literals? These should be named properly with defines are
> there some defines/enums for some of them already if this hwmon ABI?

Specifically for pwm_enable I don't think so actually. With a quick
grep all drivers I checked use literals.

> > +
> > +                     return 0;
> >               default:
> >                       break;
> >               }
> > @@ -745,15 +765,24 @@ static int oxp_platform_read(struct device *dev, =
enum hwmon_sensor_types type,
> >  static int oxp_platform_write(struct device *dev, enum hwmon_sensor_ty=
pes type,
> >                             u32 attr, int channel, long val)
> >  {
> > +     int ret;
> > +
> >       switch (type) {
> >       case hwmon_pwm:
> >               switch (attr) {
> >               case hwmon_pwm_enable:
> >                       if (val =3D=3D 1)
> >                               return oxp_pwm_enable();
> > -                     else if (val =3D=3D 0)
> > +                     else if (val =3D=3D 2)
> >                               return oxp_pwm_disable();
> > -                     return -EINVAL;
> > +                     else if (val !=3D 0)
>
> Literals here too should be changed.
>
> > +                             return -EINVAL;
> > +
> > +                     /* Enable PWM and set to max speed */
> > +                     ret =3D oxp_pwm_enable();
> > +                     if (ret)
> > +                             return ret;
> > +                     return oxp_pwm_input_write(255);
> >               case hwmon_pwm_input:
> >                       return oxp_pwm_input_write(val);
> >               default:
> > @@ -818,7 +847,7 @@ static int oxp_platform_probe(struct platform_devic=
e *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct device *hwdev;
> >
> > -     hwdev =3D devm_hwmon_device_register_with_info(dev, "oxpec", NULL=
,
> > +     hwdev =3D devm_hwmon_device_register_with_info(dev, "oxp_ec", NUL=
L,
> >                                                    &oxp_ec_chip_info, N=
ULL);
> >
> >       return PTR_ERR_OR_ZERO(hwdev);
> >
>
> --
>  i.

