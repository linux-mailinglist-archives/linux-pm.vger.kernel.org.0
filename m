Return-Path: <linux-pm+bounces-16525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196709B2088
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 21:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A1D2814B9
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 20:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944BE181B8F;
	Sun, 27 Oct 2024 20:47:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2A291E;
	Sun, 27 Oct 2024 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062025; cv=none; b=fy9EVAiOJ+1PGlruq32c7AZDvJOm2uOXWYAFTmr/5XjMakcYms/3RPlXZC37ui70URScUHY2ReOce9RC3QHq9rWYOh97l6f1/br/B1bsN3xf4vrjkS5R2MN8QF7e9w3QThPdPmDXF0uX/MAutQQ9JV2If2IOADRtchAYrA9xioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062025; c=relaxed/simple;
	bh=QHTw0IyCWbSMaP9tLcAz5dOu1X5LhXFaMZvD7we8AeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZavxqAZT5ekYeWxCq0GoHdVa8sNfybDtUtu+rU/TxpHQMirE5oyce7xfwLAN3LVGFslDCKSXE8FdskSaGmjFweNZl0TGaOpZQRc+8cSzWLu2H0BB7q9lKhwjJdAWtiKEOv5JGNPb3vmLzCtwtUmrF5WrlYhmCsVeEXLCWPk4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C81C4CEC3;
	Sun, 27 Oct 2024 20:47:04 +0000 (UTC)
Date: Sun, 27 Oct 2024 21:47:02 +0100
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	Parthiban <parthiban@linumiz.com>, Yangtao Li <frank@allwinnertech.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Vinod Koul <vkoul@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 05/13] dt-bindings: usb: sunxi-musb: Add A100 compatible
 string
Message-ID: <cdfocja5u4jh6xh2jkouzyztsjinggep45ymbdwxc4zpscy376@i5voj36oqrrf>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-6-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024170540.2721307-6-masterr3c0rd@epochal.quest>

On Thu, Oct 24, 2024 at 02:05:23PM -0300, Cody Eksal wrote:
> The A100 MUSB peripheral has 10 endpoints, and thus is compatible with
> the A33 version.
> 
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
>  .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
> index f972ce976e86..d4993336a29b 100644
> --- a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
> +++ b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
> @@ -24,6 +24,7 @@ properties:
>                - allwinner,sun8i-a83t-musb
>                - allwinner,sun20i-d1-musb
>                - allwinner,sun50i-h6-musb
> +              - allwinner,sun50i-a100-musb

List looked ordered, now doesn't.... are you sure you keep intented
ordering here?

Best regards,
Krzysztof


