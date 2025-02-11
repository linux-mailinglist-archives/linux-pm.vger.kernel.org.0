Return-Path: <linux-pm+bounces-21889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66669A3171C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C26C7A3C1E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD861264623;
	Tue, 11 Feb 2025 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXFA0YVr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848802641E8;
	Tue, 11 Feb 2025 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307776; cv=none; b=fCb2T2Uh7nFtG+j+1p+TSLTBlF6YjZRiSgtCHEhnix8a18zfZK8qiJNvmV1udoD0TW1QKLSQO3rxIY7jEka6e/nnAZ/xuHSVWlxzheEdEyOUGLYU+ZLjzH3nf3kpOKcsbhS309vWsFROwRcfWZdfFM8Rxtas39CFIgosp4LNMY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307776; c=relaxed/simple;
	bh=mPDIGAOPfFORI7LS1qh2u5u7JxUaNOD3vSVK0HFG47E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GH3kIVVArVRcY6T0ZjTZH8ZeQfEXZ/mzUXZcgRSKYU3pw9NQ7uYQqKdyuCPZHkt/291/AuGuj1mszI44/csV+Cehiup5V7q9NgrJ0q48fv/YcxHWKPDZ833DQ/ghLkXiAWvaPqFdzIPQOi0IVlbueMQmHKjjEJvGXobFPuwll08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXFA0YVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260A5C4CEDD;
	Tue, 11 Feb 2025 21:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739307776;
	bh=mPDIGAOPfFORI7LS1qh2u5u7JxUaNOD3vSVK0HFG47E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXFA0YVrKBjSTeI63HmZL4q9NOLOskpQ7vqBrMooWe36Cuqzu/Fe+33bDLUiC0BPb
	 qRXHUIYzAKySmdpEp5p3VRGbv8rVJxclJX/lJy3H62dMSLu/jlYLyTnXYPlmlFeH0K
	 A+c6wJAWZfp/vyBSdxOLe47iUdwd38VA6RYMiGUP3M07qJt6oRx0nTTPdTM5AnbJ+7
	 NjteYhk+aYmcokeq2hOdPfyjux6obELcimRdEmdMbtDclA/kIyiBMt5VnMh126I822
	 dgS/KwesBkGVd+nNWIGcBNLIzn10nzeiUk0i/vlx7Gs3f0GXYZuBuXtQ3ZkpAHnBYq
	 9KQOD3olOP/hA==
Date: Tue, 11 Feb 2025 15:02:55 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andras Szemzo <szemzo.andras@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <mripard@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel@sholland.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-clk@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-sunxi@lists.linux.dev, Albert Ou <aou@eecs.berkeley.edu>,
	devicetree@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] dt-bindings: power: add V853 ppu bindings
Message-ID: <173930777478.1171902.17591605192329357737.robh@kernel.org>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
 <20250205125225.1152849-6-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205125225.1152849-6-szemzo.andras@gmail.com>


On Wed, 05 Feb 2025 13:52:20 +0100, Andras Szemzo wrote:
> Document V853 PPU compatible.
> 
> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
> ---
>  .../bindings/power/allwinner,sun20i-d1-ppu.yaml        |  1 +
>  include/dt-bindings/power/allwinner,sun8i-v853-ppu.h   | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>  create mode 100644 include/dt-bindings/power/allwinner,sun8i-v853-ppu.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


