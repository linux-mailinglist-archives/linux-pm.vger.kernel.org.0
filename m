Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF4810CFB9
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 23:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfK1WUF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 17:20:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54885 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfK1WUF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 17:20:05 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id eea6408bb1d4e6fd; Thu, 28 Nov 2019 23:20:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/2] PM / runtime: Allow drivers to override runtime PM behaviour on sleep
Date:   Thu, 28 Nov 2019 23:20:01 +0100
Message-ID: <4149037.GOuMSCS4uT@kreacher>
In-Reply-To: <2310325.iNVD75376c@kreacher>
References: <20191128160314.2381249-1-thierry.reding@gmail.com> <20191128163623.GA2382107@ulmo> <2310325.iNVD75376c@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, November 28, 2019 11:03:57 PM CET Rafael J. Wysocki wrote:
> On Thursday, November 28, 2019 5:50:26 PM CET Thierry Reding wrote:
> > 
> > --0F1p//8PRICkK4MW
> > Content-Type: text/plain; charset=us-ascii
> > Content-Disposition: inline
> > Content-Transfer-Encoding: quoted-printable
> > 
> > On Thu, Nov 28, 2019 at 05:14:51PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Nov 28, 2019 at 5:03 PM Thierry Reding <thierry.reding@gmail.com>=
> >  wrote:
> > > >
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> > > > Currently the driver PM core will automatically acquire a runtime PM
> > > > reference for devices before system sleep is entered. This is needed
> > > > to avoid potential issues related to devices' parents getting put to
> > > > runtime suspend at the wrong time and causing problems with their
> > > > children.
> > >=20
> > > Not only for that.
> > >=20
> > > > In some cases drivers are carefully written to avoid such issues and
> > > > the default behaviour can be changed to allow runtime PM to operate
> > > > regularly during system sleep.
> > >=20
> > > But this change breaks quite a few assumptions in the core too, so no,
> > > it can't be made.
> > 
> > Anything in particular that I can look at? I'm not seeing any issues
> > when I test this, which could of course mean that I'm just getting
> > lucky.
> 
> There are races and such that you may never hit during casual testing.
> 
> > One thing that irritated me is that I think this used to work. I do
> > recall testing suspend/resume a few years ago and devices would get
> > properly runtime suspended/resumed.
> 
> Not true at all.
> 
> The PM core has always taken PM-runtime references on all devices pretty much
> since when PM-runtime was introduced.
> 
> > I did some digging but couldn't
> > find anything that would have had an impact on this.
> > 
> > Given that this is completely opt-in feature, why are you categorically
> > NAK'ing this?
> 
> The general problem is that if any device has been touched by system-wide
> suspend code, it should not be subject to PM-runtime any more until the
> subsequent system-wide resume is able to undo whatever the suspend did.
> 
> Moreover, if a device is runtime-suspended, the system-wide suspend code
> may mishandle it, in general.  That's why PM-runtime suspend is not allowed
> during system-wide transitions at all.  And it has always been like that.
> 
> For a specific platform you may be able to overcome these limitations if
> you are careful enough, but certainly they are there in general and surely
> you cannot prevent people from using your opt-in just because they think
> that they know what they are doing.

BTW, what if user space prevents PM-runtime from suspending devices by writing
"on" to their "control" files?

System-wide suspend is (of course) still expected to work in that case, so how
exactly would you overcome that?



