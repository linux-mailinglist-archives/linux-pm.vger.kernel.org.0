Return-Path: <linux-pm+bounces-21892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF9A3172A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70023A3764
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB5264F81;
	Tue, 11 Feb 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ1e4HBR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9AB2641E5;
	Tue, 11 Feb 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307859; cv=none; b=CoTDnS5H1Zk4N4vXpSItlTgrz6k5UIoUQMh+FhnJcQ5vrmfOF0988ObSUf9PGSGO2lKYyFlx5HBX1VPRJM0zdg7cEBopr8TYHV0s5HzWLuAyn4UFIjCPGI81vCG4+VmsuRpj0unicJgktytGrtLsVs7oBJ/bHCuR/RFQKd6YJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307859; c=relaxed/simple;
	bh=QBM1KecRIyqwFJKJr5Qa6EXftCFXKvIfRc/X2og4zNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDXoHDY/Got38oHh1PAdVnH5T22zu0N7AMhY6yBdlAe+C/MvefoEzNI9X1EJ20CIwYYYtO33mSu1ZoHpRUTm7EKJ4br4dA73dqWMxcydYQsgV3/Rna+oUSnkuOGjsclkxjv4idw5r7XwoeXs5zbzhOO9PA810tR2Wlvemsxd3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ1e4HBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BC5C4CEDD;
	Tue, 11 Feb 2025 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739307859;
	bh=QBM1KecRIyqwFJKJr5Qa6EXftCFXKvIfRc/X2og4zNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJ1e4HBR4HykvJcDifuZAV8jxb26dyJveTq4z6xAuQl98eFIDF/Fzj/Ai65OpksOx
	 QUCBtM/uoWTrskBIGCgtSKyIFp6yLq2z1IhOzZRQ3aMPDXnX/AbPWXp6IpHagE0j/p
	 2ZpWzK7McjscizTIHAHMBJq0TQd3uXuGgISTx5WUgH3RmB4GAsmw9IOpXq56vgzeTN
	 5xNFdHSdjwxipTAVpG9gZcXkjwnm82a7ZekzpkFn/OxjJsu1KgdZ5md6U+4gNsyneK
	 ugdWWtiuYFFHt8WJy5FdipuWXeUXN7jxtCF9qQMAAdk61NSbuhmR7XyJ9W6VdtoOVG
	 ZLAeOXFopDtlg==
Date: Tue, 11 Feb 2025 15:04:18 -0600
From: Rob Herring <robh@kernel.org>
To: Andras Szemzo <szemzo.andras@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
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
Subject: Re: [PATCH v2 07/10] dt-bindings: phy: allwinner: add v853 usb phy
Message-ID: <20250211210418.GA1172102-robh@kernel.org>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
 <20250205125225.1152849-8-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205125225.1152849-8-szemzo.andras@gmail.com>

On Wed, Feb 05, 2025 at 01:52:22PM +0100, Andras Szemzo wrote:
> Document Allwinner v853 USB phy.
> 
> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
> ---
>  .../devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml   | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
> index 21209126ed00..815742c4f5fb 100644
> --- a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
> @@ -19,9 +19,11 @@ properties:
>        - enum:
>            - allwinner,sun20i-d1-usb-phy
>            - allwinner,sun50i-a64-usb-phy
> +          - allwinner,sun8i-v853-usb-phy
>        - items:
>            - const: allwinner,sun50i-a100-usb-phy
>            - const: allwinner,sun20i-d1-usb-phy
> +          - const: allwinner,sun8i-v853-usb-phy

You just changed existing users. 

>  
>    reg:
>      items:
> -- 
> 2.39.5
> 

