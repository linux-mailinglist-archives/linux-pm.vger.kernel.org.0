Return-Path: <linux-pm+bounces-40016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E90CE6E38
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 14:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FD1030041A4
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 13:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3323C1F30C3;
	Mon, 29 Dec 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGOmdrYd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A5632
	for <linux-pm@vger.kernel.org>; Mon, 29 Dec 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767015143; cv=none; b=ZTmaG9K+VpnPzmaNw8twQwLfC3yvhm9a5KuxmjwmQlReHdNIEtu92SQyC8p31le5c7b/lbps0J+FtSaDOXb+lCPGCYwj0mW+sXlqXNUY2dW2Q2eOFRyXYSzd5pE8Abe9BY2cjFtM4owMPbK970n1aXYcBT/UFDdFfh6wVMxeS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767015143; c=relaxed/simple;
	bh=nfLEknyMby51WHoQKrvojs6QQ1y0Bf2YJAgFmRSFOxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foImwjygUWOaRi2nYcaBn4TamTgxN66Gv7y3WgQUWtWBonEP+MBJxVV1qfYCW3LSWTzweu+pXclILxPruTiWrDjt/zyjZABfAM+mMvdmIiZMygIFD5JaWQaE9KTpLjlPVARmeqpV3nhZuGzpCnkEjx1PRbriuIcfyMhCWPu/g9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGOmdrYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D700EC4CEF7
	for <linux-pm@vger.kernel.org>; Mon, 29 Dec 2025 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767015142;
	bh=nfLEknyMby51WHoQKrvojs6QQ1y0Bf2YJAgFmRSFOxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gGOmdrYd9MvFLpB5zO8m1JQTl4BELrqVbHkPgWjKfuVu+ZXztZqsBgZC9WtIFpWNY
	 lyy+DF9az2AKonzB8pqZWAeTP97Coj9Z48UjuCq6AelxdVBLKhLpg62qBvcFFSaxEc
	 fF3zdh0rQQ+PoZUvO+RayYRPrOfJ7MX60KTGU9rZtwmqEji5n3ymIO4xQQbZWPWwLL
	 ks5i6b7t44/baWELnrA/OB47WdA600kczFheDgMMz8ItB3nZRskWwC3tKIQk8J9nen
	 tPxUbxTvPzERiPGFYKed/nt6ihwrJ6dqbImRYKPfLVeir0ITZ1Y3WaHg112dqNvipP
	 /4ye22Y6dTN1A==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-65d0953cd49so5908902eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Dec 2025 05:32:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdrl8FchSV1RUo8MYSpios04Yqw3d51kt0iecuJBTCGIsYEfEE3qzbpcdImUO8RKfWTfMGZVrRlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfFmdQ+R7QURrqQK1emAE18QhOl5yoBUNTVOmc3lc+qt0jV3N
	d3Gia4o3hc/vdJk6FlvA0F9oeHy91JtJRfH+z5g16wlcGPFblGQYZTm5RSs9ylOJslm4koAoONr
	/OYjlBQkBDyTsejTQ/ZfnMtwAe1Yg8AE=
X-Google-Smtp-Source: AGHT+IGHmF/UeipIR0M7ntD24u3HCLarZY8hIdMfE2PZSXhQV8l8tZQwln/n+/TOpC3AObg5tYaqUCM0chgWqYUGXVM=
X-Received: by 2002:a05:6820:4814:b0:65d:697:2d52 with SMTP id
 006d021491bc7-65d0e9f049fmr8750934eaf.37.1767015141978; Mon, 29 Dec 2025
 05:32:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6251576.lOV4Wx5bFT@rafael.j.wysocki> <ead94047-f1de-4349-99f4-f836382b91d9@kylinos.cn>
In-Reply-To: <ead94047-f1de-4349-99f4-f836382b91d9@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Dec 2025 14:32:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j257Pomf0_gPdUfdgmxo6H9oV+jrp+_y_UC4G9kf1cNg@mail.gmail.com>
X-Gm-Features: AQt7F2p6TLY0KHpywLrxv83DqOZDhlCSfHXRNrrEh8yQtoTEtOt4Y14iz-klyWE
Message-ID: <CAJZ5v0j257Pomf0_gPdUfdgmxo6H9oV+jrp+_y_UC4G9kf1cNg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Fix suspend_test() at the TEST_CORE level
To: luriwen <luriwen@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 3:31=E2=80=AFAM luriwen <luriwen@kylinos.cn> wrote:
>
> =E5=9C=A8 2025/12/26 21:50, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit a10ad1b10402 ("PM: suspend: Make pm_test delay interruptible by
> > wakeup events") replaced mdelay() in suspend_test() with msleep() which
> > does not work at the TEST_CORE test level that calls suspend_test()
> > while running on one CPU with interrupts off.
> >
> > Address this by making suspend_test() check if the test level is
> > suitable for using msleep() and use mdelay() otherwise.
> >
> > Fixes: a10ad1b10402 ("PM: suspend: Make pm_test delay interruptible by =
wakeup events")
> > Reported-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Closes: https://lore.kernel.org/linux-pm/aUsAk0k1N9hw8IkY@venus/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   kernel/power/suspend.c |    9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -349,9 +349,12 @@ static int suspend_test(int level)
> >       if (pm_test_level =3D=3D level) {
> >               pr_info("suspend debug: Waiting for %d second(s).\n",
> >                               pm_test_delay);
> > -             for (i =3D 0; i < pm_test_delay && !pm_wakeup_pending(); =
i++)
> > -                     msleep(1000);
> > -
> > +             for (i =3D 0; i < pm_test_delay && !pm_wakeup_pending(); =
i++) {
> > +                     if (level > TEST_CORE)
> > +                             msleep(1000);
> > +                     else
> > +                             mdelay(1000);
> > +             }
>
> Maybe this can be rewritten as follows
>
>                 for (i =3D 0; i < pm_test_delay && !pm_wakeup_pending(); =
i++)
>                         level =3D=3D TEST_CORE ? mdelay(1000) : msleep(10=
00);

Not really, the current trend is to avoid the ternary operator.

