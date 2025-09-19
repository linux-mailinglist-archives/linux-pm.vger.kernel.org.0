Return-Path: <linux-pm+bounces-35070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA28BB8AAAC
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 18:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B6517318E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F2131CA4E;
	Fri, 19 Sep 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/TXNmQs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009A1E1A05
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301143; cv=none; b=g2J70v6z7P73xf//aC4xi0rUE9fdCQTemKMkQmUWxPx+YAguusv11jS3SEto+DLIozUWPLnDCsLbx46b2SDvSAA9PF3x+CLhMScND1HDT29BjSuFk962gpneEZch4eV+6rdTJSehpCIC1Iih5JtMttQlruJncF/Fj5qe3BQyO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301143; c=relaxed/simple;
	bh=q4Fp3CwUIPHFmgTHIUppL23eh3nlnofaufwG77k+LlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knwUwFx30HOjtQ+dObjykzZ8nVHVsBeflCNzSPjm+Ca0ompGiDBAyZ27LZy5H/wS+ombFF0w4/tvv4sb15FtsiURO8KkuKPb1kkGcCJt42LxLkwUCsTRjAGezoOfM1SOw+jHMGaao9tEvGKv8TpgT5U9Hjq3NiSgbWW9MC5p4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/TXNmQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40046C4CEF9
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758301143;
	bh=q4Fp3CwUIPHFmgTHIUppL23eh3nlnofaufwG77k+LlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u/TXNmQsVwT9GdWiTLlodqvwxgeIBeNISKxnMa3sKLkPqgnZGkstP5f1rTyV/Jn1C
	 mru4paNJm4Q9ISfJvaWvu9kNz4hbX2MrUAz5WJ/oWQGB8AdI+n4VNGoi2K2NhwIC6A
	 HN9Fho1r3apqjJ1eNPBgrO4MSArvvKwqU5MJu98f4A9zC8JDPardasTD0iMbkC10ag
	 l8ISnt7b6wpoiSr1tjoCW4J90DkttjwvQqzn2K5GcyTs6mOjdp8JwFYBBcp6AJCMTs
	 wN0Hi58LRPiL1sXaubrHBOAStHtND0iBp8WgTnnH1vanMGYF747ZeaSlAAmp+uzsds
	 51VmDQTgYmT3A==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-621c69d767aso892007eaf.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 09:59:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEzoNdzhjWi1PcABus94H6kEAaQw9Bh8dvU/7+jPSOri8LRDKFj8UYAbTHzjsU93JmUxz5vCfZzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ne8LQvelYDIez8CYkvZ28ePyzs/07BgmkFBCz1T+9S2BX9wR
	4rDdmFGgWnW3EC7W45OQqQi2Oxr8M8tM2nZ+uYg5HG1KB0BBK1NEXrEh33gNTHAib8H5Qi9xt2S
	8wSRY0ZeIy21TnHiTzJGsdEmpJVn8jzk=
X-Google-Smtp-Source: AGHT+IEN5uNA6xwmKPM+zTn2tvbvIWNMHkGGjepwuB8he2VIqxjyrUozAaybsK7toSY+XDye/pfu3GWMMxYcZqpOKrE=
X-Received: by 2002:a05:6820:50a:b0:621:71a0:5b67 with SMTP id
 006d021491bc7-6272abec283mr1750335eaf.7.1758301142426; Fri, 19 Sep 2025
 09:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com> <aMHjOJGaKi9cwbsn@google.com>
In-Reply-To: <aMHjOJGaKi9cwbsn@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 18:58:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iELLPYBS6FKmX=DhoyQ2tDq9F9DAzuV0A8etv0dGeJvQ@mail.gmail.com>
X-Gm-Features: AS18NWA8_TAHfGLVKv_dX2GxSJIZKvVsremuwn0SmzDiFIvj_CkIUa4PRWpq0KY
Message-ID: <CAJZ5v0iELLPYBS6FKmX=DhoyQ2tDq9F9DAzuV0A8etv0dGeJvQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: runtime: Add basic kunit tests for API contracts
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, kunit-dev@googlegroups.com, 
	Len Brown <lenb@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Wed, Sep 10, 2025 at 10:44=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
>
> Hi Rafael,
>
> On Fri, Sep 05, 2025 at 07:37:38PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 29, 2025 at 2:33=E2=80=AFAM Brian Norris <briannorris@chrom=
ium.org> wrote:
> > >
> > > In exploring the various return codes and failure modes of runtime PM
> > > APIs, I found it helpful to verify and codify many of them in unit
> > > tests, especially given that even the kerneldoc can be rather complex=
 to
> > > reason through, and it also has had subtle errors of its own.
> > >
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> >
> > This is nice in general, but I have a couple of questions/comments (see=
 below).
