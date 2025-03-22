Return-Path: <linux-pm+bounces-24408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A51D4A6C85C
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 09:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111C71B60C59
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABBE1D63C0;
	Sat, 22 Mar 2025 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="hTaTbzhj"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115322612;
	Sat, 22 Mar 2025 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742632318; cv=none; b=Vp88k/nOV/3Z6o/yuNf1VgpB8tbw6ldYGcCtpVeYSNEt2F4PE/DMiqEPvLMJ5rrs4mFWTyOiWluJRe2M2pxirR5zK3oiSEOV9d45Cne2TtOCxUancFpAEf+HDZMnLrSEMc/lu4yi/goUu4h98dclAOuh4bV0mhc5p/HFOMZ66zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742632318; c=relaxed/simple;
	bh=QoYCuVA7WJWjffy5W2M+hJlbNlosEBUP3M7rM6uKD8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8J0I+9DeJKRCL+Xn289xp01lMNmmy3RibZdWP20JEyXb69ldJOab+joXIWdiquqny1Vo0KgM0KZv/9xL6R2oTNdUoHWMqgg8FVIfWKtR+QMgdHlzhMCa6a02cKjCWj0IDr/fXy0RSsB7bIiSDeBOMdlS7LCC+kgOV9XPej3gek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=hTaTbzhj; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 9B18E2E07CC0;
	Sat, 22 Mar 2025 10:31:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742632314;
	bh=L8bLEhdlBZ6u9TOuV2UuNIJUtMnFkd97B/SFwalxwEU=;
	h=Received:From:Subject:To;
	b=hTaTbzhjNngTm70bEWV/8HBNT+RmpL4iFqUgIaSrH+9HySm3hoIp9T7ovW4OcrAWj
	 XOUVqLjXfY3rrmk/FPLF05d97OfEccYffsODPolYiCSmJSV4A9SK+igz9+xJ6h3iQC
	 TIg40bzLtlpMsEMtv+Am6qzy11zMFgNurwHQtWms=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-30613802a6bso28260101fa.1;
        Sat, 22 Mar 2025 01:31:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUuIBoiuKQVmrbziplWhpgt+peqo9GfkgcbZiza23D4zScgZOl7iTGcZkMbn9P7GNeR29lZygxEi6M=@vger.kernel.org,
 AJvYcCV5kd+O+K/g1tNFHQZJS3NCUtebejRK9/8E8oy4/GD1xqHpO4fB7HnYqd5uVcPzMF3wDaco2ycofL3rOxM=@vger.kernel.org,
 AJvYcCWQJ436cxIAUt/wM7AQh1WyiEsPTtTbThI8vAykWOAHz0OvDHQu2NDD0hZSeD4c8788oGdsGIekIvk=@vger.kernel.org,
 AJvYcCXhPzC+Ztu7ltAW04mUmvYnT0BQX99/YS0YtipTACZdOBO/wA0wKzZ92Wn+h9OFIKTViX7vyA5QRg+SJl4f@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/lrwjANYd4GvAKEZ9DEPKzg56NYNjTiRSYNftFOvdNbEE5Nue
	2YDrLvKMhoo9E8K5ikXseKodNKWhN20gYrZbnD8+u4WFlU4jFY/DYDi2j+VwCW9Nmj92KuOqEqo
	WKpbRelxshMsusjO+LQ/d/keA4KA=
X-Google-Smtp-Source: 
 AGHT+IEof65vaDRL78PwFDIYXOPqdkFkB+5Oj5OnIXTjCMfnDT6p/q2TrKk1EIlDOMVNYvKS/OqKaE06U2AqaSSmwE0=
X-Received: by 2002:a05:651c:2205:b0:30b:9813:b00c with SMTP id
 38308e7fff4ca-30d7e2fff7emr24924621fa.27.1742632311844; Sat, 22 Mar 2025
 01:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319175512.27059-1-lkml@antheas.dev>
 <20250319175512.27059-12-lkml@antheas.dev>
 <96d19837-167a-43d6-93ea-cd24844cff7f@t-8ch.de>
In-Reply-To: <96d19837-167a-43d6-93ea-cd24844cff7f@t-8ch.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 22 Mar 2025 09:31:40 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEQivC-uDnZQ5ZRR7zKEVQkcFaVs3MgJXTiN_RMzF_MSQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpLtiFFH1tgMc5aEilhqsHIOW68X0_JQXvxieDGWR2vUrY4coLYlf3xEWM
Message-ID: 
 <CAGwozwEQivC-uDnZQ5ZRR7zKEVQkcFaVs3MgJXTiN_RMzF_MSQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/14] platform/x86: oxpec: Adhere to sysfs-class-hwmon
 and enable pwm on 2
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org, sre@kernel.org, ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com, mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174263231316.26351.14750796367721795071@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sat, 22 Mar 2025 at 09:24, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> =
wrote:
>
> On 2025-03-19 18:55:06+0100, Antheas Kapenekakis wrote:
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
> Where is the renaming being done?

Good catch thomas. When I did the battery rebase after v4 [1], it
seems to have moved from this patch to the battery patch [2]

Antheas

[1] https://lore.kernel.org/all/20250311165406.331046-13-lkml@antheas.dev/
[2] https://lore.kernel.org/all/20250319181044.392235-15-lkml@antheas.dev/

> > Closes: https://lore.kernel.org/linux-hwmon/20241027174836.8588-1-derek=
john.clark@gmail.com/
> > Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/platform/x86/oxpec.c | 35 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.=
c
> > index e84afc5f53379..680fa537babf6 100644
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
> > --
> > 2.48.1
> >

