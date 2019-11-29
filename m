Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7462710DA93
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 21:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfK2U1k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 15:27:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36862 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2U1k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 15:27:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so10509072wma.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2019 12:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dAr/eDqhv9Ud8ZSYN/AId0Oghe+xqTiZDWWez4ZYfgo=;
        b=H06JGztG7aul8sMAoUmAu5eic+Qlir+slRE61mGgNT2j9HvOw/o+Pc3VlmshBrxLZd
         V9Wef3xMJ2JwVpMFzQQYHcloZvfTnVGlZceDaRKqBMPVoCbBozXhKWJgr+3D7+W0kW6e
         CwOLcPzMBenSjLDMlW4K9P2BnhshbyDy/CC9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dAr/eDqhv9Ud8ZSYN/AId0Oghe+xqTiZDWWez4ZYfgo=;
        b=DJ3+YvjVBUGqWh0mJmhIpWiytDAAA58/3haA8kMC96sAUOB0VxxIiCs8SlU7mXMh83
         x8gZHL/+PeIv7AnA2FGmxqCTmNWI3IKxx1WzLIX/HcGQ7h1qNFdL/a5CfGFQrn+YQfP+
         Mj642gryrtJS/qn7qjB089ls8UOjYNM8v5WC3k/rkIleutpW5CnSBU5n5fXa6+9aqVRP
         3s01CgVVUoXnD6VDlX5cskHgMPtZiXvaYC/av9PP02e4DDhWaZDmkruphZPP78n3BMcd
         PQgWLxYzowghvBEpVF0YgZDCHDsGELOdq0kq+j+vZbkCNOljH6ZJp2R4SXbQP8hIqIzA
         9iIA==
X-Gm-Message-State: APjAAAUfefIWitp8RRh+qvfIRF95KjNuEa8Qi3LOXHyGt0PZfASZt0a/
        Y+VypzELefPco2rRiWcxHFJu/VOARbI=
X-Google-Smtp-Source: APXvYqzizH66FbKznJhCk3/6chUJ5dXYdcQrM2jvQCv0FSVbQD0zf7OntdNn3VnLrWmeWdG7wOps3g==
X-Received: by 2002:a1c:2e0f:: with SMTP id u15mr16546880wmu.47.1575059257153;
        Fri, 29 Nov 2019 12:27:37 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id a184sm5669596wmf.29.2019.11.29.12.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 12:27:35 -0800 (PST)
Date:   Fri, 29 Nov 2019 21:27:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pavel Machek <pavel@ucw.cz>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 1/2] PM / runtime: Allow drivers to override runtime PM
 behaviour on sleep
Message-ID: <20191129202734.GU624164@phenom.ffwll.local>
References: <20191128160314.2381249-1-thierry.reding@gmail.com>
 <20191128163623.GA2382107@ulmo>
 <2310325.iNVD75376c@kreacher>
 <4149037.GOuMSCS4uT@kreacher>
 <20191129094303.GB2770902@ulmo>
 <CAJZ5v0hhMSmLBr+M5CxCrfrcJHH2DzYkRFJBVyBymP0xs35Yzw@mail.gmail.com>
 <20191129120719.GF2771912@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129120719.GF2771912@ulmo>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 29, 2019 at 01:07:19PM +0100, Thierry Reding wrote:
