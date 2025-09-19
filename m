Return-Path: <linux-pm+bounces-35030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF84EB89922
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681AF3A32EE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A1223DF1;
	Fri, 19 Sep 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ01YdCc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935E14A60C;
	Fri, 19 Sep 2025 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287108; cv=none; b=ScY2kMq+iSS6CJj2iEV73QWro7htWevperpu2je7pYoyXccr+xanfMf0DHNtS/CnbIOMN8vVPtjlrsLbzCCldwSWQE7ryjIt37HjjBR0l6PAfrbg8TOBMLPUuvJJtIPVOaQEgzPljDJojdEI41rJjwhAwH2Mf/X1fkkOfMWrk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287108; c=relaxed/simple;
	bh=YlVgAyYZLBI4i4As4VZ2YkhXsCbsQ7l/n3ea7NwzeSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEzjdr5e4OlFwUFrbXmER98zmKNM00CLMMhmEgFLj7lorEuU0k37r6f2GQblbdl63TZs9FosUHEAv7PyEIM9Ci18kC7+Mc+s54AKE82REZ7yZtIEnh0mW6TM9Th4ENAWMiE8dE1o/W9ktwCjNfWMCmsUB6nGqfh2r5pI8b5IsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ01YdCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C40CC4CEF0;
	Fri, 19 Sep 2025 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758287107;
	bh=YlVgAyYZLBI4i4As4VZ2YkhXsCbsQ7l/n3ea7NwzeSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQ01YdCcxvhfAJBXrwnIMYEcuvwBMfREDONqFBNPZCFSrzsgXUDTdTVFtnrdC0n0l
	 SiKr6Ybl9lMgZZ5eBCqyuDH7N5oVE4/4v/8XtwfQbF/u/iywzrHi+gtqCK9EUO4T0g
	 kq/lazNnFEaYiSyTTs8Ja/xEdzevm7qjv+0QRPqy14fD0oaoUMvhkK91e8Bm9e0b8H
	 7en+FZ7Pz9n319D5jdUMcfF9GWzPIShMulDgUvtc8m2ZUi1/6LOgnIjVNqEXw1FLKA
	 9nIqW+qoafXM8Z4wha7Z4xcycvBxViRk5B1T04OoqoAReEFTxErL7AlQ6pecW6xzKw
	 1pZPrKUFFWBLw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PM runtime auto-cleanup macros
Date: Fri, 19 Sep 2025 15:05:04 +0200
Message-ID: <12751070.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <87jz1uao65.wl-tiwai@suse.de>
References:
 <878qimv24u.wl-tiwai@suse.de>
 <CAJZ5v0hJvsuOTj5j-0Jn-c9TPnbm70wPvdBkop2hRrdweoncDg@mail.gmail.com>
 <87jz1uao65.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Friday, September 19, 2025 9:37:06 AM CEST Takashi Iwai wrote:
> On Thu, 18 Sep 2025 22:41:32 +0200,
> Rafael J. Wysocki wrote:
> >=20
> > On Thu, Sep 18, 2025 at 10:19=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 1:28=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > >
> > > > On Thu, Sep 18, 2025 at 9:10=E2=80=AFAM Takashi Iwai <tiwai@suse.de=
> wrote:
> > > > >
> > > > > On Wed, 17 Sep 2025 20:58:36 +0200,
> > > > > Rafael J. Wysocki wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Sorry for the delay.
> > > > > >
> > > > > > On Thu, Sep 11, 2025 at 9:31=E2=80=AFAM Takashi Iwai <tiwai@sus=
e.de> wrote:
> > > > > > >
> > > > > > > On Wed, 10 Sep 2025 16:00:17 +0200,
> > > > > > > Takashi Iwai wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > while I worked on the code cleanups in the drivers with the=
 recent
