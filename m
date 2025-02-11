Return-Path: <linux-pm+bounces-21894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39E1A3174C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB981889400
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3904E265CB1;
	Tue, 11 Feb 2025 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ+4Fr4o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9F2641E8;
	Tue, 11 Feb 2025 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308098; cv=none; b=J6A8JfIEkoZyVpwHDHvkmzm8xan06Noh37rreduxxfBozP2L072U+9vkDJgCZY6MUwH5Qob5KjDtb3bSEngI13MC6i0aiEZzecCh0ceyNnHWKYY0XH+AfZ7N3s2o243/aT+Xkab1L3msaMdwBqJrjDOYKuOWMA19LvTOjIlLZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308098; c=relaxed/simple;
	bh=bGAOKA1MkNL81iEciQ/YaP9238hsjmHj0yVs2PHuZjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzQNReQMe7hgX1Pl9QJjtdCKFV6XP2MQbcfTIh85sllnI/a3HZDKso2T1uUaWmxAq2G40dte0cueJkng8zoHNXrRCldyurphOSag67sunN/Lx3O5azXHRbc62P/f4uY8h0CjW2f6kzwSyFMmFmtTE/xVg5tNabyv72oZOsjf9PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ+4Fr4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26979C4CEE2;
	Tue, 11 Feb 2025 21:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739308095;
	bh=bGAOKA1MkNL81iEciQ/YaP9238hsjmHj0yVs2PHuZjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQ+4Fr4obzotuKZeY0/kEEylnLtsOD6qn4FsTE6130dX+MJjMj/w+e8PP+Rimq72C
	 TrSDrPoODZpQ0mWRSCDfuz5DIEnbG4cxoY5xlGdm+mXlMGfSE1wUUT/m3Jspj+9rrA
	 G81fXqid9RUh9II6oOuWG9CkvC3Lbz3ogvPg7KAEakKMpacaZBCIQWesFL8M9BTx6U
	 Zbzo+M49Pq+rEzRVuGgmkNbc7Ew8iY78IZleQNZb3B+N5X07Yyb4F1putZOT+qAPRP
	 5y1Ze4HTH/9MfNe8uOxWCKn4VxNHAhJ+YFRaj67QNEb3ULeJzPFkuvAsj7C99etlv+
	 6Sy+bxDDNG+AA==
Date: Tue, 11 Feb 2025 15:08:14 -0600
From: Rob Herring <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andras Szemzo <szemzo.andras@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 09/10] ARM: dts: sun8i: add DTSI file for V853
Message-ID: <20250211210814.GB1172102-robh@kernel.org>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
 <20250205125225.1152849-10-szemzo.andras@gmail.com>
 <20250206161958.1ae885db@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206161958.1ae885db@donnerap.manchester.arm.com>

On Thu, Feb 06, 2025 at 04:19:58PM +0000, Andre Przywara wrote:
> On Wed,  5 Feb 2025 13:52:24 +0100
> Andras Szemzo <szemzo.andras@gmail.com> wrote:
> 
> Hi,
> 
> > V853/V851 is a new SoC by Allwinner. Add a basic dtsi file for it.
> > 
> > Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
> > ---
> >  arch/arm/boot/dts/allwinner/sun8i-v853.dtsi | 656 ++++++++++++++++++++
> >  1 file changed, 656 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/allwinner/sun8i-v853.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/allwinner/sun8i-v853.dtsi b/arch/arm/boot/dts/allwinner/sun8i-v853.dtsi
> > new file mode 100644
> > index 000000000000..8b82b8783127
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/allwinner/sun8i-v853.dtsi
> > @@ -0,0 +1,656 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> > +// Copyright (C) 2024 Andras Szemzo <szemzo.andras@gmail.com>
> > +
> > +#include <dt-bindings/clock/sun6i-rtc.h>
> > +#include <dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h>
> > +#include <dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h>
> > +#include <dt-bindings/clock/allwinner,sun8i-v853-ccu.h>
> > +#include <dt-bindings/reset/allwinner,sun8i-v853-ccu.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/power/allwinner,sun8i-v853-ppu.h>
> > +
> > +/ {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	dcxo: dcxo-clk {
> 
> What's people's opinion about the node name? Traditionally we call this
> "osc24M", in all the other SoCs except D1 and A100. So is this the new
> black?

That's documented (but not enforced) in fixed-clock.yaml now. It's 
"clock-<freq-in-hz>".

Rob

