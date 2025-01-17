Return-Path: <linux-pm+bounces-20634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C5A15305
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 16:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3611889A68
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C181419ADA4;
	Fri, 17 Jan 2025 15:43:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87331714D0;
	Fri, 17 Jan 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128604; cv=none; b=gRh0wq1FYYlxwmdjx998MYK2G+9DXs81xAYGfPBmQ/cxoCkAeIjk1hNcrT4o6G8/AbxJd99jKnjSVbzxCLkjJpj4NgMm5YvZwqJOL8c+j41UYNkjonIe5QrLUade4BkQib9BICLnfj4HyL+6ZNmqKU4y8vRNGGoUmT/Ik4qDGwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128604; c=relaxed/simple;
	bh=diVDJTYn1VVxEIzS+6ZugT9gK4hpBvjWk2xOKJug5a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XH4S8YDZ4GQNabtPnimOJ8tyEI53Tz3FV+ksCqDjSyqOsDbXwrhhiV5Zk0ylc3IopOjAA/r510R+p+zAkioGTmjFBXsfpfUt2F9m5zixui3Ibih8lm9SpJZNM3CeKm9tsxWuysHi2aarVwBxVjmVkn8QFJjd8+YxODHtuXDs3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53f757134cdso2272289e87.2;
        Fri, 17 Jan 2025 07:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737128599; x=1737733399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2N+AWy70jywn4CRmdsXKEKKnKrL7LoujnGhrXs380U=;
        b=v4f7M/mHzG4CL5VP9F1F60A9+N9Deb0XthLSNhTL+bgZABS1weOVcuPhtkn+5yjXVW
         3YEiBl+20PzAgMgngghZX8eYMtBQKry8QnmRQ6ybbJlDdOA2HyLzOb54Rf9RQpssJ0e+
         fHteHraTi1sZ2TfNz4TSEy5zUa2In0nCQMDmHGi9TmFarU/mqIFhRgukxE+uNJIoZFOg
         G4W2fpMA2ec23B/zL18Y8p2wrGvA57raUEvl5IJOE1+DHJ4WleAuKaLfxBCBhlUpj4xe
         G3bzNpC0xJ4ShIU7bIxZmN80KgAPMoYOBp8hrpZ0xzb4MEKYfWZit8L6x9ZDhURX4D5k
         DClA==
X-Forwarded-Encrypted: i=1; AJvYcCUtXIOhlhltqf1Oi6SN1VLDjd1Ob1N5rxqM1QCYF0zPLvdpxIVwWrU70Ipp4N7DJDlf8V+eVOquoJVy@vger.kernel.org, AJvYcCVbxvVysUzADL/Ok2UAR0HQK4lwqRgSuk0rqjjOeIhDBzp0KE/i2qWeKePnjgCCJ6zg1K8k0pUd0Mo=@vger.kernel.org, AJvYcCWHRaA5Ol/mttZwj+hzjRPEfbHWQ7P+vv79b+HzYhinwey1P6ek3eeJwsmQ7FUB1DWwjg1AUCv++a4xsg==@vger.kernel.org, AJvYcCWlAET/TQPvNfajHBoyEJXVUCnCk3SJAhJ+niSXYMa91mGe9df5EjXNfKTeyt1+WvPY0dNc4k1Q60SW@vger.kernel.org, AJvYcCXcO3Fx7uJbXquu7oIu8mM+QonZz6duzkwV3UW6yuNrnodz7y8wdeNKlqTL2qv+LDUXm77NIWjt47qXDKLR@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVDDyP3IL64NnEUXhUGS3/IEJveh0NNfBbAmaS6AccZ+QtwdO
	ilQZFk9sDALhzx22AwCi3qlVWHq3O+cw0cgBpJsE2br7qQlBALwFGhR8Pj7m
X-Gm-Gg: ASbGnctgZTF6xOiXC0ks+Y/CuGtee2nZBu58QRLD7cMiAmE+KLitxP+maIQjKbmmlsS
	OKFCosS/WpCQTxYk+VRiBUgXyJc30Dq+ywLKIAT9gy0SGLIO9pdByB/tjMylAr26HyFvymx7zfJ
	bnzcSgOxcW1aSTKU0znYp6hWAMzBqPjB1Ywmp/2F3KnbrPkU+Pg78kwVasMDtZlRxeVMZMSunUH
	lboo0IiYl4bLGlzOQB/Y0jh8RZMjEgjYENMugLoUU93NLkgsht1PV3zCkARJJj7FjY4bRiKAnNR
	Qsd9RJZBXXAi4Q==
