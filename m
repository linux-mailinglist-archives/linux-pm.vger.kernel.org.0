Return-Path: <linux-pm+bounces-17200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C42E9C1CAD
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 13:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E71B1C22F23
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A041E572F;
	Fri,  8 Nov 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEWRkHD3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6EB1E47CE;
	Fri,  8 Nov 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067758; cv=none; b=r9l0FC9yd5Y8kfT1IT9DhLS5VcojjuwcwTq3dtBCRQq598HWLaOZNcjNF9XOtS8JWZZyaavHq5CUqLs2UWlRkNFzUkHQuos/2SPiXxeHhDPgJHg0DvDpd+eoTFRTl27+So4PklVsRxh+wVWcsls/HeovsvaWKeQzjlmHvHn12Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067758; c=relaxed/simple;
	bh=ip2W+uSWSs4HJ0Umwf51InDV1CWXoXICkPZL470Ag7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPrfcwiaxV8vcBi0p22euE9iIj0L8zbda56CUiQRFy5M1sx61ff+RD6YpJlLApcGlXBqDUwpQ0ncaynYHaFWruk4oQN7T9uKe93TP4K+b7I9HQgN/SSS04Nux/Ughb/GbNBiPBWPFIIly1KK1HSdwPKfNReKVxcya+Wj6hfC6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEWRkHD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2933C4CED4;
	Fri,  8 Nov 2024 12:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731067757;
	bh=ip2W+uSWSs4HJ0Umwf51InDV1CWXoXICkPZL470Ag7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NEWRkHD32gZixICbkYYys60GMY7MVh8plRXb6awULMsovwf/85qGVuF7i7EHA3H1t
	 G/FXGknPRSxdOEbehz3BDJfApZYLZt4EbVdJ273XqjxdTh6mmsauynKjGmj+zWwePB
	 tmRggUtu6TbLE/ivrJsarxa2MEqzIXjzA6z/IzsXlIOoc8i/lvF92wAoGwC+T7vbJn
	 h8r+Uyy/frOIHtJcl97plymUnMsWxlXVXhE8I6i5YtvLoWyFJzxawr52V0mEvyysrg
	 bSEBQ0uz57/my+Uwv6Pvf7tazlFcipyBdSc0SSiWzZLx/vXdpxv1vr0YAvFcxi4wTe
	 SkhGZF/IkhIiQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-28896d9d9deso1032519fac.2;
        Fri, 08 Nov 2024 04:09:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeyk+UCqi4Q880LCJYa27zXh9n47jbuef+TCHdvnnuMf0OgpZnas6AUTkNypqgRBvQNBIjRpnCsBk=@vger.kernel.org, AJvYcCXsl+cE9C+H36IpQT3AnzS7iUT8VsZyuL2/rr50H3/fD59fx/jDVQDDm8YQI3zDH7qnEhuLCMLj+oGbuHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQSLpBdNuU2V8pYBoS8XgVAxfv9kB+ggOv8cSsuqVTQ9ODw2B
	PWwbyEPf0BkKgUgraBSWp/OaZWZVsP471klK8oMs+0OlHqRJU6otO3ubDSwRC1BTN1j2FGxLnwy
	IfVazqPQwF6Orpkz10ZPPepouNtI=
X-Google-Smtp-Source: AGHT+IF1/C5xlG7mIlZDVHks8V3bCbIdBNfrptAsUbwtk/KWGJ3JrSVwnwRAT0tFD+opYQnEMeyVSjO8Y/ckH0QWgtY=
X-Received: by 2002:a05:6870:e38c:b0:277:f5d8:b77b with SMTP id
 586e51a60fabf-295602a56e3mr2797000fac.32.1731067757095; Fri, 08 Nov 2024
 04:09:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108044700.37633-1-zhangjiao2@cmss.chinamobile.com>
In-Reply-To: <20241108044700.37633-1-zhangjiao2@cmss.chinamobile.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 Nov 2024 13:09:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gHGrRn0cLvsSTaX=tX8mVhxudoJ4aSh5jWNxh171oKgg@mail.gmail.com>
Message-ID: <CAJZ5v0gHGrRn0cLvsSTaX=tX8mVhxudoJ4aSh5jWNxh171oKgg@mail.gmail.com>
Subject: Re: [PATCH] tools/thermal: Fix common realloc mistake
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 7:39=E2=80=AFAM zhangjiao2
<zhangjiao2@cmss.chinamobile.com> wrote:
>
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>
> Do not set thermometer->tz NULL when realloc failed.

Presumably, this fixes a problem.

What problem does it fix?

> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  tools/thermal/thermometer/thermometer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/ther=
mometer/thermometer.c
> index 1a87a0a77f9f..e08291a97fd8 100644
> --- a/tools/thermal/thermometer/thermometer.c
> +++ b/tools/thermal/thermometer/thermometer.c
> @@ -259,6 +259,7 @@ static int thermometer_add_tz(const char *path, const=
 char *name, int polling,
>  {
>         int fd;
>         char tz_path[PATH_MAX];
> +       void *tmp;
>
>         sprintf(tz_path, CLASS_THERMAL"/%s/temp", path);
>
> @@ -268,12 +269,13 @@ static int thermometer_add_tz(const char *path, con=
st char *name, int polling,
>                 return -1;
>         }
>
> -       thermometer->tz =3D realloc(thermometer->tz,
> +       tmp =3D realloc(thermometer->tz,
>                                   sizeof(*thermometer->tz) * (thermometer=
->nr_tz + 1));
> -       if (!thermometer->tz) {
> +       if (!tmp) {
>                 ERROR("Failed to allocate thermometer->tz\n");
>                 return -1;
>         }
> +       thermometer->tz =3D tmp;
>
>         thermometer->tz[thermometer->nr_tz].fd_temp =3D fd;
>         thermometer->tz[thermometer->nr_tz].name =3D strdup(name);
> --
> 2.33.0
>
>
>
>

