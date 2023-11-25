Return-Path: <linux-pm+bounces-211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BB17F8976
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 10:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806692816D9
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 09:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20FA9444;
	Sat, 25 Nov 2023 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JKY/4ilC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7106568B;
	Sat, 25 Nov 2023 09:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAF0C433C8;
	Sat, 25 Nov 2023 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700903344;
	bh=MW8ZDrdn27gXIQAKUwEbdXYazJeTuzAYxnp0tKWlAGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKY/4ilC6JEquAcrxGLtsxIpaK2IIAJCb0VyL9wU4pIcQ4pIZ/M9ZSLdiatU+RLEP
	 uXHrJqwUVriaZ57JiZfi2LkP8mZrQjFOExQyrSTVtrm8/OzsisVTOqjw9hV5hR6oK4
	 j0NAjZZZMH8bwHYB9E7s9eYuEs3cUt7i1XEmhm8o=
Date: Sat, 25 Nov 2023 09:09:01 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <2023112506-unselfish-unkind-adcb@gregkh>
References: <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125085038.GA877872@pengutronix.de>

On Sat, Nov 25, 2023 at 09:50:38AM +0100, Oleksij Rempel wrote:
> On Sat, Nov 25, 2023 at 06:51:55AM +0000, Greg Kroah-Hartman wrote:
> > On Fri, Nov 24, 2023 at 07:57:25PM +0100, Oleksij Rempel wrote:
> > > On Fri, Nov 24, 2023 at 05:26:30PM +0000, Greg Kroah-Hartman wrote:
> > > > On Fri, Nov 24, 2023 at 05:32:34PM +0100, Oleksij Rempel wrote:
> > > > > On Fri, Nov 24, 2023 at 03:56:19PM +0000, Greg Kroah-Hartman wrote:
> > > > > > On Fri, Nov 24, 2023 at 03:49:46PM +0000, Mark Brown wrote:
> > > > > > > On Fri, Nov 24, 2023 at 03:27:48PM +0000, Greg Kroah-Hartman wrote:
> > > > > > > > On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:
> > > > > > > 
> > > > > > > > > This came out of some discussions about trying to handle emergency power
> > > > > > > > > failure notifications.
> > > > > > > 
> > > > > > > > I'm sorry, but I don't know what that means.  Are you saying that the
> > > > > > > > kernel is now going to try to provide a hard guarantee that some devices
> > > > > > > > are going to be shut down in X number of seconds when asked?  If so, why
> > > > > > > > not do this in userspace?
> > > > > > > 
> > > > > > > No, it was initially (or when I initially saw it anyway) handling of
> > > > > > > notifications from regulators that they're in trouble and we have some
> > > > > > > small amount of time to do anything we might want to do about it before
> > > > > > > we expire.
> > > > > > 
> > > > > > So we are going to guarantee a "time" in which we are going to do
> > > > > > something?  Again, if that's required, why not do it in userspace using
> > > > > > a RT kernel?
> > > > > 
> > > > > For the HW in question I have only 100ms time before power loss. By
> > > > > doing it over use space some we will have even less time to react.
> > > > 
> > > > Why can't userspace react that fast?  Why will the kernel be somehow
> > > > faster?  Speed should be the same, just get the "power is cut" signal
> > > > and have userspace flush and unmount the disk before power is gone.  Why
> > > > can the kernel do this any differently?
> > > > 
> > > > > In fact, this is not a new requirement. It exist on different flavors of
> > > > > automotive Linux for about 10 years. Linux in cars should be able to
> > > > > handle voltage drops for example on ignition and so on. The only new thing is
> > > > > the attempt to mainline it.
> > > > 
> > > > But your patch is not guaranteeing anything, it's just doing a "I want
> > > > this done before the other devices are handled", that's it.  There is no
> > > > chance that 100ms is going to be a requirement, or that some other
> > > > device type is not going to come along and demand to be ahead of your
> > > > device in the list.
> > > > 
> > > > So you are going to have a constant fight among device types over the
> > > > years, and people complaining that the kernel is now somehow going to
> > > > guarantee that a device is shutdown in a set amount of time, which
> > > > again, the kernel can not guarantee here.
> > > > 
> > > > This might work as a one-off for a specific hardware platform, which is
> > > > odd, but not anything you really should be adding for anyone else to use
> > > > here as your reasoning for it does not reflect what the code does.
> > > 
> > > I see. Good point.
> > > 
> > > In my case umount is not needed, there is not enough time to write down
> > > the data. We should send a shutdown command to the eMMC ASAP.
> > 
> > If you don't care about the data, why is a shutdown command to the
> > hardware needed?  What does that do that makes anything "safe" if your
> > data is lost.
> 
> It prevents HW damage. In a typical automotive under-voltage labor it is
> usually possible to reproduce X amount of bricked eMMCs or NANDs on Y
> amount of under-voltage cycles (I do not have exact numbers right now).
> Even if the numbers not so high in the labor tests (sometimes something
> like one bricked device in a month of tests), the field returns are
> significant enough to care about software solution for this problem.

So hardware is attempting to rely on software in order to prevent the
destruction of that same hardware?  Surely hardware designers aren't
that crazy, right?  (rhetorical question, I know...)

> Same problem was seen not only in automotive devices, but also in
> industrial or agricultural. With other words, it is important enough to bring
> some kind of solution mainline.

But you are not providing a real solution here, only a "I am going to
attempt to shut down a specific type of device before the others, there
are no time or ordering guarantees here, so good luck!" solution.

And again, how are you going to prevent the in-fighting of all device
types to be "first" in the list?

thanks,

greg k-h

