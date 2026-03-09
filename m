Return-Path: <linux-pm+bounces-43971-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGIrFuIZr2n2NwIAu9opvQ
	(envelope-from <linux-pm+bounces-43971-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 20:05:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0159123F21A
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 20:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BAD300EABB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9499835CB8B;
	Mon,  9 Mar 2026 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEpBXpXv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE1175A75;
	Mon,  9 Mar 2026 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083100; cv=none; b=CpoqkVVzfg9l74PIJQdJBwXD8HXG2Rgx4yvLlvmfISbSU3oLPOHf8gz0y1C6zuqqdETWkHMzSMsXp1rEGkgtOReW4Y3qg737CqJ70FyWGtN6TfyCm/rRmBCBj4sQuJVBaj96FTnT1g1+OUtQik9q9H1HaumTdf9WG0G0JcBrSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083100; c=relaxed/simple;
	bh=1gDb6j/JlkCFdpEsMVdhL8r3rqW83cqfP3G8hG4gcKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiaQ7KgA/R+s1i6wxYakm/vZG85AwsPpJd5v2ayDmJmNeqBaLYJ0x3mVSgUzHaXzgzrz6eG8iF7IvZgpViylL+ZwIA/WbHNKQUPqVVKm3Wa5E8ZA3aaPpgPeWWBFKk3ChHdjaRpxFa7WG4FmYwY+VWDOkqJH+JmfVKkQ6OslCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEpBXpXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66B2C4CEF7;
	Mon,  9 Mar 2026 19:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773083100;
	bh=1gDb6j/JlkCFdpEsMVdhL8r3rqW83cqfP3G8hG4gcKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEpBXpXvPEVW8GAI+5ZloOek7XKIqxjjV5UE2cLKLxinFqIXD/evjTez6HIGqdzxS
	 GStQpJuXnnIzoD65Xx9OIwsE98MXxS0OPuPSxcpWCInouB9ZzdXHco5q3fB98hnc7H
	 y5XBFylM6wJhgtZdHXimIjotPNSEGiUM9y8JBCKMr4uTxd20WyASXW9p9k3X/jY/xV
	 kIiLoGB/PCr4bLHIehWv2fHJ1z3+Xw/58/rzzdI/WaC2tgWZIOD/R8KqkJc/LOg0GJ
	 /haDEWUiJSUULotDUUQXjg2VursYTP8z8S7Fhif19aGfX4CIS6LnzTJSgDxTaiZPye
	 mPjrXUXssu+qA==
Date: Mon, 9 Mar 2026 19:04:53 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 7/9] leds: Add driver for Asus Transformer LEDs
Message-ID: <20260309190453.GA183676@google.com>
References: <20260209104407.116426-1-clamor95@gmail.com>
 <20260209104407.116426-8-clamor95@gmail.com>
 <20260306100406.GE183676@google.com>
 <CAPVz0n0jnuhmvsSPckfFOQ0NZ3VMe6W2p_Bb5a9pdVZYhVSJhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0jnuhmvsSPckfFOQ0NZ3VMe6W2p_Bb5a9pdVZYhVSJhQ@mail.gmail.com>
X-Rspamd-Queue-Id: 0159123F21A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43971-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qmqm.pl:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 06 Mar 2026, Svyatoslav Ryhel wrote:

> пт, 6 бер. 2026 р. о 12:04 Lee Jones <lee@kernel.org> пише:
> >
> > On Mon, 09 Feb 2026, Svyatoslav Ryhel wrote:
> >
> > > From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > >
> > > Asus Transformer tablets have a green and an amber LED on both the Pad
> > > and the Dock. If both LEDs are enabled simultaneously, the emitted light
> > > will be yellow.
> > >
> > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > > ---
> > >  drivers/leds/Kconfig        |  11 ++++
> > >  drivers/leds/Makefile       |   1 +
> > >  drivers/leds/leds-asus-ec.c | 104 ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 116 insertions(+)
> > >  create mode 100644 drivers/leds/leds-asus-ec.c
[
...]

> > > +static int asus_ec_led_probe(struct platform_device *pdev)
> > > +{
> > > +     struct asusec_info *ec = cell_to_ec(pdev);
> >
> > Please remove all of your abstraction layers.  They serve little purpose
> > other than to complicate things.  Just use dev_get_drvdata() here.
> >
> > Remove the "_info" part and change "ec" to "ddata".
> >
> 
> Controller exposes only required stuff, exposing controllers internal
> parts is not desired. Is there any written convention that driver
> private data pointer MUST be named "ddata"? "priv" is pretty well
> fitting to. You are just nitpicking.

[...] 

> > Lots of repetition here.
> >
> > I'd make a sub-function that takes the differences.
> >
> > Same with the set brightness functions.
> >
> > Think to yourself - what if I had to support 16 different LEDs?
> >
> 
> That is not of my concern what you would do. I have 2 LEDs and I see
> no point in "abstraction for he sake of abstraction".

Your attitude stinks!

All of your submissions are now on hold until I can be bothered to look
at them again.  In the mean time, I suggest you look inward and
re-evaluate how you choose to communicate with others.

-- 
Lee Jones [李琼斯]

