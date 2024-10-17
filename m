Return-Path: <linux-pm+bounces-15862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C3C9A205E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 12:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325B4B23EF6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37C91DAC9F;
	Thu, 17 Oct 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W496lQ2b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F31DA0E9;
	Thu, 17 Oct 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162619; cv=none; b=DP6wQuqooPyHRaASV6s9/J3mK8hGJvWMKIsgpQ2Baw8wH+44tTzyv975xupCaBNODnk6Ymk4VnG03lwM5aHWdIXuIgMUUa+3ky4MRo5qFDXDWLnP2l5+35mp4Wqgfw2tsW9k/jd3sK67nIyYbccLLl9IySLlXAlkrUee2WVHJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162619; c=relaxed/simple;
	bh=D5RTI9FOOit5KbbEFT2DC25/vMJ92nKXQzGoJvbMPXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeQqUZ4TeabVYgF8Wjv9sO8R7PUhyUQH3L5/4Q6mWt78ut12uylyyKyEJFh6CwD5wrseXeeb8Tw5Cl8+JSeOC6nmp4Ge49df0qPIfF8bC2hultVX+sBG04F6MNv08Fa6DWrd55cg0MU8XoOmDEdXvSNdaotAbfzTF60CJc7JVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W496lQ2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47365C4CEC7;
	Thu, 17 Oct 2024 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729162619;
	bh=D5RTI9FOOit5KbbEFT2DC25/vMJ92nKXQzGoJvbMPXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W496lQ2byJnSKa4PxIA6n48H3WC7Bs1q2K3W4oDOcLlweMFNQWgZ3djy/HUpd4RGG
	 A0T7QaN3+Ai6zhhKvCCCHB5m+3oObmvkLcajISB3+2RbgnJip2x37PFRlYcEINMLyt
	 2XAexB3kyQ4Re4LEFYqbRfiry8qzvDaA4swkMAyxARATSiwrsTvqCX5G1gTnt9b+Yd
	 EGElnt0+/PqR3WJYWqpNMzQka2aziGRs9yEhg/+Mm3GUyu1FJNHrkvgbn2fzGph1DC
	 x64HYV4eBCRcmFNn7w6jKe6Y5eyzasLk+s3FLjqe/cOJ1tgGU6tF+wQHfBvBVGatpL
	 mywAaKVtCPXTw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5daa93677e1so444279eaf.3;
        Thu, 17 Oct 2024 03:56:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwGz+PpJBtzNJqKT4Mtb9RYeYM7Mu4/uHAW+EfoVP+FZ2p6g8LabXiOJoLGz92SqM76M472pywsVg=@vger.kernel.org, AJvYcCXfIyI2T1v5sAM1rifm1Cv2JKhe3HeBJpHFhMFltP5uDbJkaB1NtaGHGlrRxHbFM1g8AKzyEprnAaVrxfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcv0ieJwXJgM/ndB0Tupp9k+QW1iSDIcAOFbYRaYxIwTSOvJuE
	ZvFKPGMvlkOey9Tn4GV9uMnRkOxRxhEq5nSGHG4DpVyCsO79qwiJodVWD8xLNlTJ7VHooF/yJy3
	Hx4ytHGvGQSjjiOoCOOZCEKHRCoM=
X-Google-Smtp-Source: AGHT+IFf3YEvrAc2/G0NQs4QVU7cxHfpnuZAN/b8kSqqUTXMoL2fKaVj+DCbNBkFcsDdYZgqgYOgXLv1o81cmRIrryA=
X-Received: by 2002:a05:6870:e0ca:b0:27c:475c:ab2c with SMTP id
 586e51a60fabf-288ee12a3e2mr6407221fac.43.1729162618602; Thu, 17 Oct 2024
 03:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017090503.1006068-1-wenst@chromium.org>
