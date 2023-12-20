Return-Path: <linux-pm+bounces-1442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07EC81A6C1
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 19:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A0028512B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54193482C2;
	Wed, 20 Dec 2023 18:18:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A7482CA
	for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2023 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5908b15f43eso751369eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2023 10:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703096280; x=1703701080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81LfAHHJgalZNNfrg/vCV84LuOvzid4mwqR/ugH9S9s=;
        b=DmLNSTBOc+Hb/s23IwTICgML1vjZwaIw8Ib4tB67qWasy0bEzfD0WbbsZT2FMrEhGR
         R3hGLT1w1bM7EkTMwgZpU+W3Jp4bXw+i4UxCwczUULfgaoJU5Ul4q9iTiGjHvv2vjjR0
         nUMUbpgECiJ8B7ozBgTr6jXxTYY8Epwi01pCyEBYDFF06qeATy6U1+sH4kua9NTdsPQ2
         8js9+Y0t55Y+Em8su3r5NyWD/WPvAkOYkDOg22CFxxUPCXQ16PSeO35M/jahcDGbdrQo
         9DbkcDVIR89msHQb4o6XOf7pfgtrbnNfsWpkSvFPAp9pGdzyL6Z5YEyUv85j5GSS/URL
         Z7rQ==
X-Gm-Message-State: AOJu0YwCYCyQhwsbIureapeHZImcnCS16O9wCFUeuQEWLAhRTrnjoP/P
	64qrMHLqxzmJ3dtXSIMdV9GmTvNFPwYkDtIha3o=
X-Google-Smtp-Source: AGHT+IHWnCtoBeQQ4ZFPTwDLnNylHnSBdOHpFoYXHYjgtLYOlSj6ZqYTuEt5ViezcGxFG3nYJdYYwXtGo7Q4T8XSXKE=
X-Received: by 2002:a4a:b803:0:b0:593:fbd5:10aa with SMTP id
 g3-20020a4ab803000000b00593fbd510aamr3464959oop.1.1703096279886; Wed, 20 Dec
 2023 10:17:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220003535.714831-1-haokexin@gmail.com>
In-Reply-To: <20231220003535.714831-1-haokexin@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 19:17:48 +0100
Message-ID: <CAJZ5v0iFeMmx+HRQr-DUprPFv_pw4RKihqCWAUHLUVsyGbaOBg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Remove obsolete comment from unlock_system_sleep()
To: Kevin Hao <haokexin@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:35=E2=80=AFAM Kevin Hao <haokexin@gmail.com> wrot=
e:
>
> With the freezer changes introduced by commit f5d39b020809
> ("freezer,sched: Rewrite core freezer logic"), the comment in
> unlock_system_sleep() has become obsolete, there is no need to
> retain it.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> v2: Remove the entire comment from unlock_system_sleep().
>
>  kernel/power/main.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index f6425ae3e8b0..b1ae9b677d03 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -60,22 +60,6 @@ EXPORT_SYMBOL_GPL(lock_system_sleep);
>
>  void unlock_system_sleep(unsigned int flags)
>  {
> -       /*
> -        * Don't use freezer_count() because we don't want the call to
> -        * try_to_freeze() here.
> -        *
> -        * Reason:
> -        * Fundamentally, we just don't need it, because freezing conditi=
on
> -        * doesn't come into effect until we release the
> -        * system_transition_mutex lock, since the freezer always works w=
ith
> -        * system_transition_mutex held.
> -        *
> -        * More importantly, in the case of hibernation,
> -        * unlock_system_sleep() gets called in snapshot_read() and
> -        * snapshot_write() when the freezing condition is still in effec=
t.
> -        * Which means, if we use try_to_freeze() here, it would make the=
m
> -        * enter the refrigerator, thus causing hibernation to lockup.
> -        */
>         if (!(flags & PF_NOFREEZE))
>                 current->flags &=3D ~PF_NOFREEZE;
>         mutex_unlock(&system_transition_mutex);
> --

Applied as 6.8 material, thanks!

