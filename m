Return-Path: <linux-pm+bounces-20632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEE0A1522E
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519797A5420
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34107194A66;
	Fri, 17 Jan 2025 14:52:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2A18A6A7;
	Fri, 17 Jan 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125558; cv=none; b=m4Bncl/I0pTKofiTAu9E/lkiRKPQApsHtQMVbi7nhY4HcTOvTvGUsgc/hbEJ5YxT7kB637GPLXEYubAqbXXVt6E+cJvZMPKD0V7gQ191qpp4NzZp46oSQfdmRLktNC0OZ+h8AORG9FsuCdsS3AOMEmzegPW6gklCih0bwuzGFPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125558; c=relaxed/simple;
	bh=2gX7KHDcFevvJA4zKEAmuJ9SkdUhqyW4SCi1gpCPwQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkMmoIu2MXIXHZ3VIjK/A1NLB7QiZPvOYw7Pv6l/HSKHzZ/l8+Ks+HwUeKRCWwjhbAUp60cXBgvEvfgoA3VDMfkF0wgRNgorGBq8R5Y9lpsIu0JpSCG7TjXfG/tZrFvKv2nyNhhA0MgNYDp5+5BKCO336hDFdHGTwgu2tcOlrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A7931476;
	Fri, 17 Jan 2025 06:53:03 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D21683F73F;
	Fri, 17 Jan 2025 06:52:30 -0800 (PST)
Date: Fri, 17 Jan 2025 14:52:28 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andras Szemzo <szemzo.andras@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Vinod
 Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Ulf
 Hansson <ulf.hansson@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 03/12] pinctrl: sunxi: add driver for Allwinner V853.
Message-ID: <20250117145228.2fc8a64e@donnerap.manchester.arm.com>
In-Reply-To: <CACRpkdYVTedEon0X-izvaDTGF6yRhD2s=Z6NEM=zBf4vD-T0Pg@mail.gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
	<20250110123923.270626-4-szemzo.andras@gmail.com>
	<20250114141954.2785879a@donnerap.manchester.arm.com>
	<CACRpkda0nx3SQtdjmXdCEbVJSWM10TM=p-6JbDjbiYcOSF5PxQ@mail.gmail.com>
	<20250115152635.1b89e7f4@donnerap.manchester.arm.com>
	<CACRpkdYVTedEon0X-izvaDTGF6yRhD2s=Z6NEM=zBf4vD-T0Pg@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jan 2025 10:34:26 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

Hi Linus,

> some nice talk here, actually the following is just opinions, I will
> be likely happy with whatever approach is taken eventually.

it's indeed an intriguing discussion, made me think a bit ...
And thanks for describing your maintainer's view, that's definitely
helpful.

