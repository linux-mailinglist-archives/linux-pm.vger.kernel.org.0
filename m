Return-Path: <linux-pm+bounces-34998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF968B86E09
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 22:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC917AB5F1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 20:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C52FBDF8;
	Thu, 18 Sep 2025 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/qj3TiJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30C22E36EC
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226776; cv=none; b=AI/VDKM0EhSXDFNhf01siz1JM3VXp1eyQSB+CX5Y002r8UDWyLVIOwfRex0Ka7jB1l0Z6ATKyq0W362LOglCw8XIF8Oe7d6fBQQSfcXHQlC9hGjzu90IXfW1vFcqU1E5eKFpolwQqNVSqZmzfh52VKksMyI/P6iifYAq/DKVnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226776; c=relaxed/simple;
	bh=sEs1SmKhcZ+GDVVt7rB6DOcGfiNBSmPezwtXQFXwSos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuKX54CKHGeDiMRcOIZCMklg68fzY5s7nDwJrEip7IhIYp8J0AkRHwWXF7xDRL9vPVoIATzSMg4kdK4WkS4eNIN27wzJcjLFCWlPmOJ0VRhDppuBu9aEhhoBgaQnWZG8WDiXAGiuCX9aZAGhzzK6bg/VvCWbx2XpF+snY4Oxtdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/qj3TiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DCEC4CEE7
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 20:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758226775;
	bh=sEs1SmKhcZ+GDVVt7rB6DOcGfiNBSmPezwtXQFXwSos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r/qj3TiJppx9/1777X2B/KI7vj9qJNy1TcFjiqUCb6RE0EzGxL01fjXQPtL4VcGh3
	 bk+Hy0ir1FiSnEcxLIk890JQ4tjrsp2CNT2v+4xqjdtxDQJsUXkh3J1Vpbduucp9Ru
	 j/oc2bYAm1L+iH17tx10hgxpbcsfTnFTfKtlH4m6Mqw2lkFzXACL7u/MYsajP+140Q
	 0PDFcErWk0YTxla48t+9sRAzUTNSA1FOJkKDlIpmG663su98AggKQ05InZ0BRu+yT1
	 ooLDhInQMD+mXbj81xaBZ5SJUypei+g6c7qEomZ0LMe2sRUZf7vu3oO0o6HWOvWQF1
	 OKqVcNdBaSJlg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-753a9c8dabeso621472a34.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 13:19:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZmKDcGPveGd1v/xGZmsrwKlaZTCulmYac/0pE99OyzjYvKPtC
	tbxsb3gW3i+siSAp78AmK9m+w8tMTDpG6YuNDtsPk1/BSskM9uIt+CyCi0koZBE+s9t4LcBarJ4
	Kgh3skCCFmJqPfWyRz9ge1YPgZZrl1k0=
X-Google-Smtp-Source: AGHT+IGvzE+sYuqO6iXoDFcYnRp6ftyzxJQiHKjhQlF8lpUcN2AarZyg2zDypOF+HgJ9wua0ZR9l3gDQ+CsgkcVnkiI=
X-Received: by 2002:a05:6808:5091:b0:43d:2218:5e1a with SMTP id
 5614622812f47-43d6c1cf595mr495885b6e.19.1758226775101; Thu, 18 Sep 2025
 13:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qimv24u.wl-tiwai@suse.de> <87ikhptpgm.wl-tiwai@suse.de>
 <CAJZ5v0htMKOcCoKts-B9BaE0VpS2oc9-cp=5VnNwS2Qe2iB+Kg@mail.gmail.com>
 <87tt10b5hq.wl-tiwai@suse.de> <CAJZ5v0hUTByfxkE=-SGSHDDd=mPw694yD7PuuJ1LLRjp-H4=uA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hUTByfxkE=-SGSHDDd=mPw694yD7PuuJ1LLRjp-H4=uA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Sep 2025 22:19:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jafoG--WrZNjt+euY0gtQSTqSDH2_cWotf92ziq5wdUw@mail.gmail.com>
X-Gm-Features: AS18NWA9gkmEeABvNt2lJgoMvhlk30TGGJvw4wXcQK1ZzayO-Y3iEaRrxIqf9PI
Message-ID: <CAJZ5v0jafoG--WrZNjt+euY0gtQSTqSDH2_cWotf92ziq5wdUw@mail.gmail.com>
Subject: Re: PM runtime auto-cleanup macros
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:28=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Sep 18, 2025 at 9:10=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrot=
e:
> >
> > On Wed, 17 Sep 2025 20:58:36 +0200,
> > Rafael J. Wysocki wrote:
> > >
> > > Hi,
> > >
> > > Sorry for the delay.
> > >
> > > On Thu, Sep 11, 2025 at 9:31=E2=80=AFAM Takashi Iwai <tiwai@suse.de> =
wrote:
> > > >
> > > > On Wed, 10 Sep 2025 16:00:17 +0200,
> > > > Takashi Iwai wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > while I worked on the code cleanups in the drivers with the recen=
t
> > > > > auto-cleanup macros, I noticed that pm_runtime_get*() and _put*()=
 can
