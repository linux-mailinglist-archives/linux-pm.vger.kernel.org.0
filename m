Return-Path: <linux-pm+bounces-20533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5A0A136B1
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 10:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C503A6F4E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61361D90AE;
	Thu, 16 Jan 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIZYhpoy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6401D90D9
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020081; cv=none; b=MQJ+yZsr50/bmlJ3v+U7Wf02EaF62kQWW3ZnBbe6kb4f8dqV/IHW1hyAyACmt0o3RDqcyYK4UbPPaYeWe2hGrjezEeHqfPaVOM80/DQOkFvr2BSNaC2hmXweblFGP/0zTxxO1iq6uyB+f/5NpeT00856XA8zvLhFkJuUQF47lcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020081; c=relaxed/simple;
	bh=YEFnAUMYl5nnOAtLb2J3ooxYMbpShUopFJE8cj2v+Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r36UzveYJogBeaQcNNubWLpz96LCWO/meUZOc9dfpXES4saCmN1cfSQ8irqCYkeg0uBXi7qvdqSU8Nnauz1bi2ro19ze5VKyt4fXEA6TfJg9ZHjvWYTDh7txY6SWPqw0dZUts7KjMda5rAAOzaZv7O8d021Z/pCmWuzE97Gq8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jIZYhpoy; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30227ccf803so6604171fa.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 01:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737020078; x=1737624878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDEoo08UzquHfpbAFyPJ/ZCgHJCQZd+B5Sb7kOuUYkM=;
        b=jIZYhpoy+DFFNrjb8qjYVs9Cq/Z5nA++uPbf2PRbHH1UTllQIBbFbyovyhbCxQ1vD8
         UaVhfrB/h5cUoHPjA48Bx1d0/nsfaebo9wvdJTOpRcj0Fd3ZPfjHqufSI7oeyXwtJH5n
         +sWzFiQGsbYnOFbK1TuZTZXEvKWJp5LP99pJRThETQdKOPCmeKHeVXU3h+LnR6wQEUMP
         /McBASunyEAX5U62MiK9DVzG2paObZF4tRatJ33P2T+Q6AY0XdNokr6MY69BygF9wvA5
         mSgFCto0REWHJVmzPHRQN2RJ5dYPC17vjU1Mu1uBg2s6eT5jcDLf+Jl+ukj0FyBkXJMH
         ihAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737020078; x=1737624878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDEoo08UzquHfpbAFyPJ/ZCgHJCQZd+B5Sb7kOuUYkM=;
        b=fD14uFqTNomIvQDKZn/OHL/ycZv8f1herr6bOPvta9wTYlu39GD/wbRDrpGn8sxswd
         M+BlNQXhnikHSEygpOH0tcoQ1oH6xuZGn7elTX1nd/WwDY6BfmUNpExsSa+BHbfAFEGD
         L8auHwdTq0Le2Xmbo7JxmlqM+H206vrxUhp7iD/zUVggJsCdOQiEureamp9IY+n6aIVD
         S8x7ZPNRIWEzzy+TWEScY3Ixqnj30cUBM4PFzLUblDez/4eq8yHdRAY+fBdKs20HMCDb
         kKn3eBjXtRJQ7gwEA8LAVgcePBMF6L+2xdFhxHbl23sUhOUYPikGbww/SR7n81RWrwi5
         jU4g==
X-Forwarded-Encrypted: i=1; AJvYcCX7QG6mCkQBSbq4Fq3tAIGorrgB1nVh28XCD7rCLf6gjlAFAMeLVxopIAzUjBUMW9DKxm2PGoQCxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUjIfLdhuqR/OYFS0G05Qlk8S0319daPMe9KYSUN68NCG/bDJ
	3tYi+FDFMcktlaRlhwUy5tcSRhzh7vAlpE1IkeV9DQcuyh616y+d/wdh48J40YMq0GbksPmgdrK
	NB1IbuMd7z4LXcYXl6sywyLkpMCrNrorJ9LA1WQ==
X-Gm-Gg: ASbGncvUAdMZStgOuo8B3wj3JQBC76fSDz/MT5anBxqSnHUAtU4tZeXs3jhRIssOYit
	PbDDfWveA4O2ppYizer4mPY4mzP4AoSwXIqys
X-Google-Smtp-Source: AGHT+IEvxOVujRx8L7nmAm14+W+J9iR9tC3itop2isDuY+VzNKk3E+BY5vasl+NH5yxy4xJbTTxIO6CFjEvK/kGunk4=
X-Received: by 2002:a05:651c:2222:b0:300:38ff:f8e2 with SMTP id
 38308e7fff4ca-305f453f9d5mr108573981fa.10.1737020077607; Thu, 16 Jan 2025
 01:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-4-szemzo.andras@gmail.com> <20250114141954.2785879a@donnerap.manchester.arm.com>
 <CACRpkda0nx3SQtdjmXdCEbVJSWM10TM=p-6JbDjbiYcOSF5PxQ@mail.gmail.com> <20250115152635.1b89e7f4@donnerap.manchester.arm.com>
In-Reply-To: <20250115152635.1b89e7f4@donnerap.manchester.arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jan 2025 10:34:26 +0100
X-Gm-Features: AbW1kvbBkCN9uFhss2v8p9gI5MNXxz-I4EOdo9aGVELtvFSbQyk_EVu2ddxSQ7s
Message-ID: <CACRpkdYVTedEon0X-izvaDTGF6yRhD2s=Z6NEM=zBf4vD-T0Pg@mail.gmail.com>
Subject: Re: [PATCH 03/12] pinctrl: sunxi: add driver for Allwinner V853.
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andras Szemzo <szemzo.andras@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andre,

