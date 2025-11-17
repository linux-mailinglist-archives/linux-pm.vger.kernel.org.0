Return-Path: <linux-pm+bounces-38130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E96C64DDF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 16:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16EDB348FEE
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F2233ADAD;
	Mon, 17 Nov 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVMyXElu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CD337BBC;
	Mon, 17 Nov 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393024; cv=none; b=XI5/w0HExpgH2SIS77J3dl4JPNJ4UyiD0UZClnsVu+V3VtQX4k6aNNVwCnHUmrkunIksBX73k2Amw8mvEF1Wm7GXr5WodSb6oiEGXOMYyKQCicNaL2Gf6n7mY5iCnIBJO7Epk/kruBtK8n0PdbmJtUVlp5pM9l6+UGCivLEgiT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393024; c=relaxed/simple;
	bh=D0uHEF+8TZ+GciPjEn9il1CGydZ3mO5pAE9l/oJDips=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6ad+2aIYk/yWXAAX5nS9xNgeclwj7YnENJgSwmC5kl1hMSVu/8j6w4ZYDl5sQ4t0BdhQvf8kU6U1OHYMEnijQtH+JVLYfJ1RLgnYvUp/D9QdPHz5eSPHmbAv6h4JcSckO2TYLJZfCR2Hhwe+dc/tK4Tb1ICNPyKCldQopiIM3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVMyXElu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869F8C19423;
	Mon, 17 Nov 2025 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763393023;
	bh=D0uHEF+8TZ+GciPjEn9il1CGydZ3mO5pAE9l/oJDips=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVMyXEluUuY3fVAbZu5As/b3oLYYW1eM17pQU0tqvz8Dl91tztRJVHX2h56r73VGF
	 6AFl7MqcTl7siDIzjU+QrZHbfmAPbqlsEj7e64oQeSyC5yWpjSllRHBuRIy79O/p3l
	 fiAxH+8NOq2BQlHxISI6HA2oT+YvQpRfmfrpbdozZt2cRStk4Soe+aztUqUkGQj+bb
	 Gvb4SclKUIISLGd/IB4mzbeX8xeP6WV7BRaUDCkQThQh5QceCpkzZMFOnprVW8GQNc
	 IPFUo8Hwv9D6/HY8+3SP9d27jcrliTR63ZUtPe1DwIOq2pZu6bXwdAnKW0NfyHRnQr
	 zt72M3bvIEcGg==
Date: Mon, 17 Nov 2025 09:23:41 -0600
From: Rob Herring <robh@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	linux-leds@vger.kernel.org, Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 04/16] dt-bindings: power: supply: BD72720 managed
 battery
Message-ID: <20251117152341.GA1944698-robh@kernel.org>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
 <ac5a4e992e4fb9c7bffb1e641a7cd61f74af4cba.1763022807.git.mazziesaccount@gmail.com>
 <176303119683.3716572.16868393928566655866.robh@kernel.org>
 <ee36d7d1-ef47-4a35-9aff-baa6ed32105a@gmail.com>
 <20251114163954.GA3399895-robh@kernel.org>
 <32303b95-3fd5-44c4-bb7d-e2957a6064fc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32303b95-3fd5-44c4-bb7d-e2957a6064fc@gmail.com>

