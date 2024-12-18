Return-Path: <linux-pm+bounces-19455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015DC9F6E45
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68F31888C9A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E29A1FA826;
	Wed, 18 Dec 2024 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqxMxK4u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F01FC105
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550727; cv=none; b=CaaVuMtYBp2vY6V1ryDQSatH/oYtEUlPSm/A7ucz1e6zs/7NXRRj1y1i/ekmNlc82T6gDYbN22m1W7JIR5l1uaRLEEO2rVLsTNO2WfXoi9mI3VpED9eaaieo9yrJkYl0Qd4slUD7U50sQc/Ul47yqj2UXxaYEGnjOU5O4Hbp8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550727; c=relaxed/simple;
	bh=ZxYoxGXux8wJgZmCu91l5LfASeizOrhAXDqZH4aqDUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNP0VcSHJt+PMngsRdVEj8F8V965HkMCDz5jc+KNixDjAI5695KAhxhgpXDzfGeM98BkI6/9CVnGLw0WaiDPQJQBxJ8ZrPebEyZuipzSjtWKAQYZPlT4jEi1gZOBBQEVKy6WUNEul5R9zip9GeOZOvZmoBt7AzpNbeK8Zt/oP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqxMxK4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12165C4CECD
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734550727;
	bh=ZxYoxGXux8wJgZmCu91l5LfASeizOrhAXDqZH4aqDUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uqxMxK4u/5CmJ+0qPHj5Gvo4GDNheXu3uYZoVaxYvYqFPb1u+nFh3li0t4/mYzF/i
	 uCwl3XxG9O5mi8i9xVuZg5/tSZLHncQn+5zIxwpPlEqyaL0PTOZguUs3lUksLwTSq+
	 c+ePwAes39xcHn1hb4hubdo6CWjnVGL/nTPabBBqQIUXgM2x0gP3lSLYK9TWIae70c
	 +Kwh+K5KYUjRo8fXRgAsAhcYaMrMYcXkAAVc/8Zqm26Mp15C2rzROYDDFxFvVC0k4S
	 xy+TEtgg5pPX2MslFRVKysqvAuHrLjgBJuVWODSPRpNANQWH1iq5I0VC0jFXoo1FWY
	 YvjhubvLXxlyA==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eba50d6da7so1597854b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 11:38:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXzPjOO4BUZgvJPL8g8/ivmfWd8MEfSSv3uQDR8CApqX2FI1pMejUO9+XGWbXpNOFKZ5/Zl+u/GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweuvwFjk0s0k0lo69hv/rZg8zEgpNMh2d4mxtPnRq4vhIj/SR9
	wVs0FnmgMYft/cZ5D8GmJTmhLfmD2nFjoCTgBg3wlK/89xci+yyM5iaCSHLTUKthluMv4emB6ZP
	SVLLnaWmcfiOKbe1l7+6S6+Kcc/4=
X-Google-Smtp-Source: AGHT+IFQzgNMtehAIVr2BYKurBDtsIdTgPXBeNgD3vTDyqs2r9nwE5VH8BGS9FzItt2Rf9VkP+5hPFlUajwASFMPq+w=
X-Received: by 2002:a05:6808:138a:b0:3ea:57cf:7c26 with SMTP id
 5614622812f47-3eccc0b33a8mr3176474b6e.19.1734550726398; Wed, 18 Dec 2024
 11:38:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215071012.59208-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241215071012.59208-1-joe@pf.is.s.u-tokyo.ac.jp>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 20:38:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gmZc4wMDRmJFzdLdJef_E+OhSYh-99pauiX3_Pz2y9BQ@mail.gmail.com>
Message-ID: <CAJZ5v0gmZc4wMDRmJFzdLdJef_E+OhSYh-99pauiX3_Pz2y9BQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: balance device refcount in powercap_register_control_type()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 8:10=E2=80=AFAM Joe Hattori <joe@pf.is.s.u-tokyo.ac=
.jp> wrote:
>
> powercap_register_control_type() calls device_register(), but does not
> release the refcount of the device when it fails. Call put_device()
> before returning an error to balance the refcount.
>
> This bug was found by an experimental static analysis tool that I am
> developing.
>
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/powercap/powercap_sys.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_=
sys.c
> index 52c32dcbf7d8..c2d36dbe29e1 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -627,6 +627,7 @@ struct powercap_control_type *powercap_register_contr=
ol_type(
>         dev_set_name(&control_type->dev, "%s", name);
>         result =3D device_register(&control_type->dev);
>         if (result) {
> +               put_device(&control_type->dev);
>                 if (control_type->allocated)
>                         kfree(control_type);
>                 return ERR_PTR(result);
> --

Applied as 6.14 material, thanks!