In-Reply-To: <20241017090503.1006068-1-wenst@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Oct 2024 12:56:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hZUzubeLt2OBcG=F5QKFh-0V8yqYRoQL0iHK+y+zeZFg@mail.gmail.com>
Message-ID: <CAJZ5v0hZUzubeLt2OBcG=F5QKFh-0V8yqYRoQL0iHK+y+zeZFg@mail.gmail.com>
Subject: Re: [PATCH v3] thermal/of: support thermal zones w/o trips subnode
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Icenowy Zheng <uwu@icenowy.me>, Mark Brown <broonie@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:05=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> From: Icenowy Zheng <uwu@icenowy.me>
>
> Although the current device tree binding of thermal zones require the
> trips subnode, the binding in kernel v5.15 does not require it, and many
> device trees shipped with the kernel, for example,
> allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64, still
> comply to the old binding and contain no trips subnode.
>
> Allow the code to successfully register thermal zones w/o trips subnode
> for DT binding compatibility now.
>
> Furtherly, the inconsistency between DTs and bindings should be resolved
> by either adding empty trips subnode or dropping the trips subnode
> requirement.
>
> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Stacked on top of Krzysztof's cleanup patches
>   - thermal: of: Use scoped memory and OF handling to simplify thermal_of=
_trips_init() [1]
> - Adjusted to account for eliminated error path
>
> [1] https://lore.kernel.org/all/20241010-b4-cleanup-h-of-node-put-thermal=
-v4-2-bfbe29ad81f4@linaro.org/
>
> Changes since v1:
> - set *ntrips at beginning of thermal_of_trips_init()
> - Keep goto out_of_node_put in of_get_child_count(trips) =3D=3D 0 branch
> - Check return value of thermal_of_trips_init(), if it is -ENXIO, print
>   warning and clear |trips| pointer
> - Drop |mask| change, as the variable was removed
>
> I kept Mark's reviewed-by since the changes are more stylish than
> functional.
> ---
>  drivers/thermal/thermal_of.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 93f7c6f8d06d..be1fa6478c21 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -99,14 +99,14 @@ static struct thermal_trip *thermal_of_trips_init(str=
uct device_node *np, int *n
>
>         struct device_node *trips __free(device_node) =3D of_get_child_by=
_name(np, "trips");
>         if (!trips) {
> -               pr_err("Failed to find 'trips' node\n");
> -               return ERR_PTR(-EINVAL);
> +               pr_debug("Failed to find 'trips' node\n");
> +               return ERR_PTR(-ENXIO);

Why not

*ntrips =3D 0;
return NULL;

>         }
>
>         count =3D of_get_child_count(trips);
>         if (!count) {
> -               pr_err("No trip point defined\n");
> -               return ERR_PTR(-EINVAL);
> +               pr_debug("No trip point defined\n");
> +               return ERR_PTR(-ENXIO);

Is this based on the current mainline code?

>         }
>
>         struct thermal_trip *tt __free(kfree) =3D kzalloc(sizeof(*tt) * c=
ount, GFP_KERNEL);
> @@ -386,9 +386,15 @@ static struct thermal_zone_device *thermal_of_zone_r=
egister(struct device_node *
>
>         trips =3D thermal_of_trips_init(np, &ntrips);
>         if (IS_ERR(trips)) {
> -               pr_err("Failed to find trip points for %pOFn id=3D%d\n", =
sensor, id);
> -               ret =3D PTR_ERR(trips);
> -               goto out_of_node_put;
> +               if (PTR_ERR(trips) !=3D -ENXIO) {
> +                       pr_err("Failed to find trip points for %pOFn id=
=3D%d\n", sensor, id);
> +                       ret =3D PTR_ERR(trips);
> +                       goto out_of_node_put;
> +               }
> +
> +               pr_warn("Failed to find trip points for %pOFn id=3D%d\n",=
 sensor, id);

Wouldn't pr_info() be sufficient for this?

> +               trips =3D NULL;
> +               ntrips =3D 0;
>         }
>
>         ret =3D thermal_of_monitor_init(np, &delay, &pdelay);
> --

