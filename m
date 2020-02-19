Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4BC81639CF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 03:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgBSCIA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 21:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgBSCH7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 21:07:59 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68CC924655;
        Wed, 19 Feb 2020 02:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582078078;
        bh=ufSZgg1wZOqFJZOXUO8f0j1hDXf30tLyORTHplCmLGs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xFQu/8fX/yhfSKSM3vii6wtXTcTqL6SCtvO0uxeNmherG2KRiyFAnyQ78T+05xNHR
         mt43Vr5ztaRWprUfmbtvY5z/RT5n952ZbjvFC55/H21q2Ht/0jmgbXo892XMMX5cDK
         7nwFE7JtZ3SMB5/oiLXUqkUf06DUz1ieMS9hmSJ4=
Received: by mail-qt1-f170.google.com with SMTP id d5so16143242qto.0;
        Tue, 18 Feb 2020 18:07:58 -0800 (PST)
X-Gm-Message-State: APjAAAX8ckAms/ZmIAecFaweGF0ylmrP+W8sVSd39lsGcokfejXvMUgO
        vmgxxV/7xLKSAotalePafL+FNQszWXHB4KuHxQ==
X-Google-Smtp-Source: APXvYqzilKNDgKSHVeW3zu6GzBq5ZhsXsw+wNn13+9u8EcbRQ0taUuXVhe6rsxsqnedWAGc9PGbp2OCwlfjhwY3hvUs=
X-Received: by 2002:aed:2344:: with SMTP id i4mr20224440qtc.136.1582078077503;
 Tue, 18 Feb 2020 18:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <CAHp75VcPL7DYp9hjgMu+d=CE=g+V7ZxT9ZyXX-OjEW_JQ4m_nA@mail.gmail.com>
 <CALAqxLWtYfwCzDRVecWF8yRQSKQZh-N2g0SifageUaG0QhBGJg@mail.gmail.com> <CALAqxLW-Z=sut+A5Ezg4PkZ0HzM-np3PY_gAn0r=Ef0+FDBQDA@mail.gmail.com>
In-Reply-To: <CALAqxLW-Z=sut+A5Ezg4PkZ0HzM-np3PY_gAn0r=Ef0+FDBQDA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Feb 2020 20:07:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQRa5PNgms_jJ8bdsJqscW8dsKUtbzhGVLNvsAt0qMAQ@mail.gmail.com>
Message-ID: <CAL_JsqJQRa5PNgms_jJ8bdsJqscW8dsKUtbzhGVLNvsAt0qMAQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     John Stultz <john.stultz@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 18, 2020 at 7:11 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Tue, Feb 18, 2020 at 4:19 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Tue, Feb 18, 2020 at 4:06 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wednesday, February 19, 2020, John Stultz <john.stultz@linaro.org> wrote:
> > >> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > >> index b25bcab2a26b..9d916a7b56a6 100644
> > >> --- a/drivers/base/dd.c
> > >> +++ b/drivers/base/dd.c
> > >> @@ -237,13 +237,12 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
> > >>
> > >>  static int __driver_deferred_probe_check_state(struct device *dev)
> > >>  {
> > >> -       if (!initcalls_done)
> > >> -               return -EPROBE_DEFER;
> > >
> > >
> > > Why to touch this? Can't you simple add a new condition here 'if (deferred_probe_timeout > 0)'... ?
> >
> > I think that might work. I'll give it a spin later tonight and double check it.
> >
> > The main thing I wanted to do is fix the logic hole in the current
> > code where after initcalls_done=true but before deferred_probe_timeout
> > has expired we just fall through and return 0, which results in an
> > ENODEV being returned from the calling function.
>
>
> So on IRC Bjorn sort of clarified a point I think Rob was trying to
> make on the earlier iteration of this patch, that it seems like
> Thierry's patch here:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=62a6bc3a1e4f4ee9ae0076fa295f9af1c3725ce3
> *seems* to be trying to address the exact same issue, and maybe we
> should just have the genpd code use that instead?

Looking at it some more, I think the change to the pinctrl code there
breaks the case I care about (pinctrl described in DT and no driver on
a system that previously worked without pinctrl). Maybe if I set the
timeout to 0 it will still work (which would be fine).

> The main question though, is why do we need both?  As mentioned above,
> the existing logic in __driver_deferred_probe_check_state() seems
> wrong: Until late_initcall it returns EPROBE_DEFER, then after
> initcalls_done==true returns 0 (in which case the caller then
> translates to ENODEV), until the timeout expires which it then returns
> ETIMEDOUT.
>
> I suspect what is really wanted is EPROBE_DEFER -> (0) ENODEV (when
> timeout is not set) or EPROBE_DEFER -> ETIMEOUT (when the timeout is
> set), instead of the two state transitions it currently makes.

Yes. There's never any reason to return 0. It should be one of 3
errnos. If we're moving to always having a timeout, then maybe ENODEV
isn't even needed. I guess it's a stronger "we're done with init and
there's never going to be another driver" which maybe we should do for
!CONFIG_MODULES.

> So I still think my patch is needed, but I also suspect a better fix
> would be to kill driver_deferred_probe_check_state() and just replace
> its usage with driver_deferred_probe_check_state_continue(). Or am I
> still missing something?

I think those should be merged. They now do almost the same thing.
Only in the timeout==-1 case do they differ.

The original intent was that driver_deferred_probe_check_state()
simply returned what state we're in and the caller would decide what
to do with that. IOW, each caller could implement their own policy
possibly based on other information. Pinctrl factored in a DT hint.
IOMMU relied on everything was built-in.

The one complication which I mentioned already is with consoles. A
timeout (and dependencies in modules) there doesn't work. You have to
probe and register the console before init is done.

Rob
