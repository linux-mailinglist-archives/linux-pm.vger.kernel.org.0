Return-Path: <linux-pm+bounces-26238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 122EFA9D0A8
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 20:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0152A7AD469
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA7C216E1B;
	Fri, 25 Apr 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+Bnb1LO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115FB7E9;
	Fri, 25 Apr 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606626; cv=none; b=f9uXfZlbnmu1OV42zxscVNSwcf+fJsDsQWdooTIwc2D6rOzzCShPTtLwWyg+iItSP3/m5mAqRCdQcGeL30jYgPvDxb29IvDreUVauOUi7qpEVlBjMXTTaYvqhszoMH5uiH0CZOwFFvqUG9fE22nwDiJEy/FCyC6jWiVZczKeFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606626; c=relaxed/simple;
	bh=oRbnULd+pvgyIqyXUcH4ldEzy+X/hNIXnhxXaeZ8Hw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YojI1N5fwoLaRWI00QJPzd8N3sSagM0bOujUaZEL1eDQ1TrFr/vQF66Ac10FZcmUvWGT10wKhBTDfzZw8yCELzf811CC6FVk8Nf3awkOcwQVjk6qtNE9SrKF2aiZSyZx0mKwTkhb5ArWQwrowNq6h9r+ZLbSURqhvY0H4jEnNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+Bnb1LO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7635FC4CEE4;
	Fri, 25 Apr 2025 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745606625;
	bh=oRbnULd+pvgyIqyXUcH4ldEzy+X/hNIXnhxXaeZ8Hw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W+Bnb1LOq5ZBEL8q0M0ErEPb+ekqsXPe3SW8i1lI2RszJd9U8UAkzGBs2OZ8byObs
	 2jrVP9i4B4rjAzPC2UimN06DyI+WluhpoGx5EZznaxeCnmLgtCtUxKw8eAAOENwJyc
	 3Vze4UNzq0Je/dpfQseZ5JyeYMnhDnDgoCVsmKfTugxqE8FaRows39XGkBc2DHt+8w
	 k3ZzdNOH57gJgHTQyD3TxWTPsFByBV3znJd3oW90lj7vaPCWVtUQiC9kE4eHRDQvqI
	 br5x8QWNj9reJhuogPhy5m8+OWr127s4YN0RqOcmC8AiEMpjIGVz4odidCQJp4d1MV
	 xzjgTEdp7K5tQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2d0364e9231so712968fac.1;
        Fri, 25 Apr 2025 11:43:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUC1BQicbgyplyoNDUiKAN/6tb9/NuDp99zap8KBMzNaiLKQuSSuxBAvnFFiGl/FnpcN8+ip3FijWs=@vger.kernel.org, AJvYcCUomGpVvWoxCxaipPKnk359CwLyI7+Akr5n56qiCo/t2sNQ/WuDzzaxMstzjTMoUAxZSwESp9kfnJ4l1eE=@vger.kernel.org, AJvYcCX6Ieuh5jxGtD6Ut940lnavW/JCTtWvfC9k7/YEPbdno+nMyncegmf84s9Vs3yKx6ykWKRKCcdQti4qO+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwETHiEulO1UNwvOwvksD0gToV34aZmXoP7vkX4TObJ8JbI0VqV
	p2a/YgRExJ7PVsG3W26nJwOpS8PQlrUa6ak+C5+OTYkPripIFqtaOF+7IbYiiiWeOVdbVcc4wtr
	L+ZS/+1gOWYVz1Y8iOHwkiaCe+sU=
X-Google-Smtp-Source: AGHT+IFy5Eym5BLJREteVInWqHA/TWsIsW/7cwsZQtmYkh4ff8Mkq0LbyQQdNCvFoGFRP8o/LocCXeX48LxmPmlXrik=
X-Received: by 2002:a05:6870:819a:b0:2c1:62e9:584b with SMTP id
 586e51a60fabf-2d99de905e9mr2032853fac.39.1745606624720; Fri, 25 Apr 2025
 11:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5891540.DvuYhMxLoT@rjwysocki.net> <30acf520-c137-4b49-8b69-08e35a7c5969@linux.dev>
 <CAJZ5v0iCsd8fdXRdicT7mqsRte39WC+SVjgfz2NHS9QpvSnDdw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iCsd8fdXRdicT7mqsRte39WC+SVjgfz2NHS9QpvSnDdw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Apr 2025 20:43:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iFPf=WT3CjNqtioUoiX9jc5nmZLJnAkQOhBTmGq_ioAw@mail.gmail.com>
