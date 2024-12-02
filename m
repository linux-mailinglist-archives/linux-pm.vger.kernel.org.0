Return-Path: <linux-pm+bounces-18394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19E9E0F4A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 00:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2495BB23139
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 23:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28601DFD86;
	Mon,  2 Dec 2024 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWqHvV7c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441021DF244
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733182094; cv=none; b=AC8FFtzQoyhTdORkhYYSngecLOuBy+QAVhsYq2rE1WsRY3Dzk0NmWXSGcTuhoBRzRGrsoKgour/QdZEFltNHPXD/d4esvuJ1wxmqbcAS+jxGi27mG6bPRMFJXTpAT8kb0psJ+cGBFH4CGc4bIzGlDLn4oTfs6JMhlF5m38rkUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733182094; c=relaxed/simple;
	bh=jwdcVue+nHHQCNc8y1qV+V5+3ZT64hNhWwiKhcS7sE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKKAkHomYmRZ9z+SpiwF7DMjgEL+xONxwpop5MiGLvFze2zotttnSZ2kYgXiavMYTApeVBrUV5m7OELFvKt9BVNO3zppLsbX4iLKB3FcdjFVd04UpAmpu+QqzMHGEfnwfY4SAQOG6SuQPeySAgGjxPchBeo5ZXVtlE+eHQl79Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EWqHvV7c; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de7321675so5135036e87.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2024 15:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733182090; x=1733786890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3sbXCn2Rh0xH7nuuep2iyHgGbFrRI3XCnsb9RhyJDQ=;
        b=EWqHvV7cuWu6Qwb7D+Fmg67lEJXEYt3x9vqqDdthGR0F4gVXK4ohvWMNyCORsma8dt
         NVnEUMuBExAXZSRK5vgzD6QdEviPs/qR9ork6rAXpgtqlbOAArgQARRAHsdyVtB2X4xy
         YgTpoOy42eSAJyIMPr4nl3kUEQWp9qzg0pYdYlNQQ+hf1bdljLF+xuMJC+WcotnV/bjM
         jstF1UjnqbGXdjw0/UCMChlREqCH40SnYSB6kqzNESRxpIar2rlD3cqxHkQHbz+QED7G
         Y4WNoQpSzK4/xutXWocYgJfnKVa8xoVBzvFjmY519TPjuRI9VcUINen2AUrugAlVijqS
         y/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733182090; x=1733786890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3sbXCn2Rh0xH7nuuep2iyHgGbFrRI3XCnsb9RhyJDQ=;
        b=LDfNIWY7XqH0IZCvSr6lDmvLgjef7pXzUscXKAJZibkgmqHJPAdK+oQhTCU8ymK620
         9+f0DGDBFidXDVzfsniGPrsvvLKoLkdZS8EJ3xyAgI5XFbCTY57zfAj3wEdilckowlsX
         cZzNdDFg1rxqVn8u7usRYUa0WTt7w+Xd/0LWN3UdF9pkHcYOm9hUGzKcj+nU/MtJELIq
         1YAgt1U9W0Pdv5J3jcVLnSXju5ETw3qlA1G+amDcCSY3zRMXNDpO/P+2oOPF8W/2N4/8
         hvu58ZTsqZBoVcyo73zM2eRi7nO0eTIWoMgN0FI3i7hJMWTqm6kuG9tv3OaNcp9RlhsY
         fing==
X-Forwarded-Encrypted: i=1; AJvYcCV5u/mag5ufUGt5zd6SIt0IOFrcnIhB8MxjpizmmM7x0J9Gr6yOlk5q8btle7HtjoPWz32hPMzW1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhh+lRNyaBA4fr9kM+0z5+h/PsjX99OT7tSMsA7UcfHcdiVyp
	MioZHtf+iy6Foa5kK+46c5UPv4Czt3UMMOKiwzbfJy9YcFPlQDCOud/e+FS5pB1Tv+MPwyRNX/E
	+fdzdIDQFHihKwyTD//U5l7bDeB2ktalhG5Io
X-Gm-Gg: ASbGncuQzx0xZEL1o7KQanON4NQo7GGJC7y7XEreQsUK1V3myvWgIlnjQxgdu+VtWB6
	LSiFLss/g7QlUtIejWx0lPbzbkXKIuw==
X-Google-Smtp-Source: AGHT+IEhy6WbRnDJO91BppdUDAlEmi+S9zeMSCFE571EcNiY/nN7FU0teqcVwTaqqVL2IKReSprg6M9g51mDFLUkHN8=
X-Received: by 2002:a05:6512:118e:b0:53d:f095:ffec with SMTP id
 2adb3069b0e04-53e129cd2d9mr190550e87.8.1733182090221; Mon, 02 Dec 2024
 15:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-3-saravanak@google.com> <CAJZ5v0jPO24JR5um0gv5U5AwiR_RHx37x6DisG-nUxaZt9gfGA@mail.gmail.com>
 <CAJZ5v0iLq9L5nMp13BrBmbWavFs1ZEAtJ-WeyRzv3D2GXPNuag@mail.gmail.com>
 <CAGETcx-9XSdXcuGQFSoS-mMPwp=UJ3_FfTJ1Cx+9jddyjYTKEg@mail.gmail.com> <CAJZ5v0iWCWdjP9Gku2uV0Qz-Hp6ZEHDspaPVzHPPzHfvyREeWA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iWCWdjP9Gku2uV0Qz-Hp6ZEHDspaPVzHPPzHfvyREeWA@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 2 Dec 2024 15:27:33 -0800
