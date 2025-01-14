Return-Path: <linux-pm+bounces-20438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D599A1117F
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 20:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678D81881FDC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 19:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5321D208994;
	Tue, 14 Jan 2025 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkcU8Cfp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E91FECC6;
	Tue, 14 Jan 2025 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884376; cv=none; b=nIA2QefL8za22E46Y6LWQq9Mjq/DQP6sbuTwTXcA3hbvYyEm2So/iKq3AWtZck4tP0TOdNJq6VWjvMsp92CBLTwlmQ21OJGHi5UOczSw759CzclCQIad8FrHmkwh1fyY0Sy1bgyxqRU62l2JfSPigKi/OJ490fjtF2PIBsYx0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884376; c=relaxed/simple;
	bh=tFzCEIztKEZ3kBKK0bFyC/nzjd+01xcbW/7eoFlG6DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjjHUdj7XihZDuRXGWsUByoZ8Mi/sTEsM/iwuZzC+GvG7zy/o7oOzW2zgrduCCH9ismNrU1/awqVG/G0lotWXMY4DBIBPjDABIE2L3vNXw51xssMARoyd4vmWaqw1wHUbChHSd0MBngKUXlvfxabE//MvDbGgZYnGEw8UsjE1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkcU8Cfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D23C4CEDD;
	Tue, 14 Jan 2025 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736884375;
	bh=tFzCEIztKEZ3kBKK0bFyC/nzjd+01xcbW/7eoFlG6DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkcU8CfpStzYxO1CHv2BL2eUQ9p0pg4vOUNoINSSBu9JtBLB8yu6XNT9Yndv2NYbX
	 HkfswsOjGivQ3792WWlUN9ARVj21u91EVGmVaWk33zl6CJEUOqlblpKKfLotxmAFn0
	 lD9TDtp8H39JrkR2RU/IJoXwzCshjPCxb0WFazxL3ogASL88nKodW4/n44mHgbOagk
	 wlFcwm72u8Y02A9zJONQoBA3J8HJC6Nf47Rj/6uRRcUnGXqNU+CXB0I34gdbijS4fN
	 Z5FtFaLfxG6yyPaZYueo4KWAzWC2WVMZV6dILP5avypfnpCK9M/bGlOyCNaGr/SMbN
	 vOlo2ZPIp7z8Q==
Date: Tue, 14 Jan 2025 13:52:54 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andras Szemzo <szemzo.andras@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-sunxi@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-phy@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
	linux-pm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
	Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 02/12] dt-bindings: pinctrl: sunxi: add compatible for
 V853
Message-ID: <173688437416.1619259.7363940656037127304.robh@kernel.org>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-3-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110123923.270626-3-szemzo.andras@gmail.com>


On Fri, 10 Jan 2025 13:39:13 +0100, Andras Szemzo wrote:
> Add compatible strings for V853 family pinctrl.
> 
> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
> ---
>  .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml        | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


