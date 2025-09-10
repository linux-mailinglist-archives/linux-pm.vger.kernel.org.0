Return-Path: <linux-pm+bounces-34415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F6CB522C4
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 22:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816BF1CC01FD
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 20:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36AC32145F;
	Wed, 10 Sep 2025 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P129z1AS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E830C613
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537085; cv=none; b=e8nyBn/SbqcaCDUl9pFGMWRBfnLd8uT0aMM4Qp72NJykc+kzYnNmj7B5uxuQHRab4O7IZM3XIO8OdYDpK20+jqFBAU+k5L7NPWrbuVd12uSczphZs1g/haEgDeQ0z9xtKmz6CxUFPMRQ9niz03LtXvxGB5FLTk0sdUA5rtyOTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537085; c=relaxed/simple;
	bh=jKvZ0sP0nxR8T7mOsZSu3Nb1qAMgg+mb7LxigOIxVK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV3v/6zccfDOuh6bpHBOUjtDAo4rjFmYE1J5yPgIL+QttIU+z3C6vHXavVIU3BXjm8Aovr1+8NZWKZNszkPu99ZIWqbLIOjsEeCUr3w7dj7F1yF0kMbBwZd1Dc2y0++8mC5SqKanEt914FALHJYhZ6aW97DC6/+VHuOQDvsC94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P129z1AS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24456ce0b96so776735ad.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757537083; x=1758141883; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+RmsjXY0G9bTmGgcttoyEOhih/llw4M0qDu2slIcVSs=;
        b=P129z1ASKqB9YGqXMPPNg4YW0aU+kz8SpJKInXBaPSw44zPmZ54g4QH9k2KHGxo1uk
         cix3CpXKQ5Fe/UbJMy19zXCrVAskjUfJQyUTloBNN0N4ZY2+l22ftEALvMVrTpp/gRE+
         4LkJH4Oc8Lr/gBblpKO+p3A8Aybe3GPVicMbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537083; x=1758141883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RmsjXY0G9bTmGgcttoyEOhih/llw4M0qDu2slIcVSs=;
        b=l/7sJRY8FLbJBV/whyILpUtiiZBw1eydKRpc6dBsMWtvk5Nvoi+LbOww4QHtPIA2YD
         +bPjeUyqHWTTNLYsJJa69bKzdW5wXiMcCOUQWlsXcWtG0uXyyF2+wMd9ShAXynqzwTzH
         rQJMHUjViU/1ftFL4WJH3lC2zO/SPW5wlhVzdWFSp5hRLvi5mnxjk33nQdc7LLVKVAMY
         P1HWMfnl4p0DPOl4lmxqkeuonReMP50pZp5i5o66umO1gKRHwHhZR6jYjYFEW+mlzb2d
         LrL4P1X7kwGiMM1lNUR7Qa+Bhx8m0O8WNNeG11LtEWqUNSot65Fbqs0b4OhIKPOT1lOO
         0dPg==
X-Forwarded-Encrypted: i=1; AJvYcCV3su99PbZ/2DVADRwfTzA8YI84saekY2WCbpddrFjqXRZHgnU9+SCCtpNUXP/qH21kBgCE4Prj5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7p9sTsaRcYQr2V1M7TmfdGrLh50CTQ8KbPAoTEokRiq9NPn/W
	9tRxONuKw3wxYREPbT9PgObu2plDjMJnru+PdfhRdAK14v1Iqay2BHPjpS2kUku3dg==
X-Gm-Gg: ASbGncsXK7wu7/MF+SCd5xQnmjrhtzKmS/zbEvvIh+bDCbt1qdAuwbkdzoLcBlXod9b
	3O2Z4iddo6A/vWVqwy199vllpysiL+aWrG/6CF4QEvcDehz07swilxAn/Rkj2eOfvVNl/tU7ufp
	iN/jHs5iXKogPsV4MReSXvAM/uazGb1hAqe3f8YFsi90SfwmMuo5Rhwr1vvcYZ5WRknAHjpcdc8
	uhDjMXK0xKswZa712lWa12WEcEk9ghxtQ05FKMDYr91SpeE4OtMSSx1rZ7IpNvGlZCoR35jSt3M
	ifgoBRB10uWWr2/asj55nwDZkFCw0JIxCgbpo1fRlsNEKsxxqF7n7oHcNNARgNUT59xhyULo44U
	ebiWvG1eFTPJapa3L/KNGkgg4d5bjmQK+Qm3ukS8gihSDcmFTfwoj8QABuwjI
X-Google-Smtp-Source: AGHT+IE/EPPXLgqoqfdSwHOGiaDgCJL6UIz4/iAcySpXxLMRer18kYJ/ELk7olAHtNwyhwC/677RZw==
X-Received: by 2002:a17:902:f687:b0:24c:cf58:c5d9 with SMTP id d9443c01a7336-25bab92d0e4mr8515905ad.1.1757537082722;
        Wed, 10 Sep 2025 13:44:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:4780:f759:d36a:6480])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25a2a3449f7sm36380115ad.88.2025.09.10.13.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:44:42 -0700 (PDT)
