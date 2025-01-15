Return-Path: <linux-pm+bounces-20492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20300A12763
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 16:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E522162954
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0AA15535B;
	Wed, 15 Jan 2025 15:26:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9B145B2E;
	Wed, 15 Jan 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954812; cv=none; b=pGNLCXTN7TOpICSKl4Wpjtfa/kAzYPVg/3q4LgQAG3/t8Z3IInSKFt/AFEFB1FbGxX0t7+pXWFkGTdYh82AjQWxQDJc7OZRyLBZTH0qPia6gXYnM9fz6yg6Oc109Hi1E2HF63CuGIXqIG9HmT09a+HfgDsTAEUYZl/iFgtpcc/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954812; c=relaxed/simple;
	bh=JBcCp53Gsobb/CU+JgBt3NsWKZtsmKsbDhO8bGTGg5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpetO5zbJqroMhWZa8321nN6dui2SY81VEnYb+y2qrp/Yj4aLvFSYequOi4wA/Zkj7Pm8frkgbjqzfsnC1XleioOdzGuCS4kL7BtYunPoqD3dAbebjh7UmxLUIj/rWoH6geELyuuqA8sNTVUJj6Kswu7gDYzRZU9mSXPZ445O8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE6FF11FB;
	Wed, 15 Jan 2025 07:27:11 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FF323F73F;
	Wed, 15 Jan 2025 07:26:39 -0800 (PST)
Date: Wed, 15 Jan 2025 15:26:35 +0000
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
Message-ID: <20250115152635.1b89e7f4@donnerap.manchester.arm.com>
In-Reply-To: <CACRpkda0nx3SQtdjmXdCEbVJSWM10TM=p-6JbDjbiYcOSF5PxQ@mail.gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
	<20250110123923.270626-4-szemzo.andras@gmail.com>
	<20250114141954.2785879a@donnerap.manchester.arm.com>
	<CACRpkda0nx3SQtdjmXdCEbVJSWM10TM=p-6JbDjbiYcOSF5PxQ@mail.gmail.com>
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

On Wed, 15 Jan 2025 11:23:50 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

Hi Linus,

thanks for the reply, I was hoping to get some insight and discuss this!

> On Tue, Jan 14, 2025 at 3:20=E2=80=AFPM Andre Przywara <andre.przywara@ar=
m.com> wrote:
> > Andras Szemzo <szemzo.andras@gmail.com> wrote: =20
>=20
> > > The V853 family has multiple package variants, from BGA to QFN88.
> > > The latter has co-packaged DRAM and fewer pins, and less features (pi=
n muxes).
> > > All family members can be supported by a single driver, as the availa=
ble pins
> > > with allowed muxes is the same across the devices. =20
> >
> > It depends a bit on the outcome of the discussion on the A523 pinctrl
> > driver [1], but I think we should use the same approach here (and for
> > every "new" Allwinner SoC coming up, really): put the pinmux value in t=
he
> > DT, and get rid of this entire table altogether:
> > [1]
> >
> > The SoC specific pinctrl driver would then be very small ([2]), so this
> > pinctrl support patch here would actually become much smaller.
> >
> > Just feel a bit sorry for you having created this table, in a tedious a=
nd
> > eye-straining exercise - been there, done that ;-) =20
>=20
> It's pretty stressful for the pin control maintainer as well.
>=20
> From the subsystems point of view, groups matches to functions by
> strings is the best. ("fun1") + ("group1", "group2"):
>=20
> pio: pinctrl@1c20800 {
>                         compatible =3D "allwinner,sun8i-r40-pinctrl";
> (...)
>                         i2c0_pins: i2c0-pins {
>                                 pins =3D "PB0", "PB1";
>                                 function =3D "i2c0";
>                         };
>=20
> abstract, strings, nice. The driver handles the particulars.

What bugs me about this it that this has quite some seemingly redundant
information (Who would have thought that the i2c0 pins use function
"i2c0"?), but misses out on the actual 4 bits(!) of information.
So the A523 version [1] just *adds* this one property:
		allwinner,pinmux =3D <2>;

[1]https://lore.kernel.org/linux-sunxi/20241111005750.13071-5-andre.przywar=
a@arm.com/

And we keep all your beloved strings ;-)

