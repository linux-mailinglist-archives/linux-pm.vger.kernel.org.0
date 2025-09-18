Return-Path: <linux-pm+bounces-34956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8001B845A8
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 13:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A6F1BC465C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 11:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9F930102A;
	Thu, 18 Sep 2025 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl2XmFWz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06320296BDA
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194932; cv=none; b=mrwuLAuIMoIbKV0yq4sOeEdGDYMN/TN7kSPH56ZdB5rwbNUyvDqmpLnWECedUFNxG+iEWhMqFc/RHkB+WBa/fBw0RewSJNSmPm7lX0V9kru+sGHHVt99ltrebEnPaWdmUP0vibjk0Mp9Ut+vOpu2aSb3NAow/VPJDZhbzDmeijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194932; c=relaxed/simple;
	bh=aGX4zFbu6ixCH3Tv8vvb+Ir1zlZCuHzA62pjtMb8H9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XL5k0Hqg0QLPQ2TBj8WYwkTi+Uww0jC57LRER2NvgSxbNF1JDVEha/uMZdz3/uPyYYqoT/GSFoVhot9ZlMa8JaUm+mitrIXg1sgoMkJfOteLDBWX+QexnmkAP0uvOUCdd83vn8cPyA2J7qX0wpuQbux6fXCzTJB27G6lXstkr5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl2XmFWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905DDC4AF09
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758194931;
	bh=aGX4zFbu6ixCH3Tv8vvb+Ir1zlZCuHzA62pjtMb8H9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sl2XmFWziQwzMxXE4tAL7uEPE4V11Hf8IaCAsWJDZ0YQBRLZzEgMdeCZIMpHyu20d
	 gNqX+5NlxMIrrtCDuEpNlma4oC7v2fE25cUx1itTYKYsHfwJQPpoWrN3w9GjdSX4mi
	 iF1QdbkWNvSvVmTxc44xKpdsgnWETPBH/zUKt1GzYfjm7mKa9byRjWV9RQ3Q7FUxkx
	 eloZUCZaCbFZo00WWk/g2aXVwi0y8YKYdVggu3kaahtGhK3uBz3LWJ8aPVO6YKarar
	 qAJTr+Tn4DPqzOYAN9jD2hkFl8+CWfDUoXFDXdTz0QIAkCo8kCnqXbVlJ/FCfxJpnS
	 f21l8veoIYuSA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-746d7c469a8so703301a34.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 04:28:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJhbOpRqIJm3CCaRNwsDzH5MMLISgcqvJvukyE1QNvH7Bb11e+LrRzkVn2x8H9PRzIKk68RGAokQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8ooPIPQuazKNdOh3Pm9sPc4CZtxsJXILOcTjoZfknk45TtMl
	PpS3jWUL6vOx44w+bi9SfvsX4rI4KM9hvTfdan0yC6MYN5fhNQgJymDhS+Hjj6Ls0KPN8vlUmw3
	xLrj9rerSRYzPAQ3GERU//z42EvnpQoI=
X-Google-Smtp-Source: AGHT+IHe7GVU0yxBg/xdy5kAVi+cnsgH8FVocDQJtOYW5b+idqPIhO8Ey8RCPsDzzIJoKeHKDMqWERmGkh05IbRrmiw=
X-Received: by 2002:a05:6808:f94:b0:43d:2dc4:9d16 with SMTP id
 5614622812f47-43d50a8e97bmr2588108b6e.9.1758194930823; Thu, 18 Sep 2025
 04:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qimv24u.wl-tiwai@suse.de> <87ikhptpgm.wl-tiwai@suse.de>
 <CAJZ5v0htMKOcCoKts-B9BaE0VpS2oc9-cp=5VnNwS2Qe2iB+Kg@mail.gmail.com> <87tt10b5hq.wl-tiwai@suse.de>
