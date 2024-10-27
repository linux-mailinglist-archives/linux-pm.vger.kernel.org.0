Return-Path: <linux-pm+bounces-16528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83EF9B20B7
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 22:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FDC1C20BF4
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 21:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019B217DFF1;
	Sun, 27 Oct 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roFr7gAu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DDE1DFE8;
	Sun, 27 Oct 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730063486; cv=none; b=t1lHWtGer1DgD4kqsJHuLJHKn+uwbKMknAuZ7uLxeVuiE5bcGS+YhzrwmZph5jSSUJHqlEjHwuORtt8PMx513VzZhdlrKJFH53X+JES6dxUkwArBgcbHt4jGHvXQ/iEJjwe2AbI+MY6GIXgI4LVKsiiOoptisF/Tbu1A9EB3BLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730063486; c=relaxed/simple;
	bh=qxdDf/jwCLwtMg/BFx08kpItrd6GwiKsheCB5mZ8L5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGX8QLjCVoGuV68xI+N4i2xxsdtSWQ//DzVj3GRvSVWuNV9kaYvJtSKANBufElMu4OkuT0cWghxR5OigfhKOfW6V4Hq7gGMMuOmVc6zRJEgycTusyAaV7mqO095KoCUIHeFnoTh/U/KcfUYdlYpw9kSdS+3mlNRERIK5WxzTF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roFr7gAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D27C4CEC3;
	Sun, 27 Oct 2024 21:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730063486;
	bh=qxdDf/jwCLwtMg/BFx08kpItrd6GwiKsheCB5mZ8L5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roFr7gAuUh9x1bpL1a0X8t4pPfIME4ciTyiS0Xlu+4gWLAEBQ+uQL0SehfyR/hlc3
	 wt5kyLKGovdfDXWrMtpmn4LPYhctXKnxbGbSkcppX3uiveof5OYnKSWQ1D2xYM1myr
	 uUdHKipcFFu2jiHLHXcw/nK/Xgqy6JqzlhoqoAJ8yea3k923xOnYX7+KYpkWCIRT5p
	 Xq85rQpq71LfaYvdEiIF93WtNBxtPUym+NgeS/EM6MKs99yapMKkMQcumgMTba2oZc
	 PVx6EDRO2HXb2Y0Qa2lz20vNo3Ig/eR7jkBwRiKtOIdvFCegFlu+EjtHYKdntM69ob
	 h0SNp3L2sf16Q==
Date: Sun, 27 Oct 2024 16:11:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>, Nishanth Menon <nm@ti.com>,
	Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Yangtao Li <frank@allwinnertech.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev, Yangtao Li <tiny.windzz@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Parthiban <parthiban@linumiz.com>
Subject: Re: [PATCH 03/13] dt-bindings: phy: sun50i-a64: add a100 compatible
Message-ID: <173006348387.87150.15151805812797724971.robh@kernel.org>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-4-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024170540.2721307-4-masterr3c0rd@epochal.quest>


On Thu, 24 Oct 2024 14:05:21 -0300, Cody Eksal wrote:
> The USB PHY found in the A100 is similar to that found in the A64,
> although it requires some quirks to be enabled. Add a compatible for the
> A100's variant.
> 
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
>  .../devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml    | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


