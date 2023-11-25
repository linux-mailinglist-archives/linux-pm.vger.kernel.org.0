Return-Path: <linux-pm+bounces-235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E839D7F8E43
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 20:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985C828141D
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 19:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A432FE1C;
	Sat, 25 Nov 2023 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JaLY3ZWp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194772F849;
	Sat, 25 Nov 2023 19:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0E0C433C7;
	Sat, 25 Nov 2023 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700942295;
	bh=g7PIAmnH5nJje+Q1nASw9YQHtkXNa79XrtXt1I9gXXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaLY3ZWpEQtnaKMuAiMNDNqAFO99WTHGVVPfKslb3BUL1JWwE+wYd99vJPAH0q+sb
	 6xvC/5ed5MNhiK3NJrQW4Ms9SBjjOtISp+Cy18jU8K2EOsvSxIAkH91NhJAqvSPuUd
	 Mp3EjseRzX8SenCbT+oPVGAvNvCGN6DlIjeASJn8=
Date: Sat, 25 Nov 2023 19:58:12 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <2023112504-cathedral-pulmonary-83ce@gregkh>
References: <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <2023112506-unselfish-unkind-adcb@gregkh>
 <ZWHM0lRPOp/efyD5@finisterre.sirena.org.uk>
 <2023112541-uptown-tripping-05f3@gregkh>
 <ZWIWBhBN8AmK7tAJ@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWIWBhBN8AmK7tAJ@finisterre.sirena.org.uk>

On Sat, Nov 25, 2023 at 03:43:02PM +0000, Mark Brown wrote:
> On Sat, Nov 25, 2023 at 02:35:41PM +0000, Greg Kroah-Hartman wrote:
> > On Sat, Nov 25, 2023 at 10:30:42AM +0000, Mark Brown wrote:
> > > On Sat, Nov 25, 2023 at 09:09:01AM +0000, Greg Kroah-Hartman wrote:
> 
> > > > So hardware is attempting to rely on software in order to prevent the
> > > > destruction of that same hardware?  Surely hardware designers aren't
> > > > that crazy, right?  (rhetorical question, I know...)
> 
> > > Surely software people aren't going to make no effort to integrate with
> > > the notification features that the hardware engineers have so helpfully
> > > provided us with?
> 
> > That would be great, but I don't see that here, do you?  All I see is
> > the shutdown sequence changing because someone wants it to go "faster"
> > with the threat of hardware breaking if we don't meet that "faster"
> > number, yet no knowledge or guarantee that this number can ever be known
> > or happen.
> 
> The idea was to have somewhere to send notifications when the hardware
> starts reporting things like power supplies starting to fail.  We do
> have those from hardware, we just don't do anything terribly useful
> with them yet.

Ok, but that's not what I recall this patchset doing, or did I missing
something?  All I saw was a "reorder the shutdown sequence" set of
changes.  Or at least that's all I remember at this point in time,
sorry, it's been a few days, but at least that lines up with what the
Subject line says above :)

> TBH it does seem reasonable that there will be systems that can usefully
> detect these issues but hasn't got a detailed characterisation of
> exactly how long you've got before things expire, it's also likely that
> the actual bound is going to be highly variable depending on what the
> system is up to at the point of detection.  It's quite likely that we'd
> only get a worst case bound so it's also likely that we'd have more time
> in practice than in spec.  I'd expect characterisation that does happen
> to be very system specific at this point, I don't think we can rely on
> getting that information.  I'd certainly expect that we have vastly more
> systems can usefully detect issues than systems where we have firm
> numbers.

Sure, that all sounds good, but again, I don't think that's what is
happening here.

> > > > > Same problem was seen not only in automotive devices, but also in
> > > > > industrial or agricultural. With other words, it is important enough to bring
> > > > > some kind of solution mainline.
> 
> > > > But you are not providing a real solution here, only a "I am going to
> > > > attempt to shut down a specific type of device before the others, there
> > > > are no time or ordering guarantees here, so good luck!" solution.
> 
> > > I'm not sure there are great solutions here, the system integrators are
> > > constrained by the what the application appropriate silicon that's on
> > > the market is capable of, the siicon is constrained by the area costs of
> > > dealing with corner cases for system robustness and how much of the
> > > market cares about fixing these issues and software is constrained by
> > > what hardware ends up being built.  Everyone's just got to try their
> > > best with the reality they're confronted with, hopefully what's possible
> > > will improve with time.

Note, if you attempt to mitigate broken hardware with software fixes,
hardware will never get unbroken as it never needs to change.  Push back
on this, it's the only real way forward here.  I know it's not always
possible, but the number of times I have heard hardware engineers say
"but no one ever told us that was broken/impossible/whatever, we just
assumed software could handle it" is uncountable.

> > Agreed, but I don't think this patch is going to actually work properly
> > over time as there is no time values involved :)
> 
> This seems to be more into the area of mitigation than firm solution, I
> suspect users will be pleased if they can make a noticable dent in the
> number of failures they're seeing.

Mitigation is good, but this patch series is just a hack by doing "throw
this device type at the front of the shutdown list because we have
hardware that crashes a lot" :)

> > > > And again, how are you going to prevent the in-fighting of all device
> > > > types to be "first" in the list?
> 
> > > It doesn't seem like the most complex integration challenge we've ever
> > > had to deal with TBH.
> 
> > True, but we all know how this grows and thinking about how to handle it
> > now is key for this to be acceptable.
> 
> It feels like if we're concerned about mitigating physical damage during
> the process of power failure that's a very limited set of devices - the
> storage case where we're in the middle of writing to flash or whatever
> is the most obvious case.

Then why isn't userspace handling this?  This is a policy decision that
it needs to take to properly know what hardware needs to be shut down,
and what needs to happen in order to do that (i.e. flush, unmount,
etc.?)  And userspace today should be able to say, "power down this
device now!" for any device in the system based on the sysfs device
tree, or at the very least, force it to a specific power state.  So why
not handle this policy there?

thanks,

greg k-h

