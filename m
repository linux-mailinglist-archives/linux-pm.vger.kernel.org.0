Return-Path: <linux-pm+bounces-30553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E6AFFE79
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA63D3A9ABE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5352D3EFB;
	Thu, 10 Jul 2025 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XogLWYsY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A84A11;
	Thu, 10 Jul 2025 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141097; cv=none; b=XXpSLPh1+pmW+tqawEI+ENBc2HoQnxqPavpH4SUL4sSisULtQs5LY6ZRDuqFZltLdFX+N4+Mx0kJRC/SOv7XFzm/9qp97iUmatXiHyrw872F7fX+PTwZD7UnDcKLM00bRIAQERHol7+rlyFCWDb4INe8YWmecliuMRkhuoyM/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141097; c=relaxed/simple;
	bh=ysqkpnLH5eHCh7kN2peKuvz2QENB7fUs4hX/rZeXMI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfJZ/LxjAeiRMuhFVfeJXn5W5ssPG1drlBg5R2VwzCeizlOAYooM1WayTTz07pO797QLjMrNveEfZzEeBI+D57cZwpDyY3fF6pEaUGHqyadSnaczubHxfqlNZ4pOrpCAYQLakomJNxYvy5iJabtXUaVzT4kkTC12II0AkahPly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XogLWYsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34C5C4CEF1;
	Thu, 10 Jul 2025 09:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752141097;
	bh=ysqkpnLH5eHCh7kN2peKuvz2QENB7fUs4hX/rZeXMI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XogLWYsYrW52faB+LJo50ovT6WWOmctuyU0wl1eXn/u+z1IqrNMwRzsKuH2PYos6G
	 gXMZJtf7yDibAbCPDdv5QcSM9ljX9W2mQiVgF1roWgdVohRfZZQp+EhBTOfOCVwyzp
	 hebYtTxfSpS4mDbSuc/uJEG6EV3xIIH1Mu67BmLjolOH/3C50FIx+KJJkhemu8fTMB
	 6nQQgOaHyM7Q0WrSKu9ofqNT3t2Ai9CsqvY07ysiHUNtwB4t6widDA8B3zQ9suwGrP
	 bbCxQYy5TRtAwc26pFTZKiIoUO24IOVZiIyYG+ZWqyZmkZFpVM2mKxGDGIBlS09dWS
	 +2jVfMv+JJiKg==
Date: Thu, 10 Jul 2025 11:51:34 +0200
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
Subject: Re: [PATCH v9 02/13] dt-bindings: net: mediatek,net: allow up to 8
 IRQs
Message-ID: <20250710-tasteful-crystal-partridge-770464@krzk-bin>
References: <20250709111147.11843-1-linux@fw-web.de>
 <20250709111147.11843-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709111147.11843-3-linux@fw-web.de>

On Wed, Jul 09, 2025 at 01:09:38PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Increase the maximum IRQ count to 8 (4 FE + 4 RSS/LRO).
> 
> Frame-engine-IRQs (max 4):
> MT7621, MT7628: 1 FE-IRQ
> MT7622, MT7623: 3 FE-IRQs (only two used by the driver for now)
> MT7981, MT7986, MT7988: 4 FE-IRQs (only two used by the driver for now)
> 
> Mediatek Filogic SoCs (mt798x) have 4 additional IRQs for RSS and/or
> LRO. So MT798x have 8 IRQs in total.
> 
> MT7981 does not have a ethernet-node yet.
> MT7986 Ethernet node is updated with RSS/LRO IRQs in this series.
> MT7988 Ethernet node is added in this series.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


