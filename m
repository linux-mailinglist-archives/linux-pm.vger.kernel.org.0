Return-Path: <linux-pm+bounces-21101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6E0A2218C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 17:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE69C3A2FCB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D11DE4F9;
	Wed, 29 Jan 2025 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwHg8VcI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D981AAA1F;
	Wed, 29 Jan 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167517; cv=none; b=PyJ060VsHdAG8F9/NAPUptDQ0RbqzRSAEZl3XKY/ejjNORP07ig0ytn4x8/m++jHfCLKTYQAS1T90bQTrqS6VTT6t/1eq+2Qa+u9Be/TyY6m3ZaLl/pKr+iN3yPQFen2Ky7hgTw+JaQweLUnD15CuSBcR93x16N2EdW/2oml8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167517; c=relaxed/simple;
	bh=pJNynvJv0aYkZvx54P/lJKp3sxHHReX0PC+QAARokCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijhBqjC0k2r/NWggJhkWOTxLOUQdFIHbcmYzj03qS92ZVZqyTt+W20zUt+5vPDTKOIpWKFTefpF2FJ7vunHWXQNM1M9t0Gb/2+Ky96pGfayjrwkT3XLyn6nE1krPlrSUwNVMQOJReC4FP6B8IaC3gS2UixDhKgJKP9AXrTBjaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwHg8VcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19D8C4CEE1;
	Wed, 29 Jan 2025 16:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738167516;
	bh=pJNynvJv0aYkZvx54P/lJKp3sxHHReX0PC+QAARokCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TwHg8VcIwKBr73IOs1gKrNLuhKa33RBFmgNUg6p4qvoGc63rat8eMmh5BS3x+Pwus
	 TkSHOX+k3P7iEcEz7K9AEqLubN0L6GYJ2plpvDJui3o2u/GioPlFBLhrz0yl2i7jCv
	 JZsZ8f6lqMZ2sNnp3XaUpSTsxVzGbuKp9rVWq5DAkXiCKRGD2K1pM/e1RdNcqjdZ4J
	 WFvV5NGXjDGB+dI6bHO6UnobjfiAT9by+zq9V1ZbF5QgGFNYsrTJPCRJcGUYysvkrW
	 EbDgulXXjEvFEqdLnoMg2EvZe7KR5BrS+6H31bEaoUVH4n3WGP/QEX6zG0eoKVgM4I
	 JQiPQQUUGpzWg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e10e6a1ceso1826066a34.0;
        Wed, 29 Jan 2025 08:18:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtJHx8mq7z1+bJacDEOGdghCv7rpuDSwb0K/y9jBxpHp231+XRpwc77au4bPcF/qvgUeNEoX1LY8A=@vger.kernel.org, AJvYcCXDys2wehu1mIABYLriQdWBR3EoUQdtQGzSoUnktKsVeTPQUCFS6DicSZvvG/Lc1R+NQWI6/WAh6rsOI/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxELyWyEDJgEUAQ13NteU54ZIOe/tk60ASOzUkcYcYQo/fkfOa/
	ZOEp5EaU2za7yTOwHdJvas8tvgJbSCzf7oKmPsZgHdeLjrzvWCdjQNFHflg8YeYdJYgVNL95m/c
	YZadxhITtE9ku956IqU3iNy0jYtY=
X-Google-Smtp-Source: AGHT+IE9JMamln5EFNy+PFaKLFery2X/0ercM0JLQ84oUAh5rjJPUh52uxscUISBRqVt18f4ZfEjieq2YN7I5rh70II=
X-Received: by 2002:a05:6870:6111:b0:29e:57ec:34c3 with SMTP id
 586e51a60fabf-2b32f3078d9mr2147243fac.32.1738167515900; Wed, 29 Jan 2025
 08:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129112056.3051949-1-d-gole@ti.com>
In-Reply-To: <20250129112056.3051949-1-d-gole@ti.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Jan 2025 17:18:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iEoTapZP1-QHxe8UDc1oq3y12Tph0-mU=1NhPjNpYLQw@mail.gmail.com>
X-Gm-Features: AWEUYZnfnTnlJhMMzG9k9yM0N4EKtnrq2iwp-uXFhURtDWGD8bIh_DtVTTLVfFI
Message-ID: <CAJZ5v0iEoTapZP1-QHxe8UDc1oq3y12Tph0-mU=1NhPjNpYLQw@mail.gmail.com>
Subject: Re: [RFC PATCH] PM: wakeup: set device_set_wakeup_capable to false in
 case of error
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>, 
	Kevin Hilman <khilman@baylibre.com>, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 12:21=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:
>
> In device_init_wakeup enable, we first set device_set_wakeup_capable to
> true. However in case the device_wakeup_enable fails for whatever reason,
> there was no error handling being done.
> Consequenty, there was no cleanup being done to device_set_wakeup_capable=
.

s/Consequenty/Consequently/

> If a certain API is enabling something, it should take care of disabling =
it
> in error scenarios. In this case device_init_wakeup should on it's own
> check for errors and clean up accordingly.

Why do you think that failing device_wakeup_enable() will always mean
that the device is not in fact wakeup capable?

> Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>
> This patch was briefly proposed in a related thread [1], where this discu=
ssion
> was taking place.
> That probably got missed due to some confusion around the device_init_wak=
eup
> return value.
>
> There is infact error returning being done in drivers/base/power/wakeup.c=
, and
> ideally we should be using that info as done in this patch.
>
> If this patch get accepted, it might even bring forth few hidden bugs
> due to missing error handling, and it will also change the patch for
> devm_device_init_wakeup() helper slightly[2].
>
> [1] https://lore.kernel.org/linux-pm/20241218064335.c72gmw56ogtp36a2@lcpd=
911/
> [2] https://lore.kernel.org/linux-pm/20241214021652.3432500-1-joe@pf.is.s=
.u-tokyo.ac.jp/
>
> ---
>  include/linux/pm_wakeup.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index d501c09c60cd..ed62a7055a54 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -231,9 +231,13 @@ static inline void pm_wakeup_hard_event(struct devic=
e *dev)
>   */
>  static inline int device_init_wakeup(struct device *dev, bool enable)
>  {
> +       int err;
>         if (enable) {
>                 device_set_wakeup_capable(dev, true);
> -               return device_wakeup_enable(dev);
> +               err =3D device_wakeup_enable(dev);
> +               if (err)
> +                       device_set_wakeup_capable(dev, false);
> +               return err;
>         }
>         device_wakeup_disable(dev);
>         device_set_wakeup_capable(dev, false);
> --
> 2.34.1
>

