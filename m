Return-Path: <linux-pm+bounces-34004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB8EB4604D
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 19:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BC318921AB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 17:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858FA352FD1;
	Fri,  5 Sep 2025 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu+HYx4j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C7345743;
	Fri,  5 Sep 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093870; cv=none; b=Og/SKJm00SBYcJK44SuoeFC1cUuOIV9KCuXMyHL72lwiykDIcXQyx39tHcy3OWOD54catGIASBdAtWIY4/qj6gO6XJdmFIEqGUhSFLEzAnjq5oACpMf6U2DZ2MmhXbQWXBQF+5B5/t2qW3S5ymqOLwVNvwgUdvbh/SIkjNoPOL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093870; c=relaxed/simple;
	bh=x6IIS6wHflZ7IWG0oUKT031UepYbt38TsRpu2nZoZcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ae0RBZWIR/I/HqJsX8JQZdcdsbC55/SmFGbIUgoRrqmWS/C8/AHdHCx/7LJ+1ou3KvsbcZQywy6CeEj8A6Hp3qcX9Woh0IhJy7+fcW+WhA3sv3tmkRvcW6uV+5cSoL7PRmObpjtzpw5/uya3aw0BMWVIJAVzLeDoK03aBA3pZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pu+HYx4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4270C4CEFB;
	Fri,  5 Sep 2025 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757093869;
	bh=x6IIS6wHflZ7IWG0oUKT031UepYbt38TsRpu2nZoZcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pu+HYx4jymn4unNUiDUjbmCGcZrTp8XRWzvpssXb+IBP2zHB+XAcvUDX9xP7RqjRl
	 rF0HYtHC0Yf1uIckGQBc2Nd7NBxYgWhpVUYt37U4AENutiKquu79FcMbYQVu+QPpPQ
	 rtpYy7XsoBYUexFJxBAkhxonOjH5JPXxcFGErHMmZpByC28rMDG9BsHmKoSac9I/Eq
	 r9uXh2M4VyaBZSuUl+BNuTJzA1Vg4YnCKPVFhV3AajdyIP41BMBrvjdmcZNzRWcpSu
	 3YB63uhsJ4l5UHc8QFDRyyAUm6bUyeKSIBMBbLWlzZrrY+CHL0m9LAITEaL+yjvfz0
	 IHBuSuW+hWd0A==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61ff9c5a0c6so601144eaf.0;
        Fri, 05 Sep 2025 10:37:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqLhVvzNEmtgyymNPcVFyys1HUbHik1XRNp36j3Br9LutL0fSuPEQeJfbpEJRV8411abOsBn7G8dw=@vger.kernel.org, AJvYcCXalMWSuc3ipeQCQPpLASm/UTJL9I0FyarW+3x+3uylKFnO1CBV1B16778MlYY7FvkSCeSTukausmYx0JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnn877KjGGi5lruCnofCxlxPZnySscvQjI6W/5HS0fhuPewz75
	qHpzYFRyKlSvQZS8Ju/yf6voaJUjMTumS7lsCjQNINJ3bCAXD6MIXo+rA7/9Xivzt64CARWrO6u
	SfTzo6Znlvrf02c/CGw+viB+iCuR90AE=
X-Google-Smtp-Source: AGHT+IFxB02usVeB3J1htLOk4C0d72Yo0VpFL3Y324JwLT3q0u+OPeMZMRyvVOVtMDORpghLBv4DsafJihG60sryfxU=
X-Received: by 2002:a05:6820:1b96:b0:61e:154c:5b01 with SMTP id
 006d021491bc7-61e3374776emr15322036eaf.6.1757093869019; Fri, 05 Sep 2025
 10:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829003319.2785282-1-briannorris@chromium.org>
In-Reply-To: <20250829003319.2785282-1-briannorris@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 19:37:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com>
X-Gm-Features: Ac12FXxCo1cGKz7rVH9hIlnZysOzUz34OtnVdpQF90W5Tc8T67jQkMoHjMgve_g
Message-ID: <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: runtime: Add basic kunit tests for API contracts
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, kunit-dev@googlegroups.com, 
	Len Brown <lenb@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 2:33=E2=80=AFAM Brian Norris <briannorris@chromium.=