X-Google-Smtp-Source: AGHT+IHvet8QBclfRRC43ZI8zq7VauYdw8ALXG5svVg9olwvAipZr0lc5joyvUZl02xfI9DqUu62xA==
X-Received: by 2002:a05:6512:1084:b0:542:29b6:9c26 with SMTP id 2adb3069b0e04-5439c27d0c5mr1181858e87.47.1737128598796;
        Fri, 17 Jan 2025 07:43:18 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af79d92sm398724e87.258.2025.01.17.07.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 07:43:17 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3003d7ca01cso23032151fa.0;
        Fri, 17 Jan 2025 07:43:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuQw9mQ7S/lD+wl0SGVtK3JqkVvTOpnRGRv5WUx8svNdUPytYL9hc13rkS8xydVOjn9fDqU0OjS3zO@vger.kernel.org, AJvYcCV8gzDlr9dGd9qd5mojxz2Ts5D+ul9qqGA82yKkHxNVvU8hvKqqES84eJkIV9/bGJ/XF6Ap6Vl9tPedU4xV@vger.kernel.org, AJvYcCWwbnKKUBM8bfYeMo5Cw9gnSTXhEbWsF3bA5weivUTQljKL+1x4rmh9ujPCFxYgj5QR6BFp20QckD/v3A==@vger.kernel.org, AJvYcCXcMwrWdtQ5n9CC32KPj5OoVZZnFIXt6ddNjvIX80WqEoCKZ43pcTXa5gvX8co/WXz9tLUHUkbLG8mV@vger.kernel.org, AJvYcCXfMPe0Plk343NFrv6TyNieD25vsCx7FcCauc0wyzc9t+7mBka2d4y7jBBfepHDCQ40xIB/FJ88s0s=@vger.kernel.org
X-Received: by 2002:a05:651c:2c7:b0:2fb:58b1:3731 with SMTP id
 38308e7fff4ca-3072ca60bd0mr8406481fa.6.1737128597473; Fri, 17 Jan 2025
 07:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-4-szemzo.andras@gmail.com> <20250114141954.2785879a@donnerap.manchester.arm.com>
 <CACRpkda0nx3SQtdjmXdCEbVJSWM10TM=p-6JbDjbiYcOSF5PxQ@mail.gmail.com>
 <20250115152635.1b89e7f4@donnerap.manchester.arm.com> <CACRpkdYVTedEon0X-izvaDTGF6yRhD2s=Z6NEM=zBf4vD-T0Pg@mail.gmail.com>
In-Reply-To: <CACRpkdYVTedEon0X-izvaDTGF6yRhD2s=Z6NEM=zBf4vD-T0Pg@mail.gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 17 Jan 2025 23:43:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v64sNfytUPbyBFjiZCU+jLkXOH1r9iH=Z_E0PjwVxkMCWg@mail.gmail.com>
X-Gm-Features: AbW1kvbzoziWjm4-jxBgu7nAEK51uWx6aYENBjR409HEBu5PP3az-MNoew5mtV4
Message-ID: <CAGb2v64sNfytUPbyBFjiZCU+jLkXOH1r9iH=Z_E0PjwVxkMCWg@mail.gmail.com>
Subject: Re: [PATCH 03/12] pinctrl: sunxi: add driver for Allwinner V853.
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Andras Szemzo <szemzo.andras@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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