Message-ID: <CAGETcx_5oRA-kTzU7WtWSV2=Bp0cKcT=2kPa0+ZkwkHTA+rwOQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] PM: sleep: Remove unnecessary mutex lock when
 waiting on parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
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

On Mon, Dec 2, 2024 at 1:15=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Mon, Dec 2, 2024 at 9:46=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
> >
> > On Mon, Dec 2, 2024 at 12:16=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Mon, Dec 2, 2024 at 9:11=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > > >
> > > > Sorry for the delay.
> > > >
> > > > On Thu, Nov 14, 2024 at 11:09=E2=80=AFPM Saravana Kannan <saravanak=
@google.com> wrote:
> > > > >
> > > > > Locking is not needed to do get_device(dev->parent). We either ge=
t a NULL
> > > > > (if the parent was cleared) or the actual parent. Also, when a de=
vice is
> > > > > deleted (device_del()) and removed from the dpm_list, its complet=
ion
> > > > > variable is also complete_all()-ed. So, we don't have to worry ab=
out
> > > > > waiting indefinitely on a deleted parent device.
> > > >
> > > > The device_pm_initialized(dev) check before get_device(dev->parent)
> > > > doesn't make sense without the locking and that's the whole point o=
f
> > > > it.
> > >
> > > Hmm, not really.
> > >
> > > How is the parent prevented from going away in get_device() right
> > > after the initial dev check without the locking?
> >
> > Not sure what you mean by "go away"? But get_device() is going to keep
> > a non-zero refcount on the parent so that struct doesn't get freed.
>
> That's after it has returned.
>
> There is nothing to prevent dev from being freed in get_device()
> itself before the kobject_get(&dev->kobj) call.
>
> So when get_device() is called, there needs to be an active ref on the
> device already or something else to prevent the target device object
> from being freed.
>
> In this particular case it is the lock along with the
> device_pm_initialized(dev) check on the child.

Ugh... my head hurts whenever I think about get_device(). Yeah, I
think you are right.

Hmm... I wanted to have this function be replaced by a call to a
generic helper function dpm_for_each_superior() in the next patch. But
that helper function could be called from places where the dpm_list
lock is held. Also, I was planning on making it even more generic (not
specific to dpm) in the future. So, depending on dpm_list lock didn't
make sense.

Any other ideas on how I could do this without grabbing the dpm_list mutex?

Actually, with the rewrite and at the end of this series, we don't
have to worry about this race because each device's suspend/resume is
only started after all the dependencies are done. So, if the parent
deletes a child and itself, the child device's suspend wouldn't have
been triggered at all.

So, another option is to just squash the series and call it a day. Or
add a comment to the commit text that this adds a race that's fixed by
the time we get to the end of the series.

Thoughts?

Thanks,
Saravana


>
> > The parent itself can still "go away" in terms of unbinding or
> > removing the children from the dpm_list(). But that's what the
> > device_pm_initialized() check is for. When a device_del() is called,
> > it's removed from the dpm_list. The actual freeing comes later. But we
> > aren't/weren't checking for that anyway.
> >
> > >
> > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > ---
> > > > >  drivers/base/power/main.c | 13 ++-----------
> > > > >  1 file changed, 2 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.=
c
> > > > > index 86e51b9fefab..9b9b6088e56a 100644
> > > > > --- a/drivers/base/power/main.c
> > > > > +++ b/drivers/base/power/main.c
> > > > > @@ -284,18 +284,9 @@ static bool dpm_wait_for_superior(struct dev=
ice *dev, bool async)
> > > > >          * counting the parent once more unless the device has be=
en deleted
> > > > >          * already (in which case return right away).
> > > > >          */
> > > > > -       mutex_lock(&dpm_list_mtx);
> > > > > -
> > > > > -       if (!device_pm_initialized(dev)) {
> > > > > -               mutex_unlock(&dpm_list_mtx);
> > > > > -               return false;
> > > > > -       }
> > > > > -
> > > > >         parent =3D get_device(dev->parent);
> > > > > -
> > > > > -       mutex_unlock(&dpm_list_mtx);
> > > > > -
> > > > > -       dpm_wait(parent, async);
> > > > > +       if (device_pm_initialized(dev))
> > > > > +               dpm_wait(parent, async);
> > > >
> > > > This is racy, so what's the point?
> > > >
> > > > You can just do
> > > >
> > > > parent =3D get_device(dev->parent);
> > > > dpm_wait(parent, async);
> >
> > Parent struct device being there isn't the same as whether this device
> > is in the dpm_list? So, shouldn't we still check this?
> >
> > Also, is it really racy anymore with the new algorithm? We don't kick
> > off the subordinates until after the parent is done.
> >
> > > >
> > > > and please update the comment above this.
> >
> > Will do.
> >
> > Thanks,
> > Saravana
> > > >
> > > > >         put_device(parent);
> > > > >
> > > > >         dpm_wait_for_suppliers(dev, async);
> > > > > --