org> wrote:
>
> In exploring the various return codes and failure modes of runtime PM
> APIs, I found it helpful to verify and codify many of them in unit
> tests, especially given that even the kerneldoc can be rather complex to
> reason through, and it also has had subtle errors of its own.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

This is nice in general, but I have a couple of questions/comments (see bel=
ow).

> ---
>
>  drivers/base/Kconfig              |   6 +
>  drivers/base/power/Makefile       |   1 +
>  drivers/base/power/runtime-test.c | 259 ++++++++++++++++++++++++++++++
>  3 files changed, 266 insertions(+)
>  create mode 100644 drivers/base/power/runtime-test.c
>
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 064eb52ff7e2..1786d87b29e2 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -167,6 +167,12 @@ config PM_QOS_KUNIT_TEST
>         depends on KUNIT=3Dy
>         default KUNIT_ALL_TESTS
>
> +config PM_RUNTIME_KUNIT_TEST
> +       tristate "KUnit Tests for runtime PM" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       depends on PM
> +       default KUNIT_ALL_TESTS
> +
>  config HMEM_REPORTING
>         bool
>         default n
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 01f11629d241..2989e42d0161 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_PM_SLEEP)  +=3D main.o wakeup.o wakeup_stats=
.o
>  obj-$(CONFIG_PM_TRACE_RTC)     +=3D trace.o
>  obj-$(CONFIG_HAVE_CLK) +=3D clock_ops.o
>  obj-$(CONFIG_PM_QOS_KUNIT_TEST) +=3D qos-test.o
> +obj-$(CONFIG_PM_RUNTIME_KUNIT_TEST) +=3D runtime-test.o
>
>  ccflags-$(CONFIG_DEBUG_DRIVER) :=3D -DDEBUG
> diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runti=
me-test.c
> new file mode 100644
> index 000000000000..263c28d5fc50
> --- /dev/null
> +++ b/drivers/base/power/runtime-test.c
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 Google, Inc.
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/pm_runtime.h>
> +#include <kunit/device.h>
> +#include <kunit/test.h>
> +
> +#define DEVICE_NAME "pm_runtime_test_device"
> +
> +static void pm_runtime_depth_test(struct kunit *test)
> +{
> +       struct device *dev =3D kunit_device_register(test, DEVICE_NAME);
> +
> +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> +
> +       pm_runtime_enable(dev);
> +
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_get_sync(dev)); /* "already a=
ctive" */
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +}
> +
> +/* Test pm_runtime_put() and friends when already suspended. */
> +static void pm_runtime_already_suspended_test(struct kunit *test)
> +{
> +       struct device *dev =3D kunit_device_register(test, DEVICE_NAME);
> +
> +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> +
> +       pm_runtime_enable(dev);
> +
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +       pm_runtime_get_noresume(dev);
> +
> +       /* Flush, in case the above (non-sync) triggered any work. */
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup n=
eeded */

Why do you run pm_runtime_barrier(dev) here?  It is guaranteed that no
requests are pending at this point.

> +
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));

This has already been tested above.

> +       /*
> +        * We never actually left RPM_SUSPENDED, but rpm_idle() still tre=
ats
> +        * this as -EAGAIN / "runtime PM status change ongoing".

No, this means "Conditions are not suitable, but may change".

> +        */
> +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put(dev));
> +
> +       pm_runtime_get_noresume(dev);
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));

This has been tested already twice and why would it change?

> +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
> +
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
> +       KUNIT_EXPECT_EQ(test, 1, pm_request_autosuspend(dev));
> +
> +       pm_runtime_get_noresume(dev);
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));

There's no way by which it could change above.

> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync_autosuspend(dev));
> +
> +       pm_runtime_get_noresume(dev);
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_autosuspend(dev));
> +
> +       /* Grab 2 refcounts */
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_get_noresume(dev);
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +       /* The first put() sees usage_count 1 */
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_autosuspend(dev));
> +       /* The second put() sees usage_count 0 but tells us "already susp=
ended". */
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_autosuspend(dev));
> +
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));

Again, there is no way this can change in the whole test.