On Thu, Jan 16, 2025 at 5:34=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> Hi Andre,
>
> some nice talk here, actually the following is just opinions, I will
> be likely happy with whatever approach is taken eventually.
>
> On Wed, Jan 15, 2025 at 4:26=E2=80=AFPM Andre Przywara <andre.przywara@ar=
m.com> wrote:
>
> > > pio: pinctrl@1c20800 {
> > >                         compatible =3D "allwinner,sun8i-r40-pinctrl";
> > > (...)
> > >                         i2c0_pins: i2c0-pins {
> > >                                 pins =3D "PB0", "PB1";
> > >                                 function =3D "i2c0";
> > >                         };
> > >
> > > abstract, strings, nice. The driver handles the particulars.
> >
> > What bugs me about this it that this has quite some seemingly redundant
> > information (Who would have thought that the i2c0 pins use function
> > "i2c0"?), but misses out on the actual 4 bits(!) of information.
>
> the pins in this example are called PB0 and PB1 though. The designation
> on the package. And often pins actually named "i2c0_1" "i2c0_2" are
> for that primary function, but muxable to a few other functions,
> at least GPIO in most cases. So it's just some name for the pin
> really.

No. Allwinner actually names their pins like this, kind of like Rockchip
which provides standardized names such as "GPIO0_B2", but unlike MediaTek
which just names the pins after their designated primary function such as
"EINT22" or "TDM_BCLK". The ball names are a separate thing.

Even though the pin names seem a bit random, there's actually a grouping
logic underneath:

- PC pins are always for the bootable internal storage (NAND, SPI-NOR, eMMC=
)
- PF pins are always the external SD card / debug UART / JTAG

> > > That is like so because we are designing for users which are
> > > let's say customization engineers. If these engineers jump from
> > > project to project matching function strings to group strings will
> > > be a common way to set up pins, and easy to understand and
> > > grasp, and it makes the DTS very readable.
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
> > dealing with just a new board is not bothered by this.
>
> You have a point, and when working with a system the application
> engineer often finds bugs in the pin control driver, and has to go
> and fix the actual driver and then all the information hiding and
> simplification is moot.
>
> This can become an expensive lesson for the current attempts
> to push pin control into firmware where the configuration is
> mostly "dead simple" (and just using strings) - the bugs will be
> in the firmware instead, and impossible or really hard to fix.
>
> > Also in my experience most people have no problems in understanding the
> > concept of pinmuxing and that there is a selector number, also where to
> > find this.
>
> Yeah the ambition with the strings was to avoid forcing application
> engineers to know all about that. If they do, they are then
> developing the driver, not just using it.
>
> > > Mediatek and STM32 made a compromise by using pinmux
> > > and adding some macros to define them so it looks more
> > > pleasant:
> > >
> > >       i2c0_pins_a: i2c0-default {
> > >                 pins-i2c0 {
> > >                         pinmux =3D <MT7623_PIN_75_SDA0_FUNC_SDA0>,
> > >                                  <MT7623_PIN_76_SCL0_FUNC_SCL0>;
> >
> > Well, I don't really get why they don't use the (MTK_PIN_NO(75) | 1)
> > definition directly, seems to be more telling to me?
>
> That's what STM32 does as well and it's usable.
>
> But of course it drives a truck through the initial ambition that pins
> on all systems be configured the same way, with strings. So now
> there are some families of drivers all "necessarily different" which
> is not so nice for people jumping between different SoCs, but
> very compelling for people focusing on just one SoC.
>
> Well, unless this way of doing things becomes so prevalent that
> it's the new black.
>
> > So the plan for sunxi would be: <SUNXI_PINMUX(PORTC, 23, MUX_1)>, ...
> > And this would not be really "opaque", since it has a fixed known mappi=
ng:
> >         (port << 16) | (pin << 8) | (mux << 0))
> > I find this both technically elegant, because it combines all the
> > information into just one compact cell, but also readable by outsiders,
> > thanks to the macro.
>
> And a new standard, to add to the other standards, so that
> is my problem as maintainer. It makes sense on its own, and it
> complicates the bigger picture.
>
> > My main arguments against the current (string-based) approach:
> > - They require the mapping table to be in every DT user, so not only th=
e
> >   Linux kernel, but also U-Boot, FreeBSD, you name it...
>
> That's true.
>
> This comes from the DT ambition to describe hardware and config,
> but not *define* hardware, i.e. to stop device tree to turn into
> Verilog or SystemC, which is what will happen if we take the
> 1:1 reflection of hardware to device tree too far.
>
> I don't think anyone really knows where to cut the line.
>
> > - The tables are getting quite large, and they pollute the single image
> >   Linux kernel, with tons of very specific information for a number of =
very
> >   pitiful Allwinner SoCs. At the moment the tally is at 145KB of code+d=
ata
> >   for the existing arm64 SoCs, with the newer SoCs ever growing (H616 a=
lone
> >   is 27KB, A523 would be quite larger even, I guess 40K). The new A523
> >   specific pinctrl support adds 872 Bytes.
>
> This is a generic problem though, look at GPU drivers.
>
> The community (especially Android) seem set on fixing this by using
> modules.
>
> > - Most of the mappings are untested at pinctrl driver commit time, sinc=
e we
> >   don't have the device drivers ready yet - by a margin. The new approa=
ch
> >   would add the pinmux values when we need them and can test them.
>
> I like this argument the best.
>
> However this also reads "upfront firmware to handle pin control is a
> dead end" yet there are people dedicatedly working on exactly that.
> (Not that its' the Allwinner developers' problem...)
>
> > - The comments in the table give away that something is not quite right=
:
> >                   SUNXI_FUNCTION(0x2, "i2c0")),         /* SDA */
> >   This is just a comment, so has no relevance for the code, but it's no=
t
> >   meant for humans either. Yet we try to make this correct and maintain
> >   it. Odd.
>
> So i2c0 is SDA and i2c1 is SCL or something?
> It seems common, but yeah it can be confusing.

No. i2c0 is the actual peripheral that gets muxed in. The SDA / SCL
comments are simply denoting which signal from the peripheral this
pin & mux value carry.

