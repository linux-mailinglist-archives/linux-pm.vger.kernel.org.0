Return-Path: <linux-pm+bounces-35503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75537BA5E71
	for <lists+linux-pm@lfdr.de>; Sat, 27 Sep 2025 13:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A73C7A49B3
	for <lists+linux-pm@lfdr.de>; Sat, 27 Sep 2025 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6427284695;
	Sat, 27 Sep 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaoOK8GX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145924466D
	for <linux-pm@vger.kernel.org>; Sat, 27 Sep 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758973460; cv=none; b=HshCQ0nbskaQXgvXd00KeFWwXd3LPzBZy3r4OyfmgVgUmj/4rjudtPEVzJ3lX62LbNegry0LANPjLUZSv5XyFL9zTnPFGZKA49HoEk327TsKepNbjsBO8F356+ccQexHjVldbCu+cRK9fKa+r2IEUofg2Yq6GIJW3xgbrjPkxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758973460; c=relaxed/simple;
	bh=fHAz41ddWusVzitI8c+oKzTa87YCzyF6UwEZItK04Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxDFFAKWqv3kXRWAD+F/GdKDHkb2Wm6g7TJE/cNNaon2R7a02dHLHyfwkloaPrYD6NBqOpDQ32UaRiaAu2IiMGfk44JMy/Vd3Q71xOZQwBgfOZ98dyPQyavJR53otMoQ9jH0jvXbsq18vQhAgxPFk52X0zy+U9JLA/7b/DOw5K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaoOK8GX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64437C4CEE7
	for <linux-pm@vger.kernel.org>; Sat, 27 Sep 2025 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758973460;
	bh=fHAz41ddWusVzitI8c+oKzTa87YCzyF6UwEZItK04Ms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oaoOK8GXPpvR+12BdRKjzaqrdR1WQqQdnJsN1cCjjsXVb+hdtdqoqWi5IjYLvurJ+
	 4/TjJ8bwHdqCm1bLXvQ8+rOZkKL1QH6WNgucW4ru80yUuOAQQbGxwNcld5As6AJH5D
	 8A+3+kHHmRPHDg7YM8D656mO9MfJcrhxZej2+MdxutUkb3FagF1LHF7qAZ+j87Y5Jt
	 mNjRRVIHF94EvcODY3+K9USyGK3T3YyPOyOYNNOQ3+aQieZF7gO3XMdNrcbUkt3Xuj
	 zdo/fAqPVc18Kr7uYMDPO9cOGTFM2v6H1oPEJ20J8/1dMGEtAEu4osxIysRXs1yeJ/
	 mY9IvnWmfqmcA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cceb3be82so3023377fac.2
        for <linux-pm@vger.kernel.org>; Sat, 27 Sep 2025 04:44:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPnRXBDMwdPYLHmylF0lqaLNDPMuxugHbXq0/NgjNrd8Df5JWMd0bCfg5ZeQdlFwjPl1PbEug9fA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdp0+SZt019iU0J32BbAxgF7mb6mWSnaXWO0eHE73Xhp45iGLk
	BIfOp9hGWDgZCNSaYp4JM3tJ3lXecUi4nH8U38bDVkcRuOT/uWovQ6TdhJcMnFjILOAxRDgcY3Q
	RZOPJ02gRgBNR/2wNhJiONg6pmNcMSM4=
X-Google-Smtp-Source: AGHT+IHH1kU0k25pOhUcxY85WUYqxggSBVsmmFoNG800Zmah0L69UbqFOrIAy0/PrR92c8bxjmow1o8T4gPayN7eGmo=
X-Received: by 2002:a05:6808:80a7:b0:438:430b:3dd9 with SMTP id
 5614622812f47-43f4cc75e34mr6332907b6e.11.1758973459612; Sat, 27 Sep 2025
 04:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925124216.v2.1.I443d97ccd1c67f32670eb93784ad735b11816743@changeid>
