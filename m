Return-Path: <linux-pm+bounces-22512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AA2A3CBA8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182263AE923
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391B8256C98;
	Wed, 19 Feb 2025 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8mzYQ6A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156C1C5F35;
	Wed, 19 Feb 2025 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001271; cv=none; b=VJ3m0xKaFod9J33UKNtzhN1z2+czPEalmlrviZaO3D6ZJ9eMwLSrT/s3m2zYwKbpAut0WBsKJFItzYzRPIvbm1xApGPi0p+vkSRRNsx6wX3YtDVfCw8ROFygu0FtV8fghAYT1QOiShlSgroWAQih1ig/ZP5EjAK5T8vwEcOUpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001271; c=relaxed/simple;
	bh=r1bLBSrB/oSSuywo7vnvRAZKO2skODEyrEjHC27eUZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYaQPDwapYkyCjHCdl2wjrCyZaXFoqyJ6vpTrgt2A+mhbkvghVZjq/MqkaTJUCy5ok/ktPIesCVvg31gtMGkPHtXT06ii1pCxBGVPKyF8Kn+BCkzAzBgXDid27LMyjsWirCs/uK7QrkzGj6ZIn1GKozmZSodG51hv4l2JHUdWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8mzYQ6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84644C4CED1;
	Wed, 19 Feb 2025 21:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740001270;
	bh=r1bLBSrB/oSSuywo7vnvRAZKO2skODEyrEjHC27eUZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G8mzYQ6A2kmEfouwOz9TQDtus3S0m8vnJ+l5FuNqF9qUHmrPhicw6cMcwb4FlouZi
	 2JLZkM3/Pr/NkeP4VTPzJUFlYupttFCRF2hbroY7EtuupCC1/S81i9fhAfh+imrNz4
	 A5nnZFzp3dTu5/IFjiEO7Cnw+3bKzie9WUEJMKi6tl/gGLh/Dr1YkitdnNHfnUOBji
	 MEmRRXTH124KNyQOos5wJdCj1mdFo1H3kNzQFCJldSt1Zb7O2j36A2obeKMDLj0K2c
	 NfUtTb6X4DnrY3BSBtoXi/w4Uu+1dfk5ZUk0+fM5oiFFstxudr/94hf1mL4/q1J+d8
	 UckIo9QQHrB+Q==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb6b16f1a0so84537b6e.3;
        Wed, 19 Feb 2025 13:41:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcEpbQ5udpxy33a9CQqPmLfqK4UBqBa4z6jUUfjtssH56ShOOGny273LupUarLmMOKreWFt9GGQIo=@vger.kernel.org, AJvYcCXu1HtRqnRNdhS9As9IOn+hiwjP+/yAqso12IFYl2ZX5NaWKOZdpsNsMPnov4+nZmnZaTjpIQeXziSCKAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmigcQIjLTetxoX3SEBiUhX2mx6rds1XYa3nCmhPVthwyEgK/V
	t/ree/lkkLkHTWakg/GQUSgAzjdG9oBZFC5HU39Xb4L3NKw+BANDYYqhTyAXm8v9TOdPg9pO2pB
	SFXb21+6p88xUuwpF0h2tl+k5Ixk=
X-Google-Smtp-Source: AGHT+IFfMwFanWZlcxY4vRvho5N7M8BH8nOHWmqG9wgJCf3xqFgCH96KjIziEg+awBrhs+URwGsmNdeWAogHcTNfRl4=
X-Received: by 2002:a05:6808:3199:b0:3f3:bde3:4f75 with SMTP id
 5614622812f47-3f3eb0925c7mr14082765b6e.3.1740001269865; Wed, 19 Feb 2025
 13:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-fix-thermal-of-v1-1-de36e7a590c4@chromium.org>
In-Reply-To: <20250219-fix-thermal-of-v1-1-de36e7a590c4@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Feb 2025 22:40:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i=Ehi1icm4Tx6cXmdhjq-Qj8Vwv1SwzCyx5oBj-5y9hQ@mail.gmail.com>
X-Gm-Features: AWEUYZmHsgWDQ_-BAeQSQIQ2ZBKoL7qhjVqIh_bJF4Hl2ya26uoOUqszd7zkuhk
Message-ID: <CAJZ5v0i=Ehi1icm4Tx6cXmdhjq-Qj8Vwv1SwzCyx5oBj-5y9hQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: of: Fix logic in thermal_of_should_bind
To: Yu-Che Cheng <giver@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 8:06=E2=80=AFAM Yu-Che Cheng <giver@chromium.org> w=
rote:
>
> The current thermal_of_should_bind will stop iterating cooling-maps on
> the first matched trip point, leading to subsequent cooling devices
> binding to the same trip point failing to find the cooling spec.
>
> The iteration should continue enumerating subsequent cooling-maps if the
> target cooling device is not found.
>
> Fix the logic to break only when a matched cooling device is found.

OK, but ->

> Fixes: 94c6110b0b13 ("thermal/of: Use the .should_bind() thermal zone cal=
lback")
> Signed-off-by: Yu-Che Cheng <giver@chromium.org>
> ---
>  drivers/thermal/thermal_of.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 5ab4ce4daaeb..69c530e38574 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -312,7 +312,8 @@ static bool thermal_of_should_bind(struct thermal_zon=
e_device *tz,
>                                 break;

-> I'd prefer to do a jump from here, that is

-                                 break;
+                                goto put_cm_np;
>                 }
>
> -               break;

and remove the break statement above altogether.

> +               if (result)
> +                       break;
>         }
>

And of course the label needs to be added too:

+put_cm_np:
>         of_node_put(cm_np);
>
> ---

