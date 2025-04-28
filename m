Return-Path: <linux-pm+bounces-26323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7C8A9F25D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1A17A8321
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 13:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D482025F96B;
	Mon, 28 Apr 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6qNiVLe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D827470;
	Mon, 28 Apr 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745847038; cv=none; b=UFC9vjbhaH0dO0t+uc1WMmopWweW/RmR/+8eA34LTxIkb+as1sYTjENdW98tJCTH0sTB4mg+ILttt+TUP+fJspECzx7A1fliSLQJrG6uEfE8bXMBgcc1pe0Yd3GmDBHXMSXVD2tdBJLXrXcebI2hFksUYNaH6Gqt3o4nJ5WcMLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745847038; c=relaxed/simple;
	bh=wcX0/Gbii5mG818cMWU1haHGSuHByWakDVyiTxnCZqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjCf5ViXK8ToxdQwEfv5jN1LX1whVVRQzx+Jn8dLCzU3FoEGAiMIAg0eqEneDKxSNsLNRS4ic2m+7eZ7VBPNCOd0EKh8mUNvC0DMKdq6z6WQczwe2I9bsUthKGkYj2pENVJK4dr5Y90DK98JxlVdaRz68JlzFknxrU9exWhz+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6qNiVLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27773C4CEED;
	Mon, 28 Apr 2025 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745847038;
	bh=wcX0/Gbii5mG818cMWU1haHGSuHByWakDVyiTxnCZqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K6qNiVLeN/psgmTjMc+BMCDZpyoU8H+McSplnrtf9PPYhjtgp777bNNFwjvotTL7q
	 svJgiMgZE6ZQe20Rtddm0NShuahrRGdKuk8YRFAbhfAxcPYblLfVZMXloeTTqdkXQ0
	 Zs/+UTES1YoKci1JZrCH/gSVqvBlf22dRKQ0Ym9n6lEomTZf4mRlMn6D5sWSkAjeRh
	 g1Y43WRBZfreK1FbLNev9ra9AQSoEV4sl6TyZBYBazmn99NjFI90xXpzYVB/pOZ3Be
	 kgm0k+huj6Oau8PNELkeXoVn/CGNdGKF67Y30G4pyZGuhRv3eJOGJQHa2QGkVsMEoY
	 DaQPBE484xL2A==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2d9b61e02d1so566872fac.2;
        Mon, 28 Apr 2025 06:30:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdXMfgINVuvOqKvnCL6BbAUVwsE6z5nutg3bXLUbG7vUnPRHY5GqslKcsX0qLx0bq6bTMMqJIAJvs=@vger.kernel.org, AJvYcCWtlg4ax3lnXo63L0TnMkBKdFDX9cMWuWGQkAI/1EQ5SwisgaBHvJuzq8HUmYo7Jfoym5YGShlup2IX4dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1PyUREDx9hNhoGcyYX2auFOvpblV5x3bUGXECzk8m0XyUHejH
	q47gIuCfHwmNqIhPlLie60bPcMywPz305pFPdxvRIIf/wtp5uK49zXEwEsnNwX8i7tfVN55YRgH
	5UrjmbwCBCWOVtM2KZw/f+oEkEhs=
X-Google-Smtp-Source: AGHT+IEct+NiFTV886e7v9qglyrvvU5cP2Spr1Eqhk7idTdAQcxrekH74EtkzDyQmOIRLV2dT5kQgEKGIgxTxvHR6cs=
X-Received: by 2002:a05:6870:b010:b0:2d5:b914:fe38 with SMTP id
 586e51a60fabf-2d9be923341mr4260391fac.37.1745847037425; Mon, 28 Apr 2025
 06:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_7F99ED4767C1AF7889D0D8AD50F34859CE06@qq.com>
In-Reply-To: <tencent_7F99ED4767C1AF7889D0D8AD50F34859CE06@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Apr 2025 15:30:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hM9KwdHRcoBjGRJq7y6wkQDFt+PMuU1k=3ARifDvOENA@mail.gmail.com>
X-Gm-Features: ATxdqUHJ6_zXi_Wqvz4LXfPkTTFxOUk8hKFqRCdm1Z6TsdkGdSeODYP2FSMc5Ks
Message-ID: <CAJZ5v0hM9KwdHRcoBjGRJq7y6wkQDFt+PMuU1k=3ARifDvOENA@mail.gmail.com>
Subject: Re: [PATCH v4 RESEND] PM: EM: Fix potential division-by-zero error in em_compute_costs()
To: Yaxiong Tian <iambestgod@qq.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 3:19=E2=80=AFAM Yaxiong Tian <iambestgod@qq.com> wr=
ote:
>
> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>
> When the device is of a non-CPU type, table[i].performance won't be
> initialized in the previous em_init_performance(), resulting in division
> by zero when calculating costs in em_compute_costs().
>
> Since the 'cost' algorithm is only used for EAS energy efficiency
> calculations and is currently not utilized by other device drivers, we
> should add the _is_cpu_device(dev) check to prevent this division-by-zero
> issue.
>
> Fixes: 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove divisio=
n")
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index d9b7e2b38c7a..41606247c277 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -233,6 +233,10 @@ static int em_compute_costs(struct device *dev, stru=
ct em_perf_state *table,
>         unsigned long prev_cost =3D ULONG_MAX;
>         int i, ret;
>
> +       /* This is needed only for CPUs and EAS skip other devices */
> +       if (!_is_cpu_device(dev))
> +               return 0;
> +
>         /* Compute the cost of each performance state. */
>         for (i =3D nr_states - 1; i >=3D 0; i--) {
>                 unsigned long power_res, cost;
> --

Applied as 6.16 material, thanks!

