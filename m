Return-Path: <linux-pm+bounces-10295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00991E62F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 19:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F1E1F23D03
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960CF16DED5;
	Mon,  1 Jul 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1MvCpoT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA7A16DEC8;
	Mon,  1 Jul 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853617; cv=none; b=XGwEl5JBtYHgCrDLYHsCn04LQ1sW2YiUUS/Nphdz6ZeS8OQrU9H+HhvkeIrzbeDf3o7rB3ERQ8UOKor62xwqEPrB5KyC5IMbkU8rTqWLQaHkO4Zf/QBc+bbOWk+mlWrhimikVBvbV5tpLVcSKhSXTNYV6O+4uhi/m4V7vfqdxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853617; c=relaxed/simple;
	bh=2MHUMtUTr2rUtINqeV5IrNWFoQd81TAN0bY26G+DKoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9JUBeK13VyWKwO4p8c5bTOjFiqnur222S9qVqV05x8RU/a2DzUmvSEwxFAdecpgKet9urLH4hwGNsuGt0/dC32kRa2LPyL7H8kgvLRwFP/Fj1dFpN/XvgHXrIMG9M1AaPBhWH4IFvLAgkdqZ3IJbQ1vmXDqJ2EMsmeD6uR/37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1MvCpoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE90C32786;
	Mon,  1 Jul 2024 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719853617;
	bh=2MHUMtUTr2rUtINqeV5IrNWFoQd81TAN0bY26G+DKoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A1MvCpoTKaLOQfFZUdGfxwjJZFH6PulvN5kioPxVuWXm2Q6uX1H/064U/jby+kadS
	 Tfwzz+VLat2rqIpkZHoAQchWcTyj8Woe8Z3u3pFsfE7a9Bh2GU4amkQpnI826XNIym
	 QY7t9uuCfVwd1Z4D6ZmYuWfk0A3eVTKH6BRx0vOeNMCmFq4uQyi6N5QQbWL+FLYXc9
	 M5pIQP1vvoFgzXCTZ7mBJ2RsG59VaPscFbrYDAbSEjZdjHxnMgOMtuHTcCkNrJtlAz
	 MuezoDNOE8se+93zsm/SwC0MTVzJzpBwPCexoDlTaBIRlJ6YwIVBLGxdmBm/UnBPLI
	 Tnrk9p0d0onJw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25cb022c0e6so421062fac.0;
        Mon, 01 Jul 2024 10:06:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0WexqW3K4G1FGJdRo7mnleH9f8RRzBDloSshVTrIkTxz61WA6qa+5BQ6qSutkhGQ6c1ATHFY1UD4zH2BQGAHA+VuDBbkSnpjYpxk1p3m4Yo7AQ1UmF47gxa0cF/dMNLhhOY8zk34=
X-Gm-Message-State: AOJu0YwmWW8VRX0+7OUM2uoKF2l4dvfTAmvFgCAZLdBs/xfRoNQpYDMh
	f7Mq13sTqPBXrX1KNxlKXE7Qm8WEdu1IxQoLEKcBiAtdeNUmGVZ6GQmdChy5/8yP5TGfdeal8Ui
	1yZhwz8u/G8Cj3sRPqXh9AFHICxc=
X-Google-Smtp-Source: AGHT+IEyPvXu/dDq0QuY+drlNclWMjinscF8HzLFNro78MKqrQbiyKMolAUvlrXEuV5qtJNQyhjVYzMi23lOxek8EeU=
X-Received: by 2002:a05:6870:9629:b0:25c:ad1f:b335 with SMTP id
 586e51a60fabf-25db363c020mr6276623fac.4.1719853616592; Mon, 01 Jul 2024
 10:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_2ACBECB5B8EF2442CE608CE48F8E6131CC09@qq.com>
In-Reply-To: <tencent_2ACBECB5B8EF2442CE608CE48F8E6131CC09@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 19:06:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ioSZaB39Xb5W7R4Y5b6chYNnU0qTy6feVaY8-ucm0dqg@mail.gmail.com>
Message-ID: <CAJZ5v0ioSZaB39Xb5W7R4Y5b6chYNnU0qTy6feVaY8-ucm0dqg@mail.gmail.com>
Subject: Re: [PATCH] drivers/cpuidle: Fix guest_halt_poll_ns failed to take effect
To: ysay <570260087@qq.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ysay <ysaydong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 11:01=E2=80=AFAM ysay <570260087@qq.com> wrote:
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

This should carry a Fixes: tag pointing to the commit fixed by it.

Also, is it -stable material?

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