> On Wed, Jan 15, 2025 at 4:26=E2=80=AFPM Andre Przywara <andre.przywara@ar=
m.com> wrote:
>=20
> > > pio: pinctrl@1c20800 {
> > >                         compatible =3D "allwinner,sun8i-r40-pinctrl";
> > > (...)
> > >                         i2c0_pins: i2c0-pins {
> > >                                 pins =3D "PB0", "PB1";
> > >                                 function =3D "i2c0";
> > >                         };
> > >
> > > abstract, strings, nice. The driver handles the particulars. =20
> >
> > What bugs me about this it that this has quite some seemingly redundant
> > information (Who would have thought that the i2c0 pins use function
> > "i2c0"?), but misses out on the actual 4 bits(!) of information. =20
>=20
> the pins in this example are called PB0 and PB1 though. The designation
> on the package. And often pins actually named "i2c0_1" "i2c0_2" are
> for that primary function, but muxable to a few other functions,
> at least GPIO in most cases. So it's just some name for the pin
> really.

Sure, there is information in the form that marks those two pins for
being usable as I2C pins. But I feel like the function parameter is not
living up to its promise (see below).

> > > That is like so because we are designing for users which are
> > > let's say customization engineers. If these engineers jump from
> > > project to project matching function strings to group strings will
> > > be a common way to set up pins, and easy to understand and
> > > grasp, and it makes the DTS very readable. =20
> >
> > That's an interesting view, and I see the point of it being easy to rea=
d,
> > but this is partly because it doesn't convey too much actual informatio=
n,
> > does it, as it requires another lookup or two.
> > And the pinctrl group nodes are actually in the .dtsi file, which are
> > typically written once during the initial SoC enablement, and new board
> > .dts files normally just reference the existing pingroup nodes. So anyo=
ne
> > dealing with just a new board is not bothered by this. =20
>=20
> You have a point, and when working with a system the application
> engineer often finds bugs in the pin control driver, and has to go
> and fix the actual driver and then all the information hiding and
> simplification is moot.
>=20
> This can become an expensive lesson for the current attempts
> to push pin control into firmware where the configuration is
> mostly "dead simple" (and just using strings) - the bugs will be
> in the firmware instead, and impossible or really hard to fix.

... in that old embedded world where firmware is an opaque closed source
unfixable blob. Mainline Allwinner is all "organic": we have upstreamed
U-Boot and TF-A support, actively maintained, plus an Open Source
management firmware. Updating the firmware is a matter of "dd" or
"flashcp" - at least in theory. And I'd rather think of the kernel being
not easy to change - think Debian installer image, or getting it upstream
first, then backported, then picked up by a distro.
But I think this discussion slightly digresses here - at least following it
would double the length of this email ;-)

> > Also in my experience most people have no problems in understanding the
> > concept of pinmuxing and that there is a selector number, also where to
> > find this. =20
>=20
> Yeah the ambition with the strings was to avoid forcing application
> engineers to know all about that. If they do, they are then
> developing the driver, not just using it.

I'd argue that an application engineer just has to choose the right
pingroup DT node:
	pinctrl-0 =3D <&i2c2_pb_pins>;
In the worst case they go ahead and ask their hardware buddy, and create
a new pingroup node. In my experience the typical Allwinner users are more
on the hardware side, so are no strangers to looking up data sheets.

