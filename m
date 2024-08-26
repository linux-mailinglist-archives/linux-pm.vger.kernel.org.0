Return-Path: <linux-pm+bounces-12898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AAE95F835
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 19:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8CB1C21B52
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6D2198E89;
	Mon, 26 Aug 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFhMatMq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1B198E84;
	Mon, 26 Aug 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693583; cv=none; b=levpVPXRHPQy4Glz6KyjVt6UeVqQHK9E2GZDakg6VGSmQm9QYUcwDHrRoGJlRKiDaJzdw1jKlgGQelgbI9QFZOoafN2xb0VwP39wTzpE+k2p3kZmDJF814DkvjLjBV7TKfamT5wm6Ipe3ONDpIaivi5mX3KM+fbu+eVNr5Z0xlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693583; c=relaxed/simple;
	bh=TAh6Bl1VLr1EWHR5IFo9O+tDZgymLTN1OTXOZRGQQg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhonBj/A95lYmszcHWeRLWUB0x+0QB6qbZTUCfSpwt/VB2WIaRPxAMWWxv0bjs6H4sMIj5os8oOG/UnSSkktFPGxfHl+4837OKKZ0ihy54jATiMiiBkDBJbTHKPE3/HNgIYdNAh6zr/as7YTL+HC3ZDBAXcw4jdVzJSveke9jKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFhMatMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27306C8B7B7;
	Mon, 26 Aug 2024 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724693583;
	bh=TAh6Bl1VLr1EWHR5IFo9O+tDZgymLTN1OTXOZRGQQg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vFhMatMq++we8GsDVkjMSZ5V+XOzeCBM0jCASf1ecE7B3mJ806+s36hXg45nAdV9Z
	 vFphtkEorTrEsSOusgAXlzVxq5BwrLvk2e6nNCBujrjPf1j71ZOo19I1opnFjfhMDN
	 KLOcU5rj3rWLEO/Eod9BT9ZYv959KEnFbRm4minS/QcEbfw0CQUqZRU4bu8pneBjtP
	 U1e7m8I78wQJHwGU38Hy8iIuWQ1ibf7qx4JaqjwYWZP3iQFhl4g58Tos3kylxW5uxv
	 bN5LAzt8iuPijoURrpEgh3i5yXaKBgWClVv+bVGZA+q7qZjatZdjR4UU0FNeI3yBmQ
	 fIBneDHDpVeDA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2705dd4ba64so3191883fac.3;
        Mon, 26 Aug 2024 10:33:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIFPUPHGmCCN9x6djZhy2446Q5K4zDDlPXN6sVZ0Rr8v0uZ4K1brHlW5tc4Wjnq0ipIFuD7cOGaqKZ8Og=@vger.kernel.org, AJvYcCV206tPrgvrlEtzVW0SJY5iIH8ApdudZ9NlS7MrsUwoVzqT3gQ34j2AMOGHBKCL340e73N2uj0H5fc=@vger.kernel.org, AJvYcCWRv7PB1DyszB76fE6VmOmbSEWIt+n7GNUuFnzsrF+T5ZuPdsu4TqEl4dGAx7TorhtMUUpv/Dbs@vger.kernel.org
X-Gm-Message-State: AOJu0YyzST6ESEA/k1kqve3+vPtWfYzS7YzTQtnZUqGwaOaBCUgrgmvX
	gNOnYW/F+/M+D8/TyaIq96nYFd2uhvtd/10v3p0tpSD4q1f7HLPN8gIV4v+uA55glTkLDDSz2tA
	Inx3s6X8UlFJVtWlMqdEaSMJ2ytA=
X-Google-Smtp-Source: AGHT+IFSrSBZa62SwXA+5JbHIGCzklV8q64pAeJZw2PY0F5WyUkkpcfoaNJSjtZqpIeCsacUKPDi+IBq53muwhJ7UpE=
X-Received: by 2002:a05:6870:4713:b0:260:f75c:c28b with SMTP id
 586e51a60fabf-273e646d7a8mr11338790fac.8.1724693582147; Mon, 26 Aug 2024
 10:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_13F0C81B16C09CC67E961B5E22F78CC72805@qq.com>
