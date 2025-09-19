Return-Path: <linux-pm+bounces-35050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0AB8A6F2
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 17:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA053A7585
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49D631CA4E;
	Fri, 19 Sep 2025 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFDLpFO5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C015031A577
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297165; cv=none; b=aQ8DIaXvPsjTkJd0lwglp2PjbDVpWHBuUSwSbtKUpRnqOdpa1FrvyoF4nnxx3/i0M24aCF+rzPM3DnGUAdHk3nKy1Rfk3oWdIlJHC6Nvvfl3GJHvDJw37VVnIcN+7v67w8s0xHfEjzqUmDClYfGgEcDzGKn52DIP9oyOiBSfyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297165; c=relaxed/simple;
	bh=yu0BaAlhHdF9NB/b7woVzAzP1He1KTkForkbJthVWbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mn2g+53GYX3k9VHmaznFsZNREq4K1u0+MUsferHMh3GzIhm3fdIlOHXvX9TnUQxyxy5HzeVlSmIdAHMgZIfN7v8LCCtNqhWXXmE5Xxtj3EzWweoAJb2X8Zk6ELAK+E+Ne/WGmTJn5uEf305IymCiy8NllTpDosgXo4vYUKOCQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFDLpFO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6F2C4CEF0
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758297165;
	bh=yu0BaAlhHdF9NB/b7woVzAzP1He1KTkForkbJthVWbs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZFDLpFO5ifI7BRfGjmsMtgaJeRQSz947wRrt2PQMPyKbHA4SJqH1JXZufTwgCQKK3
	 g524lwIdYXr178bzBD+GWGO530kDB5BkTAfBodrkmMWrcS9t7pbrBHZPQnzWb7sH00
	 Y1oBgnjGlVXfUrMc4j1mxXdo8v0NT7B4CcVvoj7UROnz78NLwageN946qeDGvR0ojt
	 TWZ/S/FilN3qMcFxBRkYEnneWqcc/ja27xK5GCSYWbU/lHiuiaYG3AULa7H+NAcM4Z
	 cfKZEpEYccV8jayeQfWWxdZ9QdS8V0MXFFdKv/+SohkA4+2rk5dSwfKxVHvyYOOTX+
	 MDK3+QZCUBsPQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-757fda06b0cso1431307a34.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 08:52:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVE/MYsYd9ukznzDkdFMGIe/PT9RbWIZMDdPgbT1Or+jrjMdR2JLfelbukfdQGv4+NK61cDLUVkOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4x38YwX25PgLK2H1yOGGsaoZNmbOk/BnZc0mzOInle2AUhX0P
	MXN9TdWsFv6ApkZlcUtdPeaxBZEOQHI+4iLbwBWM0pZ8qOzNuXDlXFeJud8L6copxG8kn16/ikr
	2wm/i8BvPbFKt2E8M+dakHqJ3i6z7KWc=
X-Google-Smtp-Source: AGHT+IElFXgKPDJwIEbMIM/4QUHaRTFINLDiOMLhSlUDLMtp0jDVeYP+yeLmhyxPqd7xkKqoDPfbtToid0vtwInpRHw=
X-Received: by 2002:a05:6808:140a:b0:43b:252e:f7a4 with SMTP id
 5614622812f47-43d6c11294emr1727897b6e.1.1758297164666; Fri, 19 Sep 2025
 08:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qimv24u.wl-tiwai@suse.de> <CAJZ5v0hJvsuOTj5j-0Jn-c9TPnbm70wPvdBkop2hRrdweoncDg@mail.gmail.com>
 <87jz1uao65.wl-tiwai@suse.de> <12751070.O9o76ZdvQC@rafael.j.wysocki> <87ldma8sq1.wl-tiwai@suse.de>