> On Fri, Nov 29, 2019 at 11:22:08AM +0100, Rafael J. Wysocki wrote:
> > On Fri, Nov 29, 2019 at 11:08 AM Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > >
> > > On Thu, Nov 28, 2019 at 11:20:01PM +0100, Rafael J. Wysocki wrote:
> > > > On Thursday, November 28, 2019 11:03:57 PM CET Rafael J. Wysocki wrote:
> > > > > On Thursday, November 28, 2019 5:50:26 PM CET Thierry Reding wrote:
> > > > > >
> > > > > > --0F1p//8PRICkK4MW
> > > > > > Content-Type: text/plain; charset=us-ascii
> > > > > > Content-Disposition: inline
> > > > > > Content-Transfer-Encoding: quoted-printable
> > > > > >
> > > > > > On Thu, Nov 28, 2019 at 05:14:51PM +0100, Rafael J. Wysocki wrote:
> > > > > > > On Thu, Nov 28, 2019 at 5:03 PM Thierry Reding <thierry.reding@gmail.com>=
> > > > > >  wrote:
> > > > > > > >
> > > > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > > > >
> > > > > > > > Currently the driver PM core will automatically acquire a runtime PM
> > > > > > > > reference for devices before system sleep is entered. This is needed
> > > > > > > > to avoid potential issues related to devices' parents getting put to
> > > > > > > > runtime suspend at the wrong time and causing problems with their
> > > > > > > > children.
> > > > > > >=20
> > > > > > > Not only for that.
> > > > > > >=20
> > > > > > > > In some cases drivers are carefully written to avoid such issues and
> > > > > > > > the default behaviour can be changed to allow runtime PM to operate
> > > > > > > > regularly during system sleep.
> > > > > > >=20
> > > > > > > But this change breaks quite a few assumptions in the core too, so no,
> > > > > > > it can't be made.
> > > > > >
> > > > > > Anything in particular that I can look at? I'm not seeing any issues
> > > > > > when I test this, which could of course mean that I'm just getting
> > > > > > lucky.
> > > > >
> > > > > There are races and such that you may never hit during casual testing.
> > > > >
> > > > > > One thing that irritated me is that I think this used to work. I do
> > > > > > recall testing suspend/resume a few years ago and devices would get
> > > > > > properly runtime suspended/resumed.
> > > > >
> > > > > Not true at all.
> > > > >
> > > > > The PM core has always taken PM-runtime references on all devices pretty much
> > > > > since when PM-runtime was introduced.
> > > > >
> > > > > > I did some digging but couldn't
> > > > > > find anything that would have had an impact on this.
> > > > > >
> > > > > > Given that this is completely opt-in feature, why are you categorically
> > > > > > NAK'ing this?
> > > > >
> > > > > The general problem is that if any device has been touched by system-wide
> > > > > suspend code, it should not be subject to PM-runtime any more until the
> > > > > subsequent system-wide resume is able to undo whatever the suspend did.
> > > > >
> > > > > Moreover, if a device is runtime-suspended, the system-wide suspend code
> > > > > may mishandle it, in general.  That's why PM-runtime suspend is not allowed
> > > > > during system-wide transitions at all.  And it has always been like that.
> > > > >
> > > > > For a specific platform you may be able to overcome these limitations if
> > > > > you are careful enough, but certainly they are there in general and surely
> > > > > you cannot prevent people from using your opt-in just because they think
> > > > > that they know what they are doing.
> > > >
> > > > BTW, what if user space prevents PM-runtime from suspending devices by writing
> > > > "on" to their "control" files?
> > > >
> > > > System-wide suspend is (of course) still expected to work in that case, so how
> > > > exactly would you overcome that?
> > >
> > > I suppose one way to overcome that would be to make it an error to write
> > > "on" to the "control" files for these devices.
> > 
> > Seeing suggestions like this in messages from seasoned kernel
> > developers is seriously disappointing. :-/
> > 
> > > Currently doing this is likely going to break display support on Tegra,
> > > so this would be a good idea in this case anyway.
> > 
> > PM-runtime has always allowed user space to prevent devices from being
> > suspended and it seems that this has not been taken into account by
> > Tegra display support developers at all.
> > 
> > > Again, I could avoid all of these issues by avoiding runtime PM in this driver,
> > 
> > I don't quite see the connection here.
> > 
> > Preventing a device from suspending should never be a functional
> > problem.  It may be an energy-efficiency problem, but that's something
> > for user space to consider before writing "on" to a device's control
> > file.
> 
> That's really a question of how you define suspension. In the case of
> display drivers we have the somewhat unfortunate situation that in most
> SoCs the display "device" is actually represented by a collection of
> different devices. On Tegra specifically, for example, you have a couple
> of display controllers, then some "encoders" that take pixel streams
> from the display controllers and encode them into some wire format like
> LVDS, HDMI, DSI or DP.
> 
> Prohibiting suspension of any of the individual devices causes problems
> because it effectively makes the whole composite display device not
> suspendable. Doing so in turn usually means that you can't change the
> display configuration anymore because devices need to be powered up and
> down in order to change the configuration.
> 
> I consider powering up and down the devices a form of suspension. Hence
> it seemed natural to implement using runtime PM.
> 
> It sounds to me like userspace preventing runtime PM is problematic in
> most scenarios that involve composite devices because it makes all of
> the interactions between the devices a bit complicated.

Yeah with the DT model of how a SoC works, all these tiny little devices
are essentially implementation details that userspace really shouldn't
ever care about, much less change anything with them.

If userspace doesn't want the gpu to auto-suspend, then there's the
overall gpu device that it can set that on, and I guess doing that should
not break a decently written driver. For all the others insisting that
userspace can be stupid essentially means we get to hand roll large chunks
of runtime pm in drivers, which feels rather pointless. We have a lot of
that home-grown runtime pm for subcomponents in i915, and I very much
understand why the DT folks wanted to standardize all that with lots of
little explicit devices.

Maybe the mistake was simply allowing these to be visible to userspace.
-Daniel

> > > but I would end up reimplementing some of the same concepts. I'd
> > > rather use something that's supported by the PM core and that might be
> > > useful to other drivers than reinvent the wheel.
> > 
> > Which doesn't have to be by using PM-runtime suspend for the handling
> > of system-wide suspend, at least in my view.
> 
> Well, runtime PM is very convenient for this, though. It would allow the
> same code paths to be used in all cases.
> 
> Thierry



> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