> > > Mediatek and STM32 made a compromise by using pinmux
> > > and adding some macros to define them so it looks more
> > > pleasant:
> > >
> > >       i2c0_pins_a: i2c0-default {
> > >                 pins-i2c0 {
> > >                         pinmux =3D <MT7623_PIN_75_SDA0_FUNC_SDA0>,
> > >                                  <MT7623_PIN_76_SCL0_FUNC_SCL0>; =20
> >
> > Well, I don't really get why they don't use the (MTK_PIN_NO(75) | 1)
> > definition directly, seems to be more telling to me? =20
>=20
> That's what STM32 does as well and it's usable.
>=20
> But of course it drives a truck through the initial ambition that pins
> on all systems be configured the same way, with strings. So now
> there are some families of drivers all "necessarily different" which
> is not so nice for people jumping between different SoCs, but
> very compelling for people focusing on just one SoC.

Ah, I think I get your point.

> Well, unless this way of doing things becomes so prevalent that
> it's the new black.

That is actually a good argument: At the moment I am happy with my
proposal (the allwinner,pinmux =3D <number>; property), but that seems like
standard #15 then.
So would biting the bullet and adopting the Apple/STM32 way then be more
sustainable?
On the other hand: the allwinner,pinmux solution has the advantage of being
already written and proven working, also it stays very close to the
existing description/binding - so implementations like U-Boot could just
keep on using the "function" string.

I am a bit torn here... I don't think I will find the solitude to
implement this "Apple" approach in the next few weeks.

> > So the plan for sunxi would be: <SUNXI_PINMUX(PORTC, 23, MUX_1)>, ...
> > And this would not be really "opaque", since it has a fixed known mappi=
ng:
> >         (port << 16) | (pin << 8) | (mux << 0))
> > I find this both technically elegant, because it combines all the
> > information into just one compact cell, but also readable by outsiders,
> > thanks to the macro. =20
>=20
> And a new standard, to add to the other standards, so that
> is my problem as maintainer. It makes sense on its own, and it
> complicates the bigger picture.

I see your point - xkcd 927.

> > My main arguments against the current (string-based) approach:
> > - They require the mapping table to be in every DT user, so not only the
> >   Linux kernel, but also U-Boot, FreeBSD, you name it... =20
>=20
> That's true.
>=20
> This comes from the DT ambition to describe hardware and config,
> but not *define* hardware, i.e. to stop device tree to turn into
> Verilog or SystemC, which is what will happen if we take the
> 1:1 reflection of hardware to device tree too far.
>=20
> I don't think anyone really knows where to cut the line.

That's true, and I learned to step back from this ambition - it's
tempting, but indeed out of scope.
One thing to consider, though: the function names are effectively part of
the binding, since they must match exactly between the driver and DT - it's
not just a name. But they are documented nowhere. Names like "i2c0" or
"uart2" seem obvious, but there are ambiguities like "twi" vs "i2c" (the
former used in the vendor BSP), or "owa" vs "spdif" (same situation).
Also, is it "emac" or "emac0"? For some SoCs we discover a second
interface later: A523 just exposes one EMAC, but the A527 package (same
die) provides the pins for the second MAC as well. So I am afraid strings
are not as unique or straight-forward as we hope for.

So for creating a new pingroup, an application engineer would need to
check the Linux driver (or U-Boot? Or FreeBSD?) for the name to use - that
sounds somewhat wrong to me.
In the new model they just create a unique function name and enter the
pinmux from the datasheet - I think that's not too much to ask?

> > - The tables are getting quite large, and they pollute the single image
> >   Linux kernel, with tons of very specific information for a number of =
very
> >   pitiful Allwinner SoCs. At the moment the tally is at 145KB of code+d=
ata
> >   for the existing arm64 SoCs, with the newer SoCs ever growing (H616 a=
lone
> >   is 27KB, A523 would be quite larger even, I guess 40K). The new A523
> >   specific pinctrl support adds 872 Bytes. =20
>=20
> This is a generic problem though, look at GPU drivers.

Yes, but for GPUs there is good rationale (because they are big
complicated pieces of hardware), and they are easily put into modules.
Pinctrl on the other hand is essential for *any* device to come up
(UART!), so having them in the image makes things much easier. Also
Allwinner pinctrl devices are not nearly as sexy as a Radeon or Geforce ;-)

> The community (especially Android) seem set on fixing this by using
> modules.
>=20
> > - Most of the mappings are untested at pinctrl driver commit time, sinc=
e we
> >   don't have the device drivers ready yet - by a margin. The new approa=
ch
> >   would add the pinmux values when we need them and can test them. =20
>=20
> I like this argument the best.
>=20
> However this also reads "upfront firmware to handle pin control is a
> dead end" yet there are people dedicatedly working on exactly that.
> (Not that its' the Allwinner developers' problem...)

I see, but I feel it's an orthogonal problem, and relies on the a
pessimistic firmware view (see above).
Having those gory SoC specific details in firmware (which is by
definition device specific) solves one big problem, though: there is a
chance that existing kernels would already run on new SoCs/boards.
But again: different discussion thread, I guess, and not what I ask for.

> > - The comments in the table give away that something is not quite right:
> >                   SUNXI_FUNCTION(0x2, "i2c0")),         /* SDA */
> >   This is just a comment, so has no relevance for the code, but it's not
> >   meant for humans either. Yet we try to make this correct and maintain
> >   it. Odd. =20
>=20
> So i2c0 is SDA and i2c1 is SCL or something?

No, sorry, I cut out too much, it looks like this:

	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 5),
		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SCK */
		...
        SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 6),
		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SDA */
		...
        SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 7),
		  SUNXI_FUNCTION(0x5, "i2c1"),		/* SCK */
		...
        SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 8),
		  SUNXI_FUNCTION(0x5, "i2c1"),		/* SDA */

So the function just selects the group, and the actual pin name is
completely irrelevant to the software side - hence the comment.
But this "put something not meant for the human reader into a comment"
typically points to something not being quite right.

Cheers,
Andre