In-Reply-To: <87ldma8sq1.wl-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 17:52:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jJjYoTceD2_pgvKgKuPypo+8osnAuCefgAjrzY_w2n8A@mail.gmail.com>
X-Gm-Features: AS18NWBbFanpIdD1FMjuGOYTBF45GYJUQFzReMhjN3B3PMyQPSWVM_rvJQkPXcM
Message-ID: <CAJZ5v0jJjYoTceD2_pgvKgKuPypo+8osnAuCefgAjrzY_w2n8A@mail.gmail.com>
Subject: Re: PM runtime auto-cleanup macros
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:41=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 19 Sep 2025 15:05:04 +0200,
> Rafael J. Wysocki wrote:
> >
> > On Friday, September 19, 2025 9:37:06 AM CEST Takashi Iwai wrote:
> > > On Thu, 18 Sep 2025 22:41:32 +0200,
> > > Rafael J. Wysocki wrote:
> > > >
> > > > On Thu, Sep 18, 2025 at 10:19=E2=80=AFPM Rafael J. Wysocki <rafael@=
kernel.org> wrote:
> > > > >
> > > > > On Thu, Sep 18, 2025 at 1:28=E2=80=AFPM Rafael J. Wysocki <rafael=
@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Sep 18, 2025 at 9:10=E2=80=AFAM Takashi Iwai <tiwai@sus=
e.de> wrote:
> > > > > > >
> > > > > > > On Wed, 17 Sep 2025 20:58:36 +0200,
> > > > > > > Rafael J. Wysocki wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > Sorry for the delay.
> > > > > > > >
> > > > > > > > On Thu, Sep 11, 2025 at 9:31=E2=80=AFAM Takashi Iwai <tiwai=
@suse.de> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 10 Sep 2025 16:00:17 +0200,
> > > > > > > > > Takashi Iwai wrote:
> > > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > while I worked on the code cleanups in the drivers with=
 the recent
> > > > > > > > > > auto-cleanup macros, I noticed that pm_runtime_get*() a=
nd _put*() can
> > > > > > > > > > be also managed with the auto-cleanup gracefully, too. =
 Actually we
> > > > > > > > > > already defined the __free(pm_runtime_put) in commit bf=
a4477751e9, and
> > > > > > > > > > there is a (single) user of it in pci-sysfs.c.
> > > > > > > > > >
> > > > > > > > > > Now I wanted to extend it to pm_runtime_put_autosuspend=
() as:
> > > > > > > > > >
> > > > > > > > > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *=
,
> > > > > > > > > >            if (_T) pm_runtime_put_autosuspend(_T))
> > > > > > > > > >
> > > > > > > > > > Then one can use it like
> > > > > > > > > >
> > > > > > > > > >       ret =3D pm_runtime_resume_and_get(dev);
> > > > > > > > > >       if (ret < 0)
> > > > > > > > > >               return ret;
> > > > > > > > > >       struct device *pmdev __free(pm_runtime_put_autosu=
spend) =3D dev;
> > > > > > > > > >
> > > > > > > > > > that is similar as done in pci-sysfs.c.  So far, so goo=
d.
> > > > > > > > > >
> > > > > > > > > > But, I find putting the line like above at each place a=
 bit ugly.
> > > > > > > > > > So I'm wondering whether it'd be better to introduce so=
me helper
> > > > > > > > > > macros, e.g.
> > > > > > > > > >
> > > > > > > > > > #define pm_runtime_auto_clean(dev, var) \
> > > > > > > > > >       struct device *var __free(pm_runtime_put) =3D (de=
v)
> > > > > > > > >
> > > > > > > > > It can be even simpler by assigning a temporary variable =
such as:
> > > > > > > > >
> > > > > > > > > #define pm_runtime_auto_clean(dev) \
> > > > > > > > >         struct device *__pm_runtime_var ## __LINE__ __fre=
e(pm_runtime_put) =3D (dev)
> > > > > > > >
> > > > > > > > Well, if there's something like
> > > > > > > >
> > > > > > > > struct device *pm_runtime_resume_and_get_dev(struct device =
*dev)
> > > > > > > > {
> > > > > > > >         int ret =3D pm_runtime_resume_and_get(dev);
> > > > > > > >         if (ret < 0)
> > > > > > > >                 return ERR_PTR(ret);
> > > > > > > >
> > > > > > > >         return dev;
> > > > > > > > }
> > > > > > > >
> > > > > > > > It would be a matter of redefining the FREE to also take er=
ror
> > > > > > > > pointers into account and you could do
> > > > > > > >
> > > > > > > > struct device *__dev __free(pm_runtim_put) =3D pm_runtime_r=
esume_and_get_dev(dev);
> > > > > > > > if (IS_ERR(__dev))
> > > > > > > >         return PTR_ERR(__dev);
> > > > > > >
> > > > > > > That'll work, too.  Though, I find the notion of __free() and=
 a
