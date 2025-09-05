Return-Path: <linux-pm+bounces-34005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4820CB46070
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 19:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E1F1B253E0
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A123568EA;
	Fri,  5 Sep 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6XFLTof"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5053568E0;
	Fri,  5 Sep 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094135; cv=none; b=uH9NbzUfbHhCuyFDTQT3Qf/lAIc58WnNIYjt3JfJKj2nBpwSIfu/4XgEAHReI39fxjSByJHg2PXLdSZEVuXQ981cEKL71m0N020cVpidvkqFcNfiH5PVC/R6goIF2Wzu8KCfOF+VHYjKSs8o6Tfv56Kc7Ynpoucl+nkKYdsq9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094135; c=relaxed/simple;
	bh=3GTZ3VwuRNk7+OBE+ppVxtDl8nDx4mcaNqQdqe/JOBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WW00RI6JYpWgfEY53tmbo4UliCNdRpynH7/Udmm0qCrFxsl99+7bkeZEB2aVzo9ifISBEDM4gFwWHU4ysegVkumLXnh8UAsLHC98ZJaWPYVVzoueYGz7OBfvSTKl9FqlNYd0Zn3D8W7Z6gO5La8KQ/YTjV47juVYAhsR4dRcX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6XFLTof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC663C4CEFB;
	Fri,  5 Sep 2025 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757094134;
	bh=3GTZ3VwuRNk7+OBE+ppVxtDl8nDx4mcaNqQdqe/JOBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K6XFLTofw5q8LfsGaBz4b0oNrc59Y6/DUouxKnflIJLYjq5tvw9YMpYP6YpETaStT
	 dXTwGGR18LzjNptQoXWCK6Anf0V2LIbb/WAkd2ApkXZyXLm/FzeyP9DRqYCdJAT/Ya
	 UigqFT+X8ngJWrpBZXqMBL3l6OXKFv+bGDQpIlsjFWtOlaCYFFwExT7qGX7oenitdK
	 2v1K0rJXVy9IL5dtiaJnh0cJij6aYFFhesLfE3OhvpvotTWJDF6QsjfvOMcdpiW0Ld
	 VPEnYaYLRntk/cGF+u03nGgNNDLCGIVsR1wIoZ9Urgs5ei+T40cs042wrPWs2emb04
	 P7uZ4s82PUw2Q==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-746d7c469a8so1182650a34.3;
        Fri, 05 Sep 2025 10:42:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6q3dFmax0lSswNIoeYpod+Gq7CiCLoOfuQJqeCpzeWn3zeNBVKd2MKRJ5wvaX1nILLYKEzdSuUW0ECnw=@vger.kernel.org, AJvYcCWTWwnApR84jo9O8WEJn7ZN+DZZPFe3PBlWG6Xg1SloCcQ8gSCuva7bNccyv75kxw1DcK/xlStnc44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4ayoVTN3Y0NlrAthGNndAtGRQgHw7a8JRzZRMzaQeB8lcMcj
	1EmQLmT9zfN4O0zVje4Tz6jZeSSgELuv/hOzvKIM1w10RWiXozXTd/gSG6mjArEeHLw2gs/p9Sv
	IGO+Sat59DgQgSTdMh7R+Z6vgDb/8Vv8=
X-Google-Smtp-Source: AGHT+IHb0VMd6zkI16YdwWOoqRQ4O7RJoD1+EbBplr2djA3mmOe+dEpFu+Ml9fb8O9gpJD1XPAr6+frTdhLT8W1/rXs=
X-Received: by 2002:a05:6830:60cf:10b0:745:9272:4a34 with SMTP id
 46e09a7af769-74592724ff0mr5665635a34.16.1757094134168; Fri, 05 Sep 2025
 10:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <20250829003319.2785282-2-briannorris@chromium.org> <aLab51BTgvnULBUd@kekkonen.localdomain>