> +}
> +
> +static void pm_runtime_idle_test(struct kunit *test)
> +{
> +       struct device *dev =3D kunit_device_register(test, DEVICE_NAME);
> +
> +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> +
> +       pm_runtime_enable(dev);
> +
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> +       pm_runtime_put_noidle(dev);
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_idle(dev));
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
> +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_idle(dev));
> +}
> +
> +static void pm_runtime_disabled_test(struct kunit *test)
> +{
> +       struct device *dev =3D kunit_device_register(test, DEVICE_NAME);
> +
> +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> +
> +       /* Never called pm_runtime_enable() */
> +       KUNIT_EXPECT_FALSE(test, pm_runtime_enabled(dev));
> +
> +       /* "disabled" is treated as "active" */
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> +       KUNIT_EXPECT_FALSE(test, pm_runtime_suspended(dev));
> +
> +       /*
> +        * Note: these "fail", but they still acquire/release refcounts, =
so
> +        * keep them balanced.
> +        */
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put(dev));
> +
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get_sync(dev));
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_sync(dev));
> +
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_autosuspend(dev));
> +
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume_and_get(dev));
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_idle(dev));
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_idle(dev));
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_resume(dev));
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_autosuspend(dev));
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_suspend(dev));
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume(dev));
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_autosuspend(dev));
> +
> +       /* Still active */

Still disabled rather.

> +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> +}
> +
> +static void pm_runtime_error_test(struct kunit *test)
> +{
> +       struct device *dev =3D kunit_device_register(test, DEVICE_NAME);
> +
> +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> +
> +       pm_runtime_enable(dev);
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +
> +       /* Fake a .runtime_resume() error */
> +       dev->power.runtime_error =3D -EIO;
> +
> +       /*
> +        * Note: these "fail", but they still acquire/release refcounts, =
so
> +        * keep them balanced.
> +        */
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put(dev));
> +
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get_sync(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_sync(dev));
> +
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_autosuspend(dev));
> +
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume_and_get(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_idle(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_idle(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_resume(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_autosuspend(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_suspend(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_autosuspend(dev));
> +
> +       /* Still suspended */

Error is still pending.

> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +       /* Clear error */
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_set_suspended(dev));
> +       KUNIT_EXPECT_EQ(test, 0, dev->power.runtime_error);
> +       /* Still suspended */
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get(dev));
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_barrier(dev)); /* resume was =
pending */
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put(dev));
> +       pm_runtime_suspend(dev); /* flush the put(), to suspend */
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> +
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_autosuspend(dev));
> +
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_resume_and_get(dev));
> +
> +       /*
> +        * The following should all "fail" with -EAGAIN (usage is non-zer=
o) or
> +        * 1 (already resumed).

The return value of 1 doesn't count as a failure.

> +        */
> +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
> +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_idle(dev));
> +       KUNIT_EXPECT_EQ(test, 1, pm_request_resume(dev));
> +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_autosuspend(dev));
> +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_suspend(dev));
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_resume(dev));
> +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_autosuspend(dev));
> +
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> +
> +       /* Suspended again */
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +}
> +
> +/*
> + * Explore a typical probe() sequence in which a device marks itself pow=
ered,
> + * but doesn't hold any runtime PM reference, so it suspends as soon as =
it goes
> + * idle.
> + */
> +static void pm_runtime_probe_active_test(struct kunit *test)
> +{
> +       struct device *dev =3D kunit_device_register(test, DEVICE_NAME);
> +
> +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> +
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_status_suspended(dev));
> +
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_set_active(dev));
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> +
> +       pm_runtime_enable(dev);
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> +
> +       /* Flush, and ensure we stayed active. */

There's nothing to flush though.

> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev));
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> +
> +       /* Ask for idle? Now we suspend. */
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_idle(dev));
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +}
> +
> +static struct kunit_case pm_runtime_test_cases[] =3D {
> +       KUNIT_CASE(pm_runtime_depth_test),
> +       KUNIT_CASE(pm_runtime_already_suspended_test),
> +       KUNIT_CASE(pm_runtime_idle_test),
> +       KUNIT_CASE(pm_runtime_disabled_test),
> +       KUNIT_CASE(pm_runtime_error_test),
> +       KUNIT_CASE(pm_runtime_probe_active_test),
> +       {}
> +};
> +
> +static struct kunit_suite pm_runtime_test_suite =3D {
> +       .name =3D "pm_runtime_test_cases",
> +       .test_cases =3D pm_runtime_test_cases,
> +};
> +
> +kunit_test_suite(pm_runtime_test_suite);
> +MODULE_DESCRIPTION("Runtime power management unit test suite");
> +MODULE_LICENSE("GPL");
> --