On Mon, Nov 17, 2025 at 10:12:01AM +0200, Matti Vaittinen wrote:
> On 14/11/2025 18:39, Rob Herring wrote:
> > On Fri, Nov 14, 2025 at 11:04:27AM +0200, Matti Vaittinen wrote:
> > > On 13/11/2025 12:53, Rob Herring (Arm) wrote:
> > > > 
> > > > On Thu, 13 Nov 2025 10:52:19 +0200, Matti Vaittinen wrote:
> > > > > From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> //snip
> 
> > > 
> > > So, as far as I understand, the only viable options are expanding the
> > > existing battery.yaml with these properties (which I hoped to avoid, see
> > > below)
> > > 
> > > > > The right place for them is the battery node, which is described by the
> > > > > generic "battery.yaml". I was not comfortable with adding these
> > > > > properties to the generic battery.yaml because they are:
> > > > >     - Meaningful only for those charger drivers which have the VDR
> > > > >       algorithm implemented. (And even though the algorithm is not charger
> > > > >       specific, AFAICS, it is currently only used by some ROHM PMIC
> > > > >       drivers).
> > > > >     - Technique of measuring the VDR tables for a battery is not widely
> > > > >       known. AFAICS, only folks at ROHM are measuring those for some
> > > > >       customer products. We do have those tables available for some of the
> > > > >       products though (Kobo?).
> > > 
> > > or, to add new compatible for the "vdr-battery".
> > > AFAICS, adding new compatible would require us to wither duplicate the used
> > > properties from battery.yaml here (as battery.yaml mandates the
> > > "simple-battery" - compatible) - or to split the battery.yaml in two files,
> > > one containing the generic properties, other containing the "simple-battery"
> > > -compatible and referencing the generic one. Then the "vdr-battery" could
> > > also reference the generic one.
> > > 
> > > Any suggestions for the next path to follow?
> > 
> > Probably the latter option. You could do the former and make the new
> > properties conditional on the "vdr-battery" compatible. That's fine with
> > small differences, but gets messy as there are more properties and
> > variations.
> > 
> > But is "VDR" a type of battery though? Is there a certain type/chemistry
> > of battery we should be describing where VDR is applicable?
> 
> No. Not that I know. My understanding is that the "VDR (voltage drop rate)"
> refers to measured voltage drop-rates under certain conditions - which can
> be used to (more accurately) estimate the remaining capacity when battery is
> nearly depleted. As far as I know, this is only used with Lithium-ion
> batteries (I am not at all sure of this) - but I _assume_ the technique
> could be applied to other type of batteries as well.
> 
> > I don't
> > think it scales well if we define battery compatibles for every
> > variation of charger algorithm. Honestly I don't mind just adding 1
> > property. I care more if we allow undocumented properties than
> > allowing documented but invalid for the platform properties.
> 
> I see. The "VDR" stuff is really tightly bound to the fuel-gauging
> algorithm. It is measured characteristics of the battery - but those values
> are only usable by the "VDR" algorithm. I don't really have a good insight
> in the amount of fuel-gauging algorithm related properties suggested to be
> added during the years - but don't think there have been that many of them.
> So, I am not that worried about adding the compatible. On the other hand,
> there is no technical reason (other than adding properties which are unused
> on many platforms) why not to add the vdr tables in the static-battey node
> without adding own compatible. And, reading reply from Andreas (I'll copy it
> here to answer it in same mail)
> 
> /// Below text is form Andreas:
> > just keep in mind, that several kobo devices have one pmic in one board
> > revision and another one in the other (e.g. Kobo Nia rev A vs rev C).
> > But probably the same battery. So if the "vdr-battery" is a compatible
> > just to allow a more properties,
> > then "simple-battery" should be allowed as fallback.
> 
> I didn't know Kobos use multiple chargers. Thanks Andreas! So, in that
> sense, adding the "vdr" tables in static-battery node, without new
> compatible, would maybe be simplest solution. Then the charger(s)
> (fuel-gauge(s)) which implement VDR algorithm, can pick the tables while
> those chargers which don't implement the VDR will just ignore these tables.
> 
> > When it
> > becomes 10, 20, 30 properties, then I might start to care.
> 
> For VDR there are only:
> 
> rohm,voltage-vdr-thresh-microvolt,

So "voltage voltage drop rate"? And '-microvolt' says this is voltage 
too. :)

> rohm,volt-drop-soc-bp,
> rohm,volt-drop-temperatures-millicelsius
> 
> and
> 
> patternProperties:
>   '^rohm,volt-drop-[0-9]-microvolt':
> 
> So, from the binding point of view (.yaml), it's not _that_ lot. In the .dts
> there will be quite some noise as the tables have several values.
> 
> 
> > If that
> > happens, either we are doing a poor job of generically describing
> > battery parameters or chargers and batteries are tightly coupled and
> > can't be described independently.
> 
> I am under impression that chargers tend to be pretty flexible, and they can
> be configured to work with many different batteries by altering the charging
> profiles. Most of the battery properties (like and charging phases [like
> pre, CC, CV], their limits, currents and voltages etc) are very generally
> usable. So, large subset of charging functionality can be handled with
> standard properties. I believe it is only the fuel-gauging where things get
> more hairy.
> 
> I did prepare a series which does the split and adds new compatible for the
> 'rohm,vdr-battery'. (The power-supply class is not yet modified in the
> series, but we would probably want to modify the battery-info getters to
> also accept the 'rohm,vdr-battery' -compatible.)

I don't think that's the right direction. It's not a Rohm battery.

> I wonder if I should actually prepare also a series where these properties
> are just placed in the existing static battery node without adding new
> compatible. That way it would be easier to see which way is better.

That seems like the right thing to do here. 

The main question for me is whether these should even be Rohm specific? 
That would probably require a 2nd user to answer for sure. 


> If I do that, should I only spin these bindings as RFC to avoid the
> unnecessary noise?

Only if you think something is not complete and/or the patches should 
not be applied.

Rob

