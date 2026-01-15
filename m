Return-Path: <linux-pm+bounces-40947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF911D2857D
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 21:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6018230A4B4E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 20:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7564320CCE;
	Thu, 15 Jan 2026 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOMzhbaG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A85320382
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507992; cv=none; b=Kkajvj0jr7VaVY1WoU/XEU3VOB+oJj+9XKrPK6I9twCHewNNjXIwvuGKAOnIEaTdcb5mOeJI8909Akf+FVFPEQXJyJyA2MBOGCty7P89aeXPgooR0+hk2BzWO0xevE4ajiHndfTZqn0wP37eTlexPlYjATNzGgLqhXtgpn8S86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507992; c=relaxed/simple;
	bh=GbWDP5EXcjqoGcASLvp9iGA/BFkPYLSVC3JXWxCcRtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpC4b62fu6asMpDfjSLwPtAtiJQny8CrYZGnpPzyhrLDCTitlO3mikC6QxNYQIS4v4JVy+saVIp/F6sfIhto4iI/p6fl5CeHaNB5t4OwiFFa1cRw/0GpCqBqedA+AXSZKt/1DsNFiyvw2jaY75U1tBJQFd1daKzCHwjdzGi5jv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOMzhbaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87EFC16AAE
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768507992;
	bh=GbWDP5EXcjqoGcASLvp9iGA/BFkPYLSVC3JXWxCcRtw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kOMzhbaGXa+tjQUZT51fLst21dSnz8L0P/Ei6Hg9kqcEUo/vMCZ2pnyNBFiw0z7TJ
	 +DMTbFvNa0fty8TUmpqjT/26gBc/ZRk2l52wYYFsTzbItWuvPeTuiMQtoCiquBuNUZ
	 hTMOWCPgkGTdcVfXE0ND8ofIdTGjiA0vY94FjSX0Pr/IlNchKHFAYwY3CNCw1qZpY8
	 60O9NMoseclpR4uDR2MDucSfSpRTxWN3J80GbxiD5CsdPKJQAXKh+dEHaFH1AUH4Rt
	 aYRrbOiVhsziEq1YcNVmomP6VuHM/AIIRqbRfavaY8B/hmuuGa9Grz4cucvefxpW9t
	 PGQVk6YIRsD7A==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6610f045c1eso567638eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 12:13:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUs/Vd/KONcA5/joyaxzs6bBjP0ZK0T3HIdR0+IZIL5pUvYMQs7I+DI5UrbUw8pDVk1ifyDX+FkYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlzOs17+psOJQMZD3ontF4G9v4MLne8R/IaQsmcEoj+OJpxQdP
	v1mG2T/5t0hyP6/ko34PVlVzjZgWxervfHyCmA/wtNDRacw2N+LZNGsBErgSN+2Su4jDUt27bx8
	VOGPXZYMMPKIDLACVNg+WR2mabfh2618=
X-Received: by 2002:a05:6820:f004:b0:659:9a49:8feb with SMTP id
 006d021491bc7-6611796df12mr426034eaf.24.1768507991811; Thu, 15 Jan 2026
 12:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111141237.12340-1-sumeet4linux@gmail.com>
In-Reply-To: <20260111141237.12340-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Jan 2026 21:13:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jJw70jM-NqF9A30UsBcya0arZ6yMXZYhvATimZOhppLA@mail.gmail.com>
X-Gm-Features: AZwV_QgSpR3fgATrLxZ9g_QbnRNoIMNbpmZjZSn4K6NlVUflWUsJwktn6S3sbjU
Message-ID: <CAJZ5v0jJw70jM-NqF9A30UsBcya0arZ6yMXZYhvATimZOhppLA@mail.gmail.com>
Subject: Re: [PATCH] powercap: Replace sprintf() with sysfs_emit() in sysfs
 show functions
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 3:12=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> Replace all sprintf() calls with sysfs_emit() in sysfs show functions.
> sysfs_emit() is preferred over sprintf() for formatting sysfs output
> as it provides better bounds checking and prevents potential buffer
> overflows.
> Also, replace sprintf() with sysfs_emit() in show_constraint_name()
> and simplify the code by removing the redundant strlen() call since
> sysfs_emit() returns the length.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/powercap/powercap_sys.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_=
sys.c
> index 1ff369880beb..f3b2ae635305 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -27,7 +27,7 @@ static ssize_t _attr##_show(struct device *dev, \
>         \
>         if (power_zone->ops->get_##_attr) { \
>                 if (!power_zone->ops->get_##_attr(power_zone, &value)) \
> -                       len =3D sprintf(buf, "%lld\n", value); \
> +                       len =3D sysfs_emit(buf, "%lld\n", value); \
>         } \
>         \
>         return len; \
> @@ -75,7 +75,7 @@ static ssize_t show_constraint_##_attr(struct device *d=
ev, \
>         pconst =3D &power_zone->constraints[id]; \
>         if (pconst && pconst->ops && pconst->ops->get_##_attr) { \
>                 if (!pconst->ops->get_##_attr(power_zone, id, &value)) \
> -                       len =3D sprintf(buf, "%lld\n", value); \
> +                       len =3D sysfs_emit(buf, "%lld\n", value); \
>         } \
>         \
>         return len; \
> @@ -171,9 +171,8 @@ static ssize_t show_constraint_name(struct device *de=
v,
>         if (pconst && pconst->ops && pconst->ops->get_name) {
>                 name =3D pconst->ops->get_name(power_zone, id);
>                 if (name) {
> -                       sprintf(buf, "%.*s\n", POWERCAP_CONSTRAINT_NAME_L=
EN - 1,
> -                               name);
> -                       len =3D strlen(buf);
> +                       len =3D sysfs_emit(buf, "%.*s\n",
> +                                        POWERCAP_CONSTRAINT_NAME_LEN - 1=
, name);
>                 }
>         }
>
> @@ -350,7 +349,7 @@ static ssize_t name_show(struct device *dev,
>  {
>         struct powercap_zone *power_zone =3D to_powercap_zone(dev);
>
> -       return sprintf(buf, "%s\n", power_zone->name);
> +       return sysfs_emit(buf, "%s\n", power_zone->name);
>  }
>
>  static DEVICE_ATTR_RO(name);
> @@ -438,7 +437,7 @@ static ssize_t enabled_show(struct device *dev,
>                                 mode =3D false;
>         }
>
> -       return sprintf(buf, "%d\n", mode);
> +       return sysfs_emit(buf, "%d\n", mode);
>  }
>
>  static ssize_t enabled_store(struct device *dev,
> --

Applied as 6.20 material, thanks!

