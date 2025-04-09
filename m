Return-Path: <linux-pm+bounces-25024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 111DEA82DB9
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071AE18844CB
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D806126FA5D;
	Wed,  9 Apr 2025 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R095+pdI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3441C5D7D;
	Wed,  9 Apr 2025 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220165; cv=none; b=XUq8tVqIphCb1WTY3BhkO69Ldht38rLrmSsX/o8Hw0PyeoNQ+gZF5F7B3nv43OK5ux9O0hr0/0837yD7Wd+64aEASCZ+puw4IaqZUHuZjtgrX+Zjl64p15a/dOC3ULGvVDv1X3IgBAVrwc1Un8ijOYzXXYrnALpfL58Vxi5lM1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220165; c=relaxed/simple;
	bh=118j6dSY2LWufoMHA0NQiowWmkCyuLbqD1TJeYp1heE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tv2AeBupAspJgux1VWgaN/wtoyuxgzYYs1LuU+T3mV8XAQa+4Ikt/fpTZSdDeTwJ+YzF2fFEheG+72IMQBDkKaSN5SLX3+zgrvtAK2BHm6DXgcEOAkkqFRWzN6SZZXq3IcuKHgAAuwopirB4YL2iLSyfAKh0mUorwyMpZm0TB1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R095+pdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E547C4CEE7;
	Wed,  9 Apr 2025 17:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744220165;
	bh=118j6dSY2LWufoMHA0NQiowWmkCyuLbqD1TJeYp1heE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R095+pdIFdyFVKIvdunsyUvXeKwsJkTl+HOo7bxwLGFcQ97SbLIKHH5ZvVJeiGn1g
	 qLbiFhUmFNP1N9Qixi4sYaKlhXxw3/SrnxMsFt+S6m+9ExfF/eRtlNTOFIcelXrNzU
	 lY7Yu4lHr3fnA4mEiaCX2Urx7sZ5jh/7jenFoxZOgC7/KMG35n+mPWXllR49ObQWkc
	 nMs8FmeiypsFR0ege4oE+KUWYqFeLucwCiMYcW2/PXRM7qj0QQLK0BuSHWc4dU/SP5
	 eSoC2VKpTShb0wnoXFPMQiwpnKCcKJVAzOanIiTFygQjdzw5/giGp6XQux3g/8642E
	 Di1EnjT1xq21g==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-603ff8e915aso1795877eaf.3;
        Wed, 09 Apr 2025 10:36:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrcWAsVsYzY0Za1wdjtt1xfOp+ljGzS9J1s6sYM/CPPc0IVleaXgKTmD4GomU+m+ah66fiu/ABJT/cWlg=@vger.kernel.org, AJvYcCVEizAdJQrgfeWuL9DA8gN/SIsoncCaPA3/+VpCVh4AC0m8aQFZ0n5xx5v0NYwL3kXhJGCtIaPGiwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdytfDMdFCwwZkAowztw4qf47GMkWBi0R107dSZUWXzlUYMr+w
	SZFucdgb0q+cT0/8KyzZkc0Sg/OTzLSptDXSf5ZAAmiCMd+gCi/OM1hYb0HvtfdW1cVGoD4Zm2A
	Nro3Y37nf/6q23b4zjokPHOIhJp8=
X-Google-Smtp-Source: AGHT+IHBnYpZQiiOB3am9fC3lA9CN47uPxJnr9ShV+UAV/NROnWurDgTFqjecZi6QaLUkY3Qg5a/TrQjclVUDTQOQ4Q=
X-Received: by 2002:a05:6871:aa17:b0:2c1:5b95:5f1b with SMTP id
 586e51a60fabf-2d08ddf6828mr2251840fac.23.1744220164390; Wed, 09 Apr 2025
 10:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405060909.2026332-1-atulpant.linux@gmail.com>
In-Reply-To: <20250405060909.2026332-1-atulpant.linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 19:35:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gu+5P=rnM=JC67kC-6dfO2P00oMBh7=73j+Et8beas3A@mail.gmail.com>
X-Gm-Features: ATxdqUHyYoKwZwhyf74Kld-IO1Ir59iLSTW5nbCU5hxN-WDSRonxjztLWGuBWaQ
Message-ID: <CAJZ5v0gu+5P=rnM=JC67kC-6dfO2P00oMBh7=73j+Et8beas3A@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: governors: Fixes typos in comments
To: Atul Kumar Pant <atulpant.linux@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 8:09=E2=80=AFAM Atul Kumar Pant <atulpant.linux@gmai=
l.com> wrote:
>
> Fixes typos and corrects spelling in the comments.
>
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  drivers/cpuidle/governors/teo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/=
teo.c
> index 8fe5e1b47..bfa55c1ea 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -19,7 +19,7 @@
>   *
>   * Of course, non-timer wakeup sources are more important in some use ca=
ses,
>   * but even then it is generally unnecessary to consider idle duration v=
alues
> - * greater than the time time till the next timer event, referred as the=
 sleep
> + * greater than the time till the next timer event, referred as the slee=
p
>   * length in what follows, because the closest timer will ultimately wak=
e up the
>   * CPU anyway unless it is woken up earlier.
>   *
> @@ -311,7 +311,7 @@ static int teo_select(struct cpuidle_driver *drv, str=
uct cpuidle_device *dev,
>                 struct cpuidle_state *s =3D &drv->states[i];
>
>                 /*
> -                * Update the sums of idle state mertics for all of the s=
tates
> +                * Update the sums of idle state metrics for all of the s=
tates
>                  * shallower than the current one.
>                  */
>                 intercept_sum +=3D prev_bin->intercepts;
> --

Applied as 6.16 material with some edits in the subject and changelog, than=
ks!

