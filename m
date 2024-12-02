Return-Path: <linux-pm+bounces-18378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8F9E0CE0
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1509C1656EF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 20:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C411DE89C;
	Mon,  2 Dec 2024 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8dBTadz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4C1D88C7;
	Mon,  2 Dec 2024 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170607; cv=none; b=E5DGuc8/FpcYmvkfPlH4nDgqvpx/+l3g5c1mw/E5Um8USPwgnMrHJL/fh8hbFUykB4DvIwt15k1/daKDjqheM0wUtzw7Le4SuOnt5aiyo3ZCp92s2pMG/JlNWQiF1zCbKJTNaZ3NHspUWJCBmCZccOagON0O4KZ+9T+rie8Ic3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170607; c=relaxed/simple;
	bh=M/8545t/m7bhJOBqSsnUSnGyaxzOspC9YimXSPviZ30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1V6hHZJb06lBNxADzfw5G1okt9Cxo0PY/eN6wttxuL+SGuCvnWI4lHwOWxu4h7iFUjEfqhKFSlO2qSIV4s2IjekGLGEiYcfAE/srYVsiOd/M247Vs8obiGDSU+qozdpIvgasBRk0MbvxncgIaxAvNjbi4rCbgE8y35Yverm/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8dBTadz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F263DC4CEE1;
	Mon,  2 Dec 2024 20:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733170607;
	bh=M/8545t/m7bhJOBqSsnUSnGyaxzOspC9YimXSPviZ30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n8dBTadzy6bgeapI+amB6M2AIC+mYzmdsvv8p15lktNEQNWfa6+xSyLubtwjK+TD0
	 Zopq6TbTpNRZYJRqGRziUplWpba59E2VLLGTVrNhZcDH5SolmX8cpZdfj21y+Jkd+u
	 vfKQY0Dm4WUQMO5GAjNjitUHfDzyaQjNivYW5Q6r94dOa9/BrLPQ6+TK5wj3bZgHr4
	 vNdET4WPEjSWxve49hfuKGXaigzWh0rfJRFo0618hSruxMdSbXgn9S/OswJsnvyr70
	 eKLe+WA1BlhSArYOsTTqhD408nviGB2Kk2c1W+hY7Zt9MCr3H4HSya3vIyFruH7zc+
	 S1bymSUiKWeCw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f1e573e65dso1370244eaf.0;
        Mon, 02 Dec 2024 12:16:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsrS1M6d6OLJ5LcYt3aOtU9rcB94XVA9drYHl/vRY0vaMclVcjM+sjSAUI/ZytEOE6XXYVTijmTu6N5lo=@vger.kernel.org, AJvYcCXXNTWqP3yBT2BVlT926/NmIw2P5jXTSKqkiYgrkdo27Y0b1nF3l/Za8+4vE/rGgCSQGHGMIyDy1qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX79yT4sFuCmHcvKVOLD50MvF4baER8tvbgj9L/9VSFXHRfoe+
	8JRQyKWoNY4vwV6vnzfn3P+ZDBbRRmQY7eT4p/IGPhdM2VYmdQfFQi2ZMxUPWd4I38oiFDMmwa1
	gViKAuSZOEbvVmNbggR4nROFy3nQ=
X-Google-Smtp-Source: AGHT+IHlHeE2R9BrV0PMMpZDdBocUrKf5KOeyTQLT02mpMtN7GzHFvJBEsOzZrlEdyPl9l38RgV8lYGV6Qrr8gvq5zc=
X-Received: by 2002:a05:6870:988a:b0:29d:c832:840d with SMTP id
 586e51a60fabf-29dc832e5dfmr15308297fac.35.1733170606144; Mon, 02 Dec 2024
 12:16:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-3-saravanak@google.com> <CAJZ5v0jPO24JR5um0gv5U5AwiR_RHx37x6DisG-nUxaZt9gfGA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jPO24JR5um0gv5U5AwiR_RHx37x6DisG-nUxaZt9gfGA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Dec 2024 21:16:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iLq9L5nMp13BrBmbWavFs1ZEAtJ-WeyRzv3D2GXPNuag@mail.gmail.com>
Message-ID: <CAJZ5v0iLq9L5nMp13BrBmbWavFs1ZEAtJ-WeyRzv3D2GXPNuag@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] PM: sleep: Remove unnecessary mutex lock when
 waiting on parent
To: Saravana Kannan <saravanak@google.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 9:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Sorry for the delay.
>
> On Thu, Nov 14, 2024 at 11:09=E2=80=AFPM Saravana Kannan <saravanak@googl=
e.com> wrote:
> >
> > Locking is not needed to do get_device(dev->parent). We either get a NU=
LL
> > (if the parent was cleared) or the actual parent. Also, when a device i=
s
> > deleted (device_del()) and removed from the dpm_list, its completion
> > variable is also complete_all()-ed. So, we don't have to worry about
> > waiting indefinitely on a deleted parent device.
>
> The device_pm_initialized(dev) check before get_device(dev->parent)
> doesn't make sense without the locking and that's the whole point of
> it.

Hmm, not really.

How is the parent prevented from going away in get_device() right
after the initial dev check without the locking?

> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/power/main.c | 13 ++-----------
> >  1 file changed, 2 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 86e51b9fefab..9b9b6088e56a 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -284,18 +284,9 @@ static bool dpm_wait_for_superior(struct device *d=
ev, bool async)
> >          * counting the parent once more unless the device has been del=
eted
> >          * already (in which case return right away).
> >          */
> > -       mutex_lock(&dpm_list_mtx);
> > -
> > -       if (!device_pm_initialized(dev)) {
> > -               mutex_unlock(&dpm_list_mtx);
> > -               return false;
> > -       }
> > -
> >         parent =3D get_device(dev->parent);
> > -
> > -       mutex_unlock(&dpm_list_mtx);
> > -
> > -       dpm_wait(parent, async);
> > +       if (device_pm_initialized(dev))
> > +               dpm_wait(parent, async);
>
> This is racy, so what's the point?
>
> You can just do
>
> parent =3D get_device(dev->parent);
> dpm_wait(parent, async);
>
> and please update the comment above this.
>
> >         put_device(parent);
> >
> >         dpm_wait_for_suppliers(dev, async);
> > --