Date: Wed, 10 Sep 2025 13:44:40 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	kunit-dev@googlegroups.com, Len Brown <lenb@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PM: runtime: Add basic kunit tests for API contracts
Message-ID: <aMHjOJGaKi9cwbsn@google.com>
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com>

Hi Rafael,

On Fri, Sep 05, 2025 at 07:37:38PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 29, 2025 at 2:33 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > In exploring the various return codes and failure modes of runtime PM
> > APIs, I found it helpful to verify and codify many of them in unit
> > tests, especially given that even the kerneldoc can be rather complex to
> > reason through, and it also has had subtle errors of its own.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> This is nice in general, but I have a couple of questions/comments (see below).

Thanks for looking. There's certainly some matter of opinion on how
exactly to test things, and I'm still getting up to speed on some of the
runtime PM API details, so I appreciate the care you've given.

Replies inline.

> > ---
> >
> >  drivers/base/Kconfig              |   6 +
> >  drivers/base/power/Makefile       |   1 +
> >  drivers/base/power/runtime-test.c | 259 ++++++++++++++++++++++++++++++
> >  3 files changed, 266 insertions(+)
> >  create mode 100644 drivers/base/power/runtime-test.c
> >
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 064eb52ff7e2..1786d87b29e2 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -167,6 +167,12 @@ config PM_QOS_KUNIT_TEST
> >         depends on KUNIT=y
> >         default KUNIT_ALL_TESTS
> >
> > +config PM_RUNTIME_KUNIT_TEST
> > +       tristate "KUnit Tests for runtime PM" if !KUNIT_ALL_TESTS
> > +       depends on KUNIT
> > +       depends on PM
> > +       default KUNIT_ALL_TESTS
> > +
> >  config HMEM_REPORTING
> >         bool
> >         default n
> > diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> > index 01f11629d241..2989e42d0161 100644
> > --- a/drivers/base/power/Makefile
> > +++ b/drivers/base/power/Makefile
> > @@ -4,5 +4,6 @@ obj-$(CONFIG_PM_SLEEP)  += main.o wakeup.o wakeup_stats.o
> >  obj-$(CONFIG_PM_TRACE_RTC)     += trace.o
> >  obj-$(CONFIG_HAVE_CLK) += clock_ops.o
> >  obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
> > +obj-$(CONFIG_PM_RUNTIME_KUNIT_TEST) += runtime-test.o
> >
> >  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> > diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
> > new file mode 100644
> > index 000000000000..263c28d5fc50
> > --- /dev/null
> > +++ b/drivers/base/power/runtime-test.c
> > @@ -0,0 +1,259 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2025 Google, Inc.
> > + */
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/pm_runtime.h>
> > +#include <kunit/device.h>
> > +#include <kunit/test.h>
> > +
> > +#define DEVICE_NAME "pm_runtime_test_device"
> > +
> > +static void pm_runtime_depth_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       pm_runtime_enable(dev);
> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_get_sync(dev)); /* "already active" */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +}
> > +
> > +/* Test pm_runtime_put() and friends when already suspended. */
> > +static void pm_runtime_already_suspended_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       pm_runtime_enable(dev);
> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       pm_runtime_get_noresume(dev);
> > +
> > +       /* Flush, in case the above (non-sync) triggered any work. */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup needed */
> 
> Why do you run pm_runtime_barrier(dev) here?  It is guaranteed that no
> requests are pending at this point.

I suppose my thought is as somewhat of an outsider, that's not really
familiar with exactly how each API is supposed to work. So without
looking into the details of the implementation, it's not clear to me
that a "get_noresume()" will never queue any work. Admittedly, that's a
pretty weak reason.

OTOH, it does serve to test the 0 side of the API contract:

"""
 * 1, if there was a resume request pending and the device had to be woken up,
 * 0, otherwise
"""

So IMO, it's a reasonable thing to run in this test, although I probably
should drop the "Flush" comment.

> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> 
> This has already been tested above.

I'm not really an expert on unit testing and style, but the whole point
of this test (named "already_suspended") is that we're testing each
operation when the device is suspended. So it's many series of:

1. set up some precondition
2. assert that the device is (still) suspended
3. test that an API returns the expected value for "already suspended"

Even if #1/#3 aren't likely to affect #2 for a later sequence, it seems
like a good pattern to actually test that this continues to remain true
each time. If the test changes in the future such that we perform
something different in #1, we might find ourselves not testing "already
suspended" behavior in #3.

Alternatively, I could split each #1/#2/#3 sequence into its own
subtest, but that might get a little excessive.

Anyway, like I said, it's probably some matter of opinion/style. I can
drop some of these checks if you still think they have no place here.

