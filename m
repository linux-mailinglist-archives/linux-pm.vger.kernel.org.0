Return-Path: <linux-pm+bounces-30554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C529EAFFE7C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EB81C8188F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925B2D46B0;
	Thu, 10 Jul 2025 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIDgM0RR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C22D46A0;
	Thu, 10 Jul 2025 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141133; cv=none; b=qu7N3SOA4qWcAmkjYrBbczbuMfq2ofkfr5+qw2hw3cnU0uAzkbNs+ts+SAimXCryMt337dmegWlZpY6xcpTRJGKtCtYX7EJIAGW/nRPsbR9FMPhSSEf4CEV8cJYwydaiDdDjI2I56gLyYDY9usjU4LTR6m+vn75lCcbNZMUgT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141133; c=relaxed/simple;
	bh=pZGaq0Wu1dT/dxRh+MB2XlLidtH1F8cMudtE386pfjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiMWunN2gpWaMEyqKHi67FEPcvXpth8oXXB+JNLKLA+8Mnpk7mMxQNQZpLe3g4oOrIzl/uNOAYtlW9ouTCW8/ysI+3FVAR7kwSMtDxkNUUtw+xMtm/d8QHEnp9EsWKH3m2XPBO3MwaxOfu34jT0hOfbhPGLo336Nx0RT0TOuSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIDgM0RR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5D7C4CEE3;
	Thu, 10 Jul 2025 09:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752141132;
	bh=pZGaq0Wu1dT/dxRh+MB2XlLidtH1F8cMudtE386pfjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIDgM0RRhADkfkCfjrESf7N9LWIsVsPWJutieH2NNF9Z1EW8Q4D3kAeZGMJyu55+5
	 zwPw6eAQHXbJOpcZH7O02IYZ4joxKi0sMWSFyLygR9IdsbUtY6X25oPvtP3XiCpC04
	 4gCXlq4UsCF2j6U19+893abdzEUw9I76OLTy4OZrr4Nr3Lz5N+0gE4j9BZD0saSUQQ
	 Dxg9ZTSMk0b8q+Gn6oKnSrrfxG0dR9SK4NDvHJzW1Kly6RXeERNvBAsyGaWPCicZvo
	 DbnPbuKRn3HVOA3d10mSYUWWlcCzmzXQ8BdYk8R+cnGvpymuS7BoES+e0YXYJFJWxh
	 R9idoDyVAjeXA==
Date: Thu, 10 Jul 2025 11:52:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Johnson Wang <johnson.wang@mediatek.com>, 
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Felix Fietkau <nbd@nbd.name>, Frank Wunderlich <frank-w@public-files.de>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 03/13] dt-bindings: net: mediatek,net: allow irq names
Message-ID: <20250710-dashing-wine-hippo-d879c9@krzk-bin>
References: <20250709111147.11843-1-linux@fw-web.de>
 <20250709111147.11843-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709111147.11843-4-linux@fw-web.de>

On Wed, Jul 09, 2025 at 01:09:39PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> In preparation for MT7988 and RSS/LRO allow the interrupt-names
> property.
> In this way driver can request the interrupts by name which is much
> more readable in the driver code and SoC's dtsi than relying on a
> specific order.
> 
> Frame-engine-IRQs (fe0..3):
> MT7621, MT7628: 1 FE-IRQ
> MT7622, MT7623: 3 FE-IRQs (only two used by the driver for now)
> MT7981, MT7986: 4 FE-IRQs (only two used by the driver for now)
> 
> RSS/LRO IRQs (pdma0..3) additional only on Filogic (MT798x) with
> count of 4. So all IRQ-names (8) for Filogic.
> 
> Set boundaries for all compatibles same as irq count.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


