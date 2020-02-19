Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0C163C03
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 05:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBSEXW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 23:23:22 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38885 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgBSEXW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 23:23:22 -0500
Received: by mail-ot1-f67.google.com with SMTP id z9so21870661oth.5
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 20:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7SLwa6rrwxpfTtL0bXLJZfcEfVfrOJVu8RT2yguxu8=;
        b=TmFigD35LCKnZvhGHDH34L5P/d+/RjHyfyqH2kLH9QCMYnkbeYjlHLwrOmOd5ky8pG
         dmvoNfkVsBm4DQlXdVpMKlA2erdn7rSPaMcPh4uCyacPwoh5qlk1Qp9IJq9Sza/lgv8D
         8W7giZXLH2Sg0HbZB4pUNVSxONQDJmZAVmvUbSbKmLHyICE4NnnNjk7+Q5e3MXUyI1Fl
         xdBU3V3fb/hISfNu3QJ7SYZFtX96vS7Fr6wgjXl1xXYIMTPEg0Ci11vZO1crOuOV1uj0
         D86GefSPDdkRdPV/WAx+fdlb2sT8CTyIvxK1GCCCb4r4CWP5LCn6RDDcZKbfLepFxH+T
         +vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7SLwa6rrwxpfTtL0bXLJZfcEfVfrOJVu8RT2yguxu8=;
        b=lw0Bwl1XTPkG6+/qEPLZiFZ9TRyzmCcDyEIZ3bLqJipNqrT+ucPMo9AYjLd98LKk9M
         a+8WwchXU7XcLNlxV2f98RqAikwber8PKO/RiVhcvNvGjhCodlFqW8KG44KhblXUS72n
         z8E55GRH6kcoqdGY90Bx9cS933mGQRRg/ji+XvNHRab7ftYxbEsTc/c+em3vI1sNP27z
         6s58NGKICW0x/RFSz2/I75r7+wiF9Ex6n66+ZnNBVpr5r3r6yG2yCBqswFmJZ2jpqkwV
         3F5HOgoHVQJCK7C2oyCZn+nVnrHScMOXn8VzK6GvrSd3uQEa4z/LxvkVUtczJYCUkbUi
         GQdQ==
X-Gm-Message-State: APjAAAWxqDB4pUES8ZE0iT0oUVQGJ8aVaN7XPf4gti/7KpaxWFCF6Gw5
        GFSeM/VjjVOqnsVrCdgEHHL/2uKgFyWwJ3KnRWGwJQ==
X-Google-Smtp-Source: APXvYqzTSjT9/xhIYTjQNNao1IXP26vaK/cfEUj5cWME8N34ik1V0niHrLTda2e9yGguG+46/XbtPMDm/Aj4jFiZ2P0=
X-Received: by 2002:a9d:4e82:: with SMTP id v2mr4360065otk.352.1582086201006;
 Tue, 18 Feb 2020 20:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <CAHp75VcPL7DYp9hjgMu+d=CE=g+V7ZxT9ZyXX-OjEW_JQ4m_nA@mail.gmail.com>
 <CALAqxLWtYfwCzDRVecWF8yRQSKQZh-N2g0SifageUaG0QhBGJg@mail.gmail.com>
 <CALAqxLW-Z=sut+A5Ezg4PkZ0HzM-np3PY_gAn0r=Ef0+FDBQDA@mail.gmail.com> <CAL_JsqJQRa5PNgms_jJ8bdsJqscW8dsKUtbzhGVLNvsAt0qMAQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJQRa5PNgms_jJ8bdsJqscW8dsKUtbzhGVLNvsAt0qMAQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 18 Feb 2020 20:23:08 -0800
Message-ID: <CALAqxLUCfegDoBUfa6ZNd7dQaiz-ujeVk=RxJcu5NanfDj=bRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Rob Herring <robh@kernel.org>
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

On Tue, Feb 18, 2020 at 6:07 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 18, 2020 at 7:11 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Tue, Feb 18, 2020 at 4:19 PM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > On Tue, Feb 18, 2020 at 4:06 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Wednesday, February 19, 2020, John Stultz <john.stultz@linaro.org> wrote:
> > > >> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > >> index b25bcab2a26b..9d916a7b56a6 100644
> > > >> --- a/drivers/base/dd.c
> > > >> +++ b/drivers/base/dd.c
> > > >> @@ -237,13 +237,12 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
> > > >>
> > > >>  static int __driver_deferred_probe_check_state(struct device *dev)
> > > >>  {
> > > >> -       if (!initcalls_done)
> > > >> -               return -EPROBE_DEFER;
> > > >
> > > >
> > > > Why to touch this? Can't you simple add a new condition here 'if (deferred_probe_timeout > 0)'... ?
> > >
> > > I think that might work. I'll give it a spin later tonight and double check it.
> > >
> > > The main thing I wanted to do is fix the logic hole in the current
> > > code where after initcalls_done=true but before deferred_probe_timeout
> > > has expired we just fall through and return 0, which results in an
> > > ENODEV being returned from the calling function.
> >
> >
> > So on IRC Bjorn sort of clarified a point I think Rob was trying to
> > make on the earlier iteration of this patch, that it seems like
> > Thierry's patch here:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=62a6bc3a1e4f4ee9ae0076fa295f9af1c3725ce3
> > *seems* to be trying to address the exact same issue, and maybe we
> > should just have the genpd code use that instead?
>
> Looking at it some more, I think the change to the pinctrl code there
> breaks the case I care about (pinctrl described in DT and no driver on
> a system that previously worked without pinctrl). Maybe if I set the
> timeout to 0 it will still work (which would be fine).
>
> > The main question though, is why do we need both?  As mentioned above,
> > the existing logic in __driver_deferred_probe_check_state() seems
> > wrong: Until late_initcall it returns EPROBE_DEFER, then after
> > initcalls_done==true returns 0 (in which case the caller then
> > translates to ENODEV), until the timeout expires which it then returns
> > ETIMEDOUT.
> >
> > I suspect what is really wanted is EPROBE_DEFER -> (0) ENODEV (when
> > timeout is not set) or EPROBE_DEFER -> ETIMEOUT (when the timeout is
> > set), instead of the two state transitions it currently makes.
>
> Yes. There's never any reason to return 0. It should be one of 3
> errnos. If we're moving to always having a timeout, then maybe ENODEV
> isn't even needed. I guess it's a stronger "we're done with init and
> there's never going to be another driver" which maybe we should do for
> !CONFIG_MODULES.
>
> > So I still think my patch is needed, but I also suspect a better fix
> > would be to kill driver_deferred_probe_check_state() and just replace
> > its usage with driver_deferred_probe_check_state_continue(). Or am I
> > still missing something?
>
> I think those should be merged. They now do almost the same thing.
> Only in the timeout==-1 case do they differ.

Well.. almost..  in addition to that different after late_initcall but
before the timeout driver_deferred_probe_check_state() will return
ENODEV, where as driver_deferred_probe_check_state_continue() returns
EPROBE_DEFER until the timeout happens.

> The original intent was that driver_deferred_probe_check_state()
> simply returned what state we're in and the caller would decide what
> to do with that. IOW, each caller could implement their own policy
> possibly based on other information. Pinctrl factored in a DT hint.
> IOMMU relied on everything was built-in.

I'm not super opinionated here, having the subsystem opt in and decide
what to do with the check_state() return value seems sane.  But I
suspect that we can consolidate the two cases down and simplify some
of the logic here.

I'll take another spin on this.

thanks
-john
