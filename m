Return-Path: <linux-pm+bounces-35000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEF1B86EF1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 22:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99607E4A32
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 20:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B972F28F9;
	Thu, 18 Sep 2025 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDjaykv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFC2F28E2
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228105; cv=none; b=G2ndQiV0dxyRvWljafSyL+lSB6qoz1G20SA/OoL7abtlwV0xnVSMeDaw8NI2PesSuEcCHnGOFr2lY8AMI8eSmQmwj2W+b2PYtCTXvdgV/voHx62b/v3oupF2tvpkdTZdu377OUb9Jw0znJOkVYLFs+quCO1wDCi4HGGfN+g4Zt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228105; c=relaxed/simple;
	bh=aDocuMnkv4mVo6KXRe3fiBe9cisLwlR+sER5CgmTjug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJNCdqC5rXiOUQUyek3D+ig4YxpyzD5yd2vgybxse7jR1ETvq82R8nHB3kjyfwBQ4LT7vj3r/x3UUBuWjpkbOC3Vm5MxqzzM5pytHTws+3htgHwyIC/TCgMGLJoWiOa6qeJW8snXxrSshwmunh/uTefbTrjtWlj8L4IxtIF6mpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDjaykv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23E7C4CEF1
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 20:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758228104;
	bh=aDocuMnkv4mVo6KXRe3fiBe9cisLwlR+sER5CgmTjug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iDjaykv5WkLRmbqgn7D1eJ4lMgVq2g6VdG2QFNtcV9q9PkcSYZRHGoHH/qxoZgosq
	 nnip1d0MLmjtDjl8a9u57Qubmk0ajm3MbHiPBwmnh1QGiY+V4FqYhDwWz/qyiikUUD
	 ZcJoWelwTHd++iFNi6pHKOT0FFNTBXAbBnTehrgJ7grz1dOrEvoQ7b8Xikaap6r7bH
	 TNWVesKbHchdr+kf27oGETe8V/+hu5Vsf7k87Y5epcZIRHzPnaEWNSQiTRoDX+zdPy
	 JR1XCKVitNznSlsATuq0QEKizl983Ac0i7ZE5SA1ZRwKya/J471adPYCOJUzMhIeOM
	 x+X30iWwk9nQw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3357b8aeddaso2106741fac.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 13:41:44 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw80cgT/AEfSQgmTwDzw5oRoBmToqKtmn/ZvA4Gj7Ci3HsvZQ+M
	zlNRdR7X/IqL55CxhqFOcLQ5qzWLmrgW7+0dF/F5Ztj4AWM3rhhQrz1JOAb5EysNARi0R0J8gMv
	brIpkNeDjYFg34yvegJ+j5IcM5QX4oUc=
X-Google-Smtp-Source: AGHT+IHbgn+Em6qgOGkmyyKFH4O6KrMY22fLCzxb2sK+AcbcoPYSM2t5aezkKL+Wj4iS8cE+9rtGtf7IGswC1rBRJ4s=
X-Received: by 2002:a05:6808:50a8:b0:439:af0a:dca4 with SMTP id
 5614622812f47-43d6c288304mr401495b6e.35.1758228104044; Thu, 18 Sep 2025
 13:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qimv24u.wl-tiwai@suse.de> <87ikhptpgm.wl-tiwai@suse.de>
 <CAJZ5v0htMKOcCoKts-B9BaE0VpS2oc9-cp=5VnNwS2Qe2iB+Kg@mail.gmail.com>
 <87tt10b5hq.wl-tiwai@suse.de> <CAJZ5v0hUTByfxkE=-SGSHDDd=mPw694yD7PuuJ1LLRjp-H4=uA@mail.gmail.com>
 <CAJZ5v0jafoG--WrZNjt+euY0gtQSTqSDH2_cWotf92ziq5wdUw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jafoG--WrZNjt+euY0gtQSTqSDH2_cWotf92ziq5wdUw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Sep 2025 22:41:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJvsuOTj5j-0Jn-c9TPnbm70wPvdBkop2hRrdweoncDg@mail.gmail.com>
