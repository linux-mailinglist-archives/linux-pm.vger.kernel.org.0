Return-Path: <linux-pm+bounces-268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C5C7FA172
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 14:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AA2281615
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19CD30341;
	Mon, 27 Nov 2023 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j6oghxJx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57F3033D;
	Mon, 27 Nov 2023 13:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26C2C433C9;
	Mon, 27 Nov 2023 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701093239;
	bh=GTb9GqaRsBrlekhwa6N38fc0CNzOeE8HWqbJZ/h0/sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6oghxJxrr3PmUOx2TowPlRTMgt888N0YYTPcXPzBuaxhMHKoAt39URjaOREyU12b
	 m4HAHzm49h/JPhcx1UtMjOogq6R0PBxWpI8oYHx0/jsUK9PjfDkAoJ3DJoGH3By43A
	 xZ9xSyxqf9+cyDKYD25xYdONAn5Rd5YZwEuhkaWE=
Date: Mon, 27 Nov 2023 13:08:24 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <2023112722-headdress-kissing-8c9f@gregkh>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <CANhJrGPop=tL8y+chvPwMpSZYF1pkeWeRp3xL+7JsuY=U0fyag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANhJrGPop=tL8y+chvPwMpSZYF1pkeWeRp3xL+7JsuY=U0fyag@mail.gmail.com>

On Mon, Nov 27, 2023 at 02:54:21PM +0200, Matti Vaittinen wrote:
> pe 24. marrask. 2023 klo 19.26 Greg Kroah-Hartman
> (gregkh@linuxfoundation.org) kirjoitti:
> >
> > On Fri, Nov 24, 2023 at 05:32:34PM +0100, Oleksij Rempel wrote:
> > > On Fri, Nov 24, 2023 at 03:56:19PM +0000, Greg Kroah-Hartman wrote:
> > > > On Fri, Nov 24, 2023 at 03:49:46PM +0000, Mark Brown wrote:
> > > > > On Fri, Nov 24, 2023 at 03:27:48PM +0000, Greg Kroah-Hartman wrote:
> > > > > > On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:
> > > > >
> > > > > > > This came out of some discussions about trying to handle emergency power
> > > > > > > failure notifications.
> > > > >
> > > > > > I'm sorry, but I don't know what that means.  Are you saying that the
> > > > > > kernel is now going to try to provide a hard guarantee that some devices
> > > > > > are going to be shut down in X number of seconds when asked?  If so, why
> > > > > > not do this in userspace?
> > > > >
> > > > > No, it was initially (or when I initially saw it anyway) handling of
> > > > > notifications from regulators that they're in trouble and we have some
> > > > > small amount of time to do anything we might want to do about it before
> > > > > we expire.
> > > >
> > > > So we are going to guarantee a "time" in which we are going to do
> > > > something?  Again, if that's required, why not do it in userspace using
> > > > a RT kernel?
> > >
> > > For the HW in question I have only 100ms time before power loss. By
> > > doing it over use space some we will have even less time to react.
> >
> > Why can't userspace react that fast?  Why will the kernel be somehow
> > faster?  Speed should be the same, just get the "power is cut" signal
> > and have userspace flush and unmount the disk before power is gone.  Why
> > can the kernel do this any differently?
> >
> > > In fact, this is not a new requirement. It exist on different flavors of
> > > automotive Linux for about 10 years. Linux in cars should be able to
> > > handle voltage drops for example on ignition and so on. The only new thing is
> > > the attempt to mainline it.
> >
> > But your patch is not guaranteeing anything, it's just doing a "I want
> > this done before the other devices are handled", that's it.  There is no
> > chance that 100ms is going to be a requirement, or that some other
> > device type is not going to come along and demand to be ahead of your
> > device in the list.
> >
> > So you are going to have a constant fight among device types over the
> > years, and people complaining that the kernel is now somehow going to
> > guarantee that a device is shutdown in a set amount of time, which
> > again, the kernel can not guarantee here.
> >
> > This might work as a one-off for a specific hardware platform, which is
> > odd, but not anything you really should be adding for anyone else to use
> > here as your reasoning for it does not reflect what the code does.
> 
> I was (am) interested in knowing how/where the regulator error
> notifications are utilized - hence I asked this in ELCE last summer.
> Replies indeed mostly pointed to automotive and handling the under
> voltage events.
> 
> As to what has changed (I think this was asked in another mail on this
> topic) - I understood from the discussions that the demand of running
> systems with as low power as possible is even more
> important/desirable. Hence, the under-voltage events are more usual
> than they were when cars used to be working by burning flammable
> liquids :)
> 
> Anyways, what I thought I'd comment on is that the severity of the
> regulator error notifications can be given from device-tree. Rationale
> behind this is that figuring out whether a certain detected problem is
> fatal or not (in embedded systems) should be done by the board
> designers, per board. Maybe the understanding which hardware should
> react first is also a property of hardware and could come from the
> device-tree? Eg, instead of having a "DEVICE_SHUTDOWN_PRIO_STORAGE"
> set unconditionally for EMMC, systems could set shutdown priority per
> board and per device explicitly using device-tree?

Yes, using device tree would be good, but now you have created something
that is device-tree-specific and not all the world is device tree :(

Also, many devices are finally moving out to non-device-tree busses,
like PCI and USB, so how would you handle them in this type of scheme?

thanks,

greg k-h

