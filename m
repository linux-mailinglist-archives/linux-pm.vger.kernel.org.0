Return-Path: <linux-pm+bounces-33838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE8CB43CF4
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 15:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225571705DB
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E462FF166;
	Thu,  4 Sep 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeBjgvvh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6512ECEB8
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992113; cv=none; b=Fu83KqmUDZDkRQKuMKWmcV9k2pjqvr/OoLZGht2t+bdoFt24DJrTYkXz50n3CAP9G+j+NVT5IeUpxneeGoUonwOhHDVdTloTqqlFmapmRIMqH5JCcvg8VhaXLv8/kc9LcyZ3hfSe+q/vlE+XSAKwPuydhzqHmgmyYyBkhlLtsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992113; c=relaxed/simple;
	bh=qo4+GKLXGFiTNyOVP1QuBOi8BIKyb9sSiyMt3ybbC2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qS4TZwc+PRLOgv3eoqE4NsAkCmHl02FYHVC27wxl6/Aa+01ZowB1nvnFImvF85GW2s6L14a7SGaf6YUXpufX2oNsq6Pu04Te+NrPma4ujNN8SV0rS+8Td+7xgPJ/JuIl4xbRjm2N5pxmvbGyriYBChLuDMOeP3g0OVaoDKARjh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeBjgvvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F16C4CEF8
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756992112;
	bh=qo4+GKLXGFiTNyOVP1QuBOi8BIKyb9sSiyMt3ybbC2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eeBjgvvhch4OWm+EspsXnXLs/o7YMHOSmgBmoqgtPdGUdyXiMV0vaXKJ9/999FwL7
	 xYnNZECKOcdKvFk2iksunSYqzVGLkoQBVweinX6P3KP2ORG6QfSVuvaeNaJiL0cqGp
	 MQ8dlBChywKAul9qx8/bFruLIbhVS4P8LG9KizpsrI7IuYuy+1Z9XfbsCpMYapM+cA
	 QbvFNL6VZorckg+NyMacmAkzPk/1lBUOLBF2oWUOjdsQSf4ZctiS5Qxzgc/aGm6iiE
	 Dn7sXNNHqcreStGTex+aJc/CoYjELH37LNeiucVfOyQvyAqACILDbJ4Cuat+m6Mc7R
	 yC9/FxWqFAQZA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74381e207a0so833748a34.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 06:21:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMlu9Vl12c/q7hs5tn7Tx3pOch6at3dTypNest11EnXk4Xm4c6blPUBboJ3oVlzcBXbtTDF7AsiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo7DoOKVLDjrct1C6n25TJN3mn0nMI1UfsrkHvXeYHffxAR4v7
	dwkJttI7lyC2DALovl9A3lVooiTnFQPhNIbCffzz9Vg8LaoUPdVmUG54Sq3nU7z24RjaDhsBdLC
	VTcA8Cfp6kcRpuzoON6pMIWxyzEmrHHE=
X-Google-Smtp-Source: AGHT+IHdGmlphfFGnt50ls1k7J1BDOKrtbE9wl3KpQcDoUFFaeFaf1j5/HssvVcWfRiAfoPn5J7l0vswcNJLXQD8K1s=
X-Received: by 2002:a05:6830:3c86:b0:745:4738:fc49 with SMTP id
 46e09a7af769-74569d94b2amr10619839a34.5.1756992111835; Thu, 04 Sep 2025
 06:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22453676d1ddcebbe81641bb68ddf587fee7e21e.1756990799.git.lukas@wunner.de>
In-Reply-To: <22453676d1ddcebbe81641bb68ddf587fee7e21e.1756990799.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 15:21:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jTUrCj6YkQd7ab1LdTaHGU-SGVswm=TUhmN0yDmRxkpA@mail.gmail.com>
X-Gm-Features: Ac12FXxuisaRR3J61UIxjJaNL4wSskbcFfNo2uvlzP8vHcRTSEW7Y5HYs2DQgBI
Message-ID: <CAJZ5v0jTUrCj6YkQd7ab1LdTaHGU-SGVswm=TUhmN0yDmRxkpA@mail.gmail.com>
Subject: Re: [PATCH] xen/manage: Fix suspend error path
To: Lukas Wunner <lukas@wunner.de>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	xen-devel@lists.xenproject.org, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 3:11=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrote=
:
>
> The device power management API has the following asymmetry:
> * dpm_suspend_start() does not clean up on failure
>   (it requires a call to dpm_resume_end())
> * dpm_suspend_end() does clean up on failure
>   (it does not require a call to dpm_resume_start())
>
> The asymmetry was introduced by commit d8f3de0d2412 ("Suspend-related
> patches for 2.6.27") in June 2008:  It removed a call to device_resume()
> from device_suspend() (which was later renamed to dpm_suspend_start()).
>
> When Xen began using the device power management API in May 2008 with
> commit 0e91398f2a5d ("xen: implement save/restore"), the asymmetry did
> not yet exist.  But since it was introduced, a call to dpm_resume_end()
> is missing in the error path of dpm_suspend_start().  Fix it.
>
> Fixes: d8f3de0d2412 ("Suspend-related patches for 2.6.27")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org  # v2.6.27

Thanks for catching this!

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> kexec suffered from the same issue ever since it began using the
> device power management API in July 2008 with commit 89081d17f7bb
> ("kexec jump: save/restore device state").  It was fixed this year
> by commit 996afb6efd1a ("kexec_core: Fix error code path in the
> KEXEC_JUMP flow").  All other callers seem fine.
>
>  drivers/xen/manage.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
> index 841afa4..1f5a7a4 100644
> --- a/drivers/xen/manage.c
> +++ b/drivers/xen/manage.c
> @@ -110,7 +110,7 @@ static void do_suspend(void)
>         err =3D dpm_suspend_start(PMSG_FREEZE);
>         if (err) {
>                 pr_err("%s: dpm_suspend_start %d\n", __func__, err);
> -               goto out_thaw;
> +               goto out_resume_end;
>         }
>
>         printk(KERN_DEBUG "suspending xenstore...\n");
> @@ -150,6 +150,7 @@ static void do_suspend(void)
>         else
>                 xs_suspend_cancel();
>
> +out_resume_end:
>         dpm_resume_end(si.cancelled ? PMSG_THAW : PMSG_RESTORE);
>
>  out_thaw:
> --
> 2.50.1
>
>

