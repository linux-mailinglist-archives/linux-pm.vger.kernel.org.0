Return-Path: <linux-pm+bounces-35048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAECDB8A698
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 17:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5E01CC528D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A31232126F;
	Fri, 19 Sep 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8H4AVhb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C1321264
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296969; cv=none; b=NiaEuaPZL5+MbC/zRhhr93GETALzicJVfhQF7ZDvbFh6AR6Npy8xluNEl7g+b0lUvy/aXghvaOAjUb/qkH/NxhQ7LzPx7sOmMXyQ6+VosOl0Le45iXXbE+UpWPa3HgQ9QPtGxDQ/BfjJ0ngAB63hthn83tBPrVDO/uV66MmfX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296969; c=relaxed/simple;
	bh=OjeUS1xUO9VKQqDyPDEKkqWfbtIP9n1TJO8kyFgx4Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajzdPk+BC778WaTBql0l5SJGiFh8nBPPpVBrqulqffTuVuef5LbI8lEsVX18Af15hK7jlVb88GCmre/AtZFs0d34sQoaHI01YZi+jFCG7tAiPDMnCTU9gnTKnlXSs8uaecqtum7Mw0475OQD3JZwFqkBzUbJRyg0ZZ2EvUsY/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8H4AVhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A02C4CEF1
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758296969;
	bh=OjeUS1xUO9VKQqDyPDEKkqWfbtIP9n1TJO8kyFgx4Fo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m8H4AVhbdj79oX4PtqPt6/LsXicElgzLJlU65dEcUvYdqgh+kzzQdma3aLQrWrTsl
	 tKtGSAGfLgGwl8uk4AqA087EVjchomJT1Qq54Y91zGvCYBiHUZ2jhw2ffxq8Z3s1WH
	 xoUA7DRcfjCnRS06JIAVUa5F3lOLqW2aVLeBRmyp6T57m6xJAtFyEtLEmsREOCjEjM
	 a3Mx0P5ZhG/O2OHNH7nPTCh+lfmiXsbtzx09nWtUfpiiK/5nnhANq+TZ9rBRDIoawn
	 Y1S1jO6YEb+dti4b7wvNVWCkBDP+4VWw3zY8Q9MByerRP3K70RMS9Vu8NtIWe4Bmyv
	 t2oTwXvHu6IcA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-62355a687e6so1582847eaf.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 08:49:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFfm9v47GEIBtW3fU3Rdew21U1fOrSQHsj1/qZWg8xUNYsVJFqqwLpG0jfmXh58ZeTUfQ+HDLBVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa9fQJh+wy9gcrpz0hfmk2SpH4iSCgkPjDTFWCcvNJ8IJn7KM8
	pvPEaGjWfMINMZRjZch+mizqIQdGT4fQaPzwWYwK6stfMm1skQm1+61ujgeZkHPxqp2T+nCJmG1
	vo5QtMBooa+ecxkqkKrVoDJQNieszyck=
X-Google-Smtp-Source: AGHT+IG0LxZ/DsMKuutYisOP3A4z7jBmYhlzCwVDoi7MSN6EsWz+45UfZ9ff30swMbXGa2XMvHFdAq1gt8b2ZSXJnxQ=
X-Received: by 2002:a05:6808:11cd:b0:43d:2454:b69f with SMTP id
 5614622812f47-43d6c115e33mr1815898b6e.10.1758296968354; Fri, 19 Sep 2025
 08:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qimv24u.wl-tiwai@suse.de> <CAJZ5v0hJvsuOTj5j-0Jn-c9TPnbm70wPvdBkop2hRrdweoncDg@mail.gmail.com>
 <87jz1uao65.wl-tiwai@suse.de> <12751070.O9o76ZdvQC@rafael.j.wysocki>
 <87ldma8sq1.wl-tiwai@suse.de> <87jz1u8sn9.wl-tiwai@suse.de>
