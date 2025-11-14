Return-Path: <linux-pm+bounces-38053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98528C5E465
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 17:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B537B542B3F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485DC329C51;
	Fri, 14 Nov 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw5RjQZ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E30283CB0;
	Fri, 14 Nov 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137346; cv=none; b=dfixyqe1qrwYsGD+EvuS2IQsTrxktwo+IiwDuQBE+F8fZ+YXgoMU4BN4x/3bmJFNbTetW8qz4myysSl+UYr+FULBE8pikvzZOXQDOYimT+bNz1wVOHrUFZWJLdsGafiys93rbiCDYCG7cfcDRChOfUSfee1fOb3r11gTbFvyt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137346; c=relaxed/simple;
	bh=Dh7B81R0CZthI9c9EIIN3+DY5FYoCN3eZa7ifInLPXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrHWKL8C1nZsxAozkGkL15+UucpCLXtFNeiDH7e68Fy93Ht5qjGBErLPcOplv0FWwVfa1fJtLUaNN0e3v9M5ojKcZNDFdwlZldMIG+6+JbjsdL9wznO5DtrVLHNRM1g5CZz5OhucCVddBonp7hHQLfaYNCg4ZiZcj9SS01x9v5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw5RjQZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18243C4CEF8;
	Fri, 14 Nov 2025 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763137345;
	bh=Dh7B81R0CZthI9c9EIIN3+DY5FYoCN3eZa7ifInLPXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dw5RjQZ441yQWfZo1zaW2y9Ff7Fbpc4MDmSCaR5XnvyHjtaVi9mEBa+/XNq3plSpm
	 YctoaAEnlbxvUdqtU7s8kCDYhSxFeYF2ZX5wBC2jF+EmfC49v0vHh2oTCZQ5MNMzrQ
	 hQM0e281PSZMWJwOsStkKVZoCNymSiPckpWGSfd3FC0Ft5l1hgPFpWDc44f7gcUcO9
	 uc+AiGLcYXXiZzfZoCn9tPavc+RB41G0eQvkNj+1bI3CDuSkLuBozOVIdRsbbhXm4U
	 BAUeDOOaC6nJUXJ1bXKQZVXPxZhPRS0Tj+H3+vPrTUUkFWMcswhCU7g1Bm9vUoyMMW
	 koBIXdaOMy9bw==
Date: Fri, 14 Nov 2025 10:22:23 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	linux-rtc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Pavel Machek <pavel@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, linux-gpio@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 01/16] dt-bindings: regulator: ROHM BD72720
Message-ID: <176313734261.3399634.14735602290463429362.robh@kernel.org>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
 <21e83fccf2d2422f4bea1c482dcd3cb1aeda4085.1763022807.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e83fccf2d2422f4bea1c482dcd3cb1aeda4085.1763022807.git.mazziesaccount@gmail.com>


On Thu, 13 Nov 2025 10:51:32 +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The ROHM BD72720 is a new PMIC with 10 BUCk and 11 LDO regulators.
> 
> The BD72720 is designed to support using the BUCK10 as a supply for
> the LDOs 1 to 4. When the BUCK10 is used for this, it can be set to a
> LDON_HEAD mode. In this mode, the BUCK10 voltage can't be controlled by
> software, but the voltage is adjusted by PMIC to match the LDO1 .. LDO4
> voltages with a given offset. Offset can be 50mV .. 300mV and is
> changeable at 50mV steps.
> 
> Add 'ldon-head-microvolt' property to denote a board which is designed
> to utilize the LDON_HEAD mode.
> 
> All other properties are already existing.
> 
> Add dt-binding doc for ROHM BD72720 regulators to make it usable.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
>  v3 => v4:
>  - Drop type from ldon-head
>  - Fix the name patterns for regulator nodes and names
> 
>  v2 => v3:
>  - drop unnecessary descriptions
>  - use microvolts for the 'ldon-head' dt-property
> 
>  RFCv1 => v2:
>  - No changes
> ---
>  .../regulator/rohm,bd72720-regulator.yaml     | 148 ++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


