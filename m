Return-Path: <linux-pm+bounces-16286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3245A9AC76A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC5D1C20DF3
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D978619D8A8;
	Wed, 23 Oct 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9EFuW/l"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51613C836;
	Wed, 23 Oct 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678196; cv=none; b=tQRKZq8fY3ZLnO9XxqLZotbX6hTxVmuZE1rhQO4erSjVH0HVFZIBV8svSY4ayHgy9wLqgeEthwoXb7+ptly9L0dhyNxaLuif5xgvf86Q/TrS8PvSCeKtLAvB8JLQAdrwxdHmihetetngU8ZWS0ngVldxmutSZg2FMhANHkDhCVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678196; c=relaxed/simple;
	bh=3+7KK3MYd0AO0JEwRkr/m5qoHt4QL1/FO6wzjLuG/XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uadXYRdTraJwFU9G2nLGpsFFXyPv0NXP7VcZ9VT0OPh0PagsPV9kTKO8JbDtD5kjNmBsEAnZehqUzVA8q81qfwzCiQS3COh/Rmuohm0qCjRKQGCWJZB6JF0DD1oi500fO8Lvbqo3ipn73wlpdNEOjH8tHefMxE0gX/0JJUc9Wc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9EFuW/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF97C4CEE5;
	Wed, 23 Oct 2024 10:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729678196;
	bh=3+7KK3MYd0AO0JEwRkr/m5qoHt4QL1/FO6wzjLuG/XE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r9EFuW/lI+zRSGlAeCCr1wbyPczFbuUzUiaMx8naz8hhxhl8Vw3Ylo0gyeEQstZPU
	 88AqBzRgZ075CWNXeEHgyjFZrFOQ4w6uwMkQrpKaKvd1GCINqGwgTCDx563DLvp8KY
	 G+l8LAHh8v5LBUuKBWN9XMNhdHdK3PIIuEjMv6gGi84s4EO00s1XK6wVr2fRM6sTFc
	 xTXzwiAm3InzVHru6SLht8SIl6z0Vl4CL5/O6u340zT5kptiriz2XkS89m39O2yYh+
	 OWb8KM6ChXNvOcA2/Wnc20h8ykcVychT4r4sAo5Flj0nc/moElDeBcjY102Kzq+PMK
	 eLPTjPHXwGmDQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-288dfdaf833so3384734fac.3;
        Wed, 23 Oct 2024 03:09:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIlWI132IQvWPRmUNMEw3naQZUdTFzSTUFPSKkhQwhZA1yL+2MjBB270KclpZRjphQEbZXAqwl6wEo2C8=@vger.kernel.org, AJvYcCXwAXOlm60nLz0udSSorY3Di2dnhW5R6ga1PKyKhTQw42t+8cI0mnUWSX9m2SW4pbPQpb2L/nnPkqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg5yIQz4q1W04JCWS8KGz2qRdNuiaViseUAVFbxdTC5CNKucrK
	v65r4xh7cC//44u2akF0D09cMRHMuS8DZU5anX2/H2C/TAOQO0DF++Mu7InLuMQfvKAf82TTTHL
	jnS7GrqKEd3jpOaSLVtR77+Y6L78=
X-Google-Smtp-Source: AGHT+IFwxmaW/VuDdyPK3Iq1c8Yrq1K7IU4+yKVTI3NiMFrV80zFAIbPJTwu4H27IEQ0oWUxG5zOZ2gNM1YDedj91J0=
X-Received: by 2002:a05:6871:207:b0:277:d7f1:db53 with SMTP id
 586e51a60fabf-28ccb410e75mr2128499fac.17.1729678195559; Wed, 23 Oct 2024
 03:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021121138.422-1-zhengshaobo1@xiaomi.com>
In-Reply-To: <20241021121138.422-1-zhengshaobo1@xiaomi.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Oct 2024 12:09:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g=uyPA1QH-gQbTZBim7EB8Fn+8Q_7Bc+eOmPqGaDQh0A@mail.gmail.com>
Message-ID: <CAJZ5v0g=uyPA1QH-gQbTZBim7EB8Fn+8Q_7Bc+eOmPqGaDQh0A@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Granted power set to max
 when nobody request power
To: ZhengShaobo <zhengshaobo1@xiaomi.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhuzhangwei <chuci@xiaomi.com>, dingchongchong <dingchongchong@xiaomi.com>, 
	chendejun <chendejun@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 2:12=E2=80=AFPM ZhengShaobo <zhengshaobo1@xiaomi.co=
m> wrote:
>
> From: zhengshaobo1 <zhengshaobo1@xiaomi.com>
>
> When total_req_power is 0, divvy_up_power() will set granted_power to 0,
> and cdev will be limited to the lowest performance. If our polling delay
> is set to 200ms, it means that cdev cannot perform better within 200ms
> even if cdev has a sudden load. This will affect the performance of cdev
> and is not as expected.
>
> For this reason, if nobody requests power, then set the granted power to
> the max_power.
>
> Signed-off-by: zhengshaobo1 <zhengshaobo1@xiaomi.com>

I would have applied this, but your S-o-b above needs to be fixed.
Why don't you use your real name there?

If it can be changed to "ZhengShaobo <zhengshaobo1@xiaomi.com>",
please let me know, and I will fix it for you when applying the patch.

> ---
>  drivers/thermal/gov_power_allocator.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 1b2345a697c5..4301516c0938 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -356,11 +356,19 @@ static void divvy_up_power(struct power_actor *powe=
r, int num_actors,
>         u32 extra_power =3D 0;
>         int i;
>
> -       /*
> -        * Prevent division by 0 if none of the actors request power.
> -        */
> -       if (!total_req_power)
> -               total_req_power =3D 1;
> +       if (!total_req_power) {
> +               /*
> +                * Nobody requested anything, just give everybody
> +                * the maximum power
> +                */
> +               for (i =3D 0; i < num_actors; i++) {
> +                       struct power_actor *pa =3D &power[i];
> +
> +                       pa->granted_power =3D pa->max_power;
> +               }
> +
> +               return;
> +       }
>
>         for (i =3D 0; i < num_actors; i++) {
>                 struct power_actor *pa =3D &power[i];
> --
> 2.43.0
>

