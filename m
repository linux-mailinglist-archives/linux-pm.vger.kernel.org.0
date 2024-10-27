Return-Path: <linux-pm+bounces-16526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC5C9B208C
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 21:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6C71C20B0B
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 20:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAFC184523;
	Sun, 27 Oct 2024 20:47:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC7291E;
	Sun, 27 Oct 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062064; cv=none; b=QngNxgfSawvmuQkRs2FALzq2zHJHZESa3wC/Z23AYNW0VlvavvO+kHbv7v/u5lCyt2d5kME+DsKHzRD4XoT5jgWyR4VYJ8e1MiiOha2jhLz2IGICp/Pn4qiMY6Hswu01Zlb8gF+zqJIgg8/2QwI5qDIXWeVI1hOuWON0hbFW7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062064; c=relaxed/simple;
	bh=I3NWrlfErvRrt2F/00Eo3m3dBULSZazp0Iyhj4t2nW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGf3Dv7oE8Jx3t2kiTZFeseq6c6U3rYfefFvnpR3F7qKNO94bJ9wh4l4wzkOGdBNStdnS95n8eywOB1FlbjbJMKNth1umJtJdssA0Fgyged/J2XaDYEkY1GChOOP+VQw7Z2VNuyia/oNbesIolV2aU6Rt5CA2A4atHnwsR6WJJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85284C4CEE4;
	Sun, 27 Oct 2024 20:47:43 +0000 (UTC)
Date: Sun, 27 Oct 2024 21:47:41 +0100
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	Parthiban <parthiban@linumiz.com>, Yangtao Li <frank@allwinnertech.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Vinod Koul <vkoul@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 11/13] dt-bindings: opp: h6: Add A100 operating points
Message-ID: <7dybkf3zveidwapwfivvq3jk6qxntuqgycndff3ajjl2owhjhn@khqgycnzh76j>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-12-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024170540.2721307-12-masterr3c0rd@epochal.quest>

On Thu, Oct 24, 2024 at 02:05:29PM -0300, Cody Eksal wrote:
> The A100, similar to the H6 and H616, use an NVMEM value to determine
> speed binnings. The method used is similar to that of the H6. However,
> the information is stored at a slightly different bit offset.
> 
> Add a new compatible for the A100.
> 
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
>  .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> index ec5e424bb3c8..603c6c88d080 100644
> --- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> +++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> @@ -23,6 +23,7 @@ properties:
>    compatible:
>      enum:
>        - allwinner,sun50i-h6-operating-points
> +      - allwinner,sun50i-a100-operating-points
>        - allwinner,sun50i-h616-operating-points

I have no clue why a100 is between h6 and h616. :/

Best regards,
Krzysztof