> > > > > > > > auto-cleanup macros, I noticed that pm_runtime_get*() and _=
put*() can
> > > > > > > > be also managed with the auto-cleanup gracefully, too.  Act=
ually we
> > > > > > > > already defined the __free(pm_runtime_put) in commit bfa447=
7751e9, and
> > > > > > > > there is a (single) user of it in pci-sysfs.c.
> > > > > > > >
> > > > > > > > Now I wanted to extend it to pm_runtime_put_autosuspend() a=
s:
> > > > > > > >
> > > > > > > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
> > > > > > > >            if (_T) pm_runtime_put_autosuspend(_T))
> > > > > > > >
> > > > > > > > Then one can use it like
> > > > > > > >
> > > > > > > >       ret =3D pm_runtime_resume_and_get(dev);
> > > > > > > >       if (ret < 0)
> > > > > > > >               return ret;
> > > > > > > >       struct device *pmdev __free(pm_runtime_put_autosuspen=
d) =3D dev;
> > > > > > > >
> > > > > > > > that is similar as done in pci-sysfs.c.  So far, so good.
> > > > > > > >
> > > > > > > > But, I find putting the line like above at each place a bit=
 ugly.
> > > > > > > > So I'm wondering whether it'd be better to introduce some h=
elper
> > > > > > > > macros, e.g.
> > > > > > > >
> > > > > > > > #define pm_runtime_auto_clean(dev, var) \
> > > > > > > >       struct device *var __free(pm_runtime_put) =3D (dev)
> > > > > > >
> > > > > > > It can be even simpler by assigning a temporary variable such=
 as:
> > > > > > >
> > > > > > > #define pm_runtime_auto_clean(dev) \
> > > > > > >         struct device *__pm_runtime_var ## __LINE__ __free(pm=
_runtime_put) =3D (dev)
> > > > > >
> > > > > > Well, if there's something like
> > > > > >
> > > > > > struct device *pm_runtime_resume_and_get_dev(struct device *dev)
> > > > > > {
> > > > > >         int ret =3D pm_runtime_resume_and_get(dev);
> > > > > >         if (ret < 0)
> > > > > >                 return ERR_PTR(ret);
> > > > > >
> > > > > >         return dev;
> > > > > > }
> > > > > >
> > > > > > It would be a matter of redefining the FREE to also take error
> > > > > > pointers into account and you could do
> > > > > >
> > > > > > struct device *__dev __free(pm_runtim_put) =3D pm_runtime_resum=
e_and_get_dev(dev);
> > > > > > if (IS_ERR(__dev))
> > > > > >         return PTR_ERR(__dev);
> > > > >
> > > > > That'll work, too.  Though, I find the notion of __free() and a
> > > > > temporary variable __dev a bit too cumbersome; it's used only for
> > > > > auto-clean stuff, so it could be somewhat anonymous.
> > > >
> > > > No, it is not used only for auto-clean, it is also used for return
> > > > value checking and it represents a reference on the original dev.  =
It
> > > > cannot be entirely anonymous because of the error checking part.
> > > >
> > > > The point is that this is one statement instead of two and so it is
> > > > arguably harder to mess up with.
> > > >
> > > > > But it's all about a matter of taste, and I'd follow what you and
> > > > > other guys suggest.
> > > > >
> > > > > FWIW, there are lots of code doing like
> > > > >
> > > > >         pm_runtime_get_sync(dev);
> > > > >         mutex_lock(&foo);
> > > > >         ....
> > > > >         mutex_unlock(&foo);
> > > > >         pm_runtime_put(dev);
> > > > >         return;
> > > > >
> > > > > or
> > > > >
> > > > >         ret =3D pm_runtime_resume_and_get(dev);
> > > > >         if (ret)
> > > > >                 return ret;
> > > > >         mutex_lock(&foo);
> > > > >         ....
> > > > >         mutex_unlock(&foo);
> > > > >         pm_runtime_put_autosuspend(dev);
> > > > >         return 0;
> > > > >
> > > > > and they can be converted nicely with guard() once when PM runtim=
e can
> > > > > be automatically unreferenced.  With my proposed change, it would
> > > > > become like:
> > > > >
> > > > >         pm_runtime_get_sync(dev);
> > > > >         pm_runtime_auto_clean(dev);
> > > >
> > > > For the case in which the pm_runtime_get_sync() return value is
> > > > discarded, you could define a guard and do
> > > >
> > > > guard(pm_runtime_get_sync)(dev);
> > > >
> > > > here.
> > > >
> > > > The case checking the return value is less straightforward.
> > > >
> > > > >         guard(mutex)(&foo);
> > > > >         ....
> > > > >         return;
> > > > >
> > > > > or
> > > > >
> > > > >         ret =3D pm_runtime_resume_and_get(dev);
> > > > >         if (ret)
> > > > >                 return ret;
> > > > >         pm_runtime_auto_clean_autosuspend(dev);
> > > > >         guard(mutex)(&foo);
> > > > >         ....
> > > > >         return 0;
> > > > >
> > >
> > > I guess what I'm saying means basically something like this:
> > >
> > > DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
> > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put(_T),
> > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > >
> > > DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
> > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put_autosuspend(_T),
> > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > >
> > > and analogously for pm_runtime_get_sync().
> >=20
> > And it kind of makes sense either.  Do
> >=20
> > CLASS(pm_runtime_resume_and_get, active_dev)(dev);
> > if (IS_ERR(active_dev))
> >         return PTR_ERR(active_dev);
> >=20
> > and now use active_dev for representing the device until it gets out
> > of the scope.
>=20
> Yes, that's what I thought of as an alternative, too, but I didn't
> consider using only pm_runtime_resume_and_get().  Actually by this
> action, we can also "clean up" the API usage at the same time to use a
> single recommended API function, which is a good thing.
>=20
> That said, I like this way :)
>=20
> It'd be nice if this change can go into 6.18, then I can put the
> driver cleanup works for 6.19.  It's a bit late stage for 6.18, but
> this change is definitely safe and can't break, per se.