X-Gm-Features: ATxdqUH2gpi0z3_zPVJ3Dy1t6lghfw6a3CE-Su7_syymO_e7p_CEWdwpVYRZjNA
Message-ID: <CAJZ5v0iFPf=WT3CjNqtioUoiX9jc5nmZLJnAkQOhBTmGq_ioAw@mail.gmail.com>
Subject: Re: [PATCH v1] soundwire: intel_auxdevice: Fix system suspend/resume handling
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vinod Koul <vkoul@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 8:10=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Apr 25, 2025 at 7:14=E2=80=AFPM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.dev> wrote:
> >
> > On 4/24/25 20:13, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The code in intel_suspend() and intel_resume() needs to be properly
> > > synchronized with runtime PM which is not the case currently, so fix
> > > it.
> > >
> > > First of all, prevent runtime PM from triggering after intel_suspend(=
)
> > > has started because the changes made by it to the device might be
> > > undone by a runtime resume of the device.  For this purpose, add a
> > > pm_runtime_disable() call to intel_suspend().
> >
> > Allow me to push back on this, because we have to be very careful with =
a hidden state transition that needs to happen.
> >
> > If a controller was suspended by pm_runtime, it will enter the clock st=
op mode.
> >
> > If the system needs to suspend, the controller has to be forced to exit=
 the clock stop mode and the bus has to restart before we can suspend it, a=
nd that's why we had those pm_runtime_resume().
> >
> > Disabling pm_runtime when entering system suspend would be problematic =
for Intel hardware, it's a known can of worms.
>
> No, it wouldn't AFAICS.
>
> > It's quite possible that some of the code in intel_suspend() is no long=
er required because the .prepare will resume the bus properly, but I wanted=
 to make sure this state transition out of clock-stop is known and taken in=
to consideration.
>
> This patch doesn't change the functionality in intel_suspend(), it
> just prevents runtime resume running in parallel with it or after it
> from messing up with the hardware.
>
> I don't see why it would be unsafe to do and please feel free to prove me=
 wrong.

Or just tell me what I'm missing in the reasoning below.

This code:

-    if (pm_runtime_suspended(dev)) {
-        dev_dbg(dev, "pm_runtime status was suspended, forcing active\n");
-
-        /* follow required sequence from runtime_pm.rst */
-        pm_runtime_disable(dev);
-        pm_runtime_set_active(dev);
-        pm_runtime_mark_last_busy(dev);
-        pm_runtime_enable(dev);
-
-        pm_runtime_resume(bus->dev);
-
-        link_flags =3D md_flags >> (bus->link_id * 8);
-
-        if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
-            pm_runtime_idle(dev);
-    }

that is being removed by my patch (because it is invalid - more about
that later) had never run before commit bca84a7b93fd ("PM: sleep: Use
DPM_FLAG_SMART_SUSPEND conditionally") because setting
DPM_FLAG_SMART_SUSPEND had caused the core to call
pm_runtime_set_active() on the device in the noirq resume phase, so it
had never been seen as runtime-suspended in intel_resume().  After
commit bca84a7b93fd the core doesn't do that any more, so if the
device has been runtime-suspended before intel_suspend() runs,
intel_resume() will see that its status is RPM_SUSPENDED.  The code in
question will run and it will crash and burn if
SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE is set in the link flags.

The reason why that code is invalid is because the
pm_runtime_set_active() call in it causes the status to change to
RPM_ACTIVE, but it doesn't actually change the state of the device
(that is still physically suspended).  The subsequent
pm_runtime_resume() sees that the status is RPM_ACTIVE and it doesn't
do anything.  At this point, the device is still physically suspended,
but its runtime PM status is RPM_ACTIVE, so if pm_runtime_idle() runs,
it will trigger an attempt to suspend and that will break because the
device is already suspended.

So this code had never run before and it demonstrably doesn't work, so
I don't see why removing it could be incorrect.

Thanks!

