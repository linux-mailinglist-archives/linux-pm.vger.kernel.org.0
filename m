Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAA10D3E1
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 11:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfK2KWV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 05:22:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39556 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2KWV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 05:22:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so3229542oty.6;
        Fri, 29 Nov 2019 02:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEPlDHDfElQzlynpKZC50UQTVyZXxcMCTJJAXbl0YjM=;
        b=ibEoeExm/DLGYnasShOMLZjjx77Cpq043Nw+lU6pRYn16gZokvl5dwm7M7YLNl4JKE
         cfCpBzR4KCBTzoEtb1dB2jlz0UYPv8SOcdnn9grtQExak5e9/zLSGjNfZtJwOp25X+Zj
         gFkENGkAw/VrIuDbCzrIY9vmkXawwR53s0uXQu+dbrapn3mlSh9CiN0sK2OniTiGYHRO
         6zHokLV0Z/WjsUqyRW046svYq9vlQHm6CFYl/CSIdO5oynqdmsuZ3kiFW1Iht1QZvAbB
         xJUiM/phEFGk24hHMR+ddAX24QnvhkBsDmN75y3rO7bPkieipt+LHQRWt3hWSgn+QWfQ
         OyFw==
X-Gm-Message-State: APjAAAVNTdTYiZ4VBXEgjIPwpo/jynwOeqMNOSCz98Fn4mC8FFScKFD0
        JnZaDy+D09UpheaYvBYpV/7acvhVS0CboaTb1UU=
X-Google-Smtp-Source: APXvYqw7RBvYpcakVysZLAP41IqtSt4qsgKCCm673X7BR+/eo9R0SNTc+yaEL5eXa173X8qQUyqqQhef8r7FnE09AWA=
X-Received: by 2002:a9d:7483:: with SMTP id t3mr10774090otk.262.1575022939737;
 Fri, 29 Nov 2019 02:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20191128160314.2381249-1-thierry.reding@gmail.com>
 <20191128163623.GA2382107@ulmo> <2310325.iNVD75376c@kreacher>
 <4149037.GOuMSCS4uT@kreacher> <20191129094303.GB2770902@ulmo>
In-Reply-To: <20191129094303.GB2770902@ulmo>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Nov 2019 11:22:08 +0100
Message-ID: <CAJZ5v0hhMSmLBr+M5CxCrfrcJHH2DzYkRFJBVyBymP0xs35Yzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / runtime: Allow drivers to override runtime PM
 behaviour on sleep
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 29, 2019 at 11:08 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Thu, Nov 28, 2019 at 11:20:01PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, November 28, 2019 11:03:57 PM CET Rafael J. Wysocki wrote:
> > > On Thursday, November 28, 2019 5:50:26 PM CET Thierry Reding wrote:
> > > >
> > > > --0F1p//8PRICkK4MW
> > > > Content-Type: text/plain; charset=us-ascii
> > > > Content-Disposition: inline
> > > > Content-Transfer-Encoding: quoted-printable
> > > >
> > > > On Thu, Nov 28, 2019 at 05:14:51PM +0100, Rafael J. Wysocki wrote:
> > > > > On Thu, Nov 28, 2019 at 5:03 PM Thierry Reding <thierry.reding@gmail.com>=
> > > >  wrote:
> > > > > >
> > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > >
> > > > > > Currently the driver PM core will automatically acquire a runtime PM
> > > > > > reference for devices before system sleep is entered. This is needed
> > > > > > to avoid potential issues related to devices' parents getting put to
> > > > > > runtime suspend at the wrong time and causing problems with their
> > > > > > children.
> > > > >=20
> > > > > Not only for that.
> > > > >=20
> > > > > > In some cases drivers are carefully written to avoid such issues and
> > > > > > the default behaviour can be changed to allow runtime PM to operate
> > > > > > regularly during system sleep.
> > > > >=20
> > > > > But this change breaks quite a few assumptions in the core too, so no,
> > > > > it can't be made.
> > > >
> > > > Anything in particular that I can look at? I'm not seeing any issues
> > > > when I test this, which could of course mean that I'm just getting
> > > > lucky.
> > >
> > > There are races and such that you may never hit during casual testing.
> > >
> > > > One thing that irritated me is that I think this used to work. I do
> > > > recall testing suspend/resume a few years ago and devices would get
> > > > properly runtime suspended/resumed.
> > >
> > > Not true at all.
> > >
> > > The PM core has always taken PM-runtime references on all devices pretty much
> > > since when PM-runtime was introduced.
> > >
> > > > I did some digging but couldn't
> > > > find anything that would have had an impact on this.
> > > >
> > > > Given that this is completely opt-in feature, why are you categorically
> > > > NAK'ing this?
> > >
> > > The general problem is that if any device has been touched by system-wide
> > > suspend code, it should not be subject to PM-runtime any more until the
> > > subsequent system-wide resume is able to undo whatever the suspend did.
> > >
> > > Moreover, if a device is runtime-suspended, the system-wide suspend code
> > > may mishandle it, in general.  That's why PM-runtime suspend is not allowed
> > > during system-wide transitions at all.  And it has always been like that.
> > >
> > > For a specific platform you may be able to overcome these limitations if
> > > you are careful enough, but certainly they are there in general and surely
> > > you cannot prevent people from using your opt-in just because they think
> > > that they know what they are doing.
> >
> > BTW, what if user space prevents PM-runtime from suspending devices by writing
> > "on" to their "control" files?
> >
> > System-wide suspend is (of course) still expected to work in that case, so how
> > exactly would you overcome that?
>
> I suppose one way to overcome that would be to make it an error to write
> "on" to the "control" files for these devices.

Seeing suggestions like this in messages from seasoned kernel
developers is seriously disappointing. :-/

> Currently doing this is likely going to break display support on Tegra,
> so this would be a good idea in this case anyway.

PM-runtime has always allowed user space to prevent devices from being
suspended and it seems that this has not been taken into account by
Tegra display support developers at all.

> Again, I could avoid all of these issues by avoiding runtime PM in this driver,

I don't quite see the connection here.

Preventing a device from suspending should never be a functional
problem.  It may be an energy-efficiency problem, but that's something
for user space to consider before writing "on" to a device's control
file.

> but I would end up reimplementing some of the same concepts. I'd
> rather use something that's supported by the PM core and that might be
> useful to other drivers than reinvent the wheel.

Which doesn't have to be by using PM-runtime suspend for the handling
of system-wide suspend, at least in my view.