In-Reply-To: <87tt10b5hq.wl-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Sep 2025 13:28:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hUTByfxkE=-SGSHDDd=mPw694yD7PuuJ1LLRjp-H4=uA@mail.gmail.com>
X-Gm-Features: AS18NWA4sJvRMM6lzUoIW98fo5qumY39WEP-CzBbiU-mbi_9Mil7xxpLJakcxfk
Message-ID: <CAJZ5v0hUTByfxkE=-SGSHDDd=mPw694yD7PuuJ1LLRjp-H4=uA@mail.gmail.com>
Subject: Re: PM runtime auto-cleanup macros
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 9:10=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 17 Sep 2025 20:58:36 +0200,
> Rafael J. Wysocki wrote:
> >
> > Hi,
> >
> > Sorry for the delay.
> >
> > On Thu, Sep 11, 2025 at 9:31=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wr=
ote:
> > >
> > > On Wed, 10 Sep 2025 16:00:17 +0200,
> > > Takashi Iwai wrote:
> > > >
> > > > Hi,
> > > >
> > > > while I worked on the code cleanups in the drivers with the recent
> > > > auto-cleanup macros, I noticed that pm_runtime_get*() and _put*() c=
an
> > > > be also managed with the auto-cleanup gracefully, too.  Actually we
> > > > already defined the __free(pm_runtime_put) in commit bfa4477751e9, =
and
> > > > there is a (single) user of it in pci-sysfs.c.
> > > >
> > > > Now I wanted to extend it to pm_runtime_put_autosuspend() as:
> > > >
> > > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
> > > >            if (_T) pm_runtime_put_autosuspend(_T))
> > > >
> > > > Then one can use it like
> > > >
> > > >       ret =3D pm_runtime_resume_and_get(dev);
> > > >       if (ret < 0)
> > > >               return ret;
> > > >       struct device *pmdev __free(pm_runtime_put_autosuspend) =3D d=
ev;
> > > >
> > > > that is similar as done in pci-sysfs.c.  So far, so good.
> > > >
> > > > But, I find putting the line like above at each place a bit ugly.
> > > > So I'm wondering whether it'd be better to introduce some helper
> > > > macros, e.g.
> > > >
> > > > #define pm_runtime_auto_clean(dev, var) \
> > > >       struct device *var __free(pm_runtime_put) =3D (dev)
> > >
> > > It can be even simpler by assigning a temporary variable such as:
> > >
> > > #define pm_runtime_auto_clean(dev) \
> > >         struct device *__pm_runtime_var ## __LINE__ __free(pm_runtime=
_put) =3D (dev)
> >
> > Well, if there's something like
> >
> > struct device *pm_runtime_resume_and_get_dev(struct device *dev)
> > {
> >         int ret =3D pm_runtime_resume_and_get(dev);
> >         if (ret < 0)
> >                 return ERR_PTR(ret);
> >
> >         return dev;
> > }
> >
> > It would be a matter of redefining the FREE to also take error
> > pointers into account and you could do
> >
> > struct device *__dev __free(pm_runtim_put) =3D pm_runtime_resume_and_ge=
t_dev(dev);
> > if (IS_ERR(__dev))
> >         return PTR_ERR(__dev);
>
> That'll work, too.  Though, I find the notion of __free() and a
> temporary variable __dev a bit too cumbersome; it's used only for
> auto-clean stuff, so it could be somewhat anonymous.

No, it is not used only for auto-clean, it is also used for return
value checking and it represents a reference on the original dev.  It
cannot be entirely anonymous because of the error checking part.

The point is that this is one statement instead of two and so it is
arguably harder to mess up with.

> But it's all about a matter of taste, and I'd follow what you and
> other guys suggest.
>
> FWIW, there are lots of code doing like
>
>         pm_runtime_get_sync(dev);
>         mutex_lock(&foo);
>         ....
>         mutex_unlock(&foo);
>         pm_runtime_put(dev);
>         return;
>
> or
>
>         ret =3D pm_runtime_resume_and_get(dev);
>         if (ret)
>                 return ret;
>         mutex_lock(&foo);
>         ....
>         mutex_unlock(&foo);
>         pm_runtime_put_autosuspend(dev);
>         return 0;
>
> and they can be converted nicely with guard() once when PM runtime can
> be automatically unreferenced.  With my proposed change, it would
> become like:
>
>         pm_runtime_get_sync(dev);
>         pm_runtime_auto_clean(dev);

For the case in which the pm_runtime_get_sync() return value is
discarded, you could define a guard and do

guard(pm_runtime_get_sync)(dev);

here.

The case checking the return value is less straightforward.

>         guard(mutex)(&foo);
>         ....
>         return;
>
> or
>
>         ret =3D pm_runtime_resume_and_get(dev);
>         if (ret)
>                 return ret;
>         pm_runtime_auto_clean_autosuspend(dev);
>         guard(mutex)(&foo);
>         ....
>         return 0;
>
>

