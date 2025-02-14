Return-Path: <linux-pm+bounces-22112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872D2A36776
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 22:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B231893B0E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC71C861B;
	Fri, 14 Feb 2025 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCJ0qwxn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB84158870;
	Fri, 14 Feb 2025 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568295; cv=none; b=iw+6sMmu6FtpeeAsX4lbUX23kaoBbiFDYeM5IGcLLaaFVOwSX2tZNvsDLYKJRt2SN9gI50XnQD5mGgGXW9vRqhuLl2+0DApcC0rA5/cXIrAkczs5xVbAdAnMekfZrpd7vOSHddGaV669klyalKORHnVmrDGzvV6ES5d2upspBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568295; c=relaxed/simple;
	bh=EzLv1PXDSqrSgIGdd+Ne0LCQSPCxPjBW79dJ8940ZBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2zloZDnPYboBChOVXfyuOkgsWwg3sP5eWT/uforRAT1duiYIpuYFY5jmJGql6eObRkDS7O04MiLWYAj/PgqDfTdAji/3PdWO3bXA/nO8hMYASCTBvYGilsK3ajKIuskbp4EFGZMffjCFKwH2OFemFy1Mt6AXxGCzyOMTXzz+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCJ0qwxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00968C4CEDF;
	Fri, 14 Feb 2025 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568295;
	bh=EzLv1PXDSqrSgIGdd+Ne0LCQSPCxPjBW79dJ8940ZBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jCJ0qwxnVhC21iVM09GsHY5We2ktTclhzhJn1KwiCozsvnFJdQP7T5WqCiJiRTcgD
	 OcId0pVJK7KKzE74qyaJstEGpRviSQo8M81d1P4OG4/UoaY+VtuOur7HR9y719/qiN
	 FvqKd75OtP3cP5A6pM+BOAxTVGhWui22JQkI47zyA33irOya85l/s1c3WdUcdULz8b
	 byLHh3xIAwNouT3QHkWuOX6Wh5+aWcYV8fIL8/cGeRxNb1c+cleWmgAcy8fTt5mxV/
	 eOPySx8spEj2lZwZse+HeyIjcMdas3cjI1IOJ0tW0FiAy5yDW1KsppNmnsB/Oqab5w
	 ZV6d6Ni9fIMww==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7271239d89fso48664a34.0;
        Fri, 14 Feb 2025 13:24:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWBZqVmM1ZPQTuXy9gfBA6aLEvy6r+O7iyaTN7czLCzqIpqe7dWgxmVcAwqyUr5LUI9HfxjIoxWM8ct7U=@vger.kernel.org, AJvYcCVV1jA+goLkaTDpMTU9b1AK6yos5Uki9zA/3INVR0qhyGn97KZhGpXXW9TRHqx8dIqb+c5p3B8ehSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1IROEXjCmawOUDCrJCF1mBWXW0eLkobSB9rVTSsyKRXib7DB
	kB5jhV0c33kzjhQqL7zma+iVBWtRZBa23WH2XDrveEq9M+BmaVH0RysepfcgmYvjKsID3QpmJC8
	Rw6TY07u/Vk7TMXYN9IOHAI6s4fo=
X-Google-Smtp-Source: AGHT+IGH7ThwbfO5wqEDV+pwCch4O/d4lXFcYV2d7xcYrEEB2ig4ZwKzHwpL04riTFSwMJej92QX2x/ZkQUc7MPioxM=
X-Received: by 2002:a05:6870:82a1:b0:2b8:2f9c:d513 with SMTP id
 586e51a60fabf-2bc99b57b8bmr398470fac.19.1739568294249; Fri, 14 Feb 2025
 13:24:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214102130.3000-1-johan+linaro@kernel.org>
In-Reply-To: <20250214102130.3000-1-johan+linaro@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Feb 2025 22:24:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gKOFgLEUhyFBO82o+2e8n84pwoa99BrgGLy5fYxGaJRg@mail.gmail.com>
X-Gm-Features: AWEUYZmslmIYyELyGXTmYS0eCvCxMB2HqErQkRxh5kE0kADjlSsc8Ha_KhVEMIk
Message-ID: <CAJZ5v0gKOFgLEUhyFBO82o+2e8n84pwoa99BrgGLy5fYxGaJRg@mail.gmail.com>
Subject: Re: [PATCH] bus: simple-pm-bus: fix forced runtime PM use
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liu Ying <victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 11:21=E2=80=AFAM Johan Hovold <johan+linaro@kernel.=
org> wrote:
>
> The simple-pm-bus driver only enables runtime PM for some buses
> ('simple-pm-bus') yet has started calling pm_runtime_force_suspend() and
> pm_runtime_force_resume() during system suspend unconditionally.
>
> This currently works, but that is not obvious and depends on
> implementation details which may change at some point.
>
> Add dedicated system sleep ops and only call pm_runtime_force_suspend()
> and pm_runtime_force_resume() for buses that use runtime PM to avoid any
> future surprises.
>
> Fixes: c45839309c3d ("drivers: bus: simple-pm-bus: Use clocks")
> Cc: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/bus/simple-pm-bus.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> index 5dea31769f9a..d8e029e7e53f 100644
> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -109,9 +109,29 @@ static int simple_pm_bus_runtime_resume(struct devic=
e *dev)
>         return 0;
>  }
>
> +static int simple_pm_bus_suspend(struct device *dev)
> +{
> +       struct simple_pm_bus *bus =3D dev_get_drvdata(dev);
> +
> +       if (!bus)
> +               return 0;
> +
> +       return pm_runtime_force_suspend(dev);
> +}
> +
> +static int simple_pm_bus_resume(struct device *dev)
> +{
> +       struct simple_pm_bus *bus =3D dev_get_drvdata(dev);
> +
> +       if (!bus)
> +               return 0;
> +
> +       return pm_runtime_force_resume(dev);
> +}
> +
>  static const struct dev_pm_ops simple_pm_bus_pm_ops =3D {
>         RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend, simple_pm_bus_runti=
me_resume, NULL)
> -       NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_fo=
rce_resume)
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(simple_pm_bus_suspend, simple_pm_bus_re=
sume)
>  };
>
>  #define ONLY_BUS       ((void *) 1) /* Match if the device is only a bus=
. */
> --

