Return-Path: <linux-pm+bounces-16529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FAD9B20BC
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 22:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5767B20E9C
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 21:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E64186284;
	Sun, 27 Oct 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtTDTfaD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F25684;
	Sun, 27 Oct 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730063551; cv=none; b=drqPZ8E0gPQbhSdAuuBd56CULnO1gkXxHBNv/W2X7iPzffvq6Vcy9NIDDYsHKk+i6t6pqzr19uWSGYBMvEX2PKs2RK1SBzhqE5Sa54+uIxKfM4CfBxeZ6z2C+lbIc0OzV8gZ3eqh4GQatUTu7XGtVqkkwxB8JOx+/eQngFhzdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730063551; c=relaxed/simple;
	bh=uar3ycx7EeVIytO9GydYomj6oWgdHWiXSLPywFoGwjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ladbn0L12tLnPj+hG5TJVzOBFNq7MBZJ5BA344ozlERfeHQJ7LsNWUylbm7JFcQoMOjE9MBu1slDecgjLFtSLy9dSQRcm3sUytvHs08QNMOeuhSS5rv/cGaV8dudk4KD++SR2Pwuut7ehOlASGdTD/Ea9mZ+03oS051wk3+fxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtTDTfaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48295C4CEC3;
	Sun, 27 Oct 2024 21:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730063550;
	bh=uar3ycx7EeVIytO9GydYomj6oWgdHWiXSLPywFoGwjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtTDTfaDp+Zl8zoQbHTadKyITDcn5Ytr2y5R2jG6MBWu02ckpwWMg4YK945vmrjRN
	 Uz4UKcboBHsLUosvB5XIjJrIR2qdYKNCM+WWcaqnW1YNuQvKAY2X/HHserRTaq+PHR
	 QCVXFIPufguNxNR8DLABEfOI4UvrSGBcC/PumrIMlIUfl0DfjlRBReSXoFj69x4m9C
	 EnDmaTxPgJZsw1J7+gt1CR9lCMHzQEKCXorpDLot9VdzY1jf1P8x1R799PXen3+76I
	 SDuMAo6I7+ptd66g8H+AO/vCHqMvuQ/lipqQeNa5NxFeVtDK0SXXwMaM6jBT+ljV9V
	 Ghq1jQGh6Ej9Q==
Date: Sun, 27 Oct 2024 16:12:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-sunxi@lists.linux.dev, Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
	Yangtao Li <frank@allwinnertech.com>, linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Parthiban <parthiban@linumiz.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, linux-usb@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <treding@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 04/13] dt-bindings: usb: Add A100 compatible string
Message-ID: <173006354857.88418.13246529686874362124.robh@kernel.org>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-5-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024170540.2721307-5-masterr3c0rd@epochal.quest>


On Thu, 24 Oct 2024 14:05:22 -0300, Cody Eksal wrote:
> The Allwinner A100 contains two fully OHCI/EHCI compatible USB host
> controllers. Add their compatible strings to the list of
> generic OHCI/EHCI controllers.
> 
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
>  Documentation/devicetree/bindings/usb/generic-ohci.yaml | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


