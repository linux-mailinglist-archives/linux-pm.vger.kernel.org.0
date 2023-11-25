Return-Path: <linux-pm+bounces-210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A9C7F8969
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 09:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EB71F20EE9
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 08:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1670F8F62;
	Sat, 25 Nov 2023 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED87E6
	for <linux-pm@vger.kernel.org>; Sat, 25 Nov 2023 00:50:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1r6oN6-0005Vm-TH; Sat, 25 Nov 2023 09:50:40 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1r6oN4-00BS6U-Du; Sat, 25 Nov 2023 09:50:38 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1r6oN4-003lCE-Aq; Sat, 25 Nov 2023 09:50:38 +0100
Date: Sat, 25 Nov 2023 09:50:38 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <20231125085038.GA877872@pengutronix.de>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023112520-paper-image-ef5d@gregkh>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Sat, Nov 25, 2023 at 06:51:55AM +0000, Greg Kroah-Hartman wrote:
> On Fri, Nov 24, 2023 at 07:57:25PM +0100, Oleksij Rempel wrote:
> > On Fri, Nov 24, 2023 at 05:26:30PM +0000, Greg Kroah-Hartman wrote:
> > > On Fri, Nov 24, 2023 at 05:32:34PM +0100, Oleksij Rempel wrote:
> > > > On Fri, Nov 24, 2023 at 03:56:19PM +0000, Greg Kroah-Hartman wrote:
> > > > > On Fri, Nov 24, 2023 at 03:49:46PM +0000, Mark Brown wrote:
> > > > > > On Fri, Nov 24, 2023 at 03:27:48PM +0000, Greg Kroah-Hartman wrote:
> > > > > > > On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:
> > > > > > 
> > > > > > > > This came out of some discussions about trying to handle emergency power
> > > > > > > > failure notifications.
> > > > > > 
> > > > > > > I'm sorry, but I don't know what that means.  Are you saying that the
> > > > > > > kernel is now going to try to provide a hard guarantee that some devices
> > > > > > > are going to be shut down in X number of seconds when asked?  If so, why
> > > > > > > not do this in userspace?
> > > > > > 
> > > > > > No, it was initially (or when I initially saw it anyway) handling of
> > > > > > notifications from regulators that they're in trouble and we have some
> > > > > > small amount of time to do anything we might want to do about it before
> > > > > > we expire.
> > > > > 
> > > > > So we are going to guarantee a "time" in which we are going to do
> > > > > something?  Again, if that's required, why not do it in userspace using
> > > > > a RT kernel?
> > > > 
> > > > For the HW in question I have only 100ms time before power loss. By
> > > > doing it over use space some we will have even less time to react.
> > > 
> > > Why can't userspace react that fast?  Why will the kernel be somehow
> > > faster?  Speed should be the same, just get the "power is cut" signal
> > > and have userspace flush and unmount the disk before power is gone.  Why
> > > can the kernel do this any differently?
> > > 
> > > > In fact, this is not a new requirement. It exist on different flavors of
> > > > automotive Linux for about 10 years. Linux in cars should be able to
> > > > handle voltage drops for example on ignition and so on. The only new thing is
> > > > the attempt to mainline it.
> > > 
> > > But your patch is not guaranteeing anything, it's just doing a "I want
> > > this done before the other devices are handled", that's it.  There is no
> > > chance that 100ms is going to be a requirement, or that some other
> > > device type is not going to come along and demand to be ahead of your
> > > device in the list.
> > > 
> > > So you are going to have a constant fight among device types over the
> > > years, and people complaining that the kernel is now somehow going to
> > > guarantee that a device is shutdown in a set amount of time, which
> > > again, the kernel can not guarantee here.
> > > 
> > > This might work as a one-off for a specific hardware platform, which is
> > > odd, but not anything you really should be adding for anyone else to use
> > > here as your reasoning for it does not reflect what the code does.
> > 
> > I see. Good point.
> > 
> > In my case umount is not needed, there is not enough time to write down
> > the data. We should send a shutdown command to the eMMC ASAP.
> 
> If you don't care about the data, why is a shutdown command to the
> hardware needed?  What does that do that makes anything "safe" if your
> data is lost.

It prevents HW damage. In a typical automotive under-voltage labor it is
usually possible to reproduce X amount of bricked eMMCs or NANDs on Y
amount of under-voltage cycles (I do not have exact numbers right now).
Even if the numbers not so high in the labor tests (sometimes something
like one bricked device in a month of tests), the field returns are
significant enough to care about software solution for this problem.

Same problem was seen not only in automotive devices, but also in
industrial or agricultural. With other words, it is important enough to bring
some kind of solution mainline.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

