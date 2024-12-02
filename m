Return-Path: <linux-pm+bounces-18385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D5B9E0E0B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 22:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8B1B253DE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19021DEFF7;
	Mon,  2 Dec 2024 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3L8ihzS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2B1DDA0C;
	Mon,  2 Dec 2024 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174109; cv=none; b=FfYMz2NJNRNBRDvfazLxDThu3F69TU/vj9wlulvdPivL3xS91Z2pJwEY+xwB7TFJROLWyzWkt9XJuHTJgHikBUk5+iye8PvDz8kT/jMHCFe/3wKjVZNA6UPNCCh58F1ccMVpJ1w6s4RkN4p/3RbaLzpE3E+gFQUp4gZ3chRcWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174109; c=relaxed/simple;
	bh=SHAxs9fQV/eBIXPxu+3Jt7SAedFs0FjlleS9+0O7wSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQyvqdbZv1EhQmujaJaSlg57YSKwDQ9kLiEervWU+zjBvh9XFOeyVFUwCA7mrR43z0s3iUVF1olIftddesgNEvSWcn3Zs27/Zz9rfE04lvaXU/UQpZTVhMFy19B+Xl4+op0QBuykyOKnwiS/A5pAW9/eEc9EEhrdCJy0sUYRUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3L8ihzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4668CC4CED2;
	Mon,  2 Dec 2024 21:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733174109;
	bh=SHAxs9fQV/eBIXPxu+3Jt7SAedFs0FjlleS9+0O7wSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R3L8ihzS1S/yrHy8gD7aOsrncK3vhvBVo+4XlMkeTgi/J8r2/bCao8Yv5jTrlk9LP
	 If/TXwEYUZOVFsk3rI4u0L5O4KbnQETjjecZhVy2OfEqMKsGLraJCgRJj28WbsHSM0
	 Y0CkGI50f3tobmlNFBfZDkCExkBbDiaAR4fOZxueq3DkX+2CzY6+Joy40S4cqoYax1
	 k5sqEFva9SqWmoc3GT6oxLH4KjaFuyfdCmu4UTxNlMT4hsFnvr/UD5/JCyYw4LcrcI
	 hJT1U+8wJdXWfvt7OOy6WA+88nqjuL80TVwtuovi/ucea0B2W4O76+UUc1BYNDHa7F
	 lhjdH91zD+aog==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29737adb604so2578391fac.1;
        Mon, 02 Dec 2024 13:15:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/d15iiQPnKbqfrvsW0M3aTXGQ5A+1BKO9+lHhSHBn2VzFLgy8RncUbpzI48kQ3VQVKIE9+oRWFUq20ec=@vger.kernel.org, AJvYcCWfpC61ZIkLAY/OHp7Xwz2Ktr2Sj0jpR7j3IeNR4Z+8qAv69kyrzvWJ9EpV43NVuSp0/jBUx4PJUBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQdGzRC7XOQtPoGfAJ7vglvArhdxo5rWLYcEUd0HFD7lGRatC
	kywaaPst5UVhlRDMCD9J8vLxqi/k0wTfCk4ugTGclIEVReFZaPgRgeD1Yzdf4k7omHb0LnqCU7d
	VgYYM8WwskOtABhyUOQa0kiwb1+M=
X-Google-Smtp-Source: AGHT+IEzj7J5M5in46m+yKOUto4QjDW1GF6V1FXByl1UytxQkM6ePfkXX/gwUGianPCiT0bLJ1YG4ZoMv1ux+SOLnPo=
X-Received: by 2002:a05:6870:5d88:b0:29e:5c37:a1c3 with SMTP id
 586e51a60fabf-29e5c37ca25mr6585322fac.2.1733174108372; Mon, 02 Dec 2024
 13:15:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-3-saravanak@google.com> <CAJZ5v0jPO24JR5um0gv5U5AwiR_RHx37x6DisG-nUxaZt9gfGA@mail.gmail.com>
 <CAJZ5v0iLq9L5nMp13BrBmbWavFs1ZEAtJ-WeyRzv3D2GXPNuag@mail.gmail.com> <CAGETcx-9XSdXcuGQFSoS-mMPwp=UJ3_FfTJ1Cx+9jddyjYTKEg@mail.gmail.com>