In-Reply-To: <20250925124216.v2.1.I443d97ccd1c67f32670eb93784ad735b11816743@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 27 Sep 2025 13:44:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gK9vRZtL4e9BJx+eR8nj7-FpRj3of8iQOLMNEwoz9oTQ@mail.gmail.com>
X-Gm-Features: AS18NWBY48-YExpFUjsCrHPji9GbPVu9rrsuxMft8M55meThkl8tVE3nwcw5O5Q
Message-ID: <CAJZ5v0gK9vRZtL4e9BJx+eR8nj7-FpRj3of8iQOLMNEwoz9oTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: runtime: Add basic kunit tests for API contracts
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	kunit-dev@googlegroups.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 9:43=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> In exploring the various return codes and failure modes of runtime PM
> APIs, I found it helpful to verify and codify many of them in unit
> tests, especially given that even the kerneldoc can be rather complex to
> reason through, and it also has had subtle errors of its own.
>
> Notably, I avoid testing the return codes for pm_runtime_put() and
> pm_runtime_put_autosuspend(), since code that checks them is probably
> wrong, and we're considering making them return 'void' altogether. I
> still test the sync() variants, since those have a bit more meaning to
> them.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v2:
>  * Improve comments, per review suggestions
>  * Minor sequence changes, per review suggestions
>  * Stop testing for pm_runtime_put() and pm_runtime_put_autosuspend()
>    return codes
>
>  drivers/base/Kconfig              |   6 +
>  drivers/base/power/Makefile       |   1 +
>  drivers/base/power/runtime-test.c | 253 ++++++++++++++++++++++++++++++
>  3 files changed, 260 insertions(+)
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
> index 000000000000..2e966fd96664
> --- /dev/null
> +++ b/drivers/base/power/runtime-test.c
> @@ -0,0 +1,253 @@
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
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +
> +       pm_runtime_get_noresume(dev);
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup n=
eeded */
> +       pm_runtime_put(dev);
> +
> +       pm_runtime_get_noresume(dev);
> +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
> +
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
> +       KUNIT_EXPECT_EQ(test, 1, pm_request_autosuspend(dev));
> +
> +       pm_runtime_get_noresume(dev);
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync_autosuspend(dev));
> +
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_put_autosuspend(dev);
> +
> +       /* Grab 2 refcounts */
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_get_noresume(dev);
> +       /* The first put() sees usage_count 1 */
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync_autosuspend(dev));
> +       /* The second put() sees usage_count 0 but tells us "already susp=
ended". */
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync_autosuspend(dev));
> +
> +       /* Should have remained suspended the whole time. */
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
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
> +       pm_runtime_put(dev);
> +
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get_sync(dev));
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_sync(dev));
> +
> +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
> +       pm_runtime_put_autosuspend(dev);
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
> +       /* Still disabled */
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> +       KUNIT_EXPECT_FALSE(test, pm_runtime_enabled(dev));
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
> +       pm_runtime_put(dev);
> +
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get_sync(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_sync(dev));
> +
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
> +       pm_runtime_put_autosuspend(dev);
> +
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
> +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_sync_autosuspend(de=
v));
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
> +       /* Error is still pending */
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +       KUNIT_EXPECT_EQ(test, -EIO, dev->power.runtime_error);
> +       /* Clear error */
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_set_suspended(dev));
> +       KUNIT_EXPECT_EQ(test, 0, dev->power.runtime_error);
> +       /* Still suspended */
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get(dev));
> +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_barrier(dev)); /* resume was =
pending */
> +       pm_runtime_put(dev);
> +       pm_runtime_suspend(dev); /* flush the put(), to suspend */
> +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> +
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> +       pm_runtime_put_autosuspend(dev);
> +
> +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_resume_and_get(dev));
> +
> +       /*
> +        * The following should all return -EAGAIN (usage is non-zero) or=
 1
> +        * (already resumed).
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
> +       /* Nothing to flush. We stay active. */
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

Applied as 6.18 material along with patches [2-3/3].

Thanks!

