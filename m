Return-Path: <linux-pm+bounces-30048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3BFAF76F4
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA2454383C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FB02E7BCB;
	Thu,  3 Jul 2025 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+f6Y0td"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277351AAA1C;
	Thu,  3 Jul 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552123; cv=none; b=qg4bZaRkxUtlbDWecNqBHAgmP5DH9rLhUHhjDgA6+r1kxaIlm/IPcE/p4vBH/qiHKi3xyyxTCN1F/VSiaMnsZHb9FcGc4Fwirv2d0hFWytYfQ4ZMeEns3rBZnnKktyHAsQdE/1UvR27K8tF++GNWCwh85y0Mf1wqOSzmMrjd8nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552123; c=relaxed/simple;
	bh=E4bV3ZcGr1FqBIRiLtCzhIyS85m/9EVekMqGxdMWLck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UC3oVh5m6Ftb/Ox743zXomu8IhqOjWJi1Bv//PjgmqemBSAqy6M+7Wdl2wQsw5Dpy5+fPbX+JBuZVKkbdqgjYJQnS6b3aDwHuFAHzTcJcnrijLYGUhsVEB1MmaEOa0jATpm3GtfSL/l+6VrXfSkzFBr38MaAbQDytN1+PGcglwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+f6Y0td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F045C4CEED;
	Thu,  3 Jul 2025 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751552122;
	bh=E4bV3ZcGr1FqBIRiLtCzhIyS85m/9EVekMqGxdMWLck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o+f6Y0tdf9Xf5//ZNxZVy0UHpOcIFXH2JB1HV86O0K2rDNfx6Zh0v44XLtHfpt6zP
	 fS2OG39Z6+fVqMUccwZljrrN2kI6eSMjxvAYRzsN/AHB1qV3UlSvyVWcucg25WtQ79
	 J4RzBZ59PkDPOd/uzXDg12NJF5Dt4C8lgN6ejayfvn+T1uM9/e2mYSDm5cyJN2ojr4
	 433Mk6ThuasH2+an1GYCIhkoYYLk6pPaPSFxX0lkephbmDziYb5+c+bcU6pRFzdcvU
	 YgyHLx34sTwHDGLPeYLlBZZFa2C/zlXqISLIQkGjZcpWbJ/xQfGBfqk304UuaZ6C0S
	 jBtlPNvTboHRw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4067106dd56so3383018b6e.3;
        Thu, 03 Jul 2025 07:15:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUTiPxcQq0BXWM8e+ytLdVickH4xOUQZ8/MKElhpJn5gKqYDBvQ0fpeoi30MFQy7fwPQsDiaMK+88=@vger.kernel.org, AJvYcCW/CmeU17YpeVASVNABUc0C152QDkXhdSrh7PJze+VIuEkmIP9Wmk3lxWy/D7Dqzx4keQ6O7RX7PLw6spM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKR8R+jiN4Ic2l47ybuMlkyjSCi0B0sFVH3JcP9mStzD+YSBMA
	0hbOPE6WRuWsytihHFZeUv6kHoliV9A+ag/qf4U7N3+2zEI+yVI/nXqcqdkuvGxV/5Jyx1b1D2y
	vqXIxMDWZcub43D5NnGp8gO2wshZSeIg=
X-Google-Smtp-Source: AGHT+IExmwqeDlyaQUlnPiLgwuZRtUxdGGqrR0IkUTOvwfBKsUqs1fKawWM6QdKVAEoyt4z84vHCGv3EnhxZxk43yak=
X-Received: by 2002:a05:6808:4d0c:b0:40c:f644:87fe with SMTP id
 5614622812f47-40cf64489c2mr1286295b6e.24.1751552121725; Thu, 03 Jul 2025
 07:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611101247.15522-1-zhangzihuan@kylinos.cn> <20250611101247.15522-2-zhangzihuan@kylinos.cn>
In-Reply-To: <20250611101247.15522-2-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 16:15:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>
X-Gm-Features: Ac12FXyn8rXc9CQKN6l2d_jC3Uv4Bp9Ji7lPrIOkovvGLlVsAJDJwzvxtujSF4Q
Message-ID: <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
To: Zihuan Zhang <zhangzihuan@kylinos.cn>, Peter Zijlstra <peterz@infradead.org>
Cc: rafael@kernel.org, pavel@kernel.org, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The patch subject appears to be incomplete.

On Wed, Jun 11, 2025 at 12:13=E2=80=AFPM Zihuan Zhang <zhangzihuan@kylinos.=
cn> wrote:
>
> When freezing user space during suspend or hibernation, the freezer
> iterates over all tasks and attempts to freeze them via
> try_to_freeze_tasks().
>
> However, zombie processes (i.e., tasks in EXIT_ZOMBIE state) are no
> longer running and will never enter the refrigerator. Trying to freeze
> them is meaningless and causes extra overhead, especially when there are
> thousands of zombies created during stress conditions such as fork
> storms.
>
> This patch skips zombie processes during the freezing phase.
>
> In our testing with ~30,000 user processes (including many zombies), the
> average freeze time during suspend (S3) dropped from ~43 ms to ~16 ms:
>
>     - Without the patch: ~43 ms average freeze latency
>     - With the patch:    ~16 ms average freeze latency
>     - Improvement:       ~62%

And what's the total suspend time on the system in question?

> This confirms that skipping zombies significantly speeds up the freezing
> process when the system is under heavy load with many short-lived tasks.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>
> Changes in v3:
> - Added performance test
>
> Changes in v2:
> - Simplified code, added judgment of dead processes
> - Rewrite changelog
> ---
>  kernel/power/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index a6f7ba2d283d..2bbe22610522 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -51,7 +51,7 @@ static int try_to_freeze_tasks(bool user_only)
>                 todo =3D 0;
>                 read_lock(&tasklist_lock);
>                 for_each_process_thread(g, p) {
> -                       if (p =3D=3D current || !freeze_task(p))
> +                       if (p =3D=3D current || p->exit_state || !freeze_=
task(p))
>                                 continue;
>
>                         todo++;
> --

This is basically fine by me, but I wonder what other people think.

Peter?