In-Reply-To: <tencent_13F0C81B16C09CC67E961B5E22F78CC72805@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 19:32:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hC6G7Xvd=jzCvS4re3kk0-h72DdXCkwFiBV8xzT8doOw@mail.gmail.com>
Message-ID: <CAJZ5v0hC6G7Xvd=jzCvS4re3kk0-h72DdXCkwFiBV8xzT8doOw@mail.gmail.com>
Subject: Re: [PATCH] Fixes: 496d0a648509 ("cpuidle: Fix guest_halt_poll_ns
 failed to take effect when setting guest_halt_poll_allow_shrink=N")
To: Yanhao Dong <570260087@qq.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, ysaydong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Why did you put a Fixes; tag in the subject?

Please provide a proper subject and put the Fixes: tag next to the
Signed-off-by: one below.

On Mon, Aug 26, 2024 at 11:07=E2=80=AFAM Yanhao Dong <570260087@qq.com> wro=
te:
>
> From: ysay <ysaydong@gmail.com>
>
> When guest_halt_poll_allow_shrink=3DN,setting guest_halt_poll_ns
> from a large value to 0 does not reset the CPU polling time,
> despite guest_halt_poll_ns being intended as a mandatory maximum
> time limit.
>
> The problem was situated in the adjust_poll_limit() within
> drivers/cpuidle/governors/haltpoll.c:79.
>
> Specifically, when guest_halt_poll_allow_shrink was set to N,
> resetting guest_halt_poll_ns to zero did not lead to executing any
> section of code that adjusts dev->poll_limit_ns.
>
> The issue has been resolved by relocating the check and assignment for
> dev->poll_limit_ns outside of the conditional block.
> This ensures that every modification to guest_halt_poll_ns
> properly influences the CPU polling time.
>
> Signed-off-by: ysay <ysaydong@gmail.com>
> ---
>  drivers/cpuidle/governors/haltpoll.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/gover=
nors/haltpoll.c
> index 663b7f164..99c6260d7 100644
> --- a/drivers/cpuidle/governors/haltpoll.c
> +++ b/drivers/cpuidle/governors/haltpoll.c
> @@ -78,26 +78,22 @@ static int haltpoll_select(struct cpuidle_driver *drv=
,
>
>  static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
>  {
> -       unsigned int val;
> +       unsigned int val =3D dev->poll_limit_ns;
>
>         /* Grow cpu_halt_poll_us if
>          * cpu_halt_poll_us < block_ns < guest_halt_poll_us
>          */
>         if (block_ns > dev->poll_limit_ns && block_ns <=3D guest_halt_pol=
l_ns) {
> -               val =3D dev->poll_limit_ns * guest_halt_poll_grow;
> +               val *=3D guest_halt_poll_grow;
>
>                 if (val < guest_halt_poll_grow_start)
>                         val =3D guest_halt_poll_grow_start;
> -               if (val > guest_halt_poll_ns)
> -                       val =3D guest_halt_poll_ns;
>
>                 trace_guest_halt_poll_ns_grow(val, dev->poll_limit_ns);
> -               dev->poll_limit_ns =3D val;
>         } else if (block_ns > guest_halt_poll_ns &&
>                    guest_halt_poll_allow_shrink) {
>                 unsigned int shrink =3D guest_halt_poll_shrink;
>
> -               val =3D dev->poll_limit_ns;
>                 if (shrink =3D=3D 0) {
>                         val =3D 0;
>                 } else {
> @@ -108,8 +104,12 @@ static void adjust_poll_limit(struct cpuidle_device =
*dev, u64 block_ns)
>                 }
>
>                 trace_guest_halt_poll_ns_shrink(val, dev->poll_limit_ns);
> -               dev->poll_limit_ns =3D val;
>         }
> +
> +       if (val > guest_halt_poll_ns)
> +               val =3D guest_halt_poll_ns;
> +
> +       dev->poll_limit_ns =3D val;
>  }
>
>  /**
> --
> 2.43.5
>
>