>
> Thanks for looking. There's certainly some matter of opinion on how
> exactly to test things, and I'm still getting up to speed on some of the
> runtime PM API details, so I appreciate the care you've given.
>
> Replies inline.
>
> > > ---
> > >
> > >  drivers/base/Kconfig              |   6 +
> > >  drivers/base/power/Makefile       |   1 +
> > >  drivers/base/power/runtime-test.c | 259 ++++++++++++++++++++++++++++=
++
> > >  3 files changed, 266 insertions(+)
> > >  create mode 100644 drivers/base/power/runtime-test.c
> > >
> > > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > > index 064eb52ff7e2..1786d87b29e2 100644
> > > --- a/drivers/base/Kconfig
> > > +++ b/drivers/base/Kconfig
> > > @@ -167,6 +167,12 @@ config PM_QOS_KUNIT_TEST
> > >         depends on KUNIT=3Dy
> > >         default KUNIT_ALL_TESTS
> > >
> > > +config PM_RUNTIME_KUNIT_TEST
> > > +       tristate "KUnit Tests for runtime PM" if !KUNIT_ALL_TESTS
> > > +       depends on KUNIT
> > > +       depends on PM
> > > +       default KUNIT_ALL_TESTS
> > > +
> > >  config HMEM_REPORTING
> > >         bool
> > >         default n
> > > diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefil=
e
> > > index 01f11629d241..2989e42d0161 100644
> > > --- a/drivers/base/power/Makefile
> > > +++ b/drivers/base/power/Makefile
> > > @@ -4,5 +4,6 @@ obj-$(CONFIG_PM_SLEEP)  +=3D main.o wakeup.o wakeup_s=
tats.o
> > >  obj-$(CONFIG_PM_TRACE_RTC)     +=3D trace.o
> > >  obj-$(CONFIG_HAVE_CLK) +=3D clock_ops.o
> > >  obj-$(CONFIG_PM_QOS_KUNIT_TEST) +=3D qos-test.o
> > > +obj-$(CONFIG_PM_RUNTIME_KUNIT_TEST) +=3D runtime-test.o
> > >
> > >  ccflags-$(CONFIG_DEBUG_DRIVER) :=3D -DDEBUG
> > > diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/r=
untime-test.c
> > > new file mode 100644
> > > index 000000000000..263c28d5fc50
> > > --- /dev/null
> > > +++ b/drivers/base/power/runtime-test.c
> > > @@ -0,0 +1,259 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright 2025 Google, Inc.
> > > + */
> > > +
> > > +#include <linux/cleanup.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <kunit/device.h>
> > > +#include <kunit/test.h>
> > > +
> > > +#define DEVICE_NAME "pm_runtime_test_device"
> > > +
> > > +static void pm_runtime_depth_test(struct kunit *test)
> > > +{
> > > +       struct device *dev =3D kunit_device_register(test, DEVICE_NAM=
E);
> > > +
> > > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > > +
> > > +       pm_runtime_enable(dev);
> > > +
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_get_sync(dev)); /* "alrea=
dy active" */
> > > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> > > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > > +}
> > > +
> > > +/* Test pm_runtime_put() and friends when already suspended. */
> > > +static void pm_runtime_already_suspended_test(struct kunit *test)
> > > +{
> > > +       struct device *dev =3D kunit_device_register(test, DEVICE_NAM=
E);
> > > +
> > > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > > +
> > > +       pm_runtime_enable(dev);
> > > +
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > > +       pm_runtime_get_noresume(dev);
> > > +
> > > +       /* Flush, in case the above (non-sync) triggered any work. */
> > > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wake=
up needed */
> >
> > Why do you run pm_runtime_barrier(dev) here?  It is guaranteed that no
> > requests are pending at this point.
>
> I suppose my thought is as somewhat of an outsider, that's not really
> familiar with exactly how each API is supposed to work. So without
> looking into the details of the implementation, it's not clear to me
> that a "get_noresume()" will never queue any work. Admittedly, that's a
> pretty weak reason.
>
> OTOH, it does serve to test the 0 side of the API contract:
>
> """
>  * 1, if there was a resume request pending and the device had to be woke=
n up,
>  * 0, otherwise
> """
>
> So IMO, it's a reasonable thing to run in this test, although I probably
> should drop the "Flush" comment.

Yeah, changing the comment would help.

> > > +
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> >
> > This has already been tested above.
>
> I'm not really an expert on unit testing and style, but the whole point
> of this test (named "already_suspended") is that we're testing each
> operation when the device is suspended. So it's many series of:
>
> 1. set up some precondition
> 2. assert that the device is (still) suspended
> 3. test that an API returns the expected value for "already suspended"
>
> Even if #1/#3 aren't likely to affect #2 for a later sequence, it seems
> like a good pattern to actually test that this continues to remain true
> each time. If the test changes in the future such that we perform
> something different in #1, we might find ourselves not testing "already
> suspended" behavior in #3.
>
> Alternatively, I could split each #1/#2/#3 sequence into its own
> subtest, but that might get a little excessive.
>
> Anyway, like I said, it's probably some matter of opinion/style. I can
> drop some of these checks if you still think they have no place here.

I would do just two of them, one at the beginning and one at the end.
It should be an invariant for everything in between.

> > > +       /*
> > > +        * We never actually left RPM_SUSPENDED, but rpm_idle() still=
 treats
> > > +        * this as -EAGAIN / "runtime PM status change ongoing".
> >
> > No, this means "Conditions are not suitable, but may change".
>
> I'm just quoting the API docs for put():
>
> """
> * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change =
ongoing.
> """
>
> If that's the wrong language, then we should update the API doc. At any
> rate, I'm not sure what's "unsuitable" about a suspended device when we
> call put(). It's not unsuitable -- it's already in the target state!
>
> Notably, I'm also changing this behavior in patch 2, since I think it's
> an API bug. And the comment then goes away.

Yeah, so I'd prefer to change this particular thing entirely,
especially in the face of

https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/

which quite obviously doesn't take the return value of
pm_runtime_put() and pm_runtime_put_sutosuspend() into account.

I would like these two functions to be void.

Of course, there are existing users that check their return values,
but I'm not sure how much of a real advantage from doing that is.  At
least some of those users appear to not exactly know what they are
doing.

> > > +        */
> > > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put(dev));
> > > +
> > > +       pm_runtime_get_noresume(dev);
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> >
> > This has been tested already twice and why would it change?
>
> Addressed above. I can drop it if you think it's excessive.
>
> > > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
> > > +
> > > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
> > > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
> > > +       KUNIT_EXPECT_EQ(test, 1, pm_request_autosuspend(dev));
> > > +
> > > +       pm_runtime_get_noresume(dev);
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> >
> > There's no way by which it could change above.
>
> Same.
>
> > > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync_autosuspend(dev)=
);
> > > +
> > > +       pm_runtime_get_noresume(dev);
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_autosuspend(dev));
> > > +
> > > +       /* Grab 2 refcounts */
> > > +       pm_runtime_get_noresume(dev);
> > > +       pm_runtime_get_noresume(dev);
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > > +       /* The first put() sees usage_count 1 */
> > > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_autosuspend(dev));
> > > +       /* The second put() sees usage_count 0 but tells us "already =
suspended". */
> > > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_autosuspend(dev));
> > > +
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> >
> > Again, there is no way this can change in the whole test.
>
> Same.
>
> > > +}
> > > +
> > > +static void pm_runtime_idle_test(struct kunit *test)
> > > +{
> > > +       struct device *dev =3D kunit_device_register(test, DEVICE_NAM=
E);
> > > +
> > > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > > +
> > > +       pm_runtime_enable(dev);
> > > +
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > > +       pm_runtime_put_noidle(dev);
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_idle(dev));
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_idle(dev));
> > > +}
> > > +
> > > +static void pm_runtime_disabled_test(struct kunit *test)
> > > +{
> > > +       struct device *dev =3D kunit_device_register(test, DEVICE_NAM=
E);
> > > +
> > > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > > +
> > > +       /* Never called pm_runtime_enable() */
> > > +       KUNIT_EXPECT_FALSE(test, pm_runtime_enabled(dev));
> > > +
> > > +       /* "disabled" is treated as "active" */
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > > +       KUNIT_EXPECT_FALSE(test, pm_runtime_suspended(dev));
> > > +
> > > +       /*
> > > +        * Note: these "fail", but they still acquire/release refcoun=
ts, so
> > > +        * keep them balanced.
> > > +        */
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put(dev));
> > > +
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get_sync(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_sync(dev));
> > > +
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_autosuspend(dev=
));
> > > +
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume_and_get(dev)=
);
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_idle(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_idle(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_resume(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_autosuspend(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_suspend(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_autosuspend(dev));
> > > +
> > > +       /* Still active */
> >
> > Still disabled rather.
>
> Ack, will change.
>
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > > +}
> > > +
> > > +static void pm_runtime_error_test(struct kunit *test)
> > > +{
> > > +       struct device *dev =3D kunit_device_register(test, DEVICE_NAM=
E);
> > > +
> > > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > > +
> > > +       pm_runtime_enable(dev);
> > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > > +
> > > +       /* Fake a .runtime_resume() error */
> > > +       dev->power.runtime_error =3D -EIO;
> > > +
> > > +       /*
> > > +        * Note: these "fail", but they still acquire/release refcoun=
ts, so
> > > +        * keep them balanced.
> > > +        */
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put(dev));
> > > +
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get_sync(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_sync(dev));
> > > +
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_autosuspend(dev=
));
> > > +
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume_and_get(dev)=
);
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_idle(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_idle(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_resume(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_autosuspend(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_suspend(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume(dev));
> > > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_autosuspend(dev));
> > > +
> > > +       /* Still suspended */
> >
> > Error is still pending.
>
> Your statement is true, but I'm not quite sure what you're suggesting.
> Are you suggesting I should
>
>         KUNIT_EXPECT_EQ(test, -EIO, dev->power.runtime_error);
>
> ?
>
> Or are you suggesting I change the comment?

Change the comment.

> I'm thinking I'll do both.

That will work too.