OK, do you mean something like the patch below?

=2D--
 include/linux/pm_runtime.h |   43 ++++++++++++++++++++++++++++++++++++++++=
+++
 1 file changed, 43 insertions(+)

=2D-- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -533,6 +533,30 @@ static inline int pm_runtime_resume_and_
 }
=20
 /**
+ * pm_runtime_resume_and_get_dev - Resume device and bump up its usage cou=
nter.
+ * @dev: Target device.
+ *
+ * Resume @dev synchronously and if that is successful, increment its runt=
ime
+ * PM usage counter.
+ *
+ * Return:
+ * * 0 if the runtime PM usage counter of @dev has been incremented.
+ * * Negative error code otherwise.
+ */
+static inline struct device *pm_runtime_resume_and_get_dev(struct device *=
dev)
+{
+	int ret;
+
+	ret =3D __pm_runtime_resume(dev, RPM_GET_PUT);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ERR_PTR(ret);
+	}
+
+	return dev;
+}
+
+/**
  * pm_runtime_put - Drop device usage counter and queue up "idle check" if=
 0.
  * @dev: Target device.
  *
@@ -606,6 +630,25 @@ static inline int pm_runtime_put_autosus
 	return __pm_runtime_put_autosuspend(dev);
 }
=20
+/*
+ * The way to use the classes defined below is to define a class variable =
and
+ * use it going forward for representing the target device until it goes o=
ut of
+ * the scope.  For example:
+ *
+ * CLASS(pm_runtime_resume_and_get, active_dev)(dev);
+ * if (IS_ERR(active_dev))
+ *         return PTR_ERR(active_dev);
+ *
+ * ... do something with active_dev (which is guaranteed to never suspend)=
 ...
+ */
+DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
+	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put(_T),
+	     pm_runtime_resume_and_get_dev(dev), struct device *dev)
+
+DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
+	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put_autosuspend(_T),
+	     pm_runtime_resume_and_get_dev(dev), struct device *dev)
+
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if=
 0.
  * @dev: Target device.




