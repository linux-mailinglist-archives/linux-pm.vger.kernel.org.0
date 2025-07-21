Return-Path: <linux-pm+bounces-31237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F44B0CB2A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 21:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C8C7AFA4F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 19:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A42367C5;
	Mon, 21 Jul 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPMv7+OL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66587BA2E;
	Mon, 21 Jul 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127473; cv=none; b=VbCRzcQxS+6vqxdKZApT9NUXoOd/8qPW6Aq7BfTDrvXdzBtCaP9GPsU/j3mnuesVJPFWbNgOXjiq+GBC8Rxir66kbUOztfrMDBKiX2NXnmraEQNsJl0ZBtGCRl0/jQK2IUgi/NGYT7xYWHlSiXW05+QXq2Ij0jpqqQoAqfCngCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127473; c=relaxed/simple;
	bh=AfBAOulMHp7EDYXtLwDEGsMzWBGQfkizPfb1i5IFklU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeRHKucenHrXuSxGt3ikB6UfWPNrOD4pDzV7QEjHxLxx1r6EOyn++cmG6SMdqCVkuIfKMs5upyloYje0ot4dbsmXmgo/mfIQY4eBx8hRUYrVd4J/DwALW1nJuN9TReKLr5WQaSKjhdCFl4Rt2XjxMnkQ7jSn3xMuraIOTnR0mdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPMv7+OL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CBBC4CEED;
	Mon, 21 Jul 2025 19:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753127472;
	bh=AfBAOulMHp7EDYXtLwDEGsMzWBGQfkizPfb1i5IFklU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dPMv7+OLGzdY2UCXX1FzkbpFiK8a7emjMkEokFNh2rF52G/Rq4idAPGL8SAzM87M+
	 GbwP/4wLRbE+81SBDcG7XOb+xPz80bAYWcyfXZwYGku8ovMz/dg1vjC4fji0uE7X2r
	 Yix8fABTx1/CdhHxMwN2m5QN3fIgi8W70PAXBgpd1wC5sU6azDM/Nsf7eBrIvFw4Ci
	 O09fNEFamaMy2VJoXKyH8U8V7pMB3+neT3z9ARW/egq2obhXJiHrEB/DDEtLoVFSqW
	 4KTfuwLr2KjwPJ1q7RI0B0+8DaMHGVPqOu+hpWhAoOFMG/m2PNs63wIfUocpWRpX09
	 IKnkbY5o466cA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61591e51092so2219764eaf.0;
        Mon, 21 Jul 2025 12:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVINuZPOnQf+iJ1M4IRZfOEd5YWZxuswGDjw6/KptR8mT9qms2CczSJ0qDasAnHZ7yzBxwwyMGdjb3va8E=@vger.kernel.org, AJvYcCWZNBStKsYrzFeTPktRU/Q+uwnIUvx3ZIHtMXqiGU2BxD9JhN8QNK/D/ZpFp33Wg+1jYDUh9R8qAYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfRv95iyuSM0MDxS0DNOg1NRosKS8c44k/iYOgVfZ3s0Bjkwt
	vVb7AwkHkkZADqz9xvQzhfIg809gMzxSStvhJiQdVK5BJgXiaV8vk/9rN3MpdNx0uZCFVpJKvOa
	PfzRgwLtNuahfuPkQzo9pvgI6Y+JuG7A=
X-Google-Smtp-Source: AGHT+IGoM4BLNSSylFMNbSAw1L3y53fxwdNKamgvbVT7Dp4NfffRHl+vvuNMRI4uIkvyicesk2mZGwF22RKoemB9+HY=
X-Received: by 2002:a05:6820:260b:b0:615:e807:8134 with SMTP id
 006d021491bc7-615e8078370mr1969877eaf.5.1753127472191; Mon, 21 Jul 2025
 12:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718071842.2483378-1-saravanak@google.com>
In-Reply-To: <20250718071842.2483378-1-saravanak@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Jul 2025 21:51:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ifsVycSWk24gMrEsGtDn0nVkUJGH8vwBvJdEA1XHbTRQ@mail.gmail.com>
X-Gm-Features: Ac12FXz4dxl62coHj83jeFJGnEtG5DNBml2TR8wnyAfVVxahSc3gpjhv9ZxVhoU
Message-ID: <CAJZ5v0ifsVycSWk24gMrEsGtDn0nVkUJGH8vwBvJdEA1XHbTRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] PM: wakeup: Provide interface for userspace to
 abort suspend
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 9:18=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> Once suspend starts, it can take a while before file system sync
> finishes and all the userspace threads are frozen. During this time,
> there can be events that originate in userspace that would require the
> suspend to be aborted.
>
> The only way to abort suspend from userspace as of today is to grab
> and release a kernel wakelock using the /sys/power/wake_lock and
> /sys/power/wake_unlock files. This has the disadvantage of:
>
> * Doing the useless work of creating and destroying wakelocks.
> * If the userspace entity crashes after the wake lock is created, we
>   get a wake lock/memory leak.

But wakelocks are for this purpose.

> To avoid all this and simplify the interface, this patch allows
> canceling a suspend by writing UINT_MAX value to the
> /sys/power/wakeup_count that is meant for tracking wakeup events.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>
> Rafael,
>
> If the idea looks good to you, I can also update Documentation and sent
> it as a non-RFC patch. I'm not too tied on what file we use to trigger
> an abort from userspace as long as it's possible.

I would rather add an interface based on a special device file for
wakelocks to address this.

For example, open it to create a wakelock with the name of a calling
process, write 1 to it to block suspending, write 0 to it to unblock,
close to remove it.

Then it will go away automatically when the process exits.

>  drivers/base/power/wakeup.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index d1283ff1080b..9316de561bcc 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -1008,6 +1008,8 @@ bool pm_save_wakeup_count(unsigned int count)
>         if (cnt =3D=3D count && inpr =3D=3D 0) {
>                 saved_count =3D count;
>                 events_check_enabled =3D true;
> +       } else if (cnt =3D=3D UINT_MAX) {
> +               pm_system_wakeup();
>         }
>         raw_spin_unlock_irqrestore(&events_lock, flags);
>         return events_check_enabled;
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
>