> > > > > > > temporary variable __dev a bit too cumbersome; it's used only=
 for
> > > > > > > auto-clean stuff, so it could be somewhat anonymous.
> > > > > >
> > > > > > No, it is not used only for auto-clean, it is also used for ret=
urn
> > > > > > value checking and it represents a reference on the original de=
v.  It
> > > > > > cannot be entirely anonymous because of the error checking part=
.
> > > > > >
> > > > > > The point is that this is one statement instead of two and so i=
t is
> > > > > > arguably harder to mess up with.
> > > > > >
> > > > > > > But it's all about a matter of taste, and I'd follow what you=
 and
> > > > > > > other guys suggest.
> > > > > > >
> > > > > > > FWIW, there are lots of code doing like
> > > > > > >
> > > > > > >         pm_runtime_get_sync(dev);
> > > > > > >         mutex_lock(&foo);
> > > > > > >         ....
> > > > > > >         mutex_unlock(&foo);
> > > > > > >         pm_runtime_put(dev);
> > > > > > >         return;
> > > > > > >
> > > > > > > or
> > > > > > >
> > > > > > >         ret =3D pm_runtime_resume_and_get(dev);
> > > > > > >         if (ret)
> > > > > > >                 return ret;
> > > > > > >         mutex_lock(&foo);
> > > > > > >         ....
> > > > > > >         mutex_unlock(&foo);
> > > > > > >         pm_runtime_put_autosuspend(dev);
> > > > > > >         return 0;
> > > > > > >
> > > > > > > and they can be converted nicely with guard() once when PM ru=
ntime can
> > > > > > > be automatically unreferenced.  With my proposed change, it w=
ould
> > > > > > > become like:
> > > > > > >
> > > > > > >         pm_runtime_get_sync(dev);
> > > > > > >         pm_runtime_auto_clean(dev);
> > > > > >
> > > > > > For the case in which the pm_runtime_get_sync() return value is
> > > > > > discarded, you could define a guard and do
> > > > > >
> > > > > > guard(pm_runtime_get_sync)(dev);
> > > > > >
> > > > > > here.
> > > > > >
> > > > > > The case checking the return value is less straightforward.
> > > > > >
> > > > > > >         guard(mutex)(&foo);
> > > > > > >         ....
> > > > > > >         return;
> > > > > > >
> > > > > > > or
> > > > > > >
> > > > > > >         ret =3D pm_runtime_resume_and_get(dev);
> > > > > > >         if (ret)
> > > > > > >                 return ret;
> > > > > > >         pm_runtime_auto_clean_autosuspend(dev);
> > > > > > >         guard(mutex)(&foo);
> > > > > > >         ....
> > > > > > >         return 0;
> > > > > > >
> > > > >
> > > > > I guess what I'm saying means basically something like this:
> > > > >
> > > > > DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
> > > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put(_T),
> > > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > > >
> > > > > DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
> > > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put_autosuspend(_T),
> > > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > > >
> > > > > and analogously for pm_runtime_get_sync().
> > > >
> > > > And it kind of makes sense either.  Do
> > > >
> > > > CLASS(pm_runtime_resume_and_get, active_dev)(dev);
> > > > if (IS_ERR(active_dev))
> > > >         return PTR_ERR(active_dev);
> > > >
> > > > and now use active_dev for representing the device until it gets ou=
t
> > > > of the scope.
> > >
> > > Yes, that's what I thought of as an alternative, too, but I didn't
> > > consider using only pm_runtime_resume_and_get().  Actually by this
> > > action, we can also "clean up" the API usage at the same time to use =
a
> > > single recommended API function, which is a good thing.
> > >
> > > That said, I like this way :)
> > >
> > > It'd be nice if this change can go into 6.18, then I can put the
> > > driver cleanup works for 6.19.  It's a bit late stage for 6.18, but
> > > this change is definitely safe and can't break, per se.
> >
> > OK, do you mean something like the patch below?
>
> Yes!

OK

> An easy follower is the patch like below.
> (It's the only user of __free(pm_runtime_*) in linux-next as of now.)

So the __free(pm_runtime_*) could be dropped after this patch I suppose?

In that case, let me send a series of 3 patches which will add the new
class definitions, switch over PCI to using them (your patch), and
drop the existing pm_runtime_put FREE.