some nice talk here, actually the following is just opinions, I will
be likely happy with whatever approach is taken eventually.

On Wed, Jan 15, 2025 at 4:26=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:

> > pio: pinctrl@1c20800 {
> >                         compatible =3D "allwinner,sun8i-r40-pinctrl";
> > (...)
> >                         i2c0_pins: i2c0-pins {
> >                                 pins =3D "PB0", "PB1";
> >                                 function =3D "i2c0";
> >                         };
> >
> > abstract, strings, nice. The driver handles the particulars.
>
> What bugs me about this it that this has quite some seemingly redundant
> information (Who would have thought that the i2c0 pins use function
> "i2c0"?), but misses out on the actual 4 bits(!) of information.

the pins in this example are called PB0 and PB1 though. The designation
on the package. And often pins actually named "i2c0_1" "i2c0_2" are
for that primary function, but muxable to a few other functions,
at least GPIO in most cases. So it's just some name for the pin
really.

> > That is like so because we are designing for users which are
> > let's say customization engineers. If these engineers jump from
> > project to project matching function strings to group strings will
> > be a common way to set up pins, and easy to understand and
> > grasp, and it makes the DTS very readable.
>
> That's an interesting view, and I see the point of it being easy to read,
> but this is partly because it doesn't convey too much actual information,
> does it, as it requires another lookup or two.
> And the pinctrl group nodes are actually in the .dtsi file, which are
> typically written once during the initial SoC enablement, and new board
> .dts files normally just reference the existing pingroup nodes. So anyone
> dealing with just a new board is not bothered by this.

You have a point, and when working with a system the application
engineer often finds bugs in the pin control driver, and has to go
and fix the actual driver and then all the information hiding and
simplification is moot.

This can become an expensive lesson for the current attempts
to push pin control into firmware where the configuration is
mostly "dead simple" (and just using strings) - the bugs will be
in the firmware instead, and impossible or really hard to fix.

> Also in my experience most people have no problems in understanding the
> concept of pinmuxing and that there is a selector number, also where to
> find this.

Yeah the ambition with the strings was to avoid forcing application
engineers to know all about that. If they do, they are then
developing the driver, not just using it.

> > Mediatek and STM32 made a compromise by using pinmux
> > and adding some macros to define them so it looks more
> > pleasant:
> >
> >       i2c0_pins_a: i2c0-default {
> >                 pins-i2c0 {
> >                         pinmux =3D <MT7623_PIN_75_SDA0_FUNC_SDA0>,
> >                                  <MT7623_PIN_76_SCL0_FUNC_SCL0>;
>
> Well, I don't really get why they don't use the (MTK_PIN_NO(75) | 1)
> definition directly, seems to be more telling to me?

That's what STM32 does as well and it's usable.

But of course it drives a truck through the initial ambition that pins
on all systems be configured the same way, with strings. So now
there are some families of drivers all "necessarily different" which
is not so nice for people jumping between different SoCs, but
very compelling for people focusing on just one SoC.

Well, unless this way of doing things becomes so prevalent that
it's the new black.

> So the plan for sunxi would be: <SUNXI_PINMUX(PORTC, 23, MUX_1)>, ...
> And this would not be really "opaque", since it has a fixed known mapping=
:
>         (port << 16) | (pin << 8) | (mux << 0))
> I find this both technically elegant, because it combines all the
> information into just one compact cell, but also readable by outsiders,
> thanks to the macro.

And a new standard, to add to the other standards, so that
is my problem as maintainer. It makes sense on its own, and it
complicates the bigger picture.

> My main arguments against the current (string-based) approach:
> - They require the mapping table to be in every DT user, so not only the
>   Linux kernel, but also U-Boot, FreeBSD, you name it...

That's true.

This comes from the DT ambition to describe hardware and config,
but not *define* hardware, i.e. to stop device tree to turn into
Verilog or SystemC, which is what will happen if we take the
1:1 reflection of hardware to device tree too far.

I don't think anyone really knows where to cut the line.

> - The tables are getting quite large, and they pollute the single image
>   Linux kernel, with tons of very specific information for a number of ve=
ry
>   pitiful Allwinner SoCs. At the moment the tally is at 145KB of code+dat=
a
>   for the existing arm64 SoCs, with the newer SoCs ever growing (H616 alo=
ne
>   is 27KB, A523 would be quite larger even, I guess 40K). The new A523
>   specific pinctrl support adds 872 Bytes.

This is a generic problem though, look at GPU drivers.

The community (especially Android) seem set on fixing this by using
modules.

> - Most of the mappings are untested at pinctrl driver commit time, since =
we
>   don't have the device drivers ready yet - by a margin. The new approach
>   would add the pinmux values when we need them and can test them.

I like this argument the best.

However this also reads "upfront firmware to handle pin control is a
dead end" yet there are people dedicatedly working on exactly that.
(Not that its' the Allwinner developers' problem...)

> - The comments in the table give away that something is not quite right:
>                   SUNXI_FUNCTION(0x2, "i2c0")),         /* SDA */
>   This is just a comment, so has no relevance for the code, but it's not
>   meant for humans either. Yet we try to make this correct and maintain
>   it. Odd.

So i2c0 is SDA and i2c1 is SCL or something?
It seems common, but yeah it can be confusing.

Yours,
Linus Walleij

