Return-Path: <linux-pm+bounces-13451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1884396A744
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 21:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FDF1F2290F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A228A18F2CF;
	Tue,  3 Sep 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5OKd1kO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2C11D5CC6;
	Tue,  3 Sep 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391215; cv=none; b=Xaw84fVFK/whUiNzXiKSms8UGdoQdVtXx5l0B4yLwOi27rxBTSwjy5NfSGti6T8VtIj8SDq5bjMNJas2k34uo2YrtPHllIdiO6LMIt4X3aj05HATKaef38/zDvFvQ66d1JR3BkKpqZ+YJUd2EDAMIp+BZ5r6W52DWVC3NjqFIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391215; c=relaxed/simple;
	bh=cksDKNStvbeJj1FMPzP7UiyIQGPWWsWLf5dZK9KEdcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2ipvAErgX5dK9AibM2T7rzE2JCFYZLNUwj3NwA+4s7ApJgubt0MIbPL/j3T5GT+XygYe4/k/MguIYxsNo4dkFk+AIp4ERV860402qLCBuUy5jbLMQq9g0FXnXndq0WYUBgCiM/sUR25i6AGFnNQmEk5vyNBy2i4jvzog0GiStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5OKd1kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21043C4CECA;
	Tue,  3 Sep 2024 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391215;
	bh=cksDKNStvbeJj1FMPzP7UiyIQGPWWsWLf5dZK9KEdcE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h5OKd1kOKUVYqMyM9ufBEZpP3rpnKVpwcQoF+HgLtJ9zGoD7aR7/wWNzHkSQd1p5z
	 YEFTbL8EkLOeq7o2St8BAt8LWpu4ncsJY1ByMtofL8TJKgbyla5LRH2n6U0YYdzZbx
	 8INxFdHyEVLoYPAqUIyci0QXkcLZZ7ioNt0n5WQSMw8DeIAXRPHbrf4Uap1Z5xsUCZ
	 wzrbDjgEwMgAE47rEXlhiuW49YLmNt/kHpUSjbKRqhreY4HBR61w3pKgPYNdv5ExWg
	 ZajYyNWVCVjqgmV2e/e7qd/evuyYchJlQq+9EHLSjWpuY9twrQ6y0NBivNFFzAwsVS
	 OYYsVQdU1ccNw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f4f8742138so65052051fa.0;
        Tue, 03 Sep 2024 12:20:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTc///8wbwX9Eaauc/h2BtKUDHIJgcy/oZFJFhiN05Ir1jtd/Py7SaOtBAZS/EL0c684EJnF/tIbPM/6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXQbdSjsFsMXM92iGk3mc4CFt7UlSmeYxu5Nu8FUuZ+7VgLda
	sPvN+0wZiZJPgTuLZMfwLfXQAeUWErdrR0xo+loZhy89OwUct7AaEqg0orpZtMBi4jr4lzWCI7n
	0rPYzdgJA7z30OdztXWEmQ15Cag==
X-Google-Smtp-Source: AGHT+IHbJzfMD5ZbkBqZR1C5OTEDd2QkeDzZePElEq+3ELKFCi8thSJ3vRUZZzicZL0UEZ5fgm7rBi1VrffsCg8vqRA=
X-Received: by 2002:a05:651c:221a:b0:2f0:1f06:2b43 with SMTP id
 38308e7fff4ca-2f64d570aeemr13729221fa.41.1725391213513; Tue, 03 Sep 2024
 12:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-11-robh@kernel.org>
In-Reply-To: <20240731191312.1710417-11-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Sep 2024 14:20:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLgPmnVjrGOcV+Qbp5ExWK25qVbShawJK96LPNE=RqNig@mail.gmail.com>
Message-ID: <CAL_JsqLgPmnVjrGOcV+Qbp5ExWK25qVbShawJK96LPNE=RqNig@mail.gmail.com>
Subject: Re: [PATCH] devfreq: imx-bus: Use of_property_present()
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:13=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> Use of_property_present() to test for property presence rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/devfreq/imx-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ping!

>
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index 86850b7dea09..49798f542d68 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -59,7 +59,7 @@ static int imx_bus_init_icc(struct device *dev)
>         struct imx_bus *priv =3D dev_get_drvdata(dev);
>         const char *icc_driver_name;
>
> -       if (!of_get_property(dev->of_node, "#interconnect-cells", NULL))
> +       if (!of_property_present(dev->of_node, "#interconnect-cells"))
>                 return 0;
>         if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX)) {
>                 dev_warn(dev, "imx interconnect drivers disabled\n");
> --
> 2.43.0
>