> > +       /*
> > +        * We never actually left RPM_SUSPENDED, but rpm_idle() still treats
> > +        * this as -EAGAIN / "runtime PM status change ongoing".
> 
> No, this means "Conditions are not suitable, but may change".

I'm just quoting the API docs for put():

"""
* * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
"""

If that's the wrong language, then we should update the API doc. At any
rate, I'm not sure what's "unsuitable" about a suspended device when we
call put(). It's not unsuitable -- it's already in the target state!

Notably, I'm also changing this behavior in patch 2, since I think it's
an API bug. And the comment then goes away.

> > +        */
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put(dev));
> > +
> > +       pm_runtime_get_noresume(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> 
> This has been tested already twice and why would it change?

Addressed above. I can drop it if you think it's excessive.

> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_request_autosuspend(dev));
> > +
> > +       pm_runtime_get_noresume(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> 
> There's no way by which it could change above.

Same.

> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync_autosuspend(dev));
> > +
> > +       pm_runtime_get_noresume(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_autosuspend(dev));
> > +
> > +       /* Grab 2 refcounts */
> > +       pm_runtime_get_noresume(dev);
> > +       pm_runtime_get_noresume(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       /* The first put() sees usage_count 1 */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_autosuspend(dev));
> > +       /* The second put() sees usage_count 0 but tells us "already suspended". */
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_autosuspend(dev));
> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> 
> Again, there is no way this can change in the whole test.

Same.

> > +}
> > +
> > +static void pm_runtime_idle_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       pm_runtime_enable(dev);
> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +       pm_runtime_put_noidle(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_idle(dev));
> > +}
> > +
> > +static void pm_runtime_disabled_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       /* Never called pm_runtime_enable() */
> > +       KUNIT_EXPECT_FALSE(test, pm_runtime_enabled(dev));
> > +
> > +       /* "disabled" is treated as "active" */
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +       KUNIT_EXPECT_FALSE(test, pm_runtime_suspended(dev));
> > +
> > +       /*
> > +        * Note: these "fail", but they still acquire/release refcounts, so
> > +        * keep them balanced.
> > +        */
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_sync(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_autosuspend(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume_and_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_autosuspend(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_suspend(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_autosuspend(dev));
> > +
> > +       /* Still active */
> 
> Still disabled rather.

Ack, will change.

> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +}
> > +
> > +static void pm_runtime_error_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       pm_runtime_enable(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +
> > +       /* Fake a .runtime_resume() error */
> > +       dev->power.runtime_error = -EIO;
> > +
> > +       /*
> > +        * Note: these "fail", but they still acquire/release refcounts, so
> > +        * keep them balanced.
> > +        */
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_sync(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_autosuspend(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume_and_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_autosuspend(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_suspend(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_autosuspend(dev));
> > +
> > +       /* Still suspended */
> 
> Error is still pending.

Your statement is true, but I'm not quite sure what you're suggesting.
Are you suggesting I should

	KUNIT_EXPECT_EQ(test, -EIO, dev->power.runtime_error);

?

Or are you suggesting I change the comment?

I'm thinking I'll do both.

> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       /* Clear error */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_set_suspended(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, dev->power.runtime_error);
> > +       /* Still suspended */
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_barrier(dev)); /* resume was pending */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put(dev));
> > +       pm_runtime_suspend(dev); /* flush the put(), to suspend */
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_autosuspend(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_resume_and_get(dev));
> > +
> > +       /*
> > +        * The following should all "fail" with -EAGAIN (usage is non-zero) or
> > +        * 1 (already resumed).
> 
> The return value of 1 doesn't count as a failure.

Hehe, sure. I suppose that's also a matter of unclear docs, because for
some of these, the kerneldoc specifically says 0 is success, while 1
doesn't really say whether it's success or failure. One has to infer
that "already resumed" is essentially "success" when requesting a
resume.

I'll try to tweak the language.

> > +        */
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_request_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_autosuspend(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_suspend(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_autosuspend(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> > +
> > +       /* Suspended again */
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +}
> > +
> > +/*
> > + * Explore a typical probe() sequence in which a device marks itself powered,
> > + * but doesn't hold any runtime PM reference, so it suspends as soon as it goes
> > + * idle.
> > + */
> > +static void pm_runtime_probe_active_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_status_suspended(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_set_active(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +
> > +       pm_runtime_enable(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +
> > +       /* Flush, and ensure we stayed active. */
> 
> There's nothing to flush though.

Ack. I'll reword.

Brian

> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +
> > +       /* Ask for idle? Now we suspend. */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +}
> > +
> > +static struct kunit_case pm_runtime_test_cases[] = {
> > +       KUNIT_CASE(pm_runtime_depth_test),
> > +       KUNIT_CASE(pm_runtime_already_suspended_test),
> > +       KUNIT_CASE(pm_runtime_idle_test),
> > +       KUNIT_CASE(pm_runtime_disabled_test),
> > +       KUNIT_CASE(pm_runtime_error_test),
> > +       KUNIT_CASE(pm_runtime_probe_active_test),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite pm_runtime_test_suite = {
> > +       .name = "pm_runtime_test_cases",
> > +       .test_cases = pm_runtime_test_cases,
> > +};
> > +
> > +kunit_test_suite(pm_runtime_test_suite);
> > +MODULE_DESCRIPTION("Runtime power management unit test suite");
> > +MODULE_LICENSE("GPL");
> > --