X-Gm-Features: AS18NWDkTaA7k8ZeUuuh_IsjSGk4mkR6cG4n3fK_qylbpPgCTEu85hQKQVPaUbE
Message-ID: <CAJZ5v0hJvsuOTj5j-0Jn-c9TPnbm70wPvdBkop2hRrdweoncDg@mail.gmail.com>
Subject: Re: PM runtime auto-cleanup macros
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:19=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Sep 18, 2025 at 1:28=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Sep 18, 2025 at 9:10=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wr=
ote:
> > >
> > > On Wed, 17 Sep 2025 20:58:36 +0200,
> > > Rafael J. Wysocki wrote:
> > > >
> > > > Hi,
> > > >
> > > > Sorry for the delay.
> > > >
> > > > On Thu, Sep 11, 2025 at 9:31=E2=80=AFAM Takashi Iwai <tiwai@suse.de=
> wrote:
> > > > >
> > > > > On Wed, 10 Sep 2025 16:00:17 +0200,
> > > > > Takashi Iwai wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > while I worked on the code cleanups in the drivers with the rec=
ent
> > > > > > auto-cleanup macros, I noticed that pm_runtime_get*() and _put*=
() can
> > > > > > be also managed with the auto-cleanup gracefully, too.  Actuall=
y we
> > > > > > already defined the __free(pm_runtime_put) in commit bfa4477751=
e9, and
> > > > > > there is a (single) user of it in pci-sysfs.c.
> > > > > >
> > > > > > Now I wanted to extend it to pm_runtime_put_autosuspend() as:
> > > > > >
> > > > > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
> > > > > >            if (_T) pm_runtime_put_autosuspend(_T))
> > > > > >
> > > > > > Then one can use it like
> > > > > >
> > > > > >       ret =3D pm_runtime_resume_and_get(dev);
> > > > > >       if (ret < 0)
> > > > > >               return ret;
> > > > > >       struct device *pmdev __free(pm_runtime_put_autosuspend) =
=3D dev;
> > > > > >
> > > > > > that is similar as done in pci-sysfs.c.  So far, so good.
> > > > > >
> > > > > > But, I find putting the line like above at each place a bit ugl=
y.
> > > > > > So I'm wondering whether it'd be better to introduce some helpe=
r
> > > > > > macros, e.g.
> > > > > >
> > > > > > #define pm_runtime_auto_clean(dev, var) \
> > > > > >       struct device *var __free(pm_runtime_put) =3D (dev)
> > > > >
> > > > > It can be even simpler by assigning a temporary variable such as:
> > > > >
> > > > > #define pm_runtime_auto_clean(dev) \
> > > > >         struct device *__pm_runtime_var ## __LINE__ __free(pm_run=
time_put) =3D (dev)
> > > >
> > > > Well, if there's something like
> > > >
> > > > struct device *pm_runtime_resume_and_get_dev(struct device *dev)
> > > > {
> > > >         int ret =3D pm_runtime_resume_and_get(dev);
> > > >         if (ret < 0)
> > > >                 return ERR_PTR(ret);
> > > >
> > > >         return dev;
> > > > }
> > > >
> > > > It would be a matter of redefining the FREE to also take error
> > > > pointers into account and you could do
> > > >
> > > > struct device *__dev __free(pm_runtim_put) =3D pm_runtime_resume_an=
d_get_dev(dev);
> > > > if (IS_ERR(__dev))
> > > >         return PTR_ERR(__dev);
> > >
> > > That'll work, too.  Though, I find the notion of __free() and a
> > > temporary variable __dev a bit too cumbersome; it's used only for
> > > auto-clean stuff, so it could be somewhat anonymous.
> >
> > No, it is not used only for auto-clean, it is also used for return
> > value checking and it represents a reference on the original dev.  It
> > cannot be entirely anonymous because of the error checking part.
> >
> > The point is that this is one statement instead of two and so it is
> > arguably harder to mess up with.
> >
> > > But it's all about a matter of taste, and I'd follow what you and
> > > other guys suggest.
> > >
> > > FWIW, there are lots of code doing like
> > >
> > >         pm_runtime_get_sync(dev);
> > >         mutex_lock(&foo);
> > >         ....
> > >         mutex_unlock(&foo);
> > >         pm_runtime_put(dev);
> > >         return;
> > >
> > > or
> > >
> > >         ret =3D pm_runtime_resume_and_get(dev);
> > >         if (ret)
> > >                 return ret;
> > >         mutex_lock(&foo);
> > >         ....
> > >         mutex_unlock(&foo);
> > >         pm_runtime_put_autosuspend(dev);
> > >         return 0;
> > >
> > > and they can be converted nicely with guard() once when PM runtime ca=
n
> > > be automatically unreferenced.  With my proposed change, it would
> > > become like:
> > >
> > >         pm_runtime_get_sync(dev);
> > >         pm_runtime_auto_clean(dev);
> >
> > For the case in which the pm_runtime_get_sync() return value is
> > discarded, you could define a guard and do
> >
> > guard(pm_runtime_get_sync)(dev);
> >
> > here.
> >
> > The case checking the return value is less straightforward.
> >
> > >         guard(mutex)(&foo);
> > >         ....
> > >         return;
> > >
> > > or
> > >
> > >         ret =3D pm_runtime_resume_and_get(dev);
> > >         if (ret)
> > >                 return ret;
> > >         pm_runtime_auto_clean_autosuspend(dev);
> > >         guard(mutex)(&foo);
> > >         ....
> > >         return 0;
> > >
>
> I guess what I'm saying means basically something like this:
>
> DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
>          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put(_T),
> pm_runtime_resume_and_get_dev(dev), struct device *dev)
>
> DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
>          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put_autosuspend(_T),
> pm_runtime_resume_and_get_dev(dev), struct device *dev)
>
> and analogously for pm_runtime_get_sync().

And it kind of makes sense either.  Do

CLASS(pm_runtime_resume_and_get, active_dev)(dev);
if (IS_ERR(active_dev))
        return PTR_ERR(active_dev);

and now use active_dev for representing the device until it gets out
of the scope.