> > > > > be also managed with the auto-cleanup gracefully, too.  Actually =
we
> > > > > already defined the __free(pm_runtime_put) in commit bfa4477751e9=
, and
> > > > > there is a (single) user of it in pci-sysfs.c.
> > > > >
> > > > > Now I wanted to extend it to pm_runtime_put_autosuspend() as:
> > > > >
> > > > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
> > > > >            if (_T) pm_runtime_put_autosuspend(_T))
> > > > >
> > > > > Then one can use it like
> > > > >
> > > > >       ret =3D pm_runtime_resume_and_get(dev);
> > > > >       if (ret < 0)
> > > > >               return ret;
> > > > >       struct device *pmdev __free(pm_runtime_put_autosuspend) =3D=
 dev;
> > > > >
> > > > > that is similar as done in pci-sysfs.c.  So far, so good.
> > > > >
> > > > > But, I find putting the line like above at each place a bit ugly.
> > > > > So I'm wondering whether it'd be better to introduce some helper
> > > > > macros, e.g.
> > > > >
> > > > > #define pm_runtime_auto_clean(dev, var) \
> > > > >       struct device *var __free(pm_runtime_put) =3D (dev)
> > > >
> > > > It can be even simpler by assigning a temporary variable such as:
> > > >
> > > > #define pm_runtime_auto_clean(dev) \
> > > >         struct device *__pm_runtime_var ## __LINE__ __free(pm_runti=
me_put) =3D (dev)
> > >
> > > Well, if there's something like
> > >
> > > struct device *pm_runtime_resume_and_get_dev(struct device *dev)
> > > {
> > >         int ret =3D pm_runtime_resume_and_get(dev);
> > >         if (ret < 0)
> > >                 return ERR_PTR(ret);
> > >
> > >         return dev;
> > > }
> > >
> > > It would be a matter of redefining the FREE to also take error
> > > pointers into account and you could do
> > >
> > > struct device *__dev __free(pm_runtim_put) =3D pm_runtime_resume_and_=
get_dev(dev);
> > > if (IS_ERR(__dev))
> > >         return PTR_ERR(__dev);
> >
> > That'll work, too.  Though, I find the notion of __free() and a
> > temporary variable __dev a bit too cumbersome; it's used only for
> > auto-clean stuff, so it could be somewhat anonymous.
>
> No, it is not used only for auto-clean, it is also used for return
> value checking and it represents a reference on the original dev.  It
> cannot be entirely anonymous because of the error checking part.
>
> The point is that this is one statement instead of two and so it is
> arguably harder to mess up with.
>
> > But it's all about a matter of taste, and I'd follow what you and
> > other guys suggest.
> >
> > FWIW, there are lots of code doing like
> >
> >         pm_runtime_get_sync(dev);
> >         mutex_lock(&foo);
> >         ....
> >         mutex_unlock(&foo);
> >         pm_runtime_put(dev);
> >         return;
> >
> > or
> >
> >         ret =3D pm_runtime_resume_and_get(dev);
> >         if (ret)
> >                 return ret;
> >         mutex_lock(&foo);
> >         ....
> >         mutex_unlock(&foo);
> >         pm_runtime_put_autosuspend(dev);
> >         return 0;
> >
> > and they can be converted nicely with guard() once when PM runtime can
> > be automatically unreferenced.  With my proposed change, it would
> > become like:
> >
> >         pm_runtime_get_sync(dev);
> >         pm_runtime_auto_clean(dev);
>
> For the case in which the pm_runtime_get_sync() return value is
> discarded, you could define a guard and do
>
> guard(pm_runtime_get_sync)(dev);
>
> here.
>
> The case checking the return value is less straightforward.
>
> >         guard(mutex)(&foo);
> >         ....
> >         return;
> >
> > or
> >
> >         ret =3D pm_runtime_resume_and_get(dev);
> >         if (ret)
> >                 return ret;
> >         pm_runtime_auto_clean_autosuspend(dev);
> >         guard(mutex)(&foo);
> >         ....
> >         return 0;
> >

I guess what I'm saying means basically something like this:

DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
         if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put(_T),
pm_runtime_resume_and_get_dev(dev), struct device *dev)

DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
         if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put_autosuspend(_T),
pm_runtime_resume_and_get_dev(dev), struct device *dev)

and analogously for pm_runtime_get_sync().