> That is like so because we are designing for users which are
> let's say customization engineers. If these engineers jump from
> project to project matching function strings to group strings will
> be a common way to set up pins, and easy to understand and
> grasp, and it makes the DTS very readable.

That's an interesting view, and I see the point of it being easy to read,
but this is partly because it doesn't convey too much actual information,
does it, as it requires another lookup or two.
And the pinctrl group nodes are actually in the .dtsi file, which are
typically written once during the initial SoC enablement, and new board
.dts files normally just reference the existing pingroup nodes. So anyone
dealing with just a new board is not bothered by this.
Also in my experience most people have no problems in understanding the
concept of pinmuxing and that there is a selector number, also where to
find this.

> Then there are the engineers creating the pin control drivers,
> and they want everything to be convinient for *them*, and they
> think an opaque hex digit in the DTS is perfect at times, thus
> pinmux =3D <0xdeadbeef>;
>=20
> Mediatek and STM32 made a compromise by using pinmux
> and adding some macros to define them so it looks more
> pleasant:
>=20
>       i2c0_pins_a: i2c0-default {
>                 pins-i2c0 {
>                         pinmux =3D <MT7623_PIN_75_SDA0_FUNC_SDA0>,
>                                  <MT7623_PIN_76_SCL0_FUNC_SCL0>;

Well, I don't really get why they don't use the (MTK_PIN_NO(75) | 1)
definition directly, seems to be more telling to me?
So the plan for sunxi would be: <SUNXI_PINMUX(PORTC, 23, MUX_1)>, ...
And this would not be really "opaque", since it has a fixed known mapping:
	(port << 16) | (pin << 8) | (mux << 0))
I find this both technically elegant, because it combines all the
information into just one compact cell, but also readable by outsiders,
thanks to the macro.

But please note that using the generic pinmux is just an idea at this
point, last time I checked this would require significant rework in the
sunxi pinctrl driver.
Just adding the "allwinner,pinmux" property on the other hand is a
comparably easy addition, hence my patch, as a compromise.

>                         bias-disable;
>                 };
>         };
>=20
> At least the bias control is using strings, this is nice.
>=20
> So I'm mostly fine with that as well, but it can be pretty
> heavy on people coming from the outside, asking us questions
> like "on MT7689 how do you mux pin nnnn to function yyy"???
> Well I don't know? Some MT7689_PIN* macro I guess?

MTK_PIN_NO(nnn, yyy)?

> If it was just strings I would know what the
> expected behaviour and looks would be at least, then the driver
> could be buggy or missing things but that's clearly cut. That's
> why I prefer the strings.

My main arguments against the current (string-based) approach:
- They require the mapping table to be in every DT user, so not only the
  Linux kernel, but also U-Boot, FreeBSD, you name it...
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pinctrl/sunxi/pi=
nctrl-sunxi.c?ref_type=3Dheads#L236-768
https://cgit.freebsd.org/src/tree/sys/arm/allwinner/h6/h6_padconf.c
- The tables are getting quite large, and they pollute the single image
  Linux kernel, with tons of very specific information for a number of very
  pitiful Allwinner SoCs. At the moment the tally is at 145KB of code+data
  for the existing arm64 SoCs, with the newer SoCs ever growing (H616 alone
  is 27KB, A523 would be quite larger even, I guess 40K). The new A523
  specific pinctrl support adds 872 Bytes.
- Most of the mappings are untested at pinctrl driver commit time, since we
  don't have the device drivers ready yet - by a margin. The new approach
  would add the pinmux values when we need them and can test them.
- The comments in the table give away that something is not quite right:
                  SUNXI_FUNCTION(0x2, "i2c0")),         /* SDA */
  This is just a comment, so has no relevance for the code, but it's not
  meant for humans either. Yet we try to make this correct and maintain
  it. Odd.

Cheers,
Andre

