Return-Path: <linux-pm+bounces-30305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7AAAFB95A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 18:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE80F5609A5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E545A2949ED;
	Mon,  7 Jul 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rcgh7ctZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2C28C2C3;
	Mon,  7 Jul 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907448; cv=none; b=sR74nmcsYQ82NJvHZZXnv9fTDjkfC37iRsu7Y/7qLkOXVDc2KuBu5wpAHls+HAcUivXIOnXJ3OmHRjtGYVf+zLXfqagJFHEJ4Im2zGD5I/O+QtwLwIBKWT7l6OWWF202iqjR1YO+TAhDKWkAH5eE3e1qCQ17bJEf5SbON4HW62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907448; c=relaxed/simple;
	bh=tNNr80vT7oFBRYr1+P4foxOFm7tJDFnWWkbUlEpN0kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpoVZXh9/4ckKktwIcZv/+wmkiufOarcAjPB3NWHL4px4Iw7+0bBCII0s3XACd4DRmoEOXY0Ei0GHXvZrdA09bB7AIPgxKkaWprmXFi0uALo6YeniXJrM9/R26APwz1hgR+zFNosOEXafcoXapQrp0jmMPLJrk1vkWK+x687TiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rcgh7ctZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D0FC4CEE3;
	Mon,  7 Jul 2025 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751907448;
	bh=tNNr80vT7oFBRYr1+P4foxOFm7tJDFnWWkbUlEpN0kc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rcgh7ctZ7DlnsMRiM1U/8VlbtnvRWehPdVS8ZZU9wKmj1cpCUPmmfB4loyA++p3fq
	 penbj0UXO3pZjt+I8N2O9g9QNAcR9FGqYUx0SwN+Z0kbqL7DXxJGS8P4FVETLyEjEB
	 wUp+BQt5Qp3H9xykE5y3JBv8ovGyvUUrCETAsvjiK+CxsyrUAI8wCvIpPO7zJjSZJz
	 8/jgFjI+/JqPw297MQcaG/hZPajlZW7daXI3EtDe5yW8ONUcaqTFItM19kD0mAfYZ9
	 /+wh8S8EAz4eRT5q/5zC7XFflfKyqVJ3U+2Qo8BqxtM3Y2Q9WNr+Fg9Xf0nKG+425R
	 zAzwpEGqLp42w==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-60d666804ebso2480987eaf.1;
        Mon, 07 Jul 2025 09:57:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtQ7IrCaQ+RVuASDuUcFXPEqVMYjAInaLR3yjyrDc4/No9QBhBdso2ebmUaCs2tNBhtg6WPwX2@vger.kernel.org, AJvYcCWUBI72x0Uxgr+WiGs43j8nQEpSNcQlVR4fcIeuQ4yyRw1UAIUMlDGCkGdp3u0ILAcHd70uTGIichFbN6Q=@vger.kernel.org, AJvYcCWqXgw4vMvqlHPkg/VurcYQXJjV7U5hLshUoZwlHccv9/RwYalFp/5vODY1I2849Q1hh8hG7MBs4+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbhON56R82qecQC6Rk6hy18OkozNZ3Q8a4e2FJ7QlbsAHiuGkJ
	ajPI6hNHzzVn8fpdfbHeqiUhrsJSkYQjPCEQEKKEZ38gXOV+JQdzRHw8pvpean/vF88rW8M59tD
	kdrYcTJpOc9K8m+XVbXlGi2T2LjIJbe4=
X-Google-Smtp-Source: AGHT+IELhvUdbErMoodFxPp5UcX5oIhVVIY14d49V912ioILHXfP/Mqq4p8T++smi+2bzoWhvw7mgmof0hvX3aZg6FQ=
X-Received: by 2002:a4a:bb8d:0:b0:611:5a9e:51c4 with SMTP id
 006d021491bc7-613c03bcf11mr98988eaf.4.1751907447677; Mon, 07 Jul 2025
 09:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org>
In-Reply-To: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jul 2025 18:57:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOm4-qmAGGswk9nuPb45UGabNK-DqkcZEGmTO71tRLkQ@mail.gmail.com>
X-Gm-Features: Ac12FXxAanzGlIkOQgjFHOTHg1kMQRxJ2B69g__BbWCYP_YxWs5cjixLuT7YgZk
Message-ID: <CAJZ5v0gOm4-qmAGGswk9nuPb45UGabNK-DqkcZEGmTO71tRLkQ@mail.gmail.com>
Subject: Re: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 12:27=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.o=
rg> wrote:
>
> After commit 725f31f300e3 ("thermal/of: support thermal zones w/o trips
> subnode") was backported on 6.6 stable branch as commit d3304dbc2d5f
> ("thermal/of: support thermal zones w/o trips subnode"), thermal zones
> w/o trips subnode still fail to register since `mask` argument is not
> set correctly. When number of trips subnode is 0, `mask` must be 0 to
> pass the check in `thermal_zone_device_register_with_trips()`.
>
> Set `mask` to 0 when there's no trips subnode.
>
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>  drivers/thermal/thermal_of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 0f520cf923a1e684411a3077ad283551395eec11..97aeb869abf5179dfa512dd74=
4725121ec7fd0d9 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -514,7 +514,7 @@ static struct thermal_zone_device *thermal_of_zone_re=
gister(struct device_node *
>         of_ops->bind =3D thermal_of_bind;
>         of_ops->unbind =3D thermal_of_unbind;
>
> -       mask =3D GENMASK_ULL((ntrips) - 1, 0);
> +       mask =3D ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;
>
>         tz =3D thermal_zone_device_register_with_trips(np->name, trips, n=
trips,
>                                                      mask, data, of_ops, =
&tzp,
>
> ---

If this issue is present in the mainline, it is not necessary to
mention "stable" in the changelog.

Just post a patch against the mainline with an appropriate Fixes: tag.

Thanks!