In-Reply-To: <87jz1u8sn9.wl-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 17:49:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ggvL420OmU2G=0kEGeiJct3hiBPTHCn5wFwwLkQpugCw@mail.gmail.com>
X-Gm-Features: AS18NWDicNoivABKnZkYyPyfwGfiStk5PMDvvuyS4L5rsYDOpnP5PW5u-umpprA
Message-ID: <CAJZ5v0ggvL420OmU2G=0kEGeiJct3hiBPTHCn5wFwwLkQpugCw@mail.gmail.com>
Subject: Re: PM runtime auto-cleanup macros
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:43=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 19 Sep 2025 15:41:42 +0200,
> Takashi Iwai wrote:
> >
> > On Fri, 19 Sep 2025 15:05:04 +0200,
> > Rafael J. Wysocki wrote:
> > >
> > > On Friday, September 19, 2025 9:37:06 AM CEST Takashi Iwai wrote:
> > > > On Thu, 18 Sep 2025 22:41:32 +0200,
> > > > Rafael J. Wysocki wrote:
> > > > >
> > > > > On Thu, Sep 18, 2025 at 10:19=E2=80=AFPM Rafael J. Wysocki <rafae=
l@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Sep 18, 2025 at 1:28=E2=80=AFPM Rafael J. Wysocki <rafa=
el@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Sep 18, 2025 at 9:10=E2=80=AFAM Takashi Iwai <tiwai@s=
use.de> wrote:
> > > > > > > >
> > > > > > > > On Wed, 17 Sep 2025 20:58:36 +0200,
> > > > > > > > Rafael J. Wysocki wrote:
> > > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > Sorry for the delay.
> > > > > > > > >
> > > > > > > > > On Thu, Sep 11, 2025 at 9:31=E2=80=AFAM Takashi Iwai <tiw=
ai@suse.de> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, 10 Sep 2025 16:00:17 +0200,
> > > > > > > > > > Takashi Iwai wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi,
> > > > > > > > > > >
> > > > > > > > > > > while I worked on the code cleanups in the drivers wi=
th the recent
> > > > > > > > > > > auto-cleanup macros, I noticed that pm_runtime_get*()=
 and _put*() can
> > > > > > > > > > > be also managed with the auto-cleanup gracefully, too=
.  Actually we
> > > > > > > > > > > already defined the __free(pm_runtime_put) in commit =
bfa4477751e9, and
> > > > > > > > > > > there is a (single) user of it in pci-sysfs.c.
> > > > > > > > > > >
> > > > > > > > > > > Now I wanted to extend it to pm_runtime_put_autosuspe=
nd() as:
> > > > > > > > > > >
> > > > > > > > > > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device=
 *,
> > > > > > > > > > >            if (_T) pm_runtime_put_autosuspend(_T))
> > > > > > > > > > >
> > > > > > > > > > > Then one can use it like
> > > > > > > > > > >
> > > > > > > > > > >       ret =3D pm_runtime_resume_and_get(dev);
> > > > > > > > > > >       if (ret < 0)
> > > > > > > > > > >               return ret;
> > > > > > > > > > >       struct device *pmdev __free(pm_runtime_put_auto=
suspend) =3D dev;
> > > > > > > > > > >
> > > > > > > > > > > that is similar as done in pci-sysfs.c.  So far, so g=
ood.
> > > > > > > > > > >
> > > > > > > > > > > But, I find putting the line like above at each place=
 a bit ugly.
> > > > > > > > > > > So I'm wondering whether it'd be better to introduce =
some helper
> > > > > > > > > > > macros, e.g.
> > > > > > > > > > >
> > > > > > > > > > > #define pm_runtime_auto_clean(dev, var) \
> > > > > > > > > > >       struct device *var __free(pm_runtime_put) =3D (=
dev)
> > > > > > > > > >
> > > > > > > > > > It can be even simpler by assigning a temporary variabl=
e such as:
> > > > > > > > > >
> > > > > > > > > > #define pm_runtime_auto_clean(dev) \
> > > > > > > > > >         struct device *__pm_runtime_var ## __LINE__ __f=
ree(pm_runtime_put) =3D (dev)
> > > > > > > > >
> > > > > > > > > Well, if there's something like
> > > > > > > > >
> > > > > > > > > struct device *pm_runtime_resume_and_get_dev(struct devic=
e *dev)
> > > > > > > > > {
> > > > > > > > >         int ret =3D pm_runtime_resume_and_get(dev);
> > > > > > > > >         if (ret < 0)
> > > > > > > > >                 return ERR_PTR(ret);
> > > > > > > > >
> > > > > > > > >         return dev;
> > > > > > > > > }
> > > > > > > > >
> > > > > > > > > It would be a matter of redefining the FREE to also take =
error
> > > > > > > > > pointers into account and you could do
> > > > > > > > >
> > > > > > > > > struct device *__dev __free(pm_runtim_put) =3D pm_runtime=
_resume_and_get_dev(dev);
> > > > > > > > > if (IS_ERR(__dev))
> > > > > > > > >         return PTR_ERR(__dev);
> > > > > > > >
> > > > > > > > That'll work, too.  Though, I find the notion of __free() a=
nd a
> > > > > > > > temporary variable __dev a bit too cumbersome; it's used on=
ly for
> > > > > > > > auto-clean stuff, so it could be somewhat anonymous.
> > > > > > >
> > > > > > > No, it is not used only for auto-clean, it is also used for r=
eturn
> > > > > > > value checking and it represents a reference on the original =
dev.  It
> > > > > > > cannot be entirely anonymous because of the error checking pa=
rt.
> > > > > > >
> > > > > > > The point is that this is one statement instead of two and so=
 it is