In-Reply-To: <aLab51BTgvnULBUd@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 19:42:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ia=tXJ7Fo7Jkh_keyzDYe+w20Qcqg7z3WKm8jJzymEUw@mail.gmail.com>
X-Gm-Features: Ac12FXzDnlYh2um-wK5lLYAbtG3ziOVuk-FuywaNXIhw5zuNw2BzFja3Y62bLfA
Message-ID: <CAJZ5v0ia=tXJ7Fo7Jkh_keyzDYe+w20Qcqg7z3WKm8jJzymEUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM: runtime: Make put{,_sync}() return 1 when already suspended
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Brian Norris <briannorris@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	kunit-dev@googlegroups.com, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:25=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Brian,
>
> On Thu, Aug 28, 2025 at 05:28:27PM -0700, Brian Norris wrote:
> > The pm_runtime.h docs say pm_runtime_put() and pm_runtime_put_sync()
> > return 1 when already suspended, but this is not true -- they return
> > -EAGAIN. On the other hand, pm_runtime_put_sync_suspend() and
> > pm_runtime_put_sync_autosuspend() *do* return 1.
> >
> > This is an artifact of the fact that the former are built on rpm_idle()=
,
> > whereas the latter are built on rpm_suspend().
> >
> > There are precious few pm_runtime_put()/pm_runtime_put_sync() callers
> > that check the return code at all, but most of them only log errors, an=
d
> > usually only for negative error codes. None of them should be treating
> > this as an error, so:
> >
> >  * at best, this may fix some case where a driver treats this condition
> >    as an error, when it shouldn't;
> >
> >  * at worst, this should make no effect; and
> >
> >  * somewhere in between, we could potentially clear up non-fatal log
> >    messages.
> >
> > Fix the pm_runtime_already_suspended_test() while tweaking the behavior=
.
> > The test makes a lot more sense when these all return 1 when the device
> > is already suspended:
> >
> >     pm_runtime_put(dev);
> >     pm_runtime_put_sync(dev);
> >     pm_runtime_suspend(dev);
> >     pm_runtime_autosuspend(dev);
> >     pm_request_autosuspend(dev);
> >     pm_runtime_put_sync_autosuspend(dev);
> >     pm_runtime_put_autosuspend(dev);
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> >  drivers/base/power/runtime-test.c | 8 ++------
> >  drivers/base/power/runtime.c      | 3 +++
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/run=
time-test.c
> > index 263c28d5fc50..1be18e871f1d 100644
> > --- a/drivers/base/power/runtime-test.c
> > +++ b/drivers/base/power/runtime-test.c
> > @@ -43,15 +43,11 @@ static void pm_runtime_already_suspended_test(struc=
t kunit *test)
> >       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup n=
eeded */
> >
> >       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > -     /*
> > -      * We never actually left RPM_SUSPENDED, but rpm_idle() still tre=
ats
> > -      * this as -EAGAIN / "runtime PM status change ongoing".
> > -      */
> > -     KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put(dev));
> > +     KUNIT_EXPECT_EQ(test, 1, pm_runtime_put(dev));
> >
> >       pm_runtime_get_noresume(dev);
> >       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > -     KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
> > +     KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync(dev));
> >
> >       KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
> >       KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.=
c
> > index 3e84dc4122de..17cf111d16aa 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -498,6 +498,9 @@ static int rpm_idle(struct device *dev, int rpmflag=
s)
> >       if (retval < 0)
> >               ;       /* Conditions are wrong. */
> >
> > +     else if ((rpmflags & RPM_GET_PUT) && (retval =3D=3D 1))
> > +             ;       /* put() is allowed in RPM_SUSPENDED */
>
> Ah, I missed this while reviewing the 3rd patch. Makes sense. Please igno=
re
> my comments regarding the 3rd patch on whether the return value 1 is
> applicable.
>
> The latter parentheses are redundant (the former, too, actually, but the
> compiler warns so let them be).

Right.

But overall this should work.

> > +
> >       /* Idle notifications are allowed only in the RPM_ACTIVE state. *=
/
> >       else if (dev->power.runtime_status !=3D RPM_ACTIVE)
> >               retval =3D -EAGAIN;
>
> --