In-Reply-To: <CAGETcx-9XSdXcuGQFSoS-mMPwp=UJ3_FfTJ1Cx+9jddyjYTKEg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Dec 2024 22:14:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iWCWdjP9Gku2uV0Qz-Hp6ZEHDspaPVzHPPzHfvyREeWA@mail.gmail.com>
Message-ID: <CAJZ5v0iWCWdjP9Gku2uV0Qz-Hp6ZEHDspaPVzHPPzHfvyREeWA@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] PM: sleep: Remove unnecessary mutex lock when
 waiting on parent
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 9:46=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Mon, Dec 2, 2024 at 12:16=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Mon, Dec 2, 2024 at 9:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > >
> > > Sorry for the delay.
> > >
> > > On Thu, Nov 14, 2024 at 11:09=E2=80=AFPM Saravana Kannan <saravanak@g=
oogle.com> wrote:
> > > >
> > > > Locking is not needed to do get_device(dev->parent). We either get =
a NULL
> > > > (if the parent was cleared) or the actual parent. Also, when a devi=
ce is
> > > > deleted (device_del()) and removed from the dpm_list, its completio=
n
> > > > variable is also complete_all()-ed. So, we don't have to worry abou=
t
> > > > waiting indefinitely on a deleted parent device.
> > >
> > > The device_pm_initialized(dev) check before get_device(dev->parent)
> > > doesn't make sense without the locking and that's the whole point of
> > > it.
> >
> > Hmm, not really.
> >
> > How is the parent prevented from going away in get_device() right
> > after the initial dev check without the locking?
>
> Not sure what you mean by "go away"? But get_device() is going to keep
> a non-zero refcount on the parent so that struct doesn't get freed.

That's after it has returned.

There is nothing to prevent dev from being freed in get_device()
itself before the kobject_get(&dev->kobj) call.

So when get_device() is called, there needs to be an active ref on the
device already or something else to prevent the target device object
from being freed.

In this particular case it is the lock along with the
device_pm_initialized(dev) check on the child.

> The parent itself can still "go away" in terms of unbinding or
> removing the children from the dpm_list(). But that's what the
> device_pm_initialized() check is for. When a device_del() is called,
> it's removed from the dpm_list. The actual freeing comes later. But we
> aren't/weren't checking for that anyway.
>
> >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/base/power/main.c | 13 ++-----------
> > > >  1 file changed, 2 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > index 86e51b9fefab..9b9b6088e56a 100644
> > > > --- a/drivers/base/power/main.c
> > > > +++ b/drivers/base/power/main.c
> > > > @@ -284,18 +284,9 @@ static bool dpm_wait_for_superior(struct devic=
e *dev, bool async)
> > > >          * counting the parent once more unless the device has been=
 deleted
> > > >          * already (in which case return right away).
> > > >          */
> > > > -       mutex_lock(&dpm_list_mtx);
> > > > -
> > > > -       if (!device_pm_initialized(dev)) {
> > > > -               mutex_unlock(&dpm_list_mtx);
> > > > -               return false;
> > > > -       }
> > > > -
> > > >         parent =3D get_device(dev->parent);
> > > > -
> > > > -       mutex_unlock(&dpm_list_mtx);
> > > > -
> > > > -       dpm_wait(parent, async);
> > > > +       if (device_pm_initialized(dev))
> > > > +               dpm_wait(parent, async);
> > >
> > > This is racy, so what's the point?
> > >
> > > You can just do
> > >
> > > parent =3D get_device(dev->parent);
> > > dpm_wait(parent, async);
>
> Parent struct device being there isn't the same as whether this device
> is in the dpm_list? So, shouldn't we still check this?
>
> Also, is it really racy anymore with the new algorithm? We don't kick
> off the subordinates until after the parent is done.
>
> > >
> > > and please update the comment above this.
>
> Will do.
>
> Thanks,
> Saravana
> > >
> > > >         put_device(parent);
> > > >
> > > >         dpm_wait_for_suppliers(dev, async);
> > > > --

