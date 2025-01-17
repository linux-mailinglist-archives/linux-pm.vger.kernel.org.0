Return-Path: <linux-pm+bounces-20612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC4CA14DCB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 11:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526A73A3787
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9D41FC7F4;
	Fri, 17 Jan 2025 10:39:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6225C1F91FF;
	Fri, 17 Jan 2025 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110395; cv=none; b=MvacyTsIV0BYd3riVdQft3YOkMZJKRqpnz4jZYRfuHnpJRTZ1cmI4H4gP+a3/IJGTxr7SJGPfu0/57XQhSQqcvrP5G40IYx7HfuUYVYQL56rNLmUM+D7hx8g/Dp5CAsZtwivWCV0pTboOcBJ8GO4TFfYbkP1Xsx47u/PqBHUPZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110395; c=relaxed/simple;
	bh=YXW+x9GgzgdecKu3CzDdV0DGCreYczj3I9qa8OAff9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYhpkpqLJsIEr7ZGrOzHCr4Dcr2h6SacQJwRKgf3fyxKW6S6v94sLKGTf8dJeU+YmeADJ1yuS9bItA66hdLeBKgGmOUn203JHsd3RqnSImG20OhWcSWfHLr7UhET3imYKX8In90o+kcAGUE3/mpEGkMfj6JkuucL0KhkVeGDB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3403D1476;
	Fri, 17 Jan 2025 02:40:21 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D2753F7B4;
	Fri, 17 Jan 2025 02:39:49 -0800 (PST)
Date: Fri, 17 Jan 2025 10:39:41 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Andras Szemzo <szemzo.andras@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Linus
 Walleij <linus.walleij@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Maxime Ripard <mripard@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 10/12] dt-bindings: phy: allwinner: add v853 usb phy
Message-ID: <20250117103941.7f9bda7b@donnerap.manchester.arm.com>
In-Reply-To: <Z4dpFqffMJ31ml2y@vaman>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
	<20250110123923.270626-11-szemzo.andras@gmail.com>
	<Z4dpFqffMJ31ml2y@vaman>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 07:51:50 +0000
Vinod Koul <vkoul@kernel.org> wrote:

> On 10-01-25, 13:39, Andras Szemzo wrote:
> > Document Allwinner v853 USB phy.
> > 
> > Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
> > ---
> >  .../phy/allwinner,sun8i-v853-usb-phy.yaml     | 89 +++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
> > new file mode 100644
> > index 000000000000..773c3f476db8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
> > @@ -0,0 +1,89 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/allwinner,sun8i-v853-usb-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner V853 USB PHY
> > +
> > +maintainers:
> > +  - Chen-Yu Tsai <wens@csie.org>
> > +  - Maxime Ripard <mripard@kernel.org>
> > +
> > +properties:
> > +  "#phy-cells":
> > +    const: 1
> > +
> > +  compatible:
> > +    const:
> > +	- allwinner,sun8i-v853-usb-phy  
> 
> Does this really need a new binding document, if so why... Cant this be
> added to one of the existing docs which driver uses?

The USB-PHY bindings don't differ too much on a first glance, but still
enough in nasty details (number of PHYs supported, number of clocks
required, etc.) to make a joint binding basically unreadable (we tried
that). That's why we opted to have separate bindings.
Now I believe it's worth to look for the closest existing binding, and
just put the compatible in there, in the hope we don't need much else, and
that it still stays readable.

Cheers,
Andre