> > > > > > > arguably harder to mess up with.
> > > > > > >
> > > > > > > > But it's all about a matter of taste, and I'd follow what y=
ou and
> > > > > > > > other guys suggest.
> > > > > > > >
> > > > > > > > FWIW, there are lots of code doing like
> > > > > > > >
> > > > > > > >         pm_runtime_get_sync(dev);
> > > > > > > >         mutex_lock(&foo);
> > > > > > > >         ....
> > > > > > > >         mutex_unlock(&foo);
> > > > > > > >         pm_runtime_put(dev);
> > > > > > > >         return;
> > > > > > > >
> > > > > > > > or
> > > > > > > >
> > > > > > > >         ret =3D pm_runtime_resume_and_get(dev);
> > > > > > > >         if (ret)
> > > > > > > >                 return ret;
> > > > > > > >         mutex_lock(&foo);
> > > > > > > >         ....
> > > > > > > >         mutex_unlock(&foo);
> > > > > > > >         pm_runtime_put_autosuspend(dev);
> > > > > > > >         return 0;
> > > > > > > >
> > > > > > > > and they can be converted nicely with guard() once when PM =
runtime can
> > > > > > > > be automatically unreferenced.  With my proposed change, it=
 would
> > > > > > > > become like:
> > > > > > > >
> > > > > > > >         pm_runtime_get_sync(dev);
> > > > > > > >         pm_runtime_auto_clean(dev);
> > > > > > >
> > > > > > > For the case in which the pm_runtime_get_sync() return value =
is
> > > > > > > discarded, you could define a guard and do
> > > > > > >
> > > > > > > guard(pm_runtime_get_sync)(dev);
> > > > > > >
> > > > > > > here.
> > > > > > >
> > > > > > > The case checking the return value is less straightforward.
> > > > > > >
> > > > > > > >         guard(mutex)(&foo);
> > > > > > > >         ....
> > > > > > > >         return;
> > > > > > > >
> > > > > > > > or
> > > > > > > >
> > > > > > > >         ret =3D pm_runtime_resume_and_get(dev);
> > > > > > > >         if (ret)
> > > > > > > >                 return ret;
> > > > > > > >         pm_runtime_auto_clean_autosuspend(dev);
> > > > > > > >         guard(mutex)(&foo);
> > > > > > > >         ....
> > > > > > > >         return 0;
> > > > > > > >
> > > > > >
> > > > > > I guess what I'm saying means basically something like this:
> > > > > >
> > > > > > DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
> > > > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put(_T),
> > > > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > > > >
> > > > > > DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
> > > > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put_autosuspend(_T=
),
> > > > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > > > >
> > > > > > and analogously for pm_runtime_get_sync().
> > > > >
> > > > > And it kind of makes sense either.  Do
> > > > >
> > > > > CLASS(pm_runtime_resume_and_get, active_dev)(dev);
> > > > > if (IS_ERR(active_dev))
> > > > >         return PTR_ERR(active_dev);
> > > > >
> > > > > and now use active_dev for representing the device until it gets =
out
> > > > > of the scope.
> > > >
> > > > Yes, that's what I thought of as an alternative, too, but I didn't
> > > > consider using only pm_runtime_resume_and_get().  Actually by this
> > > > action, we can also "clean up" the API usage at the same time to us=
e a
> > > > single recommended API function, which is a good thing.
> > > >
> > > > That said, I like this way :)
> > > >
> > > > It'd be nice if this change can go into 6.18, then I can put the
> > > > driver cleanup works for 6.19.  It's a bit late stage for 6.18, but
> > > > this change is definitely safe and can't break, per se.
> > >
> > > OK, do you mean something like the patch below?
> >
> > Yes!
> >
> > An easy follower is the patch like below.
>
> Err, I forgot to refresh before generating a patch.
> The proper one is below.
>
>
> Takashi
>
> -- 8< --
> Subject: [PATCH] PCI: Use PM runtime class macro for the auto cleanup
>
> The newly introduced class macro can simplify the code.
> Also, add the proper error handling for the PM runtime get, too.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/pci/pci-sysfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5eea14c1f7f5..87c2311494bf 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct device *de=
v,
>                 return count;
>         }
>
> -       pm_runtime_get_sync(dev);
> -       struct device *pmdev __free(pm_runtime_put) =3D dev;
> +       CLASS(pm_runtime_resume_and_get, pmdev)(dev);
> +       if (IS_ERR(pmdev))
> +               return PTR_ERR(pmdev);

This error will propagate to user space AFAICS and some of the values
may be confusing in that respect, so it may be better to return -ENXIO
here.

>
>         if (sysfs_streq(buf, "default")) {
>                 pci_init_reset_methods(pdev);
> --

