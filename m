Return-Path: <linux-pm+bounces-19429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FA39F67D1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 15:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FAF16A350
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7B61BEF66;
	Wed, 18 Dec 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS666hh0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914121B424B;
	Wed, 18 Dec 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530408; cv=none; b=HRIMdHzAZ9MzouVUbLe0VwWwYppd9USoXoQsHxAuKGG/i5+0dnRBQPGNuRg3UTn9PZ/L94B1qKKTpTJQ5Kn0QT7Sjqx+AMbhf19of5y9YMG09tbbJnKqXpx+R6NInPsiI3z4wDSVdYNNAUmusR4IBfmuK4PyHqJlT0fPQgc1aak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530408; c=relaxed/simple;
	bh=jdYphwB5yrFqyQlo2lsvcPBK3asXRD6NbipXT+9+YhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6FxRcTNb12clyNWCJy7M8eAVZuJRb9Rv7NunkVTlwQPmQCqIUmGgZ71iKOl+XJV9EzRnxlbUUaoStUwbsfwtalQimh5d7PraRcAg+HHZ/8r9Z55DbvXCpPaJwIgEzI7NdMnqrqPe6vAolNlxBG2ylz81WwAsOqbHdVCV7Hi8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS666hh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D85C4CECE;
	Wed, 18 Dec 2024 14:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734530407;
	bh=jdYphwB5yrFqyQlo2lsvcPBK3asXRD6NbipXT+9+YhI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CS666hh0T6fRX1RnoGsAHg8HvpXVc+HBrRhXow7cMysfnB0YYe03qyL3lm6n9Rb1e
	 ueKTlprFeMXFCfQ0OPlSP3xN6U4TS6v1zZQJpLK53UQjdsNHiOwcMl377jvh8qyuw3
	 4FO8wFSA9M18DRLTwsM9ymdphfmam4X1rV1v+5+IsLSiEjjs1V3YoKcT+WXulm6Ux5
	 dXkAtTP0cQGpwAKBhk0YmZL7gpnmlzirr1BMOHtTFznAkTIVAJcSkqwkP0ct7vh36G
	 ONbd+FPLlnwYig/iFpJE/zVSANYkgATaamc5Mx5IeM/0RwBv9ofS3NvdD6samawKci
	 DvPzGq4mE727A==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ebc678b5c9so1363025b6e.3;
        Wed, 18 Dec 2024 06:00:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQoPd01FiCA6PmFFKRzPUroUXl5pLl8fci+x9LPSprnvroPZ4eqS+k/3ajFe3m8TRRL9KLRIUMjOM=@vger.kernel.org, AJvYcCVtRQUISRo7gw82ff1ycoGcU1Tmp1cTtfjSGxTr9g1r+suYka0EmVpLJpsiYPqfFnc8/nFUBY3aY7iJMBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiIHqNXVsdA/E5V9HBo/O0AJf4nzGuWHKZlJbggLZo+7IOATwU
	heLXGNQI2ORP8gS2+YXGafwV9Ecy6BREGnBcVjXAle1Fd58VOIlZ3LHLusKx7ap8yX6lmAupDSu
	rvd0Gk8YVDgRMviqXQ4XEbWQWVPE=
X-Google-Smtp-Source: AGHT+IFiwwT2xErgUiEq/7jIa3r2/gNzYCCCrPhfDzMsSfWbeUZKHjSYT/MzTrOq5SiGh96r6Tjt91AqF9EnNtkOs9k=
X-Received: by 2002:a05:6808:2183:b0:3e7:9f1f:b84a with SMTP id
 5614622812f47-3eccc0d8ec5mr1625599b6e.21.1734530406328; Wed, 18 Dec 2024
 06:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211020645.2123881-1-make_ruc2021@163.com>
In-Reply-To: <20241211020645.2123881-1-make_ruc2021@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 14:59:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hi=Hh5RL0whSTxD7Gd+59R44v7B5bQv0JThw6i93L-Zw@mail.gmail.com>
Message-ID: <CAJZ5v0hi=Hh5RL0whSTxD7Gd+59R44v7B5bQv0JThw6i93L-Zw@mail.gmail.com>
Subject: Re: [PATCH] powercap: Check dev_set_name() return value
To: Ma Ke <make_ruc2021@163.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 3:07=E2=80=AFAM Ma Ke <make_ruc2021@163.com> wrote:
>
> It's possible that dev_set_name() returns -ENOMEM. We could catch and
> handle it by adding dev_set_name() return value check.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/powercap/powercap_sys.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_=
sys.c
> index 52c32dcbf7d8..11db93b10aa5 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -552,9 +552,12 @@ struct powercap_zone *powercap_register_zone(
>         power_zone->dev_attr_groups[0] =3D &power_zone->dev_zone_attr_gro=
up;
>         power_zone->dev_attr_groups[1] =3D NULL;
>         power_zone->dev.groups =3D power_zone->dev_attr_groups;
> -       dev_set_name(&power_zone->dev, "%s:%x",
> +       result =3D dev_set_name(&power_zone->dev, "%s:%x",
>                                         dev_name(power_zone->dev.parent),
>                                         power_zone->id);
> +       if (result)
> +               goto err_dev_ret;
> +

Why is it necessary to fail in this case?

>         result =3D device_register(&power_zone->dev);
>         if (result) {
>                 put_device(&power_zone->dev);
> --

